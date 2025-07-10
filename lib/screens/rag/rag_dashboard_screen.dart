import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/rag_provider.dart';
import '../../widgets/rag/semantic_search_widget.dart';
import '../../widgets/rag/rag_chat_widget.dart';
import '../../widgets/rag/rag_status_widget.dart';

class RagDashboardScreen extends ConsumerStatefulWidget {
  const RagDashboardScreen({super.key});

  @override
  ConsumerState<RagDashboardScreen> createState() => _RagDashboardScreenState();
}

class _RagDashboardScreenState extends ConsumerState<RagDashboardScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    // Initialize RAG system when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ragInitializationProvider);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ragSystemState = ref.watch(ragSystemProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RAG System Dashboard'),
        backgroundColor: theme.colorScheme.surfaceVariant,
        foregroundColor: theme.colorScheme.onSurfaceVariant,
        elevation: 0,
        actions: [
          // Initialization Status
          if (ragSystemState.status == RagStatus.initializing)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          
          // Settings
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showRagSettings,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.dashboard),
              text: 'Overview',
            ),
            Tab(
              icon: Icon(Icons.search),
              text: 'Search',
            ),
            Tab(
              icon: Icon(Icons.chat),
              text: 'Chat',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Overview Tab
          _buildOverviewTab(),
          
          // Search Tab
          _buildSearchTab(),
          
          // Chat Tab
          _buildChatTab(),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(ragSystemState),
    );
  }

  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // System Status
          const RagStatusWidget(
            showDetails: true,
            showQuickActions: true,
          ),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          _buildQuickActionsSection(),
          
          const SizedBox(height: 24),
          
          // Recent Activity
          _buildRecentActivitySection(),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: SemanticSearchWidget(
        showFilters: true,
        compactMode: false,
      ),
    );
  }

  Widget _buildChatTab() {
    return const RagChatWidget(
      showRagIndicators: true,
      enableStructuredAnswers: true,
    );
  }

  Widget _buildQuickActionsSection() {
    final theme = Theme.of(context);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _buildQuickActionCard(
                  'Index Content',
                  'Add new documents to knowledge base',
                  Icons.upload_file,
                  () => _indexContent(),
                  theme,
                ),
                _buildQuickActionCard(
                  'Rebuild Graph',
                  'Regenerate knowledge graphs',
                  Icons.account_tree,
                  () => _rebuildKnowledgeGraph(),
                  theme,
                ),
                _buildQuickActionCard(
                  'Export Data',
                  'Download RAG system data',
                  Icons.download,
                  () => _exportData(),
                  theme,
                ),
                _buildQuickActionCard(
                  'System Logs',
                  'View detailed system logs',
                  Icons.list_alt,
                  () => _viewSystemLogs(),
                  theme,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
    ThemeData theme,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: theme.dividerColor,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection() {
    final theme = Theme.of(context);
    final searchState = ref.watch(semanticSearchProvider);
    final answersState = ref.watch(structuredAnswersProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: _viewAllActivity,
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Activity List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _getRecentActivities().length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final activity = _getRecentActivities()[index];
                return _buildActivityItem(activity, theme);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(_ActivityItem activity, ThemeData theme) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: activity.color.withOpacity(0.2),
        child: Icon(
          activity.icon,
          color: activity.color,
          size: 20,
        ),
      ),
      title: Text(
        activity.title,
        style: theme.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        activity.description,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
      trailing: Text(
        _formatActivityTime(activity.timestamp),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(RagSystemState ragState) {
    if (!ragState.isInitialized) {
      return FloatingActionButton(
        onPressed: () {
          ref.read(ragSystemProvider.notifier).initialize();
        },
        child: const Icon(Icons.play_arrow),
      );
    }

    return FloatingActionButton(
      onPressed: () {
        _tabController.animateTo(1); // Switch to search tab
      },
      child: const Icon(Icons.search),
    );
  }

  List<_ActivityItem> _getRecentActivities() {
    // This would be populated from actual system activity
    return [
      _ActivityItem(
        title: 'Knowledge Graph Updated',
        description: 'Transportation network graph refreshed',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        icon: Icons.account_tree,
        color: Colors.green,
      ),
      _ActivityItem(
        title: 'Content Indexed',
        description: '25 new documents added to vector store',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        icon: Icons.inventory,
        color: Colors.blue,
      ),
      _ActivityItem(
        title: 'Search Performed',
        description: 'User searched for "housing assistance"',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        icon: Icons.search,
        color: Colors.orange,
      ),
      _ActivityItem(
        title: 'Structured Answer Generated',
        description: 'AI provided enhanced response',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        icon: Icons.psychology,
        color: Colors.purple,
      ),
    ];
  }

  String _formatActivityTime(DateTime timestamp) {
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

  void _showRagSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('RAG System Settings'),
        content: const Text('RAG configuration options will be available here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _indexContent() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Content indexing feature coming soon!'),
      ),
    );
  }

  void _rebuildKnowledgeGraph() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Knowledge graph rebuilding feature coming soon!'),
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data export feature coming soon!'),
      ),
    );
  }

  void _viewSystemLogs() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('System logs feature coming soon!'),
      ),
    );
  }

  void _viewAllActivity() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Activity history feature coming soon!'),
      ),
    );
  }
}

class _ActivityItem {
  final String title;
  final String description;
  final DateTime timestamp;
  final IconData icon;
  final Color color;

  const _ActivityItem({
    required this.title,
    required this.description,
    required this.timestamp,
    required this.icon,
    required this.color,
  });
} 