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
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i3;

abstract class SubtitleReviewDashboard implements _i1.SerializableModel {
  SubtitleReviewDashboard._({
    required this.currentUserId,
    required this.currentDisplayName,
    required this.unclaimedCount,
    required this.myCount,
    required this.secondReviewCount,
    required this.completedCount,
    required this.unclaimed,
    required this.mine,
    required this.secondReview,
    required this.completed,
  });

  factory SubtitleReviewDashboard({
    required String currentUserId,
    required String currentDisplayName,
    required int unclaimedCount,
    required int myCount,
    required int secondReviewCount,
    required int completedCount,
    required List<_i2.SubtitleReviewQueueItem> unclaimed,
    required List<_i2.SubtitleReviewQueueItem> mine,
    required List<_i2.SubtitleReviewQueueItem> secondReview,
    required List<_i2.SubtitleReviewQueueItem> completed,
  }) = _SubtitleReviewDashboardImpl;

  factory SubtitleReviewDashboard.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubtitleReviewDashboard(
      currentUserId: jsonSerialization['currentUserId'] as String,
      currentDisplayName: jsonSerialization['currentDisplayName'] as String,
      unclaimedCount: jsonSerialization['unclaimedCount'] as int,
      myCount: jsonSerialization['myCount'] as int,
      secondReviewCount: jsonSerialization['secondReviewCount'] as int,
      completedCount: jsonSerialization['completedCount'] as int,
      unclaimed: _i3.Protocol().deserialize<List<_i2.SubtitleReviewQueueItem>>(
        jsonSerialization['unclaimed'],
      ),
      mine: _i3.Protocol().deserialize<List<_i2.SubtitleReviewQueueItem>>(
        jsonSerialization['mine'],
      ),
      secondReview: _i3.Protocol()
          .deserialize<List<_i2.SubtitleReviewQueueItem>>(
            jsonSerialization['secondReview'],
          ),
      completed: _i3.Protocol().deserialize<List<_i2.SubtitleReviewQueueItem>>(
        jsonSerialization['completed'],
      ),
    );
  }

  String currentUserId;

  String currentDisplayName;

  int unclaimedCount;

  int myCount;

  int secondReviewCount;

  int completedCount;

  List<_i2.SubtitleReviewQueueItem> unclaimed;

  List<_i2.SubtitleReviewQueueItem> mine;

  List<_i2.SubtitleReviewQueueItem> secondReview;

  List<_i2.SubtitleReviewQueueItem> completed;

  /// Returns a shallow copy of this [SubtitleReviewDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubtitleReviewDashboard copyWith({
    String? currentUserId,
    String? currentDisplayName,
    int? unclaimedCount,
    int? myCount,
    int? secondReviewCount,
    int? completedCount,
    List<_i2.SubtitleReviewQueueItem>? unclaimed,
    List<_i2.SubtitleReviewQueueItem>? mine,
    List<_i2.SubtitleReviewQueueItem>? secondReview,
    List<_i2.SubtitleReviewQueueItem>? completed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubtitleReviewDashboard',
      'currentUserId': currentUserId,
      'currentDisplayName': currentDisplayName,
      'unclaimedCount': unclaimedCount,
      'myCount': myCount,
      'secondReviewCount': secondReviewCount,
      'completedCount': completedCount,
      'unclaimed': unclaimed.toJson(valueToJson: (v) => v.toJson()),
      'mine': mine.toJson(valueToJson: (v) => v.toJson()),
      'secondReview': secondReview.toJson(valueToJson: (v) => v.toJson()),
      'completed': completed.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _SubtitleReviewDashboardImpl extends SubtitleReviewDashboard {
  _SubtitleReviewDashboardImpl({
    required String currentUserId,
    required String currentDisplayName,
    required int unclaimedCount,
    required int myCount,
    required int secondReviewCount,
    required int completedCount,
    required List<_i2.SubtitleReviewQueueItem> unclaimed,
    required List<_i2.SubtitleReviewQueueItem> mine,
    required List<_i2.SubtitleReviewQueueItem> secondReview,
    required List<_i2.SubtitleReviewQueueItem> completed,
  }) : super._(
         currentUserId: currentUserId,
         currentDisplayName: currentDisplayName,
         unclaimedCount: unclaimedCount,
         myCount: myCount,
         secondReviewCount: secondReviewCount,
         completedCount: completedCount,
         unclaimed: unclaimed,
         mine: mine,
         secondReview: secondReview,
         completed: completed,
       );

  /// Returns a shallow copy of this [SubtitleReviewDashboard]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubtitleReviewDashboard copyWith({
    String? currentUserId,
    String? currentDisplayName,
    int? unclaimedCount,
    int? myCount,
    int? secondReviewCount,
    int? completedCount,
    List<_i2.SubtitleReviewQueueItem>? unclaimed,
    List<_i2.SubtitleReviewQueueItem>? mine,
    List<_i2.SubtitleReviewQueueItem>? secondReview,
    List<_i2.SubtitleReviewQueueItem>? completed,
  }) {
    return SubtitleReviewDashboard(
      currentUserId: currentUserId ?? this.currentUserId,
      currentDisplayName: currentDisplayName ?? this.currentDisplayName,
      unclaimedCount: unclaimedCount ?? this.unclaimedCount,
      myCount: myCount ?? this.myCount,
      secondReviewCount: secondReviewCount ?? this.secondReviewCount,
      completedCount: completedCount ?? this.completedCount,
      unclaimed:
          unclaimed ?? this.unclaimed.map((e0) => e0.copyWith()).toList(),
      mine: mine ?? this.mine.map((e0) => e0.copyWith()).toList(),
      secondReview:
          secondReview ?? this.secondReview.map((e0) => e0.copyWith()).toList(),
      completed:
          completed ?? this.completed.map((e0) => e0.copyWith()).toList(),
    );
  }
}
