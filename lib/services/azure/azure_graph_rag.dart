import 'dart:convert';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:graphs/graphs.dart';
import '../../models/graph_rag_model.dart';
import '../../models/vector_store_model.dart';
import '../../models/chat_model.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import 'azure_ai_foundry.dart';
import 'azure_cosmos.dart';

/// Graph RAG Service - Context Reasoning + Structured Answer Generation
class AzureGraphRagService {
  static const String _endpoint = 'https://YOUR_OPENAI_RESOURCE.openai.azure.com/';
  static const String _apiKey = 'YOUR_AZURE_OPENAI_API_KEY';
  static const String _apiVersion = '2023-12-01-preview';
  static const String _gpt4Deployment = 'gpt-4';
  
  final AzureAiFoundryService _aiFoundryService;
  final AzureCosmosService _cosmosService;
  final Dio _dio;
  final RetryOptions _retryOptions;
  
  // Knowledge graph storage
  final Map<String, KnowledgeGraph> _knowledgeGraphs = {};
  final Map<String, GraphMetrics> _graphMetrics = {};
  
  AzureGraphRagService({
    required AzureAiFoundryService aiFoundryService,
    required AzureCosmosService cosmosService,
    Dio? dio,
  }) : _aiFoundryService = aiFoundryService,
       _cosmosService = cosmosService,
       _dio = dio ?? Dio(),
       _retryOptions = const RetryOptions(
         maxAttempts: 3,
         delay: Duration(seconds: 1),
         delayFactor: Duration(seconds: 2),
       );
  
  /// Initialize the Graph RAG service
  Future<void> initialize() async {
    _dio.options.baseUrl = _endpoint;
    _dio.options.headers['api-key'] = _apiKey;
    _dio.options.headers['Content-Type'] = 'application/json';
    
    await _aiFoundryService.initialize();
    await _cosmosService.initialize();
    await _loadKnowledgeGraphs();
  }
  
  /// Main Graph RAG pipeline: Process query and generate structured answer
  Future<StructuredAnswer> generateStructuredAnswer({
    required String query,
    required String userId,
    String? sessionId,
    String? needId,
    List<ChatMessage>? conversationHistory,
    User? user,
    Need? relatedNeed,
    AnswerType? preferredAnswerType,
    Map<String, dynamic>? additionalContext,
  }) async {
    try {
      final startTime = DateTime.now();
      
      // Step 1: Process query through AI Foundry (middle layer)
      final enrichedQuery = await _aiFoundryService.processQuery(
        query: query,
        userId: userId,
        sessionId: sessionId,
        needId: needId,
        conversationHistory: conversationHistory,
        user: user,
        relatedNeed: relatedNeed,
        additionalContext: additionalContext,
      );
      
      // Step 2: Perform graph reasoning
      final reasoningResult = await _performGraphReasoning(
        enrichedQuery: enrichedQuery,
        strategy: _selectReasoningStrategy(enrichedQuery.queryUnderstanding),
      );
      
      // Step 3: Generate structured answer
      final structuredAnswer = await _generateStructuredAnswer(
        enrichedQuery: enrichedQuery,
        reasoningResult: reasoningResult,
        preferredType: preferredAnswerType ?? _inferAnswerType(enrichedQuery.queryUnderstanding),
      );
      
      // Step 4: Post-process and validate answer
      final finalAnswer = await _postProcessAnswer(structuredAnswer);
      
      // Step 5: Store for analytics and learning
      await _storeAnswerForLearning(finalAnswer, enrichedQuery, reasoningResult);
      
      final processingTime = DateTime.now().difference(startTime);
      print('Graph RAG processing completed in ${processingTime.inMilliseconds}ms');
      
      return finalAnswer;
    } catch (e) {
      throw GraphRagException('Failed to generate structured answer: $e');
    }
  }
  
  /// Perform graph-based reasoning on the enriched query
  Future<GraphReasoningResult> _performGraphReasoning({
    required EnrichedQuery enrichedQuery,
    required ReasoningStrategy strategy,
  }) async {
    try {
      final startTime = DateTime.now();
      
      // Select appropriate knowledge graph
      final graph = await _selectKnowledgeGraph(enrichedQuery);
      
      // Find relevant nodes in the graph
      final relevantNodes = await _findRelevantNodes(
        graph: graph,
        enrichedQuery: enrichedQuery,
      );
      
      // Identify reasoning paths
      final reasoningPaths = await _findReasoningPaths(
        graph: graph,
        relevantNodes: relevantNodes,
        strategy: strategy,
        queryUnderstanding: enrichedQuery.queryUnderstanding,
      );
      
      // Extract relevant edges
      final relevantEdges = _extractRelevantEdges(graph, reasoningPaths);
      
      // Perform reasoning analysis
      final conclusion = await _analyzeReasoningPaths(
        paths: reasoningPaths,
        queryUnderstanding: enrichedQuery.queryUnderstanding,
        enrichedContext: enrichedQuery.enrichedContext,
      );
      
      // Calculate reasoning quality metrics
      final metrics = _calculateReasoningMetrics(reasoningPaths, relevantNodes);
      
      final reasoningTime = DateTime.now().difference(startTime);
      
      return GraphReasoningResult(
        id: 'gr_${DateTime.now().millisecondsSinceEpoch}',
        query: enrichedQuery.originalQuery,
        paths: reasoningPaths,
        relevantNodes: relevantNodes,
        relevantEdges: relevantEdges,
        conclusion: conclusion,
        confidence: metrics['confidence'] ?? 0.0,
        supportingEvidence: _extractSupportingEvidence(reasoningPaths),
        strategy: strategy,
        reasoningTime: reasoningTime,
        coherenceScore: metrics['coherence'] ?? 0.0,
        completenessScore: metrics['completeness'] ?? 0.0,
        consistencyScore: metrics['consistency'] ?? 0.0,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw GraphRagException('Failed to perform graph reasoning: $e');
    }
  }
  
  /// Generate structured answer from reasoning results
  Future<StructuredAnswer> _generateStructuredAnswer({
    required EnrichedQuery enrichedQuery,
    required GraphReasoningResult reasoningResult,
    required AnswerType preferredType,
  }) async {
    try {
      // Build comprehensive prompt for answer generation
      final answerPrompt = await _buildAnswerGenerationPrompt(
        enrichedQuery: enrichedQuery,
        reasoningResult: reasoningResult,
        answerType: preferredType,
      );
      
      // Generate main answer using GPT-4
      final mainAnswer = await _generateMainAnswer(answerPrompt);
      
      // Structure the answer into sections
      final sections = await _structureAnswer(
        mainAnswer: mainAnswer,
        answerType: preferredType,
        reasoningResult: reasoningResult,
      );
      
      // Extract key points and action items
      final keyPoints = await _extractKeyPoints(mainAnswer, sections);
      final actionItems = await _extractActionItems(mainAnswer, sections);
      
      // Generate source references
      final sources = _generateSourceReferences(
        enrichedQuery.enrichedContext.relevantDocuments,
        reasoningResult.relevantNodes,
      );
      
      // Identify related concepts
      final relatedConcepts = _identifyRelatedConcepts(reasoningResult.relevantNodes);
      
      // Generate follow-up questions
      final followUpQuestions = await _generateFollowUpQuestions(
        enrichedQuery.originalQuery,
        mainAnswer,
        enrichedQuery.queryUnderstanding,
      );
      
      // Calculate answer quality metrics
      final qualityMetrics = await _calculateAnswerQuality(
        mainAnswer: mainAnswer,
        sections: sections,
        reasoningResult: reasoningResult,
      );
      
      return StructuredAnswer(
        id: 'sa_${DateTime.now().millisecondsSinceEpoch}',
        query: enrichedQuery.originalQuery,
        mainAnswer: mainAnswer,
        sections: sections,
        keyPoints: keyPoints,
        actionItems: actionItems,
        sources: sources,
        relatedConcepts: relatedConcepts,
        followUpQuestions: followUpQuestions,
        confidence: qualityMetrics['confidence'] ?? 0.0,
        completeness: qualityMetrics['completeness'] ?? 0.0,
        accuracy: qualityMetrics['accuracy'] ?? 0.0,
        reasoningResult: reasoningResult,
        reasoningPaths: reasoningResult.paths,
        answerType: preferredType,
        generationMetadata: {
          'processing_time': DateTime.now().difference(enrichedQuery.processingTime).inMilliseconds,
          'reasoning_paths_count': reasoningResult.paths.length,
          'relevant_nodes_count': reasoningResult.relevantNodes.length,
          'graph_reasoning_confidence': reasoningResult.confidence,
        },
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw GraphRagException('Failed to generate structured answer: $e');
    }
  }
  
  /// Build knowledge graph from documents and relationships
  Future<KnowledgeGraph> buildKnowledgeGraph({
    required String graphId,
    required String name,
    required List<VectorDocument> documents,
    String? domain,
    List<String>? categories,
  }) async {
    try {
      final nodes = <String, KnowledgeNode>{};
      final edges = <String, KnowledgeEdge>{};
      
      // Extract entities and concepts from documents
      for (final document in documents) {
        final extractedNodes = await _extractNodesFromDocument(document);
        final extractedEdges = await _extractEdgesFromDocument(document, extractedNodes);
        
        // Add nodes
        for (final node in extractedNodes) {
          nodes[node.id] = node;
        }
        
        // Add edges
        for (final edge in extractedEdges) {
          edges[edge.id] = edge;
        }
      }
      
      // Calculate graph metrics
      final graphMetrics = _calculateGraphMetrics(nodes, edges);
      
      // Build indices for efficient lookup
      final nodesByType = _buildNodeIndices(nodes);
      final edgesByType = _buildEdgeIndices(edges);
      
      final graph = KnowledgeGraph(
        id: graphId,
        name: name,
        nodes: nodes,
        edges: edges,
        description: 'Knowledge graph built from ${documents.length} documents',
        domain: domain,
        categories: categories ?? [],
        nodeCount: nodes.length,
        edgeCount: edges.length,
        density: GraphOperations.calculateDensity(nodes.length, edges.length),
        nodesByType: nodesByType,
        edgesByType: edgesByType,
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
      );
      
      // Store the graph
      _knowledgeGraphs[graphId] = graph;
      _graphMetrics[graphId] = graphMetrics;
      
      // Persist to storage
      await _persistKnowledgeGraph(graph);
      
      print('Built knowledge graph "$name" with ${nodes.length} nodes and ${edges.length} edges');
      
      return graph;
    } catch (e) {
      throw GraphRagException('Failed to build knowledge graph: $e');
    }
  }
  
  /// Update knowledge graph with new information
  Future<void> updateKnowledgeGraph({
    required String graphId,
    required VectorDocument newDocument,
  }) async {
    try {
      final graph = _knowledgeGraphs[graphId];
      if (graph == null) {
        throw GraphRagException('Knowledge graph not found: $graphId');
      }
      
      // Extract new nodes and edges
      final newNodes = await _extractNodesFromDocument(newDocument);
      final newEdges = await _extractEdgesFromDocument(newDocument, newNodes);
      
      // Update graph
      final updatedNodes = Map<String, KnowledgeNode>.from(graph.nodes);
      final updatedEdges = Map<String, KnowledgeEdge>.from(graph.edges);
      
      // Add or update nodes
      for (final node in newNodes) {
        updatedNodes[node.id] = node;
      }
      
      // Add or update edges
      for (final edge in newEdges) {
        updatedEdges[edge.id] = edge;
      }
      
      // Recalculate metrics
      final newMetrics = _calculateGraphMetrics(updatedNodes, updatedEdges);
      
      // Update the graph
      _knowledgeGraphs[graphId] = graph.copyWith(
        nodes: updatedNodes,
        edges: updatedEdges,
        nodeCount: updatedNodes.length,
        edgeCount: updatedEdges.length,
        density: GraphOperations.calculateDensity(updatedNodes.length, updatedEdges.length),
        lastUpdated: DateTime.now(),
        version: graph.version + 1,
      );
      
      _graphMetrics[graphId] = newMetrics;
      
      // Persist updates
      await _persistKnowledgeGraph(_knowledgeGraphs[graphId]!);
      
      print('Updated knowledge graph $graphId with ${newNodes.length} new nodes and ${newEdges.length} new edges');
    } catch (e) {
      throw GraphRagException('Failed to update knowledge graph: $e');
    }
  }
  
  // Private helper methods
  
  Future<void> _loadKnowledgeGraphs() async {
    try {
      // Load existing knowledge graphs from storage
      // Implementation would depend on your storage structure
      print('Loaded existing knowledge graphs');
    } catch (e) {
      print('Warning: Failed to load knowledge graphs: $e');
    }
  }
  
  Future<KnowledgeGraph> _selectKnowledgeGraph(EnrichedQuery enrichedQuery) async {
    // For now, use a default graph or create one based on domain
    final domain = enrichedQuery.queryUnderstanding.domain;
    final graphId = 'graph_$domain';
    
    if (_knowledgeGraphs.containsKey(graphId)) {
      return _knowledgeGraphs[graphId]!;
    }
    
    // Create a minimal graph if none exists
    return KnowledgeGraph(
      id: graphId,
      name: 'Default Graph for $domain',
      nodes: {},
      edges: {},
      createdAt: DateTime.now(),
    );
  }
  
  Future<List<KnowledgeNode>> _findRelevantNodes({
    required KnowledgeGraph graph,
    required EnrichedQuery enrichedQuery,
  }) async {
    final relevantNodes = <KnowledgeNode>[];
    final keywords = enrichedQuery.queryUnderstanding.keywords;
    
    // Find nodes matching query keywords and semantic meaning
    for (final node in graph.nodes.values) {
      double relevanceScore = 0.0;
      
      // Check keyword matches
      for (final keyword in keywords) {
        if (node.label.toLowerCase().contains(keyword.toLowerCase()) ||
            node.description?.toLowerCase().contains(keyword.toLowerCase()) == true ||
            node.keywords?.any((k) => k.toLowerCase().contains(keyword.toLowerCase())) == true) {
          relevanceScore += 0.3;
        }
      }
      
      // Check semantic similarity if embeddings available
      if (node.embedding != null && enrichedQuery.enrichedContext.relevantDocuments.isNotEmpty) {
        // Calculate semantic similarity with retrieved documents
        for (final docResult in enrichedQuery.enrichedContext.relevantDocuments) {
          if (docResult.document.embedding != null) {
            final similarity = VectorOperations.cosineSimilarity(
              node.embedding!.embedding,
              docResult.document.embedding!.embedding,
            );
            relevanceScore += similarity * 0.4;
          }
        }
      }
      
      // Consider node centrality
      relevanceScore += node.centrality * 0.3;
      
      if (relevanceScore > 0.5) {
        relevantNodes.add(node.copyWith(relevanceScore: relevanceScore));
      }
    }
    
    // Sort by relevance and return top nodes
    relevantNodes.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));
    return relevantNodes.take(20).toList();
  }
  
  Future<List<ReasoningPath>> _findReasoningPaths({
    required KnowledgeGraph graph,
    required List<KnowledgeNode> relevantNodes,
    required ReasoningStrategy strategy,
    required QueryUnderstanding queryUnderstanding,
  }) async {
    final paths = <ReasoningPath>[];
    
    // Find paths between relevant nodes based on strategy
    for (int i = 0; i < relevantNodes.length && i < 5; i++) {
      for (int j = i + 1; j < relevantNodes.length && j < 5; j++) {
        final startNode = relevantNodes[i];
        final endNode = relevantNodes[j];
        
        final path = GraphOperations.findShortestPath(
          graph,
          startNode.id,
          endNode.id,
        );
        
        if (path != null && path.length > 1) {
          final reasoningPath = await _buildReasoningPath(
            graph: graph,
            nodePath: path,
            queryUnderstanding: queryUnderstanding,
          );
          
          if (reasoningPath != null) {
            paths.add(reasoningPath);
          }
        }
      }
    }
    
    // Sort paths by score and return best ones
    paths.sort((a, b) => b.pathScore.compareTo(a.pathScore));
    return paths.take(10).toList();
  }
  
  Future<ReasoningPath?> _buildReasoningPath({
    required KnowledgeGraph graph,
    required List<String> nodePath,
    required QueryUnderstanding queryUnderstanding,
  }) async {
    try {
      final edgeIds = <String>[];
      
      // Find edges connecting the nodes in the path
      for (int i = 0; i < nodePath.length - 1; i++) {
        final sourceNodeId = nodePath[i];
        final targetNodeId = nodePath[i + 1];
        
        final sourceNode = graph.nodes[sourceNodeId];
        if (sourceNode == null) continue;
        
        // Find edge connecting these nodes
        String? connectingEdgeId;
        for (final edgeId in sourceNode.outgoingEdges) {
          final edge = graph.edges[edgeId];
          if (edge?.targetNodeId == targetNodeId) {
            connectingEdgeId = edgeId;
            break;
          }
        }
        
        if (connectingEdgeId != null) {
          edgeIds.add(connectingEdgeId);
        }
      }
      
      if (edgeIds.isEmpty) return null;
      
      // Calculate path score
      final pathScore = _calculatePathScore(graph, nodePath, edgeIds);
      
      // Generate reasoning explanation
      final reasoning = await _generatePathReasoning(graph, nodePath, edgeIds, queryUnderstanding);
      
      return ReasoningPath(
        id: 'rp_${DateTime.now().millisecondsSinceEpoch}_${math.Random().nextInt(1000)}',
        nodeIds: nodePath,
        edgeIds: edgeIds,
        startNodeId: nodePath.first,
        endNodeId: nodePath.last,
        pathScore: pathScore,
        confidence: pathScore, // Simplified
        pathLength: nodePath.length,
        reasoning: reasoning,
        reasoningType: _inferReasoningType(queryUnderstanding),
        query: queryUnderstanding.semanticMeaning,
        createdAt: DateTime.now(),
      );
    } catch (e) {
      print('Warning: Failed to build reasoning path: $e');
      return null;
    }
  }
  
  double _calculatePathScore(
    KnowledgeGraph graph,
    List<String> nodePath,
    List<String> edgeIds,
  ) {
    double score = 0.0;
    
    // Score based on node relevance
    for (final nodeId in nodePath) {
      final node = graph.nodes[nodeId];
      if (node != null) {
        score += node.relevanceScore * 0.4;
        score += node.centrality * 0.2;
      }
    }
    
    // Score based on edge weights
    for (final edgeId in edgeIds) {
      final edge = graph.edges[edgeId];
      if (edge != null) {
        score += edge.weight * edge.confidence * 0.4;
      }
    }
    
    // Normalize by path length
    if (nodePath.isNotEmpty) {
      score /= nodePath.length;
    }
    
    return math.min(1.0, score);
  }
  
  Future<String> _generatePathReasoning(
    KnowledgeGraph graph,
    List<String> nodePath,
    List<String> edgeIds,
    QueryUnderstanding queryUnderstanding,
  ) async {
    final reasoning = StringBuffer();
    
    reasoning.writeln('Reasoning path from ${graph.nodes[nodePath.first]?.label} to ${graph.nodes[nodePath.last]?.label}:');
    
    for (int i = 0; i < nodePath.length - 1; i++) {
      final sourceNode = graph.nodes[nodePath[i]];
      final targetNode = graph.nodes[nodePath[i + 1]];
      final edge = edgeIds.length > i ? graph.edges[edgeIds[i]] : null;
      
      if (sourceNode != null && targetNode != null && edge != null) {
        reasoning.writeln('${sourceNode.label} ${edge.relationshipType.name} ${targetNode.label}');
      }
    }
    
    return reasoning.toString();
  }
  
  ReasoningType _inferReasoningType(QueryUnderstanding queryUnderstanding) {
    switch (queryUnderstanding.intent) {
      case 'question':
        return ReasoningType.deductive;
      case 'request':
        return ReasoningType.abductive;
      case 'search':
        return ReasoningType.inductive;
      default:
        return ReasoningType.deductive;
    }
  }
  
  ReasoningStrategy _selectReasoningStrategy(QueryUnderstanding queryUnderstanding) {
    switch (queryUnderstanding.complexity) {
      case 'simple':
        return ReasoningStrategy.breadthFirst;
      case 'medium':
        return ReasoningStrategy.bestFirst;
      case 'complex':
        return ReasoningStrategy.aStar;
      default:
        return ReasoningStrategy.bestFirst;
    }
  }
  
  AnswerType _inferAnswerType(QueryUnderstanding queryUnderstanding) {
    switch (queryUnderstanding.intent) {
      case 'question':
        return AnswerType.factual;
      case 'request':
        return AnswerType.procedural;
      case 'help':
        return AnswerType.recommendation;
      default:
        return AnswerType.explanatory;
    }
  }
  
  List<KnowledgeEdge> _extractRelevantEdges(
    KnowledgeGraph graph,
    List<ReasoningPath> paths,
  ) {
    final edgeIds = <String>{};
    for (final path in paths) {
      edgeIds.addAll(path.edgeIds);
    }
    
    return edgeIds
        .map((id) => graph.edges[id])
        .where((edge) => edge != null)
        .cast<KnowledgeEdge>()
        .toList();
  }
  
  Future<String> _analyzeReasoningPaths({
    required List<ReasoningPath> paths,
    required QueryUnderstanding queryUnderstanding,
    required EnrichedContext enrichedContext,
  }) async {
    if (paths.isEmpty) {
      return 'No clear reasoning paths found for the given query.';
    }
    
    final bestPath = paths.first;
    return bestPath.reasoning ?? 'Reasoning analysis based on knowledge graph connections.';
  }
  
  Map<String, double> _calculateReasoningMetrics(
    List<ReasoningPath> paths,
    List<KnowledgeNode> nodes,
  ) {
    if (paths.isEmpty) {
      return {'confidence': 0.0, 'coherence': 0.0, 'completeness': 0.0, 'consistency': 0.0};
    }
    
    final avgPathScore = paths.map((p) => p.pathScore).reduce((a, b) => a + b) / paths.length;
    final avgConfidence = paths.map((p) => p.confidence).reduce((a, b) => a + b) / paths.length;
    
    return {
      'confidence': avgConfidence,
      'coherence': avgPathScore,
      'completeness': math.min(1.0, paths.length / 5.0),
      'consistency': avgPathScore,
    };
  }
  
  List<String> _extractSupportingEvidence(List<ReasoningPath> paths) {
    return paths
        .map((path) => path.reasoning)
        .where((reasoning) => reasoning != null)
        .cast<String>()
        .toList();
  }
  
  Future<String> _buildAnswerGenerationPrompt({
    required EnrichedQuery enrichedQuery,
    required GraphReasoningResult reasoningResult,
    required AnswerType answerType,
  }) async {
    final prompt = StringBuffer();
    
    prompt.writeln('=== GRAPH RAG ANSWER GENERATION ===');
    prompt.writeln();
    prompt.writeln('User Query: ${enrichedQuery.originalQuery}');
    prompt.writeln('Answer Type: ${answerType.name}');
    prompt.writeln('Query Intent: ${enrichedQuery.queryUnderstanding.intent}');
    prompt.writeln('Domain: ${enrichedQuery.queryUnderstanding.domain}');
    prompt.writeln();
    
    // Include enhanced prompt from AI Foundry
    prompt.writeln('=== ENRICHED CONTEXT ===');
    prompt.writeln(enrichedQuery.enhancedPrompt);
    prompt.writeln();
    
    // Include graph reasoning results
    prompt.writeln('=== GRAPH REASONING RESULTS ===');
    prompt.writeln('Reasoning Confidence: ${reasoningResult.confidence.toStringAsFixed(2)}');
    prompt.writeln('Number of Reasoning Paths: ${reasoningResult.paths.length}');
    
    if (reasoningResult.conclusion != null) {
      prompt.writeln('Graph Conclusion: ${reasoningResult.conclusion}');
    }
    
    if (reasoningResult.supportingEvidence != null && reasoningResult.supportingEvidence!.isNotEmpty) {
      prompt.writeln('\nSupporting Evidence:');
      for (final evidence in reasoningResult.supportingEvidence!) {
        prompt.writeln('- $evidence');
      }
    }
    
    prompt.writeln();
    prompt.writeln('=== ANSWER GENERATION INSTRUCTIONS ===');
    prompt.writeln('Generate a comprehensive, structured answer that:');
    prompt.writeln('1. Directly addresses the user\'s query');
    prompt.writeln('2. Incorporates insights from graph reasoning');
    prompt.writeln('3. Uses the enriched context appropriately');
    prompt.writeln('4. Follows the ${answerType.name} answer format');
    prompt.writeln('5. Provides clear, actionable information');
    prompt.writeln('6. Maintains logical flow and coherence');
    
    return prompt.toString();
  }
  
  Future<String> _generateMainAnswer(String prompt) async {
    try {
      final response = await _retryOptions.retry(() async {
        final result = await _dio.post(
          'openai/deployments/$_gpt4Deployment/chat/completions',
          queryParameters: {'api-version': _apiVersion},
          data: {
            'messages': [
              {'role': 'system', 'content': 'You are an expert assistant providing comprehensive, accurate answers based on knowledge graph reasoning and context.'},
              {'role': 'user', 'content': prompt},
            ],
            'max_tokens': 2000,
            'temperature': 0.7,
          },
        );
        
        if (result.statusCode != 200) {
          throw DioException(
            requestOptions: result.requestOptions,
            response: result,
            message: 'Failed to generate answer: ${result.statusCode}',
          );
        }
        
        return result.data;
      });
      
      return response['choices'][0]['message']['content'] as String;
    } catch (e) {
      throw GraphRagException('Failed to generate main answer: $e');
    }
  }
  
  Future<List<AnswerSection>> _structureAnswer({
    required String mainAnswer,
    required AnswerType answerType,
    required GraphReasoningResult reasoningResult,
  }) async {
    // This is a simplified structuring - in production you might use more sophisticated NLP
    final sections = <AnswerSection>[];
    
    // Split answer into paragraphs and create sections
    final paragraphs = mainAnswer.split('\n\n').where((p) => p.trim().isNotEmpty).toList();
    
    for (int i = 0; i < paragraphs.length; i++) {
      final paragraph = paragraphs[i].trim();
      if (paragraph.isNotEmpty) {
        sections.add(AnswerSection(
          id: 'section_${i + 1}',
          title: _generateSectionTitle(paragraph, i),
          content: paragraph,
          type: _inferSectionType(paragraph, answerType),
          order: i,
          importance: i == 0 ? SectionImportance.high : SectionImportance.medium,
        ));
      }
    }
    
    return sections;
  }
  
  String _generateSectionTitle(String content, int index) {
    if (content.length > 50) {
      return content.substring(0, 47) + '...';
    }
    return 'Section ${index + 1}';
  }
  
  SectionType _inferSectionType(String content, AnswerType answerType) {
    if (content.toLowerCase().contains('step') || content.toLowerCase().contains('first') || content.toLowerCase().contains('then')) {
      return SectionType.steps;
    } else if (content.toLowerCase().contains('example') || content.toLowerCase().contains('for instance')) {
      return SectionType.examples;
    } else if (content.toLowerCase().contains('recommend') || content.toLowerCase().contains('suggest')) {
      return SectionType.recommendations;
    } else {
      return SectionType.details;
    }
  }
  
  Future<List<String>> _extractKeyPoints(String mainAnswer, List<AnswerSection> sections) async {
    // Extract key points from the main answer
    final keyPoints = <String>[];
    
    // Look for bullet points or numbered lists
    final lines = mainAnswer.split('\n');
    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.startsWith('•') || trimmed.startsWith('-') || trimmed.startsWith('*') || RegExp(r'^\d+\.').hasMatch(trimmed)) {
        keyPoints.add(trimmed.replaceAll(RegExp(r'^[•\-*\d\.\s]+'), ''));
      }
    }
    
    // If no explicit bullet points, extract first sentence of each section
    if (keyPoints.isEmpty) {
      for (final section in sections) {
        final sentences = section.content.split('.');
        if (sentences.isNotEmpty) {
          keyPoints.add(sentences.first.trim());
        }
      }
    }
    
    return keyPoints.take(5).toList();
  }
  
  Future<List<String>> _extractActionItems(String mainAnswer, List<AnswerSection> sections) async {
    final actionItems = <String>[];
    
    // Look for action-oriented language
    final actionWords = ['should', 'must', 'need to', 'can', 'try', 'consider', 'recommend'];
    final lines = mainAnswer.split('.');
    
    for (final line in lines) {
      final trimmed = line.trim();
      if (actionWords.any((word) => trimmed.toLowerCase().contains(word))) {
        actionItems.add(trimmed);
      }
    }
    
    return actionItems.take(3).toList();
  }
  
  List<SourceReference> _generateSourceReferences(
    List<SearchResultItem> documents,
    List<KnowledgeNode> nodes,
  ) {
    final sources = <SourceReference>[];
    
    // Add document sources
    for (final docResult in documents.take(5)) {
      sources.add(SourceReference(
        id: 'src_doc_${docResult.documentId}',
        documentId: docResult.documentId,
        title: docResult.document.title ?? 'Untitled Document',
        type: SourceType.document,
        relevanceScore: docResult.relevanceScore,
        excerpt: docResult.document.summary,
      ));
    }
    
    // Add knowledge graph sources
    for (final node in nodes.take(3)) {
      if (node.sourceDocument != null) {
        sources.add(SourceReference(
          id: 'src_node_${node.id}',
          documentId: node.sourceDocument!,
          title: node.label,
          type: SourceType.knowledgeBase,
          relevanceScore: node.relevanceScore,
          excerpt: node.description,
        ));
      }
    }
    
    return sources;
  }
  
  List<RelatedConcept> _identifyRelatedConcepts(List<KnowledgeNode> nodes) {
    return nodes.take(5).map((node) => RelatedConcept(
      id: node.id,
      name: node.label,
      description: node.description ?? 'Related concept from knowledge graph',
      relationshipStrength: node.relevanceScore,
      keywords: node.keywords,
      category: node.type.name,
    )).toList();
  }
  
  Future<List<String>> _generateFollowUpQuestions(
    String originalQuery,
    String mainAnswer,
    QueryUnderstanding queryUnderstanding,
  ) async {
    // Generate contextual follow-up questions
    final followUps = <String>[];
    
    // Based on query intent
    switch (queryUnderstanding.intent) {
      case 'question':
        followUps.add('What are the specific steps to implement this?');
        followUps.add('Are there any alternatives to consider?');
        break;
      case 'request':
        followUps.add('What resources do I need for this?');
        followUps.add('How long might this process take?');
        break;
      case 'help':
        followUps.add('What should I do if this doesn\'t work?');
        followUps.add('Where can I get additional support?');
        break;
      default:
        followUps.add('Can you provide more details about this?');
        followUps.add('What are the next steps?');
    }
    
    return followUps;
  }
  
  Future<Map<String, double>> _calculateAnswerQuality({
    required String mainAnswer,
    required List<AnswerSection> sections,
    required GraphReasoningResult reasoningResult,
  }) async {
    // Calculate quality metrics
    final confidence = reasoningResult.confidence;
    
    // Completeness based on answer length and structure
    final completeness = math.min(1.0, (mainAnswer.length / 500.0) * (sections.length / 3.0));
    
    // Accuracy based on reasoning confidence and coherence
    final accuracy = (reasoningResult.confidence + reasoningResult.coherenceScore) / 2.0;
    
    return {
      'confidence': confidence,
      'completeness': completeness,
      'accuracy': accuracy,
    };
  }
  
  Future<StructuredAnswer> _postProcessAnswer(StructuredAnswer answer) async {
    // Post-processing can include validation, formatting, etc.
    return answer;
  }
  
  Future<void> _storeAnswerForLearning(
    StructuredAnswer answer,
    EnrichedQuery enrichedQuery,
    GraphReasoningResult reasoningResult,
  ) async {
    try {
      // Store for analytics and learning
      await _cosmosService.createItem(
        containerName: 'structured_answers',
        item: answer.toJson(),
      );
    } catch (e) {
      print('Warning: Failed to store answer for learning: $e');
    }
  }
  
  Future<List<KnowledgeNode>> _extractNodesFromDocument(VectorDocument document) async {
    // Simplified node extraction - in production you'd use more sophisticated NLP
    final nodes = <KnowledgeNode>[];
    
    // Extract main document node
    nodes.add(KnowledgeNode(
      id: 'node_${document.id}',
      label: document.title ?? 'Document ${document.id}',
      type: NodeType.document,
      properties: {
        'content': document.content,
        'category': document.category.name,
        'type': document.type.name,
      },
      description: document.summary,
      keywords: document.keywords,
      embedding: document.embedding,
      sourceDocument: document.id,
      sourceType: document.type.name,
      createdAt: DateTime.now(),
    ));
    
    // Extract concept nodes from keywords
    if (document.keywords != null) {
      for (final keyword in document.keywords!) {
        nodes.add(KnowledgeNode(
          id: 'concept_${keyword.toLowerCase().replaceAll(' ', '_')}',
          label: keyword,
          type: NodeType.concept,
          properties: {'source_document': document.id},
          sourceDocument: document.id,
          createdAt: DateTime.now(),
        ));
      }
    }
    
    return nodes;
  }
  
  Future<List<KnowledgeEdge>> _extractEdgesFromDocument(
    VectorDocument document,
    List<KnowledgeNode> documentNodes,
  ) async {
    final edges = <KnowledgeEdge>[];
    
    // Create edges between document and concepts
    final documentNode = documentNodes.firstWhere((n) => n.type == NodeType.document);
    final conceptNodes = documentNodes.where((n) => n.type == NodeType.concept);
    
    for (final conceptNode in conceptNodes) {
      edges.add(KnowledgeEdge(
        id: 'edge_${documentNode.id}_${conceptNode.id}',
        sourceNodeId: documentNode.id,
        targetNodeId: conceptNode.id,
        relationshipType: EdgeType.mentions,
        weight: 1.0,
        confidence: 0.8,
        sourceDocument: document.id,
        createdAt: DateTime.now(),
      ));
    }
    
    return edges;
  }
  
  GraphMetrics _calculateGraphMetrics(
    Map<String, KnowledgeNode> nodes,
    Map<String, KnowledgeEdge> edges,
  ) {
    final nodeCount = nodes.length;
    final edgeCount = edges.length;
    final density = GraphOperations.calculateDensity(nodeCount, edgeCount);
    
    // Calculate PageRank scores
    final pageRankScores = GraphOperations.calculatePageRank(
      KnowledgeGraph(
        id: 'temp',
        name: 'temp',
        nodes: nodes,
        edges: edges,
      ),
    );
    
    return GraphMetrics(
      graphId: 'metrics_${DateTime.now().millisecondsSinceEpoch}',
      nodeCount: nodeCount,
      edgeCount: edgeCount,
      density: density,
      averageDegree: edgeCount > 0 ? (edgeCount * 2.0) / nodeCount : 0.0,
      pageRankScores: pageRankScores,
      computedAt: DateTime.now(),
    );
  }
  
  Map<NodeType, List<String>> _buildNodeIndices(Map<String, KnowledgeNode> nodes) {
    final indices = <NodeType, List<String>>{};
    
    for (final node in nodes.values) {
      indices[node.type] ??= [];
      indices[node.type]!.add(node.id);
    }
    
    return indices;
  }
  
  Map<EdgeType, List<String>> _buildEdgeIndices(Map<String, KnowledgeEdge> edges) {
    final indices = <EdgeType, List<String>>{};
    
    for (final edge in edges.values) {
      indices[edge.relationshipType] ??= [];
      indices[edge.relationshipType]!.add(edge.id);
    }
    
    return indices;
  }
  
  Future<void> _persistKnowledgeGraph(KnowledgeGraph graph) async {
    try {
      await _cosmosService.createItem(
        containerName: 'knowledge_graphs',
        item: graph.toJson(),
      );
    } catch (e) {
      print('Warning: Failed to persist knowledge graph: $e');
    }
  }
}

/// Custom exception for Graph RAG operations
class GraphRagException implements Exception {
  final String message;
  
  GraphRagException(this.message);
  
  @override
  String toString() => 'GraphRagException: $message';
} 