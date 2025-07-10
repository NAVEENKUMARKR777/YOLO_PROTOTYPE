import 'dart:convert';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import '../../models/vector_store_model.dart';
import '../../models/chat_model.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import 'azure_embeddings.dart';
import 'azure_vector_database.dart';

/// Azure AI Foundry Service - Query Understanding + Contextual Enrichment
class AzureAiFoundryService {
  static const String _endpoint = 'https://YOUR_OPENAI_RESOURCE.openai.azure.com/';
  static const String _apiKey = 'YOUR_AZURE_OPENAI_API_KEY';
  static const String _apiVersion = '2023-12-01-preview';
  static const String _gpt4Deployment = 'gpt-4';
  static const String _gpt35Deployment = 'gpt-35-turbo';
  
  final AzureVectorDatabaseService _vectorService;
  final Dio _dio;
  final RetryOptions _retryOptions;
  
  // Context management
  final Map<String, QueryContext> _contextCache = {};
  final Map<String, List<VectorDocument>> _documentCache = {};
  
  AzureAiFoundryService({
    required AzureVectorDatabaseService vectorService,
    Dio? dio,
  }) : _vectorService = vectorService,
       _dio = dio ?? Dio(),
       _retryOptions = const RetryOptions(
         maxAttempts: 3,
         delay: Duration(seconds: 1),
         delayFactor: Duration(seconds: 2),
       );
  
  /// Initialize the AI Foundry service
  Future<void> initialize() async {
    _dio.options.baseUrl = _endpoint;
    _dio.options.headers['api-key'] = _apiKey;
    _dio.options.headers['Content-Type'] = 'application/json';
    await _vectorService.initialize();
  }
  
  /// Process and understand user query with context enrichment
  Future<EnrichedQuery> processQuery({
    required String query,
    required String userId,
    String? sessionId,
    String? needId,
    List<ChatMessage>? conversationHistory,
    User? user,
    Need? relatedNeed,
    Map<String, dynamic>? additionalContext,
  }) async {
    try {
      // Step 1: Understand query intent and extract entities
      final queryUnderstanding = await _analyzeQueryIntent(
        query: query,
        userId: userId,
        user: user,
        conversationHistory: conversationHistory,
      );
      
      // Step 2: Retrieve relevant supporting data from vector database
      final retrievalResults = await _retrieveSupportingData(
        queryUnderstanding: queryUnderstanding,
        needCategory: relatedNeed?.category,
        maxResults: 10,
      );
      
      // Step 3: Enrich context with retrieved data
      final enrichedContext = await _enrichContext(
        originalQuery: query,
        queryUnderstanding: queryUnderstanding,
        retrievalResults: retrievalResults,
        user: user,
        relatedNeed: relatedNeed,
        conversationHistory: conversationHistory,
        additionalContext: additionalContext,
      );
      
      // Step 4: Generate enhanced prompt
      final enhancedPrompt = await _generateEnhancedPrompt(
        originalQuery: query,
        enrichedContext: enrichedContext,
        queryUnderstanding: queryUnderstanding,
      );
      
      // Step 5: Create enriched query object
      final enrichedQuery = EnrichedQuery(
        id: 'eq_${DateTime.now().millisecondsSinceEpoch}',
        originalQuery: query,
        userId: userId,
        sessionId: sessionId,
        needId: needId,
        queryUnderstanding: queryUnderstanding,
        retrievalResults: retrievalResults,
        enrichedContext: enrichedContext,
        enhancedPrompt: enhancedPrompt,
        processingTime: DateTime.now(),
        createdAt: DateTime.now(),
      );
      
      // Cache for future use
      _contextCache[enrichedQuery.id] = QueryContext(
        query: enrichedQuery,
        retrievedDocuments: retrievalResults.results.map((r) => r.document).toList(),
        timestamp: DateTime.now(),
      );
      
      return enrichedQuery;
    } catch (e) {
      throw AiFoundryException('Failed to process query: $e');
    }
  }
  
  /// Analyze query intent and extract structured information
  Future<QueryUnderstanding> _analyzeQueryIntent({
    required String query,
    required String userId,
    User? user,
    List<ChatMessage>? conversationHistory,
  }) async {
    try {
      final systemPrompt = '''
You are an expert query understanding AI. Analyze the user's query and extract structured information.

Respond with a JSON object containing:
{
  "intent": "question|request|complaint|compliment|search|create|update|delete|help",
  "confidence": 0.0-1.0,
  "entities": {
    "keywords": ["important", "keywords"],
    "categories": ["relevant", "categories"],
    "locations": ["mentioned", "locations"],
    "urgency": "low|medium|high|critical",
    "timeframe": "immediate|days|weeks|months|unspecified"
  },
  "semantic_meaning": "Detailed explanation of what the user wants",
  "suggested_actions": ["action1", "action2"],
  "context_requirements": ["type", "of", "context", "needed"],
  "complexity": "simple|medium|complex",
  "domain": "general|health|education|technology|emergency|etc"
}
''';
      
      final messages = [
        {'role': 'system', 'content': systemPrompt},
        if (conversationHistory != null && conversationHistory.isNotEmpty)
          ...conversationHistory.take(5).map((msg) => {
            'role': msg.senderId == userId ? 'user' : 'assistant',
            'content': msg.content,
          }),
        {'role': 'user', 'content': query},
      ];
      
      final response = await _retryOptions.retry(() async {
        final result = await _dio.post(
          'openai/deployments/$_gpt35Deployment/chat/completions',
          queryParameters: {'api-version': _apiVersion},
          data: {
            'messages': messages,
            'max_tokens': 800,
            'temperature': 0.3,
            'response_format': {'type': 'json_object'},
          },
        );
        
        if (result.statusCode != 200) {
          throw DioException(
            requestOptions: result.requestOptions,
            response: result,
            message: 'Failed to analyze query intent: ${result.statusCode}',
          );
        }
        
        return result.data;
      });
      
      final analysisJson = jsonDecode(response['choices'][0]['message']['content']);
      
      return QueryUnderstanding(
        intent: analysisJson['intent'] ?? 'question',
        confidence: (analysisJson['confidence'] ?? 0.8).toDouble(),
        keywords: List<String>.from(analysisJson['entities']['keywords'] ?? []),
        categories: List<String>.from(analysisJson['entities']['categories'] ?? []),
        locations: List<String>.from(analysisJson['entities']['locations'] ?? []),
        urgency: analysisJson['entities']['urgency'] ?? 'medium',
        timeframe: analysisJson['entities']['timeframe'] ?? 'unspecified',
        semanticMeaning: analysisJson['semantic_meaning'] ?? '',
        suggestedActions: List<String>.from(analysisJson['suggested_actions'] ?? []),
        contextRequirements: List<String>.from(analysisJson['context_requirements'] ?? []),
        complexity: analysisJson['complexity'] ?? 'medium',
        domain: analysisJson['domain'] ?? 'general',
      );
    } catch (e) {
      throw AiFoundryException('Failed to analyze query intent: $e');
    }
  }
  
  /// Retrieve supporting data from vector database
  Future<SemanticSearchResult> _retrieveSupportingData({
    required QueryUnderstanding queryUnderstanding,
    NeedCategory? needCategory,
    int maxResults = 10,
  }) async {
    try {
      // Build semantic query
      final semanticQuery = SemanticQuery(
        id: 'sq_${DateTime.now().millisecondsSinceEpoch}',
        query: queryUnderstanding.semanticMeaning,
        userId: 'system',
        maxResults: maxResults,
        similarityThreshold: 0.6,
        categories: needCategory != null ? [needCategory] : null,
        context: {
          'intent': queryUnderstanding.intent,
          'domain': queryUnderstanding.domain,
          'urgency': queryUnderstanding.urgency,
          'keywords': queryUnderstanding.keywords,
        },
        createdAt: DateTime.now(),
      );
      
      // Perform semantic search
      final searchResults = await _vectorService.semanticSearch(semanticQuery);
      
      return searchResults;
    } catch (e) {
      throw AiFoundryException('Failed to retrieve supporting data: $e');
    }
  }
  
  /// Enrich context with retrieved data and analysis
  Future<EnrichedContext> _enrichContext({
    required String originalQuery,
    required QueryUnderstanding queryUnderstanding,
    required SemanticSearchResult retrievalResults,
    User? user,
    Need? relatedNeed,
    List<ChatMessage>? conversationHistory,
    Map<String, dynamic>? additionalContext,
  }) async {
    try {
      // Extract relevant information from retrieved documents
      final relevantDocuments = retrievalResults.results.take(5).toList();
      final documentSummaries = await _summarizeDocuments(relevantDocuments);
      
      // Analyze user context
      final userContextAnalysis = user != null 
          ? await _analyzeUserContext(user)
          : null;
      
      // Analyze conversation context
      final conversationAnalysis = conversationHistory != null && conversationHistory.isNotEmpty
          ? await _analyzeConversationContext(conversationHistory)
          : null;
      
      // Generate contextual insights
      final contextualInsights = await _generateContextualInsights(
        queryUnderstanding: queryUnderstanding,
        documentSummaries: documentSummaries,
        userContext: userContextAnalysis,
        conversationContext: conversationAnalysis,
        relatedNeed: relatedNeed,
      );
      
      return EnrichedContext(
        originalQuery: originalQuery,
        queryUnderstanding: queryUnderstanding,
        relevantDocuments: relevantDocuments,
        documentSummaries: documentSummaries,
        userContext: userContextAnalysis,
        conversationContext: conversationAnalysis,
        contextualInsights: contextualInsights,
        retrievalResults: retrievalResults,
        confidence: _calculateContextConfidence(
          queryUnderstanding,
          retrievalResults,
          documentSummaries,
        ),
        additionalMetadata: additionalContext ?? {},
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw AiFoundryException('Failed to enrich context: $e');
    }
  }
  
  /// Generate enhanced prompt for Graph RAG processing
  Future<String> _generateEnhancedPrompt({
    required String originalQuery,
    required EnrichedContext enrichedContext,
    required QueryUnderstanding queryUnderstanding,
  }) async {
    try {
      final promptBuilder = StringBuffer();
      
      // Core query information
      promptBuilder.writeln('=== USER QUERY ===');
      promptBuilder.writeln('Original Query: $originalQuery');
      promptBuilder.writeln('Intent: ${queryUnderstanding.intent}');
      promptBuilder.writeln('Domain: ${queryUnderstanding.domain}');
      promptBuilder.writeln('Urgency: ${queryUnderstanding.urgency}');
      promptBuilder.writeln('Semantic Meaning: ${queryUnderstanding.semanticMeaning}');
      promptBuilder.writeln();
      
      // Retrieved context
      promptBuilder.writeln('=== RELEVANT CONTEXT ===');
      for (int i = 0; i < enrichedContext.documentSummaries.length; i++) {
        final summary = enrichedContext.documentSummaries[i];
        final doc = enrichedContext.relevantDocuments[i];
        promptBuilder.writeln('Document ${i + 1} (${doc.document.type.name}):');
        promptBuilder.writeln('Title: ${doc.document.title ?? 'Untitled'}');
        promptBuilder.writeln('Summary: $summary');
        promptBuilder.writeln('Relevance: ${doc.relevanceScore.toStringAsFixed(2)}');
        promptBuilder.writeln();
      }
      
      // User context
      if (enrichedContext.userContext != null) {
        promptBuilder.writeln('=== USER CONTEXT ===');
        promptBuilder.writeln(enrichedContext.userContext!);
        promptBuilder.writeln();
      }
      
      // Conversation context
      if (enrichedContext.conversationContext != null) {
        promptBuilder.writeln('=== CONVERSATION CONTEXT ===');
        promptBuilder.writeln(enrichedContext.conversationContext!);
        promptBuilder.writeln();
      }
      
      // Contextual insights
      promptBuilder.writeln('=== CONTEXTUAL INSIGHTS ===');
      promptBuilder.writeln(enrichedContext.contextualInsights);
      promptBuilder.writeln();
      
      // Instructions for Graph RAG
      promptBuilder.writeln('=== INSTRUCTIONS ===');
      promptBuilder.writeln('Based on the above context, provide a comprehensive response that:');
      promptBuilder.writeln('1. Directly addresses the user\'s query');
      promptBuilder.writeln('2. Incorporates relevant information from the retrieved documents');
      promptBuilder.writeln('3. Considers the user\'s context and conversation history');
      promptBuilder.writeln('4. Provides actionable insights and suggestions');
      promptBuilder.writeln('5. Maintains appropriate tone based on urgency and domain');
      
      return promptBuilder.toString();
    } catch (e) {
      throw AiFoundryException('Failed to generate enhanced prompt: $e');
    }
  }
  
  /// Summarize retrieved documents
  Future<List<String>> _summarizeDocuments(List<SearchResultItem> documents) async {
    try {
      final summaries = <String>[];
      
      for (final doc in documents) {
        if (doc.document.summary != null && doc.document.summary!.isNotEmpty) {
          summaries.add(doc.document.summary!);
        } else {
          // Generate summary for documents without one
          final content = doc.document.content;
          final summary = await _generateQuickSummary(content);
          summaries.add(summary);
        }
      }
      
      return summaries;
    } catch (e) {
      throw AiFoundryException('Failed to summarize documents: $e');
    }
  }
  
  /// Generate quick summary for a document
  Future<String> _generateQuickSummary(String content) async {
    try {
      if (content.length <= 200) {
        return content;
      }
      
      // Take first few sentences as summary
      final sentences = content.split(RegExp(r'[.!?]+'));
      if (sentences.length <= 3) {
        return content;
      }
      
      return sentences.take(2).join('. ') + '.';
    } catch (e) {
      return content.substring(0, math.min(200, content.length)) + '...';
    }
  }
  
  /// Analyze user context
  Future<String> _analyzeUserContext(User user) async {
    final context = StringBuffer();
    context.writeln('User: ${user.name} (${user.role.name})');
    context.writeln('Level: ${user.level}, Points: ${user.points}');
    
    if (user.bio != null && user.bio!.isNotEmpty) {
      context.writeln('Bio: ${user.bio}');
    }
    
    if (user.skills.isNotEmpty) {
      context.writeln('Skills: ${user.skills.join(', ')}');
    }
    
    if (user.interests.isNotEmpty) {
      context.writeln('Interests: ${user.interests.join(', ')}');
    }
    
    return context.toString();
  }
  
  /// Analyze conversation context
  Future<String> _analyzeConversationContext(List<ChatMessage> messages) async {
    final recentMessages = messages.take(3).toList();
    final context = StringBuffer();
    
    context.writeln('Recent conversation:');
    for (final message in recentMessages) {
      final sender = message.senderName ?? 'User';
      context.writeln('$sender: ${message.content}');
    }
    
    return context.toString();
  }
  
  /// Generate contextual insights
  Future<String> _generateContextualInsights({
    required QueryUnderstanding queryUnderstanding,
    required List<String> documentSummaries,
    String? userContext,
    String? conversationContext,
    Need? relatedNeed,
  }) async {
    final insights = StringBuffer();
    
    // Query analysis insights
    insights.writeln('Query Analysis:');
    insights.writeln('- Intent: ${queryUnderstanding.intent}');
    insights.writeln('- Complexity: ${queryUnderstanding.complexity}');
    insights.writeln('- Domain: ${queryUnderstanding.domain}');
    insights.writeln('- Key topics: ${queryUnderstanding.keywords.join(', ')}');
    
    // Document relevance insights
    if (documentSummaries.isNotEmpty) {
      insights.writeln('\nRelevant Information Found:');
      insights.writeln('- ${documentSummaries.length} relevant documents retrieved');
      insights.writeln('- Primary focus areas match user query');
    }
    
    // Context alignment insights
    if (relatedNeed != null) {
      insights.writeln('\nNeed Context:');
      insights.writeln('- Related to ${relatedNeed.category.name} need');
      insights.writeln('- Urgency level: ${relatedNeed.urgency.name}');
    }
    
    return insights.toString();
  }
  
  /// Calculate context confidence score
  double _calculateContextConfidence(
    QueryUnderstanding queryUnderstanding,
    SemanticSearchResult retrievalResults,
    List<String> documentSummaries,
  ) {
    double confidence = queryUnderstanding.confidence;
    
    // Boost confidence based on retrieval quality
    if (retrievalResults.results.isNotEmpty) {
      final avgRelevance = retrievalResults.averageRelevance ?? 0.0;
      confidence = confidence * 0.7 + avgRelevance * 0.3;
    }
    
    // Boost confidence based on document quality
    if (documentSummaries.isNotEmpty) {
      confidence += 0.1; // Small boost for having relevant documents
    }
    
    return math.min(1.0, confidence);
  }
  
  /// Get cached context for a query
  QueryContext? getCachedContext(String queryId) {
    return _contextCache[queryId];
  }
  
  /// Clear context cache
  void clearContextCache() {
    _contextCache.clear();
    _documentCache.clear();
  }
}

/// Models for AI Foundry

class QueryUnderstanding {
  final String intent;
  final double confidence;
  final List<String> keywords;
  final List<String> categories;
  final List<String> locations;
  final String urgency;
  final String timeframe;
  final String semanticMeaning;
  final List<String> suggestedActions;
  final List<String> contextRequirements;
  final String complexity;
  final String domain;
  
  QueryUnderstanding({
    required this.intent,
    required this.confidence,
    required this.keywords,
    required this.categories,
    required this.locations,
    required this.urgency,
    required this.timeframe,
    required this.semanticMeaning,
    required this.suggestedActions,
    required this.contextRequirements,
    required this.complexity,
    required this.domain,
  });
}

class EnrichedContext {
  final String originalQuery;
  final QueryUnderstanding queryUnderstanding;
  final List<SearchResultItem> relevantDocuments;
  final List<String> documentSummaries;
  final String? userContext;
  final String? conversationContext;
  final String contextualInsights;
  final SemanticSearchResult retrievalResults;
  final double confidence;
  final Map<String, dynamic> additionalMetadata;
  final DateTime createdAt;
  
  EnrichedContext({
    required this.originalQuery,
    required this.queryUnderstanding,
    required this.relevantDocuments,
    required this.documentSummaries,
    this.userContext,
    this.conversationContext,
    required this.contextualInsights,
    required this.retrievalResults,
    required this.confidence,
    required this.additionalMetadata,
    required this.createdAt,
  });
}

class EnrichedQuery {
  final String id;
  final String originalQuery;
  final String userId;
  final String? sessionId;
  final String? needId;
  final QueryUnderstanding queryUnderstanding;
  final SemanticSearchResult retrievalResults;
  final EnrichedContext enrichedContext;
  final String enhancedPrompt;
  final DateTime processingTime;
  final DateTime createdAt;
  
  EnrichedQuery({
    required this.id,
    required this.originalQuery,
    required this.userId,
    this.sessionId,
    this.needId,
    required this.queryUnderstanding,
    required this.retrievalResults,
    required this.enrichedContext,
    required this.enhancedPrompt,
    required this.processingTime,
    required this.createdAt,
  });
}

class QueryContext {
  final EnrichedQuery query;
  final List<VectorDocument> retrievedDocuments;
  final DateTime timestamp;
  
  QueryContext({
    required this.query,
    required this.retrievedDocuments,
    required this.timestamp,
  });
}

/// Custom exception for AI Foundry operations
class AiFoundryException implements Exception {
  final String message;
  
  AiFoundryException(this.message);
  
  @override
  String toString() => 'AiFoundryException: $message';
} 