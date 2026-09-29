import 'dart:convert';

import 'package:clyven_nom_converter/clyven_nom_converter.dart' as core;
import 'package:excel/excel.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ScriptConversionEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<List<ScriptConversionProfile>> listProfiles(
    Session session,
  ) {
    return ScriptConversionProfile.db.find(
      session,
      orderBy: (p) => p.languageCode,
      orderDescending: false,
    );
  }

  Future<ScriptConversionProfile> createProfile(
    Session session, {
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    required String sourceColumn,
    required String targetColumn,
    String? sheetName,
    String? priorityColumn,
    String? noteColumn,
    String? description,
  }) async {
    String? cleanOptional(String? value) {
      final text = value?.trim();
      return text == null || text.isEmpty ? null : text;
    }

    final cleanName = name.trim();
    final cleanLanguage = languageCode.trim();
    final cleanSourceScript = sourceScriptCode.trim();
    final cleanTargetScript = targetScriptCode.trim();
    final cleanSourceColumn = sourceColumn.trim();
    final cleanTargetColumn = targetColumn.trim();

    if (cleanName.isEmpty ||
        cleanLanguage.isEmpty ||
        cleanSourceScript.isEmpty ||
        cleanTargetScript.isEmpty ||
        cleanSourceColumn.isEmpty ||
        cleanTargetColumn.isEmpty) {
      throw ArgumentError(
        'Name, language, source/target scripts and source/target columns are required.',
      );
    }

    return ScriptConversionProfile.db.insertRow(
      session,
      ScriptConversionProfile(
        name: cleanName,
        languageCode: cleanLanguage,
        sourceScriptCode: cleanSourceScript,
        targetScriptCode: cleanTargetScript,
        sheetName: cleanOptional(sheetName),
        sourceColumn: cleanSourceColumn,
        targetColumn: cleanTargetColumn,
        priorityColumn: cleanOptional(priorityColumn),
        noteColumn: cleanOptional(noteColumn),
        description: cleanOptional(description),
      ),
    );
  }

  Future<ScriptConversionImportPreview> previewExcelBase64(
    Session session, {
    required int profileId,
    required String excelBase64,
  }) async {
    final profile = await _requireProfile(session, profileId);
    final rows = _readExcelRows(profile, excelBase64);

    var validRows = 0;
    var warningRows = 0;
    var errorRows = 0;
    final previewRows = <ScriptConversionImportPreviewRow>[];
    final seenPairs = <String>{};

    for (final row in rows) {
      final source = row.sourceText?.trim();
      final target = row.targetText?.trim();

      String status = 'ok';
      String? message;

      if (source == null ||
          source.isEmpty ||
          target == null ||
          target.isEmpty) {
        status = 'warning';
        message = 'Missing source or target text; this row will be skipped.';
        warningRows++;
      } else {
        final duplicateKey = '$source\u0000$target';
        if (!seenPairs.add(duplicateKey)) {
          status = 'warning';
          message = 'Duplicate source/target pair in this Excel file.';
          warningRows++;
        } else {
          validRows++;
        }
      }

      previewRows.add(
        ScriptConversionImportPreviewRow(
          rowNumber: row.rowNumber,
          sourceText: source,
          targetText: target,
          priority: row.priority,
          status: status,
          message: message,
        ),
      );
    }

    return ScriptConversionImportPreview(
      profile: profile,
      totalRows: rows.length,
      validRows: validRows,
      warningRows: warningRows,
      errorRows: errorRows,
      rows: previewRows,
    );
  }

  Future<ScriptConversionCommitResult> commitExcelBase64(
    Session session, {
    required int profileId,
    required String excelBase64,
  }) async {
    final profile = await _requireProfile(session, profileId);
    final rows = _readExcelRows(profile, excelBase64);

    var insertedRows = 0;
    var updatedRows = 0;
    var skippedRows = 0;
    final seenPairs = <String>{};

    await session.db.transaction((transaction) async {
      for (final row in rows) {
        final source = row.sourceText?.trim();
        final target = row.targetText?.trim();

        if (source == null ||
            source.isEmpty ||
            target == null ||
            target.isEmpty) {
          skippedRows++;
          continue;
        }

        final duplicateKey = '$source\u0000$target';
        if (!seenPairs.add(duplicateKey)) {
          skippedRows++;
          continue;
        }

        final existing = await ScriptConversionEntry.db.findFirstRow(
          session,
          where: (entry) =>
              entry.profileId.equals(profileId) &
              entry.sourceText.equals(source) &
              entry.targetText.equals(target),
          transaction: transaction,
        );

        if (existing == null) {
          await ScriptConversionEntry.db.insertRow(
            session,
            ScriptConversionEntry(
              profileId: profileId,
              sourceText: source,
              targetText: target,
              priority: row.priority,
              note: row.note,
            ),
            transaction: transaction,
          );
          insertedRows++;
        } else {
          existing.priority = row.priority;
          existing.note = row.note;
          existing.updatedAt = DateTime.now();

          await ScriptConversionEntry.db.updateRow(
            session,
            existing,
            transaction: transaction,
          );
          updatedRows++;
        }
      }
    });

    return ScriptConversionCommitResult(
      profileId: profileId,
      totalRows: rows.length,
      insertedRows: insertedRows,
      updatedRows: updatedRows,
      skippedRows: skippedRows,
    );
  }

  Future<String> testConvert(
    Session session, {
    required int profileId,
    required String text,
    bool reverse = false,
  }) async {
    final profile = await _requireProfile(session, profileId);
    final entries = await ScriptConversionEntry.db.find(
      session,
      where: (entry) => entry.profileId.equals(profileId),
      orderBy: (entry) => entry.priority,
      orderDescending: true,
    );

    if (entries.isEmpty || text.isEmpty) {
      return text;
    }

    final conversionProfile = core.ScriptConversionProfile(
      id: 'db-$profileId',
      languageCode: profile.languageCode,
      sourceScript: profile.sourceScriptCode,
      targetScript: profile.targetScriptCode,
      sourceWordPattern: RegExp(r'[^\\s.,!?;:()]+', unicode: true),
      normalizeSource: (value) => value.trim().replaceAll(RegExp(r'\s+'), ' '),
    );

    final dictionary = core.ScriptDictionary(
      entries.map(
        (entry) => core.ScriptDictionaryEntry(
          source: entry.sourceText,
          target: entry.targetText,
          priority: entry.priority,
          note: entry.note,
          metadata: entry.metadataJson == null
              ? const <String, Object?>{}
              : <String, Object?>{'raw': entry.metadataJson},
        ),
      ),
      profile: conversionProfile,
    );

    final converter = core.ScriptConverter(
      profile: conversionProfile,
      dictionary: dictionary,
    );

    return reverse
        ? converter.convertReverse(text).convertedText
        : converter.convertForward(text).convertedText;
  }

  Future<List<ScriptConversionEntry>> listEntries(
    Session session, {
    required int profileId,
    int limit = 100,
  }) {
    final safeLimit = limit.clamp(1, 500).toInt();
    return ScriptConversionEntry.db.find(
      session,
      where: (entry) => entry.profileId.equals(profileId),
      orderBy: (entry) => entry.priority,
      orderDescending: true,
      limit: safeLimit,
    );
  }

  Future<ScriptConversionProfile> _requireProfile(
    Session session,
    int profileId,
  ) async {
    final profile = await ScriptConversionProfile.db.findById(
      session,
      profileId,
    );
    if (profile == null) {
      throw ArgumentError('Script conversion profile not found: $profileId');
    }
    return profile;
  }

  List<_ExcelConversionRow> _readExcelRows(
    ScriptConversionProfile profile,
    String excelBase64,
  ) {
    final bytes = base64Decode(excelBase64);
    final workbook = Excel.decodeBytes(bytes);

    if (workbook.tables.isEmpty) {
      return const <_ExcelConversionRow>[];
    }

    final requestedSheet = profile.sheetName?.trim();
    final sheet = requestedSheet == null || requestedSheet.isEmpty
        ? workbook.tables.values.first
        : workbook.tables[requestedSheet];

    if (sheet == null) {
      throw FormatException('Excel sheet not found: $requestedSheet');
    }

    if (sheet.rows.isEmpty) {
      return const <_ExcelConversionRow>[];
    }

    final headers = <String>[
      for (final cell in sheet.rows.first) cell?.value?.toString().trim() ?? '',
    ];

    int columnIndex(String columnName) {
      final index = headers.indexOf(columnName);
      if (index < 0) {
        throw FormatException(
          'Excel column not found: $columnName. Found: ${headers.join(', ')}',
        );
      }
      return index;
    }

    final sourceIndex = columnIndex(profile.sourceColumn);
    final targetIndex = columnIndex(profile.targetColumn);
    final priorityIndex = profile.priorityColumn == null
        ? null
        : columnIndex(profile.priorityColumn!);
    final noteIndex = profile.noteColumn == null
        ? null
        : columnIndex(profile.noteColumn!);

    String? readCell(List<Data?> row, int? index) {
      if (index == null || index < 0 || index >= row.length) {
        return null;
      }
      final text = row[index]?.value?.toString().trim();
      return text == null || text.isEmpty ? null : text;
    }

    final result = <_ExcelConversionRow>[];

    for (var rowIndex = 1; rowIndex < sheet.rows.length; rowIndex++) {
      final row = sheet.rows[rowIndex];
      final source = readCell(row, sourceIndex);
      final target = readCell(row, targetIndex);

      if (source == null && target == null) {
        continue;
      }

      final rawPriority = readCell(row, priorityIndex);
      result.add(
        _ExcelConversionRow(
          rowNumber: rowIndex + 1,
          sourceText: source,
          targetText: target,
          priority: int.tryParse(rawPriority ?? '') ?? 0,
          note: readCell(row, noteIndex),
        ),
      );
    }

    return result;
  }
}

class _ExcelConversionRow {
  const _ExcelConversionRow({
    required this.rowNumber,
    required this.sourceText,
    required this.targetText,
    required this.priority,
    required this.note,
  });

  final int rowNumber;
  final String? sourceText;
  final String? targetText;
  final int priority;
  final String? note;
}
