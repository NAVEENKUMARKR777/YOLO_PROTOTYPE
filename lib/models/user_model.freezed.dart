// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get profileImageUrl => throw _privateConstructorUsedError;
  UserRole get role => throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;
  String? get azureObjectId => throw _privateConstructorUsedError;
  String? get accessToken => throw _privateConstructorUsedError;
  String? get refreshToken => throw _privateConstructorUsedError;
  DateTime? get tokenExpiry => throw _privateConstructorUsedError;
  Map<String, dynamic>? get claims =>
      throw _privateConstructorUsedError; // Profile Information
  String? get bio => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String>? get skills => throw _privateConstructorUsedError;
  List<String>? get interests => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get jobTitle => throw _privateConstructorUsedError; // Gamification
  int get points => throw _privateConstructorUsedError;
  int get level => throw _privateConstructorUsedError;
  List<String> get badges => throw _privateConstructorUsedError;
  int get needsCreated => throw _privateConstructorUsedError;
  int get needsHelped => throw _privateConstructorUsedError;
  int get missionsCompleted => throw _privateConstructorUsedError; // Settings
  bool get isDarkMode => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;
  bool get emailNotificationsEnabled => throw _privateConstructorUsedError;
  bool get profileVisible => throw _privateConstructorUsedError; // Timestamps
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String email,
      String displayName,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? profileImageUrl,
      UserRole role,
      UserStatus status,
      String? azureObjectId,
      String? accessToken,
      String? refreshToken,
      DateTime? tokenExpiry,
      Map<String, dynamic>? claims,
      String? bio,
      String? location,
      List<String>? skills,
      List<String>? interests,
      String? company,
      String? jobTitle,
      int points,
      int level,
      List<String> badges,
      int needsCreated,
      int needsHelped,
      int missionsCompleted,
      bool isDarkMode,
      String language,
      bool pushNotificationsEnabled,
      bool emailNotificationsEnabled,
      bool profileVisible,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastLoginAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phoneNumber = freezed,
    Object? profileImageUrl = freezed,
    Object? role = null,
    Object? status = null,
    Object? azureObjectId = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? tokenExpiry = freezed,
    Object? claims = freezed,
    Object? bio = freezed,
    Object? location = freezed,
    Object? skills = freezed,
    Object? interests = freezed,
    Object? company = freezed,
    Object? jobTitle = freezed,
    Object? points = null,
    Object? level = null,
    Object? badges = null,
    Object? needsCreated = null,
    Object? needsHelped = null,
    Object? missionsCompleted = null,
    Object? isDarkMode = null,
    Object? language = null,
    Object? pushNotificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? profileVisible = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      azureObjectId: freezed == azureObjectId
          ? _value.azureObjectId
          : azureObjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenExpiry: freezed == tokenExpiry
          ? _value.tokenExpiry
          : tokenExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      claims: freezed == claims
          ? _value.claims
          : claims // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      interests: freezed == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      badges: null == badges
          ? _value.badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      needsCreated: null == needsCreated
          ? _value.needsCreated
          : needsCreated // ignore: cast_nullable_to_non_nullable
              as int,
      needsHelped: null == needsHelped
          ? _value.needsHelped
          : needsHelped // ignore: cast_nullable_to_non_nullable
              as int,
      missionsCompleted: null == missionsCompleted
          ? _value.missionsCompleted
          : missionsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _value.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      profileVisible: null == profileVisible
          ? _value.profileVisible
          : profileVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String displayName,
      String? firstName,
      String? lastName,
      String? phoneNumber,
      String? profileImageUrl,
      UserRole role,
      UserStatus status,
      String? azureObjectId,
      String? accessToken,
      String? refreshToken,
      DateTime? tokenExpiry,
      Map<String, dynamic>? claims,
      String? bio,
      String? location,
      List<String>? skills,
      List<String>? interests,
      String? company,
      String? jobTitle,
      int points,
      int level,
      List<String> badges,
      int needsCreated,
      int needsHelped,
      int missionsCompleted,
      bool isDarkMode,
      String language,
      bool pushNotificationsEnabled,
      bool emailNotificationsEnabled,
      bool profileVisible,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastLoginAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? displayName = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? phoneNumber = freezed,
    Object? profileImageUrl = freezed,
    Object? role = null,
    Object? status = null,
    Object? azureObjectId = freezed,
    Object? accessToken = freezed,
    Object? refreshToken = freezed,
    Object? tokenExpiry = freezed,
    Object? claims = freezed,
    Object? bio = freezed,
    Object? location = freezed,
    Object? skills = freezed,
    Object? interests = freezed,
    Object? company = freezed,
    Object? jobTitle = freezed,
    Object? points = null,
    Object? level = null,
    Object? badges = null,
    Object? needsCreated = null,
    Object? needsHelped = null,
    Object? missionsCompleted = null,
    Object? isDarkMode = null,
    Object? language = null,
    Object? pushNotificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? profileVisible = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastLoginAt = freezed,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: freezed == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: freezed == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
      azureObjectId: freezed == azureObjectId
          ? _value.azureObjectId
          : azureObjectId // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenExpiry: freezed == tokenExpiry
          ? _value.tokenExpiry
          : tokenExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      claims: freezed == claims
          ? _value._claims
          : claims // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      interests: freezed == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      badges: null == badges
          ? _value._badges
          : badges // ignore: cast_nullable_to_non_nullable
              as List<String>,
      needsCreated: null == needsCreated
          ? _value.needsCreated
          : needsCreated // ignore: cast_nullable_to_non_nullable
              as int,
      needsHelped: null == needsHelped
          ? _value.needsHelped
          : needsHelped // ignore: cast_nullable_to_non_nullable
              as int,
      missionsCompleted: null == missionsCompleted
          ? _value.missionsCompleted
          : missionsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      isDarkMode: null == isDarkMode
          ? _value.isDarkMode
          : isDarkMode // ignore: cast_nullable_to_non_nullable
              as bool,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _value.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      profileVisible: null == profileVisible
          ? _value.profileVisible
          : profileVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastLoginAt: freezed == lastLoginAt
          ? _value.lastLoginAt
          : lastLoginAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.email,
      required this.displayName,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.profileImageUrl,
      required this.role,
      required this.status,
      this.azureObjectId,
      this.accessToken,
      this.refreshToken,
      this.tokenExpiry,
      final Map<String, dynamic>? claims,
      this.bio,
      this.location,
      final List<String>? skills,
      final List<String>? interests,
      this.company,
      this.jobTitle,
      this.points = 0,
      this.level = 0,
      final List<String> badges = const [],
      this.needsCreated = 0,
      this.needsHelped = 0,
      this.missionsCompleted = 0,
      this.isDarkMode = true,
      this.language = 'en',
      this.pushNotificationsEnabled = true,
      this.emailNotificationsEnabled = true,
      this.profileVisible = true,
      this.createdAt,
      this.updatedAt,
      this.lastLoginAt})
      : _claims = claims,
        _skills = skills,
        _interests = interests,
        _badges = badges;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? phoneNumber;
  @override
  final String? profileImageUrl;
  @override
  final UserRole role;
  @override
  final UserStatus status;
  @override
  final String? azureObjectId;
  @override
  final String? accessToken;
  @override
  final String? refreshToken;
  @override
  final DateTime? tokenExpiry;
  final Map<String, dynamic>? _claims;
  @override
  Map<String, dynamic>? get claims {
    final value = _claims;
    if (value == null) return null;
    if (_claims is EqualUnmodifiableMapView) return _claims;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Profile Information
  @override
  final String? bio;
  @override
  final String? location;
  final List<String>? _skills;
  @override
  List<String>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _interests;
  @override
  List<String>? get interests {
    final value = _interests;
    if (value == null) return null;
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? company;
  @override
  final String? jobTitle;
// Gamification
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final int level;
  final List<String> _badges;
  @override
  @JsonKey()
  List<String> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  @override
  @JsonKey()
  final int needsCreated;
  @override
  @JsonKey()
  final int needsHelped;
  @override
  @JsonKey()
  final int missionsCompleted;
// Settings
  @override
  @JsonKey()
  final bool isDarkMode;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final bool pushNotificationsEnabled;
  @override
  @JsonKey()
  final bool emailNotificationsEnabled;
  @override
  @JsonKey()
  final bool profileVisible;
// Timestamps
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastLoginAt;

  @override
  String toString() {
    return 'User(id: $id, email: $email, displayName: $displayName, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, role: $role, status: $status, azureObjectId: $azureObjectId, accessToken: $accessToken, refreshToken: $refreshToken, tokenExpiry: $tokenExpiry, claims: $claims, bio: $bio, location: $location, skills: $skills, interests: $interests, company: $company, jobTitle: $jobTitle, points: $points, level: $level, badges: $badges, needsCreated: $needsCreated, needsHelped: $needsHelped, missionsCompleted: $missionsCompleted, isDarkMode: $isDarkMode, language: $language, pushNotificationsEnabled: $pushNotificationsEnabled, emailNotificationsEnabled: $emailNotificationsEnabled, profileVisible: $profileVisible, createdAt: $createdAt, updatedAt: $updatedAt, lastLoginAt: $lastLoginAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.azureObjectId, azureObjectId) ||
                other.azureObjectId == azureObjectId) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.tokenExpiry, tokenExpiry) ||
                other.tokenExpiry == tokenExpiry) &&
            const DeepCollectionEquality().equals(other._claims, _claims) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.needsCreated, needsCreated) ||
                other.needsCreated == needsCreated) &&
            (identical(other.needsHelped, needsHelped) ||
                other.needsHelped == needsHelped) &&
            (identical(other.missionsCompleted, missionsCompleted) ||
                other.missionsCompleted == missionsCompleted) &&
            (identical(other.isDarkMode, isDarkMode) ||
                other.isDarkMode == isDarkMode) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(
                    other.pushNotificationsEnabled, pushNotificationsEnabled) ||
                other.pushNotificationsEnabled == pushNotificationsEnabled) &&
            (identical(other.emailNotificationsEnabled,
                    emailNotificationsEnabled) ||
                other.emailNotificationsEnabled == emailNotificationsEnabled) &&
            (identical(other.profileVisible, profileVisible) ||
                other.profileVisible == profileVisible) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        displayName,
        firstName,
        lastName,
        phoneNumber,
        profileImageUrl,
        role,
        status,
        azureObjectId,
        accessToken,
        refreshToken,
        tokenExpiry,
        const DeepCollectionEquality().hash(_claims),
        bio,
        location,
        const DeepCollectionEquality().hash(_skills),
        const DeepCollectionEquality().hash(_interests),
        company,
        jobTitle,
        points,
        level,
        const DeepCollectionEquality().hash(_badges),
        needsCreated,
        needsHelped,
        missionsCompleted,
        isDarkMode,
        language,
        pushNotificationsEnabled,
        emailNotificationsEnabled,
        profileVisible,
        createdAt,
        updatedAt,
        lastLoginAt
      ]);

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String email,
      required final String displayName,
      final String? firstName,
      final String? lastName,
      final String? phoneNumber,
      final String? profileImageUrl,
      required final UserRole role,
      required final UserStatus status,
      final String? azureObjectId,
      final String? accessToken,
      final String? refreshToken,
      final DateTime? tokenExpiry,
      final Map<String, dynamic>? claims,
      final String? bio,
      final String? location,
      final List<String>? skills,
      final List<String>? interests,
      final String? company,
      final String? jobTitle,
      final int points,
      final int level,
      final List<String> badges,
      final int needsCreated,
      final int needsHelped,
      final int missionsCompleted,
      final bool isDarkMode,
      final String language,
      final bool pushNotificationsEnabled,
      final bool emailNotificationsEnabled,
      final bool profileVisible,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? lastLoginAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get displayName;
  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get phoneNumber;
  @override
  String? get profileImageUrl;
  @override
  UserRole get role;
  @override
  UserStatus get status;
  @override
  String? get azureObjectId;
  @override
  String? get accessToken;
  @override
  String? get refreshToken;
  @override
  DateTime? get tokenExpiry;
  @override
  Map<String, dynamic>? get claims; // Profile Information
  @override
  String? get bio;
  @override
  String? get location;
  @override
  List<String>? get skills;
  @override
  List<String>? get interests;
  @override
  String? get company;
  @override
  String? get jobTitle; // Gamification
  @override
  int get points;
  @override
  int get level;
  @override
  List<String> get badges;
  @override
  int get needsCreated;
  @override
  int get needsHelped;
  @override
  int get missionsCompleted; // Settings
  @override
  bool get isDarkMode;
  @override
  String get language;
  @override
  bool get pushNotificationsEnabled;
  @override
  bool get emailNotificationsEnabled;
  @override
  bool get profileVisible; // Timestamps
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastLoginAt;

  /// Create a copy of User
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get userId => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String>? get skills => throw _privateConstructorUsedError;
  List<String>? get interests => throw _privateConstructorUsedError;
  String? get company => throw _privateConstructorUsedError;
  String? get jobTitle => throw _privateConstructorUsedError;
  String? get website => throw _privateConstructorUsedError;
  Map<String, String>? get socialLinks => throw _privateConstructorUsedError;
  List<String>? get certifications => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  int? get reviewCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String userId,
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
      DateTime? updatedAt});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? bio = freezed,
    Object? location = freezed,
    Object? skills = freezed,
    Object? interests = freezed,
    Object? company = freezed,
    Object? jobTitle = freezed,
    Object? website = freezed,
    Object? socialLinks = freezed,
    Object? certifications = freezed,
    Object? rating = freezed,
    Object? reviewCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: freezed == skills
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      interests: freezed == interests
          ? _value.interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      socialLinks: freezed == socialLinks
          ? _value.socialLinks
          : socialLinks // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      certifications: freezed == certifications
          ? _value.certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reviewCount: freezed == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
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
      DateTime? updatedAt});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? bio = freezed,
    Object? location = freezed,
    Object? skills = freezed,
    Object? interests = freezed,
    Object? company = freezed,
    Object? jobTitle = freezed,
    Object? website = freezed,
    Object? socialLinks = freezed,
    Object? certifications = freezed,
    Object? rating = freezed,
    Object? reviewCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserProfileImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      skills: freezed == skills
          ? _value._skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      interests: freezed == interests
          ? _value._interests
          : interests // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      company: freezed == company
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String?,
      jobTitle: freezed == jobTitle
          ? _value.jobTitle
          : jobTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      website: freezed == website
          ? _value.website
          : website // ignore: cast_nullable_to_non_nullable
              as String?,
      socialLinks: freezed == socialLinks
          ? _value._socialLinks
          : socialLinks // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      certifications: freezed == certifications
          ? _value._certifications
          : certifications // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      reviewCount: freezed == reviewCount
          ? _value.reviewCount
          : reviewCount // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {required this.userId,
      this.bio,
      this.location,
      final List<String>? skills,
      final List<String>? interests,
      this.company,
      this.jobTitle,
      this.website,
      final Map<String, String>? socialLinks,
      final List<String>? certifications,
      this.rating,
      this.reviewCount,
      this.createdAt,
      this.updatedAt})
      : _skills = skills,
        _interests = interests,
        _socialLinks = socialLinks,
        _certifications = certifications;

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String userId;
  @override
  final String? bio;
  @override
  final String? location;
  final List<String>? _skills;
  @override
  List<String>? get skills {
    final value = _skills;
    if (value == null) return null;
    if (_skills is EqualUnmodifiableListView) return _skills;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _interests;
  @override
  List<String>? get interests {
    final value = _interests;
    if (value == null) return null;
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? company;
  @override
  final String? jobTitle;
  @override
  final String? website;
  final Map<String, String>? _socialLinks;
  @override
  Map<String, String>? get socialLinks {
    final value = _socialLinks;
    if (value == null) return null;
    if (_socialLinks is EqualUnmodifiableMapView) return _socialLinks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _certifications;
  @override
  List<String>? get certifications {
    final value = _certifications;
    if (value == null) return null;
    if (_certifications is EqualUnmodifiableListView) return _certifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final double? rating;
  @override
  final int? reviewCount;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserProfile(userId: $userId, bio: $bio, location: $location, skills: $skills, interests: $interests, company: $company, jobTitle: $jobTitle, website: $website, socialLinks: $socialLinks, certifications: $certifications, rating: $rating, reviewCount: $reviewCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._skills, _skills) &&
            const DeepCollectionEquality()
                .equals(other._interests, _interests) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.website, website) || other.website == website) &&
            const DeepCollectionEquality()
                .equals(other._socialLinks, _socialLinks) &&
            const DeepCollectionEquality()
                .equals(other._certifications, _certifications) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      bio,
      location,
      const DeepCollectionEquality().hash(_skills),
      const DeepCollectionEquality().hash(_interests),
      company,
      jobTitle,
      website,
      const DeepCollectionEquality().hash(_socialLinks),
      const DeepCollectionEquality().hash(_certifications),
      rating,
      reviewCount,
      createdAt,
      updatedAt);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
      {required final String userId,
      final String? bio,
      final String? location,
      final List<String>? skills,
      final List<String>? interests,
      final String? company,
      final String? jobTitle,
      final String? website,
      final Map<String, String>? socialLinks,
      final List<String>? certifications,
      final double? rating,
      final int? reviewCount,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get userId;
  @override
  String? get bio;
  @override
  String? get location;
  @override
  List<String>? get skills;
  @override
  List<String>? get interests;
  @override
  String? get company;
  @override
  String? get jobTitle;
  @override
  String? get website;
  @override
  Map<String, String>? get socialLinks;
  @override
  List<String>? get certifications;
  @override
  double? get rating;
  @override
  int? get reviewCount;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStatistics _$UserStatisticsFromJson(Map<String, dynamic> json) {
  return _UserStatistics.fromJson(json);
}

/// @nodoc
mixin _$UserStatistics {
  String get userId => throw _privateConstructorUsedError;
  int get totalPoints => throw _privateConstructorUsedError;
  int get currentLevel => throw _privateConstructorUsedError;
  int get needsCreated => throw _privateConstructorUsedError;
  int get needsHelped => throw _privateConstructorUsedError;
  int get needsCompleted => throw _privateConstructorUsedError;
  int get missionsCompleted => throw _privateConstructorUsedError;
  int get badgesEarned => throw _privateConstructorUsedError;
  int get helpRequests => throw _privateConstructorUsedError;
  int get successfulHelps => throw _privateConstructorUsedError;
  double? get helpSuccessRate => throw _privateConstructorUsedError;
  double? get averageRating => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt => throw _privateConstructorUsedError;
  Map<String, int>? get categoryContributions =>
      throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this UserStatistics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatisticsCopyWith<UserStatistics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatisticsCopyWith<$Res> {
  factory $UserStatisticsCopyWith(
          UserStatistics value, $Res Function(UserStatistics) then) =
      _$UserStatisticsCopyWithImpl<$Res, UserStatistics>;
  @useResult
  $Res call(
      {String userId,
      int totalPoints,
      int currentLevel,
      int needsCreated,
      int needsHelped,
      int needsCompleted,
      int missionsCompleted,
      int badgesEarned,
      int helpRequests,
      int successfulHelps,
      double? helpSuccessRate,
      double? averageRating,
      DateTime? lastActivityAt,
      Map<String, int>? categoryContributions,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$UserStatisticsCopyWithImpl<$Res, $Val extends UserStatistics>
    implements $UserStatisticsCopyWith<$Res> {
  _$UserStatisticsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalPoints = null,
    Object? currentLevel = null,
    Object? needsCreated = null,
    Object? needsHelped = null,
    Object? needsCompleted = null,
    Object? missionsCompleted = null,
    Object? badgesEarned = null,
    Object? helpRequests = null,
    Object? successfulHelps = null,
    Object? helpSuccessRate = freezed,
    Object? averageRating = freezed,
    Object? lastActivityAt = freezed,
    Object? categoryContributions = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      needsCreated: null == needsCreated
          ? _value.needsCreated
          : needsCreated // ignore: cast_nullable_to_non_nullable
              as int,
      needsHelped: null == needsHelped
          ? _value.needsHelped
          : needsHelped // ignore: cast_nullable_to_non_nullable
              as int,
      needsCompleted: null == needsCompleted
          ? _value.needsCompleted
          : needsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      missionsCompleted: null == missionsCompleted
          ? _value.missionsCompleted
          : missionsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      badgesEarned: null == badgesEarned
          ? _value.badgesEarned
          : badgesEarned // ignore: cast_nullable_to_non_nullable
              as int,
      helpRequests: null == helpRequests
          ? _value.helpRequests
          : helpRequests // ignore: cast_nullable_to_non_nullable
              as int,
      successfulHelps: null == successfulHelps
          ? _value.successfulHelps
          : successfulHelps // ignore: cast_nullable_to_non_nullable
              as int,
      helpSuccessRate: freezed == helpSuccessRate
          ? _value.helpSuccessRate
          : helpSuccessRate // ignore: cast_nullable_to_non_nullable
              as double?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryContributions: freezed == categoryContributions
          ? _value.categoryContributions
          : categoryContributions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatisticsImplCopyWith<$Res>
    implements $UserStatisticsCopyWith<$Res> {
  factory _$$UserStatisticsImplCopyWith(_$UserStatisticsImpl value,
          $Res Function(_$UserStatisticsImpl) then) =
      __$$UserStatisticsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int totalPoints,
      int currentLevel,
      int needsCreated,
      int needsHelped,
      int needsCompleted,
      int missionsCompleted,
      int badgesEarned,
      int helpRequests,
      int successfulHelps,
      double? helpSuccessRate,
      double? averageRating,
      DateTime? lastActivityAt,
      Map<String, int>? categoryContributions,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$UserStatisticsImplCopyWithImpl<$Res>
    extends _$UserStatisticsCopyWithImpl<$Res, _$UserStatisticsImpl>
    implements _$$UserStatisticsImplCopyWith<$Res> {
  __$$UserStatisticsImplCopyWithImpl(
      _$UserStatisticsImpl _value, $Res Function(_$UserStatisticsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStatistics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? totalPoints = null,
    Object? currentLevel = null,
    Object? needsCreated = null,
    Object? needsHelped = null,
    Object? needsCompleted = null,
    Object? missionsCompleted = null,
    Object? badgesEarned = null,
    Object? helpRequests = null,
    Object? successfulHelps = null,
    Object? helpSuccessRate = freezed,
    Object? averageRating = freezed,
    Object? lastActivityAt = freezed,
    Object? categoryContributions = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$UserStatisticsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      totalPoints: null == totalPoints
          ? _value.totalPoints
          : totalPoints // ignore: cast_nullable_to_non_nullable
              as int,
      currentLevel: null == currentLevel
          ? _value.currentLevel
          : currentLevel // ignore: cast_nullable_to_non_nullable
              as int,
      needsCreated: null == needsCreated
          ? _value.needsCreated
          : needsCreated // ignore: cast_nullable_to_non_nullable
              as int,
      needsHelped: null == needsHelped
          ? _value.needsHelped
          : needsHelped // ignore: cast_nullable_to_non_nullable
              as int,
      needsCompleted: null == needsCompleted
          ? _value.needsCompleted
          : needsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      missionsCompleted: null == missionsCompleted
          ? _value.missionsCompleted
          : missionsCompleted // ignore: cast_nullable_to_non_nullable
              as int,
      badgesEarned: null == badgesEarned
          ? _value.badgesEarned
          : badgesEarned // ignore: cast_nullable_to_non_nullable
              as int,
      helpRequests: null == helpRequests
          ? _value.helpRequests
          : helpRequests // ignore: cast_nullable_to_non_nullable
              as int,
      successfulHelps: null == successfulHelps
          ? _value.successfulHelps
          : successfulHelps // ignore: cast_nullable_to_non_nullable
              as int,
      helpSuccessRate: freezed == helpSuccessRate
          ? _value.helpSuccessRate
          : helpSuccessRate // ignore: cast_nullable_to_non_nullable
              as double?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categoryContributions: freezed == categoryContributions
          ? _value._categoryContributions
          : categoryContributions // ignore: cast_nullable_to_non_nullable
              as Map<String, int>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatisticsImpl implements _UserStatistics {
  const _$UserStatisticsImpl(
      {required this.userId,
      this.totalPoints = 0,
      this.currentLevel = 0,
      this.needsCreated = 0,
      this.needsHelped = 0,
      this.needsCompleted = 0,
      this.missionsCompleted = 0,
      this.badgesEarned = 0,
      this.helpRequests = 0,
      this.successfulHelps = 0,
      this.helpSuccessRate,
      this.averageRating,
      this.lastActivityAt,
      final Map<String, int>? categoryContributions,
      this.createdAt,
      this.updatedAt})
      : _categoryContributions = categoryContributions;

  factory _$UserStatisticsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatisticsImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey()
  final int totalPoints;
  @override
  @JsonKey()
  final int currentLevel;
  @override
  @JsonKey()
  final int needsCreated;
  @override
  @JsonKey()
  final int needsHelped;
  @override
  @JsonKey()
  final int needsCompleted;
  @override
  @JsonKey()
  final int missionsCompleted;
  @override
  @JsonKey()
  final int badgesEarned;
  @override
  @JsonKey()
  final int helpRequests;
  @override
  @JsonKey()
  final int successfulHelps;
  @override
  final double? helpSuccessRate;
  @override
  final double? averageRating;
  @override
  final DateTime? lastActivityAt;
  final Map<String, int>? _categoryContributions;
  @override
  Map<String, int>? get categoryContributions {
    final value = _categoryContributions;
    if (value == null) return null;
    if (_categoryContributions is EqualUnmodifiableMapView)
      return _categoryContributions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'UserStatistics(userId: $userId, totalPoints: $totalPoints, currentLevel: $currentLevel, needsCreated: $needsCreated, needsHelped: $needsHelped, needsCompleted: $needsCompleted, missionsCompleted: $missionsCompleted, badgesEarned: $badgesEarned, helpRequests: $helpRequests, successfulHelps: $successfulHelps, helpSuccessRate: $helpSuccessRate, averageRating: $averageRating, lastActivityAt: $lastActivityAt, categoryContributions: $categoryContributions, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatisticsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.totalPoints, totalPoints) ||
                other.totalPoints == totalPoints) &&
            (identical(other.currentLevel, currentLevel) ||
                other.currentLevel == currentLevel) &&
            (identical(other.needsCreated, needsCreated) ||
                other.needsCreated == needsCreated) &&
            (identical(other.needsHelped, needsHelped) ||
                other.needsHelped == needsHelped) &&
            (identical(other.needsCompleted, needsCompleted) ||
                other.needsCompleted == needsCompleted) &&
            (identical(other.missionsCompleted, missionsCompleted) ||
                other.missionsCompleted == missionsCompleted) &&
            (identical(other.badgesEarned, badgesEarned) ||
                other.badgesEarned == badgesEarned) &&
            (identical(other.helpRequests, helpRequests) ||
                other.helpRequests == helpRequests) &&
            (identical(other.successfulHelps, successfulHelps) ||
                other.successfulHelps == successfulHelps) &&
            (identical(other.helpSuccessRate, helpSuccessRate) ||
                other.helpSuccessRate == helpSuccessRate) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt) &&
            const DeepCollectionEquality()
                .equals(other._categoryContributions, _categoryContributions) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      totalPoints,
      currentLevel,
      needsCreated,
      needsHelped,
      needsCompleted,
      missionsCompleted,
      badgesEarned,
      helpRequests,
      successfulHelps,
      helpSuccessRate,
      averageRating,
      lastActivityAt,
      const DeepCollectionEquality().hash(_categoryContributions),
      createdAt,
      updatedAt);

  /// Create a copy of UserStatistics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatisticsImplCopyWith<_$UserStatisticsImpl> get copyWith =>
      __$$UserStatisticsImplCopyWithImpl<_$UserStatisticsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatisticsImplToJson(
      this,
    );
  }
}

abstract class _UserStatistics implements UserStatistics {
  const factory _UserStatistics(
      {required final String userId,
      final int totalPoints,
      final int currentLevel,
      final int needsCreated,
      final int needsHelped,
      final int needsCompleted,
      final int missionsCompleted,
      final int badgesEarned,
      final int helpRequests,
      final int successfulHelps,
      final double? helpSuccessRate,
      final double? averageRating,
      final DateTime? lastActivityAt,
      final Map<String, int>? categoryContributions,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$UserStatisticsImpl;

  factory _UserStatistics.fromJson(Map<String, dynamic> json) =
      _$UserStatisticsImpl.fromJson;

  @override
  String get userId;
  @override
  int get totalPoints;
  @override
  int get currentLevel;
  @override
  int get needsCreated;
  @override
  int get needsHelped;
  @override
  int get needsCompleted;
  @override
  int get missionsCompleted;
  @override
  int get badgesEarned;
  @override
  int get helpRequests;
  @override
  int get successfulHelps;
  @override
  double? get helpSuccessRate;
  @override
  double? get averageRating;
  @override
  DateTime? get lastActivityAt;
  @override
  Map<String, int>? get categoryContributions;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of UserStatistics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatisticsImplCopyWith<_$UserStatisticsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
