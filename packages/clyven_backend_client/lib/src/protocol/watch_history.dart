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

abstract class WatchHistory implements _i1.SerializableModel {
  WatchHistory._({
    this.id,
    required this.userId,
    required this.videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) : positionSeconds = positionSeconds ?? 0,
       watchedAt = watchedAt ?? DateTime.now();

  factory WatchHistory({
    int? id,
    required String userId,
    required int videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) = _WatchHistoryImpl;

  factory WatchHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return WatchHistory(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as int,
      positionSeconds: jsonSerialization['positionSeconds'] as int?,
      watchedAt: jsonSerialization['watchedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['watchedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  int videoId;

  int positionSeconds;

  DateTime watchedAt;

  /// Returns a shallow copy of this [WatchHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WatchHistory copyWith({
    int? id,
    String? userId,
    int? videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WatchHistory',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'positionSeconds': positionSeconds,
      'watchedAt': watchedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _WatchHistoryImpl extends WatchHistory {
  _WatchHistoryImpl({
    int? id,
    required String userId,
    required int videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) : super._(
         id: id,
         userId: userId,
         videoId: videoId,
         positionSeconds: positionSeconds,
         watchedAt: watchedAt,
       );

  /// Returns a shallow copy of this [WatchHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WatchHistory copyWith({
    Object? id = _Undefined,
    String? userId,
    int? videoId,
    int? positionSeconds,
    DateTime? watchedAt,
  }) {
    return WatchHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      positionSeconds: positionSeconds ?? this.positionSeconds,
      watchedAt: watchedAt ?? this.watchedAt,
    );
  }
}
