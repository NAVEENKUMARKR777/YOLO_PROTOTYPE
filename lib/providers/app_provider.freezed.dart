// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppThemeState {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  bool get isDarkMode => throw _privateConstructorUsedError;
  Color get primaryColor => throw _privateConstructorUsedError;
  Color get accentColor => throw _privateConstructorUsedError;

  /// Create a copy of AppThemeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppThemeStateCopyWith<AppThemeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppThemeStateCopyWith<$Res> {
  factory $AppThemeStateCopyWith(
          AppThemeState value, $Res Function(AppThemeState) then) =
      _$AppThemeStateCopyWithImpl<$Res, AppThemeState>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool isDarkMode,
      Color primaryColor,
      Color accentColor});
}

/// @nodoc
class _$AppThemeStateCopyWithImpl<$Res, $Val extends AppThemeState>
    implements $AppThemeStateCopyWith<$Res> {
  _$AppThemeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppThemeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? isDarkMode = null,
    Object? primaryColor = null,
    Object? accentColor = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      accentColor: null == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppThemeStateImplCopyWith<$Res>
    implements $AppThemeStateCopyWith<$Res> {
  factory _$$AppThemeStateImplCopyWith(
          _$AppThemeStateImpl value, $Res Function(_$AppThemeStateImpl) then) =
      __$$AppThemeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      bool isDarkMode,
      Color primaryColor,
      Color accentColor});
}

/// @nodoc
class __$$AppThemeStateImplCopyWithImpl<$Res>
    extends _$AppThemeStateCopyWithImpl<$Res, _$AppThemeStateImpl>
    implements _$$AppThemeStateImplCopyWith<$Res> {
  __$$AppThemeStateImplCopyWithImpl(
      _$AppThemeStateImpl _value, $Res Function(_$AppThemeStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppThemeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? isDarkMode = null,
    Object? primaryColor = null,
    Object? accentColor = null,
  }) {
    return _then(_$AppThemeStateImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      primaryColor: null == primaryColor
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color,
      accentColor: null == accentColor
          ? _value.accentColor
          : accentColor // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$AppThemeStateImpl implements _AppThemeState {
  const _$AppThemeStateImpl(
      {this.themeMode = ThemeMode.system,
      this.isDarkMode = false,
      this.primaryColor = Colors.blue,
      this.accentColor = Colors.blueAccent});

  @override
  @JsonKey()
  final ThemeMode themeMode;
  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final Color primaryColor;
  @override
  @JsonKey()
  final Color accentColor;

  @override
  String toString() {
    return 'AppThemeState(themeMode: $themeMode, isDarkMode: $isDarkMode, primaryColor: $primaryColor, accentColor: $accentColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeStateImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.primaryColor, primaryColor) ||
                other.primaryColor == primaryColor) &&
            (identical(other.accentColor, accentColor) ||
                other.accentColor == accentColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, themeMode, isDarkMode, primaryColor, accentColor);

  /// Create a copy of AppThemeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppThemeStateImplCopyWith<_$AppThemeStateImpl> get copyWith =>
      __$$AppThemeStateImplCopyWithImpl<_$AppThemeStateImpl>(this, _$identity);
}

abstract class _AppThemeState implements AppThemeState {
  const factory _AppThemeState(
      {final ThemeMode themeMode,
      final bool isDarkMode,
      final Color primaryColor,
      final Color accentColor}) = _$AppThemeStateImpl;

  @override
  ThemeMode get themeMode;
  @override
  bool get isDarkMode;
  @override
  Color get primaryColor;
  @override
  Color get accentColor;

  /// Create a copy of AppThemeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppThemeStateImplCopyWith<_$AppThemeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppSettings {
  String get language => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get timezone => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get locationSharing => throw _privateConstructorUsedError;
  bool get analyticsEnabled => throw _privateConstructorUsedError;
  bool get autoBackup => throw _privateConstructorUsedError;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppSettingsCopyWith<AppSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingsCopyWith<$Res> {
  factory $AppSettingsCopyWith(
          AppSettings value, $Res Function(AppSettings) then) =
      _$AppSettingsCopyWithImpl<$Res, AppSettings>;
  @useResult
  $Res call(
      {String language,
      String currency,
      String timezone,
      bool notificationsEnabled,
      bool locationSharing,
      bool analyticsEnabled,
      bool autoBackup});
}

/// @nodoc
class _$AppSettingsCopyWithImpl<$Res, $Val extends AppSettings>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? currency = null,
    Object? timezone = null,
    Object? notificationsEnabled = null,
    Object? locationSharing = null,
    Object? analyticsEnabled = null,
    Object? autoBackup = null,
  }) {
    return _then(_value.copyWith(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      locationSharing: null == locationSharing
          ? _value.locationSharing
          : locationSharing // ignore: cast_nullable_to_non_nullable
              as bool,
      analyticsEnabled: null == analyticsEnabled
          ? _value.analyticsEnabled
          : analyticsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoBackup: null == autoBackup
          ? _value.autoBackup
          : autoBackup // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingsImplCopyWith<$Res>
    implements $AppSettingsCopyWith<$Res> {
  factory _$$AppSettingsImplCopyWith(
          _$AppSettingsImpl value, $Res Function(_$AppSettingsImpl) then) =
      __$$AppSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String language,
      String currency,
      String timezone,
      bool notificationsEnabled,
      bool locationSharing,
      bool analyticsEnabled,
      bool autoBackup});
}

/// @nodoc
class __$$AppSettingsImplCopyWithImpl<$Res>
    extends _$AppSettingsCopyWithImpl<$Res, _$AppSettingsImpl>
    implements _$$AppSettingsImplCopyWith<$Res> {
  __$$AppSettingsImplCopyWithImpl(
      _$AppSettingsImpl _value, $Res Function(_$AppSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? language = null,
    Object? currency = null,
    Object? timezone = null,
    Object? notificationsEnabled = null,
    Object? locationSharing = null,
    Object? analyticsEnabled = null,
    Object? autoBackup = null,
  }) {
    return _then(_$AppSettingsImpl(
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      timezone: null == timezone
          ? _value.timezone
          : timezone // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      locationSharing: null == locationSharing
          ? _value.locationSharing
          : locationSharing // ignore: cast_nullable_to_non_nullable
              as bool,
      analyticsEnabled: null == analyticsEnabled
          ? _value.analyticsEnabled
          : analyticsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      autoBackup: null == autoBackup
          ? _value.autoBackup
          : autoBackup // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppSettingsImpl implements _AppSettings {
  const _$AppSettingsImpl(
      {this.language = 'en',
      this.currency = 'USD',
      this.timezone = 'America/New_York',
      this.notificationsEnabled = true,
      this.locationSharing = true,
      this.analyticsEnabled = false,
      this.autoBackup = true});

  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String currency;
  @override
  @JsonKey()
  final String timezone;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool locationSharing;
  @override
  @JsonKey()
  final bool analyticsEnabled;
  @override
  @JsonKey()
  final bool autoBackup;

  @override
  String toString() {
    return 'AppSettings(language: $language, currency: $currency, timezone: $timezone, notificationsEnabled: $notificationsEnabled, locationSharing: $locationSharing, analyticsEnabled: $analyticsEnabled, autoBackup: $autoBackup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingsImpl &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.locationSharing, locationSharing) ||
                other.locationSharing == locationSharing) &&
            (identical(other.analyticsEnabled, analyticsEnabled) ||
                other.analyticsEnabled == analyticsEnabled) &&
            (identical(other.autoBackup, autoBackup) ||
                other.autoBackup == autoBackup));
  }

  @override
  int get hashCode => Object.hash(runtimeType, language, currency, timezone,
      notificationsEnabled, locationSharing, analyticsEnabled, autoBackup);

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      __$$AppSettingsImplCopyWithImpl<_$AppSettingsImpl>(this, _$identity);
}

abstract class _AppSettings implements AppSettings {
  const factory _AppSettings(
      {final String language,
      final String currency,
      final String timezone,
      final bool notificationsEnabled,
      final bool locationSharing,
      final bool analyticsEnabled,
      final bool autoBackup}) = _$AppSettingsImpl;

  @override
  String get language;
  @override
  String get currency;
  @override
  String get timezone;
  @override
  bool get notificationsEnabled;
  @override
  bool get locationSharing;
  @override
  bool get analyticsEnabled;
  @override
  bool get autoBackup;

  /// Create a copy of AppSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppSettingsImplCopyWith<_$AppSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AppState {
  AppThemeState get themeState => throw _privateConstructorUsedError;
  AppSettings get settings => throw _privateConstructorUsedError;
  NotificationPreferences get notificationPreferences =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppStateCopyWith<AppState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppStateCopyWith<$Res> {
  factory $AppStateCopyWith(AppState value, $Res Function(AppState) then) =
      _$AppStateCopyWithImpl<$Res, AppState>;
  @useResult
  $Res call(
      {AppThemeState themeState,
      AppSettings settings,
      NotificationPreferences notificationPreferences,
      bool isLoading,
      String? error});

  $AppThemeStateCopyWith<$Res> get themeState;
  $AppSettingsCopyWith<$Res> get settings;
  $NotificationPreferencesCopyWith<$Res> get notificationPreferences;
}

/// @nodoc
class _$AppStateCopyWithImpl<$Res, $Val extends AppState>
    implements $AppStateCopyWith<$Res> {
  _$AppStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeState = null,
    Object? settings = null,
    Object? notificationPreferences = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      themeState: null == themeState
          ? _value.themeState
          : themeState // ignore: cast_nullable_to_non_nullable
              as AppThemeState,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      notificationPreferences: null == notificationPreferences
          ? _value.notificationPreferences
          : notificationPreferences // ignore: cast_nullable_to_non_nullable
              as NotificationPreferences,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppThemeStateCopyWith<$Res> get themeState {
    return $AppThemeStateCopyWith<$Res>(_value.themeState, (value) {
      return _then(_value.copyWith(themeState: value) as $Val);
    });
  }

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppSettingsCopyWith<$Res> get settings {
    return $AppSettingsCopyWith<$Res>(_value.settings, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationPreferencesCopyWith<$Res> get notificationPreferences {
    return $NotificationPreferencesCopyWith<$Res>(
        _value.notificationPreferences, (value) {
      return _then(_value.copyWith(notificationPreferences: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppStateImplCopyWith<$Res>
    implements $AppStateCopyWith<$Res> {
  factory _$$AppStateImplCopyWith(
          _$AppStateImpl value, $Res Function(_$AppStateImpl) then) =
      __$$AppStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AppThemeState themeState,
      AppSettings settings,
      NotificationPreferences notificationPreferences,
      bool isLoading,
      String? error});

  @override
  $AppThemeStateCopyWith<$Res> get themeState;
  @override
  $AppSettingsCopyWith<$Res> get settings;
  @override
  $NotificationPreferencesCopyWith<$Res> get notificationPreferences;
}

/// @nodoc
class __$$AppStateImplCopyWithImpl<$Res>
    extends _$AppStateCopyWithImpl<$Res, _$AppStateImpl>
    implements _$$AppStateImplCopyWith<$Res> {
  __$$AppStateImplCopyWithImpl(
      _$AppStateImpl _value, $Res Function(_$AppStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeState = null,
    Object? settings = null,
    Object? notificationPreferences = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$AppStateImpl(
      themeState: null == themeState
          ? _value.themeState
          : themeState // ignore: cast_nullable_to_non_nullable
              as AppThemeState,
      settings: null == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as AppSettings,
      notificationPreferences: null == notificationPreferences
          ? _value.notificationPreferences
          : notificationPreferences // ignore: cast_nullable_to_non_nullable
              as NotificationPreferences,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AppStateImpl implements _AppState {
  const _$AppStateImpl(
      {this.themeState = const AppThemeState(),
      this.settings = const AppSettings(),
      this.notificationPreferences = const NotificationPreferences(),
      this.isLoading = false,
      this.error});

  @override
  @JsonKey()
  final AppThemeState themeState;
  @override
  @JsonKey()
  final AppSettings settings;
  @override
  @JsonKey()
  final NotificationPreferences notificationPreferences;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'AppState(themeState: $themeState, settings: $settings, notificationPreferences: $notificationPreferences, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppStateImpl &&
            (identical(other.themeState, themeState) ||
                other.themeState == themeState) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(
                    other.notificationPreferences, notificationPreferences) ||
                other.notificationPreferences == notificationPreferences) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, themeState, settings,
      notificationPreferences, isLoading, error);

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      __$$AppStateImplCopyWithImpl<_$AppStateImpl>(this, _$identity);
}

abstract class _AppState implements AppState {
  const factory _AppState(
      {final AppThemeState themeState,
      final AppSettings settings,
      final NotificationPreferences notificationPreferences,
      final bool isLoading,
      final String? error}) = _$AppStateImpl;

  @override
  AppThemeState get themeState;
  @override
  AppSettings get settings;
  @override
  NotificationPreferences get notificationPreferences;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of AppState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppStateImplCopyWith<_$AppStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
