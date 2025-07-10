import 'dart:math' as math;
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphs/graphs.dart';
import 'vector_store_model.dart';
import 'enums.dart';

part 'graph_rag_model.freezed.dart';
part 'graph_rag_model.g.dart';

/// Knowledge Graph Node representing entities in the system
@freezed
class KnowledgeNode with _$KnowledgeNode {
  const factory KnowledgeNode({
    required String id,
    required String label,
    required NodeType type,
    required Map<String, dynamic> properties,
    
    // Content and semantics
    String? description,
    List<String>? aliases,
    List<String>? keywords,
    DocumentEmbedding? embedding,
    
    // Graph relationships
    @Default([]) List<String> incomingEdges,
    @Default([]) List<String> outgoingEdges,
    
    // Metrics and scoring
    @Default(0.0) double centrality,
    @Default(0.0) double pageRank,
    @Default(0) int degree,
    @Default(0.0) double relevanceScore,
    
    // Temporal aspects
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastAccessed,
    
    // Source and provenance
    String? sourceDocument,
    String? sourceType,
    Map<String, dynamic>? metadata,
  }) = _KnowledgeNode;

  factory KnowledgeNode.fromJson(Map<String, dynamic> json) => 
      _$KnowledgeNodeFromJson(json);
}

/// Knowledge Graph Edge representing relationships
@freezed
class KnowledgeEdge with _$KnowledgeEdge {
  const factory KnowledgeEdge({
    required String id,
    required String sourceNodeId,
    required String targetNodeId,
    required EdgeType relationshipType,
    
    // Relationship properties
    String? label,
    String? description,
    @Default(1.0) double weight,
    @Default(1.0) double confidence,
    
    // Semantic properties
    List<String>? properties,
    Map<String, dynamic>? attributes,
    
    // Temporal aspects
    DateTime? createdAt,
    DateTime? validFrom,
    DateTime? validTo,
    
    // Source and provenance
    String? sourceDocument,
    List<String>? evidence,
    Map<String, dynamic>? metadata,
  }) = _KnowledgeEdge;

  factory KnowledgeEdge.fromJson(Map<String, dynamic> json) => 
      _$KnowledgeEdgeFromJson(json);
}

/// Complete Knowledge Graph structure
@freezed
class KnowledgeGraph with _$KnowledgeGraph {
  const factory KnowledgeGraph({
    required String id,
    required String name,
    required Map<String, KnowledgeNode> nodes,
    required Map<String, KnowledgeEdge> edges,
    
    // Graph metadata
    String? description,
    String? domain,
    @Default([]) List<String> categories,
    
    // Graph statistics
    @Default(0) int nodeCount,
    @Default(0) int edgeCount,
    @Default(0.0) double density,
    @Default(0.0) double averageClusteringCoefficient,
    
    // Graph indices for fast lookup
    Map<NodeType, List<String>>? nodesByType,
    Map<String, List<String>>? nodesByCategory,
    Map<EdgeType, List<String>>? edgesByType,
    
    // Version and synchronization
    @Default(1) int version,
    DateTime? lastUpdated,
    DateTime? createdAt,
  }) = _KnowledgeGraph;

  factory KnowledgeGraph.fromJson(Map<String, dynamic> json) => 
      _$KnowledgeGraphFromJson(json);
}

/// Reasoning Path through the knowledge graph
@freezed
class ReasoningPath with _$ReasoningPath {
  const factory ReasoningPath({
    required String id,
    required List<String> nodeIds,
    required List<String> edgeIds,
    required String startNodeId,
    required String endNodeId,
    
    // Path properties
    @Default(0.0) double pathScore,
    @Default(0.0) double confidence,
    @Default(0) int pathLength,
    @Default(0.0) double semanticCoherence,
    
    // Path reasoning
    String? reasoning,
    List<String>? justifications,
    Map<String, dynamic>? evidence,
    
    // Path metadata
    ReasoningType? reasoningType,
    String? query,
    DateTime? createdAt,
  }) = _ReasoningPath;

  factory ReasoningPath.fromJson(Map<String, dynamic> json) => 
      _$ReasoningPathFromJson(json);
}

/// Graph-based reasoning result
@freezed
class GraphReasoningResult with _$GraphReasoningResult {
  const factory GraphReasoningResult({
    required String id,
    required String query,
    required List<ReasoningPath> paths,
    required List<KnowledgeNode> relevantNodes,
    required List<KnowledgeEdge> relevantEdges,
    
    // Reasoning outcome
    String? conclusion,
    @Default(0.0) double confidence,
    List<String>? supportingEvidence,
    List<String>? contradictingEvidence,
    
    // Reasoning metadata
    required ReasoningStrategy strategy,
    @Default(0) Duration reasoningTime,
    Map<String, dynamic>? intermediateSteps,
    
    // Quality metrics
    @Default(0.0) double coherenceScore,
    @Default(0.0) double completenessScore,
    @Default(0.0) double consistencyScore,
    
    DateTime? createdAt,
  }) = _GraphReasoningResult;

  factory GraphReasoningResult.fromJson(Map<String, dynamic> json) => 
      _$GraphReasoningResultFromJson(json);
}

/// Structured answer generated by Graph RAG
@freezed
class StructuredAnswer with _$StructuredAnswer {
  const factory StructuredAnswer({
    required String id,
    required String query,
    required String mainAnswer,
    
    // Answer structure
    List<AnswerSection>? sections,
    List<String>? keyPoints,
    List<String>? actionItems,
    Map<String, dynamic>? structuredData,
    
    // Supporting information
    List<SourceReference>? sources,
    List<RelatedConcept>? relatedConcepts,
    List<String>? followUpQuestions,
    
    // Confidence and quality
    @Default(0.0) double confidence,
    @Default(0.0) double completeness,
    @Default(0.0) double accuracy,
    
    // Graph reasoning context
    GraphReasoningResult? reasoningResult,
    List<ReasoningPath>? reasoningPaths,
    
    // Generation metadata
    required AnswerType answerType,
    Map<String, dynamic>? generationMetadata,
    DateTime? createdAt,
  }) = _StructuredAnswer;

  factory StructuredAnswer.fromJson(Map<String, dynamic> json) => 
      _$StructuredAnswerFromJson(json);
}

/// Section within a structured answer
@freezed
class AnswerSection with _$AnswerSection {
  const factory AnswerSection({
    required String id,
    required String title,
    required String content,
    required SectionType type,
    
    // Section properties
    @Default(0) int order,
    @Default(SectionImportance.medium) SectionImportance importance,
    List<String>? supportingEvidence,
    List<SourceReference>? sources,
    
    // Nested sections
    List<AnswerSection>? subsections,
    Map<String, dynamic>? metadata,
  }) = _AnswerSection;

  factory AnswerSection.fromJson(Map<String, dynamic> json) => 
      _$AnswerSectionFromJson(json);
}

/// Source reference for answer attribution
@freezed
class SourceReference with _$SourceReference {
  const factory SourceReference({
    required String id,
    required String documentId,
    required String title,
    required SourceType type,
    
    // Reference details
    String? excerpt,
    String? url,
    @Default(0.0) double relevanceScore,
    @Default(0.0) double credibilityScore,
    
    // Citation information
    String? author,
    DateTime? publishedDate,
    String? publisher,
    Map<String, dynamic>? metadata,
  }) = _SourceReference;

  factory SourceReference.fromJson(Map<String, dynamic> json) => 
      _$SourceReferenceFromJson(json);
}

/// Related concept for answer enrichment
@freezed
class RelatedConcept with _$RelatedConcept {
  const factory RelatedConcept({
    required String id,
    required String name,
    required String description,
    @Default(0.0) double relationshipStrength,
    
    // Concept properties
    List<String>? keywords,
    String? category,
    Map<String, dynamic>? properties,
  }) = _RelatedConcept;

  factory RelatedConcept.fromJson(Map<String, dynamic> json) => 
      _$RelatedConceptFromJson(json);
}

/// Graph analysis metrics
@freezed
class GraphMetrics with _$GraphMetrics {
  const factory GraphMetrics({
    required String graphId,
    
    // Basic metrics
    @Default(0) int nodeCount,
    @Default(0) int edgeCount,
    @Default(0.0) double density,
    @Default(0.0) double averageDegree,
    
    // Centrality measures
    Map<String, double>? betweennessCentrality,
    Map<String, double>? closenessCentrality,
    Map<String, double>? eigenvectorCentrality,
    Map<String, double>? pageRankScores,
    
    // Clustering and community
    @Default(0.0) double clusteringCoefficient,
    @Default(0) int connectedComponents,
    List<List<String>>? communities,
    
    // Quality metrics
    @Default(0.0) double coherenceScore,
    @Default(0.0) double completenessScore,
    @Default(0.0) double consistencyScore,
    
    DateTime? computedAt,
  }) = _GraphMetrics;

  factory GraphMetrics.fromJson(Map<String, dynamic> json) => 
      _$GraphMetricsFromJson(json);
}

/// Enums for Graph RAG

enum NodeType {
  @JsonValue('entity')
  entity,
  @JsonValue('concept')
  concept,
  @JsonValue('event')
  event,
  @JsonValue('document')
  document,
  @JsonValue('user')
  user,
  @JsonValue('need')
  need,
  @JsonValue('solution')
  solution,
  @JsonValue('skill')
  skill,
  @JsonValue('topic')
  topic,
  @JsonValue('location')
  location,
}

enum EdgeType {
  @JsonValue('relates_to')
  relatesTo,
  @JsonValue('part_of')
  partOf,
  @JsonValue('causes')
  causes,
  @JsonValue('solves')
  solves,
  @JsonValue('requires')
  requires,
  @JsonValue('provides')
  provides,
  @JsonValue('similar_to')
  similarTo,
  @JsonValue('depends_on')
  dependsOn,
  @JsonValue('contains')
  contains,
  @JsonValue('mentions')
  mentions,
}

enum ReasoningType {
  @JsonValue('deductive')
  deductive,
  @JsonValue('inductive')
  inductive,
  @JsonValue('abductive')
  abductive,
  @JsonValue('analogical')
  analogical,
  @JsonValue('causal')
  causal,
}

enum ReasoningStrategy {
  @JsonValue('breadth_first')
  breadthFirst,
  @JsonValue('depth_first')
  depthFirst,
  @JsonValue('best_first')
  bestFirst,
  @JsonValue('a_star')
  aStar,
  @JsonValue('shortest_path')
  shortestPath,
  @JsonValue('max_flow')
  maxFlow,
}

enum AnswerType {
  @JsonValue('factual')
  factual,
  @JsonValue('procedural')
  procedural,
  @JsonValue('explanatory')
  explanatory,
  @JsonValue('comparative')
  comparative,
  @JsonValue('predictive')
  predictive,
  @JsonValue('recommendation')
  recommendation,
}

enum SectionType {
  @JsonValue('summary')
  summary,
  @JsonValue('details')
  details,
  @JsonValue('examples')
  examples,
  @JsonValue('steps')
  steps,
  @JsonValue('pros_cons')
  prosCons,
  @JsonValue('recommendations')
  recommendations,
}

enum SectionImportance {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

enum SourceType {
  @JsonValue('document')
  document,
  @JsonValue('web_page')
  webPage,
  @JsonValue('knowledge_base')
  knowledgeBase,
  @JsonValue('user_content')
  userContent,
  @JsonValue('expert_system')
  expertSystem,
}

/// Utility classes for Graph operations

class GraphOperations {
  /// Calculate graph density
  static double calculateDensity(int nodeCount, int edgeCount) {
    if (nodeCount <= 1) return 0.0;
    final maxEdges = nodeCount * (nodeCount - 1);
    return edgeCount / maxEdges;
  }
  
  /// Calculate node degree
  static int calculateDegree(KnowledgeNode node) {
    return node.incomingEdges.length + node.outgoingEdges.length;
  }
  
  /// Calculate average clustering coefficient
  static double calculateClusteringCoefficient(
    KnowledgeGraph graph,
    String nodeId,
  ) {
    final node = graph.nodes[nodeId];
    if (node == null) return 0.0;
    
    final neighbors = _getNeighbors(graph, nodeId);
    if (neighbors.length < 2) return 0.0;
    
    int triangles = 0;
    final possibleTriangles = neighbors.length * (neighbors.length - 1) ~/ 2;
    
    for (int i = 0; i < neighbors.length; i++) {
      for (int j = i + 1; j < neighbors.length; j++) {
        if (_areConnected(graph, neighbors[i], neighbors[j])) {
          triangles++;
        }
      }
    }
    
    return possibleTriangles > 0 ? triangles / possibleTriangles : 0.0;
  }
  
  /// Find shortest path between two nodes
  static List<String>? findShortestPath(
    KnowledgeGraph graph,
    String startNodeId,
    String endNodeId,
  ) {
    final visited = <String>{};
    final queue = <List<String>>[];
    
    queue.add([startNodeId]);
    visited.add(startNodeId);
    
    while (queue.isNotEmpty) {
      final path = queue.removeAt(0);
      final currentNode = path.last;
      
      if (currentNode == endNodeId) {
        return path;
      }
      
      final neighbors = _getNeighbors(graph, currentNode);
      for (final neighbor in neighbors) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          queue.add([...path, neighbor]);
        }
      }
    }
    
    return null; // No path found
  }
  
  /// Calculate PageRank scores for all nodes
  static Map<String, double> calculatePageRank(
    KnowledgeGraph graph, {
    double dampingFactor = 0.85,
    int maxIterations = 100,
    double tolerance = 1e-6,
  }) {
    final nodes = graph.nodes.keys.toList();
    final nodeCount = nodes.length;
    
    if (nodeCount == 0) return {};
    
    // Initialize PageRank scores
    var pageRank = <String, double>{};
    var newPageRank = <String, double>{};
    
    for (final node in nodes) {
      pageRank[node] = 1.0 / nodeCount;
    }
    
    // Iterate until convergence
    for (int iteration = 0; iteration < maxIterations; iteration++) {
      for (final node in nodes) {
        newPageRank[node] = (1.0 - dampingFactor) / nodeCount;
      }
      
      for (final node in nodes) {
        final outgoingEdges = graph.nodes[node]?.outgoingEdges ?? [];
        final outDegree = outgoingEdges.length;
        
        if (outDegree > 0) {
          final contribution = dampingFactor * pageRank[node]! / outDegree;
          
          for (final edgeId in outgoingEdges) {
            final edge = graph.edges[edgeId];
            if (edge != null) {
              newPageRank[edge.targetNodeId] = 
                  (newPageRank[edge.targetNodeId] ?? 0.0) + contribution;
            }
          }
        }
      }
      
      // Check convergence
      double diff = 0.0;
      for (final node in nodes) {
        diff += (newPageRank[node]! - pageRank[node]!).abs();
      }
      
      pageRank = Map.from(newPageRank);
      
      if (diff < tolerance) {
        break;
      }
    }
    
    return pageRank;
  }
  
  // Helper methods
  
  static List<String> _getNeighbors(KnowledgeGraph graph, String nodeId) {
    final node = graph.nodes[nodeId];
    if (node == null) return [];
    
    final neighbors = <String>{};
    
    // Add neighbors from outgoing edges
    for (final edgeId in node.outgoingEdges) {
      final edge = graph.edges[edgeId];
      if (edge != null) {
        neighbors.add(edge.targetNodeId);
      }
    }
    
    // Add neighbors from incoming edges
    for (final edgeId in node.incomingEdges) {
      final edge = graph.edges[edgeId];
      if (edge != null) {
        neighbors.add(edge.sourceNodeId);
      }
    }
    
    return neighbors.toList();
  }
  
  static bool _areConnected(KnowledgeGraph graph, String nodeId1, String nodeId2) {
    final node1 = graph.nodes[nodeId1];
    if (node1 == null) return false;
    
    // Check outgoing edges
    for (final edgeId in node1.outgoingEdges) {
      final edge = graph.edges[edgeId];
      if (edge?.targetNodeId == nodeId2) {
        return true;
      }
    }
    
    // Check incoming edges
    for (final edgeId in node1.incomingEdges) {
      final edge = graph.edges[edgeId];
      if (edge?.sourceNodeId == nodeId2) {
        return true;
      }
    }
    
    return false;
  }
} 