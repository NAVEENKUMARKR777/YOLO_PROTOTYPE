// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationImpl _$$NotificationImplFromJson(Map<String, dynamic> json) =>
    _$NotificationImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      priority: $enumDecode(_$NotificationPriorityEnumMap, json['priority']),
      channels: (json['channels'] as List<dynamic>)
          .map((e) => $enumDecode(_$NotificationChannelEnumMap, e))
          .toList(),
      imageUrl: json['imageUrl'] as String?,
      iconUrl: json['iconUrl'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      actions: (json['actions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      topic: json['topic'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      customData: (json['customData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      relatedNeedId: json['relatedNeedId'] as String?,
      relatedChatId: json['relatedChatId'] as String?,
      relatedMissionId: json['relatedMissionId'] as String?,
      relatedUserId: json['relatedUserId'] as String?,
      isDelivered: json['isDelivered'] as bool? ?? false,
      isRead: json['isRead'] as bool? ?? false,
      isClicked: json['isClicked'] as bool? ?? false,
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      clickedAt: json['clickedAt'] == null
          ? null
          : DateTime.parse(json['clickedAt'] as String),
      azureNotificationId: json['azureNotificationId'] as String?,
      azureResponse: json['azureResponse'] as Map<String, dynamic>?,
      azureOutcome: json['azureOutcome'] as String?,
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.parse(json['scheduledFor'] as String),
      isScheduled: json['isScheduled'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      isExpired: json['isExpired'] as bool? ?? false,
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NotificationImplToJson(_$NotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'priority': _$NotificationPriorityEnumMap[instance.priority]!,
      'channels': instance.channels
          .map((e) => _$NotificationChannelEnumMap[e]!)
          .toList(),
      'imageUrl': instance.imageUrl,
      'iconUrl': instance.iconUrl,
      'data': instance.data,
      'actions': instance.actions,
      'topic': instance.topic,
      'tags': instance.tags,
      'customData': instance.customData,
      'relatedNeedId': instance.relatedNeedId,
      'relatedChatId': instance.relatedChatId,
      'relatedMissionId': instance.relatedMissionId,
      'relatedUserId': instance.relatedUserId,
      'isDelivered': instance.isDelivered,
      'isRead': instance.isRead,
      'isClicked': instance.isClicked,
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'readAt': instance.readAt?.toIso8601String(),
      'clickedAt': instance.clickedAt?.toIso8601String(),
      'azureNotificationId': instance.azureNotificationId,
      'azureResponse': instance.azureResponse,
      'azureOutcome': instance.azureOutcome,
      'scheduledFor': instance.scheduledFor?.toIso8601String(),
      'isScheduled': instance.isScheduled,
      'isActive': instance.isActive,
      'isExpired': instance.isExpired,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.needUpdate: 'need_update',
  NotificationType.missionUnlock: 'mission_unlock',
  NotificationType.adminBroadcast: 'admin_broadcast',
  NotificationType.chatMessage: 'chat_message',
  NotificationType.needCompletion: 'need_completion',
  NotificationType.helperAssigned: 'helper_assigned',
  NotificationType.badgeEarned: 'badge_earned',
  NotificationType.levelUp: 'level_up',
  NotificationType.reminder: 'reminder',
  NotificationType.system: 'system',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.low: 'low',
  NotificationPriority.normal: 'normal',
  NotificationPriority.high: 'high',
  NotificationPriority.urgent: 'urgent',
};

const _$NotificationChannelEnumMap = {
  NotificationChannel.push: 'push',
  NotificationChannel.email: 'email',
  NotificationChannel.sms: 'sms',
  NotificationChannel.inApp: 'in_app',
};

_$NotificationTemplateImpl _$$NotificationTemplateImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationTemplateImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      titleTemplate: json['titleTemplate'] as String,
      bodyTemplate: json['bodyTemplate'] as String,
      imageUrl: json['imageUrl'] as String?,
      iconUrl: json['iconUrl'] as String?,
      actionTemplates: (json['actionTemplates'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      defaultPriority: $enumDecodeNullable(
          _$NotificationPriorityEnumMap, json['defaultPriority']),
      defaultChannels: (json['defaultChannels'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$NotificationChannelEnumMap, e))
          .toList(),
      defaultData: json['defaultData'] as Map<String, dynamic>?,
      localizedTitles: (json['localizedTitles'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      localizedBodies: (json['localizedBodies'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      requiredVariables: (json['requiredVariables'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      variableDescriptions:
          (json['variableDescriptions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      isActive: json['isActive'] as bool? ?? true,
      isDefault: json['isDefault'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NotificationTemplateImplToJson(
        _$NotificationTemplateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'titleTemplate': instance.titleTemplate,
      'bodyTemplate': instance.bodyTemplate,
      'imageUrl': instance.imageUrl,
      'iconUrl': instance.iconUrl,
      'actionTemplates': instance.actionTemplates,
      'defaultPriority':
          _$NotificationPriorityEnumMap[instance.defaultPriority],
      'defaultChannels': instance.defaultChannels
          ?.map((e) => _$NotificationChannelEnumMap[e]!)
          .toList(),
      'defaultData': instance.defaultData,
      'localizedTitles': instance.localizedTitles,
      'localizedBodies': instance.localizedBodies,
      'requiredVariables': instance.requiredVariables,
      'variableDescriptions': instance.variableDescriptions,
      'isActive': instance.isActive,
      'isDefault': instance.isDefault,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$NotificationPreferencesImpl _$$NotificationPreferencesImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationPreferencesImpl(
      userId: json['userId'] as String,
      pushEnabled: json['pushEnabled'] as bool? ?? true,
      emailEnabled: json['emailEnabled'] as bool? ?? true,
      smsEnabled: json['smsEnabled'] as bool? ?? false,
      inAppEnabled: json['inAppEnabled'] as bool? ?? true,
      needUpdates: json['needUpdates'] as bool? ?? true,
      missionUnlocks: json['missionUnlocks'] as bool? ?? true,
      adminBroadcasts: json['adminBroadcasts'] as bool? ?? true,
      chatMessages: json['chatMessages'] as bool? ?? true,
      needCompletions: json['needCompletions'] as bool? ?? true,
      helperAssignments: json['helperAssignments'] as bool? ?? true,
      badgeEarned: json['badgeEarned'] as bool? ?? true,
      levelUp: json['levelUp'] as bool? ?? true,
      reminders: json['reminders'] as bool? ?? true,
      systemNotifications: json['systemNotifications'] as bool? ?? true,
      quietHoursStart: json['quietHoursStart'] as String?,
      quietHoursEnd: json['quietHoursEnd'] as String?,
      timezone: json['timezone'] as String?,
      allowedDays: (json['allowedDays'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      maxDailyNotifications: (json['maxDailyNotifications'] as num?)?.toInt(),
      maxHourlyNotifications: (json['maxHourlyNotifications'] as num?)?.toInt(),
      minimumInterval: json['minimumInterval'] == null
          ? null
          : Duration(microseconds: (json['minimumInterval'] as num).toInt()),
      subscribedTopics: (json['subscribedTopics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      blockedTopics: (json['blockedTopics'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      subscribedTags: (json['subscribedTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      blockedTags: (json['blockedTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$NotificationPreferencesImplToJson(
        _$NotificationPreferencesImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'pushEnabled': instance.pushEnabled,
      'emailEnabled': instance.emailEnabled,
      'smsEnabled': instance.smsEnabled,
      'inAppEnabled': instance.inAppEnabled,
      'needUpdates': instance.needUpdates,
      'missionUnlocks': instance.missionUnlocks,
      'adminBroadcasts': instance.adminBroadcasts,
      'chatMessages': instance.chatMessages,
      'needCompletions': instance.needCompletions,
      'helperAssignments': instance.helperAssignments,
      'badgeEarned': instance.badgeEarned,
      'levelUp': instance.levelUp,
      'reminders': instance.reminders,
      'systemNotifications': instance.systemNotifications,
      'quietHoursStart': instance.quietHoursStart,
      'quietHoursEnd': instance.quietHoursEnd,
      'timezone': instance.timezone,
      'allowedDays': instance.allowedDays,
      'maxDailyNotifications': instance.maxDailyNotifications,
      'maxHourlyNotifications': instance.maxHourlyNotifications,
      'minimumInterval': instance.minimumInterval?.inMicroseconds,
      'subscribedTopics': instance.subscribedTopics,
      'blockedTopics': instance.blockedTopics,
      'subscribedTags': instance.subscribedTags,
      'blockedTags': instance.blockedTags,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$PushTokenImpl _$$PushTokenImplFromJson(Map<String, dynamic> json) =>
    _$PushTokenImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      token: json['token'] as String,
      platform: json['platform'] as String,
      deviceId: json['deviceId'] as String,
      deviceName: json['deviceName'] as String?,
      deviceModel: json['deviceModel'] as String?,
      osVersion: json['osVersion'] as String?,
      appVersion: json['appVersion'] as String?,
      azureRegistrationId: json['azureRegistrationId'] as String?,
      azureTags: (json['azureTags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      azureProperties: json['azureProperties'] as Map<String, dynamic>?,
      isActive: json['isActive'] as bool? ?? true,
      isExpired: json['isExpired'] as bool? ?? false,
      lastUsedAt: json['lastUsedAt'] == null
          ? null
          : DateTime.parse(json['lastUsedAt'] as String),
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$PushTokenImplToJson(_$PushTokenImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'token': instance.token,
      'platform': instance.platform,
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
      'deviceModel': instance.deviceModel,
      'osVersion': instance.osVersion,
      'appVersion': instance.appVersion,
      'azureRegistrationId': instance.azureRegistrationId,
      'azureTags': instance.azureTags,
      'azureProperties': instance.azureProperties,
      'isActive': instance.isActive,
      'isExpired': instance.isExpired,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$NotificationBatchImpl _$$NotificationBatchImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationBatchImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      notificationIds: (json['notificationIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      userIds:
          (json['userIds'] as List<dynamic>?)?.map((e) => e as String).toList(),
      topics:
          (json['topics'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      filters: (json['filters'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      scheduledFor: json['scheduledFor'] == null
          ? null
          : DateTime.parse(json['scheduledFor'] as String),
      isScheduled: json['isScheduled'] as bool? ?? false,
      status: json['status'] as String,
      totalRecipients: (json['totalRecipients'] as num?)?.toInt() ?? 0,
      successfulDeliveries:
          (json['successfulDeliveries'] as num?)?.toInt() ?? 0,
      failedDeliveries: (json['failedDeliveries'] as num?)?.toInt() ?? 0,
      azureBatchId: json['azureBatchId'] as String?,
      azureResponse: json['azureResponse'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$NotificationBatchImplToJson(
        _$NotificationBatchImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'notificationIds': instance.notificationIds,
      'userIds': instance.userIds,
      'topics': instance.topics,
      'tags': instance.tags,
      'filters': instance.filters,
      'scheduledFor': instance.scheduledFor?.toIso8601String(),
      'isScheduled': instance.isScheduled,
      'status': instance.status,
      'totalRecipients': instance.totalRecipients,
      'successfulDeliveries': instance.successfulDeliveries,
      'failedDeliveries': instance.failedDeliveries,
      'azureBatchId': instance.azureBatchId,
      'azureResponse': instance.azureResponse,
      'createdAt': instance.createdAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };
