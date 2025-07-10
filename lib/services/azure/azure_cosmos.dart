import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import '../../models/user_model.dart';
import '../../models/need_model.dart';
import '../../models/chat_model.dart';
import '../../models/mission_model.dart';
import '../../models/notification_model.dart';
import '../../models/enums.dart';

class AzureCosmosService {
  static const String _endpoint = 'https://YOUR_COSMOS_ACCOUNT.documents.azure.com:443/';
  static const String _masterKey = 'YOUR_COSMOS_MASTER_KEY';
  static const String _databaseId = 'YoloNeedApp';
  
  // Container names
  static const String _usersContainer = 'Users';
  static const String _needsContainer = 'Needs';
  static const String _chatRoomsContainer = 'ChatRooms';
  static const String _messagesContainer = 'Messages';
  static const String _missionsContainer = 'Missions';
  static const String _notificationsContainer = 'Notifications';
  static const String _badgesContainer = 'Badges';
  static const String _leaderboardsContainer = 'Leaderboards';
  
  final Dio _dio;
  
  AzureCosmosService({Dio? dio}) : _dio = dio ?? Dio();
  
  /// Initialize Cosmos DB service
  Future<void> initialize([String? accessToken]) async {
    _dio.options.baseUrl = _endpoint;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.interceptors.add(_AuthInterceptor(_masterKey));
  }
  
  // ========== USER OPERATIONS ==========
  
  /// Create a new user
  Future<User> createUser(User user) async {
    try {
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_usersContainer/docs',
        data: user.toJson(),
      );
      
      return User.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to create user: $e');
    }
  }
  
  /// Get user by ID
  Future<User?> getUserById(String userId) async {
    try {
      final response = await _dio.get(
        'dbs/$_databaseId/colls/$_usersContainer/docs/$userId',
      );
      
      return User.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw CosmosException('Failed to get user: $e');
    }
  }
  
  /// Update user
  Future<User> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      final currentUser = await getUserById(userId);
      if (currentUser == null) {
        throw CosmosException('User not found');
      }
      
      final updatedData = {...currentUser.toJson(), ...updates};
      updatedData['updatedAt'] = DateTime.now().toIso8601String();
      
      final response = await _dio.put(
        'dbs/$_databaseId/colls/$_usersContainer/docs/$userId',
        data: updatedData,
      );
      
      return User.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to update user: $e');
    }
  }
  
  /// Query users by role
  Future<List<User>> getUsersByRole(UserRole role) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.role = @role',
        'parameters': [
          {'name': '@role', 'value': role.name}
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_usersContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => User.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to query users: $e');
    }
  }
  
  // ========== NEED OPERATIONS ==========
  
  /// Create a new need
  Future<Need> createNeed(Need need) async {
    try {
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_needsContainer/docs',
        data: need.toJson(),
      );
      
      return Need.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to create need: $e');
    }
  }
  
  /// Get need by ID
  Future<Need?> getNeedById(String needId) async {
    try {
      final response = await _dio.get(
        'dbs/$_databaseId/colls/$_needsContainer/docs/$needId',
      );
      
      return Need.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw CosmosException('Failed to get need: $e');
    }
  }
  
  /// Query needs with filters
  Future<List<Need>> queryNeeds(NeedFilter filter) async {
    try {
      String query = 'SELECT * FROM c WHERE 1=1';
      final parameters = <Map<String, dynamic>>[];
      
      if (filter.status != null) {
        query += ' AND c.status = @status';
        parameters.add({'name': '@status', 'value': filter.status!.name});
      }
      
      if (filter.category != null) {
        query += ' AND c.category = @category';
        parameters.add({'name': '@category', 'value': filter.category!.name});
      }
      
      if (filter.userId != null) {
        query += ' AND c.userId = @userId';
        parameters.add({'name': '@userId', 'value': filter.userId});
      }
      
      if (filter.priority != null) {
        query += ' AND c.priority = @priority';
        parameters.add({'name': '@priority', 'value': filter.priority!.name});
      }
      
      if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
        query += ' AND (CONTAINS(c.title, @search) OR CONTAINS(c.description, @search))';
        parameters.add({'name': '@search', 'value': filter.searchQuery});
      }
      
      query += ' ORDER BY c.createdAt DESC';
      
      if (filter.limit != null) {
        query += ' OFFSET ${filter.offset ?? 0} LIMIT ${filter.limit}';
      }
      
      final queryData = {
        'query': query,
        'parameters': parameters,
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_needsContainer/docs',
        data: queryData,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Need.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to query needs: $e');
    }
  }
  
  /// Update need
  Future<Need> updateNeed(String needId, Map<String, dynamic> updates) async {
    try {
      final currentNeed = await getNeedById(needId);
      if (currentNeed == null) {
        throw CosmosException('Need not found');
      }
      
      final updatedData = {...currentNeed.toJson(), ...updates};
      updatedData['updatedAt'] = DateTime.now().toIso8601String();
      
      final response = await _dio.put(
        'dbs/$_databaseId/colls/$_needsContainer/docs/$needId',
        data: updatedData,
      );
      
      return Need.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to update need: $e');
    }
  }

  /// Get needs with optional filter
  Future<List<Need>> getNeeds({
    NeedFilter? filter,
    int? limit,
    int? offset,
  }) async {
    return await queryNeeds(filter ?? const NeedFilter());
  }

  /// Delete need
  Future<void> deleteNeed(String needId) async {
    try {
      await _dio.delete(
        'dbs/$_databaseId/colls/$_needsContainer/docs/$needId',
      );
    } catch (e) {
      throw CosmosException('Failed to delete need: $e');
    }
  }

  /// Add comment to need
  Future<void> addNeedComment(String needId, String comment) async {
    try {
      final needComment = NeedComment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        needId: needId,
        userId: 'current_user_id', // TODO: Get from auth
        comment: comment,
        createdAt: DateTime.now(),
      );
      
      await _dio.post(
        'dbs/$_databaseId/colls/$_needsContainer/docs',
        data: needComment.toJson(),
      );
    } catch (e) {
      throw CosmosException('Failed to add comment: $e');
    }
  }

  /// Search needs
  Future<List<Need>> searchNeeds(String query) async {
    final filter = NeedFilter(searchQuery: query);
    return await queryNeeds(filter);
  }
  
  // ========== CHAT OPERATIONS ==========

  /// Get chat rooms
  Future<List<ChatRoom>> getChatRooms() async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.type = "chat_room"',
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_chatRoomsContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => ChatRoom.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get chat rooms: $e');
    }
  }

  /// Create chat room
  Future<ChatRoom> createChatRoom(String name, ChatType type) async {
    try {
      final chatRoom = ChatRoom(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        type: type,
        participants: [],
        lastMessageAt: DateTime.now(),
        createdAt: DateTime.now(),
      );
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_chatRoomsContainer/docs',
        data: chatRoom.toJson(),
      );
      
      return ChatRoom.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to create chat room: $e');
    }
  }

  /// Join chat room
  Future<void> joinChatRoom(String roomId, String userId) async {
    try {
      final participant = ChatParticipant(
        userId: userId,
        joinedAt: DateTime.now(),
        lastSeenAt: DateTime.now(),
      );
      
      await _dio.post(
        'dbs/$_databaseId/colls/$_chatRoomsContainer/docs',
        data: participant.toJson(),
      );
    } catch (e) {
      throw CosmosException('Failed to join chat room: $e');
    }
  }

  /// Leave chat room
  Future<void> leaveChatRoom(String roomId, String userId) async {
    try {
      await _dio.delete(
        'dbs/$_databaseId/colls/$_chatRoomsContainer/docs/$roomId/participants/$userId',
      );
    } catch (e) {
      throw CosmosException('Failed to leave chat room: $e');
    }
  }

  /// Mark messages as read
  Future<void> markMessagesAsRead(String roomId, String userId) async {
    try {
      final updates = {
        'lastSeenAt': DateTime.now().toIso8601String(),
      };
      
      await _dio.put(
        'dbs/$_databaseId/colls/$_chatRoomsContainer/docs/$roomId/participants/$userId',
        data: updates,
      );
    } catch (e) {
      throw CosmosException('Failed to mark messages as read: $e');
    }
  }

  /// Get chat messages
  Future<List<ChatMessage>> getChatMessages(String roomId, {int? limit, int? offset}) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.roomId = @roomId ORDER BY c.createdAt DESC',
        'parameters': [
          {'name': '@roomId', 'value': roomId}
        ]
      };
      
      if (limit != null) {
        query['query'] = '${query['query']} OFFSET ${offset ?? 0} LIMIT $limit';
      }
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_messagesContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => ChatMessage.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get chat messages: $e');
    }
  }

  /// Send chat message
  Future<ChatMessage> sendChatMessage(String roomId, String userId, String content, ChatMessageType type) async {
    try {
      final message = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        roomId: roomId,
        senderId: userId,
        content: content,
        type: type,
        createdAt: DateTime.now(),
      );
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_messagesContainer/docs',
        data: message.toJson(),
      );
      
      return ChatMessage.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to send chat message: $e');
    }
  }

  /// Delete chat message
  Future<void> deleteChatMessage(String roomId, String messageId) async {
    try {
      await _dio.delete(
        'dbs/$_databaseId/colls/$_messagesContainer/docs/$messageId',
      );
    } catch (e) {
      throw CosmosException('Failed to delete chat message: $e');
    }
  }
  
  // ========== MISSION OPERATIONS ==========
  
  /// Create mission
  Future<Mission> createMission(Mission mission) async {
    try {
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_missionsContainer/docs',
        data: mission.toJson(),
      );
      
      return Mission.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to create mission: $e');
    }
  }
  
  /// Get available missions for user
  Future<List<Mission>> getAvailableMissions(String userId, UserRole userRole) async {
    try {
      final query = {
        'query': '''
          SELECT * FROM c 
          WHERE c.status = @status 
          AND c.isVisible = true 
          AND (NOT IS_DEFINED(c.eligibleRoles) OR ARRAY_CONTAINS(c.eligibleRoles, @userRole))
          ORDER BY c.createdAt DESC
        ''',
        'parameters': [
          {'name': '@status', 'value': MissionStatus.available.name},
          {'name': '@userRole', 'value': userRole.name},
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_missionsContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Mission.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get missions: $e');
    }
  }
  
  // ========== NOTIFICATION OPERATIONS ==========
  
  /// Create notification
  Future<Notification> createNotification(Notification notification) async {
    try {
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_notificationsContainer/docs',
        data: notification.toJson(),
      );
      
      return Notification.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to create notification: $e');
    }
  }
  
  /// Get notifications for user
  Future<List<Notification>> getNotificationsForUser(
    String userId, {
    int limit = 50,
    bool unreadOnly = false,
  }) async {
    try {
      String query = 'SELECT * FROM c WHERE c.userId = @userId';
      final parameters = [{'name': '@userId', 'value': userId}];
      
      if (unreadOnly) {
        query += ' AND c.isRead = false';
      }
      
      query += ' ORDER BY c.createdAt DESC OFFSET 0 LIMIT $limit';
      
      final queryData = {
        'query': query,
        'parameters': parameters,
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_notificationsContainer/docs',
        data: queryData,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Notification.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get notifications: $e');
    }
  }
  
  // ========== GENERIC OPERATIONS ==========
  
  /// Delete document
  Future<void> deleteDocument(String containerId, String documentId) async {
    try {
      await _dio.delete(
        'dbs/$_databaseId/colls/$containerId/docs/$documentId',
      );
    } catch (e) {
      throw CosmosException('Failed to delete document: $e');
    }
  }
  
  /// Execute stored procedure
  Future<dynamic> executeStoredProcedure(
    String containerId,
    String procedureName,
    List<dynamic> parameters,
  ) async {
    try {
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$containerId/sprocs/$procedureName',
        data: parameters,
      );
      
      return response.data;
    } catch (e) {
      throw CosmosException('Failed to execute stored procedure: $e');
    }
  }
  
  /// Batch operations
  Future<List<Map<String, dynamic>>> executeBatch(
    String containerId,
    List<Map<String, dynamic>> operations,
  ) async {
    try {
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$containerId/docs',
        data: {'operations': operations},
        options: Options(headers: {'x-ms-documentdb-batch': 'True'}),
      );
      
      return List<Map<String, dynamic>>.from(response.data['results']);
    } catch (e) {
      throw CosmosException('Failed to execute batch: $e');
    }
  }

  // ========== GAMIFICATION OPERATIONS ==========

  /// Get user missions
  Future<List<Mission>> getUserMissions(String userId) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.userId = @userId',
        'parameters': [
          {'name': '@userId', 'value': userId}
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_missionsContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Mission.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get user missions: $e');
    }
  }

  /// Get available missions
  Future<List<Mission>> getAvailableMissions([String? userId]) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.status = @status',
        'parameters': [
          {'name': '@status', 'value': MissionStatus.available.name}
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_missionsContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Mission.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get available missions: $e');
    }
  }

  /// Get user badges
  Future<List<Badge>> getUserBadges(String userId) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.userId = @userId',
        'parameters': [
          {'name': '@userId', 'value': userId}
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_badgesContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Badge.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get user badges: $e');
    }
  }

  /// Get user achievements
  Future<List<Achievement>> getUserAchievements(String userId) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.userId = @userId',
        'parameters': [
          {'name': '@userId', 'value': userId}
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_badgesContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Achievement.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get user achievements: $e');
    }
  }

  /// Get leaderboards
  Future<List<Leaderboard>> getLeaderboards() async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.type = "leaderboard"',
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_leaderboardsContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Leaderboard.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get leaderboards: $e');
    }
  }

  /// Start mission
  Future<Mission> startMission(String userId, String missionId) async {
    try {
      final mission = Mission(
        id: missionId,
        title: 'Mission',
        description: 'Mission description',
        type: MissionType.daily,
        action: MissionAction.createNeed,
        target: 1,
        reward: 100,
        status: MissionStatus.active,
        userId: userId,
        progress: 0,
        startedAt: DateTime.now(),
      );
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_missionsContainer/docs',
        data: mission.toJson(),
      );
      
      return Mission.fromJson(response.data);
    } catch (e) {
      throw CosmosException('Failed to start mission: $e');
    }
  }

  /// Complete mission
  Future<Map<String, dynamic>> completeMission(String userId, String missionId) async {
    try {
      // Update mission status
      await updateMissionProgress(userId, missionId, 100);
      
      return {
        'success': true,
        'points': 100,
        'badges': [],
        'achievements': [],
      };
    } catch (e) {
      throw CosmosException('Failed to complete mission: $e');
    }
  }

  /// Claim mission reward
  Future<Map<String, dynamic>> claimMissionReward(String userId, String missionId) async {
    try {
      return {
        'success': true,
        'points': 100,
        'badges': [],
        'achievements': [],
      };
    } catch (e) {
      throw CosmosException('Failed to claim mission reward: $e');
    }
  }

  /// Update mission progress
  Future<void> updateMissionProgress(String userId, String missionId, int progress) async {
    try {
      final updates = {
        'progress': progress,
        'updatedAt': DateTime.now().toIso8601String(),
      };
      
      await _dio.put(
        'dbs/$_databaseId/colls/$_missionsContainer/docs/$missionId',
        data: updates,
      );
    } catch (e) {
      throw CosmosException('Failed to update mission progress: $e');
    }
  }

  /// Track user action
  Future<Map<String, dynamic>> trackUserAction(String userId, String action, Map<String, dynamic> data) async {
    try {
      return {
        'success': true,
        'points': 10,
        'badges': [],
        'achievements': [],
      };
    } catch (e) {
      throw CosmosException('Failed to track user action: $e');
    }
  }

  /// Get leaderboard
  Future<List<LeaderboardEntry>> getLeaderboard(String type) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.type = @type ORDER BY c.points DESC',
        'parameters': [
          {'name': '@type', 'value': type}
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_leaderboardsContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => LeaderboardEntry.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get leaderboard: $e');
    }
  }

  /// Get daily missions
  Future<List<Mission>> getDailyMissions(String userId) async {
    try {
      final query = {
        'query': 'SELECT * FROM c WHERE c.type = @type AND c.status = @status',
        'parameters': [
          {'name': '@type', 'value': MissionType.daily.name},
          {'name': '@status', 'value': MissionStatus.available.name}
        ]
      };
      
      final response = await _dio.post(
        'dbs/$_databaseId/colls/$_missionsContainer/docs',
        data: query,
        options: Options(headers: {'x-ms-documentdb-isquery': 'True'}),
      );
      
      final documents = response.data['Documents'] as List;
      return documents.map((doc) => Mission.fromJson(doc)).toList();
    } catch (e) {
      throw CosmosException('Failed to get daily missions: $e');
    }
  }
}

/// Cosmos DB authentication interceptor
class _AuthInterceptor extends Interceptor {
  final String masterKey;
  
  _AuthInterceptor(this.masterKey);
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final now = DateTime.now().toUtc();
    final date = _formatDate(now);
    
    final verb = options.method.toUpperCase();
    final resourceType = _getResourceType(options.path);
    final resourceId = _getResourceId(options.path);
    
    final authString = '$verb\n$resourceType\n$resourceId\n$date\n\n';
    final signature = _generateSignature(authString);
    
    options.headers['x-ms-date'] = date;
    options.headers['x-ms-version'] = '2020-07-15';
    options.headers['authorization'] = 'type=master&ver=1.0&sig=$signature';
    
    handler.next(options);
  }
  
  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    final dayName = days[date.weekday - 1];
    final day = date.day.toString().padLeft(2, '0');
    final month = months[date.month - 1];
    final year = date.year;
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    final second = date.second.toString().padLeft(2, '0');
    
    return '$dayName, $day $month $year $hour:$minute:$second GMT';
  }
  
  String _getResourceType(String path) {
    if (path.contains('/docs')) return 'docs';
    if (path.contains('/colls')) return 'colls';
    if (path.contains('/dbs')) return 'dbs';
    if (path.contains('/sprocs')) return 'sprocs';
    return '';
  }
  
  String _getResourceId(String path) {
    final segments = path.split('/');
    final filteredSegments = segments.where((s) => s.isNotEmpty).toList();
    
    if (filteredSegments.length >= 4) {
      return filteredSegments.take(4).join('/');
    }
    return '';
  }
  
  String _generateSignature(String stringToSign) {
    final key = base64.decode(masterKey);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(utf8.encode(stringToSign.toLowerCase()));
    return base64.encode(digest.bytes);
  }
}

/// Custom exception for Cosmos DB operations
class CosmosException implements Exception {
  final String message;
  
  const CosmosException(this.message);
  
  @override
  String toString() => 'CosmosException: $message';
} 