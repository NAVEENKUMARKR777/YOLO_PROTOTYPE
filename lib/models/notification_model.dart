import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

enum NotificationType {
  @JsonValue('need_update')
  needUpdate,
  @JsonValue('mission_unlock')
  missionUnlock,
  @JsonValue('admin_broadcast')
  adminBroadcast,
  @JsonValue('chat_message')
  chatMessage,
  @JsonValue('need_completion')
  needCompletion,
  @JsonValue('helper_assigned')
  helperAssigned,
  @JsonValue('badge_earned')
  badgeEarned,
  @JsonValue('level_up')
  levelUp,
  @JsonValue('reminder')
  reminder,
  @JsonValue('system')
  system,
}

enum NotificationPriority {
  @JsonValue('low')
  low,
  @JsonValue('normal')
  normal,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum NotificationChannel {
  @JsonValue('push')
  push,
  @JsonValue('email')
  email,
  @JsonValue('sms')
  sms,
  @JsonValue('in_app')
  inApp,
}

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String body,
    
    // Priority and Channel
    required NotificationPriority priority,
    required List<NotificationChannel> channels,
    
    // Content
    String? imageUrl,
    String? iconUrl,
    Map<String, dynamic>? data,
    Map<String, String>? actions,
    
    // Targeting
    String? topic,
    List<String>? tags,
    Map<String, String>? customData,
    
    // Context
    String? relatedNeedId,
    String? relatedChatId,
    String? relatedMissionId,
    String? relatedUserId,
    
    // Delivery
    @Default(false) bool isDelivered,
    @Default(false) bool isRead,
    @Default(false) bool isClicked,
    DateTime? deliveredAt,
    DateTime? readAt,
    DateTime? clickedAt,
    
    // Azure Integration
    String? azureNotificationId,
    Map<String, dynamic>? azureResponse,
    String? azureOutcome,
    
    // Scheduling
    DateTime? scheduledFor,
    @Default(false) bool isScheduled,
    
    // Status
    @Default(true) bool isActive,
    @Default(false) bool isExpired,
    DateTime? expiresAt,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Notification;

  factory Notification.fromJson(Map<String, dynamic> json) => _$NotificationFromJson(json);
}

@freezed
class NotificationTemplate with _$NotificationTemplate {
  const factory NotificationTemplate({
    required String id,
    required String name,
    required NotificationType type,
    required String titleTemplate,
    required String bodyTemplate,
    
    // Customization
    String? imageUrl,
    String? iconUrl,
    Map<String, String>? actionTemplates,
    
    // Configuration
    NotificationPriority? defaultPriority,
    List<NotificationChannel>? defaultChannels,
    Map<String, dynamic>? defaultData,
    
    // Localization
    Map<String, String>? localizedTitles,
    Map<String, String>? localizedBodies,
    
    // Variables
    List<String>? requiredVariables,
    Map<String, String>? variableDescriptions,
    
    // Status
    @Default(true) bool isActive,
    @Default(false) bool isDefault,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationTemplate;

  factory NotificationTemplate.fromJson(Map<String, dynamic> json) => _$NotificationTemplateFromJson(json);
}

@freezed
class NotificationPreferences with _$NotificationPreferences {
  const factory NotificationPreferences({
    required String userId,
    
    // Channel Preferences
    @Default(true) bool pushEnabled,
    @Default(true) bool emailEnabled,
    @Default(false) bool smsEnabled,
    @Default(true) bool inAppEnabled,
    
    // Type Preferences
    @Default(true) bool needUpdates,
    @Default(true) bool missionUnlocks,
    @Default(true) bool adminBroadcasts,
    @Default(true) bool chatMessages,
    @Default(true) bool needCompletions,
    @Default(true) bool helperAssignments,
    @Default(true) bool badgeEarned,
    @Default(true) bool levelUp,
    @Default(true) bool reminders,
    @Default(true) bool systemNotifications,
    
    // Timing Preferences
    String? quietHoursStart,
    String? quietHoursEnd,
    String? timezone,
    List<int>? allowedDays,
    
    // Frequency Limits
    int? maxDailyNotifications,
    int? maxHourlyNotifications,
    Duration? minimumInterval,
    
    // Topics & Tags
    List<String>? subscribedTopics,
    List<String>? blockedTopics,
    List<String>? subscribedTags,
    List<String>? blockedTags,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NotificationPreferences;

  factory NotificationPreferences.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesFromJson(json);
}

@freezed
class PushToken with _$PushToken {
  const factory PushToken({
    required String id,
    required String userId,
    required String token,
    required String platform,
    required String deviceId,
    
    // Device Information
    String? deviceName,
    String? deviceModel,
    String? osVersion,
    String? appVersion,
    
    // Azure Integration
    String? azureRegistrationId,
    List<String>? azureTags,
    Map<String, dynamic>? azureProperties,
    
    // Status
    @Default(true) bool isActive,
    @Default(false) bool isExpired,
    DateTime? lastUsedAt,
    DateTime? expiresAt,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _PushToken;

  factory PushToken.fromJson(Map<String, dynamic> json) => _$PushTokenFromJson(json);
}

@freezed
class NotificationBatch with _$NotificationBatch {
  const factory NotificationBatch({
    required String id,
    required String name,
    required List<String> notificationIds,
    
    // Targeting
    List<String>? userIds,
    List<String>? topics,
    List<String>? tags,
    Map<String, String>? filters,
    
    // Scheduling
    DateTime? scheduledFor,
    @Default(false) bool isScheduled,
    
    // Status
    required String status,
    @Default(0) int totalRecipients,
    @Default(0) int successfulDeliveries,
    @Default(0) int failedDeliveries,
    
    // Azure Integration
    String? azureBatchId,
    Map<String, dynamic>? azureResponse,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? completedAt,
  }) = _NotificationBatch;

  factory NotificationBatch.fromJson(Map<String, dynamic> json) => _$NotificationBatchFromJson(json);
} 