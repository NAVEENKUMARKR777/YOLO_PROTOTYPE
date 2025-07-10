/// Constants for all asset paths used in the YOLO Need App
class AssetsConstants {
  // Image Assets
  static const String appLogo = 'assets/images/app_logo.png';
  static const String splashBackground = 'assets/images/splash_background.png';
  static const String placeholderAvatar = 'assets/images/placeholder_avatar.png';
  static const String needPlaceholder = 'assets/images/need_placeholder.png';
  static const String communityHero = 'assets/images/community_hero.png';
  static const String emptyState = 'assets/images/empty_state.png';

  // Icon Assets
  static const String yoloWarriorIcon = 'assets/icons/yolo_warrior.svg';
  static const String needCaptureIcon = 'assets/icons/need_capture.svg';
  static const String communityHelpIcon = 'assets/icons/community_help.svg';
  static const String aiChatIcon = 'assets/icons/ai_chat.svg';
  static const String badgeAchievementIcon = 'assets/icons/badge_achievement.svg';

  // Animation Assets
  static const String loadingAnimation = 'assets/animations/loading_animation.json';
  static const String successAnimation = 'assets/animations/success_animation.json';
  static const String celebrationAnimation = 'assets/animations/celebration_animation.json';

  // Audio Assets
  static const String notificationSound = 'assets/audio/notification_sound.mp3';
  static const String achievementSound = 'assets/audio/achievement_sound.mp3';
  static const String voiceInputStartSound = 'assets/audio/voice_input_start.mp3';

  // Font Assets
  static const String robotoRegular = 'assets/fonts/Roboto-Regular.ttf';
  static const String robotoBold = 'assets/fonts/Roboto-Bold.ttf';

  // Asset Categories for easy access
  static const List<String> allImages = [
    appLogo,
    splashBackground,
    placeholderAvatar,
    needPlaceholder,
    communityHero,
    emptyState,
  ];

  static const List<String> allIcons = [
    yoloWarriorIcon,
    needCaptureIcon,
    communityHelpIcon,
    aiChatIcon,
    badgeAchievementIcon,
  ];

  static const List<String> allAnimations = [
    loadingAnimation,
    successAnimation,
    celebrationAnimation,
  ];

  static const List<String> allAudio = [
    notificationSound,
    achievementSound,
    voiceInputStartSound,
  ];

  static const List<String> allFonts = [
    robotoRegular,
    robotoBold,
  ];
} 