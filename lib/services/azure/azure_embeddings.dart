import 'dart:convert';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import '../../models/vector_store_model.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';

/// Azure OpenAI Embeddings Service for the Vector Store Layer
class AzureEmbeddingsService {
  static const String _endpoint = 'https://YOUR_OPENAI_RESOURCE.openai.azure.com/';
  static const String _apiKey = 'YOUR_AZURE_OPENAI_API_KEY';
  static const String _apiVersion = '2023-12-01-preview';
  static const String _embeddingsDeployment = 'text-embedding-ada-002';
  
  // Configuration
  static const int _maxTokensPerChunk = 8000;
  static const int _chunkOverlap = 200;
  static const int _embeddingDimensions = 1536;
  static const int _maxRetries = 3;
  
  final Dio _dio;
  final RetryOptions _retryOptions;
  
  AzureEmbeddingsService({Dio? dio}) 
      : _dio = dio ?? Dio(),
        _retryOptions = const RetryOptions(
          maxAttempts: _maxRetries,
          delay: Duration(seconds: 1),
          delayFactor: Duration(seconds: 2),
        );
  
  /// Initialize the embeddings service
  Future<void> initialize() async {
    _dio.options.baseUrl = _endpoint;
    _dio.options.headers['api-key'] = _apiKey;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 60);
  }
  
  /// Generate embeddings for a single text
  Future<DocumentEmbedding> generateEmbedding({
    required String text,
    required String documentId,
    String? title,
    String? summary,
    DocumentType documentType = DocumentType.userContent,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final embeddings = await _retryOptions.retry(() async {
        final response = await _dio.post(
          'openai/deployments/$_embeddingsDeployment/embeddings',
          queryParameters: {'api-version': _apiVersion},
          data: {
            'input': text,
            'model': _embeddingsDeployment,
          },
        );
        
        if (response.statusCode != 200) {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: 'Failed to generate embedding: ${response.statusCode}',
          );
        }
        
        return response.data['data'][0]['embedding'] as List<dynamic>;
      });
      
      final embeddingVector = embeddings.cast<double>();
      final magnitude = VectorOperations.magnitude(embeddingVector);
      
      return DocumentEmbedding(
        id: '${documentId}_embedding_${DateTime.now().millisecondsSinceEpoch}',
        documentId: documentId,
        embedding: embeddingVector,
        dimensions: _embeddingDimensions,
        model: _embeddingsDeployment,
        documentType: documentType.name,
        title: title,
        summary: summary,
        metadata: metadata,
        magnitude: magnitude,
        confidence: _calculateEmbeddingConfidence(embeddingVector),
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw EmbeddingException('Failed to generate embedding for document $documentId: $e');
    }
  }
  
  /// Generate embeddings for multiple texts in batch
  Future<List<DocumentEmbedding>> generateBatchEmbeddings({
    required List<String> texts,
    required List<String> documentIds,
    List<String>? titles,
    List<String>? summaries,
    DocumentType documentType = DocumentType.userContent,
    Map<String, dynamic>? metadata,
  }) async {
    if (texts.length != documentIds.length) {
      throw ArgumentError('Texts and document IDs must have the same length');
    }
    
    try {
      final embeddings = await _retryOptions.retry(() async {
        final response = await _dio.post(
          'openai/deployments/$_embeddingsDeployment/embeddings',
          queryParameters: {'api-version': _apiVersion},
          data: {
            'input': texts,
            'model': _embeddingsDeployment,
          },
        );
        
        if (response.statusCode != 200) {
          throw DioException(
            requestOptions: response.requestOptions,
            response: response,
            message: 'Failed to generate batch embeddings: ${response.statusCode}',
          );
        }
        
        return response.data['data'] as List<dynamic>;
      });
      
      final results = <DocumentEmbedding>[];
      for (int i = 0; i < embeddings.length; i++) {
        final embeddingVector = (embeddings[i]['embedding'] as List<dynamic>).cast<double>();
        final magnitude = VectorOperations.magnitude(embeddingVector);
        
        results.add(DocumentEmbedding(
          id: '${documentIds[i]}_embedding_${DateTime.now().millisecondsSinceEpoch}',
          documentId: documentIds[i],
          embedding: embeddingVector,
          dimensions: _embeddingDimensions,
          model: _embeddingsDeployment,
          documentType: documentType.name,
          title: titles?[i],
          summary: summaries?[i],
          metadata: metadata,
          magnitude: magnitude,
          confidence: _calculateEmbeddingConfidence(embeddingVector),
          createdAt: DateTime.now(),
        ));
      }
      
      return results;
    } catch (e) {
      throw EmbeddingException('Failed to generate batch embeddings: $e');
    }
  }
  
  /// Process a document and create vector document with embeddings
  Future<VectorDocument> processDocument({
    required String content,
    required String id,
    required DocumentType type,
    required String source,
    required NeedCategory category,
    String? title,
    String? summary,
    List<String>? keywords,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // Clean and preprocess content
      final cleanContent = _preprocessText(content);
      
      // Generate chunks if content is too long
      final chunks = _chunkText(cleanContent);
      
      // Generate embedding for the main content
      final mainEmbedding = await generateEmbedding(
        text: cleanContent,
        documentId: id,
        title: title,
        summary: summary,
        documentType: type,
        metadata: metadata,
      );
      
      // Extract keywords if not provided
      final extractedKeywords = keywords ?? await _extractKeywords(cleanContent);
      
      // Generate summary if not provided
      final generatedSummary = summary ?? await _generateSummary(cleanContent);
      
      return VectorDocument(
        id: id,
        content: cleanContent,
        type: type,
        source: source,
        title: title,
        summary: generatedSummary,
        chunks: chunks,
        category: category,
        keywords: extractedKeywords,
        status: ProcessingStatus.completed,
        embedding: mainEmbedding,
        qualityScore: _calculateContentQuality(cleanContent),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (e) {
      throw EmbeddingException('Failed to process document $id: $e');
    }
  }
  
  /// Process a Need model into a VectorDocument
  Future<VectorDocument> processNeedDocument(Need need) async {
    final content = _buildNeedContent(need);
    
    return processDocument(
      content: content,
      id: need.id,
      type: DocumentType.need,
      source: 'yolo_app_needs',
      category: need.category,
      title: need.title,
      summary: need.description,
      keywords: need.tags,
      metadata: {
        'urgency': need.urgency.name,
        'status': need.status.name,
        'user_id': need.userId,
        'location': need.location,
        'created_at': need.createdAt?.toIso8601String(),
      },
    );
  }
  
  /// Process user content into vector documents
  Future<List<VectorDocument>> processUserContent(User user) async {
    final documents = <VectorDocument>[];
    
    // Process user profile as a document
    final profileContent = _buildUserProfileContent(user);
    final profileDoc = await processDocument(
      content: profileContent,
      id: '${user.id}_profile',
      type: DocumentType.userContent,
      source: 'yolo_app_users',
      category: NeedCategory.general,
      title: '${user.name} Profile',
      summary: user.bio ?? 'User profile information',
      metadata: {
        'user_id': user.id,
        'role': user.role.name,
        'level': user.level,
        'points': user.points,
      },
    );
    
    documents.add(profileDoc);
    
    return documents;
  }
  
  /// Chunk text into smaller pieces for processing
  List<String> _chunkText(String text) {
    final words = text.split(' ');
    final chunks = <String>[];
    
    if (words.length <= _maxTokensPerChunk) {
      return [text];
    }
    
    int currentIndex = 0;
    while (currentIndex < words.length) {
      final endIndex = math.min(currentIndex + _maxTokensPerChunk, words.length);
      final chunk = words.sublist(currentIndex, endIndex).join(' ');
      chunks.add(chunk);
      
      // Add overlap for context continuity
      currentIndex = math.max(currentIndex + _maxTokensPerChunk - _chunkOverlap, endIndex);
    }
    
    return chunks;
  }
  
  /// Preprocess text for embeddings
  String _preprocessText(String text) {
    // Remove excessive whitespace
    String cleaned = text.replaceAll(RegExp(r'\s+'), ' ');
    
    // Remove special characters that don't add semantic value
    cleaned = cleaned.replaceAll(RegExp(r'[^\w\s\.\,\!\?\;\:\-\(\)]'), ' ');
    
    // Normalize spacing
    cleaned = cleaned.trim();
    
    return cleaned;
  }
  
  /// Calculate embedding confidence based on vector properties
  double _calculateEmbeddingConfidence(List<double> embedding) {
    // Calculate confidence based on vector magnitude and distribution
    final magnitude = VectorOperations.magnitude(embedding);
    final mean = embedding.reduce((a, b) => a + b) / embedding.length;
    final variance = embedding.map((x) => math.pow(x - mean, 2)).reduce((a, b) => a + b) / embedding.length;
    
    // Confidence increases with magnitude and decreases with high variance
    final magnitudeScore = math.min(magnitude / 10.0, 1.0);
    final varianceScore = math.max(0.0, 1.0 - variance * 10);
    
    return (magnitudeScore + varianceScore) / 2.0;
  }
  
  /// Calculate content quality score
  double _calculateContentQuality(String content) {
    final words = content.split(' ');
    final sentences = content.split(RegExp(r'[.!?]+'));
    
    // Base score on length, vocabulary diversity, and structure
    final lengthScore = math.min(words.length / 100.0, 1.0);
    final diversityScore = words.toSet().length / words.length;
    final structureScore = sentences.length > 1 ? 1.0 : 0.5;
    
    return (lengthScore + diversityScore + structureScore) / 3.0;
  }
  
  /// Extract keywords from text (simplified version)
  Future<List<String>> _extractKeywords(String text) async {
    // This is a simplified keyword extraction
    // In production, you might use more sophisticated NLP techniques
    final words = text.toLowerCase().split(RegExp(r'\W+'));
    final stopWords = {'the', 'a', 'an', 'and', 'or', 'but', 'in', 'on', 'at', 'to', 'for', 'of', 'with', 'by', 'is', 'are', 'was', 'were', 'be', 'been', 'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would', 'could', 'should'};
    
    final filteredWords = words.where((word) => 
      word.length > 3 && !stopWords.contains(word)
    ).toList();
    
    // Count word frequency
    final wordCounts = <String, int>{};
    for (final word in filteredWords) {
      wordCounts[word] = (wordCounts[word] ?? 0) + 1;
    }
    
    // Return top keywords
    final sortedWords = wordCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    return sortedWords.take(10).map((e) => e.key).toList();
  }
  
  /// Generate summary for content (simplified version)
  Future<String> _generateSummary(String content) async {
    // This is a simplified summary generation
    // In production, you might use Azure AI services for summarization
    final sentences = content.split(RegExp(r'[.!?]+'));
    if (sentences.length <= 3) {
      return content;
    }
    
    // Take first and last sentences as a simple summary
    final firstSentence = sentences.first.trim();
    final lastSentence = sentences.last.trim();
    
    if (firstSentence.isNotEmpty && lastSentence.isNotEmpty) {
      return '$firstSentence. $lastSentence';
    }
    
    return sentences.take(2).join('. ');
  }
  
  /// Build content string from Need model
  String _buildNeedContent(Need need) {
    final buffer = StringBuffer();
    
    buffer.writeln('Title: ${need.title}');
    buffer.writeln('Description: ${need.description}');
    buffer.writeln('Category: ${need.category.name}');
    buffer.writeln('Urgency: ${need.urgency.name}');
    
    if (need.location != null) {
      buffer.writeln('Location: ${need.location}');
    }
    
    if (need.tags.isNotEmpty) {
      buffer.writeln('Tags: ${need.tags.join(', ')}');
    }
    
    if (need.requirements != null && need.requirements!.isNotEmpty) {
      buffer.writeln('Requirements: ${need.requirements!.join(', ')}');
    }
    
    return buffer.toString();
  }
  
  /// Build content string from User profile
  String _buildUserProfileContent(User user) {
    final buffer = StringBuffer();
    
    buffer.writeln('Name: ${user.name}');
    buffer.writeln('Role: ${user.role.name}');
    
    if (user.bio != null) {
      buffer.writeln('Bio: ${user.bio}');
    }
    
    if (user.skills.isNotEmpty) {
      buffer.writeln('Skills: ${user.skills.join(', ')}');
    }
    
    if (user.interests.isNotEmpty) {
      buffer.writeln('Interests: ${user.interests.join(', ')}');
    }
    
    buffer.writeln('Level: ${user.level}');
    buffer.writeln('Points: ${user.points}');
    
    return buffer.toString();
  }
}

/// Custom exception for embedding operations
class EmbeddingException implements Exception {
  final String message;
  
  EmbeddingException(this.message);
  
  @override
  String toString() => 'EmbeddingException: $message';
} 