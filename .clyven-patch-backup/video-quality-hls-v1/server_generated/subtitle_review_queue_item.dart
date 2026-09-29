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
import 'package:serverpod/serverpod.dart' as _i1;
import 'subtitle_review_task.dart' as _i2;
import 'package:clyven_backend_server/src/generated/protocol.dart' as _i3;

abstract class SubtitleReviewQueueItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  SubtitleReviewQueueItem._({
    required this.task,
    required this.videoTitle,
    required this.videoAuthorName,
    required this.durationSeconds,
    required this.isMine,
  });

  factory SubtitleReviewQueueItem({
    required _i2.SubtitleReviewTask task,
    required String videoTitle,
    required String videoAuthorName,
    required int durationSeconds,
    required bool isMine,
  }) = _SubtitleReviewQueueItemImpl;

  factory SubtitleReviewQueueItem.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitleReviewQueueItem(
      task: _i3.Protocol().deserialize<_i2.SubtitleReviewTask>(
        jsonSerialization['task'],
      ),
      videoTitle: jsonSerialization['videoTitle'] as String,
      videoAuthorName: jsonSerialization['videoAuthorName'] as String,
      durationSeconds: jsonSerialization['durationSeconds'] as int,
      isMine: _i1.BoolJsonExtension.fromJson(jsonSerialization['isMine']),
    );
  }

  _i2.SubtitleReviewTask task;

  String videoTitle;

  String videoAuthorName;

  int durationSeconds;

  bool isMine;

  /// Returns a shallow copy of this [SubtitleReviewQueueItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleReviewQueueItem copyWith({
    _i2.SubtitleReviewTask? task,
    String? videoTitle,
    String? videoAuthorName,
    int? durationSeconds,
    bool? isMine,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleReviewQueueItem',
      'task': task.toJson(),
      'videoTitle': videoTitle,
      'videoAuthorName': videoAuthorName,
      'durationSeconds': durationSeconds,
      'isMine': isMine,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubtitleReviewQueueItem',
      'task': task.toJsonForProtocol(),
      'videoTitle': videoTitle,
      'videoAuthorName': videoAuthorName,
      'durationSeconds': durationSeconds,
      'isMine': isMine,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SubtitleReviewQueueItemImpl extends SubtitleReviewQueueItem {
  _SubtitleReviewQueueItemImpl({
    required _i2.SubtitleReviewTask task,
    required String videoTitle,
    required String videoAuthorName,
    required int durationSeconds,
    required bool isMine,
  }) : super._(
         task: task,
         videoTitle: videoTitle,
         videoAuthorName: videoAuthorName,
         durationSeconds: durationSeconds,
         isMine: isMine,
       );

  /// Returns a shallow copy of this [SubtitleReviewQueueItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleReviewQueueItem copyWith({
    _i2.SubtitleReviewTask? task,
    String? videoTitle,
    String? videoAuthorName,
    int? durationSeconds,
    bool? isMine,
  }) {
    return SubtitleReviewQueueItem(
      task: task ?? this.task.copyWith(),
      videoTitle: videoTitle ?? this.videoTitle,
      videoAuthorName: videoAuthorName ?? this.videoAuthorName,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      isMine: isMine ?? this.isMine,
    );
  }
}
