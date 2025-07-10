import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/chat_model.dart';
import '../models/enums.dart';
import '../services/azure/azure_cosmos.dart';
import '../services/azure/azure_ai_chat.dart';
import 'auth_provider.dart';
import 'app_provider.dart';

part 'chat_provider.freezed.dart';

// AI Chat service provider
final aiChatServiceProvider = Provider<AzureAiChatService>((ref) {
  return AzureAiChatService();
});

// Chat rooms state provider
final chatRoomsProvider = StateNotifierProvider<ChatRoomsNotifier, ChatRoomsState>((ref) {
  final cosmosService = ref.watch(cosmosServiceProvider);
  final authState = ref.watch(authStateProvider);
  return ChatRoomsNotifier(cosmosService, authState.accessToken);
});

// Alias for backward compatibility
final chatStateProvider = chatRoomsProvider;

// AI Chat state provider
final aiChatProvider = StateNotifierProvider<AIChatNotifier, AIChatState>((ref) {
  final aiChatService = ref.watch(aiChatServiceProvider);
  final authState = ref.watch(authStateProvider);
  return AIChatNotifier(aiChatService, authState.accessToken);
});

// Active chat room provider
final activeChatRoomProvider = StateProvider<String?>((ref) => null);

// Chat messages provider for specific room
final chatMessagesProvider = StateNotifierProvider.family<ChatMessagesNotifier, ChatMessagesState, String>((ref, roomId) {
  final cosmosService = ref.watch(cosmosServiceProvider);
  final authState = ref.watch(authStateProvider);
  return ChatMessagesNotifier(cosmosService, roomId, authState.accessToken);
});

// Unread messages count provider
final unreadMessagesCountProvider = Provider<int>((ref) {
  final chatRoomsState = ref.watch(chatRoomsProvider);
  final currentUser = ref.watch(currentUserProvider);
  
  if (currentUser == null) return 0;
  
  return chatRoomsState.chatRooms.fold<int>(0, (total, room) {
    final userParticipant = room.participants.firstWhere(
      (p) => p.userId == currentUser.id,
      orElse: () => ChatParticipant(
        userId: currentUser.id,
        displayName: currentUser.displayName,
        joinedAt: DateTime.now(),
        lastSeenAt: DateTime.now(),
      ),
    );
    
    return total + room.unreadCount;
  });
});

// Chat Rooms State
class ChatRoomsState {
  final List<ChatRoom> chatRooms;
  final bool isLoading;
  final String? error;
  
  const ChatRoomsState({
    this.chatRooms = const [],
    this.isLoading = false,
    this.error,
  });
  
  ChatRoomsState copyWith({
    List<ChatRoom>? chatRooms,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return ChatRoomsState(
      chatRooms: chatRooms ?? this.chatRooms,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

// Chat Messages State
class ChatMessagesState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  final bool hasMore;
  
  const ChatMessagesState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.hasMore = true,
  });
  
  ChatMessagesState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
    bool? hasMore,
    bool clearError = false,
  }) {
    return ChatMessagesState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

// AI Chat State
class AIChatState {
  final AiChatSession? currentSession;
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isTyping;
  final String? error;
  final String? contextNeedId;
  
  const AIChatState({
    this.currentSession,
    this.messages = const [],
    this.isLoading = false,
    this.isTyping = false,
    this.error,
    this.contextNeedId,
  });
  
  AIChatState copyWith({
    AiChatSession? currentSession,
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isTyping,
    String? error,
    String? contextNeedId,
    bool clearError = false,
  }) {
    return AIChatState(
      currentSession: currentSession ?? this.currentSession,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isTyping: isTyping ?? this.isTyping,
      error: clearError ? null : (error ?? this.error),
      contextNeedId: contextNeedId ?? this.contextNeedId,
    );
  }
}

// Chat Rooms Notifier
class ChatRoomsNotifier extends StateNotifier<ChatRoomsState> {
  final AzureCosmosService _cosmosService;
  String? _accessToken;
  
  ChatRoomsNotifier(this._cosmosService, this._accessToken) : super(const ChatRoomsState()) {
    if (_accessToken != null) {
      _initializeService();
      loadChatRooms();
    }
  }
  
  void _initializeService() async {
    if (_accessToken != null) {
      await _cosmosService.initialize(_accessToken!);
    }
  }
  
  /// Load chat rooms
  Future<void> loadChatRooms() async {
    if (_accessToken == null) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      await _cosmosService.initialize(_accessToken!);
      final chatRooms = await _cosmosService.getChatRooms();
      
      state = state.copyWith(
        chatRooms: chatRooms,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to load chat rooms: $e',
        isLoading: false,
      );
    }
  }
  
  /// Create a new chat room
  Future<ChatRoom?> createChatRoom({
    required String title,
    required List<String> participantIds,
    ChatType type = ChatType.directMessage,
    String? needId,
  }) async {
    try {
      final chatRoom = await _cosmosService.createChatRoom(
        title,
        type,
      );
      
      final updatedRooms = [chatRoom, ...state.chatRooms];
      state = state.copyWith(chatRooms: updatedRooms);
      
      return chatRoom;
    } catch (e) {
      state = state.copyWith(error: 'Failed to create chat room: $e');
      return null;
    }
  }
  
  /// Join a chat room
  Future<bool> joinChatRoom(String roomId, String userId) async {
    try {
      await _cosmosService.joinChatRoom(roomId, userId);
      await loadChatRooms(); // Refresh to get updated room
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to join chat room: $e');
      return false;
    }
  }
  
  /// Leave a chat room
  Future<bool> leaveChatRoom(String roomId, String userId) async {
    try {
      await _cosmosService.leaveChatRoom(roomId, userId);
      
      // Remove from local state
      final updatedRooms = state.chatRooms
          .where((room) => room.id != roomId)
          .toList();
      
      state = state.copyWith(chatRooms: updatedRooms);
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to leave chat room: $e');
      return false;
    }
  }
  
  /// Mark messages as read
  Future<void> markAsRead(String roomId, String userId) async {
    try {
      await _cosmosService.markMessagesAsRead(roomId, userId);
      
      // Update local state
      final updatedRooms = state.chatRooms.map((room) {
        if (room.id == roomId) {
          return room.copyWith(
            unreadCount: 0,
          );
        }
        return room;
      }).toList();
      
      state = state.copyWith(chatRooms: updatedRooms);
    } catch (e) {
      state = state.copyWith(error: 'Failed to mark messages as read: $e');
    }
  }
  
  /// Update access token
  void updateAccessToken(String? accessToken) {
    _accessToken = accessToken;
    if (accessToken != null) {
      _initializeService();
    }
  }
}

// Chat Messages Notifier
class ChatMessagesNotifier extends StateNotifier<ChatMessagesState> {
  final AzureCosmosService _cosmosService;
  final String _roomId;
  String? _accessToken;
  
  ChatMessagesNotifier(this._cosmosService, this._roomId, this._accessToken) 
      : super(const ChatMessagesState()) {
    if (_accessToken != null) {
      _initializeService();
      loadMessages();
    }
  }
  
  void _initializeService() async {
    if (_accessToken != null) {
      await _cosmosService.initialize(_accessToken!);
    }
  }
  
  /// Load messages for the chat room
  Future<void> loadMessages({bool refresh = false}) async {
    if (refresh) {
      state = state.copyWith(messages: [], hasMore: true);
    }
    
    if (state.isLoading) return;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final messages = await _cosmosService.getChatMessages(
        roomId: _roomId,
        limit: 50,
        offset: refresh ? 0 : state.messages.length,
      );
      
      final updatedMessages = refresh 
          ? messages
          : [...messages, ...state.messages];
      
      // Sort by timestamp (newest last)
      updatedMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      
      state = state.copyWith(
        messages: updatedMessages,
        isLoading: false,
        hasMore: messages.length >= 50,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to load messages: $e',
        isLoading: false,
      );
    }
  }
  
  /// Send a message
  Future<bool> sendMessage({
    required String content,
    required String senderId,
    ChatMessageType type = ChatMessageType.text,
    String? attachmentUrl,
    String? replyToId,
  }) async {
    try {
      final message = await _cosmosService.sendChatMessage(
        roomId: _roomId,
        content: content,
        senderId: senderId,
        type: type,
        attachmentUrl: attachmentUrl,
        replyToId: replyToId,
      );
      
      final updatedMessages = [...state.messages, message];
      state = state.copyWith(messages: updatedMessages);
      
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to send message: $e');
      return false;
    }
  }
  
  /// Delete a message
  Future<bool> deleteMessage(String messageId) async {
    try {
      await _cosmosService.deleteChatMessage(_roomId, messageId);
      
      final updatedMessages = state.messages
          .where((msg) => msg.id != messageId)
          .toList();
      
      state = state.copyWith(messages: updatedMessages);
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to delete message: $e');
      return false;
    }
  }
  
  /// Load more messages (pagination)
  Future<void> loadMore() async {
    if (state.hasMore && !state.isLoading) {
      await loadMessages();
    }
  }
}

// AI Chat Notifier
class AIChatNotifier extends StateNotifier<AIChatState> {
  final AzureAiChatService _aiChatService;
  String? _accessToken;
  
  AIChatNotifier(this._aiChatService, this._accessToken) : super(const AIChatState()) {
    if (_accessToken != null) {
      _initializeService();
    }
  }
  
  void _initializeService() async {
    if (_accessToken != null) {
      await _aiChatService.initialize(_accessToken!);
    }
  }
  
  /// Start a new AI chat session
  Future<void> startSession({
    String? needId,
    String? initialContext,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final session = await _aiChatService.startChatSession(
        userId: 'current_user_id', // Would get from auth provider
        needId: needId,
        initialContext: initialContext,
      );
      
      state = state.copyWith(
        currentSession: session,
        messages: [],
        contextNeedId: needId,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to start AI chat: $e',
        isLoading: false,
      );
    }
  }
  
  /// Send a message to AI
  Future<void> sendMessage(String message) async {
    if (state.currentSession == null) return;
    
    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: message,
      senderId: 'current_user_id',
      senderName: 'You',
      timestamp: DateTime.now(),
      type: ChatMessageType.text,
    );
    
    final updatedMessages = [...state.messages, userMessage];
    state = state.copyWith(
      messages: updatedMessages,
      isTyping: true,
      clearError: true,
    );
    
    try {
      final response = await _aiChatService.sendMessage(
        sessionId: state.currentSession!.id,
        message: message,
      );
      
      // Add AI response
      final aiMessage = ChatMessage(
        id: response.id,
        content: response.content,
        senderId: 'ai_assistant',
        senderName: 'YOLO Assistant',
        timestamp: response.timestamp,
        type: ChatMessageType.text,
        metadata: {
          'confidence': response.confidence,
          'intent': response.intent,
          'suggestions': response.suggestions,
        },
      );
      
      final finalMessages = [...state.messages, aiMessage];
      state = state.copyWith(
        messages: finalMessages,
        isTyping: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to get AI response: $e',
        isTyping: false,
      );
    }
  }
  
  /// Get smart suggestions based on context
  Future<List<String>> getSmartSuggestions() async {
    if (state.currentSession == null) return [];
    
    try {
      return await _aiChatService.getSmartSuggestions(
        sessionId: state.currentSession!.id,
        context: state.contextNeedId,
      );
    } catch (e) {
      return [];
    }
  }
  
  /// Analyze sentiment of conversation
  Future<String?> analyzeSentiment() async {
    if (state.currentSession == null) return null;
    
    try {
      return await _aiChatService.analyzeSentiment(
        sessionId: state.currentSession!.id,
      );
    } catch (e) {
      return null;
    }
  }
  
  /// End the current session
  Future<void> endSession() async {
    if (state.currentSession != null) {
      try {
        await _aiChatService.endChatSession(state.currentSession!.id);
      } catch (e) {
        // Ignore errors when ending session
      }
    }
    
    state = const AIChatState();
  }
  
  /// Clear messages
  void clearMessages() {
    state = state.copyWith(messages: []);
  }
  
  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }
  
  /// Update access token
  void updateAccessToken(String? accessToken) {
    _accessToken = accessToken;
    if (accessToken != null) {
      _initializeService();
    }
  }
} 