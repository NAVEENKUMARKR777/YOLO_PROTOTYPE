import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../providers/needs_provider.dart';
import '../../providers/app_provider.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import '../../models/need_model.dart';

class AdminPanelScreen extends ConsumerStatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  ConsumerState<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends ConsumerState<AdminPanelScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    
    // Load admin data when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAdminData();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadAdminData() {
    // TODO: Load admin-specific data
    // ref.read(adminStateProvider.notifier).loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    
    // Verify admin access
    if (authState.user?.role != UserRole.admin) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.admin_panel_settings,
                size: 64,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Access Denied',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'You need administrator privileges to access this area.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/home'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadAdminData,
          ),
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export_data',
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Export Data'),
                ),
              ),
              const PopupMenuItem(
                value: 'system_logs',
                child: ListTile(
                  leading: Icon(Icons.bug_report),
                  title: Text('System Logs'),
                ),
              ),
              const PopupMenuItem(
                value: 'backup',
                child: ListTile(
                  leading: Icon(Icons.backup),
                  title: Text('Create Backup'),
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Dashboard', icon: Icon(Icons.dashboard)),
            Tab(text: 'Users', icon: Icon(Icons.people)),
            Tab(text: 'Content', icon: Icon(Icons.content_paste)),
            Tab(text: 'Analytics', icon: Icon(Icons.analytics)),
            Tab(text: 'System', icon: Icon(Icons.settings)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDashboardTab(),
          _buildUsersTab(),
          _buildContentTab(),
          _buildAnalyticsTab(),
          _buildSystemTab(),
        ],
      ),
    );
  }

  Widget _buildDashboardTab() {
    return RefreshIndicator(
      onRefresh: () async => _loadAdminData(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Key metrics cards
            _buildMetricsGrid(),
            
            const SizedBox(height: 24),

            // Recent activity
            _buildRecentActivity(),
            
            const SizedBox(height: 24),

            // Quick actions
            _buildQuickActions(),
            
            const SizedBox(height: 24),

            // System status
            _buildSystemStatus(),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersTab() {
    return Column(
      children: [
        // User management controls
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search users...',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    // TODO: Implement user search
                  },
                ),
              ),
              const SizedBox(width: 12),
              PopupMenuButton<String>(
                child: const Chip(
                  label: Text('Filter'),
                  avatar: Icon(Icons.filter_list),
                ),
                onSelected: (value) {
                  // TODO: Implement user filtering
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'all', child: Text('All Users')),
                  const PopupMenuItem(value: 'seekers', child: Text('Seekers')),
                  const PopupMenuItem(value: 'helpers', child: Text('Helpers')),
                  const PopupMenuItem(value: 'business', child: Text('Business')),
                  const PopupMenuItem(value: 'suspended', child: Text('Suspended')),
                ],
              ),
            ],
          ),
        ),

        // Users list
        Expanded(
          child: _buildUsersList(),
        ),
      ],
    );
  }

  Widget _buildContentTab() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(text: 'Pending Review'),
              Tab(text: 'Reported Content'),
              Tab(text: 'Moderation Log'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildPendingReview(),
                _buildReportedContent(),
                _buildModerationLog(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time period selector
          Row(
            children: [
              Text(
                'Analytics Overview',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: '7d', label: Text('7D')),
                  ButtonSegment(value: '30d', label: Text('30D')),
                  ButtonSegment(value: '90d', label: Text('90D')),
                ],
                selected: {'30d'},
                onSelectionChanged: (Set<String> selection) {
                  // TODO: Update analytics period
                },
              ),
            ],
          ),
          
          const SizedBox(height: 24),

          // Charts and analytics
          _buildAnalyticsCharts(),
          
          const SizedBox(height: 24),

          // Power BI Embedded placeholder
          _buildPowerBIDashboard(),
        ],
      ),
    );
  }

  Widget _buildSystemTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Configuration',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          
          const SizedBox(height: 24),

          // System settings
          _buildSystemSettings(),
          
          const SizedBox(height: 24),

          // Maintenance tools
          _buildMaintenanceTools(),
          
          const SizedBox(height: 24),

          // Azure services status
          _buildAzureServicesStatus(),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildMetricCard('Total Users', '1,234', Icons.people, Colors.blue, '+12% this week'),
        _buildMetricCard('Active Needs', '89', Icons.help, Colors.green, '+5% this week'),
        _buildMetricCard('Help Requests', '567', Icons.volunteer_activism, Colors.orange, '+18% this week'),
        _buildMetricCard('System Health', '98%', Icons.health_and_safety, Colors.red, 'All systems operational'),
      ],
    );
  }

  Widget _buildMetricCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const Spacer(),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(_getActivityIcon(index)),
                  ),
                  title: Text(_getActivityTitle(index)),
                  subtitle: Text(_getActivityTime(index)),
                  trailing: _getActivityAction(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildQuickActionButton('Send Broadcast', Icons.campaign, () => _sendBroadcast()),
                _buildQuickActionButton('Export Data', Icons.download, () => _exportData()),
                _buildQuickActionButton('Create Backup', Icons.backup, () => _createBackup()),
                _buildQuickActionButton('View Logs', Icons.list_alt, () => _viewLogs()),
                _buildQuickActionButton('User Reports', Icons.report, () => _viewReports()),
                _buildQuickActionButton('System Check', Icons.check_circle, () => _runSystemCheck()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionButton(String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildSystemStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildStatusItem('API Server', true, '99.9% uptime'),
            _buildStatusItem('Database', true, 'Healthy'),
            _buildStatusItem('Azure Services', true, 'All operational'),
            _buildStatusItem('Notifications', false, 'Minor delays'),
            _buildStatusItem('File Storage', true, '89% capacity'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusItem(String service, bool isHealthy, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isHealthy ? Icons.check_circle : Icons.warning,
            color: isHealthy ? Colors.green : Colors.orange,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(service),
          ),
          Text(
            status,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    // Sample user data - in real app, this would come from state management
    final users = [
      {'name': 'John Doe', 'email': 'john@example.com', 'role': 'Helper', 'status': 'Active'},
      {'name': 'Jane Smith', 'email': 'jane@example.com', 'role': 'Seeker', 'status': 'Active'},
      {'name': 'Bob Wilson', 'email': 'bob@example.com', 'role': 'Business', 'status': 'Suspended'},
    ];

    return ListView.separated(
      itemCount: users.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(user['name']![0]),
          ),
          title: Text(user['name']!),
          subtitle: Text('${user['email']} • ${user['role']}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Chip(
                label: Text(user['status']!),
                backgroundColor: user['status'] == 'Active' 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
              ),
              PopupMenuButton<String>(
                onSelected: (value) => _handleUserAction(value, user),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'view', child: Text('View Profile')),
                  const PopupMenuItem(value: 'message', child: Text('Send Message')),
                  const PopupMenuItem(value: 'suspend', child: Text('Suspend User')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete User')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPendingReview() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('Need Review #${index + 1}'),
            subtitle: const Text('User reported inappropriate content'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () => _approveContent(index),
                  child: const Text('Approve'),
                ),
                TextButton(
                  onPressed: () => _rejectContent(index),
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildReportedContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.report, color: Colors.red),
            title: Text('Report #${index + 1}'),
            subtitle: const Text('Spam content reported by user'),
            trailing: ElevatedButton(
              onPressed: () => _reviewReport(index),
              child: const Text('Review'),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModerationLog() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.history),
          title: Text('Action taken on content #${index + 1}'),
          subtitle: Text('${DateTime.now().subtract(Duration(hours: index)).toString().split('.')[0]} - Content removed'),
        );
      },
    );
  }

  Widget _buildAnalyticsCharts() {
    return Column(
      children: [
        // User growth chart
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Growth',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(show: true),
                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            const FlSpot(0, 3),
                            const FlSpot(1, 1),
                            const FlSpot(2, 4),
                            const FlSpot(3, 2),
                            const FlSpot(4, 5),
                            const FlSpot(5, 3),
                            const FlSpot(6, 6),
                          ],
                          isCurved: true,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),

        // Needs categories pie chart
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Needs by Category',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(value: 30, title: 'Food', color: Colors.blue),
                        PieChartSectionData(value: 25, title: 'Transport', color: Colors.green),
                        PieChartSectionData(value: 20, title: 'Healthcare', color: Colors.orange),
                        PieChartSectionData(value: 15, title: 'Housing', color: Colors.red),
                        PieChartSectionData(value: 10, title: 'Other', color: Colors.purple),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPowerBIDashboard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Power BI Dashboard',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.analytics,
                    size: 64,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Power BI Embedded Dashboard',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Advanced analytics and reporting will be embedded here',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Open Power BI dashboard
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Power BI integration coming soon!')),
                      );
                    },
                    child: const Text('Open Full Dashboard'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSystemSettings() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Application Settings',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Maintenance Mode'),
              subtitle: const Text('Disable app for maintenance'),
              value: false,
              onChanged: (value) {
                // TODO: Toggle maintenance mode
              },
            ),
            SwitchListTile(
              title: const Text('New User Registration'),
              subtitle: const Text('Allow new users to register'),
              value: true,
              onChanged: (value) {
                // TODO: Toggle registration
              },
            ),
            SwitchListTile(
              title: const Text('Push Notifications'),
              subtitle: const Text('Enable system notifications'),
              value: true,
              onChanged: (value) {
                // TODO: Toggle notifications
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaintenanceTools() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Maintenance Tools',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Clear Cache'),
              subtitle: const Text('Clear application cache'),
              trailing: ElevatedButton(
                onPressed: _clearCache,
                child: const Text('Clear'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('Database Cleanup'),
              subtitle: const Text('Remove old and unused data'),
              trailing: ElevatedButton(
                onPressed: _cleanupDatabase,
                child: const Text('Cleanup'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('Update Search Index'),
              subtitle: const Text('Refresh search functionality'),
              trailing: ElevatedButton(
                onPressed: _updateSearchIndex,
                child: const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAzureServicesStatus() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Azure Services Status',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildServiceStatus('Azure AD B2C', true, 'Authentication service'),
            _buildServiceStatus('Cosmos DB', true, 'Database service'),
            _buildServiceStatus('Blob Storage', true, 'File storage service'),
            _buildServiceStatus('OpenAI', true, 'AI chat service'),
            _buildServiceStatus('Computer Vision', true, 'Image analysis service'),
            _buildServiceStatus('Notification Hubs', false, 'Push notification service'),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceStatus(String service, bool isOnline, String description) {
    return ListTile(
      leading: Icon(
        isOnline ? Icons.cloud_done : Icons.cloud_off,
        color: isOnline ? Colors.green : Colors.red,
      ),
      title: Text(service),
      subtitle: Text(description),
      trailing: Chip(
        label: Text(isOnline ? 'Online' : 'Offline'),
        backgroundColor: isOnline 
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
      ),
    );
  }

  IconData _getActivityIcon(int index) {
    final icons = [Icons.person_add, Icons.report, Icons.check_circle, Icons.warning, Icons.info];
    return icons[index % icons.length];
  }

  String _getActivityTitle(int index) {
    final titles = [
      'New user registered',
      'Content reported',
      'Need completed',
      'System alert',
      'Backup completed',
    ];
    return titles[index % titles.length];
  }

  String _getActivityTime(int index) {
    final times = ['2 minutes ago', '15 minutes ago', '1 hour ago', '3 hours ago', '1 day ago'];
    return times[index % times.length];
  }

  Widget? _getActivityAction(int index) {
    switch (index % 3) {
      case 0:
        return TextButton(
          onPressed: () {},
          child: const Text('View'),
        );
      case 1:
        return TextButton(
          onPressed: () {},
          child: const Text('Review'),
        );
      default:
        return null;
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'export_data':
        _exportData();
        break;
      case 'system_logs':
        _viewLogs();
        break;
      case 'backup':
        _createBackup();
        break;
    }
  }

  void _handleUserAction(String action, Map<String, String> user) {
    switch (action) {
      case 'view':
        // TODO: View user profile
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Viewing ${user['name']} profile')),
        );
        break;
      case 'message':
        // TODO: Send message to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Messaging ${user['name']}')),
        );
        break;
      case 'suspend':
        _suspendUser(user);
        break;
      case 'delete':
        _deleteUser(user);
        break;
    }
  }

  void _suspendUser(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Suspend User'),
        content: Text('Are you sure you want to suspend ${user['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement user suspension
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${user['name']} has been suspended')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Suspend'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete User'),
        content: Text('This will permanently delete ${user['name']} and all their data. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement user deletion
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${user['name']} has been deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _sendBroadcast() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Broadcast'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Message Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Message Content',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Broadcast sent to all users!')),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data export started. You will receive a download link via email.')),
    );
  }

  void _createBackup() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Backup process started...')),
    );
  }

  void _viewLogs() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('System logs feature coming soon!')),
    );
  }

  void _viewReports() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User reports feature coming soon!')),
    );
  }

  void _runSystemCheck() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Running system health check...')),
    );
  }

  void _approveContent(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Content #${index + 1} approved')),
    );
  }

  void _rejectContent(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Content #${index + 1} rejected')),
    );
  }

  void _reviewReport(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reviewing report #${index + 1}')),
    );
  }

  void _clearCache() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Application cache cleared')),
    );
  }

  void _cleanupDatabase() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Database cleanup completed')),
    );
  }

  void _updateSearchIndex() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search index updated')),
    );
  }
} 