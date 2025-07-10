import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/vector_store_model.dart';
import '../models/graph_rag_model.dart';
import '../models/need_model.dart';
import '../models/user_model.dart';
import '../models/enums.dart';
import '../services/azure/azure_embeddings.dart';
import '../services/azure/azure_vector_database.dart';
import '../services/azure/azure_ai_foundry.dart';
import '../services/azure/azure_graph_rag.dart';
import '../services/azure/azure_ai_chat.dart';
import '../services/azure/azure_cosmos.dart';
import 'auth_provider.dart';

part 'rag_provider.freezed.dart';

// =============================================================================
// RAG Service Providers
// =============================================================================

/// Azure Cosmos Service Provider
final cosmosServiceProvider = Provider<AzureCosmosService>((ref) {
  return AzureCosmosService();
});

/// Azure Embeddings Service Provider
final embeddingsServiceProvider = Provider<AzureEmbeddingsService>((ref) {
  return AzureEmbeddingsService();
});

/// Azure Vector Database Service Provider
final vectorDatabaseServiceProvider = Provider<AzureVectorDatabaseService>((ref) {
  final embeddingsService = ref.watch(embeddingsServiceProvider);
  final cosmosService = ref.watch(cosmosServiceProvider);
  
  return AzureVectorDatabaseService(
    embeddingsService: embeddingsService,
    cosmosService: cosmosService,
  );
});

/// Azure AI Foundry Service Provider
final aiFoundryServiceProvider = Provider<AzureAiFoundryService>((ref) {
  final vectorService = ref.watch(vectorDatabaseServiceProvider);
  
  return AzureAiFoundryService(
    vectorService: vectorService,
  );
});

/// Azure Graph RAG Service Provider
final graphRagServiceProvider = Provider<AzureGraphRagService>((ref) {
  final aiFoundryService = ref.watch(aiFoundryServiceProvider);
  final cosmosService = ref.watch(cosmosServiceProvider);
  
  return AzureGraphRagService(
    aiFoundryService: aiFoundryService,
    cosmosService: cosmosService,
  );
});

/// Enhanced AI Chat Service Provider (with RAG)
final ragEnabledChatServiceProvider = Provider<AzureAiChatService>((ref) {
  return AzureAiChatService();
});

// =============================================================================
// RAG State Providers
// =============================================================================

/// RAG System State
@freezed
class RagSystemState with _$RagSystemState {
  const factory RagSystemState({
    @Default(false) bool isInitialized,
    @Default(true) bool isEnabled,
    @Default(RagStatus.initializing) RagStatus status,
    String? error,
    Map<String, dynamic>? systemMetrics,
    DateTime? lastUpdated,
  }) = _RagSystemState;
}

enum RagStatus {
  initializing,
  ready,
  processing,
  error,
  disabled,
}

/// RAG System State Notifier
class RagSystemNotifier extends StateNotifier<RagSystemState> {
  final AzureEmbeddingsService _embeddingsService;
  final AzureVectorDatabaseService _vectorService;
  final AzureAiFoundryService _aiFoundryService;
  final AzureGraphRagService _graphRagService;
  final AzureAiChatService _chatService;
  
  RagSystemNotifier({
    required AzureEmbeddingsService embeddingsService,
    required AzureVectorDatabaseService vectorService,
    required AzureAiFoundryService aiFoundryService,
    required AzureGraphRagService graphRagService,
    required AzureAiChatService chatService,
  }) : _embeddingsService = embeddingsService,
       _vectorService = vectorService,
       _aiFoundryService = aiFoundryService,
       _graphRagService = graphRagService,
       _chatService = chatService,
       super(const RagSystemState());
  
  /// Initialize the RAG system
  Future<void> initialize() async {
    try {
      state = state.copyWith(status: RagStatus.initializing);
      
      // Initialize services in order
      await _embeddingsService.initialize();
      await _vectorService.initialize();
      await _aiFoundryService.initialize();
      await _graphRagService.initialize();
      await _chatService.initialize();
      
      // Get system metrics
      final metrics = await _getSystemMetrics();
      
      state = state.copyWith(
        isInitialized: true,
        status: RagStatus.ready,
        systemMetrics: metrics,
        lastUpdated: DateTime.now(),
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        status: RagStatus.error,
        error: e.toString(),
        lastUpdated: DateTime.now(),
      );
    }
  }
  
  /// Enable or disable RAG system
  void setEnabled(bool enabled) {
    _chatService.setRagEnabled(enabled);
    state = state.copyWith(
      isEnabled: enabled,
      status: enabled ? RagStatus.ready : RagStatus.disabled,
      lastUpdated: DateTime.now(),
    );
  }
  
  /// Get system metrics
  Future<Map<String, dynamic>> _getSystemMetrics() async {
    try {
      final chatStatus = _chatService.getRagStatus();
      final vectorIndices = _vectorService.getAvailableIndices();
      
      return {
        'chat_service': chatStatus,
        'vector_indices_count': vectorIndices.length,
        'available_indices': vectorIndices.map((i) => i.name).toList(),
        'system_health': 'healthy',
        'last_check': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      return {
        'system_health': 'error',
        'error': e.toString(),
        'last_check': DateTime.now().toIso8601String(),
      };
    }
  }
  
  /// Refresh system metrics
  Future<void> refreshMetrics() async {
    try {
      final metrics = await _getSystemMetrics();
      state = state.copyWith(
        systemMetrics: metrics,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        lastUpdated: DateTime.now(),
      );
    }
  }
}

/// RAG System State Provider
final ragSystemProvider = StateNotifierProvider<RagSystemNotifier, RagSystemState>((ref) {
  final embeddingsService = ref.watch(embeddingsServiceProvider);
  final vectorService = ref.watch(vectorDatabaseServiceProvider);
  final aiFoundryService = ref.watch(aiFoundryServiceProvider);
  final graphRagService = ref.watch(graphRagServiceProvider);
  final chatService = ref.watch(ragEnabledChatServiceProvider);
  
  return RagSystemNotifier(
    embeddingsService: embeddingsService,
    vectorService: vectorService,
    aiFoundryService: aiFoundryService,
    graphRagService: graphRagService,
    chatService: chatService,
  );
});

// =============================================================================
// Vector Store State Providers
// =============================================================================

/// Vector Documents State
@freezed
class VectorDocumentsState with _$VectorDocumentsState {
  const factory VectorDocumentsState({
    @Default([]) List<VectorDocument> documents,
    @Default(false) bool isLoading,
    String? error,
    int? totalCount,
    DateTime? lastUpdated,
  }) = _VectorDocumentsState;
}

/// Vector Documents Notifier
class VectorDocumentsNotifier extends StateNotifier<VectorDocumentsState> {
  final AzureVectorDatabaseService _vectorService;
  
  VectorDocumentsNotifier(this._vectorService) : super(const VectorDocumentsState());
  
  /// Load documents by category
  Future<void> loadDocuments({
    NeedCategory? category,
    DocumentType? type,
    int limit = 50,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      // This would be implemented based on your vector service query capabilities
      // For now, we'll simulate loading
      await Future.delayed(const Duration(milliseconds: 500));
      
      state = state.copyWith(
        documents: [], // Would be populated from actual query
        isLoading: false,
        totalCount: 0,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        lastUpdated: DateTime.now(),
      );
    }
  }
  
  /// Add a new document
  Future<void> addDocument(VectorDocument document) async {
    try {
      await _vectorService.storeVectorDocument(document);
      
      final updatedDocuments = [...state.documents, document];
      state = state.copyWith(
        documents: updatedDocuments,
        totalCount: updatedDocuments.length,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
  
  /// Remove a document
  Future<void> removeDocument(String documentId) async {
    try {
      await _vectorService.deleteVectorDocument(documentId);
      
      final updatedDocuments = state.documents
          .where((doc) => doc.id != documentId)
          .toList();
      
      state = state.copyWith(
        documents: updatedDocuments,
        totalCount: updatedDocuments.length,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}

/// Vector Documents Provider
final vectorDocumentsProvider = StateNotifierProvider<VectorDocumentsNotifier, VectorDocumentsState>((ref) {
  final vectorService = ref.watch(vectorDatabaseServiceProvider);
  return VectorDocumentsNotifier(vectorService);
});

// =============================================================================
// Semantic Search State Providers
// =============================================================================

/// Semantic Search State
@freezed
class SemanticSearchState with _$SemanticSearchState {
  const factory SemanticSearchState({
    SemanticSearchResult? currentResult,
    @Default([]) List<SemanticSearchResult> searchHistory,
    @Default(false) bool isSearching,
    String? error,
    DateTime? lastSearchTime,
  }) = _SemanticSearchState;
}

/// Semantic Search Notifier
class SemanticSearchNotifier extends StateNotifier<SemanticSearchState> {
  final AzureVectorDatabaseService _vectorService;
  
  SemanticSearchNotifier(this._vectorService) : super(const SemanticSearchState());
  
  /// Perform semantic search
  Future<void> search({
    required String query,
    required String userId,
    int maxResults = 10,
    double similarityThreshold = 0.7,
    List<DocumentType>? documentTypes,
    List<NeedCategory>? categories,
  }) async {
    try {
      state = state.copyWith(isSearching: true, error: null);
      
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
      
      final result = await _vectorService.semanticSearch(semanticQuery);
      
      final updatedHistory = [result, ...state.searchHistory].take(20).toList();
      
      state = state.copyWith(
        currentResult: result,
        searchHistory: updatedHistory,
        isSearching: false,
        lastSearchTime: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        error: e.toString(),
        lastSearchTime: DateTime.now(),
      );
    }
  }
  
  /// Clear search results
  void clearResults() {
    state = state.copyWith(
      currentResult: null,
      error: null,
    );
  }
  
  /// Clear search history
  void clearHistory() {
    state = state.copyWith(searchHistory: []);
  }
}

/// Semantic Search Provider
final semanticSearchProvider = StateNotifierProvider<SemanticSearchNotifier, SemanticSearchState>((ref) {
  final vectorService = ref.watch(vectorDatabaseServiceProvider);
  return SemanticSearchNotifier(vectorService);
});

// =============================================================================
// Knowledge Graph State Providers
// =============================================================================

/// Knowledge Graph State
@freezed
class KnowledgeGraphState with _$KnowledgeGraphState {
  const factory KnowledgeGraphState({
    @Default({}) Map<String, KnowledgeGraph> graphs,
    @Default({}) Map<String, GraphMetrics> graphMetrics,
    @Default(false) bool isLoading,
    String? error,
    String? selectedGraphId,
    DateTime? lastUpdated,
  }) = _KnowledgeGraphState;
}

/// Knowledge Graph Notifier
class KnowledgeGraphNotifier extends StateNotifier<KnowledgeGraphState> {
  final AzureGraphRagService _graphRagService;
  
  KnowledgeGraphNotifier(this._graphRagService) : super(const KnowledgeGraphState());
  
  /// Load available knowledge graphs
  Future<void> loadGraphs() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      // This would load graphs from the service
      // For now, we'll simulate
      await Future.delayed(const Duration(milliseconds: 500));
      
      state = state.copyWith(
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        lastUpdated: DateTime.now(),
      );
    }
  }
  
  /// Build a new knowledge graph
  Future<void> buildGraph({
    required String graphId,
    required String name,
    required List<VectorDocument> documents,
    String? domain,
    List<String>? categories,
  }) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      
      final graph = await _graphRagService.buildKnowledgeGraph(
        graphId: graphId,
        name: name,
        documents: documents,
        domain: domain,
        categories: categories,
      );
      
      final updatedGraphs = {...state.graphs};
      updatedGraphs[graphId] = graph;
      
      state = state.copyWith(
        graphs: updatedGraphs,
        isLoading: false,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        lastUpdated: DateTime.now(),
      );
    }
  }
  
  /// Select a knowledge graph
  void selectGraph(String graphId) {
    state = state.copyWith(selectedGraphId: graphId);
  }
}

/// Knowledge Graph Provider
final knowledgeGraphProvider = StateNotifierProvider<KnowledgeGraphNotifier, KnowledgeGraphState>((ref) {
  final graphRagService = ref.watch(graphRagServiceProvider);
  return KnowledgeGraphNotifier(graphRagService);
});

// =============================================================================
// Structured Answers State Providers
// =============================================================================

/// Structured Answers State
@freezed
class StructuredAnswersState with _$StructuredAnswersState {
  const factory StructuredAnswersState({
    @Default([]) List<StructuredAnswer> answers,
    StructuredAnswer? currentAnswer,
    @Default(false) bool isGenerating,
    String? error,
    DateTime? lastGenerated,
  }) = _StructuredAnswersState;
}

/// Structured Answers Notifier
class StructuredAnswersNotifier extends StateNotifier<StructuredAnswersState> {
  final AzureGraphRagService _graphRagService;
  
  StructuredAnswersNotifier(this._graphRagService) : super(const StructuredAnswersState());
  
  /// Generate a structured answer
  Future<void> generateAnswer({
    required String query,
    required String userId,
    String? sessionId,
    String? needId,
    User? user,
    Need? relatedNeed,
    AnswerType? preferredAnswerType,
  }) async {
    try {
      state = state.copyWith(isGenerating: true, error: null);
      
      final answer = await _graphRagService.generateStructuredAnswer(
        query: query,
        userId: userId,
        sessionId: sessionId,
        needId: needId,
        user: user,
        relatedNeed: relatedNeed,
        preferredAnswerType: preferredAnswerType,
      );
      
      final updatedAnswers = [answer, ...state.answers].take(50).toList();
      
      state = state.copyWith(
        answers: updatedAnswers,
        currentAnswer: answer,
        isGenerating: false,
        lastGenerated: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isGenerating: false,
        error: e.toString(),
        lastGenerated: DateTime.now(),
      );
    }
  }
  
  /// Clear current answer
  void clearCurrentAnswer() {
    state = state.copyWith(currentAnswer: null);
  }
  
  /// Clear answer history
  void clearHistory() {
    state = state.copyWith(answers: []);
  }
}

/// Structured Answers Provider
final structuredAnswersProvider = StateNotifierProvider<StructuredAnswersNotifier, StructuredAnswersState>((ref) {
  final graphRagService = ref.watch(graphRagServiceProvider);
  return StructuredAnswersNotifier(graphRagService);
});

// =============================================================================
// Content Indexing State Providers
// =============================================================================

/// Content Indexing State
@freezed
class ContentIndexingState with _$ContentIndexingState {
  const factory ContentIndexingState({
    @Default([]) List<String> indexingQueue,
    @Default([]) List<String> indexedContent,
    @Default(false) bool isIndexing,
    String? currentlyIndexing,
    String? error,
    int? totalProcessed,
    DateTime? lastIndexed,
  }) = _ContentIndexingState;
}

/// Content Indexing Notifier
class ContentIndexingNotifier extends StateNotifier<ContentIndexingState> {
  final AzureAiChatService _chatService;
  
  ContentIndexingNotifier(this._chatService) : super(const ContentIndexingState());
  
  /// Add content to indexing queue
  void addToQueue(String contentId) {
    final updatedQueue = [...state.indexingQueue, contentId];
    state = state.copyWith(indexingQueue: updatedQueue);
  }
  
  /// Index content for RAG
  Future<void> indexContent({
    required String content,
    required String contentId,
    required DocumentType contentType,
    required NeedCategory category,
    String? title,
    String? summary,
    List<String>? keywords,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      state = state.copyWith(
        isIndexing: true,
        currentlyIndexing: contentId,
        error: null,
      );
      
      await _chatService.indexContentForRag(
        content: content,
        contentId: contentId,
        contentType: contentType,
        category: category,
        title: title,
        summary: summary,
        keywords: keywords,
        metadata: metadata,
      );
      
      final updatedIndexed = [...state.indexedContent, contentId];
      final updatedQueue = state.indexingQueue.where((id) => id != contentId).toList();
      
      state = state.copyWith(
        indexedContent: updatedIndexed,
        indexingQueue: updatedQueue,
        isIndexing: false,
        currentlyIndexing: null,
        totalProcessed: (state.totalProcessed ?? 0) + 1,
        lastIndexed: DateTime.now(),
      );
    } catch (e) {
      state = state.copyWith(
        isIndexing: false,
        currentlyIndexing: null,
        error: e.toString(),
        lastIndexed: DateTime.now(),
      );
    }
  }
  
  /// Process indexing queue
  Future<void> processQueue() async {
    if (state.isIndexing || state.indexingQueue.isEmpty) return;
    
    // This would process items in the queue
    // Implementation depends on how you want to handle batch processing
  }
}

/// Content Indexing Provider
final contentIndexingProvider = StateNotifierProvider<ContentIndexingNotifier, ContentIndexingState>((ref) {
  final chatService = ref.watch(ragEnabledChatServiceProvider);
  return ContentIndexingNotifier(chatService);
});

// =============================================================================
// Convenience Providers
// =============================================================================

/// RAG System Status Provider
final ragSystemStatusProvider = Provider<Map<String, dynamic>>((ref) {
  final ragState = ref.watch(ragSystemProvider);
  final vectorState = ref.watch(vectorDocumentsProvider);
  final searchState = ref.watch(semanticSearchProvider);
  final graphState = ref.watch(knowledgeGraphProvider);
  final answersState = ref.watch(structuredAnswersProvider);
  final indexingState = ref.watch(contentIndexingProvider);
  
  return {
    'system': {
      'initialized': ragState.isInitialized,
      'enabled': ragState.isEnabled,
      'status': ragState.status.name,
      'error': ragState.error,
    },
    'vector_store': {
      'documents_count': vectorState.documents.length,
      'loading': vectorState.isLoading,
    },
    'search': {
      'last_search': searchState.lastSearchTime?.toIso8601String(),
      'searching': searchState.isSearching,
      'history_count': searchState.searchHistory.length,
    },
    'knowledge_graphs': {
      'graphs_count': graphState.graphs.length,
      'selected': graphState.selectedGraphId,
      'loading': graphState.isLoading,
    },
    'answers': {
      'total_generated': answersState.answers.length,
      'generating': answersState.isGenerating,
      'last_generated': answersState.lastGenerated?.toIso8601String(),
    },
    'indexing': {
      'queue_size': indexingState.indexingQueue.length,
      'indexed_count': indexingState.indexedContent.length,
      'currently_indexing': indexingState.currentlyIndexing,
      'processing': indexingState.isIndexing,
    },
  };
});

/// RAG Initialization Provider
final ragInitializationProvider = FutureProvider<void>((ref) async {
  final ragNotifier = ref.read(ragSystemProvider.notifier);
  await ragNotifier.initialize();
}); 