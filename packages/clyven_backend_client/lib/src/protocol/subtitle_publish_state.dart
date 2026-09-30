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

abstract class SubtitlePublishState implements _i1.SerializableModel {
  SubtitlePublishState._({
    this.id,
    required this.trackId,
    this.publishedPayload,
    this.publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : draftRevision = draftRevision ?? 0,
       publishedRevision = publishedRevision ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory SubtitlePublishState({
    int? id,
    required int trackId,
    String? publishedPayload,
    DateTime? publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SubtitlePublishStateImpl;

  factory SubtitlePublishState.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitlePublishState(
      id: jsonSerialization['id'] as int?,
      trackId: jsonSerialization['trackId'] as int,
      publishedPayload: jsonSerialization['publishedPayload'] as String?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      draftRevision: jsonSerialization['draftRevision'] as int?,
      publishedRevision: jsonSerialization['publishedRevision'] as int?,
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

  int trackId;

  String? publishedPayload;

  DateTime? publishedAt;

  int draftRevision;

  int publishedRevision;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubtitlePublishState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitlePublishState copyWith({
    int? id,
    int? trackId,
    String? publishedPayload,
    DateTime? publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitlePublishState',
      if (id != null) 'id': id,
      'trackId': trackId,
      if (publishedPayload != null) 'publishedPayload': publishedPayload,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'draftRevision': draftRevision,
      'publishedRevision': publishedRevision,
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

class _SubtitlePublishStateImpl extends SubtitlePublishState {
  _SubtitlePublishStateImpl({
    int? id,
    required int trackId,
    String? publishedPayload,
    DateTime? publishedAt,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         trackId: trackId,
         publishedPayload: publishedPayload,
         publishedAt: publishedAt,
         draftRevision: draftRevision,
         publishedRevision: publishedRevision,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SubtitlePublishState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitlePublishState copyWith({
    Object? id = _Undefined,
    int? trackId,
    Object? publishedPayload = _Undefined,
    Object? publishedAt = _Undefined,
    int? draftRevision,
    int? publishedRevision,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubtitlePublishState(
      id: id is int? ? id : this.id,
      trackId: trackId ?? this.trackId,
      publishedPayload: publishedPayload is String?
          ? publishedPayload
          : this.publishedPayload,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      draftRevision: draftRevision ?? this.draftRevision,
      publishedRevision: publishedRevision ?? this.publishedRevision,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
