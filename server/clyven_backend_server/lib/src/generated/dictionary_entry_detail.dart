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
import 'package:serverpod/serverpod.dart' as _i1;
import 'dictionary_entry.dart' as _i2;
import 'dictionary_definition.dart' as _i3;
import 'dictionary_relation_detail.dart' as _i4;
import 'package:clyven_backend_server/src/generated/protocol.dart' as _i5;

abstract class DictionaryEntryDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DictionaryEntryDetail._({
    required this.entry,
    required this.definitions,
    required this.relations,
  });

  factory DictionaryEntryDetail({
    required _i2.DictionaryEntry entry,
    required List<_i3.DictionaryDefinition> definitions,
    required List<_i4.DictionaryRelationDetail> relations,
  }) = _DictionaryEntryDetailImpl;

  factory DictionaryEntryDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryEntryDetail(
      entry: _i5.Protocol().deserialize<_i2.DictionaryEntry>(
        jsonSerialization['entry'],
      ),
      definitions: _i5.Protocol().deserialize<List<_i3.DictionaryDefinition>>(
        jsonSerialization['definitions'],
      ),
      relations: _i5.Protocol().deserialize<List<_i4.DictionaryRelationDetail>>(
        jsonSerialization['relations'],
      ),
    );
  }

  _i2.DictionaryEntry entry;

  List<_i3.DictionaryDefinition> definitions;

  List<_i4.DictionaryRelationDetail> relations;

  /// Returns a shallow copy of this [DictionaryEntryDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryEntryDetail copyWith({
    _i2.DictionaryEntry? entry,
    List<_i3.DictionaryDefinition>? definitions,
    List<_i4.DictionaryRelationDetail>? relations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryEntryDetail',
      'entry': entry.toJson(),
      'definitions': definitions.toJson(valueToJson: (v) => v.toJson()),
      'relations': relations.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryEntryDetail',
      'entry': entry.toJsonForProtocol(),
      'definitions': definitions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'relations': relations.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DictionaryEntryDetailImpl extends DictionaryEntryDetail {
  _DictionaryEntryDetailImpl({
    required _i2.DictionaryEntry entry,
    required List<_i3.DictionaryDefinition> definitions,
    required List<_i4.DictionaryRelationDetail> relations,
  }) : super._(
         entry: entry,
         definitions: definitions,
         relations: relations,
       );

  /// Returns a shallow copy of this [DictionaryEntryDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryEntryDetail copyWith({
    _i2.DictionaryEntry? entry,
    List<_i3.DictionaryDefinition>? definitions,
    List<_i4.DictionaryRelationDetail>? relations,
  }) {
    return DictionaryEntryDetail(
      entry: entry ?? this.entry.copyWith(),
      definitions:
          definitions ?? this.definitions.map((e0) => e0.copyWith()).toList(),
      relations:
          relations ?? this.relations.map((e0) => e0.copyWith()).toList(),
    );
  }
}
