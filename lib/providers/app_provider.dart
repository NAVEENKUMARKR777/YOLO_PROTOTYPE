import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../services/azure/azure_cosmos.dart';
import '../models/notification_model.dart';

part 'app_provider.freezed.dart';

// App theme provider
final appThemeProvider = StateNotifierProvider<AppThemeNotifier, AppThemeState>((ref) {
  return AppThemeNotifier();
});

// App settings provider
final appSettingsProvider = StateNotifierProvider<AppSettingsNotifier, AppSettings>((ref) {
  return AppSettingsNotifier();
});

// Combined app state provider
final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});

// Loading state provider
final loadingStateProvider = StateProvider<bool>((ref) => false);

// App connectivity provider
final connectivityProvider = StateProvider<bool>((ref) => true);

// Notification settings provider
final notificationSettingsProvider = StateNotifierProvider<NotificationSettingsNotifier, NotificationPreferences>((ref) {
  return NotificationSettingsNotifier();
});

// Bottom navigation index provider
final bottomNavIndexProvider = StateProvider<int>((ref) => 0);

// Current location provider
final currentLocationProvider = StateProvider<LocationData?>((ref) => null);

// Search query provider
final searchQueryProvider = StateProvider<String>((ref) => '');

// Error message provider
final errorMessageProvider = StateProvider<String?>((ref) => null);

// Success message provider
final successMessageProvider = StateProvider<String?>((ref) => null);

// Azure Cosmos DB service provider
final cosmosServiceProvider = Provider<AzureCosmosService>((ref) {
  return AzureCosmosService();
});

// App Theme State
@freezed
class AppThemeState with _$AppThemeState {
  const factory AppThemeState({
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(false) bool isDarkMode,
    @Default(Colors.blue) Color primaryColor,
    @Default(Colors.blueAccent) Color accentColor,
  }) = _AppThemeState;
}

// App Settings
@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('en') String language,
    @Default('USD') String currency,
    @Default('America/New_York') String timezone,
    @Default(true) bool notificationsEnabled,
    @Default(true) bool locationSharing,
    @Default(false) bool analyticsEnabled,
    @Default(true) bool autoBackup,
  }) = _AppSettings;
}

// Location Data
class LocationData {
  final double latitude;
  final double longitude;
  final String address;
  final String city;
  final String country;
  
  const LocationData({
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.city,
    required this.country,
  });
}

// App Theme Notifier
class AppThemeNotifier extends StateNotifier<AppThemeState> {
  AppThemeNotifier() : super(const AppThemeState()) {
    _loadThemeSettings();
  }
  
  Future<void> _loadThemeSettings() async {
    // Load theme settings from local storage
    // This would typically use SharedPreferences or similar
    try {
      // Simulated loading
      await Future.delayed(const Duration(milliseconds: 100));
      
      // For now, detect system theme
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDarkMode = brightness == Brightness.dark;
      
      state = state.copyWith(
        isDarkMode: isDarkMode,
        themeMode: ThemeMode.system,
      );
    } catch (e) {
      // Handle error loading theme
    }
  }
  
  void setThemeMode(ThemeMode mode) {
    final isDarkMode = mode == ThemeMode.dark || 
        (mode == ThemeMode.system && 
         WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);
    
    state = state.copyWith(
      themeMode: mode,
      isDarkMode: isDarkMode,
    );
    
    _saveThemeSettings();
  }
  
  void toggleDarkMode() {
    final newMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    setThemeMode(newMode);
  }
  
  void setPrimaryColor(Color color) {
    state = state.copyWith(primaryColor: color);
    _saveThemeSettings();
  }
  
  void setFontFamily(String fontFamily) {
    state = state.copyWith(fontFamily: fontFamily);
    _saveThemeSettings();
  }
  
  Future<void> _saveThemeSettings() async {
    // Save theme settings to local storage
    try {
      // This would typically use SharedPreferences
      await Future.delayed(const Duration(milliseconds: 50));
    } catch (e) {
      // Handle error saving theme
    }
  }
}

// App Settings Notifier
class AppSettingsNotifier extends StateNotifier<AppSettings> {
  AppSettingsNotifier() : super(const AppSettings()) {
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    try {
      // Load settings from local storage
      await Future.delayed(const Duration(milliseconds: 100));
      
      // This would typically load from SharedPreferences
      // For now, use defaults
    } catch (e) {
      // Handle error loading settings
    }
  }
  
  void updateLanguage(String language) {
    state = state.copyWith(language: language);
    _saveSettings();
  }
  
  void updateNotificationEnabled(bool enabled) {
    state = state.copyWith(enableNotifications: enabled);
    _saveSettings();
  }
  
  void updateLocationServicesEnabled(bool enabled) {
    state = state.copyWith(enableLocationServices: enabled);
    _saveSettings();
  }
  
  void updateAnalyticsEnabled(bool enabled) {
    state = state.copyWith(enableAnalytics: enabled);
    _saveSettings();
  }
  
  void updateAutoPlayVideos(bool enabled) {
    state = state.copyWith(autoPlayVideos: enabled);
    _saveSettings();
  }
  
  void updateTextScale(double scale) {
    state = state.copyWith(textScale: scale);
    _saveSettings();
  }
  
  void updateItemsPerPage(int items) {
    state = state.copyWith(itemsPerPage: items);
    _saveSettings();
  }
  
  void updateOfflineMode(bool enabled) {
    state = state.copyWith(offlineMode: enabled);
    _saveSettings();
  }
  
  void updateVoiceCommands(bool enabled) {
    state = state.copyWith(enableVoiceCommands: enabled);
    _saveSettings();
  }
  
  void updateHapticFeedback(bool enabled) {
    state = state.copyWith(enableHapticFeedback: enabled);
    _saveSettings();
  }
  
  void updateShowTutorials(bool enabled) {
    state = state.copyWith(showTutorials: enabled);
    _saveSettings();
  }
  
  void updatePrivacySetting(String key, dynamic value) {
    final updatedPrivacySettings = Map<String, dynamic>.from(state.privacySettings);
    updatedPrivacySettings[key] = value;
    
    state = state.copyWith(privacySettings: updatedPrivacySettings);
    _saveSettings();
  }
  
  void resetToDefaults() {
    state = const AppSettings();
    _saveSettings();
  }
  
  Future<void> _saveSettings() async {
    try {
      // Save settings to local storage
      await Future.delayed(const Duration(milliseconds: 50));
      
      // This would typically save to SharedPreferences
      // await prefs.setString('app_settings', jsonEncode(state.toJson()));
    } catch (e) {
      // Handle error saving settings
    }
  }
}

// Notification Settings Notifier
class NotificationSettingsNotifier extends StateNotifier<NotificationPreferences> {
  NotificationSettingsNotifier() : super(const NotificationPreferences()) {
    _loadNotificationSettings();
  }
  
  Future<void> _loadNotificationSettings() async {
    try {
      // Load notification settings
      await Future.delayed(const Duration(milliseconds: 100));
      
      // Use defaults for now
      state = const NotificationPreferences(
        enablePushNotifications: true,
        enableEmailNotifications: true,
        enableSmsNotifications: false,
        notificationFrequency: NotificationFrequency.immediately,
        quietHours: QuietHours(
          enabled: true,
          startTime: '22:00',
          endTime: '08:00',
        ),
        categories: {
          'need_updates': true,
          'chat_messages': true,
          'mission_updates': true,
          'achievement_earned': true,
          'helper_requests': true,
          'admin_announcements': true,
        },
      );
    } catch (e) {
      // Handle error loading notification settings
    }
  }
  
  void updatePushNotifications(bool enabled) {
    state = state.copyWith(enablePushNotifications: enabled);
    _saveNotificationSettings();
  }
  
  void updateEmailNotifications(bool enabled) {
    state = state.copyWith(enableEmailNotifications: enabled);
    _saveNotificationSettings();
  }
  
  void updateSmsNotifications(bool enabled) {
    state = state.copyWith(enableSmsNotifications: enabled);
    _saveNotificationSettings();
  }
  
  void updateNotificationFrequency(NotificationFrequency frequency) {
    state = state.copyWith(notificationFrequency: frequency);
    _saveNotificationSettings();
  }
  
  void updateQuietHours(QuietHours quietHours) {
    state = state.copyWith(quietHours: quietHours);
    _saveNotificationSettings();
  }
  
  void updateCategoryEnabled(String category, bool enabled) {
    final updatedCategories = Map<String, bool>.from(state.categories);
    updatedCategories[category] = enabled;
    
    state = state.copyWith(categories: updatedCategories);
    _saveNotificationSettings();
  }
  
  void enableAllCategories() {
    final updatedCategories = Map<String, bool>.from(state.categories);
    for (final key in updatedCategories.keys) {
      updatedCategories[key] = true;
    }
    
    state = state.copyWith(categories: updatedCategories);
    _saveNotificationSettings();
  }
  
  void disableAllCategories() {
    final updatedCategories = Map<String, bool>.from(state.categories);
    for (final key in updatedCategories.keys) {
      updatedCategories[key] = false;
    }
    
    state = state.copyWith(categories: updatedCategories);
    _saveNotificationSettings();
  }
  
  Future<void> _saveNotificationSettings() async {
    try {
      // Save notification settings
      await Future.delayed(const Duration(milliseconds: 50));
    } catch (e) {
      // Handle error saving notification settings
    }
  }
}

// Helper providers for commonly used values
final isDarkModeProvider = Provider<bool>((ref) {
  return ref.watch(appThemeProvider).isDarkMode;
});

final primaryColorProvider = Provider<Color>((ref) {
  return ref.watch(appThemeProvider).primaryColor;
});

final currentLanguageProvider = Provider<String>((ref) {
  return ref.watch(appSettingsProvider).language;
});

final notificationsEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsProvider).enableNotifications;
});

final locationServicesEnabledProvider = Provider<bool>((ref) {
  return ref.watch(appSettingsProvider).enableLocationServices;
});

// App-wide error handling
final appErrorProvider = StateNotifierProvider<AppErrorNotifier, AppError?>((ref) {
  return AppErrorNotifier();
});

class AppError {
  final String message;
  final String? details;
  final DateTime timestamp;
  final AppErrorType type;
  
  const AppError({
    required this.message,
    this.details,
    required this.timestamp,
    required this.type,
  });
}

enum AppErrorType {
  network,
  authentication,
  validation,
  server,
  unknown,
}

class AppErrorNotifier extends StateNotifier<AppError?> {
  AppErrorNotifier() : super(null);
  
  void showError(String message, {String? details, AppErrorType type = AppErrorType.unknown}) {
    state = AppError(
      message: message,
      details: details,
      timestamp: DateTime.now(),
      type: type,
    );
    
    // Auto-clear error after 5 seconds
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        clearError();
      }
    });
  }
  
  void clearError() {
    state = null;
  }
}

// Combined App State
@freezed
class AppState with _$AppState {
  const factory AppState({
    @Default(AppThemeState()) AppThemeState themeState,
    @Default(AppSettings()) AppSettings settings,
    @Default(NotificationPreferences()) NotificationPreferences notificationPreferences,
    @Default(false) bool isLoading,
    String? error,
  }) = _AppState;
}

// Combined App State Notifier
class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(const AppState()) {
    _initializeApp();
  }
  
  Future<void> _initializeApp() async {
    state = state.copyWith(isLoading: true);
    
    try {
      // Initialize app state
      await Future.delayed(const Duration(milliseconds: 200));
      
      state = state.copyWith(
        isLoading: false,
        clearError: true,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to initialize app: $e',
        isLoading: false,
      );
    }
  }
  
  void setThemeMode(ThemeMode themeMode) {
    final updatedThemeState = state.themeState.copyWith(themeMode: themeMode);
    state = state.copyWith(themeState: updatedThemeState);
  }
  
  void setNotificationsEnabled(bool enabled) {
    final updatedSettings = state.settings.copyWith(enableNotifications: enabled);
    state = state.copyWith(settings: updatedSettings);
  }
  
  void setLanguage(String language) {
    final updatedSettings = state.settings.copyWith(language: language);
    state = state.copyWith(settings: updatedSettings);
  }
  
  void setLocationServicesEnabled(bool enabled) {
    final updatedSettings = state.settings.copyWith(enableLocationServices: enabled);
    state = state.copyWith(settings: updatedSettings);
  }
  
  void clearError() {
    state = state.copyWith(clearError: true);
  }
} 