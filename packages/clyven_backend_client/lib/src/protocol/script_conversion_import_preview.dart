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
import 'script_conversion_profile.dart' as _i2;
import 'script_conversion_import_preview_row.dart' as _i3;
import 'package:clyven_backend_client/src/protocol/protocol.dart' as _i4;

abstract class ScriptConversionImportPreview implements _i1.SerializableModel {
  ScriptConversionImportPreview._({
    required this.profile,
    required this.totalRows,
    required this.validRows,
    required this.warningRows,
    required this.errorRows,
    required this.rows,
  });

  factory ScriptConversionImportPreview({
    required _i2.ScriptConversionProfile profile,
    required int totalRows,
    required int validRows,
    required int warningRows,
    required int errorRows,
    required List<_i3.ScriptConversionImportPreviewRow> rows,
  }) = _ScriptConversionImportPreviewImpl;

  factory ScriptConversionImportPreview.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScriptConversionImportPreview(
      profile: _i4.Protocol().deserialize<_i2.ScriptConversionProfile>(
        jsonSerialization['profile'],
      ),
      totalRows: jsonSerialization['totalRows'] as int,
      validRows: jsonSerialization['validRows'] as int,
      warningRows: jsonSerialization['warningRows'] as int,
      errorRows: jsonSerialization['errorRows'] as int,
      rows: _i4.Protocol()
          .deserialize<List<_i3.ScriptConversionImportPreviewRow>>(
            jsonSerialization['rows'],
          ),
    );
  }

  _i2.ScriptConversionProfile profile;

  int totalRows;

  int validRows;

  int warningRows;

  int errorRows;

  List<_i3.ScriptConversionImportPreviewRow> rows;

  /// Returns a shallow copy of this [ScriptConversionImportPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScriptConversionImportPreview copyWith({
    _i2.ScriptConversionProfile? profile,
    int? totalRows,
    int? validRows,
    int? warningRows,
    int? errorRows,
    List<_i3.ScriptConversionImportPreviewRow>? rows,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScriptConversionImportPreview',
      'profile': profile.toJson(),
      'totalRows': totalRows,
      'validRows': validRows,
      'warningRows': warningRows,
      'errorRows': errorRows,
      'rows': rows.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ScriptConversionImportPreviewImpl extends ScriptConversionImportPreview {
  _ScriptConversionImportPreviewImpl({
    required _i2.ScriptConversionProfile profile,
    required int totalRows,
    required int validRows,
    required int warningRows,
    required int errorRows,
    required List<_i3.ScriptConversionImportPreviewRow> rows,
  }) : super._(
         profile: profile,
         totalRows: totalRows,
         validRows: validRows,
         warningRows: warningRows,
         errorRows: errorRows,
         rows: rows,
       );

  /// Returns a shallow copy of this [ScriptConversionImportPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScriptConversionImportPreview copyWith({
    _i2.ScriptConversionProfile? profile,
    int? totalRows,
    int? validRows,
    int? warningRows,
    int? errorRows,
    List<_i3.ScriptConversionImportPreviewRow>? rows,
  }) {
    return ScriptConversionImportPreview(
      profile: profile ?? this.profile.copyWith(),
      totalRows: totalRows ?? this.totalRows,
      validRows: validRows ?? this.validRows,
      warningRows: warningRows ?? this.warningRows,
      errorRows: errorRows ?? this.errorRows,
      rows: rows ?? this.rows.map((e0) => e0.copyWith()).toList(),
    );
  }
}
