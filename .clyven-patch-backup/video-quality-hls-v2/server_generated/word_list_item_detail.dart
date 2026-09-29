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
import 'word_list_item.dart' as _i2;
import 'dictionary_entry.dart' as _i3;
import 'dictionary_definition.dart' as _i4;
import 'package:clyven_backend_server/src/generated/protocol.dart' as _i5;

abstract class WordListItemDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  WordListItemDetail._({
    required this.item,
    required this.entry,
    required this.definitions,
  });

  factory WordListItemDetail({
    required _i2.WordListItem item,
    required _i3.DictionaryEntry entry,
    required List<_i4.DictionaryDefinition> definitions,
  }) = _WordListItemDetailImpl;

  factory WordListItemDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordListItemDetail(
      item: _i5.Protocol().deserialize<_i2.WordListItem>(
        jsonSerialization['item'],
      ),
      entry: _i5.Protocol().deserialize<_i3.DictionaryEntry>(
        jsonSerialization['entry'],
      ),
      definitions: _i5.Protocol().deserialize<List<_i4.DictionaryDefinition>>(
        jsonSerialization['definitions'],
      ),
    );
  }

  _i2.WordListItem item;

  _i3.DictionaryEntry entry;

  List<_i4.DictionaryDefinition> definitions;

  /// Returns a shallow copy of this [WordListItemDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WordListItemDetail copyWith({
    _i2.WordListItem? item,
    _i3.DictionaryEntry? entry,
    List<_i4.DictionaryDefinition>? definitions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordListItemDetail',
      'item': item.toJson(),
      'entry': entry.toJson(),
      'definitions': definitions.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WordListItemDetail',
      'item': item.toJsonForProtocol(),
      'entry': entry.toJsonForProtocol(),
      'definitions': definitions.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _WordListItemDetailImpl extends WordListItemDetail {
  _WordListItemDetailImpl({
    required _i2.WordListItem item,
    required _i3.DictionaryEntry entry,
    required List<_i4.DictionaryDefinition> definitions,
  }) : super._(
         item: item,
         entry: entry,
         definitions: definitions,
       );

  /// Returns a shallow copy of this [WordListItemDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WordListItemDetail copyWith({
    _i2.WordListItem? item,
    _i3.DictionaryEntry? entry,
    List<_i4.DictionaryDefinition>? definitions,
  }) {
    return WordListItemDetail(
      item: item ?? this.item.copyWith(),
      entry: entry ?? this.entry.copyWith(),
      definitions:
          definitions ?? this.definitions.map((e0) => e0.copyWith()).toList(),
    );
  }
}
