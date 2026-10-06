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

abstract class WordListItem implements _i1.SerializableModel {
  WordListItem._({
    this.id,
    required this.listId,
    required this.entryId,
    required this.position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory WordListItem({
    int? id,
    required int listId,
    required int entryId,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _WordListItemImpl;

  factory WordListItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordListItem(
      id: jsonSerialization['id'] as int?,
      listId: jsonSerialization['listId'] as int,
      entryId: jsonSerialization['entryId'] as int,
      position: jsonSerialization['position'] as int,
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

  int listId;

  int entryId;

  int position;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [WordListItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WordListItem copyWith({
    int? id,
    int? listId,
    int? entryId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordListItem',
      if (id != null) 'id': id,
      'listId': listId,
      'entryId': entryId,
      'position': position,
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

class _WordListItemImpl extends WordListItem {
  _WordListItemImpl({
    int? id,
    required int listId,
    required int entryId,
    required int position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         listId: listId,
         entryId: entryId,
         position: position,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [WordListItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WordListItem copyWith({
    Object? id = _Undefined,
    int? listId,
    int? entryId,
    int? position,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return WordListItem(
      id: id is int? ? id : this.id,
      listId: listId ?? this.listId,
      entryId: entryId ?? this.entryId,
      position: position ?? this.position,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
