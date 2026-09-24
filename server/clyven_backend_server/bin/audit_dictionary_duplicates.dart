import 'dart:io';

import 'package:excel/excel.dart';

void main() {
  const filePath = r'C:\Users\USER\Downloads\越南语.xlsx';

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

  final groups = <String, List<Map<String, String>>>{};

  for (var i = 1; i < sheet.rows.length; i++) {
    final row = sheet.rows[i];

    final headword = valueAt(row, '国语字');

    if (headword.isEmpty) {
      continue;
    }

    final key = headword.toLowerCase();

    groups.putIfAbsent(key, () => []).add({
      'row': '${i + 1}',
      'id': valueAt(row, 'ID'),
      'headword': headword,
      'pos': valueAt(row, '词性'),
      'definition': valueAt(row, '中文'),
      'nom': valueAt(row, '喃字'),
    });
  }

  final duplicates =
      groups.entries.where((entry) => entry.value.length > 1).toList()..sort(
        (a, b) => a.key.compareTo(b.key),
      );

  print('重复国语字组数: ${duplicates.length}');
  print('');

  for (final group in duplicates) {
    print('==============================');
    print('国语字: ${group.key}');
    print('出现次数: ${group.value.length}');

    for (final row in group.value) {
      print('');
      print('Excel Row: ${row['row']}');
      print('ID: ${row['id']}');
      print('词性: ${row['pos']}');
      print('中文: ${row['definition']}');
      print('喃字: ${row['nom']}');
    }
  }
}
