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

abstract class SubtitleReviewEvent implements _i1.SerializableModel {
  SubtitleReviewEvent._({
    this.id,
    required this.taskId,
    this.actorUserId,
    this.actorDisplayName,
    required this.action,
    this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory SubtitleReviewEvent({
    int? id,
    required int taskId,
    String? actorUserId,
    String? actorDisplayName,
    required String action,
    String? note,
    DateTime? createdAt,
  }) = _SubtitleReviewEventImpl;

  factory SubtitleReviewEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubtitleReviewEvent(
      id: jsonSerialization['id'] as int?,
      taskId: jsonSerialization['taskId'] as int,
      actorUserId: jsonSerialization['actorUserId'] as String?,
      actorDisplayName: jsonSerialization['actorDisplayName'] as String?,
      action: jsonSerialization['action'] as String,
      note: jsonSerialization['note'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int taskId;

  String? actorUserId;

  String? actorDisplayName;

  String action;

  String? note;

  DateTime createdAt;

  /// Returns a shallow copy of this [SubtitleReviewEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleReviewEvent copyWith({
    int? id,
    int? taskId,
    String? actorUserId,
    String? actorDisplayName,
    String? action,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleReviewEvent',
      if (id != null) 'id': id,
      'taskId': taskId,
      if (actorUserId != null) 'actorUserId': actorUserId,
      if (actorDisplayName != null) 'actorDisplayName': actorDisplayName,
      'action': action,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitleReviewEventImpl extends SubtitleReviewEvent {
  _SubtitleReviewEventImpl({
    int? id,
    required int taskId,
    String? actorUserId,
    String? actorDisplayName,
    required String action,
    String? note,
    DateTime? createdAt,
  }) : super._(
         id: id,
         taskId: taskId,
         actorUserId: actorUserId,
         actorDisplayName: actorDisplayName,
         action: action,
         note: note,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [SubtitleReviewEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleReviewEvent copyWith({
    Object? id = _Undefined,
    int? taskId,
    Object? actorUserId = _Undefined,
    Object? actorDisplayName = _Undefined,
    String? action,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return SubtitleReviewEvent(
      id: id is int? ? id : this.id,
      taskId: taskId ?? this.taskId,
      actorUserId: actorUserId is String? ? actorUserId : this.actorUserId,
      actorDisplayName: actorDisplayName is String?
          ? actorDisplayName
          : this.actorDisplayName,
      action: action ?? this.action,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
