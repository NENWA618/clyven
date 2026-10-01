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
import 'subtitle_review_queue_item.dart' as _i2;
import 'subtitle_review_event.dart' as _i3;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i4;

abstract class SubtitleReviewTaskDetail implements _i1.SerializableModel {
  SubtitleReviewTaskDetail._({
    required this.item,
    required this.events,
  });

  factory SubtitleReviewTaskDetail({
    required _i2.SubtitleReviewQueueItem item,
    required List<_i3.SubtitleReviewEvent> events,
  }) = _SubtitleReviewTaskDetailImpl;

  factory SubtitleReviewTaskDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitleReviewTaskDetail(
      item: _i4.Protocol().deserialize<_i2.SubtitleReviewQueueItem>(
        jsonSerialization['item'],
      ),
      events: _i4.Protocol().deserialize<List<_i3.SubtitleReviewEvent>>(
        jsonSerialization['events'],
      ),
    );
  }

  _i2.SubtitleReviewQueueItem item;

  List<_i3.SubtitleReviewEvent> events;

  /// Returns a shallow copy of this [SubtitleReviewTaskDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleReviewTaskDetail copyWith({
    _i2.SubtitleReviewQueueItem? item,
    List<_i3.SubtitleReviewEvent>? events,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleReviewTaskDetail',
      'item': item.toJson(),
      'events': events.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SubtitleReviewTaskDetailImpl extends SubtitleReviewTaskDetail {
  _SubtitleReviewTaskDetailImpl({
    required _i2.SubtitleReviewQueueItem item,
    required List<_i3.SubtitleReviewEvent> events,
  }) : super._(
         item: item,
         events: events,
       );

  /// Returns a shallow copy of this [SubtitleReviewTaskDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleReviewTaskDetail copyWith({
    _i2.SubtitleReviewQueueItem? item,
    List<_i3.SubtitleReviewEvent>? events,
  }) {
    return SubtitleReviewTaskDetail(
      item: item ?? this.item.copyWith(),
      events: events ?? this.events.map((e0) => e0.copyWith()).toList(),
    );
  }
}
