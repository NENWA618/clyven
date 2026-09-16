import 'dart:convert';

import 'package:excel/excel.dart';
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../services/dictionary_import_writer.dart';

class DictionaryImportEndpoint extends Endpoint {
  Future<List<DictionaryImportProfile>> getProfiles(
    Session session, {
    String? languageCode,
  }) {
    return DictionaryImportProfile.db.find(
      session,
      where: languageCode == null
          ? null
          : (p) =>
              p.languageCode.equals(languageCode),
      orderBy: (p) => p.name,
    );
  }

  Future<DictionaryImportProfileDetail?>
      getProfile(
    Session session, {
    required int profileId,
  }) async {
    final profile =
        await DictionaryImportProfile.db.findById(
      session,
      profileId,
    );

    if (profile == null) {
      return null;
    }

    final mappings =
        await DictionaryImportMapping.db.find(
      session,
      where: (m) =>
          m.profileId.equals(profileId),
      orderBy: (m) => m.position,
    );

    return DictionaryImportProfileDetail(
      profile: profile,
      mappings: mappings,
    );
  }

  Future<DictionaryImportProfileDetail>
      createVietnameseVocabularyProfile(
    Session session,
  ) async {
    final existing =
        await DictionaryImportProfile.db.findFirstRow(
      session,
      where: (p) =>
          p.languageCode.equals('vi') &
          p.sheetName.equals('词汇') &
          p.name.equals('越南语主词表'),
    );

    if (existing != null) {
  var mappings =
      await DictionaryImportMapping.db.find(
    session,
    where: (m) =>
        m.profileId.equals(existing.id),
    orderBy: (m) => m.position,
  );

  for (final mapping in mappings) {
    if (mapping.sourceColumn == '词性' &&
        mapping.targetType == 'entry' &&
        mapping.targetField == 'partOfSpeech') {
      mapping.transformType = 'valueMap';
      mapping.transformConfig = jsonEncode({
        '代词': 'pronoun',
        '名词': 'noun',
        '动词': 'verb',
        '形容词': 'adjective',
        '副词': 'adverb',
        '介词': 'preposition',
        '连词': 'conjunction',
        '数词': 'numeral',
        '量词': 'classifier',
        '助词': 'particle',
        '感叹词': 'interjection',
      });

      await DictionaryImportMapping.db.updateRow(
        session,
        mapping,
      );
    }
  }

  mappings =
      await DictionaryImportMapping.db.find(
    session,
    where: (m) =>
        m.profileId.equals(existing.id),
    orderBy: (m) => m.position,
  );

  return DictionaryImportProfileDetail(
    profile: existing,
    mappings: mappings,
  );
}

    final profile =
        await DictionaryImportProfile.db.insertRow(
      session,
      DictionaryImportProfile(
        name: '越南语主词表',
        languageCode: 'vi',
        sheetName: '词汇',
        defaultEntryType: 'word',
        primaryScriptCode: 'latn',
        description:
            '越南语国语字、喃字、中文释义与多文字例句导入模板',
      ),
    );

    final profileId = profile.id!;

    final mappings = [
      DictionaryImportMapping(
        profileId: profileId,
        sourceColumn: '国语字',
        targetType: 'entry',
        targetField: 'text',
        languageCode: 'vi',
        scriptCode: 'latn',
        position: 0,
        required: true,
      ),

      DictionaryImportMapping(
        profileId: profileId,
        sourceColumn: '喃字',
        targetType: 'form',
        targetField: 'text',
        languageCode: 'vi',
        scriptCode: 'nom',
        position: 1,
      ),

      DictionaryImportMapping(
        profileId: profileId,
        sourceColumn: '中文',
        targetType: 'definition',
        targetField: 'gloss',
        languageCode: 'zh',
        scriptCode: 'hans',
        position: 2,
      ),

      DictionaryImportMapping(
  profileId: profileId,
  sourceColumn: '词性',
  targetType: 'entry',
  targetField: 'partOfSpeech',
  transformType: 'valueMap',
  transformConfig: jsonEncode({
    '代词': 'pronoun',
    '名词': 'noun',
    '动词': 'verb',
    '形容词': 'adjective',
    '副词': 'adverb',
    '介词': 'preposition',
    '连词': 'conjunction',
    '数词': 'numeral',
    '量词': 'classifier',
    '助词': 'particle',
    '感叹词': 'interjection',
  }),
  position: 3,
),

      DictionaryImportMapping(
        profileId: profileId,
        sourceColumn: '国语字例句',
        targetType: 'example',
        targetField: 'text',
        languageCode: 'vi',
        scriptCode: 'latn',
        groupKey: 'example_1',
        position: 4,
      ),

      DictionaryImportMapping(
        profileId: profileId,
        sourceColumn: '喃字例句',
        targetType: 'example',
        targetField: 'text',
        languageCode: 'vi',
        scriptCode: 'nom',
        groupKey: 'example_1',
        position: 5,
      ),

      DictionaryImportMapping(
        profileId: profileId,
        sourceColumn: '中文例句',
        targetType: 'example',
        targetField: 'text',
        languageCode: 'zh',
        scriptCode: 'hans',
        groupKey: 'example_1',
        position: 6,
      ),
    ];

    final insertedMappings =
        await DictionaryImportMapping.db.insert(
      session,
      mappings,
    );

    return DictionaryImportProfileDetail(
      profile: profile,
      mappings: insertedMappings,
    );
  }

  Future<DictionaryImportPreview?> previewRows(
  Session session, {
  required int profileId,
  required List<String> rowsJson,
}) async {
  final profile =
      await DictionaryImportProfile.db.findById(
    session,
    profileId,
  );

  if (profile == null) {
    return null;
  }

  final mappings =
      await DictionaryImportMapping.db.find(
    session,
    where: (m) =>
        m.profileId.equals(profileId),
    orderBy: (m) => m.position,
  );

  final previewRows =
    <DictionaryImportPreviewRow>[];


var validRows = 0;
var warningRows = 0;
var errorRows = 0;

  for (var i = 0; i < rowsJson.length; i++) {
    var rowNumber = i + 2;

    Map<String, dynamic> rawRow;

    try {
      final decoded = jsonDecode(
        rowsJson[i],
      );

      if (decoded is! Map) {
        throw const FormatException(
          'Row JSON must be an object',
        );
      }

      rawRow = Map<String, dynamic>.from(
        decoded,
      );

      final originalRowNumber =
          rawRow['__rowNumber'];

      if (originalRowNumber is int) {
        rowNumber = originalRowNumber;
      } else if (originalRowNumber != null) {
        rowNumber =
            int.tryParse(
              originalRowNumber.toString(),
            ) ??
            rowNumber;
      }
    } catch (_) {
      errorRows++;

      previewRows.add(
        DictionaryImportPreviewRow(
          rowNumber: rowNumber,
          status: 'error',
          message: '无法解析这一行数据',
          normalizedJson: '{}',
        ),
      );

      continue;
    }

    String? cleanValue(dynamic value) {
      if (value == null) {
        return null;
      }

      final text = value.toString().trim();

      if (text.isEmpty) {
        return null;
      }

      return text;
    }

    final entry = <String, dynamic>{
      'languageCode': profile.languageCode,
      'entryType':
          profile.defaultEntryType ?? 'word',
      'primaryScriptCode':
          profile.primaryScriptCode,
    };

    final forms =
        <Map<String, dynamic>>[];

    final definitions =
        <Map<String, dynamic>>[];

    final relations =
        <Map<String, dynamic>>[];

    final morphology =
        <Map<String, dynamic>>[];

    final exampleGroups =
        <String, List<Map<String, dynamic>>>{};

    final missingRequired =
        <String>[];

    for (final mapping in mappings) {
      var value = cleanValue(
  rawRow[mapping.sourceColumn],
);

if (value == null) {
  if (mapping.required) {
    missingRequired.add(
      mapping.sourceColumn,
    );
  }

  continue;
}

switch (mapping.transformType) {
  case 'valueMap':
    if (mapping.transformConfig != null) {
      final config = jsonDecode(
        mapping.transformConfig!,
      );

      if (config is Map &&
          config.containsKey(value)) {
        value = config[value].toString();
      }
    }

    break;

  case 'lowercase':
    value = value.toLowerCase();
    break;

  case 'uppercase':
    value = value.toUpperCase();
    break;

  case 'trim':
    value = value.trim();
    break;
}

      switch (mapping.targetType) {
        case 'entry':
          if (mapping.targetField != null) {
            entry[mapping.targetField!] = value;
          }

          break;

        case 'form':
          forms.add({
            'field':
                mapping.targetField ?? 'text',
            'text': value,
            'languageCode':
                mapping.languageCode ??
                profile.languageCode,
            'scriptCode':
                mapping.scriptCode,
          });

          break;

        case 'definition':
          definitions.add({
            'field':
                mapping.targetField ?? 'gloss',
            'value': value,
            'languageCode':
                mapping.languageCode,
            'scriptCode':
                mapping.scriptCode,
          });

          break;

        case 'example':
          final groupKey =
              mapping.groupKey ??
              'example_default';

          final group = exampleGroups
              .putIfAbsent(
            groupKey,
            () => <Map<String, dynamic>>[],
          );

          group.add({
            'text': value,
            'languageCode':
                mapping.languageCode,
            'scriptCode':
                mapping.scriptCode,
          });

          break;

        case 'relation':
          relations.add({
            'value': value,
            'relationType':
                mapping.relationType,
            'languageCode':
                mapping.languageCode,
            'scriptCode':
                mapping.scriptCode,
          });

          break;

        case 'morphology':
          morphology.add({
            'field':
                mapping.targetField ??
                mapping.sourceColumn,
            'value': value,
          });

          break;
      }
    }

    final headword =
    cleanValue(entry['text']);

String status;
String? message;

if (missingRequired.isNotEmpty) {
  status = 'warning';
  message =
      '词条尚未完成：缺少 ${missingRequired.join(', ')}；正式导入时会跳过';
  warningRows++;
} else if (headword == null) {
  status = 'warning';
  message =
      '词条尚未完成：没有主词；正式导入时会跳过';
  warningRows++;
} else {
  status = 'ok';
  validRows++;
}

    final normalized = {
      'entry': entry,
      'forms': forms,
      'definitions': definitions,
      'examples': [
        for (final item
            in exampleGroups.entries)
          {
            'groupKey': item.key,
            'texts': item.value,
          },
      ],
      'relations': relations,
      'morphology': morphology,
    };

    previewRows.add(
      DictionaryImportPreviewRow(
        rowNumber: rowNumber,
        headword: headword,
        entryType:
            entry['entryType']?.toString(),
        status: status,
        message: message,
        normalizedJson: jsonEncode(
          normalized,
        ),
      ),
    );
  }

  return DictionaryImportPreview(
    profile: profile,
    totalRows: rowsJson.length,
    validRows: validRows,
    warningRows: warningRows,
    errorRows: errorRows,
    rows: previewRows,
  );
}

Future<DictionaryImportPreview?> previewExcelBase64(
  Session session, {
  required int profileId,
  required String excelBase64,
}) async {
  final profile =
      await DictionaryImportProfile.db.findById(
    session,
    profileId,
  );

  if (profile == null) {
    return null;
  }

  final bytes = base64Decode(
    excelBase64,
  );

  final workbook = Excel.decodeBytes(
    bytes,
  );

  final sheet =
      workbook.tables[profile.sheetName];

  if (sheet == null) {
    throw FormatException(
      '找不到工作表：${profile.sheetName}',
    );
  }

  if (sheet.rows.isEmpty) {
    return DictionaryImportPreview(
      profile: profile,
      totalRows: 0,
      validRows: 0,
      warningRows: 0,
      errorRows: 0,
      rows: [],
    );
  }

  // 第一行作为 Excel 列名。
  final headerRow = sheet.rows.first;

  final headers = [
    for (final cell in headerRow)
      cell?.value?.toString().trim() ?? '',
  ];

  final rowsJson = <String>[];

  // 从第二行开始读取实际词条。
  for (
    var rowIndex = 1;
    rowIndex < sheet.rows.length;
    rowIndex++
  ) {
    final excelRow =
        sheet.rows[rowIndex];

    final rawRow =
        <String, dynamic>{};

    var hasAnyValue = false;

    for (
      var columnIndex = 0;
      columnIndex < headers.length;
      columnIndex++
    ) {
      final header =
          headers[columnIndex];

      if (header.isEmpty) {
        continue;
      }

      final cell =
          columnIndex < excelRow.length
              ? excelRow[columnIndex]
              : null;

      final value =
          cell?.value?.toString().trim();

      if (value != null &&
          value.isNotEmpty) {
        rawRow[header] = value;
        hasAnyValue = true;
      } else {
        rawRow[header] = null;
      }
    }

    // 整行完全为空就直接忽略。
    if (!hasAnyValue) {
      continue;
    }

    // 保存真实 Excel 行号。
    rawRow['__rowNumber'] =
        rowIndex + 1;

    rowsJson.add(
      jsonEncode(rawRow),
    );
  }

  // 复用之前已经验证成功的通用 Mapping 引擎。
  return previewRows(
    session,
    profileId: profileId,
    rowsJson: rowsJson,
  );
}

Future<DictionaryImportCommitResult> commitExcelBase64(
  Session session, {
  required int profileId,
  required String excelBase64,
}) async {
  if (session.authenticated == null) {
    throw Exception(
      '需要登录后才能导入词典',
    );
  }

  final preview = await previewExcelBase64(
    session,
    profileId: profileId,
    excelBase64: excelBase64,
  );

  if (preview == null) {
    throw ArgumentError(
      'Import Profile 不存在: $profileId',
    );
  }

  return DictionaryImportWriter.commit(
    session,
    preview: preview,
  );
}
}