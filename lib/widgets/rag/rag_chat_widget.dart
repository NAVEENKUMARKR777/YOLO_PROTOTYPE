import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../providers/rag_provider.dart';
import '../../models/chat_model.dart';
import '../../models/graph_rag_model.dart';
import '../../models/enums.dart';
import '../../providers/auth_provider.dart';
import '../../providers/chat_provider.dart';
import '../../utils/assets_constants.dart';

class RagChatWidget extends ConsumerStatefulWidget {
  final String? sessionId;
  final String? needId;
  final bool showRagIndicators;
  final bool enableStructuredAnswers;
  final VoidCallback? onSourceSelected;

  const RagChatWidget({
    super.key,
    this.sessionId,
    this.needId,
    this.showRagIndicators = true,
    this.enableStructuredAnswers = true,
    this.onSourceSelected,
  });

  @override
  ConsumerState<RagChatWidget> createState() => _RagChatWidgetState();
}

class _RagChatWidgetState extends ConsumerState<RagChatWidget> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _ragIndicatorController;
  late Animation<double> _ragIndicatorAnimation;

  @override
  void initState() {
    super.initState();
    _ragIndicatorController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _ragIndicatorAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _ragIndicatorController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _ragIndicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ragSystemState = ref.watch(ragSystemProvider);
    final structuredAnswersState = ref.watch(structuredAnswersProvider);
    final user = ref.watch(authProvider).user;

    return Column(
      children: [
        // RAG Status Header
        if (widget.showRagIndicators)
          _buildRagStatusHeader(ragSystemState, theme),

        // Chat Messages
        Expanded(
          child: _buildChatMessages(theme),
        ),

        // Structured Answer Panel (if available)
        if (widget.enableStructuredAnswers && structuredAnswersState.currentAnswer != null)
          _buildStructuredAnswerPanel(structuredAnswersState.currentAnswer!, theme),

        // Message Input
        _buildMessageInput(ragSystemState, theme),
      ],
    );
  }

  Widget _buildRagStatusHeader(RagSystemState ragState, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ragState.isEnabled 
            ? theme.colorScheme.primaryContainer.withOpacity(0.3)
            : theme.colorScheme.surfaceVariant,
        border: Border(
          bottom: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // RAG Status Indicator
          AnimatedBuilder(
            animation: _ragIndicatorAnimation,
            builder: (context, child) {
              return Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ragState.isEnabled 
                      ? Colors.green.withOpacity(_ragIndicatorAnimation.value)
                      : Colors.grey,
                ),
              );
            },
          ),
          const SizedBox(width: 8),
          
          // Status Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ragState.isEnabled ? 'RAG Enhanced Chat' : 'Basic Chat',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ragState.isEnabled 
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  ragState.isEnabled 
                      ? 'AI responses enhanced with knowledge base'
                      : 'Standard AI chat without knowledge enhancement',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          
          // Toggle Switch
          Switch(
            value: ragState.isEnabled,
            onChanged: (value) {
              ref.read(ragSystemProvider.notifier).setEnabled(value);
              if (value) {
                _ragIndicatorController.repeat(reverse: true);
              } else {
                _ragIndicatorController.stop();
                _ragIndicatorController.reset();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: 10, // This would come from your chat provider
        itemBuilder: (context, index) {
          // This is a placeholder - replace with actual chat messages
          final isUser = index % 2 == 0;
          return _buildMessageBubble(
            isUser: isUser,
            message: isUser 
                ? "How can I find help with transportation?"
                : "Based on your location and needs, here are some transportation options available...",
            timestamp: DateTime.now().subtract(Duration(minutes: index * 5)),
            theme: theme,
            ragSources: isUser ? null : [
              "Community Transportation Guide",
              "Local Transit Resources",
              "Volunteer Driver Network"
            ],
          );
        },
      ),
    );
  }

  Widget _buildMessageBubble({
    required bool isUser,
    required String message,
    required DateTime timestamp,
    required ThemeData theme,
    List<String>? ragSources,
  }) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUser 
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(16).copyWith(
                  bottomRight: isUser ? const Radius.circular(4) : null,
                  bottomLeft: !isUser ? const Radius.circular(4) : null,
                ),
              ),
              child: Text(
                message,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: isUser 
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            
            // RAG Sources (for AI responses)
            if (!isUser && ragSources != null && ragSources.isNotEmpty)
              _buildRagSources(ragSources, theme),
            
            // Timestamp
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                _formatTimestamp(timestamp),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRagSources(List<String> sources, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_stories,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                'Sources:',
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: sources.map((source) {
              return InkWell(
                onTap: () => _selectSource(source),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    source,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStructuredAnswerPanel(StructuredAnswer answer, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.secondary.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: theme.colorScheme.secondary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Enhanced Answer',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  ref.read(structuredAnswersProvider.notifier).clearCurrentAnswer();
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Answer Content
          Text(
            answer.content,
            style: theme.textTheme.bodyMedium,
          ),

          // Confidence and Quality
          if (answer.confidence != null || answer.qualityMetrics != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (answer.confidence != null) ...[
                  Icon(
                    Icons.verified,
                    size: 16,
                    color: _getConfidenceColor(answer.confidence!),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Confidence: ${(answer.confidence! * 100).round()}%',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getConfidenceColor(answer.confidence!),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                if (answer.confidence != null && answer.qualityMetrics != null)
                  const SizedBox(width: 16),
                if (answer.qualityMetrics != null) ...[
                  Icon(
                    Icons.analytics,
                    size: 16,
                    color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Quality: ${answer.qualityMetrics!['overall_score']?.toStringAsFixed(2) ?? 'N/A'}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ],
            ),
          ],

          // Evidence Sources
          if (answer.evidenceSources.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Evidence Sources:',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Wrap(
              spacing: 4,
              children: answer.evidenceSources.take(3).map((source) {
                return Chip(
                  label: Text(source),
                  labelStyle: theme.textTheme.bodySmall,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput(RagSystemState ragState, ThemeData theme) {
    final structuredAnswersState = ref.watch(structuredAnswersProvider);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Message Input Field
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: ragState.isEnabled 
                    ? 'Ask anything... (RAG enhanced)'
                    : 'Type your message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                prefixIcon: ragState.isEnabled 
                    ? Icon(
                        Icons.auto_stories,
                        color: theme.colorScheme.primary,
                      )
                    : const Icon(Icons.message),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: _startVoiceInput,
                    ),
                    IconButton(
                      icon: const Icon(Icons.attach_file),
                      onPressed: _attachFile,
                    ),
                  ],
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.newline,
              onSubmitted: _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          
          // Send Button
          FloatingActionButton(
            mini: true,
            onPressed: structuredAnswersState.isGenerating 
                ? null 
                : () => _sendMessage(_messageController.text),
            child: structuredAnswersState.isGenerating
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return Colors.orange;
    return Colors.red;
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;
    
    final user = ref.read(authProvider).user;
    if (user == null) return;

    final ragState = ref.read(ragSystemProvider);
    
    // If RAG is enabled and structured answers are enabled, generate structured answer
    if (ragState.isEnabled && widget.enableStructuredAnswers) {
      ref.read(structuredAnswersProvider.notifier).generateAnswer(
        query: message.trim(),
        userId: user.id,
        sessionId: widget.sessionId,
        needId: widget.needId,
        user: user,
      );
    }
    
    // Clear input
    _messageController.clear();
    
    // Auto-scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _selectSource(String source) {
    widget.onSourceSelected?.call();
    // Handle source selection - could open detailed view
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected source: $source'),
        action: SnackBarAction(
          label: 'View',
          onPressed: () {
            // Navigate to source details
          },
        ),
      ),
    );
  }

  void _startVoiceInput() {
    // TODO: Implement voice input using Azure Speech service
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Voice input coming soon!'),
      ),
    );
  }

  void _attachFile() {
    // TODO: Implement file attachment
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('File attachment coming soon!'),
      ),
    );
  }
} 