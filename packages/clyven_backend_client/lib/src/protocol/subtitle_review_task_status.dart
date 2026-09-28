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

enum SubtitleReviewTaskStatus implements _i1.SerializableModel {
  readyForReview,
  assigned,
  inReview,
  readyForSecondReview,
  returned,
  approved,
  published,
  failed;

  static SubtitleReviewTaskStatus fromJson(String name) {
    switch (name) {
      case 'readyForReview':
        return SubtitleReviewTaskStatus.readyForReview;
      case 'assigned':
        return SubtitleReviewTaskStatus.assigned;
      case 'inReview':
        return SubtitleReviewTaskStatus.inReview;
      case 'readyForSecondReview':
        return SubtitleReviewTaskStatus.readyForSecondReview;
      case 'returned':
        return SubtitleReviewTaskStatus.returned;
      case 'approved':
        return SubtitleReviewTaskStatus.approved;
      case 'published':
        return SubtitleReviewTaskStatus.published;
      case 'failed':
        return SubtitleReviewTaskStatus.failed;
      default:
        throw ArgumentError(
          'Value "$name" cannot be converted to "SubtitleReviewTaskStatus"',
        );
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
