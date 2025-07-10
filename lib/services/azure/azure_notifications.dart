import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../models/notification_model.dart';

class AzureNotificationService {
  static const String _baseUrl = 'https://your-namespace.servicebus.windows.net/your-hub';
  static const String _sasToken = 'your-sas-token'; // In production, get this securely
  
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  
  // Notification categories
  static const String _needUpdates = 'need-updates';
  static const String _missionUnlock = 'mission-unlock';
  static const String _adminBroadcasts = 'admin-broadcasts';
  static const String _chatMessages = 'chat-messages';
  static const String _reviewReceived = 'review-received';
  static const String _helperMatched = 'helper-matched';

  // Initialize notification service
  Future<void> initialize() async {
    await _initializeLocalNotifications();
    await _initializeFirebaseMessaging();
    await _requestPermissions();
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  Future<void> _initializeFirebaseMessaging() async {
    // Get FCM token
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      await _registerDevice(token);
    }

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((token) {
      _registerDevice(token);
    });

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
  }

  Future<void> _requestPermissions() async {
    // Request notification permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> _registerDevice(String token) async {
    try {
      // Register device with Azure Notification Hubs
      final response = await http.post(
        Uri.parse('$_baseUrl/registrations'),
        headers: {
          'Authorization': 'SharedAccessSignature $_sasToken',
          'Content-Type': 'application/json',
          'ServiceBusNotification-Format': 'gcm',
        },
        body: jsonEncode({
          'RegistrationId': token,
          'Tags': ['all'], // Add user-specific tags here
        }),
      );

      if (response.statusCode == 200) {
        print('Device registered successfully');
      } else {
        print('Failed to register device: ${response.statusCode}');
      }
    } catch (e) {
      print('Error registering device: $e');
    }
  }

  // Send notification to specific user
  Future<void> sendNotificationToUser({
    required String userId,
    required String title,
    required String body,
    String? category,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/messages'),
        headers: {
          'Authorization': 'SharedAccessSignature $_sasToken',
          'Content-Type': 'application/json',
          'ServiceBusNotification-Format': 'gcm',
          'X-WNS-Type': 'wns/toast',
        },
        body: jsonEncode({
          'data': {
            'title': title,
            'body': body,
            'category': category ?? 'general',
            'userId': userId,
            ...?data,
          },
          'to': 'tag:user-$userId',
        }),
      );

      if (response.statusCode == 201) {
        print('Notification sent successfully');
      } else {
        print('Failed to send notification: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  // Send notification to topic subscribers
  Future<void> sendNotificationToTopic({
    required String topic,
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/messages'),
        headers: {
          'Authorization': 'SharedAccessSignature $_sasToken',
          'Content-Type': 'application/json',
          'ServiceBusNotification-Format': 'gcm',
          'X-WNS-Type': 'wns/toast',
        },
        body: jsonEncode({
          'data': {
            'title': title,
            'body': body,
            'topic': topic,
            ...?data,
          },
          'to': 'tag:topic-$topic',
        }),
      );

      if (response.statusCode == 201) {
        print('Topic notification sent successfully');
      } else {
        print('Failed to send topic notification: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending topic notification: $e');
    }
  }

  // Send broadcast to all users
  Future<void> sendBroadcast({
    required String title,
    required String body,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/messages'),
        headers: {
          'Authorization': 'SharedAccessSignature $_sasToken',
          'Content-Type': 'application/json',
          'ServiceBusNotification-Format': 'gcm',
          'X-WNS-Type': 'wns/toast',
        },
        body: jsonEncode({
          'data': {
            'title': title,
            'body': body,
            'category': _adminBroadcasts,
            ...?data,
          },
          'to': 'tag:all',
        }),
      );

      if (response.statusCode == 201) {
        print('Broadcast sent successfully');
      } else {
        print('Failed to send broadcast: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending broadcast: $e');
    }
  }

  // Subscribe to notification topics
  Future<void> subscribeToTopic(String topic) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/subscriptions'),
        headers: {
          'Authorization': 'SharedAccessSignature $_sasToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'TopicPath': topic,
          'SubscriptionName': 'user-subscription',
        }),
      );

      if (response.statusCode == 201) {
        print('Subscribed to topic: $topic');
      } else {
        print('Failed to subscribe to topic: ${response.statusCode}');
      }
    } catch (e) {
      print('Error subscribing to topic: $e');
    }
  }

  // Unsubscribe from notification topics
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/subscriptions/$topic'),
        headers: {
          'Authorization': 'SharedAccessSignature $_sasToken',
        },
      );

      if (response.statusCode == 200) {
        print('Unsubscribed from topic: $topic');
      } else {
        print('Failed to unsubscribe from topic: ${response.statusCode}');
      }
    } catch (e) {
      print('Error unsubscribing from topic: $e');
    }
  }

  // Show local notification
  Future<void> showLocalNotification({
    required String title,
    required String body,
    String? payload,
    NotificationCategory category = NotificationCategory.general,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'yolo_notifications',
      'YOLO Notifications',
      channelDescription: 'Notifications for YOLO Need App',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  // Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap based on payload
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      _handleNotificationTap(data);
    }
  }

  void _handleNotificationTap(Map<String, dynamic> data) {
    // Navigate based on notification type
    switch (data['category']) {
      case _needUpdates:
        // Navigate to need timeline
        break;
      case _missionUnlock:
        // Navigate to gamification screen
        break;
      case _chatMessages:
        // Navigate to chat screen
        break;
      case _reviewReceived:
        // Navigate to reviews screen
        break;
      case _helperMatched:
        // Navigate to need details
        break;
      default:
        // Navigate to home screen
        break;
    }
  }

  // Handle foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      
      // Show local notification
      showLocalNotification(
        title: message.notification!.title ?? 'New Notification',
        body: message.notification!.body ?? '',
        payload: jsonEncode(message.data),
      );
    }
  }

  // Get notification settings
  Future<NotificationSettings> getNotificationSettings() async {
    return await _firebaseMessaging.getNotificationSettings();
  }

  // Update notification preferences
  Future<void> updateNotificationPreferences({
    bool? needUpdates,
    bool? missionUnlock,
    bool? adminBroadcasts,
    bool? chatMessages,
    bool? reviewReceived,
    bool? helperMatched,
  }) async {
    // Update user preferences in backend
    // This would typically involve updating user settings in Cosmos DB
    
    // Update topic subscriptions based on preferences
    if (needUpdates == true) {
      await subscribeToTopic(_needUpdates);
    } else if (needUpdates == false) {
      await unsubscribeFromTopic(_needUpdates);
    }

    if (missionUnlock == true) {
      await subscribeToTopic(_missionUnlock);
    } else if (missionUnlock == false) {
      await unsubscribeFromTopic(_missionUnlock);
    }

    // Continue for other notification types...
  }

  // Get notification history
  Future<List<NotificationModel>> getNotificationHistory() async {
    // TODO: Fetch notification history from Cosmos DB
    return [];
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    // TODO: Update notification status in Cosmos DB
  }

  // Delete notification
  Future<void> deleteNotification(String notificationId) async {
    // TODO: Delete notification from Cosmos DB
  }

  // Clear all notifications
  Future<void> clearAllNotifications() async {
    await _localNotifications.cancelAll();
    // TODO: Mark all notifications as deleted in Cosmos DB
  }

  // Get unread notification count
  Future<int> getUnreadNotificationCount() async {
    // TODO: Get count from Cosmos DB
    return 0;
  }
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
  
  // Show local notification for background messages
  final FlutterLocalNotificationsPlugin localNotifications = 
      FlutterLocalNotificationsPlugin();
  
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'yolo_notifications',
    'YOLO Notifications',
    channelDescription: 'Notifications for YOLO Need App',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await localNotifications.show(
    DateTime.now().millisecondsSinceEpoch.remainder(100000),
    message.notification?.title ?? 'New Notification',
    message.notification?.body ?? '',
    platformChannelSpecifics,
  );
}

// Notification categories enum
enum NotificationCategory {
  general,
  needUpdates,
  missionUnlock,
  adminBroadcasts,
  chatMessages,
  reviewReceived,
  helperMatched,
} 