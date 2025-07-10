import 'package:freezed_annotation/freezed_annotation.dart';

part 'mission_model.freezed.dart';
part 'mission_model.g.dart';

enum MissionType {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('achievement')
  achievement,
  @JsonValue('special')
  special,
  @JsonValue('community')
  community,
}

enum MissionStatus {
  @JsonValue('available')
  available,
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
  @JsonValue('claimed')
  claimed,
}

enum MissionDifficulty {
  @JsonValue('easy')
  easy,
  @JsonValue('medium')
  medium,
  @JsonValue('hard')
  hard,
  @JsonValue('expert')
  expert,
}

enum BadgeType {
  @JsonValue('bronze')
  bronze,
  @JsonValue('silver')
  silver,
  @JsonValue('gold')
  gold,
  @JsonValue('platinum')
  platinum,
  @JsonValue('special')
  special,
}

@freezed
class Mission with _$Mission {
  const factory Mission({
    required String id,
    required String title,
    required String description,
    required MissionType type,
    required MissionStatus status,
    required MissionAction action,
    required int target,
    required int progress,
    required int reward,
    String? userId,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? claimedAt,
    DateTime? deadline,
    String? category,
    List<String>? prerequisites,
    Map<String, dynamic>? rewards,
  }) = _Mission;

  factory Mission.fromJson(Map<String, dynamic> json) => _$MissionFromJson(json);
}

@freezed
class MissionObjective with _$MissionObjective {
  const factory MissionObjective({
    required String id,
    required String title,
    required String description,
    required String type,
    required int targetValue,
    @Default(0) int currentValue,
    @Default(false) bool isCompleted,
    Map<String, dynamic>? parameters,
    DateTime? completedAt,
  }) = _MissionObjective;

  factory MissionObjective.fromJson(Map<String, dynamic> json) => _$MissionObjectiveFromJson(json);
}

@freezed
class UserMission with _$UserMission {
  const factory UserMission({
    required String id,
    required String userId,
    required String missionId,
    required MissionStatus status,
    
    // Progress
    @Default(0) double progressPercentage,
    Map<String, dynamic>? progressData,
    List<String>? completedObjectives,
    
    // Timing
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? expiresAt,
    
    // Rewards
    @Default(false) bool rewardsClaimed,
    DateTime? rewardsClaimedAt,
    
    // Metadata
    Map<String, dynamic>? metadata,
  }) = _UserMission;

  factory UserMission.fromJson(Map<String, dynamic> json) => _$UserMissionFromJson(json);
}

@freezed
class Badge with _$Badge {
  const factory Badge({
    required String id,
    required String title,
    required String description,
    required BadgeType type,
    required BadgeTier tier,
    required BadgeCategory category,
    required int points,
    String? iconUrl,
    String? color,
    DateTime? earnedAt,
    bool? isUnlocked,
  }) = _Badge;

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
}

@freezed
class UserBadge with _$UserBadge {
  const factory UserBadge({
    required String id,
    required String userId,
    required String badgeId,
    required DateTime earnedAt,
    String? earnedFor,
    Map<String, dynamic>? context,
    @Default(false) bool isFavorite,
    @Default(true) bool isVisible,
  }) = _UserBadge;

  factory UserBadge.fromJson(Map<String, dynamic> json) => _$UserBadgeFromJson(json);
}

@freezed
class Leaderboard with _$Leaderboard {
  const factory Leaderboard({
    required String id,
    required String name,
    required String type,
    required String period,
    required List<LeaderboardEntry> entries,
    
    // Configuration
    @Default(100) int maxEntries,
    List<String>? eligibleRoles,
    Map<String, dynamic>? criteria,
    
    // Timing
    DateTime? startDate,
    DateTime? endDate,
    DateTime? lastUpdated,
    
    // Metadata
    String? description,
    String? iconUrl,
    Map<String, dynamic>? metadata,
  }) = _Leaderboard;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => _$LeaderboardFromJson(json);
}

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String userId,
    required int rank,
    required double score,
    String? displayName,
    String? avatarUrl,
    Map<String, dynamic>? stats,
    DateTime? lastActivityAt,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) => _$LeaderboardEntryFromJson(json);
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required int points,
    String? iconUrl,
    String? color,
    DateTime? earnedAt,
    bool? isUnlocked,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);
} 