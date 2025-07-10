import 'dart:convert';
import 'dart:math' as math;
import 'package:collection/collection.dart';
import '../../models/vector_store_model.dart';
import '../../models/enums.dart';
import 'azure_embeddings.dart';
import 'azure_cosmos.dart';

/// Vector Database Service for Semantic Search and Retrieval
class AzureVectorDatabaseService {
  final AzureEmbeddingsService _embeddingsService;
  final AzureCosmosService _cosmosService;
  
  // In-memory vector index for fast similarity search
  final Map<String, VectorIndex> _vectorIndices = {};
  final Map<String, List<DocumentEmbedding>> _embeddingCache = {};
  
  // Configuration
  static const int _defaultMaxResults = 20;
  static const double _defaultSimilarityThreshold = 0.7;
  static const String _vectorContainerName = 'vector_embeddings';
  static const String _documentsContainerName = 'vector_documents';
  
  AzureVectorDatabaseService({
    required AzureEmbeddingsService embeddingsService,
    required AzureCosmosService cosmosService,
  }) : _embeddingsService = embeddingsService,
       _cosmosService = cosmosService;
  
  /// Initialize the vector database service
  Future<void> initialize() async {
    await _embeddingsService.initialize();
    await _cosmosService.initialize();
    await _initializeVectorContainers();
    await _loadExistingIndices();
  }
  
  /// Store a vector document with its embedding
  Future<void> storeVectorDocument(VectorDocument document) async {
    try {
      // Store the document in Cosmos DB
      await _cosmosService.createItem(
        containerName: _documentsContainerName,
        item: document.toJson(),
      );
      
      // Store the embedding separately for fast retrieval
      if (document.embedding != null) {
        await _storeEmbedding(document.embedding!);
        
        // Update the in-memory index
        await _updateVectorIndex(document);
      }
      
      print('Stored vector document: ${document.id}');
    } catch (e) {
      throw VectorDatabaseException('Failed to store vector document ${document.id}: $e');
    }
  }
  
  /// Store multiple vector documents in batch
  Future<void> storeBatchVectorDocuments(List<VectorDocument> documents) async {
    try {
      // Store documents in Cosmos DB
      final futures = documents.map((doc) => 
        _cosmosService.createItem(
          containerName: _documentsContainerName,
          item: doc.toJson(),
        )
      );
      
      await Future.wait(futures);
      
      // Store embeddings
      final embeddings = documents
          .where((doc) => doc.embedding != null)
          .map((doc) => doc.embedding!)
          .toList();
      
      if (embeddings.isNotEmpty) {
        await _storeBatchEmbeddings(embeddings);
        
        // Update indices
        for (final document in documents) {
          await _updateVectorIndex(document);
        }
      }
      
      print('Stored ${documents.length} vector documents in batch');
    } catch (e) {
      throw VectorDatabaseException('Failed to store batch documents: $e');
    }
  }
  
  /// Perform semantic search using vector similarity
  Future<SemanticSearchResult> semanticSearch(SemanticQuery query) async {
    try {
      final startTime = DateTime.now();
      
      // Generate embedding for the query
      final queryEmbedding = await _getQueryEmbedding(query);
      
      // Find similar documents
      final results = await _findSimilarDocuments(
        queryEmbedding: queryEmbedding,
        maxResults: query.maxResults,
        similarityThreshold: query.similarityThreshold,
        documentTypes: query.documentTypes,
        categories: query.categories,
        filters: query.filters,
      );
      
      final searchTime = DateTime.now().difference(startTime);
      
      // Build search result
      final searchResult = SemanticSearchResult(
        id: 'search_${DateTime.now().millisecondsSinceEpoch}',
        queryId: query.id,
        results: results,
        totalResults: results.length,
        searchTime: searchTime,
        searchStrategy: 'cosine_similarity',
        averageRelevance: results.isEmpty ? 0.0 : 
          results.map((r) => r.relevanceScore).average,
        createdAt: DateTime.now(),
      );
      
      // Store search result for analytics
      await _storeSearchResult(searchResult);
      
      return searchResult;
    } catch (e) {
      throw VectorDatabaseException('Failed to perform semantic search: $e');
    }
  }
  
  /// Find documents similar to a given document
  Future<List<SearchResultItem>> findSimilarDocuments({
    required String documentId,
    int maxResults = _defaultMaxResults,
    double similarityThreshold = _defaultSimilarityThreshold,
  }) async {
    try {
      // Get the document embedding
      final document = await getVectorDocument(documentId);
      if (document?.embedding == null) {
        throw VectorDatabaseException('Document $documentId has no embedding');
      }
      
      return await _findSimilarDocuments(
        queryEmbedding: document!.embedding!.embedding,
        maxResults: maxResults,
        similarityThreshold: similarityThreshold,
        excludeDocumentId: documentId,
      );
    } catch (e) {
      throw VectorDatabaseException('Failed to find similar documents: $e');
    }
  }
  
  /// Get a vector document by ID
  Future<VectorDocument?> getVectorDocument(String documentId) async {
    try {
      final result = await _cosmosService.getItem(
        containerName: _documentsContainerName,
        itemId: documentId,
      );
      
      if (result != null) {
        return VectorDocument.fromJson(result);
      }
      
      return null;
    } catch (e) {
      throw VectorDatabaseException('Failed to get vector document $documentId: $e');
    }
  }
  
  /// Update a vector document
  Future<void> updateVectorDocument(VectorDocument document) async {
    try {
      await _cosmosService.updateItem(
        containerName: _documentsContainerName,
        item: document.toJson(),
      );
      
      if (document.embedding != null) {
        await _updateEmbedding(document.embedding!);
        await _updateVectorIndex(document);
      }
    } catch (e) {
      throw VectorDatabaseException('Failed to update vector document ${document.id}: $e');
    }
  }
  
  /// Delete a vector document
  Future<void> deleteVectorDocument(String documentId) async {
    try {
      await _cosmosService.deleteItem(
        containerName: _documentsContainerName,
        itemId: documentId,
      );
      
      // Remove from embedding cache
      _embeddingCache.values.forEach((embeddings) {
        embeddings.removeWhere((e) => e.documentId == documentId);
      });
      
      // Update indices
      await _removeFromVectorIndex(documentId);
    } catch (e) {
      throw VectorDatabaseException('Failed to delete vector document $documentId: $e');
    }
  }
  
  /// Build or rebuild vector index for a category
  Future<VectorIndex> buildVectorIndex({
    required String indexName,
    required NeedCategory category,
    IndexType indexType = IndexType.flat,
    SimilarityMetric similarityMetric = SimilarityMetric.cosine,
  }) async {
    try {
      final startTime = DateTime.now();
      
      // Query documents for the category
      final documents = await _getDocumentsByCategory(category);
      
      // Create index configuration
      final index = VectorIndex(
        id: 'index_${indexName}_${DateTime.now().millisecondsSinceEpoch}',
        name: indexName,
        dimensions: 1536, // text-embedding-ada-002 dimensions
        distanceMetric: similarityMetric.name,
        indexType: indexType,
        status: IndexStatus.building,
        createdAt: startTime,
      );
      
      // Build the index
      final embeddings = <DocumentEmbedding>[];
      for (final document in documents) {
        if (document.embedding != null) {
          embeddings.add(document.embedding!);
        }
      }
      
      // Store index in cache
      _vectorIndices[indexName] = index.copyWith(
        status: IndexStatus.ready,
        documentCount: documents.length,
        embeddingCount: embeddings.length,
        buildProgress: 1.0,
        updatedAt: DateTime.now(),
      );
      
      _embeddingCache[indexName] = embeddings;
      
      // Persist index metadata
      await _cosmosService.createItem(
        containerName: 'vector_indices',
        item: _vectorIndices[indexName]!.toJson(),
      );
      
      print('Built vector index $indexName with ${embeddings.length} embeddings');
      
      return _vectorIndices[indexName]!;
    } catch (e) {
      throw VectorDatabaseException('Failed to build vector index $indexName: $e');
    }
  }
  
  /// Get index statistics
  Map<String, dynamic> getIndexStatistics(String indexName) {
    final index = _vectorIndices[indexName];
    final embeddings = _embeddingCache[indexName];
    
    if (index == null || embeddings == null) {
      return {'error': 'Index not found'};
    }
    
    return {
      'name': index.name,
      'status': index.status.name,
      'document_count': index.documentCount,
      'embedding_count': index.embeddingCount,
      'dimensions': index.dimensions,
      'distance_metric': index.distanceMetric,
      'created_at': index.createdAt?.toIso8601String(),
      'updated_at': index.updatedAt?.toIso8601String(),
    };
  }
  
  /// Get all available indices
  List<VectorIndex> getAvailableIndices() {
    return _vectorIndices.values.toList();
  }
  
  // Private helper methods
  
  Future<void> _initializeVectorContainers() async {
    try {
      // Create containers for vector storage if they don't exist
      // This would be implemented based on your Cosmos DB setup
      print('Vector database containers initialized');
    } catch (e) {
      throw VectorDatabaseException('Failed to initialize vector containers: $e');
    }
  }
  
  Future<void> _loadExistingIndices() async {
    try {
      // Load existing indices from Cosmos DB
      // Implementation would depend on your storage structure
      print('Loaded existing vector indices');
    } catch (e) {
      print('Warning: Failed to load existing indices: $e');
    }
  }
  
  Future<void> _storeEmbedding(DocumentEmbedding embedding) async {
    try {
      await _cosmosService.createItem(
        containerName: _vectorContainerName,
        item: embedding.toJson(),
      );
    } catch (e) {
      throw VectorDatabaseException('Failed to store embedding: $e');
    }
  }
  
  Future<void> _storeBatchEmbeddings(List<DocumentEmbedding> embeddings) async {
    try {
      final futures = embeddings.map((embedding) =>
        _cosmosService.createItem(
          containerName: _vectorContainerName,
          item: embedding.toJson(),
        )
      );
      
      await Future.wait(futures);
    } catch (e) {
      throw VectorDatabaseException('Failed to store batch embeddings: $e');
    }
  }
  
  Future<void> _updateEmbedding(DocumentEmbedding embedding) async {
    try {
      await _cosmosService.updateItem(
        containerName: _vectorContainerName,
        item: embedding.toJson(),
      );
    } catch (e) {
      throw VectorDatabaseException('Failed to update embedding: $e');
    }
  }
  
  Future<List<double>> _getQueryEmbedding(SemanticQuery query) async {
    // If query already has embedding, use it
    if (query.queryEmbedding != null) {
      return query.queryEmbedding!;
    }
    
    // Generate embedding for the query text
    final embedding = await _embeddingsService.generateEmbedding(
      text: query.query,
      documentId: 'query_${query.id}',
      documentType: DocumentType.userContent,
    );
    
    return embedding.embedding;
  }
  
  Future<List<SearchResultItem>> _findSimilarDocuments({
    required List<double> queryEmbedding,
    int maxResults = _defaultMaxResults,
    double similarityThreshold = _defaultSimilarityThreshold,
    List<DocumentType>? documentTypes,
    List<NeedCategory>? categories,
    Map<String, dynamic>? filters,
    String? excludeDocumentId,
  }) async {
    final results = <SearchResultItem>[];
    
    // Search across all cached embeddings
    for (final indexName in _embeddingCache.keys) {
      final embeddings = _embeddingCache[indexName]!;
      
      for (final embedding in embeddings) {
        // Skip excluded document
        if (excludeDocumentId != null && embedding.documentId == excludeDocumentId) {
          continue;
        }
        
        // Calculate similarity
        final similarity = VectorOperations.cosineSimilarity(
          queryEmbedding, 
          embedding.embedding
        );
        
        // Check similarity threshold
        if (similarity < similarityThreshold) {
          continue;
        }
        
        // Get the full document
        final document = await getVectorDocument(embedding.documentId);
        if (document == null) continue;
        
        // Apply filters
        if (documentTypes != null && !documentTypes.contains(document.type)) {
          continue;
        }
        
        if (categories != null && !categories.contains(document.category)) {
          continue;
        }
        
        // Create search result item
        final resultItem = SearchResultItem(
          documentId: document.id,
          document: document,
          similarityScore: similarity,
          relevanceScore: _calculateRelevanceScore(similarity, document),
          qualityScore: document.qualityScore,
          finalScore: _calculateFinalScore(similarity, document),
        );
        
        results.add(resultItem);
      }
    }
    
    // Sort by final score and limit results
    results.sort((a, b) => b.finalScore!.compareTo(a.finalScore!));
    
    // Add ranking information
    for (int i = 0; i < results.length; i++) {
      results[i] = results[i].copyWith(
        rank: i + 1,
        rankingReason: 'Similarity: ${results[i].similarityScore.toStringAsFixed(3)}',
      );
    }
    
    return results.take(maxResults).toList();
  }
  
  double _calculateRelevanceScore(double similarity, VectorDocument document) {
    // Base relevance on similarity
    double relevance = similarity;
    
    // Boost for quality
    if (document.qualityScore != null) {
      relevance = relevance * 0.8 + document.qualityScore! * 0.2;
    }
    
    // Boost for recency (optional)
    if (document.createdAt != null) {
      final daysSinceCreation = DateTime.now().difference(document.createdAt!).inDays;
      final recencyBoost = math.max(0.0, 1.0 - daysSinceCreation / 365.0) * 0.1;
      relevance += recencyBoost;
    }
    
    return math.min(1.0, relevance);
  }
  
  double _calculateFinalScore(double similarity, VectorDocument document) {
    double score = similarity * 0.7; // Primary weight on similarity
    
    // Add quality score
    if (document.qualityScore != null) {
      score += document.qualityScore! * 0.2;
    }
    
    // Add popularity boost
    if (document.viewCount != null && document.viewCount! > 0) {
      final popularityScore = math.min(1.0, document.viewCount! / 100.0);
      score += popularityScore * 0.1;
    }
    
    return math.min(1.0, score);
  }
  
  Future<List<VectorDocument>> _getDocumentsByCategory(NeedCategory category) async {
    try {
      // Query documents from Cosmos DB by category
      // This is a simplified implementation
      final query = '''
        SELECT * FROM c 
        WHERE c.category = '${category.name}'
      ''';
      
      final results = await _cosmosService.queryItems(
        containerName: _documentsContainerName,
        query: query,
      );
      
      return results.map((result) => VectorDocument.fromJson(result)).toList();
    } catch (e) {
      throw VectorDatabaseException('Failed to get documents by category: $e');
    }
  }
  
  Future<void> _updateVectorIndex(VectorDocument document) async {
    // Update relevant indices with the new document
    for (final indexName in _vectorIndices.keys) {
      final index = _vectorIndices[indexName]!;
      
      // Add to cache if embedding exists
      if (document.embedding != null) {
        _embeddingCache[indexName] ??= [];
        _embeddingCache[indexName]!.add(document.embedding!);
        
        // Update index metadata
        _vectorIndices[indexName] = index.copyWith(
          documentCount: index.documentCount + 1,
          embeddingCount: index.embeddingCount + 1,
          updatedAt: DateTime.now(),
        );
      }
    }
  }
  
  Future<void> _removeFromVectorIndex(String documentId) async {
    // Remove from all indices
    for (final indexName in _embeddingCache.keys) {
      _embeddingCache[indexName]!.removeWhere((e) => e.documentId == documentId);
      
      // Update index metadata
      final index = _vectorIndices[indexName];
      if (index != null) {
        _vectorIndices[indexName] = index.copyWith(
          embeddingCount: _embeddingCache[indexName]!.length,
          updatedAt: DateTime.now(),
        );
      }
    }
  }
  
  Future<void> _storeSearchResult(SemanticSearchResult result) async {
    try {
      await _cosmosService.createItem(
        containerName: 'search_results',
        item: result.toJson(),
      );
    } catch (e) {
      // Non-critical error, just log
      print('Warning: Failed to store search result: $e');
    }
  }
}

/// Custom exception for vector database operations
class VectorDatabaseException implements Exception {
  final String message;
  
  VectorDatabaseException(this.message);
  
  @override
  String toString() => 'VectorDatabaseException: $message';
} 