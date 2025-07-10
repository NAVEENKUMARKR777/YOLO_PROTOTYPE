import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

enum ChatRoomType {
  @JsonValue('direct')
  direct,
  @JsonValue('group')
  group,
  @JsonValue('community')
  community,
  @JsonValue('support')
  support,
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('audio')
  audio,
  @JsonValue('video')
  video,
  @JsonValue('file')
  file,
  @JsonValue('location')
  location,
  @JsonValue('system')
  system,
  @JsonValue('ai_response')
  aiResponse,
}

enum MessageStatus {
  @JsonValue('sending')
  sending,
  @JsonValue('sent')
  sent,
  @JsonValue('delivered')
  delivered,
  @JsonValue('read')
  read,
  @JsonValue('failed')
  failed,
}

@freezed
class ChatRoom with _$ChatRoom {
  const factory ChatRoom({
    required String id,
    required String name,
    required ChatType type,
    List<String>? participants,
    String? lastMessage,
    DateTime? lastMessageAt,
    int? unreadCount,
    bool? isActive,
    Map<String, dynamic>? metadata,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChatRoom;

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
}

@freezed
class ChatMessage with _$ChatMessage {
  const factory ChatMessage({
    required String id,
    required String roomId,
    required String senderId,
    String? senderName,
    required String content,
    required ChatMessageType type,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
    int? fileSize,
    Map<String, dynamic>? metadata,
    bool? isRead,
    bool? isAiGenerated,
    DateTime? readAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ChatMessage;

  factory ChatMessage.fromJson(Map<String, dynamic> json) => _$ChatMessageFromJson(json);
}

@freezed
class ChatParticipant with _$ChatParticipant {
  const factory ChatParticipant({
    required String userId,
    required String role,
    
    // Permissions
    @Default(true) bool canSendMessages,
    @Default(true) bool canSendFiles,
    @Default(false) bool canDeleteMessages,
    @Default(false) bool canAddParticipants,
    @Default(false) bool canRemoveParticipants,
    @Default(false) bool isAdmin,
    
    // Activity
    DateTime? lastReadAt,
    DateTime? lastSeenAt,
    DateTime? lastTypingAt,
    @Default(false) bool isTyping,
    @Default(true) bool isActive,
    @Default(false) bool isMuted,
    
    // Timestamps
    DateTime? joinedAt,
    DateTime? leftAt,
  }) = _ChatParticipant;

  factory ChatParticipant.fromJson(Map<String, dynamic> json) => _$ChatParticipantFromJson(json);
}

@freezed
class AiChatSession with _$AiChatSession {
  const factory AiChatSession({
    required String id,
    required String userId,
    required String chatRoomId,
    String? needId,
    
    // AI Configuration
    required String aiModel,
    Map<String, dynamic>? systemPrompt,
    Map<String, dynamic>? context,
    List<ChatMessage>? conversationHistory,
    
    // Session State
    @Default(true) bool isActive,
    @Default(0) int messageCount,
    @Default(0) int tokenUsage,
    double? totalCost,
    
    // Feedback
    double? sessionRating,
    String? userFeedback,
    @Default(false) bool wasHelpful,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? endedAt,
    DateTime? lastInteractionAt,
  }) = _AiChatSession;

  factory AiChatSession.fromJson(Map<String, dynamic> json) => _$AiChatSessionFromJson(json);
} 