// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) {
  return _ChatRoom.fromJson(json);
}

/// @nodoc
mixin _$ChatRoom {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  ChatType get type => throw _privateConstructorUsedError;
  List<String>? get participants => throw _privateConstructorUsedError;
  String? get lastMessage => throw _privateConstructorUsedError;
  DateTime? get lastMessageAt => throw _privateConstructorUsedError;
  int? get unreadCount => throw _privateConstructorUsedError;
  bool? get isActive => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatRoom to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatRoomCopyWith<ChatRoom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatRoomCopyWith<$Res> {
  factory $ChatRoomCopyWith(ChatRoom value, $Res Function(ChatRoom) then) =
      _$ChatRoomCopyWithImpl<$Res, ChatRoom>;
  @useResult
  $Res call(
      {String id,
      String name,
      ChatType type,
      List<String>? participants,
      String? lastMessage,
      DateTime? lastMessageAt,
      int? unreadCount,
      bool? isActive,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ChatRoomCopyWithImpl<$Res, $Val extends ChatRoom>
    implements $ChatRoomCopyWith<$Res> {
  _$ChatRoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
    Object? participants = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = freezed,
    Object? isActive = freezed,
    Object? metadata = freezed,
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
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      participants: freezed == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
abstract class _$$ChatRoomImplCopyWith<$Res>
    implements $ChatRoomCopyWith<$Res> {
  factory _$$ChatRoomImplCopyWith(
          _$ChatRoomImpl value, $Res Function(_$ChatRoomImpl) then) =
      __$$ChatRoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      ChatType type,
      List<String>? participants,
      String? lastMessage,
      DateTime? lastMessageAt,
      int? unreadCount,
      bool? isActive,
      Map<String, dynamic>? metadata,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ChatRoomImplCopyWithImpl<$Res>
    extends _$ChatRoomCopyWithImpl<$Res, _$ChatRoomImpl>
    implements _$$ChatRoomImplCopyWith<$Res> {
  __$$ChatRoomImplCopyWithImpl(
      _$ChatRoomImpl _value, $Res Function(_$ChatRoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = freezed,
    Object? participants = freezed,
    Object? lastMessage = freezed,
    Object? lastMessageAt = freezed,
    Object? unreadCount = freezed,
    Object? isActive = freezed,
    Object? metadata = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChatRoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      participants: freezed == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMessageAt: freezed == lastMessageAt
          ? _value.lastMessageAt
          : lastMessageAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      unreadCount: freezed == unreadCount
          ? _value.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int?,
      isActive: freezed == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
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
class _$ChatRoomImpl implements _ChatRoom {
  const _$ChatRoomImpl(
      {required this.id,
      required this.name,
      required this.type,
      final List<String>? participants,
      this.lastMessage,
      this.lastMessageAt,
      this.unreadCount,
      this.isActive,
      final Map<String, dynamic>? metadata,
      this.createdAt,
      this.updatedAt})
      : _participants = participants,
        _metadata = metadata;

  factory _$ChatRoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatRoomImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final ChatType type;
  final List<String>? _participants;
  @override
  List<String>? get participants {
    final value = _participants;
    if (value == null) return null;
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? lastMessage;
  @override
  final DateTime? lastMessageAt;
  @override
  final int? unreadCount;
  @override
  final bool? isActive;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ChatRoom(id: $id, name: $name, type: $type, participants: $participants, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, unreadCount: $unreadCount, isActive: $isActive, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatRoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageAt, lastMessageAt) ||
                other.lastMessageAt == lastMessageAt) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
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
      name,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(_participants),
      lastMessage,
      lastMessageAt,
      unreadCount,
      isActive,
      const DeepCollectionEquality().hash(_metadata),
      createdAt,
      updatedAt);

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      __$$ChatRoomImplCopyWithImpl<_$ChatRoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatRoomImplToJson(
      this,
    );
  }
}

abstract class _ChatRoom implements ChatRoom {
  const factory _ChatRoom(
      {required final String id,
      required final String name,
      required final ChatType type,
      final List<String>? participants,
      final String? lastMessage,
      final DateTime? lastMessageAt,
      final int? unreadCount,
      final bool? isActive,
      final Map<String, dynamic>? metadata,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ChatRoomImpl;

  factory _ChatRoom.fromJson(Map<String, dynamic> json) =
      _$ChatRoomImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  ChatType get type;
  @override
  List<String>? get participants;
  @override
  String? get lastMessage;
  @override
  DateTime? get lastMessageAt;
  @override
  int? get unreadCount;
  @override
  bool? get isActive;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ChatRoom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatRoomImplCopyWith<_$ChatRoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String? get senderName => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  ChatMessageType get type => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get fileUrl => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  int? get fileSize => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  bool? get isRead => throw _privateConstructorUsedError;
  bool? get isAiGenerated => throw _privateConstructorUsedError;
  DateTime? get readAt => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call(
      {String id,
      String roomId,
      String senderId,
      String? senderName,
      String content,
      ChatMessageType type,
      String? imageUrl,
      String? fileUrl,
      String? fileName,
      int? fileSize,
      Map<String, dynamic>? metadata,
      bool? isRead,
      bool? isAiGenerated,
      DateTime? readAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? senderId = null,
    Object? senderName = freezed,
    Object? content = null,
    Object? type = freezed,
    Object? imageUrl = freezed,
    Object? fileUrl = freezed,
    Object? fileName = freezed,
    Object? fileSize = freezed,
    Object? metadata = freezed,
    Object? isRead = freezed,
    Object? isAiGenerated = freezed,
    Object? readAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatMessageType,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAiGenerated: freezed == isAiGenerated
          ? _value.isAiGenerated
          : isAiGenerated // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
          _$ChatMessageImpl value, $Res Function(_$ChatMessageImpl) then) =
      __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String roomId,
      String senderId,
      String? senderName,
      String content,
      ChatMessageType type,
      String? imageUrl,
      String? fileUrl,
      String? fileName,
      int? fileSize,
      Map<String, dynamic>? metadata,
      bool? isRead,
      bool? isAiGenerated,
      DateTime? readAt,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
      _$ChatMessageImpl _value, $Res Function(_$ChatMessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? senderId = null,
    Object? senderName = freezed,
    Object? content = null,
    Object? type = freezed,
    Object? imageUrl = freezed,
    Object? fileUrl = freezed,
    Object? fileName = freezed,
    Object? fileSize = freezed,
    Object? metadata = freezed,
    Object? isRead = freezed,
    Object? isAiGenerated = freezed,
    Object? readAt = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ChatMessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      senderName: freezed == senderName
          ? _value.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String?,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatMessageType,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileUrl: freezed == fileUrl
          ? _value.fileUrl
          : fileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _value.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as int?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isRead: freezed == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool?,
      isAiGenerated: freezed == isAiGenerated
          ? _value.isAiGenerated
          : isAiGenerated // ignore: cast_nullable_to_non_nullable
              as bool?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
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
class _$ChatMessageImpl implements _ChatMessage {
  const _$ChatMessageImpl(
      {required this.id,
      required this.roomId,
      required this.senderId,
      this.senderName,
      required this.content,
      required this.type,
      this.imageUrl,
      this.fileUrl,
      this.fileName,
      this.fileSize,
      final Map<String, dynamic>? metadata,
      this.isRead,
      this.isAiGenerated,
      this.readAt,
      this.createdAt,
      this.updatedAt})
      : _metadata = metadata;

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  @override
  final String senderId;
  @override
  final String? senderName;
  @override
  final String content;
  @override
  final ChatMessageType type;
  @override
  final String? imageUrl;
  @override
  final String? fileUrl;
  @override
  final String? fileName;
  @override
  final int? fileSize;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final bool? isRead;
  @override
  final bool? isAiGenerated;
  @override
  final DateTime? readAt;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ChatMessage(id: $id, roomId: $roomId, senderId: $senderId, senderName: $senderName, content: $content, type: $type, imageUrl: $imageUrl, fileUrl: $fileUrl, fileName: $fileName, fileSize: $fileSize, metadata: $metadata, isRead: $isRead, isAiGenerated: $isAiGenerated, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.content, content) || other.content == content) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isAiGenerated, isAiGenerated) ||
                other.isAiGenerated == isAiGenerated) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
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
      roomId,
      senderId,
      senderName,
      content,
      const DeepCollectionEquality().hash(type),
      imageUrl,
      fileUrl,
      fileName,
      fileSize,
      const DeepCollectionEquality().hash(_metadata),
      isRead,
      isAiGenerated,
      readAt,
      createdAt,
      updatedAt);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(
      this,
    );
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage(
      {required final String id,
      required final String roomId,
      required final String senderId,
      final String? senderName,
      required final String content,
      required final ChatMessageType type,
      final String? imageUrl,
      final String? fileUrl,
      final String? fileName,
      final int? fileSize,
      final Map<String, dynamic>? metadata,
      final bool? isRead,
      final bool? isAiGenerated,
      final DateTime? readAt,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  String get senderId;
  @override
  String? get senderName;
  @override
  String get content;
  @override
  ChatMessageType get type;
  @override
  String? get imageUrl;
  @override
  String? get fileUrl;
  @override
  String? get fileName;
  @override
  int? get fileSize;
  @override
  Map<String, dynamic>? get metadata;
  @override
  bool? get isRead;
  @override
  bool? get isAiGenerated;
  @override
  DateTime? get readAt;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatParticipant _$ChatParticipantFromJson(Map<String, dynamic> json) {
  return _ChatParticipant.fromJson(json);
}

/// @nodoc
mixin _$ChatParticipant {
  String get userId => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError; // Permissions
  bool get canSendMessages => throw _privateConstructorUsedError;
  bool get canSendFiles => throw _privateConstructorUsedError;
  bool get canDeleteMessages => throw _privateConstructorUsedError;
  bool get canAddParticipants => throw _privateConstructorUsedError;
  bool get canRemoveParticipants => throw _privateConstructorUsedError;
  bool get isAdmin => throw _privateConstructorUsedError; // Activity
  DateTime? get lastReadAt => throw _privateConstructorUsedError;
  DateTime? get lastSeenAt => throw _privateConstructorUsedError;
  DateTime? get lastTypingAt => throw _privateConstructorUsedError;
  bool get isTyping => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isMuted => throw _privateConstructorUsedError; // Timestamps
  DateTime? get joinedAt => throw _privateConstructorUsedError;
  DateTime? get leftAt => throw _privateConstructorUsedError;

  /// Serializes this ChatParticipant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatParticipantCopyWith<ChatParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatParticipantCopyWith<$Res> {
  factory $ChatParticipantCopyWith(
          ChatParticipant value, $Res Function(ChatParticipant) then) =
      _$ChatParticipantCopyWithImpl<$Res, ChatParticipant>;
  @useResult
  $Res call(
      {String userId,
      String role,
      bool canSendMessages,
      bool canSendFiles,
      bool canDeleteMessages,
      bool canAddParticipants,
      bool canRemoveParticipants,
      bool isAdmin,
      DateTime? lastReadAt,
      DateTime? lastSeenAt,
      DateTime? lastTypingAt,
      bool isTyping,
      bool isActive,
      bool isMuted,
      DateTime? joinedAt,
      DateTime? leftAt});
}

/// @nodoc
class _$ChatParticipantCopyWithImpl<$Res, $Val extends ChatParticipant>
    implements $ChatParticipantCopyWith<$Res> {
  _$ChatParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? role = null,
    Object? canSendMessages = null,
    Object? canSendFiles = null,
    Object? canDeleteMessages = null,
    Object? canAddParticipants = null,
    Object? canRemoveParticipants = null,
    Object? isAdmin = null,
    Object? lastReadAt = freezed,
    Object? lastSeenAt = freezed,
    Object? lastTypingAt = freezed,
    Object? isTyping = null,
    Object? isActive = null,
    Object? isMuted = null,
    Object? joinedAt = freezed,
    Object? leftAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      canSendMessages: null == canSendMessages
          ? _value.canSendMessages
          : canSendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      canSendFiles: null == canSendFiles
          ? _value.canSendFiles
          : canSendFiles // ignore: cast_nullable_to_non_nullable
              as bool,
      canDeleteMessages: null == canDeleteMessages
          ? _value.canDeleteMessages
          : canDeleteMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      canAddParticipants: null == canAddParticipants
          ? _value.canAddParticipants
          : canAddParticipants // ignore: cast_nullable_to_non_nullable
              as bool,
      canRemoveParticipants: null == canRemoveParticipants
          ? _value.canRemoveParticipants
          : canRemoveParticipants // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTypingAt: freezed == lastTypingAt
          ? _value.lastTypingAt
          : lastTypingAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leftAt: freezed == leftAt
          ? _value.leftAt
          : leftAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatParticipantImplCopyWith<$Res>
    implements $ChatParticipantCopyWith<$Res> {
  factory _$$ChatParticipantImplCopyWith(_$ChatParticipantImpl value,
          $Res Function(_$ChatParticipantImpl) then) =
      __$$ChatParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String role,
      bool canSendMessages,
      bool canSendFiles,
      bool canDeleteMessages,
      bool canAddParticipants,
      bool canRemoveParticipants,
      bool isAdmin,
      DateTime? lastReadAt,
      DateTime? lastSeenAt,
      DateTime? lastTypingAt,
      bool isTyping,
      bool isActive,
      bool isMuted,
      DateTime? joinedAt,
      DateTime? leftAt});
}

/// @nodoc
class __$$ChatParticipantImplCopyWithImpl<$Res>
    extends _$ChatParticipantCopyWithImpl<$Res, _$ChatParticipantImpl>
    implements _$$ChatParticipantImplCopyWith<$Res> {
  __$$ChatParticipantImplCopyWithImpl(
      _$ChatParticipantImpl _value, $Res Function(_$ChatParticipantImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChatParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? role = null,
    Object? canSendMessages = null,
    Object? canSendFiles = null,
    Object? canDeleteMessages = null,
    Object? canAddParticipants = null,
    Object? canRemoveParticipants = null,
    Object? isAdmin = null,
    Object? lastReadAt = freezed,
    Object? lastSeenAt = freezed,
    Object? lastTypingAt = freezed,
    Object? isTyping = null,
    Object? isActive = null,
    Object? isMuted = null,
    Object? joinedAt = freezed,
    Object? leftAt = freezed,
  }) {
    return _then(_$ChatParticipantImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      canSendMessages: null == canSendMessages
          ? _value.canSendMessages
          : canSendMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      canSendFiles: null == canSendFiles
          ? _value.canSendFiles
          : canSendFiles // ignore: cast_nullable_to_non_nullable
              as bool,
      canDeleteMessages: null == canDeleteMessages
          ? _value.canDeleteMessages
          : canDeleteMessages // ignore: cast_nullable_to_non_nullable
              as bool,
      canAddParticipants: null == canAddParticipants
          ? _value.canAddParticipants
          : canAddParticipants // ignore: cast_nullable_to_non_nullable
              as bool,
      canRemoveParticipants: null == canRemoveParticipants
          ? _value.canRemoveParticipants
          : canRemoveParticipants // ignore: cast_nullable_to_non_nullable
              as bool,
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastSeenAt: freezed == lastSeenAt
          ? _value.lastSeenAt
          : lastSeenAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastTypingAt: freezed == lastTypingAt
          ? _value.lastTypingAt
          : lastTypingAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isTyping: null == isTyping
          ? _value.isTyping
          : isTyping // ignore: cast_nullable_to_non_nullable
              as bool,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isMuted: null == isMuted
          ? _value.isMuted
          : isMuted // ignore: cast_nullable_to_non_nullable
              as bool,
      joinedAt: freezed == joinedAt
          ? _value.joinedAt
          : joinedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      leftAt: freezed == leftAt
          ? _value.leftAt
          : leftAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatParticipantImpl implements _ChatParticipant {
  const _$ChatParticipantImpl(
      {required this.userId,
      required this.role,
      this.canSendMessages = true,
      this.canSendFiles = true,
      this.canDeleteMessages = false,
      this.canAddParticipants = false,
      this.canRemoveParticipants = false,
      this.isAdmin = false,
      this.lastReadAt,
      this.lastSeenAt,
      this.lastTypingAt,
      this.isTyping = false,
      this.isActive = true,
      this.isMuted = false,
      this.joinedAt,
      this.leftAt});

  factory _$ChatParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatParticipantImplFromJson(json);

  @override
  final String userId;
  @override
  final String role;
// Permissions
  @override
  @JsonKey()
  final bool canSendMessages;
  @override
  @JsonKey()
  final bool canSendFiles;
  @override
  @JsonKey()
  final bool canDeleteMessages;
  @override
  @JsonKey()
  final bool canAddParticipants;
  @override
  @JsonKey()
  final bool canRemoveParticipants;
  @override
  @JsonKey()
  final bool isAdmin;
// Activity
  @override
  final DateTime? lastReadAt;
  @override
  final DateTime? lastSeenAt;
  @override
  final DateTime? lastTypingAt;
  @override
  @JsonKey()
  final bool isTyping;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isMuted;
// Timestamps
  @override
  final DateTime? joinedAt;
  @override
  final DateTime? leftAt;

  @override
  String toString() {
    return 'ChatParticipant(userId: $userId, role: $role, canSendMessages: $canSendMessages, canSendFiles: $canSendFiles, canDeleteMessages: $canDeleteMessages, canAddParticipants: $canAddParticipants, canRemoveParticipants: $canRemoveParticipants, isAdmin: $isAdmin, lastReadAt: $lastReadAt, lastSeenAt: $lastSeenAt, lastTypingAt: $lastTypingAt, isTyping: $isTyping, isActive: $isActive, isMuted: $isMuted, joinedAt: $joinedAt, leftAt: $leftAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatParticipantImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.canSendMessages, canSendMessages) ||
                other.canSendMessages == canSendMessages) &&
            (identical(other.canSendFiles, canSendFiles) ||
                other.canSendFiles == canSendFiles) &&
            (identical(other.canDeleteMessages, canDeleteMessages) ||
                other.canDeleteMessages == canDeleteMessages) &&
            (identical(other.canAddParticipants, canAddParticipants) ||
                other.canAddParticipants == canAddParticipants) &&
            (identical(other.canRemoveParticipants, canRemoveParticipants) ||
                other.canRemoveParticipants == canRemoveParticipants) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.lastTypingAt, lastTypingAt) ||
                other.lastTypingAt == lastTypingAt) &&
            (identical(other.isTyping, isTyping) ||
                other.isTyping == isTyping) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isMuted, isMuted) || other.isMuted == isMuted) &&
            (identical(other.joinedAt, joinedAt) ||
                other.joinedAt == joinedAt) &&
            (identical(other.leftAt, leftAt) || other.leftAt == leftAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      role,
      canSendMessages,
      canSendFiles,
      canDeleteMessages,
      canAddParticipants,
      canRemoveParticipants,
      isAdmin,
      lastReadAt,
      lastSeenAt,
      lastTypingAt,
      isTyping,
      isActive,
      isMuted,
      joinedAt,
      leftAt);

  /// Create a copy of ChatParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatParticipantImplCopyWith<_$ChatParticipantImpl> get copyWith =>
      __$$ChatParticipantImplCopyWithImpl<_$ChatParticipantImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatParticipantImplToJson(
      this,
    );
  }
}

abstract class _ChatParticipant implements ChatParticipant {
  const factory _ChatParticipant(
      {required final String userId,
      required final String role,
      final bool canSendMessages,
      final bool canSendFiles,
      final bool canDeleteMessages,
      final bool canAddParticipants,
      final bool canRemoveParticipants,
      final bool isAdmin,
      final DateTime? lastReadAt,
      final DateTime? lastSeenAt,
      final DateTime? lastTypingAt,
      final bool isTyping,
      final bool isActive,
      final bool isMuted,
      final DateTime? joinedAt,
      final DateTime? leftAt}) = _$ChatParticipantImpl;

  factory _ChatParticipant.fromJson(Map<String, dynamic> json) =
      _$ChatParticipantImpl.fromJson;

  @override
  String get userId;
  @override
  String get role; // Permissions
  @override
  bool get canSendMessages;
  @override
  bool get canSendFiles;
  @override
  bool get canDeleteMessages;
  @override
  bool get canAddParticipants;
  @override
  bool get canRemoveParticipants;
  @override
  bool get isAdmin; // Activity
  @override
  DateTime? get lastReadAt;
  @override
  DateTime? get lastSeenAt;
  @override
  DateTime? get lastTypingAt;
  @override
  bool get isTyping;
  @override
  bool get isActive;
  @override
  bool get isMuted; // Timestamps
  @override
  DateTime? get joinedAt;
  @override
  DateTime? get leftAt;

  /// Create a copy of ChatParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatParticipantImplCopyWith<_$ChatParticipantImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AiChatSession _$AiChatSessionFromJson(Map<String, dynamic> json) {
  return _AiChatSession.fromJson(json);
}

/// @nodoc
mixin _$AiChatSession {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get chatRoomId => throw _privateConstructorUsedError;
  String? get needId => throw _privateConstructorUsedError; // AI Configuration
  String get aiModel => throw _privateConstructorUsedError;
  Map<String, dynamic>? get systemPrompt => throw _privateConstructorUsedError;
  Map<String, dynamic>? get context => throw _privateConstructorUsedError;
  List<ChatMessage>? get conversationHistory =>
      throw _privateConstructorUsedError; // Session State
  bool get isActive => throw _privateConstructorUsedError;
  int get messageCount => throw _privateConstructorUsedError;
  int get tokenUsage => throw _privateConstructorUsedError;
  double? get totalCost => throw _privateConstructorUsedError; // Feedback
  double? get sessionRating => throw _privateConstructorUsedError;
  String? get userFeedback => throw _privateConstructorUsedError;
  bool get wasHelpful => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  DateTime? get lastInteractionAt => throw _privateConstructorUsedError;

  /// Serializes this AiChatSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiChatSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiChatSessionCopyWith<AiChatSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiChatSessionCopyWith<$Res> {
  factory $AiChatSessionCopyWith(
          AiChatSession value, $Res Function(AiChatSession) then) =
      _$AiChatSessionCopyWithImpl<$Res, AiChatSession>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String chatRoomId,
      String? needId,
      String aiModel,
      Map<String, dynamic>? systemPrompt,
      Map<String, dynamic>? context,
      List<ChatMessage>? conversationHistory,
      bool isActive,
      int messageCount,
      int tokenUsage,
      double? totalCost,
      double? sessionRating,
      String? userFeedback,
      bool wasHelpful,
      DateTime? createdAt,
      DateTime? endedAt,
      DateTime? lastInteractionAt});
}

/// @nodoc
class _$AiChatSessionCopyWithImpl<$Res, $Val extends AiChatSession>
    implements $AiChatSessionCopyWith<$Res> {
  _$AiChatSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiChatSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? chatRoomId = null,
    Object? needId = freezed,
    Object? aiModel = null,
    Object? systemPrompt = freezed,
    Object? context = freezed,
    Object? conversationHistory = freezed,
    Object? isActive = null,
    Object? messageCount = null,
    Object? tokenUsage = null,
    Object? totalCost = freezed,
    Object? sessionRating = freezed,
    Object? userFeedback = freezed,
    Object? wasHelpful = null,
    Object? createdAt = freezed,
    Object? endedAt = freezed,
    Object? lastInteractionAt = freezed,
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
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      needId: freezed == needId
          ? _value.needId
          : needId // ignore: cast_nullable_to_non_nullable
              as String?,
      aiModel: null == aiModel
          ? _value.aiModel
          : aiModel // ignore: cast_nullable_to_non_nullable
              as String,
      systemPrompt: freezed == systemPrompt
          ? _value.systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      conversationHistory: freezed == conversationHistory
          ? _value.conversationHistory
          : conversationHistory // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
      tokenUsage: null == tokenUsage
          ? _value.tokenUsage
          : tokenUsage // ignore: cast_nullable_to_non_nullable
              as int,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      sessionRating: freezed == sessionRating
          ? _value.sessionRating
          : sessionRating // ignore: cast_nullable_to_non_nullable
              as double?,
      userFeedback: freezed == userFeedback
          ? _value.userFeedback
          : userFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      wasHelpful: null == wasHelpful
          ? _value.wasHelpful
          : wasHelpful // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastInteractionAt: freezed == lastInteractionAt
          ? _value.lastInteractionAt
          : lastInteractionAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AiChatSessionImplCopyWith<$Res>
    implements $AiChatSessionCopyWith<$Res> {
  factory _$$AiChatSessionImplCopyWith(
          _$AiChatSessionImpl value, $Res Function(_$AiChatSessionImpl) then) =
      __$$AiChatSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String chatRoomId,
      String? needId,
      String aiModel,
      Map<String, dynamic>? systemPrompt,
      Map<String, dynamic>? context,
      List<ChatMessage>? conversationHistory,
      bool isActive,
      int messageCount,
      int tokenUsage,
      double? totalCost,
      double? sessionRating,
      String? userFeedback,
      bool wasHelpful,
      DateTime? createdAt,
      DateTime? endedAt,
      DateTime? lastInteractionAt});
}

/// @nodoc
class __$$AiChatSessionImplCopyWithImpl<$Res>
    extends _$AiChatSessionCopyWithImpl<$Res, _$AiChatSessionImpl>
    implements _$$AiChatSessionImplCopyWith<$Res> {
  __$$AiChatSessionImplCopyWithImpl(
      _$AiChatSessionImpl _value, $Res Function(_$AiChatSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of AiChatSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? chatRoomId = null,
    Object? needId = freezed,
    Object? aiModel = null,
    Object? systemPrompt = freezed,
    Object? context = freezed,
    Object? conversationHistory = freezed,
    Object? isActive = null,
    Object? messageCount = null,
    Object? tokenUsage = null,
    Object? totalCost = freezed,
    Object? sessionRating = freezed,
    Object? userFeedback = freezed,
    Object? wasHelpful = null,
    Object? createdAt = freezed,
    Object? endedAt = freezed,
    Object? lastInteractionAt = freezed,
  }) {
    return _then(_$AiChatSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      chatRoomId: null == chatRoomId
          ? _value.chatRoomId
          : chatRoomId // ignore: cast_nullable_to_non_nullable
              as String,
      needId: freezed == needId
          ? _value.needId
          : needId // ignore: cast_nullable_to_non_nullable
              as String?,
      aiModel: null == aiModel
          ? _value.aiModel
          : aiModel // ignore: cast_nullable_to_non_nullable
              as String,
      systemPrompt: freezed == systemPrompt
          ? _value._systemPrompt
          : systemPrompt // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      context: freezed == context
          ? _value._context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      conversationHistory: freezed == conversationHistory
          ? _value._conversationHistory
          : conversationHistory // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      messageCount: null == messageCount
          ? _value.messageCount
          : messageCount // ignore: cast_nullable_to_non_nullable
              as int,
      tokenUsage: null == tokenUsage
          ? _value.tokenUsage
          : tokenUsage // ignore: cast_nullable_to_non_nullable
              as int,
      totalCost: freezed == totalCost
          ? _value.totalCost
          : totalCost // ignore: cast_nullable_to_non_nullable
              as double?,
      sessionRating: freezed == sessionRating
          ? _value.sessionRating
          : sessionRating // ignore: cast_nullable_to_non_nullable
              as double?,
      userFeedback: freezed == userFeedback
          ? _value.userFeedback
          : userFeedback // ignore: cast_nullable_to_non_nullable
              as String?,
      wasHelpful: null == wasHelpful
          ? _value.wasHelpful
          : wasHelpful // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endedAt: freezed == endedAt
          ? _value.endedAt
          : endedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastInteractionAt: freezed == lastInteractionAt
          ? _value.lastInteractionAt
          : lastInteractionAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AiChatSessionImpl implements _AiChatSession {
  const _$AiChatSessionImpl(
      {required this.id,
      required this.userId,
      required this.chatRoomId,
      this.needId,
      required this.aiModel,
      final Map<String, dynamic>? systemPrompt,
      final Map<String, dynamic>? context,
      final List<ChatMessage>? conversationHistory,
      this.isActive = true,
      this.messageCount = 0,
      this.tokenUsage = 0,
      this.totalCost,
      this.sessionRating,
      this.userFeedback,
      this.wasHelpful = false,
      this.createdAt,
      this.endedAt,
      this.lastInteractionAt})
      : _systemPrompt = systemPrompt,
        _context = context,
        _conversationHistory = conversationHistory;

  factory _$AiChatSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiChatSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String chatRoomId;
  @override
  final String? needId;
// AI Configuration
  @override
  final String aiModel;
  final Map<String, dynamic>? _systemPrompt;
  @override
  Map<String, dynamic>? get systemPrompt {
    final value = _systemPrompt;
    if (value == null) return null;
    if (_systemPrompt is EqualUnmodifiableMapView) return _systemPrompt;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _context;
  @override
  Map<String, dynamic>? get context {
    final value = _context;
    if (value == null) return null;
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<ChatMessage>? _conversationHistory;
  @override
  List<ChatMessage>? get conversationHistory {
    final value = _conversationHistory;
    if (value == null) return null;
    if (_conversationHistory is EqualUnmodifiableListView)
      return _conversationHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Session State
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final int messageCount;
  @override
  @JsonKey()
  final int tokenUsage;
  @override
  final double? totalCost;
// Feedback
  @override
  final double? sessionRating;
  @override
  final String? userFeedback;
  @override
  @JsonKey()
  final bool wasHelpful;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? endedAt;
  @override
  final DateTime? lastInteractionAt;

  @override
  String toString() {
    return 'AiChatSession(id: $id, userId: $userId, chatRoomId: $chatRoomId, needId: $needId, aiModel: $aiModel, systemPrompt: $systemPrompt, context: $context, conversationHistory: $conversationHistory, isActive: $isActive, messageCount: $messageCount, tokenUsage: $tokenUsage, totalCost: $totalCost, sessionRating: $sessionRating, userFeedback: $userFeedback, wasHelpful: $wasHelpful, createdAt: $createdAt, endedAt: $endedAt, lastInteractionAt: $lastInteractionAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiChatSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.chatRoomId, chatRoomId) ||
                other.chatRoomId == chatRoomId) &&
            (identical(other.needId, needId) || other.needId == needId) &&
            (identical(other.aiModel, aiModel) || other.aiModel == aiModel) &&
            const DeepCollectionEquality()
                .equals(other._systemPrompt, _systemPrompt) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            const DeepCollectionEquality()
                .equals(other._conversationHistory, _conversationHistory) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.messageCount, messageCount) ||
                other.messageCount == messageCount) &&
            (identical(other.tokenUsage, tokenUsage) ||
                other.tokenUsage == tokenUsage) &&
            (identical(other.totalCost, totalCost) ||
                other.totalCost == totalCost) &&
            (identical(other.sessionRating, sessionRating) ||
                other.sessionRating == sessionRating) &&
            (identical(other.userFeedback, userFeedback) ||
                other.userFeedback == userFeedback) &&
            (identical(other.wasHelpful, wasHelpful) ||
                other.wasHelpful == wasHelpful) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.lastInteractionAt, lastInteractionAt) ||
                other.lastInteractionAt == lastInteractionAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      chatRoomId,
      needId,
      aiModel,
      const DeepCollectionEquality().hash(_systemPrompt),
      const DeepCollectionEquality().hash(_context),
      const DeepCollectionEquality().hash(_conversationHistory),
      isActive,
      messageCount,
      tokenUsage,
      totalCost,
      sessionRating,
      userFeedback,
      wasHelpful,
      createdAt,
      endedAt,
      lastInteractionAt);

  /// Create a copy of AiChatSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiChatSessionImplCopyWith<_$AiChatSessionImpl> get copyWith =>
      __$$AiChatSessionImplCopyWithImpl<_$AiChatSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiChatSessionImplToJson(
      this,
    );
  }
}

abstract class _AiChatSession implements AiChatSession {
  const factory _AiChatSession(
      {required final String id,
      required final String userId,
      required final String chatRoomId,
      final String? needId,
      required final String aiModel,
      final Map<String, dynamic>? systemPrompt,
      final Map<String, dynamic>? context,
      final List<ChatMessage>? conversationHistory,
      final bool isActive,
      final int messageCount,
      final int tokenUsage,
      final double? totalCost,
      final double? sessionRating,
      final String? userFeedback,
      final bool wasHelpful,
      final DateTime? createdAt,
      final DateTime? endedAt,
      final DateTime? lastInteractionAt}) = _$AiChatSessionImpl;

  factory _AiChatSession.fromJson(Map<String, dynamic> json) =
      _$AiChatSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get chatRoomId;
  @override
  String? get needId; // AI Configuration
  @override
  String get aiModel;
  @override
  Map<String, dynamic>? get systemPrompt;
  @override
  Map<String, dynamic>? get context;
  @override
  List<ChatMessage>? get conversationHistory; // Session State
  @override
  bool get isActive;
  @override
  int get messageCount;
  @override
  int get tokenUsage;
  @override
  double? get totalCost; // Feedback
  @override
  double? get sessionRating;
  @override
  String? get userFeedback;
  @override
  bool get wasHelpful; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get endedAt;
  @override
  DateTime? get lastInteractionAt;

  /// Create a copy of AiChatSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiChatSessionImplCopyWith<_$AiChatSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
