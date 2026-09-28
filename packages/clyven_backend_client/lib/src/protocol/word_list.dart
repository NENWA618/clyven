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

abstract class WordList implements _i1.SerializableModel {
  WordList._({
    this.id,
    required this.name,
    required this.languageCode,
    this.description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WordList({
    int? id,
    required String name,
    required String languageCode,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WordListImpl;

  factory WordList.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordList(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      languageCode: jsonSerialization['languageCode'] as String,
      description: jsonSerialization['description'] as String?,
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

  String name;

  String languageCode;

  String? description;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WordList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WordList copyWith({
    int? id,
    String? name,
    String? languageCode,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordList',
      if (id != null) 'id': id,
      'name': name,
      'languageCode': languageCode,
      if (description != null) 'description': description,
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

class _WordListImpl extends WordList {
  _WordListImpl({
    int? id,
    required String name,
    required String languageCode,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         name: name,
         languageCode: languageCode,
         description: description,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WordList]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WordList copyWith({
    Object? id = _Undefined,
    String? name,
    String? languageCode,
    Object? description = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WordList(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      languageCode: languageCode ?? this.languageCode,
      description: description is String? ? description : this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
