import 'dart:io';

import 'package:excel/excel.dart';

void main() {
  const filePath =
      r'C:\Users\USER\Downloads\越南语.xlsx';

  final bytes = File(filePath).readAsBytesSync();
  final excel = Excel.decodeBytes(bytes);

  final sheet = excel.tables['词汇'];

  if (sheet == null) {
    print('找不到工作表：词汇');
    return;
  }

  if (sheet.rows.isEmpty) {
    print('工作表为空');
    return;
  }

  String cellText(Data? cell) {
    return cell?.value?.toString().trim() ?? '';
  }

  final headers = <String, int>{};

  for (var i = 0; i < sheet.rows.first.length; i++) {
    final name = cellText(sheet.rows.first[i]);

    if (name.isNotEmpty) {
      headers[name] = i;
    }
  }

  String valueAt(
    List<Data?> row,
    String column,
  ) {
    final index = headers[column];

    if (index == null || index >= row.length) {
      return '';
    }

    return cellText(row[index]);
  }

  final groups =
      <String, List<Map<String, String>>>{};

  for (var i = 1; i < sheet.rows.length; i++) {
    final row = sheet.rows[i];

    final headword = valueAt(
      row,
      '国语字',
    );

    if (headword.isEmpty) {
      continue;
    }

    final key = headword.toLowerCase();

    groups.putIfAbsent(
      key,
      () => [],
    );

    groups[key]!.add({
      'row': '${i + 1}',
      '国语字': headword,
      '喃字': valueAt(row, '喃字'),
      '中文': valueAt(row, '中文'),
      '词性': valueAt(row, '词性'),
      '国语字例句':
          valueAt(row, '国语字例句'),
      '喃字例句':
          valueAt(row, '喃字例句'),
      '中文例句':
          valueAt(row, '中文例句'),
    });
  }

  final duplicates = groups.entries
      .where(
        (entry) => entry.value.length > 1,
      )
      .toList()
    ..sort(
      (a, b) => a.key.compareTo(b.key),
    );

  print(
    '重复国语字组数: ${duplicates.length}',
  );

  for (final group in duplicates) {
    print('');
    print(
      '========================================',
    );
    print('国语字: ${group.key}');
    print(
      '原始行: '
      '${group.value.map((e) => e['row']).join(', ')}',
    );

    final nomValues = uniqueNonEmpty(
      group.value,
      '喃字',
    );

    final chineseValues = uniqueNonEmpty(
      group.value,
      '中文',
    );

    final posValues = uniqueNonEmpty(
      group.value,
      '词性',
    );

    final viExampleValues = uniqueNonEmpty(
      group.value,
      '国语字例句',
    );

    final nomExampleValues = uniqueNonEmpty(
      group.value,
      '喃字例句',
    );

    final zhExampleValues = uniqueNonEmpty(
      group.value,
      '中文例句',
    );

    print('');
    print('建议合并：');

    print(
      '国语字: '
      '${group.value.first['国语字']}',
    );

    printValues(
      '喃字',
      nomValues,
    );

    printValues(
      '中文',
      chineseValues,
    );

    printValues(
      '词性',
      posValues,
    );

    printValues(
      '国语字例句',
      viExampleValues,
    );

    printValues(
      '喃字例句',
      nomExampleValues,
    );

    printValues(
      '中文例句',
      zhExampleValues,
    );

    final conflicts = <String>[];

    if (nomValues.length > 1) {
      conflicts.add('喃字');
    }

    if (chineseValues.length > 1) {
      conflicts.add('中文');
    }

    if (posValues.length > 1) {
      conflicts.add('词性');
    }

    if (viExampleValues.length > 1) {
      conflicts.add('国语字例句');
    }

    if (nomExampleValues.length > 1) {
      conflicts.add('喃字例句');
    }

    if (zhExampleValues.length > 1) {
      conflicts.add('中文例句');
    }

    if (conflicts.isEmpty) {
      print('');
      print(
        '判断: 可以直接合并，没有冲突',
      );
    } else {
      print('');
      print(
        '判断: 需要人工检查',
      );
      print(
        '冲突字段: ${conflicts.join(', ')}',
      );
    }
  }
}

List<String> uniqueNonEmpty(
  List<Map<String, String>> rows,
  String field,
) {
  final result = <String>[];

  for (final row in rows) {
    final value =
        row[field]?.trim() ?? '';

    if (value.isEmpty) {
      continue;
    }

    if (!result.contains(value)) {
      result.add(value);
    }
  }

  return result;
}

void printValues(
  String label,
  List<String> values,
) {
  if (values.isEmpty) {
    print('$label:');
    return;
  }

  if (values.length == 1) {
    print(
      '$label: ${values.first}',
    );
    return;
  }

  print('$label:');

  for (var i = 0; i < values.length; i++) {
    print(
      '  ${i + 1}. ${values[i]}',
    );
  }
}