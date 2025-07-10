import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

enum UserStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('suspended')
  suspended,
  @JsonValue('pending')
  pending,
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String displayName,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImageUrl,
    required UserRole role,
    required UserStatus status,
    String? azureObjectId,
    String? accessToken,
    String? refreshToken,
    DateTime? tokenExpiry,
    Map<String, dynamic>? claims,
    
    // Profile Information
    String? bio,
    String? location,
    List<String>? skills,
    List<String>? interests,
    String? company,
    String? jobTitle,
    
    // Gamification
    @Default(0) int points,
    @Default(0) int level,
    @Default([]) List<String> badges,
    @Default(0) int needsCreated,
    @Default(0) int needsHelped,
    @Default(0) int missionsCompleted,
    
    // Settings
    @Default(true) bool isDarkMode,
    @Default('en') String language,
    @Default(true) bool pushNotificationsEnabled,
    @Default(true) bool emailNotificationsEnabled,
    @Default(true) bool profileVisible,
    
    // Timestamps
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String userId,
    String? bio,
    String? location,
    List<String>? skills,
    List<String>? interests,
    String? company,
    String? jobTitle,
    String? website,
    Map<String, String>? socialLinks,
    List<String>? certifications,
    double? rating,
    int? reviewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
class UserStatistics with _$UserStatistics {
  const factory UserStatistics({
    required String userId,
    @Default(0) int totalPoints,
    @Default(0) int currentLevel,
    @Default(0) int needsCreated,
    @Default(0) int needsHelped,
    @Default(0) int needsCompleted,
    @Default(0) int missionsCompleted,
    @Default(0) int badgesEarned,
    @Default(0) int helpRequests,
    @Default(0) int successfulHelps,
    double? helpSuccessRate,
    double? averageRating,
    DateTime? lastActivityAt,
    Map<String, int>? categoryContributions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserStatistics;

  factory UserStatistics.fromJson(Map<String, dynamic> json) => _$UserStatisticsFromJson(json);
} 