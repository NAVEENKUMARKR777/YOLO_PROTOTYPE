// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'needs_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NeedsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<Need> get needs => throw _privateConstructorUsedError;
  List<Need> get userNeeds => throw _privateConstructorUsedError;
  List<Need> get communityNeeds => throw _privateConstructorUsedError;
  Need? get currentNeed => throw _privateConstructorUsedError;
  int get totalNeeds => throw _privateConstructorUsedError;
  int get helpedCount => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  NeedFilter? get currentFilter => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of NeedsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NeedsStateCopyWith<NeedsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeedsStateCopyWith<$Res> {
  factory $NeedsStateCopyWith(
          NeedsState value, $Res Function(NeedsState) then) =
      _$NeedsStateCopyWithImpl<$Res, NeedsState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<Need> needs,
      List<Need> userNeeds,
      List<Need> communityNeeds,
      Need? currentNeed,
      int totalNeeds,
      int helpedCount,
      bool hasMore,
      NeedFilter? currentFilter,
      String? error});

  $NeedCopyWith<$Res>? get currentNeed;
  $NeedFilterCopyWith<$Res>? get currentFilter;
}

/// @nodoc
class _$NeedsStateCopyWithImpl<$Res, $Val extends NeedsState>
    implements $NeedsStateCopyWith<$Res> {
  _$NeedsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NeedsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? needs = null,
    Object? userNeeds = null,
    Object? communityNeeds = null,
    Object? currentNeed = freezed,
    Object? totalNeeds = null,
    Object? helpedCount = null,
    Object? hasMore = null,
    Object? currentFilter = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      needs: null == needs
          ? _value.needs
          : needs // ignore: cast_nullable_to_non_nullable
              as List<Need>,
      userNeeds: null == userNeeds
          ? _value.userNeeds
          : userNeeds // ignore: cast_nullable_to_non_nullable
              as List<Need>,
      communityNeeds: null == communityNeeds
          ? _value.communityNeeds
          : communityNeeds // ignore: cast_nullable_to_non_nullable
              as List<Need>,
      currentNeed: freezed == currentNeed
          ? _value.currentNeed
          : currentNeed // ignore: cast_nullable_to_non_nullable
              as Need?,
      totalNeeds: null == totalNeeds
          ? _value.totalNeeds
          : totalNeeds // ignore: cast_nullable_to_non_nullable
              as int,
      helpedCount: null == helpedCount
          ? _value.helpedCount
          : helpedCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentFilter: freezed == currentFilter
          ? _value.currentFilter
          : currentFilter // ignore: cast_nullable_to_non_nullable
              as NeedFilter?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of NeedsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NeedCopyWith<$Res>? get currentNeed {
    if (_value.currentNeed == null) {
      return null;
    }

    return $NeedCopyWith<$Res>(_value.currentNeed!, (value) {
      return _then(_value.copyWith(currentNeed: value) as $Val);
    });
  }

  /// Create a copy of NeedsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NeedFilterCopyWith<$Res>? get currentFilter {
    if (_value.currentFilter == null) {
      return null;
    }

    return $NeedFilterCopyWith<$Res>(_value.currentFilter!, (value) {
      return _then(_value.copyWith(currentFilter: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NeedsStateImplCopyWith<$Res>
    implements $NeedsStateCopyWith<$Res> {
  factory _$$NeedsStateImplCopyWith(
          _$NeedsStateImpl value, $Res Function(_$NeedsStateImpl) then) =
      __$$NeedsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<Need> needs,
      List<Need> userNeeds,
      List<Need> communityNeeds,
      Need? currentNeed,
      int totalNeeds,
      int helpedCount,
      bool hasMore,
      NeedFilter? currentFilter,
      String? error});

  @override
  $NeedCopyWith<$Res>? get currentNeed;
  @override
  $NeedFilterCopyWith<$Res>? get currentFilter;
}

/// @nodoc
class __$$NeedsStateImplCopyWithImpl<$Res>
    extends _$NeedsStateCopyWithImpl<$Res, _$NeedsStateImpl>
    implements _$$NeedsStateImplCopyWith<$Res> {
  __$$NeedsStateImplCopyWithImpl(
      _$NeedsStateImpl _value, $Res Function(_$NeedsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NeedsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? needs = null,
    Object? userNeeds = null,
    Object? communityNeeds = null,
    Object? currentNeed = freezed,
    Object? totalNeeds = null,
    Object? helpedCount = null,
    Object? hasMore = null,
    Object? currentFilter = freezed,
    Object? error = freezed,
  }) {
    return _then(_$NeedsStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      needs: null == needs
          ? _value._needs
          : needs // ignore: cast_nullable_to_non_nullable
              as List<Need>,
      userNeeds: null == userNeeds
          ? _value._userNeeds
          : userNeeds // ignore: cast_nullable_to_non_nullable
              as List<Need>,
      communityNeeds: null == communityNeeds
          ? _value._communityNeeds
          : communityNeeds // ignore: cast_nullable_to_non_nullable
              as List<Need>,
      currentNeed: freezed == currentNeed
          ? _value.currentNeed
          : currentNeed // ignore: cast_nullable_to_non_nullable
              as Need?,
      totalNeeds: null == totalNeeds
          ? _value.totalNeeds
          : totalNeeds // ignore: cast_nullable_to_non_nullable
              as int,
      helpedCount: null == helpedCount
          ? _value.helpedCount
          : helpedCount // ignore: cast_nullable_to_non_nullable
              as int,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      currentFilter: freezed == currentFilter
          ? _value.currentFilter
          : currentFilter // ignore: cast_nullable_to_non_nullable
              as NeedFilter?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$NeedsStateImpl implements _NeedsState {
  const _$NeedsStateImpl(
      {this.isLoading = false,
      final List<Need> needs = const [],
      final List<Need> userNeeds = const [],
      final List<Need> communityNeeds = const [],
      this.currentNeed,
      this.totalNeeds = 0,
      this.helpedCount = 0,
      this.hasMore = true,
      this.currentFilter,
      this.error})
      : _needs = needs,
        _userNeeds = userNeeds,
        _communityNeeds = communityNeeds;

  @override
  @JsonKey()
  final bool isLoading;
  final List<Need> _needs;
  @override
  @JsonKey()
  List<Need> get needs {
    if (_needs is EqualUnmodifiableListView) return _needs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_needs);
  }

  final List<Need> _userNeeds;
  @override
  @JsonKey()
  List<Need> get userNeeds {
    if (_userNeeds is EqualUnmodifiableListView) return _userNeeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userNeeds);
  }

  final List<Need> _communityNeeds;
  @override
  @JsonKey()
  List<Need> get communityNeeds {
    if (_communityNeeds is EqualUnmodifiableListView) return _communityNeeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_communityNeeds);
  }

  @override
  final Need? currentNeed;
  @override
  @JsonKey()
  final int totalNeeds;
  @override
  @JsonKey()
  final int helpedCount;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final NeedFilter? currentFilter;
  @override
  final String? error;

  @override
  String toString() {
    return 'NeedsState(isLoading: $isLoading, needs: $needs, userNeeds: $userNeeds, communityNeeds: $communityNeeds, currentNeed: $currentNeed, totalNeeds: $totalNeeds, helpedCount: $helpedCount, hasMore: $hasMore, currentFilter: $currentFilter, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeedsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other._needs, _needs) &&
            const DeepCollectionEquality()
                .equals(other._userNeeds, _userNeeds) &&
            const DeepCollectionEquality()
                .equals(other._communityNeeds, _communityNeeds) &&
            (identical(other.currentNeed, currentNeed) ||
                other.currentNeed == currentNeed) &&
            (identical(other.totalNeeds, totalNeeds) ||
                other.totalNeeds == totalNeeds) &&
            (identical(other.helpedCount, helpedCount) ||
                other.helpedCount == helpedCount) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentFilter, currentFilter) ||
                other.currentFilter == currentFilter) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_needs),
      const DeepCollectionEquality().hash(_userNeeds),
      const DeepCollectionEquality().hash(_communityNeeds),
      currentNeed,
      totalNeeds,
      helpedCount,
      hasMore,
      currentFilter,
      error);

  /// Create a copy of NeedsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NeedsStateImplCopyWith<_$NeedsStateImpl> get copyWith =>
      __$$NeedsStateImplCopyWithImpl<_$NeedsStateImpl>(this, _$identity);
}

abstract class _NeedsState implements NeedsState {
  const factory _NeedsState(
      {final bool isLoading,
      final List<Need> needs,
      final List<Need> userNeeds,
      final List<Need> communityNeeds,
      final Need? currentNeed,
      final int totalNeeds,
      final int helpedCount,
      final bool hasMore,
      final NeedFilter? currentFilter,
      final String? error}) = _$NeedsStateImpl;

  @override
  bool get isLoading;
  @override
  List<Need> get needs;
  @override
  List<Need> get userNeeds;
  @override
  List<Need> get communityNeeds;
  @override
  Need? get currentNeed;
  @override
  int get totalNeeds;
  @override
  int get helpedCount;
  @override
  bool get hasMore;
  @override
  NeedFilter? get currentFilter;
  @override
  String? get error;

  /// Create a copy of NeedsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NeedsStateImplCopyWith<_$NeedsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
