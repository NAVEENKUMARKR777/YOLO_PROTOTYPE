import 'package:freezed_annotation/freezed_annotation.dart';
import 'enums.dart';

part 'need_model.freezed.dart';
part 'need_model.g.dart';





@freezed
class Need with _$Need {
  const factory Need({
    required String id,
    required String title,
    required String description,
    required String requesterId,
    String? requesterName,
    required String category,
    required NeedPriority priority,
    required NeedStatus status,
    required InputMethod inputMethod,
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
    NeedUrgency? urgency,
  }) = _Need;

  factory Need.fromJson(Map<String, dynamic> json) => _$NeedFromJson(json);
}

@freezed
class NeedUpdate with _$NeedUpdate {
  const factory NeedUpdate({
    required String id,
    required String needId,
    required String userId,
    required String updateType,
    required String message,
    String? imageUrl,
    Map<String, dynamic>? data,
    DateTime? createdAt,
  }) = _NeedUpdate;

  factory NeedUpdate.fromJson(Map<String, dynamic> json) => _$NeedUpdateFromJson(json);
}

@freezed
class NeedComment with _$NeedComment {
  const factory NeedComment({
    required String id,
    required String needId,
    required String userId,
    required String comment,
    String? parentCommentId,
    List<String>? imageUrls,
    @Default(0) int likeCount,
    @Default(false) bool isEdited,
    @Default(false) bool isDeleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _NeedComment;

  factory NeedComment.fromJson(Map<String, dynamic> json) => _$NeedCommentFromJson(json);
}

@freezed
class NeedFilter with _$NeedFilter {
  const factory NeedFilter({
    NeedStatus? status,
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
    int? offset,
  }) = _NeedFilter;

  factory NeedFilter.fromJson(Map<String, dynamic> json) => _$NeedFilterFromJson(json);
}