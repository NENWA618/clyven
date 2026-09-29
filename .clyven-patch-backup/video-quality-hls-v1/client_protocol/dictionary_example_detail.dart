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
import 'dictionary_example.dart' as _i2;
import 'dictionary_example_text.dart' as _i3;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i4;

abstract class DictionaryExampleDetail implements _i1.SerializableModel {
  DictionaryExampleDetail._({
    required this.example,
    required this.texts,
  });

  factory DictionaryExampleDetail({
    required _i2.DictionaryExample example,
    required List<_i3.DictionaryExampleText> texts,
  }) = _DictionaryExampleDetailImpl;

  factory DictionaryExampleDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryExampleDetail(
      example: _i4.Protocol().deserialize<_i2.DictionaryExample>(
        jsonSerialization['example'],
      ),
      texts: _i4.Protocol().deserialize<List<_i3.DictionaryExampleText>>(
        jsonSerialization['texts'],
      ),
    );
  }

  _i2.DictionaryExample example;

  List<_i3.DictionaryExampleText> texts;

  /// Returns a shallow copy of this [DictionaryExampleDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryExampleDetail copyWith({
    _i2.DictionaryExample? example,
    List<_i3.DictionaryExampleText>? texts,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryExampleDetail',
      'example': example.toJson(),
      'texts': texts.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DictionaryExampleDetailImpl extends DictionaryExampleDetail {
  _DictionaryExampleDetailImpl({
    required _i2.DictionaryExample example,
    required List<_i3.DictionaryExampleText> texts,
  }) : super._(
         example: example,
         texts: texts,
       );

  /// Returns a shallow copy of this [DictionaryExampleDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryExampleDetail copyWith({
    _i2.DictionaryExample? example,
    List<_i3.DictionaryExampleText>? texts,
  }) {
    return DictionaryExampleDetail(
      example: example ?? this.example.copyWith(),
      texts: texts ?? this.texts.map((e0) => e0.copyWith()).toList(),
    );
  }
}
