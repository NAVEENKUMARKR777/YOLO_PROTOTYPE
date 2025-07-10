import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../providers/auth_provider.dart';
import '../../providers/gamification_provider.dart';
import '../../providers/app_provider.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load user data when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gamificationStateProvider.notifier).loadUserProgress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final gamificationState = ref.watch(gamificationStateProvider);
    final appState = ref.watch(appStateProvider);
    final user = authState.user;

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(authStateProvider.notifier).refreshUser();
          await ref.read(gamificationStateProvider.notifier).loadUserProgress();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Header
              _buildProfileHeader(user, gamificationState),
              
              const SizedBox(height: 24),

              // Role-specific stats
              _buildRoleStats(user, gamificationState),
              
              const SizedBox(height: 24),

              // Recent achievements
              _buildRecentAchievements(gamificationState),
              
              const SizedBox(height: 24),

              // Profile sections
              _buildProfileSections(user, context),

              const SizedBox(height: 24),

              // Account actions
              _buildAccountActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(User user, GamificationState gamificationState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile picture and basic info
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: user.profileImageUrl.isNotEmpty
                          ? NetworkImage(user.profileImageUrl)
                          : null,
                      child: user.profileImageUrl.isEmpty
                          ? Text(
                              '${user.firstName[0]}${user.lastName[0]}',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 14),
                          color: Colors.white,
                          onPressed: _changeProfilePicture,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            _getRoleIcon(user.role),
                            size: 16,
                            color: _getRoleColor(user.role),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _getRoleDisplayName(user.role),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: _getRoleColor(user.role),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      if (user.bio.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          user.bio,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Level and progress
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Level ${gamificationState.currentLevel}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        'YOLO Warrior',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${gamificationState.totalPoints}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      Text(
                        'Total Points',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Theme.of(context).colorScheme.outline,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '${gamificationState.currentStreak}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Day Streak',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Progress to next level
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress to Level ${gamificationState.currentLevel + 1}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      '${gamificationState.pointsToNextLevel} XP to go',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: gamificationState.levelProgress,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleStats(User user, GamificationState gamificationState) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_getRoleDisplayName(user.role)} Stats',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: _getRoleStatCards(user.role, gamificationState),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAchievements(GamificationState gamificationState) {
    final recentBadges = gamificationState.badges.take(3).toList();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Achievements',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () => context.go('/gamification'),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            if (recentBadges.isEmpty)
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.military_tech,
                      size: 48,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'No achievements yet',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Complete missions to earn badges!',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            else
              Row(
                children: recentBadges.map((badge) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.military_tech,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          badge.title,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSections(User user, BuildContext context) {
    return Column(
      children: [
        _buildProfileSection(
          'Personal Information',
          Icons.person,
          [
            _buildProfileItem('Email', user.email, Icons.email),
            _buildProfileItem('Phone', user.phoneNumber, Icons.phone),
            _buildProfileItem('Location', user.location, Icons.location_on),
            _buildProfileItem('Joined', _formatDate(user.createdAt), Icons.calendar_today),
          ],
          onTap: () => _editPersonalInfo(context),
        ),
        
        const SizedBox(height: 16),
        
        _buildProfileSection(
          'Privacy & Security',
          Icons.security,
          [
            _buildProfileItem('Email Notifications', 'Enabled', Icons.notifications),
            _buildProfileItem('Location Sharing', 'On', Icons.location_sharing),
            _buildProfileItem('Profile Visibility', 'Public', Icons.visibility),
          ],
          onTap: () => _showPrivacySettings(context),
        ),
        
        const SizedBox(height: 16),
        
        _buildProfileSection(
          'Help & Support',
          Icons.help,
          [
            _buildProfileItem('FAQ', 'Get answers', Icons.question_answer),
            _buildProfileItem('Contact Support', 'Get help', Icons.support_agent),
            _buildProfileItem('Community Guidelines', 'Learn more', Icons.gavel),
          ],
          onTap: () => _showHelpSupport(context),
        ),
      ],
    );
  }

  Widget _buildProfileSection(
    String title,
    IconData icon,
    List<Widget> items,
    {VoidCallback? onTap}
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              ...items,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not set' : value,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountActions(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _showEditProfileDialog(context),
            icon: const Icon(Icons.edit),
            label: const Text('Edit Profile'),
          ),
        ),
        
        const SizedBox(height: 12),
        
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _exportData(context),
            icon: const Icon(Icons.download),
            label: const Text('Export My Data'),
          ),
        ),
        
        const SizedBox(height: 12),
        
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _showSignOutDialog(context),
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.red,
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _getRoleStatCards(UserRole role, GamificationState gamificationState) {
    switch (role) {
      case UserRole.seeker:
        return [
          _buildStatCard('Needs Created', '12', Icons.add_circle, Colors.blue),
          _buildStatCard('Help Received', '8', Icons.volunteer_activism, Colors.green),
          _buildStatCard('Active Needs', '3', Icons.hourglass_empty, Colors.orange),
          _buildStatCard('Avg Response', '2.5 hrs', Icons.schedule, Colors.purple),
        ];
      case UserRole.helper:
        return [
          _buildStatCard('People Helped', '25', Icons.people, Colors.green),
          _buildStatCard('Help Offers', '42', Icons.volunteer_activism, Colors.blue),
          _buildStatCard('Response Rate', '94%', Icons.trending_up, Colors.orange),
          _buildStatCard('Avg Rating', '4.8/5', Icons.star, Colors.amber),
        ];
      case UserRole.business:
        return [
          _buildStatCard('Services Posted', '15', Icons.business_center, Colors.blue),
          _buildStatCard('Customers Served', '67', Icons.people, Colors.green),
          _buildStatCard('Service Rating', '4.9/5', Icons.star, Colors.amber),
          _buildStatCard('Response Time', '1.2 hrs', Icons.schedule, Colors.orange),
        ];
      case UserRole.admin:
        return [
          _buildStatCard('Users Managed', '1.2k', Icons.people, Colors.blue),
          _buildStatCard('Needs Reviewed', '345', Icons.visibility, Colors.green),
          _buildStatCard('Issues Resolved', '89', Icons.check_circle, Colors.orange),
          _buildStatCard('Reports Handled', '23', Icons.report, Colors.red),
        ];
    }
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.seeker:
        return Icons.help;
      case UserRole.helper:
        return Icons.volunteer_activism;
      case UserRole.business:
        return Icons.business;
      case UserRole.admin:
        return Icons.admin_panel_settings;
    }
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.seeker:
        return Colors.blue;
      case UserRole.helper:
        return Colors.green;
      case UserRole.business:
        return Colors.orange;
      case UserRole.admin:
        return Colors.purple;
    }
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.seeker:
        return 'Help Seeker';
      case UserRole.helper:
        return 'Community Helper';
      case UserRole.business:
        return 'Service Provider';
      case UserRole.admin:
        return 'Administrator';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _changeProfilePicture() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      // TODO: Upload image and update profile
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile picture updated!')),
      );
    }
  }

  void _showSettingsDialog(BuildContext context) {
    final appState = ref.read(appStateProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: appState.themeMode == ThemeMode.dark,
              onChanged: (value) {
                ref.read(appStateProvider.notifier).setThemeMode(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
            SwitchListTile(
              title: const Text('Notifications'),
              value: appState.notificationsEnabled,
              onChanged: (value) {
                ref.read(appStateProvider.notifier).setNotificationsEnabled(value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    // TODO: Implement profile editing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile editing coming soon!')),
    );
  }

  void _editPersonalInfo(BuildContext context) {
    // TODO: Navigate to personal info editing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Personal info editing coming soon!')),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    // TODO: Show privacy settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Privacy settings coming soon!')),
    );
  }

  void _showHelpSupport(BuildContext context) {
    // TODO: Show help and support
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Help & support coming soon!')),
    );
  }

  void _exportData(BuildContext context) {
    // TODO: Implement data export
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data export feature coming soon!')),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(authStateProvider.notifier).signOut();
              context.go('/auth/login');
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
} 