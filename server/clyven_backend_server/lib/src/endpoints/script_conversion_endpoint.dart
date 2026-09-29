import 'dart:convert';

import 'package:clyven_nom_converter/clyven_nom_converter.dart' as core;
import 'package:excel/excel.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ScriptConversionEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {Scope.admin};

  Future<List<ScriptConversionProfile>> listProfiles(Session session) {
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
    String conversionMode = 'dictionary',
    String? typeColumn,
    String? description,
  }) async {
    final values = _cleanProfileValues(
      name: name,
      languageCode: languageCode,
      sourceScriptCode: sourceScriptCode,
      targetScriptCode: targetScriptCode,
      sourceColumn: sourceColumn,
      targetColumn: targetColumn,
      sheetName: sheetName,
      priorityColumn: priorityColumn,
      noteColumn: noteColumn,
      conversionMode: conversionMode,
      typeColumn: typeColumn,
      description: description,
    );

    return ScriptConversionProfile.db.insertRow(
      session,
      ScriptConversionProfile(
        name: values.name,
        languageCode: values.languageCode,
        sourceScriptCode: values.sourceScriptCode,
        targetScriptCode: values.targetScriptCode,
        sheetName: values.sheetName,
        sourceColumn: values.sourceColumn,
        targetColumn: values.targetColumn,
        priorityColumn: values.priorityColumn,
        noteColumn: values.noteColumn,
        conversionMode: values.conversionMode,
        typeColumn: values.typeColumn,
        description: values.description,
      ),
    );
  }

  Future<ScriptConversionProfile> updateProfile(
    Session session, {
    required int profileId,
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    required String sourceColumn,
    required String targetColumn,
    String? sheetName,
    String? priorityColumn,
    String? noteColumn,
    String conversionMode = 'dictionary',
    String? typeColumn,
    String? description,
  }) async {
    final profile = await _requireProfile(session, profileId);
    final values = _cleanProfileValues(
      name: name,
      languageCode: languageCode,
      sourceScriptCode: sourceScriptCode,
      targetScriptCode: targetScriptCode,
      sourceColumn: sourceColumn,
      targetColumn: targetColumn,
      sheetName: sheetName,
      priorityColumn: priorityColumn,
      noteColumn: noteColumn,
      conversionMode: conversionMode,
      typeColumn: typeColumn,
      description: description,
    );

    profile.name = values.name;
    profile.languageCode = values.languageCode;
    profile.sourceScriptCode = values.sourceScriptCode;
    profile.targetScriptCode = values.targetScriptCode;
    profile.sheetName = values.sheetName;
    profile.sourceColumn = values.sourceColumn;
    profile.targetColumn = values.targetColumn;
    profile.priorityColumn = values.priorityColumn;
    profile.noteColumn = values.noteColumn;
    profile.conversionMode = values.conversionMode;
    profile.typeColumn = values.typeColumn;
    profile.description = values.description;
    profile.updatedAt = DateTime.now();

    return ScriptConversionProfile.db.updateRow(session, profile);
  }

  Future<bool> deleteProfile(
    Session session, {
    required int profileId,
  }) async {
    await _requireProfile(session, profileId);

    await session.db.transaction((transaction) async {
      await ScriptConversionEntry.db.deleteWhere(
        session,
        where: (entry) => entry.profileId.equals(profileId),
        transaction: transaction,
      );
      await ScriptConversionProfile.db.deleteWhere(
        session,
        where: (profile) => profile.id.equals(profileId),
        transaction: transaction,
      );
    });

    return true;
  }

  Future<List<ScriptConversionEntry>> listEntries(
    Session session, {
    required int profileId,
    int limit = 200,
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

  Future<ScriptConversionEntry> updateEntry(
    Session session, {
    required int entryId,
    required String sourceText,
    required String targetText,
    required int priority,
    String? note,
    String? entryType,
  }) async {
    final entry = await ScriptConversionEntry.db.findById(session, entryId);
    if (entry == null) {
      throw ArgumentError('Script conversion entry not found: $entryId');
    }

    final source = sourceText.trim();
    final target = targetText.trim();
    if (source.isEmpty || target.isEmpty) {
      throw ArgumentError('Source and target text are required.');
    }

    entry.sourceText = source;
    entry.targetText = target;
    entry.priority = priority;
    entry.note = _cleanOptional(note);
    if (entryType != null) {
      entry.entryType = _normalizeEntryType(entryType);
    }
    entry.updatedAt = DateTime.now();

    return ScriptConversionEntry.db.updateRow(session, entry);
  }

  Future<bool> deleteEntry(
    Session session, {
    required int entryId,
  }) async {
    final deleted = await ScriptConversionEntry.db.deleteWhere(
      session,
      where: (entry) => entry.id.equals(entryId),
    );
    return deleted.isNotEmpty;
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
        final duplicateKey = '${row.entryType}\u0000$source\u0000$target';
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
          entryType: row.entryType,
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

        final duplicateKey = '${row.entryType}\u0000$source\u0000$target';
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
              entryType: row.entryType,
            ),
            transaction: transaction,
          );
          insertedRows++;
        } else {
          existing.priority = row.priority;
          existing.note = row.note;
          existing.entryType = row.entryType;
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
      sourceWordPattern: RegExp(r'[^\s.,!?;:()]+', unicode: true),
      normalizeSource: (value) => value.trim().replaceAll(RegExp(r'\s+'), ' '),
    );

    core.ScriptDictionary buildDictionary(
      Iterable<ScriptConversionEntry> rows,
    ) {
      return core.ScriptDictionary(
        rows.map(
          (entry) => core.ScriptDictionaryEntry(
            source: entry.sourceText,
            target: entry.targetText,
            priority: entry.priority,
            note: entry.note,
            metadata: <String, Object?>{
              'entryType': entry.entryType ?? 'dictionary',
              if (entry.metadataJson != null) 'raw': entry.metadataJson,
            },
          ),
        ),
        profile: conversionProfile,
      );
    }

    final dictionaryEntries = entries.where(
      (entry) => _normalizeEntryType(entry.entryType) == 'dictionary',
    );
    final exceptionEntries = entries.where(
      (entry) => _normalizeEntryType(entry.entryType) == 'exception',
    );
    final ruleEntries = entries.where((entry) {
      final type = _normalizeEntryType(entry.entryType);
      return type == 'character' || type == 'sequence';
    });

    final dictionary = buildDictionary(dictionaryEntries);
    final exceptions = buildDictionary(exceptionEntries);
    final rules = core.ScriptRuleSet(
      ruleEntries.map(
        (entry) => core.ScriptRuleEntry(
          source: entry.sourceText,
          target: entry.targetText,
          kind: _normalizeEntryType(entry.entryType),
          priority: entry.priority,
          note: entry.note,
          metadata: entry.metadataJson == null
              ? const <String, Object?>{}
              : <String, Object?>{'raw': entry.metadataJson},
        ),
      ),
    );

    final converter = core.ScriptConverter(
      profile: conversionProfile,
      dictionary: dictionary,
      exceptionDictionary: exceptions,
      rules: rules,
    );

    return reverse
        ? converter.convertReverse(text).convertedText
        : converter.convertForward(text).convertedText;
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

  _CleanProfileValues _cleanProfileValues({
    required String name,
    required String languageCode,
    required String sourceScriptCode,
    required String targetScriptCode,
    required String sourceColumn,
    required String targetColumn,
    String? sheetName,
    String? priorityColumn,
    String? noteColumn,
    String conversionMode = 'dictionary',
    String? typeColumn,
    String? description,
  }) {
    final cleanName = name.trim();
    final cleanLanguage = languageCode.trim();
    final cleanSourceScript = sourceScriptCode.trim();
    final cleanTargetScript = targetScriptCode.trim();
    final cleanSourceColumn = sourceColumn.trim();
    final cleanTargetColumn = targetColumn.trim();
    final cleanConversionMode = _normalizeConversionMode(conversionMode);

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

    return _CleanProfileValues(
      name: cleanName,
      languageCode: cleanLanguage,
      sourceScriptCode: cleanSourceScript,
      targetScriptCode: cleanTargetScript,
      sourceColumn: cleanSourceColumn,
      targetColumn: cleanTargetColumn,
      sheetName: _cleanOptional(sheetName),
      priorityColumn: _cleanOptional(priorityColumn),
      noteColumn: _cleanOptional(noteColumn),
      conversionMode: cleanConversionMode,
      typeColumn: _cleanOptional(typeColumn),
      description: _cleanOptional(description),
    );
  }

  String _normalizeConversionMode(String? value) {
    final mode = (value ?? 'dictionary').trim().toLowerCase();
    if (mode == 'dictionary' || mode == 'rules' || mode == 'hybrid') {
      return mode;
    }
    throw ArgumentError(
      'conversionMode must be dictionary, rules, or hybrid.',
    );
  }

  String _normalizeEntryType(String? value) {
    final type = (value ?? 'dictionary').trim().toLowerCase();
    return switch (type) {
      '' => 'dictionary',
      'dictionary' || 'word' || 'phrase' => 'dictionary',
      'exception' => 'exception',
      'sequence' || 'digraph' => 'sequence',
      'character' || 'char' || 'letter' => 'character',
      _ => throw ArgumentError(
        'entryType must be dictionary, exception, sequence, or character.',
      ),
    };
  }

  String _inferEntryType(
    ScriptConversionProfile profile,
    String? explicitType,
    String source,
  ) {
    if (explicitType != null && explicitType.trim().isNotEmpty) {
      return _normalizeEntryType(explicitType);
    }

    final mode = _normalizeConversionMode(profile.conversionMode);
    if (mode == 'rules') {
      return source.runes.length == 1 ? 'character' : 'sequence';
    }

    return 'dictionary';
  }

  String? _cleanOptional(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
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
    final typeIndex = profile.typeColumn == null
        ? null
        : columnIndex(profile.typeColumn!);

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
      final entryType = source == null
          ? 'dictionary'
          : _inferEntryType(profile, readCell(row, typeIndex), source);
      result.add(
        _ExcelConversionRow(
          rowNumber: rowIndex + 1,
          sourceText: source,
          targetText: target,
          priority: int.tryParse(rawPriority ?? '') ?? 0,
          note: readCell(row, noteIndex),
          entryType: entryType,
        ),
      );
    }

    return result;
  }
}

class _CleanProfileValues {
  const _CleanProfileValues({
    required this.name,
    required this.languageCode,
    required this.sourceScriptCode,
    required this.targetScriptCode,
    required this.sourceColumn,
    required this.targetColumn,
    required this.sheetName,
    required this.priorityColumn,
    required this.noteColumn,
    required this.conversionMode,
    required this.typeColumn,
    required this.description,
  });

  final String name;
  final String languageCode;
  final String sourceScriptCode;
  final String targetScriptCode;
  final String sourceColumn;
  final String targetColumn;
  final String? sheetName;
  final String? priorityColumn;
  final String? noteColumn;
  final String conversionMode;
  final String? typeColumn;
  final String? description;
}

class _ExcelConversionRow {
  const _ExcelConversionRow({
    required this.rowNumber,
    required this.sourceText,
    required this.targetText,
    required this.priority,
    required this.note,
    required this.entryType,
  });

  final int rowNumber;
  final String? sourceText;
  final String? targetText;
  final int priority;
  final String? note;
  final String entryType;
}
