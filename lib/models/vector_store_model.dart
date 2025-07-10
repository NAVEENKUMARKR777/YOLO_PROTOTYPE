import 'dart:math' as math;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:vector_math/vector_math.dart';
import 'enums.dart';

part 'vector_store_model.freezed.dart';
part 'vector_store_model.g.dart';

/// Embedding model for vector representations
@freezed
class DocumentEmbedding with _$DocumentEmbedding {
  const factory DocumentEmbedding({
    required String id,
    required String documentId,
    required List<double> embedding,
    required int dimensions,
    required String model,
    
    // Document metadata
    required String documentType,
    String? title,
    String? summary,
    Map<String, dynamic>? metadata,
    
    // Vector properties
    @Default(0.0) double magnitude,
    @Default([]) List<String> tags,
    
    // Quality metrics
    double? confidence,
    double? relevanceScore,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DocumentEmbedding;

  factory DocumentEmbedding.fromJson(Map<String, dynamic> json) => 
      _$DocumentEmbeddingFromJson(json);
}

/// Document model for vector storage
@freezed
class VectorDocument with _$VectorDocument {
  const factory VectorDocument({
    required String id,
    required String content,
    required DocumentType type,
    required String source,
    
    // Content structure
    String? title,
    String? summary,
    List<String>? chunks,
    Map<String, dynamic>? structuredData,
    
    // Classification
    required NeedCategory category,
    List<String>? subcategories,
    List<String>? keywords,
    
    // Processing status
    @Default(ProcessingStatus.pending) ProcessingStatus status,
    String? processingError,
    
    // Vector metadata
    DocumentEmbedding? embedding,
    @Default([]) List<String> relatedDocuments,
    
    // Quality metrics
    double? relevanceScore,
    double? qualityScore,
    int? viewCount,
    int? helpfulCount,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastAccessed,
  }) = _VectorDocument;

  factory VectorDocument.fromJson(Map<String, dynamic> json) => 
      _$VectorDocumentFromJson(json);
}

/// Semantic search query model
@freezed
class SemanticQuery with _$SemanticQuery {
  const factory SemanticQuery({
    required String id,
    required String query,
    required String userId,
    
    // Query parameters
    @Default(10) int maxResults,
    @Default(0.7) double similarityThreshold,
    List<DocumentType>? documentTypes,
    List<NeedCategory>? categories,
    Map<String, dynamic>? filters,
    
    // Query processing
    List<double>? queryEmbedding,
    List<String>? expandedTerms,
    String? intent,
    
    // Context
    String? sessionId,
    String? needId,
    Map<String, dynamic>? context,
    
    // Timestamps
    DateTime? createdAt,
  }) = _SemanticQuery;

  factory SemanticQuery.fromJson(Map<String, dynamic> json) => 
      _$SemanticQueryFromJson(json);
}

/// Search result model
@freezed
class SemanticSearchResult with _$SemanticSearchResult {
  const factory SemanticSearchResult({
    required String id,
    required String queryId,
    required List<SearchResultItem> results,
    
    // Search metadata
    required int totalResults,
    required Duration searchTime,
    String? searchStrategy,
    
    // Quality metrics
    double? averageRelevance,
    double? coverageScore,
    bool? wasHelpful,
    
    // User feedback
    String? userFeedback,
    int? rating,
    
    // Timestamps
    DateTime? createdAt,
  }) = _SemanticSearchResult;

  factory SemanticSearchResult.fromJson(Map<String, dynamic> json) => 
      _$SemanticSearchResultFromJson(json);
}

/// Individual search result item
@freezed
class SearchResultItem with _$SearchResultItem {
  const factory SearchResultItem({
    required String documentId,
    required VectorDocument document,
    required double similarityScore,
    required double relevanceScore,
    
    // Matching details
    List<String>? matchingChunks,
    Map<String, dynamic>? highlights,
    String? explanation,
    
    // Additional metrics
    double? qualityScore,
    double? recencyScore,
    double? popularityScore,
    double? finalScore,
    
    // Ranking info
    int? rank,
    String? rankingReason,
  }) = _SearchResultItem;

  factory SearchResultItem.fromJson(Map<String, dynamic> json) => 
      _$SearchResultItemFromJson(json);
}

/// Vector index for efficient similarity search
@freezed
class VectorIndex with _$VectorIndex {
  const factory VectorIndex({
    required String id,
    required String name,
    required int dimensions,
    required String distanceMetric,
    
    // Index configuration
    required IndexType indexType,
    Map<String, dynamic>? configuration,
    
    // Index statistics
    @Default(0) int documentCount,
    @Default(0) int embeddingCount,
    double? averageDocumentLength,
    
    // Performance metrics
    Duration? averageQueryTime,
    double? accuracy,
    double? recall,
    
    // Status
    @Default(IndexStatus.building) IndexStatus status,
    double? buildProgress,
    String? statusMessage,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastRebuild,
  }) = _VectorIndex;

  factory VectorIndex.fromJson(Map<String, dynamic> json) => 
      _$VectorIndexFromJson(json);
}

/// Chunk model for document segmentation
@freezed
class DocumentChunk with _$DocumentChunk {
  const factory DocumentChunk({
    required String id,
    required String documentId,
    required String content,
    required int chunkIndex,
    
    // Chunk metadata
    int? startPosition,
    int? endPosition,
    int? wordCount,
    int? characterCount,
    
    // Processing
    DocumentEmbedding? embedding,
    List<String>? keywords,
    String? summary,
    
    // Relationships
    String? previousChunkId,
    String? nextChunkId,
    List<String>? relatedChunks,
    
    // Quality metrics
    double? coherenceScore,
    double? informationDensity,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DocumentChunk;

  factory DocumentChunk.fromJson(Map<String, dynamic> json) => 
      _$DocumentChunkFromJson(json);
}

/// Enums for vector store
enum DocumentType {
  @JsonValue('need')
  need,
  @JsonValue('solution')
  solution,
  @JsonValue('knowledge_base')
  knowledgeBase,
  @JsonValue('community_post')
  communityPost,
  @JsonValue('faq')
  faq,
  @JsonValue('guide')
  guide,
  @JsonValue('tutorial')
  tutorial,
  @JsonValue('policy')
  policy,
  @JsonValue('announcement')
  announcement,
  @JsonValue('user_content')
  userContent,
}

enum ProcessingStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('failed')
  failed,
  @JsonValue('needs_review')
  needsReview,
}

enum IndexType {
  @JsonValue('flat')
  flat,
  @JsonValue('ivf')
  ivf,
  @JsonValue('hnsw')
  hnsw,
  @JsonValue('lsh')
  lsh,
}

enum IndexStatus {
  @JsonValue('building')
  building,
  @JsonValue('ready')
  ready,
  @JsonValue('updating')
  updating,
  @JsonValue('error')
  error,
  @JsonValue('outdated')
  outdated,
}

/// Similarity metrics enum
enum SimilarityMetric {
  @JsonValue('cosine')
  cosine,
  @JsonValue('euclidean')
  euclidean,
  @JsonValue('manhattan')
  manhattan,
  @JsonValue('dot_product')
  dotProduct,
}

/// Vector operations utility class
class VectorOperations {
  /// Calculate cosine similarity between two vectors
  static double cosineSimilarity(List<double> a, List<double> b) {
    if (a.length != b.length) {
      throw ArgumentError('Vectors must have the same length');
    }
    
    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;
    
    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    
    if (normA == 0.0 || normB == 0.0) {
      return 0.0;
    }
    
    return dotProduct / (math.sqrt(normA) * math.sqrt(normB));
  }
  
  /// Calculate euclidean distance between two vectors
  static double euclideanDistance(List<double> a, List<double> b) {
    if (a.length != b.length) {
      throw ArgumentError('Vectors must have the same length');
    }
    
    double sum = 0.0;
    for (int i = 0; i < a.length; i++) {
      double diff = a[i] - b[i];
      sum += diff * diff;
    }
    
    return math.sqrt(sum);
  }
  
  /// Normalize vector to unit length
  static List<double> normalize(List<double> vector) {
    double norm = 0.0;
    for (double value in vector) {
      norm += value * value;
    }
    norm = math.sqrt(norm);
    
    if (norm == 0.0) {
      return vector;
    }
    
    return vector.map((value) => value / norm).toList();
  }
  
  /// Calculate magnitude of vector
  static double magnitude(List<double> vector) {
    double sum = 0.0;
    for (double value in vector) {
      sum += value * value;
    }
    return math.sqrt(sum);
  }
} 