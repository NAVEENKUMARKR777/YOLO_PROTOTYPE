// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'need_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Need _$NeedFromJson(Map<String, dynamic> json) {
  return _Need.fromJson(json);
}

/// @nodoc
mixin _$Need {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get requesterId => throw _privateConstructorUsedError;
  String? get requesterName => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  NeedPriority get priority => throw _privateConstructorUsedError;
  NeedStatus get status => throw _privateConstructorUsedError;
  InputMethod get inputMethod => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get voiceUrl => throw _privateConstructorUsedError;
  String? get barcodeData => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  List<String>? get documents => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  int? get helpersCount => throw _privateConstructorUsedError;
  int? get commentsCount => throw _privateConstructorUsedError;
  int? get viewsCount => throw _privateConstructorUsedError;
  int? get helpRequestsCount => throw _privateConstructorUsedError;
  List<String>? get helpers => throw _privateConstructorUsedError;
  List<String>? get helpOffers => throw _privateConstructorUsedError;
  List<String>? get updates => throw _privateConstructorUsedError;
  NeedVisibility? get visibility => throw _privateConstructorUsedError;
  NeedUrgency? get urgency => throw _privateConstructorUsedError;

  /// Serializes this Need to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Need
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NeedCopyWith<Need> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeedCopyWith<$Res> {
  factory $NeedCopyWith(Need value, $Res Function(Need) then) =
      _$NeedCopyWithImpl<$Res, Need>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String requesterId,
      String? requesterName,
      String category,
      NeedPriority priority,
      NeedStatus status,
      InputMethod inputMethod,
      String? imageUrl,
      String? voiceUrl,
      String? barcodeData,
      List<String>? tags,
      List<String>? images,
      List<String>? imageUrls,
      List<String>? documents,
      String? location,
      double? latitude,
      double? longitude,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deadline,
      int? helpersCount,
      int? commentsCount,
      int? viewsCount,
      int? helpRequestsCount,
      List<String>? helpers,
      List<String>? helpOffers,
      List<String>? updates,
      NeedVisibility? visibility,
      NeedUrgency? urgency});
}

/// @nodoc
class _$NeedCopyWithImpl<$Res, $Val extends Need>
    implements $NeedCopyWith<$Res> {
  _$NeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Need
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? requesterId = null,
    Object? requesterName = freezed,
    Object? category = null,
    Object? priority = null,
    Object? status = null,
    Object? inputMethod = null,
    Object? imageUrl = freezed,
    Object? voiceUrl = freezed,
    Object? barcodeData = freezed,
    Object? tags = freezed,
    Object? images = freezed,
    Object? imageUrls = freezed,
    Object? documents = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deadline = freezed,
    Object? helpersCount = freezed,
    Object? commentsCount = freezed,
    Object? viewsCount = freezed,
    Object? helpRequestsCount = freezed,
    Object? helpers = freezed,
    Object? helpOffers = freezed,
    Object? updates = freezed,
    Object? visibility = freezed,
    Object? urgency = freezed,
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
      requesterId: null == requesterId
          ? _value.requesterId
          : requesterId // ignore: cast_nullable_to_non_nullable
              as String,
      requesterName: freezed == requesterName
          ? _value.requesterName
          : requesterName // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NeedPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NeedStatus,
      inputMethod: null == inputMethod
          ? _value.inputMethod
          : inputMethod // ignore: cast_nullable_to_non_nullable
              as InputMethod,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      voiceUrl: freezed == voiceUrl
          ? _value.voiceUrl
          : voiceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      barcodeData: freezed == barcodeData
          ? _value.barcodeData
          : barcodeData // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      documents: freezed == documents
          ? _value.documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      helpersCount: freezed == helpersCount
          ? _value.helpersCount
          : helpersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentsCount: freezed == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      viewsCount: freezed == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      helpRequestsCount: freezed == helpRequestsCount
          ? _value.helpRequestsCount
          : helpRequestsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      helpers: freezed == helpers
          ? _value.helpers
          : helpers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      helpOffers: freezed == helpOffers
          ? _value.helpOffers
          : helpOffers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updates: freezed == updates
          ? _value.updates
          : updates // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as NeedVisibility?,
      urgency: freezed == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as NeedUrgency?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NeedImplCopyWith<$Res> implements $NeedCopyWith<$Res> {
  factory _$$NeedImplCopyWith(
          _$NeedImpl value, $Res Function(_$NeedImpl) then) =
      __$$NeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String requesterId,
      String? requesterName,
      String category,
      NeedPriority priority,
      NeedStatus status,
      InputMethod inputMethod,
      String? imageUrl,
      String? voiceUrl,
      String? barcodeData,
      List<String>? tags,
      List<String>? images,
      List<String>? imageUrls,
      List<String>? documents,
      String? location,
      double? latitude,
      double? longitude,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? deadline,
      int? helpersCount,
      int? commentsCount,
      int? viewsCount,
      int? helpRequestsCount,
      List<String>? helpers,
      List<String>? helpOffers,
      List<String>? updates,
      NeedVisibility? visibility,
      NeedUrgency? urgency});
}

/// @nodoc
class __$$NeedImplCopyWithImpl<$Res>
    extends _$NeedCopyWithImpl<$Res, _$NeedImpl>
    implements _$$NeedImplCopyWith<$Res> {
  __$$NeedImplCopyWithImpl(_$NeedImpl _value, $Res Function(_$NeedImpl) _then)
      : super(_value, _then);

  /// Create a copy of Need
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? requesterId = null,
    Object? requesterName = freezed,
    Object? category = null,
    Object? priority = null,
    Object? status = null,
    Object? inputMethod = null,
    Object? imageUrl = freezed,
    Object? voiceUrl = freezed,
    Object? barcodeData = freezed,
    Object? tags = freezed,
    Object? images = freezed,
    Object? imageUrls = freezed,
    Object? documents = freezed,
    Object? location = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? deadline = freezed,
    Object? helpersCount = freezed,
    Object? commentsCount = freezed,
    Object? viewsCount = freezed,
    Object? helpRequestsCount = freezed,
    Object? helpers = freezed,
    Object? helpOffers = freezed,
    Object? updates = freezed,
    Object? visibility = freezed,
    Object? urgency = freezed,
  }) {
    return _then(_$NeedImpl(
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
      requesterId: null == requesterId
          ? _value.requesterId
          : requesterId // ignore: cast_nullable_to_non_nullable
              as String,
      requesterName: freezed == requesterName
          ? _value.requesterName
          : requesterName // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NeedPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NeedStatus,
      inputMethod: null == inputMethod
          ? _value.inputMethod
          : inputMethod // ignore: cast_nullable_to_non_nullable
              as InputMethod,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      voiceUrl: freezed == voiceUrl
          ? _value.voiceUrl
          : voiceUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      barcodeData: freezed == barcodeData
          ? _value.barcodeData
          : barcodeData // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      documents: freezed == documents
          ? _value._documents
          : documents // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      helpersCount: freezed == helpersCount
          ? _value.helpersCount
          : helpersCount // ignore: cast_nullable_to_non_nullable
              as int?,
      commentsCount: freezed == commentsCount
          ? _value.commentsCount
          : commentsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      viewsCount: freezed == viewsCount
          ? _value.viewsCount
          : viewsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      helpRequestsCount: freezed == helpRequestsCount
          ? _value.helpRequestsCount
          : helpRequestsCount // ignore: cast_nullable_to_non_nullable
              as int?,
      helpers: freezed == helpers
          ? _value._helpers
          : helpers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      helpOffers: freezed == helpOffers
          ? _value._helpOffers
          : helpOffers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      updates: freezed == updates
          ? _value._updates
          : updates // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      visibility: freezed == visibility
          ? _value.visibility
          : visibility // ignore: cast_nullable_to_non_nullable
              as NeedVisibility?,
      urgency: freezed == urgency
          ? _value.urgency
          : urgency // ignore: cast_nullable_to_non_nullable
              as NeedUrgency?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NeedImpl implements _Need {
  const _$NeedImpl(
      {required this.id,
      required this.title,
      required this.description,
      required this.requesterId,
      this.requesterName,
      required this.category,
      required this.priority,
      required this.status,
      required this.inputMethod,
      this.imageUrl,
      this.voiceUrl,
      this.barcodeData,
      final List<String>? tags,
      final List<String>? images,
      final List<String>? imageUrls,
      final List<String>? documents,
      this.location,
      this.latitude,
      this.longitude,
      this.createdAt,
      this.updatedAt,
      this.deadline,
      this.helpersCount,
      this.commentsCount,
      this.viewsCount,
      this.helpRequestsCount,
      final List<String>? helpers,
      final List<String>? helpOffers,
      final List<String>? updates,
      this.visibility,
      this.urgency})
      : _tags = tags,
        _images = images,
        _imageUrls = imageUrls,
        _documents = documents,
        _helpers = helpers,
        _helpOffers = helpOffers,
        _updates = updates;

  factory _$NeedImpl.fromJson(Map<String, dynamic> json) =>
      _$$NeedImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String requesterId;
  @override
  final String? requesterName;
  @override
  final String category;
  @override
  final NeedPriority priority;
  @override
  final NeedStatus status;
  @override
  final InputMethod inputMethod;
  @override
  final String? imageUrl;
  @override
  final String? voiceUrl;
  @override
  final String? barcodeData;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _imageUrls;
  @override
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _documents;
  @override
  List<String>? get documents {
    final value = _documents;
    if (value == null) return null;
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? location;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deadline;
  @override
  final int? helpersCount;
  @override
  final int? commentsCount;
  @override
  final int? viewsCount;
  @override
  final int? helpRequestsCount;
  final List<String>? _helpers;
  @override
  List<String>? get helpers {
    final value = _helpers;
    if (value == null) return null;
    if (_helpers is EqualUnmodifiableListView) return _helpers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _helpOffers;
  @override
  List<String>? get helpOffers {
    final value = _helpOffers;
    if (value == null) return null;
    if (_helpOffers is EqualUnmodifiableListView) return _helpOffers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _updates;
  @override
  List<String>? get updates {
    final value = _updates;
    if (value == null) return null;
    if (_updates is EqualUnmodifiableListView) return _updates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final NeedVisibility? visibility;
  @override
  final NeedUrgency? urgency;

  @override
  String toString() {
    return 'Need(id: $id, title: $title, description: $description, requesterId: $requesterId, requesterName: $requesterName, category: $category, priority: $priority, status: $status, inputMethod: $inputMethod, imageUrl: $imageUrl, voiceUrl: $voiceUrl, barcodeData: $barcodeData, tags: $tags, images: $images, imageUrls: $imageUrls, documents: $documents, location: $location, latitude: $latitude, longitude: $longitude, createdAt: $createdAt, updatedAt: $updatedAt, deadline: $deadline, helpersCount: $helpersCount, commentsCount: $commentsCount, viewsCount: $viewsCount, helpRequestsCount: $helpRequestsCount, helpers: $helpers, helpOffers: $helpOffers, updates: $updates, visibility: $visibility, urgency: $urgency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.requesterId, requesterId) ||
                other.requesterId == requesterId) &&
            (identical(other.requesterName, requesterName) ||
                other.requesterName == requesterName) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.inputMethod, inputMethod) ||
                other.inputMethod == inputMethod) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.voiceUrl, voiceUrl) ||
                other.voiceUrl == voiceUrl) &&
            (identical(other.barcodeData, barcodeData) ||
                other.barcodeData == barcodeData) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            const DeepCollectionEquality()
                .equals(other._documents, _documents) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.helpersCount, helpersCount) ||
                other.helpersCount == helpersCount) &&
            (identical(other.commentsCount, commentsCount) ||
                other.commentsCount == commentsCount) &&
            (identical(other.viewsCount, viewsCount) ||
                other.viewsCount == viewsCount) &&
            (identical(other.helpRequestsCount, helpRequestsCount) ||
                other.helpRequestsCount == helpRequestsCount) &&
            const DeepCollectionEquality().equals(other._helpers, _helpers) &&
            const DeepCollectionEquality()
                .equals(other._helpOffers, _helpOffers) &&
            const DeepCollectionEquality().equals(other._updates, _updates) &&
            (identical(other.visibility, visibility) ||
                other.visibility == visibility) &&
            (identical(other.urgency, urgency) || other.urgency == urgency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        requesterId,
        requesterName,
        category,
        priority,
        status,
        inputMethod,
        imageUrl,
        voiceUrl,
        barcodeData,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_images),
        const DeepCollectionEquality().hash(_imageUrls),
        const DeepCollectionEquality().hash(_documents),
        location,
        latitude,
        longitude,
        createdAt,
        updatedAt,
        deadline,
        helpersCount,
        commentsCount,
        viewsCount,
        helpRequestsCount,
        const DeepCollectionEquality().hash(_helpers),
        const DeepCollectionEquality().hash(_helpOffers),
        const DeepCollectionEquality().hash(_updates),
        visibility,
        urgency
      ]);

  /// Create a copy of Need
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NeedImplCopyWith<_$NeedImpl> get copyWith =>
      __$$NeedImplCopyWithImpl<_$NeedImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NeedImplToJson(
      this,
    );
  }
}

abstract class _Need implements Need {
  const factory _Need(
      {required final String id,
      required final String title,
      required final String description,
      required final String requesterId,
      final String? requesterName,
      required final String category,
      required final NeedPriority priority,
      required final NeedStatus status,
      required final InputMethod inputMethod,
      final String? imageUrl,
      final String? voiceUrl,
      final String? barcodeData,
      final List<String>? tags,
      final List<String>? images,
      final List<String>? imageUrls,
      final List<String>? documents,
      final String? location,
      final double? latitude,
      final double? longitude,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? deadline,
      final int? helpersCount,
      final int? commentsCount,
      final int? viewsCount,
      final int? helpRequestsCount,
      final List<String>? helpers,
      final List<String>? helpOffers,
      final List<String>? updates,
      final NeedVisibility? visibility,
      final NeedUrgency? urgency}) = _$NeedImpl;

  factory _Need.fromJson(Map<String, dynamic> json) = _$NeedImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get requesterId;
  @override
  String? get requesterName;
  @override
  String get category;
  @override
  NeedPriority get priority;
  @override
  NeedStatus get status;
  @override
  InputMethod get inputMethod;
  @override
  String? get imageUrl;
  @override
  String? get voiceUrl;
  @override
  String? get barcodeData;
  @override
  List<String>? get tags;
  @override
  List<String>? get images;
  @override
  List<String>? get imageUrls;
  @override
  List<String>? get documents;
  @override
  String? get location;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get deadline;
  @override
  int? get helpersCount;
  @override
  int? get commentsCount;
  @override
  int? get viewsCount;
  @override
  int? get helpRequestsCount;
  @override
  List<String>? get helpers;
  @override
  List<String>? get helpOffers;
  @override
  List<String>? get updates;
  @override
  NeedVisibility? get visibility;
  @override
  NeedUrgency? get urgency;

  /// Create a copy of Need
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NeedImplCopyWith<_$NeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NeedUpdate _$NeedUpdateFromJson(Map<String, dynamic> json) {
  return _NeedUpdate.fromJson(json);
}

/// @nodoc
mixin _$NeedUpdate {
  String get id => throw _privateConstructorUsedError;
  String get needId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get updateType => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this NeedUpdate to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NeedUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NeedUpdateCopyWith<NeedUpdate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeedUpdateCopyWith<$Res> {
  factory $NeedUpdateCopyWith(
          NeedUpdate value, $Res Function(NeedUpdate) then) =
      _$NeedUpdateCopyWithImpl<$Res, NeedUpdate>;
  @useResult
  $Res call(
      {String id,
      String needId,
      String userId,
      String updateType,
      String message,
      String? imageUrl,
      Map<String, dynamic>? data,
      DateTime? createdAt});
}

/// @nodoc
class _$NeedUpdateCopyWithImpl<$Res, $Val extends NeedUpdate>
    implements $NeedUpdateCopyWith<$Res> {
  _$NeedUpdateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NeedUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? needId = null,
    Object? userId = null,
    Object? updateType = null,
    Object? message = null,
    Object? imageUrl = freezed,
    Object? data = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      needId: null == needId
          ? _value.needId
          : needId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      updateType: null == updateType
          ? _value.updateType
          : updateType // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NeedUpdateImplCopyWith<$Res>
    implements $NeedUpdateCopyWith<$Res> {
  factory _$$NeedUpdateImplCopyWith(
          _$NeedUpdateImpl value, $Res Function(_$NeedUpdateImpl) then) =
      __$$NeedUpdateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String needId,
      String userId,
      String updateType,
      String message,
      String? imageUrl,
      Map<String, dynamic>? data,
      DateTime? createdAt});
}

/// @nodoc
class __$$NeedUpdateImplCopyWithImpl<$Res>
    extends _$NeedUpdateCopyWithImpl<$Res, _$NeedUpdateImpl>
    implements _$$NeedUpdateImplCopyWith<$Res> {
  __$$NeedUpdateImplCopyWithImpl(
      _$NeedUpdateImpl _value, $Res Function(_$NeedUpdateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NeedUpdate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? needId = null,
    Object? userId = null,
    Object? updateType = null,
    Object? message = null,
    Object? imageUrl = freezed,
    Object? data = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$NeedUpdateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      needId: null == needId
          ? _value.needId
          : needId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      updateType: null == updateType
          ? _value.updateType
          : updateType // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NeedUpdateImpl implements _NeedUpdate {
  const _$NeedUpdateImpl(
      {required this.id,
      required this.needId,
      required this.userId,
      required this.updateType,
      required this.message,
      this.imageUrl,
      final Map<String, dynamic>? data,
      this.createdAt})
      : _data = data;

  factory _$NeedUpdateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NeedUpdateImplFromJson(json);

  @override
  final String id;
  @override
  final String needId;
  @override
  final String userId;
  @override
  final String updateType;
  @override
  final String message;
  @override
  final String? imageUrl;
  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'NeedUpdate(id: $id, needId: $needId, userId: $userId, updateType: $updateType, message: $message, imageUrl: $imageUrl, data: $data, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeedUpdateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.needId, needId) || other.needId == needId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.updateType, updateType) ||
                other.updateType == updateType) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, needId, userId, updateType,
      message, imageUrl, const DeepCollectionEquality().hash(_data), createdAt);

  /// Create a copy of NeedUpdate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NeedUpdateImplCopyWith<_$NeedUpdateImpl> get copyWith =>
      __$$NeedUpdateImplCopyWithImpl<_$NeedUpdateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NeedUpdateImplToJson(
      this,
    );
  }
}

abstract class _NeedUpdate implements NeedUpdate {
  const factory _NeedUpdate(
      {required final String id,
      required final String needId,
      required final String userId,
      required final String updateType,
      required final String message,
      final String? imageUrl,
      final Map<String, dynamic>? data,
      final DateTime? createdAt}) = _$NeedUpdateImpl;

  factory _NeedUpdate.fromJson(Map<String, dynamic> json) =
      _$NeedUpdateImpl.fromJson;

  @override
  String get id;
  @override
  String get needId;
  @override
  String get userId;
  @override
  String get updateType;
  @override
  String get message;
  @override
  String? get imageUrl;
  @override
  Map<String, dynamic>? get data;
  @override
  DateTime? get createdAt;

  /// Create a copy of NeedUpdate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NeedUpdateImplCopyWith<_$NeedUpdateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NeedComment _$NeedCommentFromJson(Map<String, dynamic> json) {
  return _NeedComment.fromJson(json);
}

/// @nodoc
mixin _$NeedComment {
  String get id => throw _privateConstructorUsedError;
  String get needId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  String? get parentCommentId => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  bool get isEdited => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NeedComment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NeedComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NeedCommentCopyWith<NeedComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeedCommentCopyWith<$Res> {
  factory $NeedCommentCopyWith(
          NeedComment value, $Res Function(NeedComment) then) =
      _$NeedCommentCopyWithImpl<$Res, NeedComment>;
  @useResult
  $Res call(
      {String id,
      String needId,
      String userId,
      String comment,
      String? parentCommentId,
      List<String>? imageUrls,
      int likeCount,
      bool isEdited,
      bool isDeleted,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$NeedCommentCopyWithImpl<$Res, $Val extends NeedComment>
    implements $NeedCommentCopyWith<$Res> {
  _$NeedCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NeedComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? needId = null,
    Object? userId = null,
    Object? comment = null,
    Object? parentCommentId = freezed,
    Object? imageUrls = freezed,
    Object? likeCount = null,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      needId: null == needId
          ? _value.needId
          : needId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$NeedCommentImplCopyWith<$Res>
    implements $NeedCommentCopyWith<$Res> {
  factory _$$NeedCommentImplCopyWith(
          _$NeedCommentImpl value, $Res Function(_$NeedCommentImpl) then) =
      __$$NeedCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String needId,
      String userId,
      String comment,
      String? parentCommentId,
      List<String>? imageUrls,
      int likeCount,
      bool isEdited,
      bool isDeleted,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$NeedCommentImplCopyWithImpl<$Res>
    extends _$NeedCommentCopyWithImpl<$Res, _$NeedCommentImpl>
    implements _$$NeedCommentImplCopyWith<$Res> {
  __$$NeedCommentImplCopyWithImpl(
      _$NeedCommentImpl _value, $Res Function(_$NeedCommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of NeedComment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? needId = null,
    Object? userId = null,
    Object? comment = null,
    Object? parentCommentId = freezed,
    Object? imageUrls = freezed,
    Object? likeCount = null,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$NeedCommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      needId: null == needId
          ? _value.needId
          : needId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      parentCommentId: freezed == parentCommentId
          ? _value.parentCommentId
          : parentCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$NeedCommentImpl implements _NeedComment {
  const _$NeedCommentImpl(
      {required this.id,
      required this.needId,
      required this.userId,
      required this.comment,
      this.parentCommentId,
      final List<String>? imageUrls,
      this.likeCount = 0,
      this.isEdited = false,
      this.isDeleted = false,
      this.createdAt,
      this.updatedAt})
      : _imageUrls = imageUrls;

  factory _$NeedCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$NeedCommentImplFromJson(json);

  @override
  final String id;
  @override
  final String needId;
  @override
  final String userId;
  @override
  final String comment;
  @override
  final String? parentCommentId;
  final List<String>? _imageUrls;
  @override
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int likeCount;
  @override
  @JsonKey()
  final bool isEdited;
  @override
  @JsonKey()
  final bool isDeleted;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'NeedComment(id: $id, needId: $needId, userId: $userId, comment: $comment, parentCommentId: $parentCommentId, imageUrls: $imageUrls, likeCount: $likeCount, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeedCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.needId, needId) || other.needId == needId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.parentCommentId, parentCommentId) ||
                other.parentCommentId == parentCommentId) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      needId,
      userId,
      comment,
      parentCommentId,
      const DeepCollectionEquality().hash(_imageUrls),
      likeCount,
      isEdited,
      isDeleted,
      createdAt,
      updatedAt);

  /// Create a copy of NeedComment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NeedCommentImplCopyWith<_$NeedCommentImpl> get copyWith =>
      __$$NeedCommentImplCopyWithImpl<_$NeedCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NeedCommentImplToJson(
      this,
    );
  }
}

abstract class _NeedComment implements NeedComment {
  const factory _NeedComment(
      {required final String id,
      required final String needId,
      required final String userId,
      required final String comment,
      final String? parentCommentId,
      final List<String>? imageUrls,
      final int likeCount,
      final bool isEdited,
      final bool isDeleted,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$NeedCommentImpl;

  factory _NeedComment.fromJson(Map<String, dynamic> json) =
      _$NeedCommentImpl.fromJson;

  @override
  String get id;
  @override
  String get needId;
  @override
  String get userId;
  @override
  String get comment;
  @override
  String? get parentCommentId;
  @override
  List<String>? get imageUrls;
  @override
  int get likeCount;
  @override
  bool get isEdited;
  @override
  bool get isDeleted;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of NeedComment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NeedCommentImplCopyWith<_$NeedCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NeedFilter _$NeedFilterFromJson(Map<String, dynamic> json) {
  return _NeedFilter.fromJson(json);
}

/// @nodoc
mixin _$NeedFilter {
  NeedStatus? get status => throw _privateConstructorUsedError;
  NeedPriority? get priority => throw _privateConstructorUsedError;
  NeedCategory? get category => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  double? get radiusKm => throw _privateConstructorUsedError;
  DateTime? get createdAfter => throw _privateConstructorUsedError;
  DateTime? get createdBefore => throw _privateConstructorUsedError;
  String? get searchQuery => throw _privateConstructorUsedError;
  List<String>? get tags => throw _privateConstructorUsedError;
  bool? get isVerified => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  int? get limit => throw _privateConstructorUsedError;
  int? get offset => throw _privateConstructorUsedError;

  /// Serializes this NeedFilter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NeedFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NeedFilterCopyWith<NeedFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeedFilterCopyWith<$Res> {
  factory $NeedFilterCopyWith(
          NeedFilter value, $Res Function(NeedFilter) then) =
      _$NeedFilterCopyWithImpl<$Res, NeedFilter>;
  @useResult
  $Res call(
      {NeedStatus? status,
      NeedPriority? priority,
      NeedCategory? category,
      String? location,
      double? radiusKm,
      DateTime? createdAfter,
      DateTime? createdBefore,
      String? searchQuery,
      List<String>? tags,
      bool? isVerified,
      String? userId,
      int? limit,
      int? offset});
}

/// @nodoc
class _$NeedFilterCopyWithImpl<$Res, $Val extends NeedFilter>
    implements $NeedFilterCopyWith<$Res> {
  _$NeedFilterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NeedFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? priority = freezed,
    Object? category = freezed,
    Object? location = freezed,
    Object? radiusKm = freezed,
    Object? createdAfter = freezed,
    Object? createdBefore = freezed,
    Object? searchQuery = freezed,
    Object? tags = freezed,
    Object? isVerified = freezed,
    Object? userId = freezed,
    Object? limit = freezed,
    Object? offset = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NeedStatus?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NeedPriority?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as NeedCategory?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      radiusKm: freezed == radiusKm
          ? _value.radiusKm
          : radiusKm // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAfter: freezed == createdAfter
          ? _value.createdAfter
          : createdAfter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBefore: freezed == createdBefore
          ? _value.createdBefore
          : createdBefore // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NeedFilterImplCopyWith<$Res>
    implements $NeedFilterCopyWith<$Res> {
  factory _$$NeedFilterImplCopyWith(
          _$NeedFilterImpl value, $Res Function(_$NeedFilterImpl) then) =
      __$$NeedFilterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NeedStatus? status,
      NeedPriority? priority,
      NeedCategory? category,
      String? location,
      double? radiusKm,
      DateTime? createdAfter,
      DateTime? createdBefore,
      String? searchQuery,
      List<String>? tags,
      bool? isVerified,
      String? userId,
      int? limit,
      int? offset});
}

/// @nodoc
class __$$NeedFilterImplCopyWithImpl<$Res>
    extends _$NeedFilterCopyWithImpl<$Res, _$NeedFilterImpl>
    implements _$$NeedFilterImplCopyWith<$Res> {
  __$$NeedFilterImplCopyWithImpl(
      _$NeedFilterImpl _value, $Res Function(_$NeedFilterImpl) _then)
      : super(_value, _then);

  /// Create a copy of NeedFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? priority = freezed,
    Object? category = freezed,
    Object? location = freezed,
    Object? radiusKm = freezed,
    Object? createdAfter = freezed,
    Object? createdBefore = freezed,
    Object? searchQuery = freezed,
    Object? tags = freezed,
    Object? isVerified = freezed,
    Object? userId = freezed,
    Object? limit = freezed,
    Object? offset = freezed,
  }) {
    return _then(_$NeedFilterImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as NeedStatus?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as NeedPriority?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as NeedCategory?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      radiusKm: freezed == radiusKm
          ? _value.radiusKm
          : radiusKm // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAfter: freezed == createdAfter
          ? _value.createdAfter
          : createdAfter // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdBefore: freezed == createdBefore
          ? _value.createdBefore
          : createdBefore // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      tags: freezed == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NeedFilterImpl implements _NeedFilter {
  const _$NeedFilterImpl(
      {this.status,
      this.priority,
      this.category,
      this.location,
      this.radiusKm,
      this.createdAfter,
      this.createdBefore,
      this.searchQuery,
      final List<String>? tags,
      this.isVerified,
      this.userId,
      this.limit,
      this.offset})
      : _tags = tags;

  factory _$NeedFilterImpl.fromJson(Map<String, dynamic> json) =>
      _$$NeedFilterImplFromJson(json);

  @override
  final NeedStatus? status;
  @override
  final NeedPriority? priority;
  @override
  final NeedCategory? category;
  @override
  final String? location;
  @override
  final double? radiusKm;
  @override
  final DateTime? createdAfter;
  @override
  final DateTime? createdBefore;
  @override
  final String? searchQuery;
  final List<String>? _tags;
  @override
  List<String>? get tags {
    final value = _tags;
    if (value == null) return null;
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isVerified;
  @override
  final String? userId;
  @override
  final int? limit;
  @override
  final int? offset;

  @override
  String toString() {
    return 'NeedFilter(status: $status, priority: $priority, category: $category, location: $location, radiusKm: $radiusKm, createdAfter: $createdAfter, createdBefore: $createdBefore, searchQuery: $searchQuery, tags: $tags, isVerified: $isVerified, userId: $userId, limit: $limit, offset: $offset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeedFilterImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.radiusKm, radiusKm) ||
                other.radiusKm == radiusKm) &&
            (identical(other.createdAfter, createdAfter) ||
                other.createdAfter == createdAfter) &&
            (identical(other.createdBefore, createdBefore) ||
                other.createdBefore == createdBefore) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.offset, offset) || other.offset == offset));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      priority,
      category,
      location,
      radiusKm,
      createdAfter,
      createdBefore,
      searchQuery,
      const DeepCollectionEquality().hash(_tags),
      isVerified,
      userId,
      limit,
      offset);

  /// Create a copy of NeedFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NeedFilterImplCopyWith<_$NeedFilterImpl> get copyWith =>
      __$$NeedFilterImplCopyWithImpl<_$NeedFilterImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NeedFilterImplToJson(
      this,
    );
  }
}

abstract class _NeedFilter implements NeedFilter {
  const factory _NeedFilter(
      {final NeedStatus? status,
      final NeedPriority? priority,
      final NeedCategory? category,
      final String? location,
      final double? radiusKm,
      final DateTime? createdAfter,
      final DateTime? createdBefore,
      final String? searchQuery,
      final List<String>? tags,
      final bool? isVerified,
      final String? userId,
      final int? limit,
      final int? offset}) = _$NeedFilterImpl;

  factory _NeedFilter.fromJson(Map<String, dynamic> json) =
      _$NeedFilterImpl.fromJson;

  @override
  NeedStatus? get status;
  @override
  NeedPriority? get priority;
  @override
  NeedCategory? get category;
  @override
  String? get location;
  @override
  double? get radiusKm;
  @override
  DateTime? get createdAfter;
  @override
  DateTime? get createdBefore;
  @override
  String? get searchQuery;
  @override
  List<String>? get tags;
  @override
  bool? get isVerified;
  @override
  String? get userId;
  @override
  int? get limit;
  @override
  int? get offset;

  /// Create a copy of NeedFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NeedFilterImplCopyWith<_$NeedFilterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
