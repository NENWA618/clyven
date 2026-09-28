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
import 'dictionary_relation.dart' as _i2;
import 'dictionary_entry.dart' as _i3;
import 'dictionary_definition.dart' as _i4;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i5;

abstract class DictionaryRelationDetail implements _i1.SerializableModel {
  DictionaryRelationDetail._({
    required this.relation,
    required this.targetEntry,
    required this.targetDefinitions,
  });

  factory DictionaryRelationDetail({
    required _i2.DictionaryRelation relation,
    required _i3.DictionaryEntry targetEntry,
    required List<_i4.DictionaryDefinition> targetDefinitions,
  }) = _DictionaryRelationDetailImpl;

  factory DictionaryRelationDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryRelationDetail(
      relation: _i5.Protocol().deserialize<_i2.DictionaryRelation>(
        jsonSerialization['relation'],
      ),
      targetEntry: _i5.Protocol().deserialize<_i3.DictionaryEntry>(
        jsonSerialization['targetEntry'],
      ),
      targetDefinitions: _i5.Protocol()
          .deserialize<List<_i4.DictionaryDefinition>>(
            jsonSerialization['targetDefinitions'],
          ),
    );
  }

  _i2.DictionaryRelation relation;

  _i3.DictionaryEntry targetEntry;

  List<_i4.DictionaryDefinition> targetDefinitions;

  /// Returns a shallow copy of this [DictionaryRelationDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryRelationDetail copyWith({
    _i2.DictionaryRelation? relation,
    _i3.DictionaryEntry? targetEntry,
    List<_i4.DictionaryDefinition>? targetDefinitions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryRelationDetail',
      'relation': relation.toJson(),
      'targetEntry': targetEntry.toJson(),
      'targetDefinitions': targetDefinitions.toJson(
        valueToJson: (v) => v.toJson(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DictionaryRelationDetailImpl extends DictionaryRelationDetail {
  _DictionaryRelationDetailImpl({
    required _i2.DictionaryRelation relation,
    required _i3.DictionaryEntry targetEntry,
    required List<_i4.DictionaryDefinition> targetDefinitions,
  }) : super._(
         relation: relation,
         targetEntry: targetEntry,
         targetDefinitions: targetDefinitions,
       );

  /// Returns a shallow copy of this [DictionaryRelationDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryRelationDetail copyWith({
    _i2.DictionaryRelation? relation,
    _i3.DictionaryEntry? targetEntry,
    List<_i4.DictionaryDefinition>? targetDefinitions,
  }) {
    return DictionaryRelationDetail(
      relation: relation ?? this.relation.copyWith(),
      targetEntry: targetEntry ?? this.targetEntry.copyWith(),
      targetDefinitions:
          targetDefinitions ??
          this.targetDefinitions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
