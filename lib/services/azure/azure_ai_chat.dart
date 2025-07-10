import 'dart:convert';
import 'package:dio/dio.dart';
import '../../models/chat_model.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import '../../models/vector_store_model.dart';
import '../../models/graph_rag_model.dart';
import 'azure_embeddings.dart';
import 'azure_vector_database.dart';
import 'azure_ai_foundry.dart';
import 'azure_graph_rag.dart';
import 'azure_cosmos.dart';

class AzureAiChatService {
  static const String _endpoint = 'https://YOUR_OPENAI_RESOURCE.openai.azure.com/';
  static const String _apiKey = 'YOUR_AZURE_OPENAI_API_KEY';
  static const String _apiVersion = '2023-12-01-preview';
  static const String _deploymentName = 'gpt-4';
  
  final Dio _dio;
  
  // RAG Pipeline Components
  late final AzureEmbeddingsService _embeddingsService;
  late final AzureVectorDatabaseService _vectorService;
  late final AzureAiFoundryService _aiFoundryService;
  late final AzureGraphRagService _graphRagService;
  late final AzureCosmosService _cosmosService;
  
  bool _ragEnabled = true;
  bool _isInitialized = false;
  
  AzureAiChatService({Dio? dio}) : _dio = dio ?? Dio();
  
  /// Initialize the AI chat service with full RAG pipeline
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    _dio.options.baseUrl = _endpoint;
    _dio.options.headers['api-key'] = _apiKey;
    _dio.options.headers['Content-Type'] = 'application/json';
    
    if (_ragEnabled) {
      // Initialize RAG pipeline components in correct order
      _cosmosService = AzureCosmosService();
      _embeddingsService = AzureEmbeddingsService(dio: _dio);
      _vectorService = AzureVectorDatabaseService(
        embeddingsService: _embeddingsService,
        cosmosService: _cosmosService,
      );
      _aiFoundryService = AzureAiFoundryService(
        vectorService: _vectorService,
        dio: _dio,
      );
      _graphRagService = AzureGraphRagService(
        aiFoundryService: _aiFoundryService,
        cosmosService: _cosmosService,
        dio: _dio,
      );
      
      // Initialize all services
      await _cosmosService.initialize();
      await _embeddingsService.initialize();
      await _vectorService.initialize();
      await _aiFoundryService.initialize();
      await _graphRagService.initialize();
      
      print('RAG Pipeline initialized successfully');
    }
    
    _isInitialized = true;
  }
  
  /// Generate AI response using full RAG pipeline
  Future<AiChatResponse> generateResponse({
    required String userMessage,
    required AiChatSession session,
    Need? relatedNeed,
    User? user,
    List<ChatMessage>? conversationHistory,
  }) async {
    try {
      if (!_isInitialized) {
        await initialize();
      }
      
      // Use RAG pipeline if enabled, otherwise fall back to basic chat
      if (_ragEnabled) {
        return await _generateRagResponse(
          userMessage: userMessage,
          session: session,
          relatedNeed: relatedNeed,
          user: user,
          conversationHistory: conversationHistory,
        );
      } else {
        return await _generateBasicResponse(
          userMessage: userMessage,
          session: session,
          relatedNeed: relatedNeed,
          user: user,
          conversationHistory: conversationHistory,
        );
      }
    } catch (e) {
      throw AiChatException('Failed to generate AI response: $e');
    }
  }
  
  /// Generate response using the full RAG pipeline
  Future<AiChatResponse> _generateRagResponse({
    required String userMessage,
    required AiChatSession session,
    Need? relatedNeed,
    User? user,
    List<ChatMessage>? conversationHistory,
  }) async {
    try {
      // Step 1: Generate structured answer using Graph RAG
      final structuredAnswer = await _graphRagService.generateStructuredAnswer(
        query: userMessage,
        userId: session.userId,
        sessionId: session.id,
        needId: relatedNeed?.id,
        conversationHistory: conversationHistory,
        user: user,
        relatedNeed: relatedNeed,
        additionalContext: {
          'session_context': session.context,
          'ai_model': session.aiModel,
        },
      );
      
      // Step 2: Convert structured answer to chat response format
      final chatResponse = _convertStructuredAnswerToResponse(
        structuredAnswer: structuredAnswer,
        userMessage: userMessage,
        session: session,
      );
      
      // Step 3: Store interaction for learning
      await _storeInteractionForLearning(
        userMessage: userMessage,
        response: chatResponse,
        structuredAnswer: structuredAnswer,
        session: session,
      );
      
      return chatResponse;
    } catch (e) {
      // Fall back to basic response if RAG fails
      print('RAG pipeline failed, falling back to basic response: $e');
      return await _generateBasicResponse(
        userMessage: userMessage,
        session: session,
        relatedNeed: relatedNeed,
        user: user,
        conversationHistory: conversationHistory,
      );
    }
  }
  
  /// Generate basic response without RAG (fallback)
  Future<AiChatResponse> _generateBasicResponse({
    required String userMessage,
    required AiChatSession session,
    Need? relatedNeed,
    User? user,
    List<ChatMessage>? conversationHistory,
  }) async {
    try {
      final systemPrompt = _buildSystemPrompt(user, relatedNeed);
      final messages = _buildMessageHistory(
        systemPrompt,
        userMessage,
        conversationHistory,
      );
      
      final response = await _dio.post(
        'openai/deployments/$_deploymentName/chat/completions',
        queryParameters: {'api-version': _apiVersion},
        data: {
          'messages': messages,
          'max_tokens': 1000,
          'temperature': 0.7,
          'top_p': 0.95,
          'frequency_penalty': 0,
          'presence_penalty': 0,
          'stream': false,
        },
      );
      
      final data = response.data;
      final choice = data['choices'][0];
      final aiMessage = choice['message']['content'] as String;
      final usage = data['usage'];
      
      return AiChatResponse(
        message: aiMessage,
        confidence: _calculateConfidence(choice),
        tokensUsed: usage['total_tokens'],
        model: _deploymentName,
        finishReason: choice['finish_reason'],
        suggestions: _extractSuggestions(aiMessage),
        actions: _extractActions(aiMessage, relatedNeed),
      );
    } catch (e) {
      throw AiChatException('Failed to generate basic AI response: $e');
    }
  }
  
  /// Generate smart suggestions for need creation
  Future<List<String>> generateNeedSuggestions({
    required String userInput,
    required NeedCategory category,
    String? location,
  }) async {
    try {
      final systemPrompt = '''
You are an AI assistant helping users create detailed need requests. 
Based on the user's input and category, provide 3-5 specific, actionable suggestions 
to improve their need description. Focus on clarity, completeness, and helpfulness.

Category: ${category.name}
${location != null ? 'Location: $location' : ''}

Guidelines:
- Make suggestions specific and actionable
- Consider urgency, timeline, and requirements
- Suggest missing important details
- Keep suggestions concise (1-2 sentences each)
''';
      
      final messages = [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': 'Original request: $userInput'},
      ];
      
      final response = await _dio.post(
        'openai/deployments/$_deploymentName/chat/completions',
        queryParameters: {'api-version': _apiVersion},
        data: {
          'messages': messages,
          'max_tokens': 500,
          'temperature': 0.8,
        },
      );
      
      final aiResponse = response.data['choices'][0]['message']['content'] as String;
      return _parseSuggestions(aiResponse);
    } catch (e) {
      throw AiChatException('Failed to generate need suggestions: $e');
    }
  }
  
  /// Analyze sentiment of user message
  Future<SentimentAnalysis> analyzeSentiment(String text) async {
    try {
      final systemPrompt = '''
Analyze the sentiment of the following text and respond with a JSON object containing:
- sentiment: "positive", "negative", or "neutral"
- score: float between -1.0 (very negative) and 1.0 (very positive)
- emotions: array of detected emotions
- urgency: "low", "medium", or "high"
- keywords: array of important keywords
''';
      
      final messages = [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': text},
      ];
      
      final response = await _dio.post(
        'openai/deployments/$_deploymentName/chat/completions',
        queryParameters: {'api-version': _apiVersion},
        data: {
          'messages': messages,
          'max_tokens': 300,
          'temperature': 0.3,
        },
      );
      
      final aiResponse = response.data['choices'][0]['message']['content'] as String;
      final sentimentData = jsonDecode(aiResponse);
      
      return SentimentAnalysis.fromJson(sentimentData);
    } catch (e) {
      throw AiChatException('Failed to analyze sentiment: $e');
    }
  }
  
  /// Generate contextual help for specific scenarios
  Future<String> generateContextualHelp({
    required String scenario,
    required User user,
    Need? need,
    Map<String, dynamic>? context,
  }) async {
    try {
      final systemPrompt = _buildContextualHelpPrompt(scenario, user, need, context);
      
      final messages = [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': 'Please provide help for this scenario.'},
      ];
      
      final response = await _dio.post(
        'openai/deployments/$_deploymentName/chat/completions',
        queryParameters: {'api-version': _apiVersion},
        data: {
          'messages': messages,
          'max_tokens': 800,
          'temperature': 0.6,
        },
      );
      
      return response.data['choices'][0]['message']['content'] as String;
    } catch (e) {
      throw AiChatException('Failed to generate contextual help: $e');
    }
  }
  
  /// Moderate content for safety and appropriateness
  Future<ContentModerationResult> moderateContent(String content) async {
    try {
      final response = await _dio.post(
        'openai/deployments/text-moderation-latest/completions',
        queryParameters: {'api-version': _apiVersion},
        data: {'input': content},
      );
      
      final result = response.data['results'][0];
      
      return ContentModerationResult(
        flagged: result['flagged'],
        categories: Map<String, bool>.from(result['categories']),
        categoryScores: Map<String, double>.from(result['category_scores']),
      );
    } catch (e) {
      throw AiChatException('Failed to moderate content: $e');
    }
  }
  
  /// Extract key information from user messages
  Future<MessageAnalysis> analyzeMessage(String message) async {
    try {
      final systemPrompt = '''
Analyze the following message and extract structured information as JSON:
{
  "intent": "question|request|complaint|compliment|other",
  "entities": ["person", "location", "organization", "etc"],
  "keywords": ["important", "keywords"],
  "urgency": "low|medium|high",
  "category": "general|emergency|health|education|technology|etc",
  "actionRequired": true|false,
  "priority": "low|medium|high",
  "language": "detected language code"
}
''';
      
      final messages = [
        {'role': 'system', 'content': systemPrompt},
        {'role': 'user', 'content': message},
      ];
      
      final response = await _dio.post(
        'openai/deployments/$_deploymentName/chat/completions',
        queryParameters: {'api-version': _apiVersion},
        data: {
          'messages': messages,
          'max_tokens': 400,
          'temperature': 0.2,
        },
      );
      
      final aiResponse = response.data['choices'][0]['message']['content'] as String;
      final analysisData = jsonDecode(aiResponse);
      
      return MessageAnalysis.fromJson(analysisData);
    } catch (e) {
      throw AiChatException('Failed to analyze message: $e');
    }
  }
  
  /// Build system prompt based on context
  String _buildSystemPrompt(User? user, Need? relatedNeed) {
    final buffer = StringBuffer();
    
    buffer.writeln('''
You are YOLO Assistant, an AI helper for the YOLO Need App community platform.
Your role is to help users with their needs, provide support, and guide them through the platform.

Core principles:
- Be helpful, empathetic, and encouraging
- Provide actionable advice and suggestions
- Connect users with appropriate resources
- Maintain a positive, supportive tone
- Respect user privacy and confidentiality
''');
    
    if (user != null) {
      buffer.writeln('''
User Context:
- Role: ${user.role.name}
- Level: ${user.level}
- Points: ${user.points}
''');
    }
    
    if (relatedNeed != null) {
      buffer.writeln('''
Related Need:
- Title: ${relatedNeed.title}
- Category: ${relatedNeed.category.name}
- Priority: ${relatedNeed.priority.name}
- Status: ${relatedNeed.status.name}
''');
    }
    
    return buffer.toString();
  }
  
  /// Build message history for context
  List<Map<String, String>> _buildMessageHistory(
    String systemPrompt,
    String userMessage,
    List<ChatMessage>? conversationHistory,
  ) {
    final messages = <Map<String, String>>[
      {'role': 'system', 'content': systemPrompt},
    ];
    
    // Add recent conversation history (last 10 messages)
    if (conversationHistory != null && conversationHistory.isNotEmpty) {
      final recentMessages = conversationHistory.take(10).toList();
      
      for (final msg in recentMessages.reversed) {
        final role = msg.isAiGenerated ? 'assistant' : 'user';
        messages.add({
          'role': role,
          'content': msg.content,
        });
      }
    }
    
    // Add current user message
    messages.add({'role': 'user', 'content': userMessage});
    
    return messages;
  }
  
  /// Build contextual help prompt
  String _buildContextualHelpPrompt(
    String scenario,
    User user,
    Need? need,
    Map<String, dynamic>? context,
  ) {
    return '''
You are providing contextual help for a YOLO Need App user.

Scenario: $scenario
User Role: ${user.role.name}
User Level: ${user.level}

${need != null ? 'Related Need: ${need.title} (${need.category.name})' : ''}
${context != null ? 'Additional Context: ${jsonEncode(context)}' : ''}

Provide specific, actionable help for this scenario. Include:
- Step-by-step guidance
- Relevant features to use
- Best practices
- Common pitfalls to avoid
- Next recommended actions
''';
  }
  
  /// Calculate confidence score from AI response
  double _calculateConfidence(Map<String, dynamic> choice) {
    // This is a simplified confidence calculation
    // In practice, you might use more sophisticated methods
    final finishReason = choice['finish_reason'];
    if (finishReason == 'stop') return 0.9;
    if (finishReason == 'length') return 0.7;
    return 0.5;
  }
  
  /// Extract suggestions from AI response
  List<String> _extractSuggestions(String aiMessage) {
    // Simple pattern matching for suggestions
    final suggestionPattern = RegExp(r'(?:suggest|recommend|try|consider):\s*(.+?)(?:\n|$)', caseSensitive: false);
    final matches = suggestionPattern.allMatches(aiMessage);
    
    return matches.map((match) => match.group(1)?.trim() ?? '').where((s) => s.isNotEmpty).toList();
  }
  
  /// Extract actionable items from AI response
  List<String> _extractActions(String aiMessage, Need? relatedNeed) {
    final actions = <String>[];
    
    // Pattern matching for actions
    if (aiMessage.toLowerCase().contains('contact') && relatedNeed != null) {
      actions.add('contact_helper');
    }
    if (aiMessage.toLowerCase().contains('update')) {
      actions.add('update_need');
    }
    if (aiMessage.toLowerCase().contains('complete')) {
      actions.add('mark_complete');
    }
    
    return actions;
  }
  
  /// Parse suggestions from AI response text
  /// Convert structured answer to chat response format
  AiChatResponse _convertStructuredAnswerToResponse({
    required StructuredAnswer structuredAnswer,
    required String userMessage,
    required AiChatSession session,
  }) {
    // Build main message from structured answer
    final messageBuffer = StringBuffer();
    messageBuffer.writeln(structuredAnswer.mainAnswer);
    
    // Add key points if available
    if (structuredAnswer.keyPoints != null && structuredAnswer.keyPoints!.isNotEmpty) {
      messageBuffer.writeln('\n**Key Points:**');
      for (final point in structuredAnswer.keyPoints!) {
        messageBuffer.writeln('• $point');
      }
    }
    
    // Add action items if available
    if (structuredAnswer.actionItems != null && structuredAnswer.actionItems!.isNotEmpty) {
      messageBuffer.writeln('\n**Recommended Actions:**');
      for (final action in structuredAnswer.actionItems!) {
        messageBuffer.writeln('→ $action');
      }
    }
    
    // Extract suggestions from follow-up questions
    final suggestions = structuredAnswer.followUpQuestions ?? [];
    
    // Extract actions from reasoning paths
    final actions = <String>[];
    if (structuredAnswer.reasoningPaths != null) {
      for (final path in structuredAnswer.reasoningPaths!) {
        if (path.reasoning != null) {
          actions.add(path.reasoning!);
        }
      }
    }
    
    return AiChatResponse(
      message: messageBuffer.toString(),
      confidence: structuredAnswer.confidence,
      tokensUsed: 0, // Would be calculated from actual API usage
      model: 'graph-rag-enhanced-$_deploymentName',
      finishReason: 'stop',
      suggestions: suggestions,
      actions: actions,
      metadata: {
        'answer_type': structuredAnswer.answerType.name,
        'reasoning_confidence': structuredAnswer.reasoningResult?.confidence ?? 0.0,
        'sources_count': structuredAnswer.sources?.length ?? 0,
        'processing_metadata': structuredAnswer.generationMetadata ?? {},
      },
    );
  }
  
  /// Store interaction for machine learning and analytics
  Future<void> _storeInteractionForLearning({
    required String userMessage,
    required AiChatResponse response,
    required StructuredAnswer structuredAnswer,
    required AiChatSession session,
  }) async {
    try {
      final interaction = {
        'session_id': session.id,
        'user_id': session.userId,
        'user_message': userMessage,
        'ai_response': response.message,
        'confidence': response.confidence,
        'answer_type': structuredAnswer.answerType.name,
        'reasoning_confidence': structuredAnswer.reasoningResult?.confidence ?? 0.0,
        'sources_used': structuredAnswer.sources?.map((s) => s.toJson()).toList() ?? [],
        'reasoning_paths': structuredAnswer.reasoningPaths?.map((p) => p.toJson()).toList() ?? [],
        'timestamp': DateTime.now().toIso8601String(),
        'metadata': structuredAnswer.generationMetadata ?? {},
      };
      
      await _cosmosService.createItem(
        containerName: 'chat_interactions',
        item: interaction,
      );
    } catch (e) {
      print('Warning: Failed to store interaction for learning: $e');
    }
  }
  
  /// Enable or disable RAG pipeline
  void setRagEnabled(bool enabled) {
    _ragEnabled = enabled;
  }
  
  /// Check if RAG pipeline is enabled
  bool get isRagEnabled => _ragEnabled;
  
  /// Get RAG pipeline status
  Map<String, dynamic> getRagStatus() {
    return {
      'rag_enabled': _ragEnabled,
      'initialized': _isInitialized,
      'components': {
        'embeddings_service': _ragEnabled ? 'available' : 'disabled',
        'vector_database': _ragEnabled ? 'available' : 'disabled',
        'ai_foundry': _ragEnabled ? 'available' : 'disabled',
        'graph_rag': _ragEnabled ? 'available' : 'disabled',
      },
    };
  }
  
  /// Process and index new content for RAG
  Future<void> indexContentForRag({
    required String content,
    required String contentId,
    required DocumentType contentType,
    required NeedCategory category,
    String? title,
    String? summary,
    List<String>? keywords,
    Map<String, dynamic>? metadata,
  }) async {
    if (!_ragEnabled || !_isInitialized) {
      throw AiChatException('RAG pipeline not enabled or initialized');
    }
    
    try {
      // Process content through embeddings service
      final vectorDocument = await _embeddingsService.processDocument(
        content: content,
        id: contentId,
        type: contentType,
        source: 'yolo_chat_system',
        category: category,
        title: title,
        summary: summary,
        keywords: keywords,
        metadata: metadata,
      );
      
      // Store in vector database
      await _vectorService.storeVectorDocument(vectorDocument);
      
      // Update knowledge graph
      await _graphRagService.updateKnowledgeGraph(
        graphId: 'main_knowledge_graph',
        newDocument: vectorDocument,
      );
      
      print('Successfully indexed content: $contentId for RAG');
    } catch (e) {
      throw AiChatException('Failed to index content for RAG: $e');
    }
  }
  
  /// Perform semantic search across indexed content
  Future<SemanticSearchResult> semanticSearch({
    required String query,
    required String userId,
    int maxResults = 10,
    double similarityThreshold = 0.7,
    List<DocumentType>? documentTypes,
    List<NeedCategory>? categories,
  }) async {
    if (!_ragEnabled || !_isInitialized) {
      throw AiChatException('RAG pipeline not enabled or initialized');
    }
    
    try {
      final semanticQuery = SemanticQuery(
        id: 'search_${DateTime.now().millisecondsSinceEpoch}',
        query: query,
        userId: userId,
        maxResults: maxResults,
        similarityThreshold: similarityThreshold,
        documentTypes: documentTypes,
        categories: categories,
        createdAt: DateTime.now(),
      );
      
      return await _vectorService.semanticSearch(semanticQuery);
    } catch (e) {
      throw AiChatException('Failed to perform semantic search: $e');
    }
  }

  List<String> _parseSuggestions(String aiResponse) {
    final lines = aiResponse.split('\n');
    final suggestions = <String>[];
    
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isNotEmpty && 
          (trimmed.startsWith('-') || 
           trimmed.startsWith('•') || 
           trimmed.startsWith('*') ||
           RegExp(r'^\d+\.').hasMatch(trimmed))) {
        suggestions.add(trimmed.replaceAll(RegExp(r'^[-•*\d\.\s]+'), ''));
      }
    }
    
    return suggestions.take(5).toList();
  }
}

/// AI Chat Response model
class AiChatResponse {
  final String message;
  final double confidence;
  final int tokensUsed;
  final String model;
  final String finishReason;
  final List<String> suggestions;
  final List<String> actions;
  
  AiChatResponse({
    required this.message,
    required this.confidence,
    required this.tokensUsed,
    required this.model,
    required this.finishReason,
    required this.suggestions,
    required this.actions,
  });
}

/// Sentiment Analysis model
class SentimentAnalysis {
  final String sentiment;
  final double score;
  final List<String> emotions;
  final String urgency;
  final List<String> keywords;
  
  SentimentAnalysis({
    required this.sentiment,
    required this.score,
    required this.emotions,
    required this.urgency,
    required this.keywords,
  });
  
  factory SentimentAnalysis.fromJson(Map<String, dynamic> json) {
    return SentimentAnalysis(
      sentiment: json['sentiment'],
      score: json['score'].toDouble(),
      emotions: List<String>.from(json['emotions']),
      urgency: json['urgency'],
      keywords: List<String>.from(json['keywords']),
    );
  }
}

/// Content Moderation Result model
class ContentModerationResult {
  final bool flagged;
  final Map<String, bool> categories;
  final Map<String, double> categoryScores;
  
  ContentModerationResult({
    required this.flagged,
    required this.categories,
    required this.categoryScores,
  });
}

/// Message Analysis model
class MessageAnalysis {
  final String intent;
  final List<String> entities;
  final List<String> keywords;
  final String urgency;
  final String category;
  final bool actionRequired;
  final String priority;
  final String language;
  
  MessageAnalysis({
    required this.intent,
    required this.entities,
    required this.keywords,
    required this.urgency,
    required this.category,
    required this.actionRequired,
    required this.priority,
    required this.language,
  });
  
  factory MessageAnalysis.fromJson(Map<String, dynamic> json) {
    return MessageAnalysis(
      intent: json['intent'],
      entities: List<String>.from(json['entities']),
      keywords: List<String>.from(json['keywords']),
      urgency: json['urgency'],
      category: json['category'],
      actionRequired: json['actionRequired'],
      priority: json['priority'],
      language: json['language'],
    );
  }
}

/// Custom exception for AI chat errors
class AiChatException implements Exception {
  final String message;
  
  const AiChatException(this.message);
  
  @override
  String toString() => 'AiChatException: $message';
} 