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

abstract class NotificationSettings implements _i1.SerializableModel {
  NotificationSettings._({
    this.id,
    required this.userId,
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
    DateTime? updatedAt,
  }) : pushEnabled = pushEnabled ?? true,
       likeEnabled = likeEnabled ?? true,
       commentEnabled = commentEnabled ?? true,
       followEnabled = followEnabled ?? true,
       updatedAt = updatedAt ?? DateTime.now();

  factory NotificationSettings({
    int? id,
    required String userId,
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
    DateTime? updatedAt,
  }) = _NotificationSettingsImpl;

  factory NotificationSettings.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return NotificationSettings(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      pushEnabled: jsonSerialization['pushEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['pushEnabled']),
      likeEnabled: jsonSerialization['likeEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['likeEnabled']),
      commentEnabled: jsonSerialization['commentEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['commentEnabled']),
      followEnabled: jsonSerialization['followEnabled'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['followEnabled']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userId;

  bool pushEnabled;

  bool likeEnabled;

  bool commentEnabled;

  bool followEnabled;

  DateTime updatedAt;

  /// Returns a shallow copy of this [NotificationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  NotificationSettings copyWith({
    int? id,
    String? userId,
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'NotificationSettings',
      if (id != null) 'id': id,
      'userId': userId,
      'pushEnabled': pushEnabled,
      'likeEnabled': likeEnabled,
      'commentEnabled': commentEnabled,
      'followEnabled': followEnabled,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationSettingsImpl extends NotificationSettings {
  _NotificationSettingsImpl({
    int? id,
    required String userId,
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         pushEnabled: pushEnabled,
         likeEnabled: likeEnabled,
         commentEnabled: commentEnabled,
         followEnabled: followEnabled,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [NotificationSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  NotificationSettings copyWith({
    Object? id = _Undefined,
    String? userId,
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
    DateTime? updatedAt,
  }) {
    return NotificationSettings(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      likeEnabled: likeEnabled ?? this.likeEnabled,
      commentEnabled: commentEnabled ?? this.commentEnabled,
      followEnabled: followEnabled ?? this.followEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
