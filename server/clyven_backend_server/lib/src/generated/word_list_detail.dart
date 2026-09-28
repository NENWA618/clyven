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
import 'word_list.dart' as _i2;
import 'word_list_item_detail.dart' as _i3;
import 'package:clyven_backend_server/src/generated/protocol.dart' as _i4;

abstract class WordListDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  WordListDetail._({
    required this.wordList,
    required this.items,
  });

  factory WordListDetail({
    required _i2.WordList wordList,
    required List<_i3.WordListItemDetail> items,
  }) = _WordListDetailImpl;

  factory WordListDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return WordListDetail(
      wordList: _i4.Protocol().deserialize<_i2.WordList>(
        jsonSerialization['wordList'],
      ),
      items: _i4.Protocol().deserialize<List<_i3.WordListItemDetail>>(
        jsonSerialization['items'],
      ),
    );
  }

  _i2.WordList wordList;

  List<_i3.WordListItemDetail> items;

  /// Returns a shallow copy of this [WordListDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  WordListDetail copyWith({
    _i2.WordList? wordList,
    List<_i3.WordListItemDetail>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'WordListDetail',
      'wordList': wordList.toJson(),
      'items': items.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'WordListDetail',
      'wordList': wordList.toJsonForProtocol(),
      'items': items.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _WordListDetailImpl extends WordListDetail {
  _WordListDetailImpl({
    required _i2.WordList wordList,
    required List<_i3.WordListItemDetail> items,
  }) : super._(
         wordList: wordList,
         items: items,
       );

  /// Returns a shallow copy of this [WordListDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  WordListDetail copyWith({
    _i2.WordList? wordList,
    List<_i3.WordListItemDetail>? items,
  }) {
    return WordListDetail(
      wordList: wordList ?? this.wordList.copyWith(),
      items: items ?? this.items.map((e0) => e0.copyWith()).toList(),
    );
  }
}
