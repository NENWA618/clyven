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
import 'dictionary_import_profile.dart' as _i2;
import 'dictionary_import_mapping.dart' as _i3;
import 'package:clyven_backend_server/src/generated/protocol.dart' as _i4;

abstract class DictionaryImportProfileDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  DictionaryImportProfileDetail._({
    required this.profile,
    required this.mappings,
  });

  factory DictionaryImportProfileDetail({
    required _i2.DictionaryImportProfile profile,
    required List<_i3.DictionaryImportMapping> mappings,
  }) = _DictionaryImportProfileDetailImpl;

  factory DictionaryImportProfileDetail.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return DictionaryImportProfileDetail(
      profile: _i4.Protocol().deserialize<_i2.DictionaryImportProfile>(
        jsonSerialization['profile'],
      ),
      mappings: _i4.Protocol().deserialize<List<_i3.DictionaryImportMapping>>(
        jsonSerialization['mappings'],
      ),
    );
  }

  _i2.DictionaryImportProfile profile;

  List<_i3.DictionaryImportMapping> mappings;

  /// Returns a shallow copy of this [DictionaryImportProfileDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictionaryImportProfileDetail copyWith({
    _i2.DictionaryImportProfile? profile,
    List<_i3.DictionaryImportMapping>? mappings,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictionaryImportProfileDetail',
      'profile': profile.toJson(),
      'mappings': mappings.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DictionaryImportProfileDetail',
      'profile': profile.toJsonForProtocol(),
      'mappings': mappings.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DictionaryImportProfileDetailImpl extends DictionaryImportProfileDetail {
  _DictionaryImportProfileDetailImpl({
    required _i2.DictionaryImportProfile profile,
    required List<_i3.DictionaryImportMapping> mappings,
  }) : super._(
         profile: profile,
         mappings: mappings,
       );

  /// Returns a shallow copy of this [DictionaryImportProfileDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictionaryImportProfileDetail copyWith({
    _i2.DictionaryImportProfile? profile,
    List<_i3.DictionaryImportMapping>? mappings,
  }) {
    return DictionaryImportProfileDetail(
      profile: profile ?? this.profile.copyWith(),
      mappings: mappings ?? this.mappings.map((e0) => e0.copyWith()).toList(),
    );
  }
}
