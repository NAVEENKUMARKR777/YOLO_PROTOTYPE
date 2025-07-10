import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/mission_model.dart';
import '../../models/enums.dart';
import '../../providers/gamification_provider.dart';
import '../../providers/auth_provider.dart';
import '../../models/mission.dart';
import '../../models/badge.dart';

class GamificationScreen extends ConsumerStatefulWidget {
  const GamificationScreen({super.key});

  @override
  ConsumerState<GamificationScreen> createState() => _GamificationScreenState();
}

class _GamificationScreenState extends ConsumerState<GamificationScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Load gamification data when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gamificationStateProvider.notifier).loadUserProgress();
      ref.read(gamificationStateProvider.notifier).loadMissions();
      ref.read(gamificationStateProvider.notifier).loadLeaderboard();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gamificationState = ref.watch(gamificationStateProvider);
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('YOLO Warrior'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showYOLOWarriorInfo(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Progress', icon: Icon(Icons.trending_up)),
            Tab(text: 'Missions', icon: Icon(Icons.assignment)),
            Tab(text: 'Badges', icon: Icon(Icons.military_tech)),
            Tab(text: 'Leaderboard', icon: Icon(Icons.leaderboard)),
          ],
        ),
      ),
      body: gamificationState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildProgressTab(gamificationState),
                _buildMissionsTab(gamificationState),
                _buildBadgesTab(gamificationState),
                _buildLeaderboardTab(gamificationState),
              ],
            ),
    );
  }

  Widget _buildProgressTab(GamificationState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Level Progress Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          '${state.currentLevel}',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Level ${state.currentLevel} YOLO Warrior',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${state.pointsToNextLevel} points to next level',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: state.levelProgress,
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${state.currentLevelPoints} XP',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        '${state.nextLevelPoints} XP',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Stats Grid
          Text(
            'Your Stats',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: [
              _buildStatCard(
                'Total Points',
                '${state.totalPoints}',
                Icons.stars,
                Colors.orange,
              ),
              _buildStatCard(
                'Current Streak',
                '${state.currentStreak} days',
                Icons.local_fire_department,
                Colors.red,
              ),
              _buildStatCard(
                'Missions Completed',
                '${state.completedMissions}',
                Icons.check_circle,
                Colors.green,
              ),
              _buildStatCard(
                'Badges Earned',
                '${state.badges.length}',
                Icons.military_tech,
                Colors.blue,
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Weekly Activity Chart
          Text(
            'Weekly Activity',
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
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                            return Text(
                              days[value.toInt() % 7],
                              style: Theme.of(context).textTheme.bodySmall,
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: _generateWeeklyData(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionsTab(GamificationState state) {
    return RefreshIndicator(
      onRefresh: () => ref.read(gamificationStateProvider.notifier).loadMissions(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Missions
            Text(
              'Daily Missions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...state.dailyMissions.map((mission) => _buildMissionCard(mission, true)),

            const SizedBox(height: 24),

            // Weekly Missions
            Text(
              'Weekly Missions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...state.weeklyMissions.map((mission) => _buildMissionCard(mission, false)),

            const SizedBox(height: 24),

            // Special Missions
            if (state.specialMissions.isNotEmpty) ...[
              Text(
                'Special Missions',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...state.specialMissions.map((mission) => _buildMissionCard(mission, false)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBadgesTab(GamificationState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Badges (${state.badges.length})',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          if (state.badges.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(
                      Icons.military_tech,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No badges yet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Complete missions and help others to earn badges!',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemCount: state.badges.length,
              itemBuilder: (context, index) {
                final badge = state.badges[index];
                return _buildBadgeCard(badge);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildLeaderboardTab(GamificationState state) {
    return RefreshIndicator(
      onRefresh: () => ref.read(gamificationStateProvider.notifier).loadLeaderboard(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Top YOLO Warriors',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            if (state.leaderboard.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.leaderboard,
                        size: 48,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Leaderboard loading...',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.leaderboard.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final entry = state.leaderboard[index];
                  final isCurrentUser = entry.userId == ref.read(authStateProvider).user?.id;
                  return _buildLeaderboardEntry(entry, index + 1, isCurrentUser);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionCard(Mission mission, bool isDaily) {
    final isCompleted = mission.isCompleted;
    final progress = mission.progress / mission.targetValue;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: isCompleted 
                      ? Colors.green 
                      : Theme.of(context).colorScheme.primary,
                  child: Icon(
                    isCompleted ? Icons.check : _getMissionIcon(mission.type),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mission.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        mission.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '+${mission.points} XP',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (isDaily)
                      Text(
                        'Daily',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.orange,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            ),
            const SizedBox(height: 4),
            Text(
              '${mission.progress}/${mission.targetValue} ${mission.unit}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadgeCard(Badge badge) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getBadgeColor(badge.tier).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getBadgeIcon(badge.type),
                size: 32,
                color: _getBadgeColor(badge.tier),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              badge.title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              badge.description,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderboardEntry(LeaderboardEntry entry, int rank, bool isCurrentUser) {
    return Card(
      color: isCurrentUser 
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getRankColor(rank),
          child: Text(
            '$rank',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          entry.userName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: isCurrentUser ? FontWeight.bold : null,
          ),
        ),
        subtitle: Text('Level ${entry.level} • ${entry.points} XP'),
        trailing: Icon(
          _getRankIcon(rank),
          color: _getRankColor(rank),
        ),
      ),
    );
  }

  List<BarChartGroupData> _generateWeeklyData() {
    // Generate sample weekly activity data
    return List.generate(7, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: (index + 1) * 10.0 + (index * 5),
            color: Theme.of(context).colorScheme.primary,
            width: 16,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    });
  }

  IconData _getMissionIcon(MissionType type) {
    switch (type) {
      case MissionType.helpRequests:
        return Icons.volunteer_activism;
      case MissionType.chatMessages:
        return Icons.chat;
      case MissionType.needsCreated:
        return Icons.add_circle;
      case MissionType.dailyLogin:
        return Icons.login;
      case MissionType.profileCompletion:
        return Icons.person;
    }
  }

  IconData _getBadgeIcon(BadgeType type) {
    switch (type) {
      case BadgeType.helper:
        return Icons.volunteer_activism;
      case BadgeType.communicator:
        return Icons.chat;
      case BadgeType.creator:
        return Icons.create;
      case BadgeType.socialite:
        return Icons.people;
      case BadgeType.achiever:
        return Icons.emoji_events;
    }
  }

  Color _getBadgeColor(BadgeTier tier) {
    switch (tier) {
      case BadgeTier.bronze:
        return Colors.brown;
      case BadgeTier.silver:
        return Colors.grey;
      case BadgeTier.gold:
        return Colors.amber;
      case BadgeTier.platinum:
        return Colors.cyan;
      case BadgeTier.diamond:
        return Colors.blue;
    }
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return Colors.amber; // Gold
      case 2:
        return Colors.grey; // Silver
      case 3:
        return Colors.brown; // Bronze
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _getRankIcon(int rank) {
    switch (rank) {
      case 1:
        return Icons.emoji_events;
      case 2:
        return Icons.military_tech;
      case 3:
        return Icons.workspace_premium;
      default:
        return Icons.star;
    }
  }

  void _showYOLOWarriorInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('YOLO Warrior System'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Welcome to the YOLO Warrior System!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Earn XP by:\n'
                '• Completing daily and weekly missions\n'
                '• Helping community members\n'
                '• Creating helpful content\n'
                '• Engaging with the community\n\n'
                'Level up to unlock new badges and climb the leaderboard!',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
} 