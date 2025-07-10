import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/azure/azure_notifications.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
  final AzureNotificationService _notificationService = AzureNotificationService();
  
  // Notification preferences
  bool _needUpdates = true;
  bool _missionUnlock = true;
  bool _adminBroadcasts = false;
  bool _chatMessages = true;
  bool _reviewReceived = true;
  bool _helperMatched = true;
  
  // General settings
  bool _pushNotifications = true;
  bool _inAppNotifications = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  
  // Quiet hours
  bool _quietHoursEnabled = false;
  TimeOfDay _quietHoursStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietHoursEnd = const TimeOfDay(hour: 8, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadNotificationSettings();
  }

  Future<void> _loadNotificationSettings() async {
    // TODO: Load notification settings from backend
    // For now, using default values
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        actions: [
          TextButton(
            onPressed: _saveSettings,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General notification settings
            _buildSectionHeader('General Settings'),
            _buildGeneralSettings(),
            
            const SizedBox(height: 24),

            // Notification types
            _buildSectionHeader('Notification Types'),
            _buildNotificationTypes(),
            
            const SizedBox(height: 24),

            // Quiet hours
            _buildSectionHeader('Quiet Hours'),
            _buildQuietHoursSettings(),
            
            const SizedBox(height: 24),

            // Notification history
            _buildSectionHeader('Notification History'),
            _buildNotificationHistory(),
            
            const SizedBox(height: 24),

            // Test notification
            _buildSectionHeader('Test Notifications'),
            _buildTestNotifications(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildGeneralSettings() {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive notifications on your device'),
            value: _pushNotifications,
            onChanged: (value) {
              setState(() => _pushNotifications = value);
              if (!value) {
                // Disable all other notification types
                setState(() {
                  _needUpdates = false;
                  _missionUnlock = false;
                  _adminBroadcasts = false;
                  _chatMessages = false;
                  _reviewReceived = false;
                  _helperMatched = false;
                });
              }
            },
          ),
          SwitchListTile(
            title: const Text('In-App Notifications'),
            subtitle: const Text('Show notifications within the app'),
            value: _inAppNotifications,
            onChanged: (value) => setState(() => _inAppNotifications = value),
          ),
          SwitchListTile(
            title: const Text('Sound'),
            subtitle: const Text('Play sound for notifications'),
            value: _soundEnabled,
            onChanged: (value) => setState(() => _soundEnabled = value),
          ),
          SwitchListTile(
            title: const Text('Vibration'),
            subtitle: const Text('Vibrate device for notifications'),
            value: _vibrationEnabled,
            onChanged: (value) => setState(() => _vibrationEnabled = value),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTypes() {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Need Updates'),
            subtitle: const Text('Updates about your posted needs'),
            value: _needUpdates && _pushNotifications,
            onChanged: _pushNotifications ? (value) => setState(() => _needUpdates = value) : null,
            secondary: const Icon(Icons.update),
          ),
          SwitchListTile(
            title: const Text('Mission Unlocks'),
            subtitle: const Text('New missions and achievements'),
            value: _missionUnlock && _pushNotifications,
            onChanged: _pushNotifications ? (value) => setState(() => _missionUnlock = value) : null,
            secondary: const Icon(Icons.emoji_events),
          ),
          SwitchListTile(
            title: const Text('Admin Broadcasts'),
            subtitle: const Text('Important announcements from administrators'),
            value: _adminBroadcasts && _pushNotifications,
            onChanged: _pushNotifications ? (value) => setState(() => _adminBroadcasts = value) : null,
            secondary: const Icon(Icons.admin_panel_settings),
          ),
          SwitchListTile(
            title: const Text('Chat Messages'),
            subtitle: const Text('New messages in conversations'),
            value: _chatMessages && _pushNotifications,
            onChanged: _pushNotifications ? (value) => setState(() => _chatMessages = value) : null,
            secondary: const Icon(Icons.chat),
          ),
          SwitchListTile(
            title: const Text('Review Received'),
            subtitle: const Text('When someone reviews your help'),
            value: _reviewReceived && _pushNotifications,
            onChanged: _pushNotifications ? (value) => setState(() => _reviewReceived = value) : null,
            secondary: const Icon(Icons.star),
          ),
          SwitchListTile(
            title: const Text('Helper Matched'),
            subtitle: const Text('When a helper responds to your need'),
            value: _helperMatched && _pushNotifications,
            onChanged: _pushNotifications ? (value) => setState(() => _helperMatched = value) : null,
            secondary: const Icon(Icons.volunteer_activism),
          ),
        ],
      ),
    );
  }

  Widget _buildQuietHoursSettings() {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Enable Quiet Hours'),
            subtitle: const Text('Mute notifications during specified hours'),
            value: _quietHoursEnabled,
            onChanged: (value) => setState(() => _quietHoursEnabled = value),
          ),
          if (_quietHoursEnabled) ...[
            ListTile(
              title: const Text('Start Time'),
              subtitle: Text(_quietHoursStart.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(true),
            ),
            ListTile(
              title: const Text('End Time'),
              subtitle: Text(_quietHoursEnd.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(false),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Notifications will be muted from ${_quietHoursStart.format(context)} to ${_quietHoursEnd.format(context)}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNotificationHistory() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('View Notification History'),
            subtitle: const Text('See all your past notifications'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _viewNotificationHistory,
          ),
          ListTile(
            leading: const Icon(Icons.mark_email_read),
            title: const Text('Mark All as Read'),
            subtitle: const Text('Clear all unread notifications'),
            onTap: _markAllAsRead,
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep),
            title: const Text('Clear All Notifications'),
            subtitle: const Text('Delete all notification history'),
            onTap: _clearAllNotifications,
          ),
        ],
      ),
    );
  }

  Widget _buildTestNotifications() {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Test Push Notification'),
            subtitle: const Text('Send a test notification to your device'),
            onTap: _sendTestNotification,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Check Notification Permissions'),
            subtitle: const Text('Verify notification settings'),
            onTap: _checkNotificationPermissions,
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? _quietHoursStart : _quietHoursEnd,
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _quietHoursStart = picked;
        } else {
          _quietHoursEnd = picked;
        }
      });
    }
  }

  Future<void> _saveSettings() async {
    try {
      // Save notification preferences
      await _notificationService.updateNotificationPreferences(
        needUpdates: _needUpdates,
        missionUnlock: _missionUnlock,
        adminBroadcasts: _adminBroadcasts,
        chatMessages: _chatMessages,
        reviewReceived: _reviewReceived,
        helperMatched: _helperMatched,
      );

      // TODO: Save other settings to backend
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notification settings saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving settings: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _viewNotificationHistory() {
    // TODO: Navigate to notification history screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification history feature coming soon!')),
    );
  }

  Future<void> _markAllAsRead() async {
    try {
      await _notificationService.clearAllNotifications();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('All notifications marked as read'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error marking notifications as read: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _clearAllNotifications() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Notifications'),
        content: const Text('Are you sure you want to delete all notification history? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              try {
                await _notificationService.clearAllNotifications();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications cleared'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Error clearing notifications: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendTestNotification() async {
    try {
      await _notificationService.showLocalNotification(
        title: 'Test Notification',
        body: 'This is a test notification from YOLO Need App',
        category: NotificationCategory.general,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Test notification sent'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending test notification: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _checkNotificationPermissions() async {
    try {
      final settings = await _notificationService.getNotificationSettings();
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Notification Permissions'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Authorization Status: ${settings.authorizationStatus}'),
              const SizedBox(height: 8),
              Text('Alert: ${settings.alert}'),
              Text('Badge: ${settings.badge}'),
              Text('Sound: ${settings.sound}'),
              Text('Announcement: ${settings.announcement}'),
              Text('Car Play: ${settings.carPlay}'),
              Text('Critical Alert: ${settings.criticalAlert}'),
              Text('Provisional: ${settings.provisional}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error checking permissions: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
} 