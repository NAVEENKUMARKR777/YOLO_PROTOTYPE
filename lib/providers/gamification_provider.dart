import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:math';

import '../models/mission_model.dart';
import '../models/enums.dart';
import '../services/azure/azure_cosmos.dart';
import 'auth_provider.dart';
import 'app_provider.dart';

part 'gamification_provider.freezed.dart';

// Gamification state provider
final gamificationProvider = StateNotifierProvider<GamificationNotifier, GamificationState>((ref) {
  final cosmosService = ref.watch(cosmosServiceProvider);
  final authState = ref.watch(authStateProvider);
  return GamificationNotifier(cosmosService, authState.user?.id, authState.accessToken);
});

// Alias for backward compatibility
final gamificationStateProvider = gamificationProvider;

// User's missions provider
final userMissionsProvider = Provider<List<Mission>>((ref) {
  final gamificationState = ref.watch(gamificationProvider);
  return gamificationState.userMissions;
});

// Available missions provider
final availableMissionsProvider = Provider<List<Mission>>((ref) {
  final gamificationState = ref.watch(gamificationProvider);
  return gamificationState.availableMissions;
});

// User's badges provider
final userBadgesProvider = Provider<List<Badge>>((ref) {
  final gamificationState = ref.watch(gamificationProvider);
  return gamificationState.userBadges;
});

// User's achievements provider
final userAchievementsProvider = Provider<List<Achievement>>((ref) {
  final gamificationState = ref.watch(gamificationProvider);
  return gamificationState.userAchievements;
});

// Leaderboard provider
final leaderboardProvider = Provider<List<Leaderboard>>((ref) {
  final gamificationState = ref.watch(gamificationProvider);
  return gamificationState.leaderboards;
});

// User's total points provider
final userPointsProvider = Provider<int>((ref) {
  final gamificationState = ref.watch(gamificationProvider);
  return gamificationState.totalPoints;
});

// User's current level provider
final userLevelProvider = Provider<int>((ref) {
  final points = ref.watch(userPointsProvider);
  return _calculateLevel(points);
});

// Progress to next level provider
final levelProgressProvider = Provider<double>((ref) {
  final points = ref.watch(userPointsProvider);
  final currentLevel = ref.watch(userLevelProvider);
  return _calculateLevelProgress(points, currentLevel);
});

// Daily missions provider
final dailyMissionsProvider = Provider<List<Mission>>((ref) {
  final missions = ref.watch(userMissionsProvider);
  return missions.where((mission) => mission.type == MissionType.daily).toList();
});

// Weekly missions provider
final weeklyMissionsProvider = Provider<List<Mission>>((ref) {
  final missions = ref.watch(userMissionsProvider);
  return missions.where((mission) => mission.type == MissionType.weekly).toList();
});

// Special missions provider
final specialMissionsProvider = Provider<List<Mission>>((ref) {
  final missions = ref.watch(userMissionsProvider);
  return missions.where((mission) => mission.type == MissionType.special).toList();
});

// Recently earned badges provider
final recentBadgesProvider = Provider<List<Badge>>((ref) {
  final badges = ref.watch(userBadgesProvider);
  final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));
  
  return badges
      .where((badge) => badge.earnedAt?.isAfter(oneWeekAgo) == true)
      .toList()
    ..sort((a, b) => b.earnedAt!.compareTo(a.earnedAt!));
});

// Helper functions
int _calculateLevel(int points) {
  // Level calculation: Level = floor(sqrt(points / 100))
  return (points / 100).sqrt().floor() + 1;
}

double _calculateLevelProgress(int points, int currentLevel) {
  final currentLevelPoints = (currentLevel - 1) * (currentLevel - 1) * 100;
  final nextLevelPoints = currentLevel * currentLevel * 100;
  final progressPoints = points - currentLevelPoints;
  final totalPoints = nextLevelPoints - currentLevelPoints;
  
  return progressPoints / totalPoints;
}

// Gamification State
@freezed
class GamificationState with _$GamificationState {
  const factory GamificationState({
    @Default(false) bool isLoading,
    @Default([]) List<Mission> missions,
    @Default([]) List<Mission> userMissions,
    @Default([]) List<Mission> availableMissions,
    @Default([]) List<Badge> badges,
    @Default([]) List<Badge> userBadges,
    @Default([]) List<Achievement> achievements,
    @Default([]) List<Achievement> userAchievements,
    @Default([]) List<Leaderboard> leaderboards,
    @Default(0) int currentLevel,
    @Default(0) int currentLevelPoints,
    @Default(0) int nextLevelPoints,
    @Default(0) int pointsToNextLevel,
    @Default(0.0) double levelProgress,
    @Default(0) int totalPoints,
    @Default(0) int currentStreak,
    @Default(0) int completedMissions,
    @Default([]) List<Mission> dailyMissions,
    @Default([]) List<Mission> weeklyMissions,
    @Default([]) List<Mission> specialMissions,
    String? error,
  }) = _GamificationState;
}

// Gamification Notifier
class GamificationNotifier extends StateNotifier<GamificationState> {
  final AzureCosmosService _cosmosService;
  final String? _userId;
  String? _accessToken;
  
  GamificationNotifier(this._cosmosService, this._userId, this._accessToken) 
      : super(const GamificationState()) {
    if (_accessToken != null && _userId != null) {
      _initializeService();
      loadGamificationData();
    }
  }
  
  void _initializeService() async {
    if (_accessToken != null) {
      await _cosmosService.initialize(_accessToken!);
    }
  }
  
  /// Load all gamification data
  Future<void> loadGamificationData() async {
    if (_userId == null) return;
    
    state = state.copyWith(isLoading: true);
    
    try {
      // Load data in parallel
      final futures = [
        _cosmosService.getUserMissions(_userId!),
        _cosmosService.getAvailableMissions(),
        _cosmosService.getUserBadges(_userId!),
        _cosmosService.getUserAchievements(_userId!),
        _cosmosService.getLeaderboards(),
      ];
      
      final results = await Future.wait(futures);
      
      final userMissions = results[0] as List<Mission>;
      final availableMissions = results[1] as List<Mission>;
      final userBadges = results[2] as List<Badge>;
      final userAchievements = results[3] as List<Achievement>;
      final leaderboards = results[4] as List<Leaderboard>;
      
      // Calculate total points from badges and achievements
      final badgePoints = userBadges.fold<int>(0, (sum, badge) => sum + badge.points);
      final achievementPoints = userAchievements.fold<int>(0, (sum, achievement) => sum + achievement.points);
      final totalPoints = badgePoints + achievementPoints;
      
      state = state.copyWith(
        userMissions: userMissions,
        availableMissions: availableMissions,
        userBadges: userBadges,
        userAchievements: userAchievements,
        leaderboards: leaderboards,
        totalPoints: totalPoints,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to load gamification data: $e',
        isLoading: false,
      );
    }
  }
  
  /// Start a mission
  Future<bool> startMission(String missionId) async {
    if (_userId == null) return false;
    
    try {
      final mission = await _cosmosService.startMission(_userId!, missionId);
      
      // Update user missions
      final updatedUserMissions = [...state.userMissions, mission];
      
      // Remove from available missions
      final updatedAvailableMissions = state.availableMissions
          .where((m) => m.id != missionId)
          .toList();
      
      state = state.copyWith(
        userMissions: updatedUserMissions,
        availableMissions: updatedAvailableMissions,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to start mission: $e');
      return false;
    }
  }
  
  /// Complete a mission
  Future<bool> completeMission(String missionId) async {
    if (_userId == null) return false;
    
    try {
      final result = await _cosmosService.completeMission(_userId!, missionId);
      
      // Update mission status
      final updatedUserMissions = state.userMissions.map((mission) {
        if (mission.id == missionId) {
          return mission.copyWith(
            status: MissionStatus.completed,
            completedAt: DateTime.now(),
          );
        }
        return mission;
      }).toList();
      
      // Add earned badges if any
      final newBadges = result['earnedBadges'] as List<Badge>? ?? [];
      final updatedBadges = [...state.userBadges, ...newBadges];
      
      // Add earned achievements if any
      final newAchievements = result['earnedAchievements'] as List<Achievement>? ?? [];
      final updatedAchievements = [...state.userAchievements, ...newAchievements];
      
      // Update total points
      final additionalPoints = result['pointsEarned'] as int? ?? 0;
      final updatedTotalPoints = state.totalPoints + additionalPoints;
      
      state = state.copyWith(
        userMissions: updatedUserMissions,
        userBadges: updatedBadges,
        userAchievements: updatedAchievements,
        totalPoints: updatedTotalPoints,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to complete mission: $e');
      return false;
    }
  }
  
  /// Update mission progress
  Future<void> updateMissionProgress(String missionId, int progress) async {
    if (_userId == null) return;
    
    try {
      await _cosmosService.updateMissionProgress(_userId!, missionId, progress);
      
      // Update local state
      final updatedUserMissions = state.userMissions.map((mission) {
        if (mission.id == missionId) {
          return mission.copyWith(progress: progress);
        }
        return mission;
      }).toList();
      
      state = state.copyWith(userMissions: updatedUserMissions);
    } catch (e) {
      // Silently fail for progress updates
    }
  }
  
  /// Claim mission reward
  Future<bool> claimMissionReward(String missionId) async {
    if (_userId == null) return false;
    
    try {
      final result = await _cosmosService.claimMissionReward(_userId!, missionId);
      
      // Update mission status
      final updatedUserMissions = state.userMissions.map((mission) {
        if (mission.id == missionId) {
          return mission.copyWith(
            status: MissionStatus.claimed,
            claimedAt: DateTime.now(),
          );
        }
        return mission;
      }).toList();
      
      // Add earned points/badges
      final pointsEarned = result['pointsEarned'] as int? ?? 0;
      final badgesEarned = result['badgesEarned'] as List<Badge>? ?? [];
      
      final updatedBadges = [...state.userBadges, ...badgesEarned];
      final updatedTotalPoints = state.totalPoints + pointsEarned;
      
      state = state.copyWith(
        userMissions: updatedUserMissions,
        userBadges: updatedBadges,
        totalPoints: updatedTotalPoints,
      );
      
      return true;
    } catch (e) {
      state = state.copyWith(error: 'Failed to claim reward: $e');
      return false;
    }
  }
  
  /// Track user action for mission progress
  Future<void> trackAction(MissionAction action, {Map<String, dynamic>? metadata}) async {
    if (_userId == null) return;
    
    try {
      final result = await _cosmosService.trackUserAction(
        _userId!,
        action,
        metadata: metadata,
      );
      
      // Update any affected missions
      if (result['updatedMissions'] != null) {
        final updatedMissionIds = result['updatedMissions'] as List<String>;
        
        for (final missionId in updatedMissionIds) {
          final mission = state.userMissions.firstWhere(
            (m) => m.id == missionId,
            orElse: () => throw Exception('Mission not found'),
          );
          
          // Increment progress based on action
          final newProgress = mission.progress + 1;
          await updateMissionProgress(missionId, newProgress);
          
          // Check if mission is completed
          if (newProgress >= mission.target && mission.status == MissionStatus.active) {
            await completeMission(missionId);
          }
        }
      }
    } catch (e) {
      // Silently fail for action tracking
    }
  }
  
  /// Get leaderboard for specific type
  Future<List<Leaderboard>> getLeaderboard(LeaderboardType type) async {
    try {
      final leaderboard = await _cosmosService.getLeaderboard(type);
      return leaderboard;
    } catch (e) {
      return [];
    }
  }
  
  /// Check for new daily missions
  Future<void> checkDailyMissions() async {
    if (_userId == null) return;
    
    try {
      final dailyMissions = await _cosmosService.getDailyMissions(_userId!);
      
      // Add new daily missions to available missions
      final existingMissionIds = state.availableMissions.map((m) => m.id).toSet();
      final newDailyMissions = dailyMissions
          .where((mission) => !existingMissionIds.contains(mission.id))
          .toList();
      
      if (newDailyMissions.isNotEmpty) {
        final updatedAvailableMissions = [...state.availableMissions, ...newDailyMissions];
        state = state.copyWith(availableMissions: updatedAvailableMissions);
      }
    } catch (e) {
      // Silently fail for daily mission checks
    }
  }
  
  /// Refresh leaderboards
  Future<void> refreshLeaderboards() async {
    try {
      final leaderboards = await _cosmosService.getLeaderboards();
      state = state.copyWith(leaderboards: leaderboards);
    } catch (e) {
      state = state.copyWith(error: 'Failed to refresh leaderboards: $e');
    }
  }
  
  /// Get user's rank in leaderboard
  int getUserRank(LeaderboardType type) {
    if (_userId == null) return -1;
    
    final leaderboard = state.leaderboards
        .where((lb) => lb.type == type)
        .expand((lb) => lb.entries)
        .toList();
    
    leaderboard.sort((a, b) => b.score.compareTo(a.score));
    
    for (int i = 0; i < leaderboard.length; i++) {
      if (leaderboard[i].userId == _userId) {
        return i + 1;
      }
    }
    
    return -1;
  }
  
  /// Get available mission by category
  List<Mission> getMissionsByCategory(MissionCategory category) {
    return state.availableMissions
        .where((mission) => mission.category == category)
        .toList();
  }
  
  /// Get completed missions count
  int getCompletedMissionsCount() {
    return state.userMissions
        .where((mission) => mission.status == MissionStatus.completed || mission.status == MissionStatus.claimed)
        .length;
  }
  
  /// Get badges by category
  List<Badge> getBadgesByCategory(BadgeCategory category) {
    return state.userBadges
        .where((badge) => badge.category == category)
        .toList();
  }
  
  /// Clear error
  void clearError() {
    state = state.copyWith(clearError: true);
  }
  
  /// Refresh all data
  Future<void> refresh() async {
    await loadGamificationData();
  }
  
  /// Update access token and user ID
  void updateAuth(String? userId, String? accessToken) {
    if (userId != _userId || accessToken != _accessToken) {
      _cosmosService.initialize(accessToken ?? '');
      
      if (userId != null && accessToken != null) {
        loadGamificationData();
      } else {
        state = const GamificationState();
      }
    }
  }
} 