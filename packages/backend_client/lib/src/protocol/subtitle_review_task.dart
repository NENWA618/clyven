/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'subtitle_review_task_status.dart' as _i2;

abstract class SubtitleReviewTask implements _i1.SerializableModel {
  SubtitleReviewTask._({
    this.id,
    required this.videoId,
    required this.trackId,
    required this.languageCode,
    this.scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    this.assignedUserId,
    this.assignedDisplayName,
    this.editedByUserId,
    this.editedByDisplayName,
    this.reviewedByUserId,
    this.reviewedByDisplayName,
    this.approvedByUserId,
    this.approvedByDisplayName,
    this.claimedAt,
    this.startedAt,
    this.submittedAt,
    this.reviewedAt,
    this.completedAt,
    this.publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : status = status ?? _i2.SubtitleReviewTaskStatus.readyForReview,
       priority = priority ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitleReviewTask({
    int? id,
    required int videoId,
    required int trackId,
    required String languageCode,
    String? scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    String? assignedUserId,
    String? assignedDisplayName,
    String? editedByUserId,
    String? editedByDisplayName,
    String? reviewedByUserId,
    String? reviewedByDisplayName,
    String? approvedByUserId,
    String? approvedByDisplayName,
    DateTime? claimedAt,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    DateTime? completedAt,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitleReviewTaskImpl;

  factory SubtitleReviewTask.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleReviewTask(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as int,
      trackId: jsonSerialization['trackId'] as int,
      languageCode: jsonSerialization['languageCode'] as String,
      scriptCode: jsonSerialization['scriptCode'] as String?,
      status: jsonSerialization['status'] == null
          ? null
          : _i2.SubtitleReviewTaskStatus.fromJson(
              (jsonSerialization['status'] as String),
            ),
      priority: jsonSerialization['priority'] as int?,
      assignedUserId: jsonSerialization['assignedUserId'] as String?,
      assignedDisplayName: jsonSerialization['assignedDisplayName'] as String?,
      editedByUserId: jsonSerialization['editedByUserId'] as String?,
      editedByDisplayName: jsonSerialization['editedByDisplayName'] as String?,
      reviewedByUserId: jsonSerialization['reviewedByUserId'] as String?,
      reviewedByDisplayName:
          jsonSerialization['reviewedByDisplayName'] as String?,
      approvedByUserId: jsonSerialization['approvedByUserId'] as String?,
      approvedByDisplayName:
          jsonSerialization['approvedByDisplayName'] as String?,
      claimedAt: jsonSerialization['claimedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['claimedAt']),
      startedAt: jsonSerialization['startedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startedAt']),
      submittedAt: jsonSerialization['submittedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['submittedAt'],
            ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int videoId;

  int trackId;

  String languageCode;

  String? scriptCode;

  _i2.SubtitleReviewTaskStatus status;

  int priority;

  String? assignedUserId;

  String? assignedDisplayName;

  String? editedByUserId;

  String? editedByDisplayName;

  String? reviewedByUserId;

  String? reviewedByDisplayName;

  String? approvedByUserId;

  String? approvedByDisplayName;

  DateTime? claimedAt;

  DateTime? startedAt;

  DateTime? submittedAt;

  DateTime? reviewedAt;

  DateTime? completedAt;

  DateTime? publishedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubtitleReviewTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleReviewTask copyWith({
    int? id,
    int? videoId,
    int? trackId,
    String? languageCode,
    String? scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    String? assignedUserId,
    String? assignedDisplayName,
    String? editedByUserId,
    String? editedByDisplayName,
    String? reviewedByUserId,
    String? reviewedByDisplayName,
    String? approvedByUserId,
    String? approvedByDisplayName,
    DateTime? claimedAt,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    DateTime? completedAt,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleReviewTask',
      if (id != null) 'id': id,
      'videoId': videoId,
      'trackId': trackId,
      'languageCode': languageCode,
      if (scriptCode != null) 'scriptCode': scriptCode,
      'status': status.toJson(),
      'priority': priority,
      if (assignedUserId != null) 'assignedUserId': assignedUserId,
      if (assignedDisplayName != null)
        'assignedDisplayName': assignedDisplayName,
      if (editedByUserId != null) 'editedByUserId': editedByUserId,
      if (editedByDisplayName != null)
        'editedByDisplayName': editedByDisplayName,
      if (reviewedByUserId != null) 'reviewedByUserId': reviewedByUserId,
      if (reviewedByDisplayName != null)
        'reviewedByDisplayName': reviewedByDisplayName,
      if (approvedByUserId != null) 'approvedByUserId': approvedByUserId,
      if (approvedByDisplayName != null)
        'approvedByDisplayName': approvedByDisplayName,
      if (claimedAt != null) 'claimedAt': claimedAt?.toJson(),
      if (startedAt != null) 'startedAt': startedAt?.toJson(),
      if (submittedAt != null) 'submittedAt': submittedAt?.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleReviewTaskImpl extends SubtitleReviewTask {
  _SubtitleReviewTaskImpl({
    int? id,
    required int videoId,
    required int trackId,
    required String languageCode,
    String? scriptCode,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    String? assignedUserId,
    String? assignedDisplayName,
    String? editedByUserId,
    String? editedByDisplayName,
    String? reviewedByUserId,
    String? reviewedByDisplayName,
    String? approvedByUserId,
    String? approvedByDisplayName,
    DateTime? claimedAt,
    DateTime? startedAt,
    DateTime? submittedAt,
    DateTime? reviewedAt,
    DateTime? completedAt,
    DateTime? publishedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         videoId: videoId,
         trackId: trackId,
         languageCode: languageCode,
         scriptCode: scriptCode,
         status: status,
         priority: priority,
         assignedUserId: assignedUserId,
         assignedDisplayName: assignedDisplayName,
         editedByUserId: editedByUserId,
         editedByDisplayName: editedByDisplayName,
         reviewedByUserId: reviewedByUserId,
         reviewedByDisplayName: reviewedByDisplayName,
         approvedByUserId: approvedByUserId,
         approvedByDisplayName: approvedByDisplayName,
         claimedAt: claimedAt,
         startedAt: startedAt,
         submittedAt: submittedAt,
         reviewedAt: reviewedAt,
         completedAt: completedAt,
         publishedAt: publishedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitleReviewTask]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleReviewTask copyWith({
    Object? id = _Undefined,
    int? videoId,
    int? trackId,
    String? languageCode,
    Object? scriptCode = _Undefined,
    _i2.SubtitleReviewTaskStatus? status,
    int? priority,
    Object? assignedUserId = _Undefined,
    Object? assignedDisplayName = _Undefined,
    Object? editedByUserId = _Undefined,
    Object? editedByDisplayName = _Undefined,
    Object? reviewedByUserId = _Undefined,
    Object? reviewedByDisplayName = _Undefined,
    Object? approvedByUserId = _Undefined,
    Object? approvedByDisplayName = _Undefined,
    Object? claimedAt = _Undefined,
    Object? startedAt = _Undefined,
    Object? submittedAt = _Undefined,
    Object? reviewedAt = _Undefined,
    Object? completedAt = _Undefined,
    Object? publishedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitleReviewTask(
      id: id is int? ? id : this.id,
      videoId: videoId ?? this.videoId,
      trackId: trackId ?? this.trackId,
      languageCode: languageCode ?? this.languageCode,
      scriptCode: scriptCode is String? ? scriptCode : this.scriptCode,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      assignedUserId: assignedUserId is String?
          ? assignedUserId
          : this.assignedUserId,
      assignedDisplayName: assignedDisplayName is String?
          ? assignedDisplayName
          : this.assignedDisplayName,
      editedByUserId: editedByUserId is String?
          ? editedByUserId
          : this.editedByUserId,
      editedByDisplayName: editedByDisplayName is String?
          ? editedByDisplayName
          : this.editedByDisplayName,
      reviewedByUserId: reviewedByUserId is String?
          ? reviewedByUserId
          : this.reviewedByUserId,
      reviewedByDisplayName: reviewedByDisplayName is String?
          ? reviewedByDisplayName
          : this.reviewedByDisplayName,
      approvedByUserId: approvedByUserId is String?
          ? approvedByUserId
          : this.approvedByUserId,
      approvedByDisplayName: approvedByDisplayName is String?
          ? approvedByDisplayName
          : this.approvedByDisplayName,
      claimedAt: claimedAt is DateTime? ? claimedAt : this.claimedAt,
      startedAt: startedAt is DateTime? ? startedAt : this.startedAt,
      submittedAt: submittedAt is DateTime? ? submittedAt : this.submittedAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
