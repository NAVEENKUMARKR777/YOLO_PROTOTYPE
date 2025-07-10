import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../providers/auth_provider.dart';
import '../../providers/needs_provider.dart';
import '../../providers/gamification_provider.dart';
import '../../providers/app_provider.dart';
import '../../models/need_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import '../../widgets/need_card.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/stats_card.dart';

class HomeDashboard extends ConsumerStatefulWidget {
  const HomeDashboard({super.key});

  @override
  ConsumerState<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends ConsumerState<HomeDashboard> {
  @override
  void initState() {
    super.initState();
    // Load data when dashboard is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(needsStateProvider.notifier).loadUserNeeds();
      ref.read(gamificationStateProvider.notifier).loadUserProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final needsState = ref.watch(needsStateProvider);
    final gamificationState = ref.watch(gamificationStateProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${user.firstName}!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              _getGreetingMessage(),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showNotifications(context),
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _showSettings(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.wait([
            ref.read(needsStateProvider.notifier).loadUserNeeds(),
            ref.read(gamificationStateProvider.notifier).loadUserProgress(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            // User Stats Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildStatsSection(user, gamificationState),
              ),
            ),

            // Quick Actions Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildQuickActions(user.role),
              ),
            ),

            // Active Needs Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildActiveNeedsSection(needsState),
              ),
            ),

            // Recent Activity Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildRecentActivitySection(),
              ),
            ),

            // Progress Chart Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildProgressChart(gamificationState),
              ),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/home/capture-need'),
        icon: const Icon(Icons.add),
        label: const Text('New Need'),
      ),
    );
  }

  Widget _buildStatsSection(User user, GamificationState gamificationState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Impact',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatsCard(
                title: 'Level',
                value: '${gamificationState.currentLevel}',
                subtitle: '${gamificationState.pointsToNextLevel} to next',
                icon: Icons.trending_up,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatsCard(
                title: 'Points',
                value: '${gamificationState.totalPoints}',
                subtitle: 'Total earned',
                icon: Icons.stars,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatsCard(
                title: user.role == UserRole.seeker ? 'Needs' : 'Helped',
                value: '${_getRelevantCount(user.role)}',
                subtitle: user.role == UserRole.seeker ? 'Created' : 'People',
                icon: user.role == UserRole.seeker ? Icons.help_outline : Icons.favorite,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatsCard(
                title: 'Streak',
                value: '${gamificationState.currentStreak}',
                subtitle: 'Days active',
                icon: Icons.local_fire_department,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions(UserRole role) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _getQuickActions(role),
          ),
        ),
      ],
    );
  }

  List<Widget> _getQuickActions(UserRole role) {
    final commonActions = [
      QuickActionCard(
        title: 'Chat AI',
        icon: Icons.smart_toy,
        color: Colors.purple,
        onTap: () => context.push('/chat'),
      ),
      QuickActionCard(
        title: 'Community',
        icon: Icons.people,
        color: Colors.blue,
        onTap: () => context.go('/community'),
      ),
      QuickActionCard(
        title: 'Missions',
        icon: Icons.emoji_events,
        color: Colors.orange,
        onTap: () => context.go('/gamification'),
      ),
    ];

    switch (role) {
      case UserRole.seeker:
        return [
          QuickActionCard(
            title: 'New Need',
            icon: Icons.add_circle,
            color: Colors.green,
            onTap: () => context.push('/home/capture-need'),
          ),
          ...commonActions,
          QuickActionCard(
            title: 'Scan Barcode',
            icon: Icons.qr_code_scanner,
            color: Colors.teal,
            onTap: () => _scanBarcode(),
          ),
        ];
      case UserRole.helper:
        return [
          QuickActionCard(
            title: 'Help Someone',
            icon: Icons.volunteer_activism,
            color: Colors.red,
            onTap: () => context.go('/community'),
          ),
          ...commonActions,
          QuickActionCard(
            title: 'My Reviews',
            icon: Icons.rate_review,
            color: Colors.indigo,
            onTap: () => _viewReviews(),
          ),
        ];
      case UserRole.business:
        return [
          QuickActionCard(
            title: 'Post Service',
            icon: Icons.business_center,
            color: Colors.green,
            onTap: () => context.push('/home/capture-need'),
          ),
          ...commonActions,
          QuickActionCard(
            title: 'Analytics',
            icon: Icons.analytics,
            color: Colors.cyan,
            onTap: () => _viewAnalytics(),
          ),
        ];
      case UserRole.admin:
        return [
          QuickActionCard(
            title: 'Admin Panel',
            icon: Icons.admin_panel_settings,
            color: Colors.deepPurple,
            onTap: () => context.go('/admin'),
          ),
          ...commonActions,
          QuickActionCard(
            title: 'Moderate',
            icon: Icons.gavel,
            color: Colors.amber,
            onTap: () => _moderateContent(),
          ),
        ];
    }
  }

  Widget _buildActiveNeedsSection(NeedsState needsState) {
    final activeNeeds = needsState.userNeeds
        .where((need) => need.status != NeedStatus.completed && need.status != NeedStatus.cancelled)
        .take(3)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Active Needs',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () => _viewAllNeeds(),
              child: const Text('View All'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (activeNeeds.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No active needs',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'You\'re all caught up! Create a new need or help others.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        else
          ...activeNeeds.map(
            (need) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: NeedCard(
                need: need,
                onTap: () => context.push('/home/need-timeline/${need.id}'),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(
                    _getActivityIcon(index),
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                title: Text(_getActivityTitle(index)),
                subtitle: Text(_getActivitySubtitle(index)),
                trailing: Text(
                  _getActivityTime(index),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProgressChart(GamificationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Progress',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          return Text(days[value.toInt() % 7]);
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _generateProgressSpots(),
                      isCurved: true,
                      color: Theme.of(context).colorScheme.primary,
                      barWidth: 3,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<FlSpot> _generateProgressSpots() {
    // Generate sample progress data for the week
    return [
      const FlSpot(0, 10),
      const FlSpot(1, 15),
      const FlSpot(2, 25),
      const FlSpot(3, 20),
      const FlSpot(4, 30),
      const FlSpot(5, 35),
      const FlSpot(6, 40),
    ];
  }

  String _getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning! Ready to make a difference?';
    if (hour < 17) return 'Good afternoon! Keep up the great work!';
    return 'Good evening! Reflecting on today\'s achievements?';
  }

  int _getRelevantCount(UserRole role) {
    final needsState = ref.read(needsStateProvider);
    switch (role) {
      case UserRole.seeker:
        return needsState.userNeeds.length;
      case UserRole.helper:
      case UserRole.business:
        return needsState.helpedCount;
      case UserRole.admin:
        return needsState.totalNeeds;
    }
  }

  IconData _getActivityIcon(int index) {
    const icons = [Icons.help, Icons.chat, Icons.star];
    return icons[index % icons.length];
  }

  String _getActivityTitle(int index) {
    const titles = [
      'New help request received',
      'AI chat session started',
      'Achievement unlocked: Helper Hero',
    ];
    return titles[index % titles.length];
  }

  String _getActivitySubtitle(int index) {
    const subtitles = [
      'Someone needs help with groceries',
      'Asked about local resources',
      'Helped 5 people this week',
    ];
    return subtitles[index % subtitles.length];
  }

  String _getActivityTime(int index) {
    const times = ['2h ago', '4h ago', '1d ago'];
    return times[index % times.length];
  }

  void _showNotifications(BuildContext context) {
    // TODO: Implement notifications screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notifications feature coming soon!')),
    );
  }

  void _showSettings(BuildContext context) {
    // TODO: Implement settings screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings feature coming soon!')),
    );
  }

  void _scanBarcode() {
    // TODO: Implement barcode scanning
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Barcode scanner coming soon!')),
    );
  }

  void _viewReviews() {
    // TODO: Implement reviews screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Reviews feature coming soon!')),
    );
  }

  void _viewAnalytics() {
    // TODO: Implement analytics screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Analytics feature coming soon!')),
    );
  }

  void _moderateContent() {
    // TODO: Implement content moderation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Moderation tools coming soon!')),
    );
  }

  void _viewAllNeeds() {
    // TODO: Navigate to all needs screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All needs view coming soon!')),
    );
  }
} 