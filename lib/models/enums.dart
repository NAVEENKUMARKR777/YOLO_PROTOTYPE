import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// Enums for YOLO Need App

enum UserRole {
  @JsonValue('seeker')
  seeker,
  @JsonValue('helper')
  helper,
  @JsonValue('admin')
  admin,
  @JsonValue('business')
  business,
}

enum NeedStatus {
  @JsonValue('draft')
  draft,
  @JsonValue('open')
  open,
  @JsonValue('pending')
  pending,
  @JsonValue('active')
  active,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('expired')
  expired,
}

enum NeedUrgency {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

enum NeedPriority {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent,
}

enum NeedCategory {
  @JsonValue('general')
  general,
  @JsonValue('emergency')
  emergency,
  @JsonValue('health')
  health,
  @JsonValue('education')
  education,
  @JsonValue('technology')
  technology,
  @JsonValue('transportation')
  transportation,
  @JsonValue('housing')
  housing,
  @JsonValue('food')
  food,
  @JsonValue('employment')
  employment,
  @JsonValue('financial')
  financial,
  @JsonValue('legal')
  legal,
  @JsonValue('social')
  social,
  @JsonValue('other')
  other,
}

enum InputMethod {
  @JsonValue('text')
  text,
  @JsonValue('voice')
  voice,
  @JsonValue('image')
  image,
  @JsonValue('barcode')
  barcode,
}

enum MissionType {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('special')
  special,
  @JsonValue('achievement')
  achievement,
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

enum MissionAction {
  @JsonValue('createNeed')
  createNeed,
  @JsonValue('helpSomeone')
  helpSomeone,
  @JsonValue('completeProfile')
  completeProfile,
  @JsonValue('shareApp')
  shareApp,
  @JsonValue('inviteFriend')
  inviteFriend,
}

enum BadgeType {
  @JsonValue('helper')
  helper,
  @JsonValue('seeker')
  seeker,
  @JsonValue('community')
  community,
  @JsonValue('achievement')
  achievement,
  @JsonValue('special')
  special,
}

enum BadgeTier {
  @JsonValue('bronze')
  bronze,
  @JsonValue('silver')
  silver,
  @JsonValue('gold')
  gold,
  @JsonValue('platinum')
  platinum,
  @JsonValue('diamond')
  diamond,
}

enum BadgeCategory {
  @JsonValue('community')
  community,
  @JsonValue('achievement')
  achievement,
  @JsonValue('special')
  special,
  @JsonValue('milestone')
  milestone,
}

enum MissionCategory {
  @JsonValue('community')
  community,
  @JsonValue('achievement')
  achievement,
  @JsonValue('special')
  special,
}

enum ChatMessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('file')
  file,
  @JsonValue('system')
  system,
}

enum LeaderboardType {
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
  @JsonValue('monthly')
  monthly,
  @JsonValue('all_time')
  allTime,
}

enum ChatType {
  @JsonValue('direct_message')
  directMessage,
  @JsonValue('group_chat')
  groupChat,
  @JsonValue('ai_chat')
  aiChat,
  @JsonValue('support_chat')
  supportChat,
}

enum NeedVisibility {
  @JsonValue('public')
  public,
  @JsonValue('private')
  private,
  @JsonValue('community')
  community,
  @JsonValue('verified_only')
  verifiedOnly,
}

enum UrgencyLevel {
  @JsonValue('low')
  low,
  @JsonValue('medium')
  medium,
  @JsonValue('high')
  high,
  @JsonValue('critical')
  critical,
}

enum NotificationFrequency {
  @JsonValue('immediate')
  immediate,
  @JsonValue('hourly')
  hourly,
  @JsonValue('daily')
  daily,
  @JsonValue('weekly')
  weekly,
}

enum QuietHours {
  @JsonValue('disabled')
  disabled,
  @JsonValue('enabled')
  enabled,
}

enum HelpOffer {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('rejected')
  rejected,
  @JsonValue('completed')
  completed,
}

enum ChatState {
  @JsonValue('loading')
  loading,
  @JsonValue('loaded')
  loaded,
  @JsonValue('error')
  error,
}

enum LeaderboardEntry {
  @JsonValue('user')
  user,
  @JsonValue('points')
  points,
  @JsonValue('rank')
  rank,
}

// Extension methods for enum utilities
extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.seeker:
        return 'Seeker';
      case UserRole.helper:
        return 'Helper';
      case UserRole.admin:
        return 'Admin';
      case UserRole.business:
        return 'Business';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.seeker:
        return Icons.person_search;
      case UserRole.helper:
        return Icons.volunteer_activism;
      case UserRole.admin:
        return Icons.admin_panel_settings;
      case UserRole.business:
        return Icons.business;
    }
  }

  Color get color {
    switch (this) {
      case UserRole.seeker:
        return Colors.blue;
      case UserRole.helper:
        return Colors.green;
      case UserRole.admin:
        return Colors.red;
      case UserRole.business:
        return Colors.orange;
    }
  }
}

extension NeedStatusExtension on NeedStatus {
  String get displayName {
    switch (this) {
      case NeedStatus.pending:
        return 'Pending';
      case NeedStatus.active:
        return 'Active';
      case NeedStatus.inProgress:
        return 'In Progress';
      case NeedStatus.completed:
        return 'Completed';
      case NeedStatus.cancelled:
        return 'Cancelled';
    }
  }

  IconData get icon {
    switch (this) {
      case NeedStatus.pending:
        return Icons.schedule;
      case NeedStatus.active:
        return Icons.play_circle;
      case NeedStatus.inProgress:
        return Icons.engineering;
      case NeedStatus.completed:
        return Icons.check_circle;
      case NeedStatus.cancelled:
        return Icons.cancel;
    }
  }

  Color get color {
    switch (this) {
      case NeedStatus.pending:
        return Colors.orange;
      case NeedStatus.active:
        return Colors.green;
      case NeedStatus.inProgress:
        return Colors.blue;
      case NeedStatus.completed:
        return Colors.grey;
      case NeedStatus.cancelled:
        return Colors.red;
    }
  }

  static Color getStatusColor(NeedStatus status) {
    switch (status) {
      case NeedStatus.draft:
        return Colors.grey;
      case NeedStatus.pending:
        return Colors.orange;
      case NeedStatus.active:
        return Colors.green;
      case NeedStatus.inProgress:
        return Colors.blue;
      case NeedStatus.completed:
        return Colors.purple;
      case NeedStatus.cancelled:
        return Colors.red;
      case NeedStatus.expired:
        return Colors.grey;
    }
  }

  static String getStatusText(NeedStatus status) {
    switch (status) {
      case NeedStatus.draft:
        return 'Draft';
      case NeedStatus.pending:
        return 'Pending';
      case NeedStatus.active:
        return 'Active';
      case NeedStatus.inProgress:
        return 'In Progress';
      case NeedStatus.completed:
        return 'Completed';
      case NeedStatus.cancelled:
        return 'Cancelled';
      case NeedStatus.expired:
        return 'Expired';
    }
  }

  static IconData getStatusIcon(NeedStatus status) {
    switch (status) {
      case NeedStatus.draft:
        return Icons.edit;
      case NeedStatus.pending:
        return Icons.schedule;
      case NeedStatus.active:
        return Icons.check_circle;
      case NeedStatus.inProgress:
        return Icons.play_circle;
      case NeedStatus.completed:
        return Icons.done_all;
      case NeedStatus.cancelled:
        return Icons.cancel;
      case NeedStatus.expired:
        return Icons.access_time;
    }
  }
}

extension NeedUrgencyExtension on NeedUrgency {
  String get displayName {
    switch (this) {
      case NeedUrgency.low:
        return 'Low';
      case NeedUrgency.medium:
        return 'Medium';
      case NeedUrgency.high:
        return 'High';
      case NeedUrgency.critical:
        return 'Critical';
    }
  }

  Color get color {
    switch (this) {
      case NeedUrgency.low:
        return Colors.green;
      case NeedUrgency.medium:
        return Colors.orange;
      case NeedUrgency.high:
        return Colors.red;
      case NeedUrgency.critical:
        return Colors.purple;
    }
  }

  int get priority {
    switch (this) {
      case NeedUrgency.low:
        return 1;
      case NeedUrgency.medium:
        return 2;
      case NeedUrgency.high:
        return 3;
      case NeedUrgency.critical:
        return 4;
    }
  }
}

extension MissionTypeExtension on MissionType {
  String get displayName {
    switch (this) {
      case MissionType.daily:
        return 'Daily';
      case MissionType.weekly:
        return 'Weekly';
      case MissionType.special:
        return 'Special';
      case MissionType.achievement:
        return 'Achievement';
    }
  }

  IconData get icon {
    switch (this) {
      case MissionType.daily:
        return Icons.today;
      case MissionType.weekly:
        return Icons.view_week;
      case MissionType.special:
        return Icons.star;
      case MissionType.achievement:
        return Icons.emoji_events;
    }
  }
}

extension BadgeTypeExtension on BadgeType {
  String get displayName {
    switch (this) {
      case BadgeType.helper:
        return 'Helper';
      case BadgeType.seeker:
        return 'Seeker';
      case BadgeType.community:
        return 'Community';
      case BadgeType.achievement:
        return 'Achievement';
      case BadgeType.special:
        return 'Special';
    }
  }

  IconData get icon {
    switch (this) {
      case BadgeType.helper:
        return Icons.volunteer_activism;
      case BadgeType.seeker:
        return Icons.person_search;
      case BadgeType.community:
        return Icons.people;
      case BadgeType.achievement:
        return Icons.emoji_events;
      case BadgeType.special:
        return Icons.star;
    }
  }
}

extension BadgeTierExtension on BadgeTier {
  String get displayName {
    switch (this) {
      case BadgeTier.bronze:
        return 'Bronze';
      case BadgeTier.silver:
        return 'Silver';
      case BadgeTier.gold:
        return 'Gold';
      case BadgeTier.platinum:
        return 'Platinum';
      case BadgeTier.diamond:
        return 'Diamond';
    }
  }

  Color get color {
    switch (this) {
      case BadgeTier.bronze:
        return Colors.brown;
      case BadgeTier.silver:
        return Colors.grey;
      case BadgeTier.gold:
        return Colors.amber;
      case BadgeTier.platinum:
        return Colors.blueGrey;
      case BadgeTier.diamond:
        return Colors.cyan;
    }
  }
} 