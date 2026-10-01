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
import 'notification_type.dart' as _i2;

abstract class AppNotification implements _i1.SerializableModel {
  AppNotification._({
    this.id,
    required this.recipientId,
    required this.actorId,
    required this.actorName,
    required this.type,
    this.videoId,
    this.commentPreview,
    bool? isRead,
    DateTime? createdAt,
  }) : isRead = isRead ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory AppNotification({
    int? id,
    required String recipientId,
    required String actorId,
    required String actorName,
    required _i2.NotificationType type,
    int? videoId,
    String? commentPreview,
    bool? isRead,
    DateTime? createdAt,
  }) = _AppNotificationImpl;

  factory AppNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppNotification(
      id: jsonSerialization['id'] as int?,
      recipientId: jsonSerialization['recipientId'] as String,
      actorId: jsonSerialization['actorId'] as String,
      actorName: jsonSerialization['actorName'] as String,
      type: _i2.NotificationType.fromJson(
        (jsonSerialization['type'] as String),
      ),
      videoId: jsonSerialization['videoId'] as int?,
      commentPreview: jsonSerialization['commentPreview'] as String?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String recipientId;

  String actorId;

  String actorName;

  _i2.NotificationType type;

  int? videoId;

  String? commentPreview;

  bool isRead;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppNotification copyWith({
    int? id,
    String? recipientId,
    String? actorId,
    String? actorName,
    _i2.NotificationType? type,
    int? videoId,
    String? commentPreview,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'recipientId': recipientId,
      'actorId': actorId,
      'actorName': actorName,
      'type': type.toJson(),
      if (videoId != null) 'videoId': videoId,
      if (commentPreview != null) 'commentPreview': commentPreview,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppNotificationImpl extends AppNotification {
  _AppNotificationImpl({
    int? id,
    required String recipientId,
    required String actorId,
    required String actorName,
    required _i2.NotificationType type,
    int? videoId,
    String? commentPreview,
    bool? isRead,
    DateTime? createdAt,
  }) : super._(
         id: id,
         recipientId: recipientId,
         actorId: actorId,
         actorName: actorName,
         type: type,
         videoId: videoId,
         commentPreview: commentPreview,
         isRead: isRead,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppNotification copyWith({
    Object? id = _Undefined,
    String? recipientId,
    String? actorId,
    String? actorName,
    _i2.NotificationType? type,
    Object? videoId = _Undefined,
    Object? commentPreview = _Undefined,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id is int? ? id : this.id,
      recipientId: recipientId ?? this.recipientId,
      actorId: actorId ?? this.actorId,
      actorName: actorName ?? this.actorName,
      type: type ?? this.type,
      videoId: videoId is int? ? videoId : this.videoId,
      commentPreview: commentPreview is String?
          ? commentPreview
          : this.commentPreview,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
