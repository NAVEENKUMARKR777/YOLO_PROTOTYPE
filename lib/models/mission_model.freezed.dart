// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Mission _$MissionFromJson(Map<String, dynamic> json) {
  return _Mission.fromJson(json);
}

/// @nodoc
mixin _$Mission {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  MissionType get type => throw _privateConstructorUsedError;
  MissionStatus get status => throw _privateConstructorUsedError;
  MissionAction get action => throw _privateConstructorUsedError;
  int get target => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;
  int get reward => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get claimedAt => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  List<String>? get prerequisites => throw _privateConstructorUsedError;
  Map<String, dynamic>? get rewards => throw _privateConstructorUsedError;

  /// Serializes this Mission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionCopyWith<Mission> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionCopyWith<$Res> {
  factory $MissionCopyWith(Mission value, $Res Function(Mission) then) =
      _$MissionCopyWithImpl<$Res, Mission>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      MissionType type,
      MissionStatus status,
      MissionAction action,
      int target,
      int progress,
      int reward,
      String? userId,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? claimedAt,
      DateTime? deadline,
      String? category,
      List<String>? prerequisites,
      Map<String, dynamic>? rewards});
}

/// @nodoc
class _$MissionCopyWithImpl<$Res, $Val extends Mission>
    implements $MissionCopyWith<$Res> {
  _$MissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? status = null,
    Object? action = freezed,
    Object? target = null,
    Object? progress = null,
    Object? reward = null,
    Object? userId = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? claimedAt = freezed,
    Object? deadline = freezed,
    Object? category = freezed,
    Object? prerequisites = freezed,
    Object? rewards = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MissionType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MissionStatus,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as MissionAction,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      reward: null == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      claimedAt: freezed == claimedAt
          ? _value.claimedAt
          : claimedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      prerequisites: freezed == prerequisites
          ? _value.prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rewards: freezed == rewards
          ? _value.rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissionImplCopyWith<$Res> implements $MissionCopyWith<$Res> {
  factory _$$MissionImplCopyWith(
          _$MissionImpl value, $Res Function(_$MissionImpl) then) =
      __$$MissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      MissionType type,
      MissionStatus status,
      MissionAction action,
      int target,
      int progress,
      int reward,
      String? userId,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? claimedAt,
      DateTime? deadline,
      String? category,
      List<String>? prerequisites,
      Map<String, dynamic>? rewards});
}

/// @nodoc
class __$$MissionImplCopyWithImpl<$Res>
    extends _$MissionCopyWithImpl<$Res, _$MissionImpl>
    implements _$$MissionImplCopyWith<$Res> {
  __$$MissionImplCopyWithImpl(
      _$MissionImpl _value, $Res Function(_$MissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? status = null,
    Object? action = freezed,
    Object? target = null,
    Object? progress = null,
    Object? reward = null,
    Object? userId = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? claimedAt = freezed,
    Object? deadline = freezed,
    Object? category = freezed,
    Object? prerequisites = freezed,
    Object? rewards = freezed,
  }) {
    return _then(_$MissionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MissionType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MissionStatus,
      action: freezed == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as MissionAction,
      target: null == target
          ? _value.target
          : target // ignore: cast_nullable_to_non_nullable
              as int,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      reward: null == reward
          ? _value.reward
          : reward // ignore: cast_nullable_to_non_nullable
              as int,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      claimedAt: freezed == claimedAt
          ? _value.claimedAt
          : claimedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      prerequisites: freezed == prerequisites
          ? _value._prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      rewards: freezed == rewards
          ? _value._rewards
          : rewards // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionImpl implements _Mission {
  const _$MissionImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.status,
      required this.action,
      required this.target,
      required this.progress,
      required this.reward,
      this.userId,
      this.startedAt,
      this.completedAt,
      this.claimedAt,
      this.deadline,
      this.category,
      final List<String>? prerequisites,
      final Map<String, dynamic>? rewards})
      : _prerequisites = prerequisites,
        _rewards = rewards;

  factory _$MissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final MissionType type;
  @override
  final MissionStatus status;
  @override
  final MissionAction action;
  @override
  final int target;
  @override
  final int progress;
  @override
  final int reward;
  @override
  final String? userId;
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? claimedAt;
  @override
  final DateTime? deadline;
  @override
  final String? category;
  final List<String>? _prerequisites;
  @override
  List<String>? get prerequisites {
    final value = _prerequisites;
    if (value == null) return null;
    if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _rewards;
  @override
  Map<String, dynamic>? get rewards {
    final value = _rewards;
    if (value == null) return null;
    if (_rewards is EqualUnmodifiableMapView) return _rewards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Mission(id: $id, title: $title, description: $description, type: $type, status: $status, action: $action, target: $target, progress: $progress, reward: $reward, userId: $userId, startedAt: $startedAt, completedAt: $completedAt, claimedAt: $claimedAt, deadline: $deadline, category: $category, prerequisites: $prerequisites, rewards: $rewards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.action, action) &&
            (identical(other.target, target) || other.target == target) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.reward, reward) || other.reward == reward) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.claimedAt, claimedAt) ||
                other.claimedAt == claimedAt) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality()
                .equals(other._prerequisites, _prerequisites) &&
            const DeepCollectionEquality().equals(other._rewards, _rewards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      status,
      const DeepCollectionEquality().hash(action),
      target,
      progress,
      reward,
      userId,
      startedAt,
      completedAt,
      claimedAt,
      deadline,
      category,
      const DeepCollectionEquality().hash(_prerequisites),
      const DeepCollectionEquality().hash(_rewards));

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      __$$MissionImplCopyWithImpl<_$MissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionImplToJson(
      this,
    );
  }
}

abstract class _Mission implements Mission {
  const factory _Mission(
      {required final String id,
      required final String title,
      required final String description,
      required final MissionType type,
      required final MissionStatus status,
      required final MissionAction action,
      required final int target,
      required final int progress,
      required final int reward,
      final String? userId,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final DateTime? claimedAt,
      final DateTime? deadline,
      final String? category,
      final List<String>? prerequisites,
      final Map<String, dynamic>? rewards}) = _$MissionImpl;

  factory _Mission.fromJson(Map<String, dynamic> json) = _$MissionImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  MissionType get type;
  @override
  MissionStatus get status;
  @override
  MissionAction get action;
  @override
  int get target;
  @override
  int get progress;
  @override
  int get reward;
  @override
  String? get userId;
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get claimedAt;
  @override
  DateTime? get deadline;
  @override
  String? get category;
  @override
  List<String>? get prerequisites;
  @override
  Map<String, dynamic>? get rewards;

  /// Create a copy of Mission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionImplCopyWith<_$MissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MissionObjective _$MissionObjectiveFromJson(Map<String, dynamic> json) {
  return _MissionObjective.fromJson(json);
}

/// @nodoc
mixin _$MissionObjective {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get targetValue => throw _privateConstructorUsedError;
  int get currentValue => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  Map<String, dynamic>? get parameters => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this MissionObjective to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MissionObjective
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MissionObjectiveCopyWith<MissionObjective> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MissionObjectiveCopyWith<$Res> {
  factory $MissionObjectiveCopyWith(
          MissionObjective value, $Res Function(MissionObjective) then) =
      _$MissionObjectiveCopyWithImpl<$Res, MissionObjective>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String type,
      int targetValue,
      int currentValue,
      bool isCompleted,
      Map<String, dynamic>? parameters,
      DateTime? completedAt});
}

/// @nodoc
class _$MissionObjectiveCopyWithImpl<$Res, $Val extends MissionObjective>
    implements $MissionObjectiveCopyWith<$Res> {
  _$MissionObjectiveCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MissionObjective
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? isCompleted = null,
    Object? parameters = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      parameters: freezed == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MissionObjectiveImplCopyWith<$Res>
    implements $MissionObjectiveCopyWith<$Res> {
  factory _$$MissionObjectiveImplCopyWith(_$MissionObjectiveImpl value,
          $Res Function(_$MissionObjectiveImpl) then) =
      __$$MissionObjectiveImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String type,
      int targetValue,
      int currentValue,
      bool isCompleted,
      Map<String, dynamic>? parameters,
      DateTime? completedAt});
}

/// @nodoc
class __$$MissionObjectiveImplCopyWithImpl<$Res>
    extends _$MissionObjectiveCopyWithImpl<$Res, _$MissionObjectiveImpl>
    implements _$$MissionObjectiveImplCopyWith<$Res> {
  __$$MissionObjectiveImplCopyWithImpl(_$MissionObjectiveImpl _value,
      $Res Function(_$MissionObjectiveImpl) _then)
      : super(_value, _then);

  /// Create a copy of MissionObjective
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? targetValue = null,
    Object? currentValue = null,
    Object? isCompleted = null,
    Object? parameters = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$MissionObjectiveImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      targetValue: null == targetValue
          ? _value.targetValue
          : targetValue // ignore: cast_nullable_to_non_nullable
              as int,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as int,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      parameters: freezed == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MissionObjectiveImpl implements _MissionObjective {
  const _$MissionObjectiveImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.targetValue,
      this.currentValue = 0,
      this.isCompleted = false,
      final Map<String, dynamic>? parameters,
      this.completedAt})
      : _parameters = parameters;

  factory _$MissionObjectiveImpl.fromJson(Map<String, dynamic> json) =>
      _$$MissionObjectiveImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String type;
  @override
  final int targetValue;
  @override
  @JsonKey()
  final int currentValue;
  @override
  @JsonKey()
  final bool isCompleted;
  final Map<String, dynamic>? _parameters;
  @override
  Map<String, dynamic>? get parameters {
    final value = _parameters;
    if (value == null) return null;
    if (_parameters is EqualUnmodifiableMapView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'MissionObjective(id: $id, title: $title, description: $description, type: $type, targetValue: $targetValue, currentValue: $currentValue, isCompleted: $isCompleted, parameters: $parameters, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MissionObjectiveImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.targetValue, targetValue) ||
                other.targetValue == targetValue) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      targetValue,
      currentValue,
      isCompleted,
      const DeepCollectionEquality().hash(_parameters),
      completedAt);

  /// Create a copy of MissionObjective
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MissionObjectiveImplCopyWith<_$MissionObjectiveImpl> get copyWith =>
      __$$MissionObjectiveImplCopyWithImpl<_$MissionObjectiveImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MissionObjectiveImplToJson(
      this,
    );
  }
}

abstract class _MissionObjective implements MissionObjective {
  const factory _MissionObjective(
      {required final String id,
      required final String title,
      required final String description,
      required final String type,
      required final int targetValue,
      final int currentValue,
      final bool isCompleted,
      final Map<String, dynamic>? parameters,
      final DateTime? completedAt}) = _$MissionObjectiveImpl;

  factory _MissionObjective.fromJson(Map<String, dynamic> json) =
      _$MissionObjectiveImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get type;
  @override
  int get targetValue;
  @override
  int get currentValue;
  @override
  bool get isCompleted;
  @override
  Map<String, dynamic>? get parameters;
  @override
  DateTime? get completedAt;

  /// Create a copy of MissionObjective
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MissionObjectiveImplCopyWith<_$MissionObjectiveImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserMission _$UserMissionFromJson(Map<String, dynamic> json) {
  return _UserMission.fromJson(json);
}

/// @nodoc
mixin _$UserMission {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get missionId => throw _privateConstructorUsedError;
  MissionStatus get status => throw _privateConstructorUsedError; // Progress
  double get progressPercentage => throw _privateConstructorUsedError;
  Map<String, dynamic>? get progressData => throw _privateConstructorUsedError;
  List<String>? get completedObjectives =>
      throw _privateConstructorUsedError; // Timing
  DateTime? get startedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError; // Rewards
  bool get rewardsClaimed => throw _privateConstructorUsedError;
  DateTime? get rewardsClaimedAt =>
      throw _privateConstructorUsedError; // Metadata
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this UserMission to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserMission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserMissionCopyWith<UserMission> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserMissionCopyWith<$Res> {
  factory $UserMissionCopyWith(
          UserMission value, $Res Function(UserMission) then) =
      _$UserMissionCopyWithImpl<$Res, UserMission>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String missionId,
      MissionStatus status,
      double progressPercentage,
      Map<String, dynamic>? progressData,
      List<String>? completedObjectives,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? expiresAt,
      bool rewardsClaimed,
      DateTime? rewardsClaimedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$UserMissionCopyWithImpl<$Res, $Val extends UserMission>
    implements $UserMissionCopyWith<$Res> {
  _$UserMissionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserMission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? missionId = null,
    Object? status = null,
    Object? progressPercentage = null,
    Object? progressData = freezed,
    Object? completedObjectives = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? expiresAt = freezed,
    Object? rewardsClaimed = null,
    Object? rewardsClaimedAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      missionId: null == missionId
          ? _value.missionId
          : missionId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MissionStatus,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      progressData: freezed == progressData
          ? _value.progressData
          : progressData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      completedObjectives: freezed == completedObjectives
          ? _value.completedObjectives
          : completedObjectives // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rewardsClaimed: null == rewardsClaimed
          ? _value.rewardsClaimed
          : rewardsClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      rewardsClaimedAt: freezed == rewardsClaimedAt
          ? _value.rewardsClaimedAt
          : rewardsClaimedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMissionImplCopyWith<$Res>
    implements $UserMissionCopyWith<$Res> {
  factory _$$UserMissionImplCopyWith(
          _$UserMissionImpl value, $Res Function(_$UserMissionImpl) then) =
      __$$UserMissionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String missionId,
      MissionStatus status,
      double progressPercentage,
      Map<String, dynamic>? progressData,
      List<String>? completedObjectives,
      DateTime? startedAt,
      DateTime? completedAt,
      DateTime? expiresAt,
      bool rewardsClaimed,
      DateTime? rewardsClaimedAt,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$UserMissionImplCopyWithImpl<$Res>
    extends _$UserMissionCopyWithImpl<$Res, _$UserMissionImpl>
    implements _$$UserMissionImplCopyWith<$Res> {
  __$$UserMissionImplCopyWithImpl(
      _$UserMissionImpl _value, $Res Function(_$UserMissionImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserMission
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? missionId = null,
    Object? status = null,
    Object? progressPercentage = null,
    Object? progressData = freezed,
    Object? completedObjectives = freezed,
    Object? startedAt = freezed,
    Object? completedAt = freezed,
    Object? expiresAt = freezed,
    Object? rewardsClaimed = null,
    Object? rewardsClaimedAt = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$UserMissionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      missionId: null == missionId
          ? _value.missionId
          : missionId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as MissionStatus,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
      progressData: freezed == progressData
          ? _value._progressData
          : progressData // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      completedObjectives: freezed == completedObjectives
          ? _value._completedObjectives
          : completedObjectives // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      startedAt: freezed == startedAt
          ? _value.startedAt
          : startedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      rewardsClaimed: null == rewardsClaimed
          ? _value.rewardsClaimed
          : rewardsClaimed // ignore: cast_nullable_to_non_nullable
              as bool,
      rewardsClaimedAt: freezed == rewardsClaimedAt
          ? _value.rewardsClaimedAt
          : rewardsClaimedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserMissionImpl implements _UserMission {
  const _$UserMissionImpl(
      {required this.id,
      required this.userId,
      required this.missionId,
      required this.status,
      this.progressPercentage = 0,
      final Map<String, dynamic>? progressData,
      final List<String>? completedObjectives,
      this.startedAt,
      this.completedAt,
      this.expiresAt,
      this.rewardsClaimed = false,
      this.rewardsClaimedAt,
      final Map<String, dynamic>? metadata})
      : _progressData = progressData,
        _completedObjectives = completedObjectives,
        _metadata = metadata;

  factory _$UserMissionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserMissionImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String missionId;
  @override
  final MissionStatus status;
// Progress
  @override
  @JsonKey()
  final double progressPercentage;
  final Map<String, dynamic>? _progressData;
  @override
  Map<String, dynamic>? get progressData {
    final value = _progressData;
    if (value == null) return null;
    if (_progressData is EqualUnmodifiableMapView) return _progressData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _completedObjectives;
  @override
  List<String>? get completedObjectives {
    final value = _completedObjectives;
    if (value == null) return null;
    if (_completedObjectives is EqualUnmodifiableListView)
      return _completedObjectives;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// Timing
  @override
  final DateTime? startedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? expiresAt;
// Rewards
  @override
  @JsonKey()
  final bool rewardsClaimed;
  @override
  final DateTime? rewardsClaimedAt;
// Metadata
  final Map<String, dynamic>? _metadata;
// Metadata
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'UserMission(id: $id, userId: $userId, missionId: $missionId, status: $status, progressPercentage: $progressPercentage, progressData: $progressData, completedObjectives: $completedObjectives, startedAt: $startedAt, completedAt: $completedAt, expiresAt: $expiresAt, rewardsClaimed: $rewardsClaimed, rewardsClaimedAt: $rewardsClaimedAt, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMissionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.missionId, missionId) ||
                other.missionId == missionId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage) &&
            const DeepCollectionEquality()
                .equals(other._progressData, _progressData) &&
            const DeepCollectionEquality()
                .equals(other._completedObjectives, _completedObjectives) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.rewardsClaimed, rewardsClaimed) ||
                other.rewardsClaimed == rewardsClaimed) &&
            (identical(other.rewardsClaimedAt, rewardsClaimedAt) ||
                other.rewardsClaimedAt == rewardsClaimedAt) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      missionId,
      status,
      progressPercentage,
      const DeepCollectionEquality().hash(_progressData),
      const DeepCollectionEquality().hash(_completedObjectives),
      startedAt,
      completedAt,
      expiresAt,
      rewardsClaimed,
      rewardsClaimedAt,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of UserMission
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMissionImplCopyWith<_$UserMissionImpl> get copyWith =>
      __$$UserMissionImplCopyWithImpl<_$UserMissionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserMissionImplToJson(
      this,
    );
  }
}

abstract class _UserMission implements UserMission {
  const factory _UserMission(
      {required final String id,
      required final String userId,
      required final String missionId,
      required final MissionStatus status,
      final double progressPercentage,
      final Map<String, dynamic>? progressData,
      final List<String>? completedObjectives,
      final DateTime? startedAt,
      final DateTime? completedAt,
      final DateTime? expiresAt,
      final bool rewardsClaimed,
      final DateTime? rewardsClaimedAt,
      final Map<String, dynamic>? metadata}) = _$UserMissionImpl;

  factory _UserMission.fromJson(Map<String, dynamic> json) =
      _$UserMissionImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get missionId;
  @override
  MissionStatus get status; // Progress
  @override
  double get progressPercentage;
  @override
  Map<String, dynamic>? get progressData;
  @override
  List<String>? get completedObjectives; // Timing
  @override
  DateTime? get startedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get expiresAt; // Rewards
  @override
  bool get rewardsClaimed;
  @override
  DateTime? get rewardsClaimedAt; // Metadata
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of UserMission
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserMissionImplCopyWith<_$UserMissionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Badge _$BadgeFromJson(Map<String, dynamic> json) {
  return _Badge.fromJson(json);
}

/// @nodoc
mixin _$Badge {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  BadgeType get type => throw _privateConstructorUsedError;
  BadgeTier get tier => throw _privateConstructorUsedError;
  BadgeCategory get category => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  DateTime? get earnedAt => throw _privateConstructorUsedError;
  bool? get isUnlocked => throw _privateConstructorUsedError;

  /// Serializes this Badge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BadgeCopyWith<Badge> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BadgeCopyWith<$Res> {
  factory $BadgeCopyWith(Badge value, $Res Function(Badge) then) =
      _$BadgeCopyWithImpl<$Res, Badge>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      BadgeType type,
      BadgeTier tier,
      BadgeCategory category,
      int points,
      String? iconUrl,
      String? color,
      DateTime? earnedAt,
      bool? isUnlocked});
}

/// @nodoc
class _$BadgeCopyWithImpl<$Res, $Val extends Badge>
    implements $BadgeCopyWith<$Res> {
  _$BadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? tier = freezed,
    Object? category = freezed,
    Object? points = null,
    Object? iconUrl = freezed,
    Object? color = freezed,
    Object? earnedAt = freezed,
    Object? isUnlocked = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BadgeType,
      tier: freezed == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as BadgeTier,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as BadgeCategory,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      earnedAt: freezed == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isUnlocked: freezed == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BadgeImplCopyWith<$Res> implements $BadgeCopyWith<$Res> {
  factory _$$BadgeImplCopyWith(
          _$BadgeImpl value, $Res Function(_$BadgeImpl) then) =
      __$$BadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      BadgeType type,
      BadgeTier tier,
      BadgeCategory category,
      int points,
      String? iconUrl,
      String? color,
      DateTime? earnedAt,
      bool? isUnlocked});
}

/// @nodoc
class __$$BadgeImplCopyWithImpl<$Res>
    extends _$BadgeCopyWithImpl<$Res, _$BadgeImpl>
    implements _$$BadgeImplCopyWith<$Res> {
  __$$BadgeImplCopyWithImpl(
      _$BadgeImpl _value, $Res Function(_$BadgeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? tier = freezed,
    Object? category = freezed,
    Object? points = null,
    Object? iconUrl = freezed,
    Object? color = freezed,
    Object? earnedAt = freezed,
    Object? isUnlocked = freezed,
  }) {
    return _then(_$BadgeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as BadgeType,
      tier: freezed == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as BadgeTier,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as BadgeCategory,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      earnedAt: freezed == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isUnlocked: freezed == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BadgeImpl implements _Badge {
  const _$BadgeImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.tier,
      required this.category,
      required this.points,
      this.iconUrl,
      this.color,
      this.earnedAt,
      this.isUnlocked});

  factory _$BadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$BadgeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final BadgeType type;
  @override
  final BadgeTier tier;
  @override
  final BadgeCategory category;
  @override
  final int points;
  @override
  final String? iconUrl;
  @override
  final String? color;
  @override
  final DateTime? earnedAt;
  @override
  final bool? isUnlocked;

  @override
  String toString() {
    return 'Badge(id: $id, title: $title, description: $description, type: $type, tier: $tier, category: $category, points: $points, iconUrl: $iconUrl, color: $color, earnedAt: $earnedAt, isUnlocked: $isUnlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BadgeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.tier, tier) &&
            const DeepCollectionEquality().equals(other.category, category) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      const DeepCollectionEquality().hash(tier),
      const DeepCollectionEquality().hash(category),
      points,
      iconUrl,
      color,
      earnedAt,
      isUnlocked);

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BadgeImplCopyWith<_$BadgeImpl> get copyWith =>
      __$$BadgeImplCopyWithImpl<_$BadgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BadgeImplToJson(
      this,
    );
  }
}

abstract class _Badge implements Badge {
  const factory _Badge(
      {required final String id,
      required final String title,
      required final String description,
      required final BadgeType type,
      required final BadgeTier tier,
      required final BadgeCategory category,
      required final int points,
      final String? iconUrl,
      final String? color,
      final DateTime? earnedAt,
      final bool? isUnlocked}) = _$BadgeImpl;

  factory _Badge.fromJson(Map<String, dynamic> json) = _$BadgeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  BadgeType get type;
  @override
  BadgeTier get tier;
  @override
  BadgeCategory get category;
  @override
  int get points;
  @override
  String? get iconUrl;
  @override
  String? get color;
  @override
  DateTime? get earnedAt;
  @override
  bool? get isUnlocked;

  /// Create a copy of Badge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BadgeImplCopyWith<_$BadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserBadge _$UserBadgeFromJson(Map<String, dynamic> json) {
  return _UserBadge.fromJson(json);
}

/// @nodoc
mixin _$UserBadge {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get badgeId => throw _privateConstructorUsedError;
  DateTime get earnedAt => throw _privateConstructorUsedError;
  String? get earnedFor => throw _privateConstructorUsedError;
  Map<String, dynamic>? get context => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  bool get isVisible => throw _privateConstructorUsedError;

  /// Serializes this UserBadge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserBadgeCopyWith<UserBadge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBadgeCopyWith<$Res> {
  factory $UserBadgeCopyWith(UserBadge value, $Res Function(UserBadge) then) =
      _$UserBadgeCopyWithImpl<$Res, UserBadge>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String badgeId,
      DateTime earnedAt,
      String? earnedFor,
      Map<String, dynamic>? context,
      bool isFavorite,
      bool isVisible});
}

/// @nodoc
class _$UserBadgeCopyWithImpl<$Res, $Val extends UserBadge>
    implements $UserBadgeCopyWith<$Res> {
  _$UserBadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? badgeId = null,
    Object? earnedAt = null,
    Object? earnedFor = freezed,
    Object? context = freezed,
    Object? isFavorite = null,
    Object? isVisible = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      badgeId: null == badgeId
          ? _value.badgeId
          : badgeId // ignore: cast_nullable_to_non_nullable
              as String,
      earnedAt: null == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      earnedFor: freezed == earnedFor
          ? _value.earnedFor
          : earnedFor // ignore: cast_nullable_to_non_nullable
              as String?,
      context: freezed == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserBadgeImplCopyWith<$Res>
    implements $UserBadgeCopyWith<$Res> {
  factory _$$UserBadgeImplCopyWith(
          _$UserBadgeImpl value, $Res Function(_$UserBadgeImpl) then) =
      __$$UserBadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String badgeId,
      DateTime earnedAt,
      String? earnedFor,
      Map<String, dynamic>? context,
      bool isFavorite,
      bool isVisible});
}

/// @nodoc
class __$$UserBadgeImplCopyWithImpl<$Res>
    extends _$UserBadgeCopyWithImpl<$Res, _$UserBadgeImpl>
    implements _$$UserBadgeImplCopyWith<$Res> {
  __$$UserBadgeImplCopyWithImpl(
      _$UserBadgeImpl _value, $Res Function(_$UserBadgeImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? badgeId = null,
    Object? earnedAt = null,
    Object? earnedFor = freezed,
    Object? context = freezed,
    Object? isFavorite = null,
    Object? isVisible = null,
  }) {
    return _then(_$UserBadgeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      badgeId: null == badgeId
          ? _value.badgeId
          : badgeId // ignore: cast_nullable_to_non_nullable
              as String,
      earnedAt: null == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      earnedFor: freezed == earnedFor
          ? _value.earnedFor
          : earnedFor // ignore: cast_nullable_to_non_nullable
              as String?,
      context: freezed == context
          ? _value._context
          : context // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      isVisible: null == isVisible
          ? _value.isVisible
          : isVisible // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserBadgeImpl implements _UserBadge {
  const _$UserBadgeImpl(
      {required this.id,
      required this.userId,
      required this.badgeId,
      required this.earnedAt,
      this.earnedFor,
      final Map<String, dynamic>? context,
      this.isFavorite = false,
      this.isVisible = true})
      : _context = context;

  factory _$UserBadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserBadgeImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String badgeId;
  @override
  final DateTime earnedAt;
  @override
  final String? earnedFor;
  final Map<String, dynamic>? _context;
  @override
  Map<String, dynamic>? get context {
    final value = _context;
    if (value == null) return null;
    if (_context is EqualUnmodifiableMapView) return _context;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final bool isFavorite;
  @override
  @JsonKey()
  final bool isVisible;

  @override
  String toString() {
    return 'UserBadge(id: $id, userId: $userId, badgeId: $badgeId, earnedAt: $earnedAt, earnedFor: $earnedFor, context: $context, isFavorite: $isFavorite, isVisible: $isVisible)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserBadgeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt) &&
            (identical(other.earnedFor, earnedFor) ||
                other.earnedFor == earnedFor) &&
            const DeepCollectionEquality().equals(other._context, _context) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.isVisible, isVisible) ||
                other.isVisible == isVisible));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      badgeId,
      earnedAt,
      earnedFor,
      const DeepCollectionEquality().hash(_context),
      isFavorite,
      isVisible);

  /// Create a copy of UserBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserBadgeImplCopyWith<_$UserBadgeImpl> get copyWith =>
      __$$UserBadgeImplCopyWithImpl<_$UserBadgeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserBadgeImplToJson(
      this,
    );
  }
}

abstract class _UserBadge implements UserBadge {
  const factory _UserBadge(
      {required final String id,
      required final String userId,
      required final String badgeId,
      required final DateTime earnedAt,
      final String? earnedFor,
      final Map<String, dynamic>? context,
      final bool isFavorite,
      final bool isVisible}) = _$UserBadgeImpl;

  factory _UserBadge.fromJson(Map<String, dynamic> json) =
      _$UserBadgeImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get badgeId;
  @override
  DateTime get earnedAt;
  @override
  String? get earnedFor;
  @override
  Map<String, dynamic>? get context;
  @override
  bool get isFavorite;
  @override
  bool get isVisible;

  /// Create a copy of UserBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserBadgeImplCopyWith<_$UserBadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Leaderboard _$LeaderboardFromJson(Map<String, dynamic> json) {
  return _Leaderboard.fromJson(json);
}

/// @nodoc
mixin _$Leaderboard {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  List<LeaderboardEntry> get entries =>
      throw _privateConstructorUsedError; // Configuration
  int get maxEntries => throw _privateConstructorUsedError;
  List<String>? get eligibleRoles => throw _privateConstructorUsedError;
  Map<String, dynamic>? get criteria =>
      throw _privateConstructorUsedError; // Timing
  DateTime? get startDate => throw _privateConstructorUsedError;
  DateTime? get endDate => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError; // Metadata
  String? get description => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this Leaderboard to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Leaderboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardCopyWith<Leaderboard> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardCopyWith<$Res> {
  factory $LeaderboardCopyWith(
          Leaderboard value, $Res Function(Leaderboard) then) =
      _$LeaderboardCopyWithImpl<$Res, Leaderboard>;
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String period,
      List<LeaderboardEntry> entries,
      int maxEntries,
      List<String>? eligibleRoles,
      Map<String, dynamic>? criteria,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? lastUpdated,
      String? description,
      String? iconUrl,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class _$LeaderboardCopyWithImpl<$Res, $Val extends Leaderboard>
    implements $LeaderboardCopyWith<$Res> {
  _$LeaderboardCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Leaderboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? period = null,
    Object? entries = null,
    Object? maxEntries = null,
    Object? eligibleRoles = freezed,
    Object? criteria = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? lastUpdated = freezed,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value.entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardEntry>,
      maxEntries: null == maxEntries
          ? _value.maxEntries
          : maxEntries // ignore: cast_nullable_to_non_nullable
              as int,
      eligibleRoles: freezed == eligibleRoles
          ? _value.eligibleRoles
          : eligibleRoles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      criteria: freezed == criteria
          ? _value.criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderboardImplCopyWith<$Res>
    implements $LeaderboardCopyWith<$Res> {
  factory _$$LeaderboardImplCopyWith(
          _$LeaderboardImpl value, $Res Function(_$LeaderboardImpl) then) =
      __$$LeaderboardImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String type,
      String period,
      List<LeaderboardEntry> entries,
      int maxEntries,
      List<String>? eligibleRoles,
      Map<String, dynamic>? criteria,
      DateTime? startDate,
      DateTime? endDate,
      DateTime? lastUpdated,
      String? description,
      String? iconUrl,
      Map<String, dynamic>? metadata});
}

/// @nodoc
class __$$LeaderboardImplCopyWithImpl<$Res>
    extends _$LeaderboardCopyWithImpl<$Res, _$LeaderboardImpl>
    implements _$$LeaderboardImplCopyWith<$Res> {
  __$$LeaderboardImplCopyWithImpl(
      _$LeaderboardImpl _value, $Res Function(_$LeaderboardImpl) _then)
      : super(_value, _then);

  /// Create a copy of Leaderboard
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? type = null,
    Object? period = null,
    Object? entries = null,
    Object? maxEntries = null,
    Object? eligibleRoles = freezed,
    Object? criteria = freezed,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? lastUpdated = freezed,
    Object? description = freezed,
    Object? iconUrl = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$LeaderboardImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      entries: null == entries
          ? _value._entries
          : entries // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardEntry>,
      maxEntries: null == maxEntries
          ? _value.maxEntries
          : maxEntries // ignore: cast_nullable_to_non_nullable
              as int,
      eligibleRoles: freezed == eligibleRoles
          ? _value._eligibleRoles
          : eligibleRoles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      criteria: freezed == criteria
          ? _value._criteria
          : criteria // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDate: freezed == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardImpl implements _Leaderboard {
  const _$LeaderboardImpl(
      {required this.id,
      required this.name,
      required this.type,
      required this.period,
      required final List<LeaderboardEntry> entries,
      this.maxEntries = 100,
      final List<String>? eligibleRoles,
      final Map<String, dynamic>? criteria,
      this.startDate,
      this.endDate,
      this.lastUpdated,
      this.description,
      this.iconUrl,
      final Map<String, dynamic>? metadata})
      : _entries = entries,
        _eligibleRoles = eligibleRoles,
        _criteria = criteria,
        _metadata = metadata;

  factory _$LeaderboardImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String type;
  @override
  final String period;
  final List<LeaderboardEntry> _entries;
  @override
  List<LeaderboardEntry> get entries {
    if (_entries is EqualUnmodifiableListView) return _entries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entries);
  }

// Configuration
  @override
  @JsonKey()
  final int maxEntries;
  final List<String>? _eligibleRoles;
  @override
  List<String>? get eligibleRoles {
    final value = _eligibleRoles;
    if (value == null) return null;
    if (_eligibleRoles is EqualUnmodifiableListView) return _eligibleRoles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _criteria;
  @override
  Map<String, dynamic>? get criteria {
    final value = _criteria;
    if (value == null) return null;
    if (_criteria is EqualUnmodifiableMapView) return _criteria;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

// Timing
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final DateTime? lastUpdated;
// Metadata
  @override
  final String? description;
  @override
  final String? iconUrl;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Leaderboard(id: $id, name: $name, type: $type, period: $period, entries: $entries, maxEntries: $maxEntries, eligibleRoles: $eligibleRoles, criteria: $criteria, startDate: $startDate, endDate: $endDate, lastUpdated: $lastUpdated, description: $description, iconUrl: $iconUrl, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.period, period) || other.period == period) &&
            const DeepCollectionEquality().equals(other._entries, _entries) &&
            (identical(other.maxEntries, maxEntries) ||
                other.maxEntries == maxEntries) &&
            const DeepCollectionEquality()
                .equals(other._eligibleRoles, _eligibleRoles) &&
            const DeepCollectionEquality().equals(other._criteria, _criteria) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      type,
      period,
      const DeepCollectionEquality().hash(_entries),
      maxEntries,
      const DeepCollectionEquality().hash(_eligibleRoles),
      const DeepCollectionEquality().hash(_criteria),
      startDate,
      endDate,
      lastUpdated,
      description,
      iconUrl,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of Leaderboard
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardImplCopyWith<_$LeaderboardImpl> get copyWith =>
      __$$LeaderboardImplCopyWithImpl<_$LeaderboardImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardImplToJson(
      this,
    );
  }
}

abstract class _Leaderboard implements Leaderboard {
  const factory _Leaderboard(
      {required final String id,
      required final String name,
      required final String type,
      required final String period,
      required final List<LeaderboardEntry> entries,
      final int maxEntries,
      final List<String>? eligibleRoles,
      final Map<String, dynamic>? criteria,
      final DateTime? startDate,
      final DateTime? endDate,
      final DateTime? lastUpdated,
      final String? description,
      final String? iconUrl,
      final Map<String, dynamic>? metadata}) = _$LeaderboardImpl;

  factory _Leaderboard.fromJson(Map<String, dynamic> json) =
      _$LeaderboardImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get type;
  @override
  String get period;
  @override
  List<LeaderboardEntry> get entries; // Configuration
  @override
  int get maxEntries;
  @override
  List<String>? get eligibleRoles;
  @override
  Map<String, dynamic>? get criteria; // Timing
  @override
  DateTime? get startDate;
  @override
  DateTime? get endDate;
  @override
  DateTime? get lastUpdated; // Metadata
  @override
  String? get description;
  @override
  String? get iconUrl;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of Leaderboard
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardImplCopyWith<_$LeaderboardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeaderboardEntry _$LeaderboardEntryFromJson(Map<String, dynamic> json) {
  return _LeaderboardEntry.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardEntry {
  String get userId => throw _privateConstructorUsedError;
  int get rank => throw _privateConstructorUsedError;
  double get score => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get stats => throw _privateConstructorUsedError;
  DateTime? get lastActivityAt => throw _privateConstructorUsedError;

  /// Serializes this LeaderboardEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardEntryCopyWith<LeaderboardEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardEntryCopyWith<$Res> {
  factory $LeaderboardEntryCopyWith(
          LeaderboardEntry value, $Res Function(LeaderboardEntry) then) =
      _$LeaderboardEntryCopyWithImpl<$Res, LeaderboardEntry>;
  @useResult
  $Res call(
      {String userId,
      int rank,
      double score,
      String? displayName,
      String? avatarUrl,
      Map<String, dynamic>? stats,
      DateTime? lastActivityAt});
}

/// @nodoc
class _$LeaderboardEntryCopyWithImpl<$Res, $Val extends LeaderboardEntry>
    implements $LeaderboardEntryCopyWith<$Res> {
  _$LeaderboardEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? rank = null,
    Object? score = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? stats = freezed,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderboardEntryImplCopyWith<$Res>
    implements $LeaderboardEntryCopyWith<$Res> {
  factory _$$LeaderboardEntryImplCopyWith(_$LeaderboardEntryImpl value,
          $Res Function(_$LeaderboardEntryImpl) then) =
      __$$LeaderboardEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      int rank,
      double score,
      String? displayName,
      String? avatarUrl,
      Map<String, dynamic>? stats,
      DateTime? lastActivityAt});
}

/// @nodoc
class __$$LeaderboardEntryImplCopyWithImpl<$Res>
    extends _$LeaderboardEntryCopyWithImpl<$Res, _$LeaderboardEntryImpl>
    implements _$$LeaderboardEntryImplCopyWith<$Res> {
  __$$LeaderboardEntryImplCopyWithImpl(_$LeaderboardEntryImpl _value,
      $Res Function(_$LeaderboardEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? rank = null,
    Object? score = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? stats = freezed,
    Object? lastActivityAt = freezed,
  }) {
    return _then(_$LeaderboardEntryImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      rank: null == rank
          ? _value.rank
          : rank // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as double,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      stats: freezed == stats
          ? _value._stats
          : stats // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      lastActivityAt: freezed == lastActivityAt
          ? _value.lastActivityAt
          : lastActivityAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardEntryImpl implements _LeaderboardEntry {
  const _$LeaderboardEntryImpl(
      {required this.userId,
      required this.rank,
      required this.score,
      this.displayName,
      this.avatarUrl,
      final Map<String, dynamic>? stats,
      this.lastActivityAt})
      : _stats = stats;

  factory _$LeaderboardEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardEntryImplFromJson(json);

  @override
  final String userId;
  @override
  final int rank;
  @override
  final double score;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  final Map<String, dynamic>? _stats;
  @override
  Map<String, dynamic>? get stats {
    final value = _stats;
    if (value == null) return null;
    if (_stats is EqualUnmodifiableMapView) return _stats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? lastActivityAt;

  @override
  String toString() {
    return 'LeaderboardEntry(userId: $userId, rank: $rank, score: $score, displayName: $displayName, avatarUrl: $avatarUrl, stats: $stats, lastActivityAt: $lastActivityAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardEntryImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.rank, rank) || other.rank == rank) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            const DeepCollectionEquality().equals(other._stats, _stats) &&
            (identical(other.lastActivityAt, lastActivityAt) ||
                other.lastActivityAt == lastActivityAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, rank, score, displayName,
      avatarUrl, const DeepCollectionEquality().hash(_stats), lastActivityAt);

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      __$$LeaderboardEntryImplCopyWithImpl<_$LeaderboardEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardEntryImplToJson(
      this,
    );
  }
}

abstract class _LeaderboardEntry implements LeaderboardEntry {
  const factory _LeaderboardEntry(
      {required final String userId,
      required final int rank,
      required final double score,
      final String? displayName,
      final String? avatarUrl,
      final Map<String, dynamic>? stats,
      final DateTime? lastActivityAt}) = _$LeaderboardEntryImpl;

  factory _LeaderboardEntry.fromJson(Map<String, dynamic> json) =
      _$LeaderboardEntryImpl.fromJson;

  @override
  String get userId;
  @override
  int get rank;
  @override
  double get score;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  Map<String, dynamic>? get stats;
  @override
  DateTime? get lastActivityAt;

  /// Create a copy of LeaderboardEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardEntryImplCopyWith<_$LeaderboardEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
mixin _$Achievement {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String? get iconUrl => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  DateTime? get earnedAt => throw _privateConstructorUsedError;
  bool? get isUnlocked => throw _privateConstructorUsedError;

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
          Achievement value, $Res Function(Achievement) then) =
      _$AchievementCopyWithImpl<$Res, Achievement>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      int points,
      String? iconUrl,
      String? color,
      DateTime? earnedAt,
      bool? isUnlocked});
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res, $Val extends Achievement>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? points = null,
    Object? iconUrl = freezed,
    Object? color = freezed,
    Object? earnedAt = freezed,
    Object? isUnlocked = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      earnedAt: freezed == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isUnlocked: freezed == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AchievementImplCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$$AchievementImplCopyWith(
          _$AchievementImpl value, $Res Function(_$AchievementImpl) then) =
      __$$AchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      int points,
      String? iconUrl,
      String? color,
      DateTime? earnedAt,
      bool? isUnlocked});
}

/// @nodoc
class __$$AchievementImplCopyWithImpl<$Res>
    extends _$AchievementCopyWithImpl<$Res, _$AchievementImpl>
    implements _$$AchievementImplCopyWith<$Res> {
  __$$AchievementImplCopyWithImpl(
      _$AchievementImpl _value, $Res Function(_$AchievementImpl) _then)
      : super(_value, _then);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? points = null,
    Object? iconUrl = freezed,
    Object? color = freezed,
    Object? earnedAt = freezed,
    Object? isUnlocked = freezed,
  }) {
    return _then(_$AchievementImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      iconUrl: freezed == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      earnedAt: freezed == earnedAt
          ? _value.earnedAt
          : earnedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isUnlocked: freezed == isUnlocked
          ? _value.isUnlocked
          : isUnlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementImpl implements _Achievement {
  const _$AchievementImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.points,
      this.iconUrl,
      this.color,
      this.earnedAt,
      this.isUnlocked});

  factory _$AchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final int points;
  @override
  final String? iconUrl;
  @override
  final String? color;
  @override
  final DateTime? earnedAt;
  @override
  final bool? isUnlocked;

  @override
  String toString() {
    return 'Achievement(id: $id, title: $title, description: $description, points: $points, iconUrl: $iconUrl, color: $color, earnedAt: $earnedAt, isUnlocked: $isUnlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.earnedAt, earnedAt) ||
                other.earnedAt == earnedAt) &&
            (identical(other.isUnlocked, isUnlocked) ||
                other.isUnlocked == isUnlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, description, points,
      iconUrl, color, earnedAt, isUnlocked);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      __$$AchievementImplCopyWithImpl<_$AchievementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementImplToJson(
      this,
    );
  }
}

abstract class _Achievement implements Achievement {
  const factory _Achievement(
      {required final String id,
      required final String title,
      required final String description,
      required final int points,
      final String? iconUrl,
      final String? color,
      final DateTime? earnedAt,
      final bool? isUnlocked}) = _$AchievementImpl;

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$AchievementImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  int get points;
  @override
  String? get iconUrl;
  @override
  String? get color;
  @override
  DateTime? get earnedAt;
  @override
  bool? get isUnlocked;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
