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

abstract class SubtitlePublishStatus implements _i1.SerializableModel {
  SubtitlePublishStatus._({
    required this.hasPublishedVersion,
    required this.hasUnpublishedChanges,
    required this.draftRevision,
    required this.publishedRevision,
    this.publishedAt,
  });

  factory SubtitlePublishStatus({
    required bool hasPublishedVersion,
    required bool hasUnpublishedChanges,
    required int draftRevision,
    required int publishedRevision,
    DateTime? publishedAt,
  }) = _SubtitlePublishStatusImpl;

  factory SubtitlePublishStatus.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitlePublishStatus(
      hasPublishedVersion: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['hasPublishedVersion'],
      ),
      hasUnpublishedChanges: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['hasUnpublishedChanges'],
      ),
      draftRevision: jsonSerialization['draftRevision'] as int,
      publishedRevision: jsonSerialization['publishedRevision'] as int,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
    );
  }

  bool hasPublishedVersion;

  bool hasUnpublishedChanges;

  int draftRevision;

  int publishedRevision;

  DateTime? publishedAt;

  /// Returns a shallow copy of this [SubtitlePublishStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitlePublishStatus copyWith({
    bool? hasPublishedVersion,
    bool? hasUnpublishedChanges,
    int? draftRevision,
    int? publishedRevision,
    DateTime? publishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitlePublishStatus',
      'hasPublishedVersion': hasPublishedVersion,
      'hasUnpublishedChanges': hasUnpublishedChanges,
      'draftRevision': draftRevision,
      'publishedRevision': publishedRevision,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubtitlePublishStatusImpl extends SubtitlePublishStatus {
  _SubtitlePublishStatusImpl({
    required bool hasPublishedVersion,
    required bool hasUnpublishedChanges,
    required int draftRevision,
    required int publishedRevision,
    DateTime? publishedAt,
  }) : super._(
         hasPublishedVersion: hasPublishedVersion,
         hasUnpublishedChanges: hasUnpublishedChanges,
         draftRevision: draftRevision,
         publishedRevision: publishedRevision,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [SubtitlePublishStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitlePublishStatus copyWith({
    bool? hasPublishedVersion,
    bool? hasUnpublishedChanges,
    int? draftRevision,
    int? publishedRevision,
    Object? publishedAt = _Undefined,
  }) {
    return SubtitlePublishStatus(
      hasPublishedVersion: hasPublishedVersion ?? this.hasPublishedVersion,
      hasUnpublishedChanges:
          hasUnpublishedChanges ?? this.hasUnpublishedChanges,
      draftRevision: draftRevision ?? this.draftRevision,
      publishedRevision: publishedRevision ?? this.publishedRevision,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
    );
  }
}
