// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Notification _$NotificationFromJson(Map<String, dynamic> json) {
  return _Notification.fromJson(json);
}

/// @nodoc
mixin _$Notification {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError; // Priority and Channel
  NotificationPriority get priority => throw _privateConstructorUsedError;
  List<NotificationChannel> get channels =>
      throw _privateConstructorUsedError; // Content
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  Map<String, String>? get actions =>
      throw _privateConstructorUsedError; // Targeting
  String? get topic => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  Map<String, String>? get customData =>
      throw _privateConstructorUsedError; // Context
  String? get relatedNeedId => throw _privateConstructorUsedError;
  String? get relatedChatId => throw _privateConstructorUsedError;
  String? get relatedMissionId => throw _privateConstructorUsedError;
  String? get relatedUserId => throw _privateConstructorUsedError; // Delivery
  bool get isDelivered => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;
  bool get isClicked => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime? get clickedAt =>
      throw _privateConstructorUsedError; // Azure Integration
  String? get azureNotificationId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get azureResponse => throw _privateConstructorUsedError;
  String? get azureOutcome => throw _privateConstructorUsedError; // Scheduling
  DateTime? get scheduledFor => throw _privateConstructorUsedError;
  bool get isScheduled => throw _privateConstructorUsedError; // Status
  bool get isActive => throw _privateConstructorUsedError;
  bool get isExpired => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Notification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationCopyWith<Notification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationCopyWith<$Res> {
  factory $NotificationCopyWith(
          Notification value, $Res Function(Notification) then) =
      _$NotificationCopyWithImpl<$Res, Notification>;
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String body,
      NotificationPriority priority,
      List<NotificationChannel> channels,
      String? imageUrl,
      String? iconUrl,
      Map<String, dynamic>? data,
      Map<String, String>? actions,
      String? topic,
      List<String>? tags,
      Map<String, String>? customData,
      String? relatedNeedId,
      String? relatedChatId,
      String? relatedMissionId,
      String? relatedUserId,
      bool isDelivered,
      bool isRead,
      bool isClicked,
      DateTime? deliveredAt,
      DateTime? readAt,
      DateTime? clickedAt,
      String? azureNotificationId,
      Map<String, dynamic>? azureResponse,
      String? azureOutcome,
      DateTime? scheduledFor,
      bool isScheduled,
      bool isActive,
      bool isExpired,
      DateTime? expiresAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$NotificationCopyWithImpl<$Res, $Val extends Notification>
    implements $NotificationCopyWith<$Res> {
  _$NotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? priority = null,
    Object? channels = null,
    Object? imageUrl = freezed,
    Object? iconUrl = freezed,
    Object? data = freezed,
    Object? actions = freezed,
    Object? topic = freezed,
    Object? tags = freezed,
    Object? customData = freezed,
    Object? relatedNeedId = freezed,
    Object? relatedChatId = freezed,
    Object? relatedMissionId = freezed,
    Object? relatedUserId = freezed,
    Object? isDelivered = null,
    Object? isRead = null,
    Object? isClicked = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
    Object? clickedAt = freezed,
    Object? azureNotificationId = freezed,
    Object? azureResponse = freezed,
    Object? azureOutcome = freezed,
    Object? scheduledFor = freezed,
    Object? isScheduled = null,
    Object? isActive = null,
    Object? isExpired = null,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority,
      channels: null == channels
          ? _value.channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<NotificationChannel>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      customData: freezed == customData
          ? _value.customData
          : customData // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      relatedNeedId: freezed == relatedNeedId
          ? _value.relatedNeedId
          : relatedNeedId // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedChatId: freezed == relatedChatId
          ? _value.relatedChatId
          : relatedChatId // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedMissionId: freezed == relatedMissionId
          ? _value.relatedMissionId
          : relatedMissionId // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedUserId: freezed == relatedUserId
          ? _value.relatedUserId
          : relatedUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelivered: null == isDelivered
          ? _value.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isClicked: null == isClicked
          ? _value.isClicked
          : isClicked // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clickedAt: freezed == clickedAt
          ? _value.clickedAt
          : clickedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      azureNotificationId: freezed == azureNotificationId
          ? _value.azureNotificationId
          : azureNotificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      azureResponse: freezed == azureResponse
          ? _value.azureResponse
          : azureResponse // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      azureOutcome: freezed == azureOutcome
          ? _value.azureOutcome
          : azureOutcome // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isScheduled: null == isScheduled
          ? _value.isScheduled
          : isScheduled // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpired: null == isExpired
          ? _value.isExpired
          : isExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationImplCopyWith<$Res>
    implements $NotificationCopyWith<$Res> {
  factory _$$NotificationImplCopyWith(
          _$NotificationImpl value, $Res Function(_$NotificationImpl) then) =
      __$$NotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      NotificationType type,
      String title,
      String body,
      NotificationPriority priority,
      List<NotificationChannel> channels,
      String? imageUrl,
      String? iconUrl,
      Map<String, dynamic>? data,
      Map<String, String>? actions,
      String? topic,
      List<String>? tags,
      Map<String, String>? customData,
      String? relatedNeedId,
      String? relatedChatId,
      String? relatedMissionId,
      String? relatedUserId,
      bool isDelivered,
      bool isRead,
      bool isClicked,
      DateTime? deliveredAt,
      DateTime? readAt,
      DateTime? clickedAt,
      String? azureNotificationId,
      Map<String, dynamic>? azureResponse,
      String? azureOutcome,
      DateTime? scheduledFor,
      bool isScheduled,
      bool isActive,
      bool isExpired,
      DateTime? expiresAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$NotificationImplCopyWithImpl<$Res>
    extends _$NotificationCopyWithImpl<$Res, _$NotificationImpl>
    implements _$$NotificationImplCopyWith<$Res> {
  __$$NotificationImplCopyWithImpl(
      _$NotificationImpl _value, $Res Function(_$NotificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? type = null,
    Object? title = null,
    Object? body = null,
    Object? priority = null,
    Object? channels = null,
    Object? imageUrl = freezed,
    Object? iconUrl = freezed,
    Object? data = freezed,
    Object? actions = freezed,
    Object? topic = freezed,
    Object? tags = freezed,
    Object? customData = freezed,
    Object? relatedNeedId = freezed,
    Object? relatedChatId = freezed,
    Object? relatedMissionId = freezed,
    Object? relatedUserId = freezed,
    Object? isDelivered = null,
    Object? isRead = null,
    Object? isClicked = null,
    Object? deliveredAt = freezed,
    Object? readAt = freezed,
    Object? clickedAt = freezed,
    Object? azureNotificationId = freezed,
    Object? azureResponse = freezed,
    Object? azureOutcome = freezed,
    Object? scheduledFor = freezed,
    Object? isScheduled = null,
    Object? isActive = null,
    Object? isExpired = null,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NotificationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority,
      channels: null == channels
          ? _value._channels
          : channels // ignore: cast_nullable_to_non_nullable
              as List<NotificationChannel>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      actions: freezed == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      customData: freezed == customData
          ? _value._customData
          : customData // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      relatedNeedId: freezed == relatedNeedId
          ? _value.relatedNeedId
          : relatedNeedId // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedChatId: freezed == relatedChatId
          ? _value.relatedChatId
          : relatedChatId // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedMissionId: freezed == relatedMissionId
          ? _value.relatedMissionId
          : relatedMissionId // ignore: cast_nullable_to_non_nullable
              as String?,
      relatedUserId: freezed == relatedUserId
          ? _value.relatedUserId
          : relatedUserId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelivered: null == isDelivered
          ? _value.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isClicked: null == isClicked
          ? _value.isClicked
          : isClicked // ignore: cast_nullable_to_non_nullable
              as bool,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      clickedAt: freezed == clickedAt
          ? _value.clickedAt
          : clickedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      azureNotificationId: freezed == azureNotificationId
          ? _value.azureNotificationId
          : azureNotificationId // ignore: cast_nullable_to_non_nullable
              as String?,
      azureResponse: freezed == azureResponse
          ? _value._azureResponse
          : azureResponse // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      azureOutcome: freezed == azureOutcome
          ? _value.azureOutcome
          : azureOutcome // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isScheduled: null == isScheduled
          ? _value.isScheduled
          : isScheduled // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpired: null == isExpired
          ? _value.isExpired
          : isExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationImpl implements _Notification {
  const _$NotificationImpl(
      {required this.id,
      required this.userId,
      required this.type,
      required this.title,
      required this.body,
      required this.priority,
      required final List<NotificationChannel> channels,
      this.imageUrl,
      this.iconUrl,
      final Map<String, dynamic>? data,
      final Map<String, String>? actions,
      this.topic,
      final List<String>? tags,
      final Map<String, String>? customData,
      this.relatedNeedId,
      this.relatedChatId,
      this.relatedMissionId,
      this.relatedUserId,
      this.isDelivered = false,
      this.isRead = false,
      this.isClicked = false,
      this.deliveredAt,
      this.readAt,
      this.clickedAt,
      this.azureNotificationId,
      final Map<String, dynamic>? azureResponse,
      this.azureOutcome,
      this.scheduledFor,
      this.isScheduled = false,
      this.isActive = true,
      this.isExpired = false,
      this.expiresAt,
      this.createdAt,
      this.updatedAt})
      : _channels = channels,
        _data = data,
        _actions = actions,
        _tags = tags,
        _customData = customData,
        _azureResponse = azureResponse;

  factory _$NotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final NotificationType type;
  @override
  final String title;
  @override
  final String body;
// Priority and Channel
  @override
  final NotificationPriority priority;
  final List<NotificationChannel> _channels;
  @override
  List<NotificationChannel> get channels {
    if (_channels is EqualUnmodifiableListView) return _channels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_channels);
  }

// Content
  @override
  final String? imageUrl;
  @override
  final String? iconUrl;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _actions;
  @override
  Map<String, String>? get actions {
    final value = _actions;
    if (value == null) return null;
    if (_actions is EqualUnmodifiableMapView) return _actions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Targeting
  @override
  final String? topic;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String>? _customData;
  @override
  Map<String, String>? get customData {
    final value = _customData;
    if (value == null) return null;
    if (_customData is EqualUnmodifiableMapView) return _customData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Context
  @override
  final String? relatedNeedId;
  @override
  final String? relatedChatId;
  @override
  final String? relatedMissionId;
  @override
  final String? relatedUserId;
// Delivery
  @override
  @JsonKey()
  final bool isDelivered;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final bool isClicked;
  @override
  final DateTime? deliveredAt;
  @override
  final DateTime? readAt;
  @override
  final DateTime? clickedAt;
// Azure Integration
  @override
  final String? azureNotificationId;
  final Map<String, dynamic>? _azureResponse;
  @override
  Map<String, dynamic>? get azureResponse {
    final value = _azureResponse;
    if (value == null) return null;
    if (_azureResponse is EqualUnmodifiableMapView) return _azureResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? azureOutcome;
// Scheduling
  @override
  final DateTime? scheduledFor;
  @override
  @JsonKey()
  final bool isScheduled;
// Status
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isExpired;
  @override
  final DateTime? expiresAt;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Notification(id: $id, userId: $userId, type: $type, title: $title, body: $body, priority: $priority, channels: $channels, imageUrl: $imageUrl, iconUrl: $iconUrl, data: $data, actions: $actions, topic: $topic, tags: $tags, customData: $customData, relatedNeedId: $relatedNeedId, relatedChatId: $relatedChatId, relatedMissionId: $relatedMissionId, relatedUserId: $relatedUserId, isDelivered: $isDelivered, isRead: $isRead, isClicked: $isClicked, deliveredAt: $deliveredAt, readAt: $readAt, clickedAt: $clickedAt, azureNotificationId: $azureNotificationId, azureResponse: $azureResponse, azureOutcome: $azureOutcome, scheduledFor: $scheduledFor, isScheduled: $isScheduled, isActive: $isActive, isExpired: $isExpired, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            const DeepCollectionEquality().equals(other._channels, _channels) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._customData, _customData) &&
            (identical(other.relatedNeedId, relatedNeedId) ||
                other.relatedNeedId == relatedNeedId) &&
            (identical(other.relatedChatId, relatedChatId) ||
                other.relatedChatId == relatedChatId) &&
            (identical(other.relatedMissionId, relatedMissionId) ||
                other.relatedMissionId == relatedMissionId) &&
            (identical(other.relatedUserId, relatedUserId) ||
                other.relatedUserId == relatedUserId) &&
            (identical(other.isDelivered, isDelivered) ||
                other.isDelivered == isDelivered) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isClicked, isClicked) ||
                other.isClicked == isClicked) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.clickedAt, clickedAt) ||
                other.clickedAt == clickedAt) &&
            (identical(other.azureNotificationId, azureNotificationId) ||
                other.azureNotificationId == azureNotificationId) &&
            const DeepCollectionEquality()
                .equals(other._azureResponse, _azureResponse) &&
            (identical(other.azureOutcome, azureOutcome) ||
                other.azureOutcome == azureOutcome) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.isScheduled, isScheduled) ||
                other.isScheduled == isScheduled) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isExpired, isExpired) ||
                other.isExpired == isExpired) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        type,
        title,
        body,
        priority,
        const DeepCollectionEquality().hash(_channels),
        imageUrl,
        iconUrl,
        const DeepCollectionEquality().hash(_data),
        const DeepCollectionEquality().hash(_actions),
        topic,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_customData),
        relatedNeedId,
        relatedChatId,
        relatedMissionId,
        relatedUserId,
        isDelivered,
        isRead,
        isClicked,
        deliveredAt,
        readAt,
        clickedAt,
        azureNotificationId,
        const DeepCollectionEquality().hash(_azureResponse),
        azureOutcome,
        scheduledFor,
        isScheduled,
        isActive,
        isExpired,
        expiresAt,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      __$$NotificationImplCopyWithImpl<_$NotificationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationImplToJson(
      this,
    );
  }
}

abstract class _Notification implements Notification {
  const factory _Notification(
      {required final String id,
      required final String userId,
      required final NotificationType type,
      required final String title,
      required final String body,
      required final NotificationPriority priority,
      required final List<NotificationChannel> channels,
      final String? imageUrl,
      final String? iconUrl,
      final Map<String, dynamic>? data,
      final Map<String, String>? actions,
      final String? topic,
      final List<String>? tags,
      final Map<String, String>? customData,
      final String? relatedNeedId,
      final String? relatedChatId,
      final String? relatedMissionId,
      final String? relatedUserId,
      final bool isDelivered,
      final bool isRead,
      final bool isClicked,
      final DateTime? deliveredAt,
      final DateTime? readAt,
      final DateTime? clickedAt,
      final String? azureNotificationId,
      final Map<String, dynamic>? azureResponse,
      final String? azureOutcome,
      final DateTime? scheduledFor,
      final bool isScheduled,
      final bool isActive,
      final bool isExpired,
      final DateTime? expiresAt,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$NotificationImpl;

  factory _Notification.fromJson(Map<String, dynamic> json) =
      _$NotificationImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  NotificationType get type;
  @override
  String get title;
  @override
  String get body; // Priority and Channel
  @override
  NotificationPriority get priority;
  @override
  List<NotificationChannel> get channels; // Content
  @override
  String? get imageUrl;
  @override
  String? get iconUrl;
  @override
  Map<String, dynamic>? get data;
  @override
  Map<String, String>? get actions; // Targeting
  @override
  String? get topic;
  @override
  List<String>? get tags;
  @override
  Map<String, String>? get customData; // Context
  @override
  String? get relatedNeedId;
  @override
  String? get relatedChatId;
  @override
  String? get relatedMissionId;
  @override
  String? get relatedUserId; // Delivery
  @override
  bool get isDelivered;
  @override
  bool get isRead;
  @override
  bool get isClicked;
  @override
  DateTime? get deliveredAt;
  @override
  DateTime? get readAt;
  @override
  DateTime? get clickedAt; // Azure Integration
  @override
  String? get azureNotificationId;
  @override
  Map<String, dynamic>? get azureResponse;
  @override
  String? get azureOutcome; // Scheduling
  @override
  DateTime? get scheduledFor;
  @override
  bool get isScheduled; // Status
  @override
  bool get isActive;
  @override
  bool get isExpired;
  @override
  DateTime? get expiresAt; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of Notification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationImplCopyWith<_$NotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationTemplate _$NotificationTemplateFromJson(Map<String, dynamic> json) {
  return _NotificationTemplate.fromJson(json);
}

/// @nodoc
mixin _$NotificationTemplate {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  NotificationType get type => throw _privateConstructorUsedError;
  String get titleTemplate => throw _privateConstructorUsedError;
  String get bodyTemplate =>
      throw _privateConstructorUsedError; // Customization
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  Map<String, String>? get actionTemplates =>
      throw _privateConstructorUsedError; // Configuration
  NotificationPriority? get defaultPriority =>
      throw _privateConstructorUsedError;
  List<NotificationChannel>? get defaultChannels =>
      throw _privateConstructorUsedError;
  Map<String, dynamic>? get defaultData =>
      throw _privateConstructorUsedError; // Localization
  Map<String, String>? get localizedTitles =>
      throw _privateConstructorUsedError;
  Map<String, String>? get localizedBodies =>
      throw _privateConstructorUsedError; // Variables
  List<String>? get requiredVariables => throw _privateConstructorUsedError;
  Map<String, String>? get variableDescriptions =>
      throw _privateConstructorUsedError; // Status
  bool get isActive => throw _privateConstructorUsedError;
  bool get isDefault => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationTemplate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationTemplateCopyWith<NotificationTemplate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationTemplateCopyWith<$Res> {
  factory $NotificationTemplateCopyWith(NotificationTemplate value,
          $Res Function(NotificationTemplate) then) =
      _$NotificationTemplateCopyWithImpl<$Res, NotificationTemplate>;
  @useResult
  $Res call(
      {String id,
      String name,
      NotificationType type,
      String titleTemplate,
      String bodyTemplate,
      String? imageUrl,
      String? iconUrl,
      Map<String, String>? actionTemplates,
      NotificationPriority? defaultPriority,
      List<NotificationChannel>? defaultChannels,
      Map<String, dynamic>? defaultData,
      Map<String, String>? localizedTitles,
      Map<String, String>? localizedBodies,
      List<String>? requiredVariables,
      Map<String, String>? variableDescriptions,
      bool isActive,
      bool isDefault,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$NotificationTemplateCopyWithImpl<$Res,
        $Val extends NotificationTemplate>
    implements $NotificationTemplateCopyWith<$Res> {
  _$NotificationTemplateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? titleTemplate = null,
    Object? bodyTemplate = null,
    Object? imageUrl = freezed,
    Object? iconUrl = freezed,
    Object? actionTemplates = freezed,
    Object? defaultPriority = freezed,
    Object? defaultChannels = freezed,
    Object? defaultData = freezed,
    Object? localizedTitles = freezed,
    Object? localizedBodies = freezed,
    Object? requiredVariables = freezed,
    Object? variableDescriptions = freezed,
    Object? isActive = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      titleTemplate: null == titleTemplate
          ? _value.titleTemplate
          : titleTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      bodyTemplate: null == bodyTemplate
          ? _value.bodyTemplate
          : bodyTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      actionTemplates: freezed == actionTemplates
          ? _value.actionTemplates
          : actionTemplates // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      defaultPriority: freezed == defaultPriority
          ? _value.defaultPriority
          : defaultPriority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority?,
      defaultChannels: freezed == defaultChannels
          ? _value.defaultChannels
          : defaultChannels // ignore: cast_nullable_to_non_nullable
              as List<NotificationChannel>?,
      defaultData: freezed == defaultData
          ? _value.defaultData
          : defaultData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      localizedTitles: freezed == localizedTitles
          ? _value.localizedTitles
          : localizedTitles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      localizedBodies: freezed == localizedBodies
          ? _value.localizedBodies
          : localizedBodies // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      requiredVariables: freezed == requiredVariables
          ? _value.requiredVariables
          : requiredVariables // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      variableDescriptions: freezed == variableDescriptions
          ? _value.variableDescriptions
          : variableDescriptions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationTemplateImplCopyWith<$Res>
    implements $NotificationTemplateCopyWith<$Res> {
  factory _$$NotificationTemplateImplCopyWith(_$NotificationTemplateImpl value,
          $Res Function(_$NotificationTemplateImpl) then) =
      __$$NotificationTemplateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      NotificationType type,
      String titleTemplate,
      String bodyTemplate,
      String? imageUrl,
      String? iconUrl,
      Map<String, String>? actionTemplates,
      NotificationPriority? defaultPriority,
      List<NotificationChannel>? defaultChannels,
      Map<String, dynamic>? defaultData,
      Map<String, String>? localizedTitles,
      Map<String, String>? localizedBodies,
      List<String>? requiredVariables,
      Map<String, String>? variableDescriptions,
      bool isActive,
      bool isDefault,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$NotificationTemplateImplCopyWithImpl<$Res>
    extends _$NotificationTemplateCopyWithImpl<$Res, _$NotificationTemplateImpl>
    implements _$$NotificationTemplateImplCopyWith<$Res> {
  __$$NotificationTemplateImplCopyWithImpl(_$NotificationTemplateImpl _value,
      $Res Function(_$NotificationTemplateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? titleTemplate = null,
    Object? bodyTemplate = null,
    Object? imageUrl = freezed,
    Object? iconUrl = freezed,
    Object? actionTemplates = freezed,
    Object? defaultPriority = freezed,
    Object? defaultChannels = freezed,
    Object? defaultData = freezed,
    Object? localizedTitles = freezed,
    Object? localizedBodies = freezed,
    Object? requiredVariables = freezed,
    Object? variableDescriptions = freezed,
    Object? isActive = null,
    Object? isDefault = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NotificationTemplateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as NotificationType,
      titleTemplate: null == titleTemplate
          ? _value.titleTemplate
          : titleTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      bodyTemplate: null == bodyTemplate
          ? _value.bodyTemplate
          : bodyTemplate // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      actionTemplates: freezed == actionTemplates
          ? _value._actionTemplates
          : actionTemplates // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      defaultPriority: freezed == defaultPriority
          ? _value.defaultPriority
          : defaultPriority // ignore: cast_nullable_to_non_nullable
              as NotificationPriority?,
      defaultChannels: freezed == defaultChannels
          ? _value._defaultChannels
          : defaultChannels // ignore: cast_nullable_to_non_nullable
              as List<NotificationChannel>?,
      defaultData: freezed == defaultData
          ? _value._defaultData
          : defaultData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      localizedTitles: freezed == localizedTitles
          ? _value._localizedTitles
          : localizedTitles // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      localizedBodies: freezed == localizedBodies
          ? _value._localizedBodies
          : localizedBodies // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      requiredVariables: freezed == requiredVariables
          ? _value._requiredVariables
          : requiredVariables // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      variableDescriptions: freezed == variableDescriptions
          ? _value._variableDescriptions
          : variableDescriptions // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationTemplateImpl implements _NotificationTemplate {
  const _$NotificationTemplateImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.titleTemplate,
      required this.bodyTemplate,
      this.imageUrl,
      this.iconUrl,
      final Map<String, String>? actionTemplates,
      this.defaultPriority,
      final List<NotificationChannel>? defaultChannels,
      final Map<String, dynamic>? defaultData,
      final Map<String, String>? localizedTitles,
      final Map<String, String>? localizedBodies,
      final List<String>? requiredVariables,
      final Map<String, String>? variableDescriptions,
      this.isActive = true,
      this.isDefault = false,
      this.createdAt,
      this.updatedAt})
      : _actionTemplates = actionTemplates,
        _defaultChannels = defaultChannels,
        _defaultData = defaultData,
        _localizedTitles = localizedTitles,
        _localizedBodies = localizedBodies,
        _requiredVariables = requiredVariables,
        _variableDescriptions = variableDescriptions;

  factory _$NotificationTemplateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationTemplateImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final NotificationType type;
  @override
  final String titleTemplate;
  @override
  final String bodyTemplate;
// Customization
  @override
  final String? imageUrl;
  @override
  final String? iconUrl;
  final Map<String, String>? _actionTemplates;
  @override
  Map<String, String>? get actionTemplates {
    final value = _actionTemplates;
    if (value == null) return null;
    if (_actionTemplates is EqualUnmodifiableMapView) return _actionTemplates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Configuration
  @override
  final NotificationPriority? defaultPriority;
  final List<NotificationChannel>? _defaultChannels;
  @override
  List<NotificationChannel>? get defaultChannels {
    final value = _defaultChannels;
    if (value == null) return null;
    if (_defaultChannels is EqualUnmodifiableListView) return _defaultChannels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _defaultData;
  @override
  Map<String, dynamic>? get defaultData {
    final value = _defaultData;
    if (value == null) return null;
    if (_defaultData is EqualUnmodifiableMapView) return _defaultData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Localization
  final Map<String, String>? _localizedTitles;
// Localization
  @override
  Map<String, String>? get localizedTitles {
    final value = _localizedTitles;
    if (value == null) return null;
    if (_localizedTitles is EqualUnmodifiableMapView) return _localizedTitles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _localizedBodies;
  @override
  Map<String, String>? get localizedBodies {
    final value = _localizedBodies;
    if (value == null) return null;
    if (_localizedBodies is EqualUnmodifiableMapView) return _localizedBodies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Variables
  final List<String>? _requiredVariables;
// Variables
  @override
  List<String>? get requiredVariables {
    final value = _requiredVariables;
    if (value == null) return null;
    if (_requiredVariables is EqualUnmodifiableListView)
      return _requiredVariables;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String>? _variableDescriptions;
  @override
  Map<String, String>? get variableDescriptions {
    final value = _variableDescriptions;
    if (value == null) return null;
    if (_variableDescriptions is EqualUnmodifiableMapView)
      return _variableDescriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Status
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isDefault;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NotificationTemplate(id: $id, name: $name, type: $type, titleTemplate: $titleTemplate, bodyTemplate: $bodyTemplate, imageUrl: $imageUrl, iconUrl: $iconUrl, actionTemplates: $actionTemplates, defaultPriority: $defaultPriority, defaultChannels: $defaultChannels, defaultData: $defaultData, localizedTitles: $localizedTitles, localizedBodies: $localizedBodies, requiredVariables: $requiredVariables, variableDescriptions: $variableDescriptions, isActive: $isActive, isDefault: $isDefault, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationTemplateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.titleTemplate, titleTemplate) ||
                other.titleTemplate == titleTemplate) &&
            (identical(other.bodyTemplate, bodyTemplate) ||
                other.bodyTemplate == bodyTemplate) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            const DeepCollectionEquality()
                .equals(other._actionTemplates, _actionTemplates) &&
            (identical(other.defaultPriority, defaultPriority) ||
                other.defaultPriority == defaultPriority) &&
            const DeepCollectionEquality()
                .equals(other._defaultChannels, _defaultChannels) &&
            const DeepCollectionEquality()
                .equals(other._defaultData, _defaultData) &&
            const DeepCollectionEquality()
                .equals(other._localizedTitles, _localizedTitles) &&
            const DeepCollectionEquality()
                .equals(other._localizedBodies, _localizedBodies) &&
            const DeepCollectionEquality()
                .equals(other._requiredVariables, _requiredVariables) &&
            const DeepCollectionEquality()
                .equals(other._variableDescriptions, _variableDescriptions) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        type,
        titleTemplate,
        bodyTemplate,
        imageUrl,
        iconUrl,
        const DeepCollectionEquality().hash(_actionTemplates),
        defaultPriority,
        const DeepCollectionEquality().hash(_defaultChannels),
        const DeepCollectionEquality().hash(_defaultData),
        const DeepCollectionEquality().hash(_localizedTitles),
        const DeepCollectionEquality().hash(_localizedBodies),
        const DeepCollectionEquality().hash(_requiredVariables),
        const DeepCollectionEquality().hash(_variableDescriptions),
        isActive,
        isDefault,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationTemplateImplCopyWith<_$NotificationTemplateImpl>
      get copyWith =>
          __$$NotificationTemplateImplCopyWithImpl<_$NotificationTemplateImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationTemplateImplToJson(
      this,
    );
  }
}

abstract class _NotificationTemplate implements NotificationTemplate {
  const factory _NotificationTemplate(
      {required final String id,
      required final String name,
      required final NotificationType type,
      required final String titleTemplate,
      required final String bodyTemplate,
      final String? imageUrl,
      final String? iconUrl,
      final Map<String, String>? actionTemplates,
      final NotificationPriority? defaultPriority,
      final List<NotificationChannel>? defaultChannels,
      final Map<String, dynamic>? defaultData,
      final Map<String, String>? localizedTitles,
      final Map<String, String>? localizedBodies,
      final List<String>? requiredVariables,
      final Map<String, String>? variableDescriptions,
      final bool isActive,
      final bool isDefault,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$NotificationTemplateImpl;

  factory _NotificationTemplate.fromJson(Map<String, dynamic> json) =
      _$NotificationTemplateImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  NotificationType get type;
  @override
  String get titleTemplate;
  @override
  String get bodyTemplate; // Customization
  @override
  String? get imageUrl;
  @override
  String? get iconUrl;
  @override
  Map<String, String>? get actionTemplates; // Configuration
  @override
  NotificationPriority? get defaultPriority;
  @override
  List<NotificationChannel>? get defaultChannels;
  @override
  Map<String, dynamic>? get defaultData; // Localization
  @override
  Map<String, String>? get localizedTitles;
  @override
  Map<String, String>? get localizedBodies; // Variables
  @override
  List<String>? get requiredVariables;
  @override
  Map<String, String>? get variableDescriptions; // Status
  @override
  bool get isActive;
  @override
  bool get isDefault; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of NotificationTemplate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationTemplateImplCopyWith<_$NotificationTemplateImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationPreferences _$NotificationPreferencesFromJson(
    Map<String, dynamic> json) {
  return _NotificationPreferences.fromJson(json);
}

/// @nodoc
mixin _$NotificationPreferences {
  String get userId =>
      throw _privateConstructorUsedError; // Channel Preferences
  bool get pushEnabled => throw _privateConstructorUsedError;
  bool get emailEnabled => throw _privateConstructorUsedError;
  bool get smsEnabled => throw _privateConstructorUsedError;
  bool get inAppEnabled =>
      throw _privateConstructorUsedError; // Type Preferences
  bool get needUpdates => throw _privateConstructorUsedError;
  bool get missionUnlocks => throw _privateConstructorUsedError;
  bool get adminBroadcasts => throw _privateConstructorUsedError;
  bool get chatMessages => throw _privateConstructorUsedError;
  bool get needCompletions => throw _privateConstructorUsedError;
  bool get helperAssignments => throw _privateConstructorUsedError;
  bool get badgeEarned => throw _privateConstructorUsedError;
  bool get levelUp => throw _privateConstructorUsedError;
  bool get reminders => throw _privateConstructorUsedError;
  bool get systemNotifications =>
      throw _privateConstructorUsedError; // Timing Preferences
  String? get quietHoursStart => throw _privateConstructorUsedError;
  String? get quietHoursEnd => throw _privateConstructorUsedError;
  String? get timezone => throw _privateConstructorUsedError;
  List<int>? get allowedDays =>
      throw _privateConstructorUsedError; // Frequency Limits
  int? get maxDailyNotifications => throw _privateConstructorUsedError;
  int? get maxHourlyNotifications => throw _privateConstructorUsedError;
  Duration? get minimumInterval =>
      throw _privateConstructorUsedError; // Topics & Tags
  List<String>? get subscribedTopics => throw _privateConstructorUsedError;
  List<String>? get blockedTopics => throw _privateConstructorUsedError;
  List<String>? get subscribedTags => throw _privateConstructorUsedError;
  List<String>? get blockedTags =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationPreferences to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationPreferencesCopyWith<NotificationPreferences> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPreferencesCopyWith<$Res> {
  factory $NotificationPreferencesCopyWith(NotificationPreferences value,
          $Res Function(NotificationPreferences) then) =
      _$NotificationPreferencesCopyWithImpl<$Res, NotificationPreferences>;
  @useResult
  $Res call(
      {String userId,
      bool pushEnabled,
      bool emailEnabled,
      bool smsEnabled,
      bool inAppEnabled,
      bool needUpdates,
      bool missionUnlocks,
      bool adminBroadcasts,
      bool chatMessages,
      bool needCompletions,
      bool helperAssignments,
      bool badgeEarned,
      bool levelUp,
      bool reminders,
      bool systemNotifications,
      String? quietHoursStart,
      String? quietHoursEnd,
      String? timezone,
      List<int>? allowedDays,
      int? maxDailyNotifications,
      int? maxHourlyNotifications,
      Duration? minimumInterval,
      List<String>? subscribedTopics,
      List<String>? blockedTopics,
      List<String>? subscribedTags,
      List<String>? blockedTags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$NotificationPreferencesCopyWithImpl<$Res,
        $Val extends NotificationPreferences>
    implements $NotificationPreferencesCopyWith<$Res> {
  _$NotificationPreferencesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? smsEnabled = null,
    Object? inAppEnabled = null,
    Object? needUpdates = null,
    Object? missionUnlocks = null,
    Object? adminBroadcasts = null,
    Object? chatMessages = null,
    Object? needCompletions = null,
    Object? helperAssignments = null,
    Object? badgeEarned = null,
    Object? levelUp = null,
    Object? reminders = null,
    Object? systemNotifications = null,
    Object? quietHoursStart = freezed,
    Object? quietHoursEnd = freezed,
    Object? timezone = freezed,
    Object? allowedDays = freezed,
    Object? maxDailyNotifications = freezed,
    Object? maxHourlyNotifications = freezed,
    Object? minimumInterval = freezed,
    Object? subscribedTopics = freezed,
    Object? blockedTopics = freezed,
    Object? subscribedTags = freezed,
    Object? blockedTags = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      pushEnabled: null == pushEnabled
          ? _value.pushEnabled
          : pushEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailEnabled: null == emailEnabled
          ? _value.emailEnabled
          : emailEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      smsEnabled: null == smsEnabled
          ? _value.smsEnabled
          : smsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppEnabled: null == inAppEnabled
          ? _value.inAppEnabled
          : inAppEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      needUpdates: null == needUpdates
          ? _value.needUpdates
          : needUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      missionUnlocks: null == missionUnlocks
          ? _value.missionUnlocks
          : missionUnlocks // ignore: cast_nullable_to_non_nullable
              as bool,
      adminBroadcasts: null == adminBroadcasts
          ? _value.adminBroadcasts
          : adminBroadcasts // ignore: cast_nullable_to_non_nullable
              as bool,
      chatMessages: null == chatMessages
          ? _value.chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      needCompletions: null == needCompletions
          ? _value.needCompletions
          : needCompletions // ignore: cast_nullable_to_non_nullable
              as bool,
      helperAssignments: null == helperAssignments
          ? _value.helperAssignments
          : helperAssignments // ignore: cast_nullable_to_non_nullable
              as bool,
      badgeEarned: null == badgeEarned
          ? _value.badgeEarned
          : badgeEarned // ignore: cast_nullable_to_non_nullable
              as bool,
      levelUp: null == levelUp
          ? _value.levelUp
          : levelUp // ignore: cast_nullable_to_non_nullable
              as bool,
      reminders: null == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as bool,
      systemNotifications: null == systemNotifications
          ? _value.systemNotifications
          : systemNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHoursStart: freezed == quietHoursStart
          ? _value.quietHoursStart
          : quietHoursStart // ignore: cast_nullable_to_non_nullable
              as String?,
      quietHoursEnd: freezed == quietHoursEnd
          ? _value.quietHoursEnd
          : quietHoursEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedDays: freezed == allowedDays
          ? _value.allowedDays
          : allowedDays // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      maxDailyNotifications: freezed == maxDailyNotifications
          ? _value.maxDailyNotifications
          : maxDailyNotifications // ignore: cast_nullable_to_non_nullable
              as int?,
      maxHourlyNotifications: freezed == maxHourlyNotifications
          ? _value.maxHourlyNotifications
          : maxHourlyNotifications // ignore: cast_nullable_to_non_nullable
              as int?,
      minimumInterval: freezed == minimumInterval
          ? _value.minimumInterval
          : minimumInterval // ignore: cast_nullable_to_non_nullable
              as Duration?,
      subscribedTopics: freezed == subscribedTopics
          ? _value.subscribedTopics
          : subscribedTopics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      blockedTopics: freezed == blockedTopics
          ? _value.blockedTopics
          : blockedTopics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      subscribedTags: freezed == subscribedTags
          ? _value.subscribedTags
          : subscribedTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      blockedTags: freezed == blockedTags
          ? _value.blockedTags
          : blockedTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationPreferencesImplCopyWith<$Res>
    implements $NotificationPreferencesCopyWith<$Res> {
  factory _$$NotificationPreferencesImplCopyWith(
          _$NotificationPreferencesImpl value,
          $Res Function(_$NotificationPreferencesImpl) then) =
      __$$NotificationPreferencesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      bool pushEnabled,
      bool emailEnabled,
      bool smsEnabled,
      bool inAppEnabled,
      bool needUpdates,
      bool missionUnlocks,
      bool adminBroadcasts,
      bool chatMessages,
      bool needCompletions,
      bool helperAssignments,
      bool badgeEarned,
      bool levelUp,
      bool reminders,
      bool systemNotifications,
      String? quietHoursStart,
      String? quietHoursEnd,
      String? timezone,
      List<int>? allowedDays,
      int? maxDailyNotifications,
      int? maxHourlyNotifications,
      Duration? minimumInterval,
      List<String>? subscribedTopics,
      List<String>? blockedTopics,
      List<String>? subscribedTags,
      List<String>? blockedTags,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$NotificationPreferencesImplCopyWithImpl<$Res>
    extends _$NotificationPreferencesCopyWithImpl<$Res,
        _$NotificationPreferencesImpl>
    implements _$$NotificationPreferencesImplCopyWith<$Res> {
  __$$NotificationPreferencesImplCopyWithImpl(
      _$NotificationPreferencesImpl _value,
      $Res Function(_$NotificationPreferencesImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? pushEnabled = null,
    Object? emailEnabled = null,
    Object? smsEnabled = null,
    Object? inAppEnabled = null,
    Object? needUpdates = null,
    Object? missionUnlocks = null,
    Object? adminBroadcasts = null,
    Object? chatMessages = null,
    Object? needCompletions = null,
    Object? helperAssignments = null,
    Object? badgeEarned = null,
    Object? levelUp = null,
    Object? reminders = null,
    Object? systemNotifications = null,
    Object? quietHoursStart = freezed,
    Object? quietHoursEnd = freezed,
    Object? timezone = freezed,
    Object? allowedDays = freezed,
    Object? maxDailyNotifications = freezed,
    Object? maxHourlyNotifications = freezed,
    Object? minimumInterval = freezed,
    Object? subscribedTopics = freezed,
    Object? blockedTopics = freezed,
    Object? subscribedTags = freezed,
    Object? blockedTags = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NotificationPreferencesImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      pushEnabled: null == pushEnabled
          ? _value.pushEnabled
          : pushEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailEnabled: null == emailEnabled
          ? _value.emailEnabled
          : emailEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      smsEnabled: null == smsEnabled
          ? _value.smsEnabled
          : smsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      inAppEnabled: null == inAppEnabled
          ? _value.inAppEnabled
          : inAppEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      needUpdates: null == needUpdates
          ? _value.needUpdates
          : needUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      missionUnlocks: null == missionUnlocks
          ? _value.missionUnlocks
          : missionUnlocks // ignore: cast_nullable_to_non_nullable
              as bool,
      adminBroadcasts: null == adminBroadcasts
          ? _value.adminBroadcasts
          : adminBroadcasts // ignore: cast_nullable_to_non_nullable
              as bool,
      chatMessages: null == chatMessages
          ? _value.chatMessages
          : chatMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      needCompletions: null == needCompletions
          ? _value.needCompletions
          : needCompletions // ignore: cast_nullable_to_non_nullable
              as bool,
      helperAssignments: null == helperAssignments
          ? _value.helperAssignments
          : helperAssignments // ignore: cast_nullable_to_non_nullable
              as bool,
      badgeEarned: null == badgeEarned
          ? _value.badgeEarned
          : badgeEarned // ignore: cast_nullable_to_non_nullable
              as bool,
      levelUp: null == levelUp
          ? _value.levelUp
          : levelUp // ignore: cast_nullable_to_non_nullable
              as bool,
      reminders: null == reminders
          ? _value.reminders
          : reminders // ignore: cast_nullable_to_non_nullable
              as bool,
      systemNotifications: null == systemNotifications
          ? _value.systemNotifications
          : systemNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      quietHoursStart: freezed == quietHoursStart
          ? _value.quietHoursStart
          : quietHoursStart // ignore: cast_nullable_to_non_nullable
              as String?,
      quietHoursEnd: freezed == quietHoursEnd
          ? _value.quietHoursEnd
          : quietHoursEnd // ignore: cast_nullable_to_non_nullable
              as String?,
      timezone: freezed == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String?,
      allowedDays: freezed == allowedDays
          ? _value._allowedDays
          : allowedDays // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      maxDailyNotifications: freezed == maxDailyNotifications
          ? _value.maxDailyNotifications
          : maxDailyNotifications // ignore: cast_nullable_to_non_nullable
              as int?,
      maxHourlyNotifications: freezed == maxHourlyNotifications
          ? _value.maxHourlyNotifications
          : maxHourlyNotifications // ignore: cast_nullable_to_non_nullable
              as int?,
      minimumInterval: freezed == minimumInterval
          ? _value.minimumInterval
          : minimumInterval // ignore: cast_nullable_to_non_nullable
              as Duration?,
      subscribedTopics: freezed == subscribedTopics
          ? _value._subscribedTopics
          : subscribedTopics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      blockedTopics: freezed == blockedTopics
          ? _value._blockedTopics
          : blockedTopics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      subscribedTags: freezed == subscribedTags
          ? _value._subscribedTags
          : subscribedTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      blockedTags: freezed == blockedTags
          ? _value._blockedTags
          : blockedTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationPreferencesImpl implements _NotificationPreferences {
  const _$NotificationPreferencesImpl(
      {required this.userId,
      this.pushEnabled = true,
      this.emailEnabled = true,
      this.smsEnabled = false,
      this.inAppEnabled = true,
      this.needUpdates = true,
      this.missionUnlocks = true,
      this.adminBroadcasts = true,
      this.chatMessages = true,
      this.needCompletions = true,
      this.helperAssignments = true,
      this.badgeEarned = true,
      this.levelUp = true,
      this.reminders = true,
      this.systemNotifications = true,
      this.quietHoursStart,
      this.quietHoursEnd,
      this.timezone,
      final List<int>? allowedDays,
      this.maxDailyNotifications,
      this.maxHourlyNotifications,
      this.minimumInterval,
      final List<String>? subscribedTopics,
      final List<String>? blockedTopics,
      final List<String>? subscribedTags,
      final List<String>? blockedTags,
      this.createdAt,
      this.updatedAt})
      : _allowedDays = allowedDays,
        _subscribedTopics = subscribedTopics,
        _blockedTopics = blockedTopics,
        _subscribedTags = subscribedTags,
        _blockedTags = blockedTags;

  factory _$NotificationPreferencesImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationPreferencesImplFromJson(json);

  @override
  final String userId;
// Channel Preferences
  @override
  @JsonKey()
  final bool pushEnabled;
  @override
  @JsonKey()
  final bool emailEnabled;
  @override
  @JsonKey()
  final bool smsEnabled;
  @override
  @JsonKey()
  final bool inAppEnabled;
// Type Preferences
  @override
  @JsonKey()
  final bool needUpdates;
  @override
  @JsonKey()
  final bool missionUnlocks;
  @override
  @JsonKey()
  final bool adminBroadcasts;
  @override
  @JsonKey()
  final bool chatMessages;
  @override
  @JsonKey()
  final bool needCompletions;
  @override
  @JsonKey()
  final bool helperAssignments;
  @override
  @JsonKey()
  final bool badgeEarned;
  @override
  @JsonKey()
  final bool levelUp;
  @override
  @JsonKey()
  final bool reminders;
  @override
  @JsonKey()
  final bool systemNotifications;
// Timing Preferences
  @override
  final String? quietHoursStart;
  @override
  final String? quietHoursEnd;
  @override
  final String? timezone;
  final List<int>? _allowedDays;
  @override
  List<int>? get allowedDays {
    final value = _allowedDays;
    if (value == null) return null;
    if (_allowedDays is EqualUnmodifiableListView) return _allowedDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Frequency Limits
  @override
  final int? maxDailyNotifications;
  @override
  final int? maxHourlyNotifications;
  @override
  final Duration? minimumInterval;
// Topics & Tags
  final List<String>? _subscribedTopics;
// Topics & Tags
  @override
  List<String>? get subscribedTopics {
    final value = _subscribedTopics;
    if (value == null) return null;
    if (_subscribedTopics is EqualUnmodifiableListView)
      return _subscribedTopics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _blockedTopics;
  @override
  List<String>? get blockedTopics {
    final value = _blockedTopics;
    if (value == null) return null;
    if (_blockedTopics is EqualUnmodifiableListView) return _blockedTopics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _subscribedTags;
  @override
  List<String>? get subscribedTags {
    final value = _subscribedTags;
    if (value == null) return null;
    if (_subscribedTags is EqualUnmodifiableListView) return _subscribedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _blockedTags;
  @override
  List<String>? get blockedTags {
    final value = _blockedTags;
    if (value == null) return null;
    if (_blockedTags is EqualUnmodifiableListView) return _blockedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NotificationPreferences(userId: $userId, pushEnabled: $pushEnabled, emailEnabled: $emailEnabled, smsEnabled: $smsEnabled, inAppEnabled: $inAppEnabled, needUpdates: $needUpdates, missionUnlocks: $missionUnlocks, adminBroadcasts: $adminBroadcasts, chatMessages: $chatMessages, needCompletions: $needCompletions, helperAssignments: $helperAssignments, badgeEarned: $badgeEarned, levelUp: $levelUp, reminders: $reminders, systemNotifications: $systemNotifications, quietHoursStart: $quietHoursStart, quietHoursEnd: $quietHoursEnd, timezone: $timezone, allowedDays: $allowedDays, maxDailyNotifications: $maxDailyNotifications, maxHourlyNotifications: $maxHourlyNotifications, minimumInterval: $minimumInterval, subscribedTopics: $subscribedTopics, blockedTopics: $blockedTopics, subscribedTags: $subscribedTags, blockedTags: $blockedTags, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationPreferencesImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pushEnabled, pushEnabled) ||
                other.pushEnabled == pushEnabled) &&
            (identical(other.emailEnabled, emailEnabled) ||
                other.emailEnabled == emailEnabled) &&
            (identical(other.smsEnabled, smsEnabled) ||
                other.smsEnabled == smsEnabled) &&
            (identical(other.inAppEnabled, inAppEnabled) ||
                other.inAppEnabled == inAppEnabled) &&
            (identical(other.needUpdates, needUpdates) ||
                other.needUpdates == needUpdates) &&
            (identical(other.missionUnlocks, missionUnlocks) ||
                other.missionUnlocks == missionUnlocks) &&
            (identical(other.adminBroadcasts, adminBroadcasts) ||
                other.adminBroadcasts == adminBroadcasts) &&
            (identical(other.chatMessages, chatMessages) ||
                other.chatMessages == chatMessages) &&
            (identical(other.needCompletions, needCompletions) ||
                other.needCompletions == needCompletions) &&
            (identical(other.helperAssignments, helperAssignments) ||
                other.helperAssignments == helperAssignments) &&
            (identical(other.badgeEarned, badgeEarned) ||
                other.badgeEarned == badgeEarned) &&
            (identical(other.levelUp, levelUp) || other.levelUp == levelUp) &&
            (identical(other.reminders, reminders) ||
                other.reminders == reminders) &&
            (identical(other.systemNotifications, systemNotifications) ||
                other.systemNotifications == systemNotifications) &&
            (identical(other.quietHoursStart, quietHoursStart) ||
                other.quietHoursStart == quietHoursStart) &&
            (identical(other.quietHoursEnd, quietHoursEnd) ||
                other.quietHoursEnd == quietHoursEnd) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            const DeepCollectionEquality()
                .equals(other._allowedDays, _allowedDays) &&
            (identical(other.maxDailyNotifications, maxDailyNotifications) ||
                other.maxDailyNotifications == maxDailyNotifications) &&
            (identical(other.maxHourlyNotifications, maxHourlyNotifications) ||
                other.maxHourlyNotifications == maxHourlyNotifications) &&
            (identical(other.minimumInterval, minimumInterval) ||
                other.minimumInterval == minimumInterval) &&
            const DeepCollectionEquality()
                .equals(other._subscribedTopics, _subscribedTopics) &&
            const DeepCollectionEquality()
                .equals(other._blockedTopics, _blockedTopics) &&
            const DeepCollectionEquality()
                .equals(other._subscribedTags, _subscribedTags) &&
            const DeepCollectionEquality()
                .equals(other._blockedTags, _blockedTags) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        userId,
        pushEnabled,
        emailEnabled,
        smsEnabled,
        inAppEnabled,
        needUpdates,
        missionUnlocks,
        adminBroadcasts,
        chatMessages,
        needCompletions,
        helperAssignments,
        badgeEarned,
        levelUp,
        reminders,
        systemNotifications,
        quietHoursStart,
        quietHoursEnd,
        timezone,
        const DeepCollectionEquality().hash(_allowedDays),
        maxDailyNotifications,
        maxHourlyNotifications,
        minimumInterval,
        const DeepCollectionEquality().hash(_subscribedTopics),
        const DeepCollectionEquality().hash(_blockedTopics),
        const DeepCollectionEquality().hash(_subscribedTags),
        const DeepCollectionEquality().hash(_blockedTags),
        createdAt,
        updatedAt
      ]);

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationPreferencesImplCopyWith<_$NotificationPreferencesImpl>
      get copyWith => __$$NotificationPreferencesImplCopyWithImpl<
          _$NotificationPreferencesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationPreferencesImplToJson(
      this,
    );
  }
}

abstract class _NotificationPreferences implements NotificationPreferences {
  const factory _NotificationPreferences(
      {required final String userId,
      final bool pushEnabled,
      final bool emailEnabled,
      final bool smsEnabled,
      final bool inAppEnabled,
      final bool needUpdates,
      final bool missionUnlocks,
      final bool adminBroadcasts,
      final bool chatMessages,
      final bool needCompletions,
      final bool helperAssignments,
      final bool badgeEarned,
      final bool levelUp,
      final bool reminders,
      final bool systemNotifications,
      final String? quietHoursStart,
      final String? quietHoursEnd,
      final String? timezone,
      final List<int>? allowedDays,
      final int? maxDailyNotifications,
      final int? maxHourlyNotifications,
      final Duration? minimumInterval,
      final List<String>? subscribedTopics,
      final List<String>? blockedTopics,
      final List<String>? subscribedTags,
      final List<String>? blockedTags,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$NotificationPreferencesImpl;

  factory _NotificationPreferences.fromJson(Map<String, dynamic> json) =
      _$NotificationPreferencesImpl.fromJson;

  @override
  String get userId; // Channel Preferences
  @override
  bool get pushEnabled;
  @override
  bool get emailEnabled;
  @override
  bool get smsEnabled;
  @override
  bool get inAppEnabled; // Type Preferences
  @override
  bool get needUpdates;
  @override
  bool get missionUnlocks;
  @override
  bool get adminBroadcasts;
  @override
  bool get chatMessages;
  @override
  bool get needCompletions;
  @override
  bool get helperAssignments;
  @override
  bool get badgeEarned;
  @override
  bool get levelUp;
  @override
  bool get reminders;
  @override
  bool get systemNotifications; // Timing Preferences
  @override
  String? get quietHoursStart;
  @override
  String? get quietHoursEnd;
  @override
  String? get timezone;
  @override
  List<int>? get allowedDays; // Frequency Limits
  @override
  int? get maxDailyNotifications;
  @override
  int? get maxHourlyNotifications;
  @override
  Duration? get minimumInterval; // Topics & Tags
  @override
  List<String>? get subscribedTopics;
  @override
  List<String>? get blockedTopics;
  @override
  List<String>? get subscribedTags;
  @override
  List<String>? get blockedTags; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of NotificationPreferences
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationPreferencesImplCopyWith<_$NotificationPreferencesImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PushToken _$PushTokenFromJson(Map<String, dynamic> json) {
  return _PushToken.fromJson(json);
}

/// @nodoc
mixin _$PushToken {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  String get platform => throw _privateConstructorUsedError;
  String get deviceId =>
      throw _privateConstructorUsedError; // Device Information
  String? get deviceName => throw _privateConstructorUsedError;
  String? get deviceModel => throw _privateConstructorUsedError;
  String? get osVersion => throw _privateConstructorUsedError;
  String? get appVersion =>
      throw _privateConstructorUsedError; // Azure Integration
  String? get azureRegistrationId => throw _privateConstructorUsedError;
  List<String>? get azureTags => throw _privateConstructorUsedError;
  Map<String, dynamic>? get azureProperties =>
      throw _privateConstructorUsedError; // Status
  bool get isActive => throw _privateConstructorUsedError;
  bool get isExpired => throw _privateConstructorUsedError;
  DateTime? get lastUsedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PushToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushTokenCopyWith<PushToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushTokenCopyWith<$Res> {
  factory $PushTokenCopyWith(PushToken value, $Res Function(PushToken) then) =
      _$PushTokenCopyWithImpl<$Res, PushToken>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String token,
      String platform,
      String deviceId,
      String? deviceName,
      String? deviceModel,
      String? osVersion,
      String? appVersion,
      String? azureRegistrationId,
      List<String>? azureTags,
      Map<String, dynamic>? azureProperties,
      bool isActive,
      bool isExpired,
      DateTime? lastUsedAt,
      DateTime? expiresAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$PushTokenCopyWithImpl<$Res, $Val extends PushToken>
    implements $PushTokenCopyWith<$Res> {
  _$PushTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? token = null,
    Object? platform = null,
    Object? deviceId = null,
    Object? deviceName = freezed,
    Object? deviceModel = freezed,
    Object? osVersion = freezed,
    Object? appVersion = freezed,
    Object? azureRegistrationId = freezed,
    Object? azureTags = freezed,
    Object? azureProperties = freezed,
    Object? isActive = null,
    Object? isExpired = null,
    Object? lastUsedAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      osVersion: freezed == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      azureRegistrationId: freezed == azureRegistrationId
          ? _value.azureRegistrationId
          : azureRegistrationId // ignore: cast_nullable_to_non_nullable
              as String?,
      azureTags: freezed == azureTags
          ? _value.azureTags
          : azureTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      azureProperties: freezed == azureProperties
          ? _value.azureProperties
          : azureProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpired: null == isExpired
          ? _value.isExpired
          : isExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushTokenImplCopyWith<$Res>
    implements $PushTokenCopyWith<$Res> {
  factory _$$PushTokenImplCopyWith(
          _$PushTokenImpl value, $Res Function(_$PushTokenImpl) then) =
      __$$PushTokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String token,
      String platform,
      String deviceId,
      String? deviceName,
      String? deviceModel,
      String? osVersion,
      String? appVersion,
      String? azureRegistrationId,
      List<String>? azureTags,
      Map<String, dynamic>? azureProperties,
      bool isActive,
      bool isExpired,
      DateTime? lastUsedAt,
      DateTime? expiresAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$PushTokenImplCopyWithImpl<$Res>
    extends _$PushTokenCopyWithImpl<$Res, _$PushTokenImpl>
    implements _$$PushTokenImplCopyWith<$Res> {
  __$$PushTokenImplCopyWithImpl(
      _$PushTokenImpl _value, $Res Function(_$PushTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushToken
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? token = null,
    Object? platform = null,
    Object? deviceId = null,
    Object? deviceName = freezed,
    Object? deviceModel = freezed,
    Object? osVersion = freezed,
    Object? appVersion = freezed,
    Object? azureRegistrationId = freezed,
    Object? azureTags = freezed,
    Object? azureProperties = freezed,
    Object? isActive = null,
    Object? isExpired = null,
    Object? lastUsedAt = freezed,
    Object? expiresAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$PushTokenImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
      deviceId: null == deviceId
          ? _value.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceName: freezed == deviceName
          ? _value.deviceName
          : deviceName // ignore: cast_nullable_to_non_nullable
              as String?,
      deviceModel: freezed == deviceModel
          ? _value.deviceModel
          : deviceModel // ignore: cast_nullable_to_non_nullable
              as String?,
      osVersion: freezed == osVersion
          ? _value.osVersion
          : osVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      appVersion: freezed == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      azureRegistrationId: freezed == azureRegistrationId
          ? _value.azureRegistrationId
          : azureRegistrationId // ignore: cast_nullable_to_non_nullable
              as String?,
      azureTags: freezed == azureTags
          ? _value._azureTags
          : azureTags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      azureProperties: freezed == azureProperties
          ? _value._azureProperties
          : azureProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isExpired: null == isExpired
          ? _value.isExpired
          : isExpired // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUsedAt: freezed == lastUsedAt
          ? _value.lastUsedAt
          : lastUsedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushTokenImpl implements _PushToken {
  const _$PushTokenImpl(
      {required this.id,
      required this.userId,
      required this.token,
      required this.platform,
      required this.deviceId,
      this.deviceName,
      this.deviceModel,
      this.osVersion,
      this.appVersion,
      this.azureRegistrationId,
      final List<String>? azureTags,
      final Map<String, dynamic>? azureProperties,
      this.isActive = true,
      this.isExpired = false,
      this.lastUsedAt,
      this.expiresAt,
      this.createdAt,
      this.updatedAt})
      : _azureTags = azureTags,
        _azureProperties = azureProperties;

  factory _$PushTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushTokenImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String token;
  @override
  final String platform;
  @override
  final String deviceId;
// Device Information
  @override
  final String? deviceName;
  @override
  final String? deviceModel;
  @override
  final String? osVersion;
  @override
  final String? appVersion;
// Azure Integration
  @override
  final String? azureRegistrationId;
  final List<String>? _azureTags;
  @override
  List<String>? get azureTags {
    final value = _azureTags;
    if (value == null) return null;
    if (_azureTags is EqualUnmodifiableListView) return _azureTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _azureProperties;
  @override
  Map<String, dynamic>? get azureProperties {
    final value = _azureProperties;
    if (value == null) return null;
    if (_azureProperties is EqualUnmodifiableMapView) return _azureProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Status
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isExpired;
  @override
  final DateTime? lastUsedAt;
  @override
  final DateTime? expiresAt;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PushToken(id: $id, userId: $userId, token: $token, platform: $platform, deviceId: $deviceId, deviceName: $deviceName, deviceModel: $deviceModel, osVersion: $osVersion, appVersion: $appVersion, azureRegistrationId: $azureRegistrationId, azureTags: $azureTags, azureProperties: $azureProperties, isActive: $isActive, isExpired: $isExpired, lastUsedAt: $lastUsedAt, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushTokenImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.platform, platform) ||
                other.platform == platform) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceName, deviceName) ||
                other.deviceName == deviceName) &&
            (identical(other.deviceModel, deviceModel) ||
                other.deviceModel == deviceModel) &&
            (identical(other.osVersion, osVersion) ||
                other.osVersion == osVersion) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion) &&
            (identical(other.azureRegistrationId, azureRegistrationId) ||
                other.azureRegistrationId == azureRegistrationId) &&
            const DeepCollectionEquality()
                .equals(other._azureTags, _azureTags) &&
            const DeepCollectionEquality()
                .equals(other._azureProperties, _azureProperties) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isExpired, isExpired) ||
                other.isExpired == isExpired) &&
            (identical(other.lastUsedAt, lastUsedAt) ||
                other.lastUsedAt == lastUsedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      token,
      platform,
      deviceId,
      deviceName,
      deviceModel,
      osVersion,
      appVersion,
      azureRegistrationId,
      const DeepCollectionEquality().hash(_azureTags),
      const DeepCollectionEquality().hash(_azureProperties),
      isActive,
      isExpired,
      lastUsedAt,
      expiresAt,
      createdAt,
      updatedAt);

  /// Create a copy of PushToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushTokenImplCopyWith<_$PushTokenImpl> get copyWith =>
      __$$PushTokenImplCopyWithImpl<_$PushTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushTokenImplToJson(
      this,
    );
  }
}

abstract class _PushToken implements PushToken {
  const factory _PushToken(
      {required final String id,
      required final String userId,
      required final String token,
      required final String platform,
      required final String deviceId,
      final String? deviceName,
      final String? deviceModel,
      final String? osVersion,
      final String? appVersion,
      final String? azureRegistrationId,
      final List<String>? azureTags,
      final Map<String, dynamic>? azureProperties,
      final bool isActive,
      final bool isExpired,
      final DateTime? lastUsedAt,
      final DateTime? expiresAt,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$PushTokenImpl;

  factory _PushToken.fromJson(Map<String, dynamic> json) =
      _$PushTokenImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get token;
  @override
  String get platform;
  @override
  String get deviceId; // Device Information
  @override
  String? get deviceName;
  @override
  String? get deviceModel;
  @override
  String? get osVersion;
  @override
  String? get appVersion; // Azure Integration
  @override
  String? get azureRegistrationId;
  @override
  List<String>? get azureTags;
  @override
  Map<String, dynamic>? get azureProperties; // Status
  @override
  bool get isActive;
  @override
  bool get isExpired;
  @override
  DateTime? get lastUsedAt;
  @override
  DateTime? get expiresAt; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PushToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushTokenImplCopyWith<_$PushTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationBatch _$NotificationBatchFromJson(Map<String, dynamic> json) {
  return _NotificationBatch.fromJson(json);
}

/// @nodoc
mixin _$NotificationBatch {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<String> get notificationIds =>
      throw _privateConstructorUsedError; // Targeting
  List<String>? get userIds => throw _privateConstructorUsedError;
  List<String>? get topics => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  Map<String, String>? get filters =>
      throw _privateConstructorUsedError; // Scheduling
  DateTime? get scheduledFor => throw _privateConstructorUsedError;
  bool get isScheduled => throw _privateConstructorUsedError; // Status
  String get status => throw _privateConstructorUsedError;
  int get totalRecipients => throw _privateConstructorUsedError;
  int get successfulDeliveries => throw _privateConstructorUsedError;
  int get failedDeliveries =>
      throw _privateConstructorUsedError; // Azure Integration
  String? get azureBatchId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get azureResponse =>
      throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationBatch to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationBatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationBatchCopyWith<NotificationBatch> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationBatchCopyWith<$Res> {
  factory $NotificationBatchCopyWith(
          NotificationBatch value, $Res Function(NotificationBatch) then) =
      _$NotificationBatchCopyWithImpl<$Res, NotificationBatch>;
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> notificationIds,
      List<String>? userIds,
      List<String>? topics,
      List<String>? tags,
      Map<String, String>? filters,
      DateTime? scheduledFor,
      bool isScheduled,
      String status,
      int totalRecipients,
      int successfulDeliveries,
      int failedDeliveries,
      String? azureBatchId,
      Map<String, dynamic>? azureResponse,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class _$NotificationBatchCopyWithImpl<$Res, $Val extends NotificationBatch>
    implements $NotificationBatchCopyWith<$Res> {
  _$NotificationBatchCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationBatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? notificationIds = null,
    Object? userIds = freezed,
    Object? topics = freezed,
    Object? tags = freezed,
    Object? filters = freezed,
    Object? scheduledFor = freezed,
    Object? isScheduled = null,
    Object? status = null,
    Object? totalRecipients = null,
    Object? successfulDeliveries = null,
    Object? failedDeliveries = null,
    Object? azureBatchId = freezed,
    Object? azureResponse = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notificationIds: null == notificationIds
          ? _value.notificationIds
          : notificationIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userIds: freezed == userIds
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      topics: freezed == topics
          ? _value.topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      filters: freezed == filters
          ? _value.filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isScheduled: null == isScheduled
          ? _value.isScheduled
          : isScheduled // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      totalRecipients: null == totalRecipients
          ? _value.totalRecipients
          : totalRecipients // ignore: cast_nullable_to_non_nullable
              as int,
      successfulDeliveries: null == successfulDeliveries
          ? _value.successfulDeliveries
          : successfulDeliveries // ignore: cast_nullable_to_non_nullable
              as int,
      failedDeliveries: null == failedDeliveries
          ? _value.failedDeliveries
          : failedDeliveries // ignore: cast_nullable_to_non_nullable
              as int,
      azureBatchId: freezed == azureBatchId
          ? _value.azureBatchId
          : azureBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      azureResponse: freezed == azureResponse
          ? _value.azureResponse
          : azureResponse // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationBatchImplCopyWith<$Res>
    implements $NotificationBatchCopyWith<$Res> {
  factory _$$NotificationBatchImplCopyWith(_$NotificationBatchImpl value,
          $Res Function(_$NotificationBatchImpl) then) =
      __$$NotificationBatchImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      List<String> notificationIds,
      List<String>? userIds,
      List<String>? topics,
      List<String>? tags,
      Map<String, String>? filters,
      DateTime? scheduledFor,
      bool isScheduled,
      String status,
      int totalRecipients,
      int successfulDeliveries,
      int failedDeliveries,
      String? azureBatchId,
      Map<String, dynamic>? azureResponse,
      DateTime? createdAt,
      DateTime? completedAt});
}

/// @nodoc
class __$$NotificationBatchImplCopyWithImpl<$Res>
    extends _$NotificationBatchCopyWithImpl<$Res, _$NotificationBatchImpl>
    implements _$$NotificationBatchImplCopyWith<$Res> {
  __$$NotificationBatchImplCopyWithImpl(_$NotificationBatchImpl _value,
      $Res Function(_$NotificationBatchImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationBatch
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? notificationIds = null,
    Object? userIds = freezed,
    Object? topics = freezed,
    Object? tags = freezed,
    Object? filters = freezed,
    Object? scheduledFor = freezed,
    Object? isScheduled = null,
    Object? status = null,
    Object? totalRecipients = null,
    Object? successfulDeliveries = null,
    Object? failedDeliveries = null,
    Object? azureBatchId = freezed,
    Object? azureResponse = freezed,
    Object? createdAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$NotificationBatchImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      notificationIds: null == notificationIds
          ? _value._notificationIds
          : notificationIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      userIds: freezed == userIds
          ? _value._userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      topics: freezed == topics
          ? _value._topics
          : topics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      filters: freezed == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      scheduledFor: freezed == scheduledFor
          ? _value.scheduledFor
          : scheduledFor // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isScheduled: null == isScheduled
          ? _value.isScheduled
          : isScheduled // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      totalRecipients: null == totalRecipients
          ? _value.totalRecipients
          : totalRecipients // ignore: cast_nullable_to_non_nullable
              as int,
      successfulDeliveries: null == successfulDeliveries
          ? _value.successfulDeliveries
          : successfulDeliveries // ignore: cast_nullable_to_non_nullable
              as int,
      failedDeliveries: null == failedDeliveries
          ? _value.failedDeliveries
          : failedDeliveries // ignore: cast_nullable_to_non_nullable
              as int,
      azureBatchId: freezed == azureBatchId
          ? _value.azureBatchId
          : azureBatchId // ignore: cast_nullable_to_non_nullable
              as String?,
      azureResponse: freezed == azureResponse
          ? _value._azureResponse
          : azureResponse // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationBatchImpl implements _NotificationBatch {
  const _$NotificationBatchImpl(
      {required this.id,
      required this.name,
      required final List<String> notificationIds,
      final List<String>? userIds,
      final List<String>? topics,
      final List<String>? tags,
      final Map<String, String>? filters,
      this.scheduledFor,
      this.isScheduled = false,
      required this.status,
      this.totalRecipients = 0,
      this.successfulDeliveries = 0,
      this.failedDeliveries = 0,
      this.azureBatchId,
      final Map<String, dynamic>? azureResponse,
      this.createdAt,
      this.completedAt})
      : _notificationIds = notificationIds,
        _userIds = userIds,
        _topics = topics,
        _tags = tags,
        _filters = filters,
        _azureResponse = azureResponse;

  factory _$NotificationBatchImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationBatchImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<String> _notificationIds;
  @override
  List<String> get notificationIds {
    if (_notificationIds is EqualUnmodifiableListView) return _notificationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationIds);
  }

// Targeting
  final List<String>? _userIds;
// Targeting
  @override
  List<String>? get userIds {
    final value = _userIds;
    if (value == null) return null;
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _topics;
  @override
  List<String>? get topics {
    final value = _topics;
    if (value == null) return null;
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, String>? _filters;
  @override
  Map<String, String>? get filters {
    final value = _filters;
    if (value == null) return null;
    if (_filters is EqualUnmodifiableMapView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Scheduling
  @override
  final DateTime? scheduledFor;
  @override
  @JsonKey()
  final bool isScheduled;
// Status
  @override
  final String status;
  @override
  @JsonKey()
  final int totalRecipients;
  @override
  @JsonKey()
  final int successfulDeliveries;
  @override
  @JsonKey()
  final int failedDeliveries;
// Azure Integration
  @override
  final String? azureBatchId;
  final Map<String, dynamic>? _azureResponse;
  @override
  Map<String, dynamic>? get azureResponse {
    final value = _azureResponse;
    if (value == null) return null;
    if (_azureResponse is EqualUnmodifiableMapView) return _azureResponse;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'NotificationBatch(id: $id, name: $name, notificationIds: $notificationIds, userIds: $userIds, topics: $topics, tags: $tags, filters: $filters, scheduledFor: $scheduledFor, isScheduled: $isScheduled, status: $status, totalRecipients: $totalRecipients, successfulDeliveries: $successfulDeliveries, failedDeliveries: $failedDeliveries, azureBatchId: $azureBatchId, azureResponse: $azureResponse, createdAt: $createdAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationBatchImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._notificationIds, _notificationIds) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._filters, _filters) &&
            (identical(other.scheduledFor, scheduledFor) ||
                other.scheduledFor == scheduledFor) &&
            (identical(other.isScheduled, isScheduled) ||
                other.isScheduled == isScheduled) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.totalRecipients, totalRecipients) ||
                other.totalRecipients == totalRecipients) &&
            (identical(other.successfulDeliveries, successfulDeliveries) ||
                other.successfulDeliveries == successfulDeliveries) &&
            (identical(other.failedDeliveries, failedDeliveries) ||
                other.failedDeliveries == failedDeliveries) &&
            (identical(other.azureBatchId, azureBatchId) ||
                other.azureBatchId == azureBatchId) &&
            const DeepCollectionEquality()
                .equals(other._azureResponse, _azureResponse) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      const DeepCollectionEquality().hash(_notificationIds),
      const DeepCollectionEquality().hash(_userIds),
      const DeepCollectionEquality().hash(_topics),
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_filters),
      scheduledFor,
      isScheduled,
      status,
      totalRecipients,
      successfulDeliveries,
      failedDeliveries,
      azureBatchId,
      const DeepCollectionEquality().hash(_azureResponse),
      createdAt,
      completedAt);

  /// Create a copy of NotificationBatch
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationBatchImplCopyWith<_$NotificationBatchImpl> get copyWith =>
      __$$NotificationBatchImplCopyWithImpl<_$NotificationBatchImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationBatchImplToJson(
      this,
    );
  }
}

abstract class _NotificationBatch implements NotificationBatch {
  const factory _NotificationBatch(
      {required final String id,
      required final String name,
      required final List<String> notificationIds,
      final List<String>? userIds,
      final List<String>? topics,
      final List<String>? tags,
      final Map<String, String>? filters,
      final DateTime? scheduledFor,
      final bool isScheduled,
      required final String status,
      final int totalRecipients,
      final int successfulDeliveries,
      final int failedDeliveries,
      final String? azureBatchId,
      final Map<String, dynamic>? azureResponse,
      final DateTime? createdAt,
      final DateTime? completedAt}) = _$NotificationBatchImpl;

  factory _NotificationBatch.fromJson(Map<String, dynamic> json) =
      _$NotificationBatchImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<String> get notificationIds; // Targeting
  @override
  List<String>? get userIds;
  @override
  List<String>? get topics;
  @override
  List<String>? get tags;
  @override
  Map<String, String>? get filters; // Scheduling
  @override
  DateTime? get scheduledFor;
  @override
  bool get isScheduled; // Status
  @override
  String get status;
  @override
  int get totalRecipients;
  @override
  int get successfulDeliveries;
  @override
  int get failedDeliveries; // Azure Integration
  @override
  String? get azureBatchId;
  @override
  Map<String, dynamic>? get azureResponse; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of NotificationBatch
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationBatchImplCopyWith<_$NotificationBatchImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
