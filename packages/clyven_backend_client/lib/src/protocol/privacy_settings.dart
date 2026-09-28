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

abstract class PrivacySettings implements _i1.SerializableModel {
  PrivacySettings._({
    this.id,
    required this.userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) : privateAccount = privateAccount ?? false,
       allowComments = allowComments ?? true,
       showActivityStatus = showActivityStatus ?? true,
       updatedAt = updatedAt ?? DateTime.now();

  factory PrivacySettings({
    int? id,
    required String userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) = _PrivacySettingsImpl;

  factory PrivacySettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return PrivacySettings(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      privateAccount: jsonSerialization['privateAccount'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['privateAccount']),
      allowComments: jsonSerialization['allowComments'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['allowComments']),
      showActivityStatus: jsonSerialization['showActivityStatus'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['showActivityStatus'],
            ),
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

  bool privateAccount;

  bool allowComments;

  bool showActivityStatus;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PrivacySettings copyWith({
    int? id,
    String? userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PrivacySettings',
      if (id != null) 'id': id,
      'userId': userId,
      'privateAccount': privateAccount,
      'allowComments': allowComments,
      'showActivityStatus': showActivityStatus,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PrivacySettingsImpl extends PrivacySettings {
  _PrivacySettingsImpl({
    int? id,
    required String userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         privateAccount: privateAccount,
         allowComments: allowComments,
         showActivityStatus: showActivityStatus,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PrivacySettings copyWith({
    Object? id = _Undefined,
    String? userId,
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
    DateTime? updatedAt,
  }) {
    return PrivacySettings(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      privateAccount: privateAccount ?? this.privateAccount,
      allowComments: allowComments ?? this.allowComments,
      showActivityStatus: showActivityStatus ?? this.showActivityStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
