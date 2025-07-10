import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../models/chat_model.dart';
import '../../models/user_model.dart';
import '../../models/enums.dart';
import '../../providers/chat_provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/azure/azure_ai_chat.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String? roomId;

  const ChatScreen({
    super.key,
    this.roomId,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;
  bool _isVoiceRecording = false;

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.roomId != null) {
        // Load specific chat room
        ref.read(chatStateProvider.notifier).loadChatRoom(widget.roomId!);
      } else {
        // Load chat rooms list
        ref.read(chatStateProvider.notifier).loadChatRooms();
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatStateProvider);
    final authState = ref.watch(authStateProvider);

    if (widget.roomId != null) {
      // Individual chat room view
      final room = chatState.chatRooms.firstWhere(
        (room) => room.id == widget.roomId,
        orElse: () => ChatRoom(
          id: widget.roomId!,
          name: 'Chat',
          participants: [],
          messages: [],
          lastMessage: null,
          lastMessageTime: DateTime.now(),
          isAIChat: widget.roomId == 'ai',
        ),
      );

      return _buildChatRoomView(room, authState.user);
    } else {
      // Chat rooms list view
      return _buildChatRoomsListView(chatState, authState.user);
    }
  }

  Widget _buildChatRoomsListView(ChatState chatState, User? user) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showChatSearch,
          ),
        ],
      ),
      body: Column(
        children: [
          // AI Chat shortcut
          Card(
            margin: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(Icons.smart_toy, color: Colors.white),
              ),
              title: const Text('YOLO AI Assistant'),
              subtitle: const Text('Get instant help and suggestions'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _startAIChat(),
            ),
          ),

          // Chat rooms list
          Expanded(
            child: chatState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : chatState.chatRooms.isEmpty
                    ? _buildEmptyChatsView()
                    : RefreshIndicator(
                        onRefresh: () => ref.read(chatStateProvider.notifier).loadChatRooms(),
                        child: ListView.separated(
                          itemCount: chatState.chatRooms.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final room = chatState.chatRooms[index];
                            return _buildChatRoomTile(room, user?.id);
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showNewChatDialog,
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildChatRoomView(ChatRoom room, User? user) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(room.name),
            if (room.isAIChat)
              Text(
                'AI Assistant',
                style: Theme.of(context).textTheme.bodySmall,
              )
            else if (room.participants.length == 2)
              Text(
                'Online now',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.green,
                ),
              ),
          ],
        ),
        actions: [
          if (!room.isAIChat) ...[
            IconButton(
              icon: const Icon(Icons.phone),
              onPressed: () => _startVoiceCall(room),
            ),
            IconButton(
              icon: const Icon(Icons.videocam),
              onPressed: () => _startVideoCall(room),
            ),
          ],
          PopupMenuButton<String>(
            onSelected: (value) => _handleChatMenuAction(value, room),
            itemBuilder: (context) => [
              if (!room.isAIChat)
                const PopupMenuItem(
                  value: 'view_profile',
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('View Profile'),
                  ),
                ),
              const PopupMenuItem(
                value: 'clear_history',
                child: ListTile(
                  leading: Icon(Icons.clear_all),
                  title: Text('Clear History'),
                ),
              ),
              if (!room.isAIChat)
                const PopupMenuItem(
                  value: 'block_user',
                  child: ListTile(
                    leading: Icon(Icons.block, color: Colors.red),
                    title: Text('Block User'),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: room.messages.isEmpty
                ? _buildEmptyMessagesView(room.isAIChat)
                : ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    itemCount: room.messages.length,
                    itemBuilder: (context, index) {
                      final message = room.messages[room.messages.length - 1 - index];
                      final isOwn = message.senderId == user?.id;
                      return _buildMessageBubble(message, isOwn, room.isAIChat);
                    },
                  ),
          ),

          // Typing indicator
          if (_isTyping)
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const CircularProgressIndicator(strokeWidth: 2),
                  const SizedBox(width: 8),
                  Text(
                    room.isAIChat ? 'AI is thinking...' : 'Typing...',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

          // Message input
          _buildMessageInput(room),
        ],
      ),
    );
  }

  Widget _buildEmptyChatsView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No conversations yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Start chatting with the AI or connect with community members',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _startAIChat,
            icon: const Icon(Icons.smart_toy),
            label: const Text('Chat with AI'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMessagesView(bool isAIChat) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isAIChat ? Icons.smart_toy : Icons.chat,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            isAIChat ? 'Chat with YOLO AI' : 'Start the conversation',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            isAIChat 
                ? 'Ask for help, get suggestions, or just chat!'
                : 'Send a message to get started',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (isAIChat) ...[
            const SizedBox(height: 24),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSuggestionChip('How can I help someone today?'),
                _buildSuggestionChip('Find resources near me'),
                _buildSuggestionChip('Create a new need'),
                _buildSuggestionChip('Explain how YOLO works'),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChatRoomTile(ChatRoom room, String? currentUserId) {
    final unreadCount = room.unreadCount;
    final hasUnread = unreadCount > 0;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: room.isAIChat 
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        child: room.isAIChat
            ? const Icon(Icons.smart_toy, color: Colors.white)
            : Text(room.name[0].toUpperCase()),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              room.name,
              style: TextStyle(
                fontWeight: hasUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          if (hasUnread)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$unreadCount',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      subtitle: room.lastMessage != null
          ? Text(
              room.lastMessage!.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: hasUnread ? FontWeight.w500 : FontWeight.normal,
              ),
            )
          : null,
      trailing: room.lastMessageTime != null
          ? Text(
              timeago.format(room.lastMessageTime!),
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,
      onTap: () => Navigator.of(context).pushNamed('/chat/room/${room.id}'),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isOwn, bool isAIChat) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isOwn ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isOwn && !isAIChat)
            CircleAvatar(
              radius: 16,
              child: Text(message.senderName[0].toUpperCase()),
            ),
          if (!isOwn && isAIChat)
            CircleAvatar(
              radius: 16,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.smart_toy, color: Colors.white, size: 16),
            ),
          if (!isOwn) const SizedBox(width: 8),
          
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isOwn 
                    ? Theme.of(context).colorScheme.primary
                    : isAIChat
                        ? Theme.of(context).colorScheme.secondaryContainer
                        : Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomLeft: isOwn ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: isOwn ? const Radius.circular(4) : const Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isOwn && !isAIChat)
                    Text(
                      message.senderName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  Text(
                    message.content,
                    style: TextStyle(
                      color: isOwn 
                          ? Theme.of(context).colorScheme.onPrimary
                          : isAIChat
                              ? Theme.of(context).colorScheme.onSecondaryContainer
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeago.format(message.timestamp),
                    style: TextStyle(
                      fontSize: 10,
                      color: (isOwn 
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurfaceVariant).withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          if (isOwn) const SizedBox(width: 8),
          if (isOwn)
            CircleAvatar(
              radius: 16,
              child: Text(message.senderName[0].toUpperCase()),
            ),
        ],
      ),
    );
  }

  Widget _buildMessageInput(ChatRoom room) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          // Voice recording button
          IconButton(
            icon: Icon(
              _isVoiceRecording ? Icons.stop : Icons.mic,
              color: _isVoiceRecording ? Colors.red : null,
            ),
            onPressed: _toggleVoiceRecording,
          ),
          
          // Text input
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: room.isAIChat 
                    ? 'Ask YOLO AI anything...'
                    : 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _sendMessage(room),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Send button
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _messageController.text.trim().isNotEmpty 
                ? () => _sendMessage(room)
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        _messageController.text = text;
        _sendMessage(ChatRoom(
          id: 'ai',
          name: 'YOLO AI',
          participants: [],
          messages: [],
          lastMessage: null,
          lastMessageTime: DateTime.now(),
          isAIChat: true,
        ));
      },
    );
  }

  void _startAIChat() {
    Navigator.of(context).pushNamed('/chat/room/ai');
  }

  void _showNewChatDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Start New Chat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.smart_toy),
              title: const Text('Chat with AI'),
              onTap: () {
                Navigator.of(context).pop();
                _startAIChat();
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Find Community Members'),
              onTap: () {
                Navigator.of(context).pop();
                _showUserSearch();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showChatSearch() {
    // TODO: Implement chat search
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Search functionality coming soon!')),
    );
  }

  void _showUserSearch() {
    // TODO: Implement user search
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('User search coming soon!')),
    );
  }

  Future<void> _sendMessage(ChatRoom room) async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    _messageController.clear();
    setState(() {
      _isTyping = true;
    });

    try {
      if (room.isAIChat) {
        await ref.read(chatStateProvider.notifier).sendAIMessage(content);
      } else {
        await ref.read(chatStateProvider.notifier).sendMessage(room.id, content);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error sending message: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isTyping = false;
        });
      }
    }

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _toggleVoiceRecording() {
    setState(() {
      _isVoiceRecording = !_isVoiceRecording;
    });
    
    // TODO: Implement voice recording with Azure Speech-to-Text
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isVoiceRecording 
            ? 'Voice recording started' 
            : 'Voice recording stopped'),
      ),
    );
  }

  void _startVoiceCall(ChatRoom room) {
    // TODO: Implement voice calling
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice calling coming soon!')),
    );
  }

  void _startVideoCall(ChatRoom room) {
    // TODO: Implement video calling
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video calling coming soon!')),
    );
  }

  void _handleChatMenuAction(String action, ChatRoom room) {
    switch (action) {
      case 'view_profile':
        // TODO: Show user profile
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile view coming soon!')),
        );
        break;
      case 'clear_history':
        _clearChatHistory(room);
        break;
      case 'block_user':
        _blockUser(room);
        break;
    }
  }

  void _clearChatHistory(ChatRoom room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat History'),
        content: const Text('This will delete all messages in this chat. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(chatStateProvider.notifier).clearChatHistory(room.id);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _blockUser(ChatRoom room) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text('This user will no longer be able to send you messages.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement user blocking
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User blocked')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Block'),
          ),
        ],
      ),
    );
  }
} 