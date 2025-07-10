import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../providers/rag_provider.dart';
import '../../utils/assets_constants.dart';

class RagStatusWidget extends ConsumerWidget {
  final bool showDetails;
  final bool showQuickActions;
  final VoidCallback? onSystemToggle;
  final VoidCallback? onRefresh;

  const RagStatusWidget({
    super.key,
    this.showDetails = true,
    this.showQuickActions = true,
    this.onSystemToggle,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ragSystemState = ref.watch(ragSystemProvider);
    final ragSystemStatus = ref.watch(ragSystemStatusProvider);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                _buildStatusIcon(ragSystemState, theme),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'RAG System',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getStatusDescription(ragSystemState),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _getStatusColor(ragSystemState, theme),
                        ),
                      ),
                    ],
                  ),
                ),
                if (showQuickActions) ..._buildQuickActions(ragSystemState, theme, ref),
              ],
            ),

            if (showDetails) ...[
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),

              // System Metrics
              _buildSystemMetrics(ragSystemStatus, theme),

              const SizedBox(height: 16),

              // Component Status
              _buildComponentStatus(ragSystemStatus, theme),

              if (ragSystemState.error != null) ...[
                const SizedBox(height: 16),
                _buildErrorSection(ragSystemState.error!, theme),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(RagSystemState state, ThemeData theme) {
    Widget icon;
    Color color;

    switch (state.status) {
      case RagStatus.initializing:
        icon = Lottie.asset(
          AssetConstants.loadingAnimation,
          width: 32,
          height: 32,
        );
        color = theme.colorScheme.secondary;
        break;
      case RagStatus.ready:
        icon = const Icon(Icons.check_circle, size: 32);
        color = Colors.green;
        break;
      case RagStatus.processing:
        icon = const Icon(Icons.sync, size: 32);
        color = theme.colorScheme.primary;
        break;
      case RagStatus.error:
        icon = const Icon(Icons.error, size: 32);
        color = theme.colorScheme.error;
        break;
      case RagStatus.disabled:
        icon = const Icon(Icons.power_off, size: 32);
        color = theme.colorScheme.onSurfaceVariant;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: IconTheme(
        data: IconThemeData(color: color),
        child: icon,
      ),
    );
  }

  List<Widget> _buildQuickActions(RagSystemState state, ThemeData theme, WidgetRef ref) {
    return [
      // Refresh Button
      IconButton(
        icon: const Icon(Icons.refresh),
        onPressed: () {
          ref.read(ragSystemProvider.notifier).refreshMetrics();
          onRefresh?.call();
        },
        tooltip: 'Refresh Status',
      ),
      
      // Settings Button
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => _showSettings(ref),
        tooltip: 'RAG Settings',
      ),
      
      // Toggle Button
      Switch(
        value: state.isEnabled,
        onChanged: (value) {
          ref.read(ragSystemProvider.notifier).setEnabled(value);
          onSystemToggle?.call();
        },
      ),
    ];
  }

  Widget _buildSystemMetrics(Map<String, dynamic> status, ThemeData theme) {
    final systemMetrics = status['system'] as Map<String, dynamic>? ?? {};
    final vectorStore = status['vector_store'] as Map<String, dynamic>? ?? {};
    final search = status['search'] as Map<String, dynamic>? ?? {};
    final indexing = status['indexing'] as Map<String, dynamic>? ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'System Metrics',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Metrics Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildMetricCard(
              'Vector Documents',
              '${vectorStore['documents_count'] ?? 0}',
              Icons.description,
              theme,
            ),
            _buildMetricCard(
              'Search History',
              '${search['history_count'] ?? 0}',
              Icons.history,
              theme,
            ),
            _buildMetricCard(
              'Indexed Content',
              '${indexing['indexed_count'] ?? 0}',
              Icons.inventory,
              theme,
            ),
            _buildMetricCard(
              'Queue Size',
              '${indexing['queue_size'] ?? 0}',
              Icons.queue,
              theme,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildComponentStatus(Map<String, dynamic> status, ThemeData theme) {
    final components = [
      _ComponentStatus(
        name: 'Vector Store',
        isHealthy: !(status['vector_store']?['loading'] ?? false),
        details: 'Document storage and retrieval',
      ),
      _ComponentStatus(
        name: 'Semantic Search',
        isHealthy: !(status['search']?['searching'] ?? false),
        details: 'Knowledge base search',
      ),
      _ComponentStatus(
        name: 'Knowledge Graphs',
        isHealthy: !(status['knowledge_graphs']?['loading'] ?? false),
        details: 'Graph-based reasoning',
      ),
      _ComponentStatus(
        name: 'Answer Generation',
        isHealthy: !(status['answers']?['generating'] ?? false),
        details: 'Structured response creation',
      ),
      _ComponentStatus(
        name: 'Content Indexing',
        isHealthy: !(status['indexing']?['processing'] ?? false),
        details: 'Background content processing',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Component Status',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        
        // Components List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: components.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final component = components[index];
            return _buildComponentItem(component, theme);
          },
        ),
      ],
    );
  }

  Widget _buildComponentItem(_ComponentStatus component, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: component.isHealthy 
            ? Colors.green.withOpacity(0.1)
            : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: component.isHealthy 
              ? Colors.green.withOpacity(0.3)
              : Colors.orange.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            component.isHealthy ? Icons.check_circle : Icons.warning,
            color: component.isHealthy ? Colors.green : Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  component.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  component.details,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Text(
            component.isHealthy ? 'Healthy' : 'Busy',
            style: theme.textTheme.bodySmall?.copyWith(
              color: component.isHealthy ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorSection(String error, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: theme.colorScheme.error.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: theme.colorScheme.onErrorContainer,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'System Error',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onErrorContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
        ],
      ),
    );
  }

  String _getStatusDescription(RagSystemState state) {
    switch (state.status) {
      case RagStatus.initializing:
        return 'Starting up services...';
      case RagStatus.ready:
        return state.isEnabled ? 'Online and ready' : 'Offline';
      case RagStatus.processing:
        return 'Processing requests...';
      case RagStatus.error:
        return 'System error detected';
      case RagStatus.disabled:
        return 'System disabled';
    }
  }

  Color _getStatusColor(RagSystemState state, ThemeData theme) {
    switch (state.status) {
      case RagStatus.initializing:
        return theme.colorScheme.secondary;
      case RagStatus.ready:
        return state.isEnabled ? Colors.green : theme.colorScheme.onSurfaceVariant;
      case RagStatus.processing:
        return theme.colorScheme.primary;
      case RagStatus.error:
        return theme.colorScheme.error;
      case RagStatus.disabled:
        return theme.colorScheme.onSurfaceVariant;
    }
  }

  void _showSettings(WidgetRef ref) {
    // TODO: Implement RAG settings dialog
    // This would show various configuration options like:
    // - Similarity thresholds
    // - Max results
    // - Knowledge graph settings
    // - Indexing preferences
  }
}

class _ComponentStatus {
  final String name;
  final bool isHealthy;
  final String details;

  const _ComponentStatus({
    required this.name,
    required this.isHealthy,
    required this.details,
  });
} 