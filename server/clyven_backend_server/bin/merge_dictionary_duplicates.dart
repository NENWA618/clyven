import 'dart:io';

import 'package:excel/excel.dart';

void main() {
  const inputPath = r'C:\Users\USER\Downloads\越南语.xlsx';

  const outputPath = r'C:\Users\USER\Downloads\越南语_去重.xlsx';

  final bytes = File(inputPath).readAsBytesSync();
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

  final mergedRows = <String, Map<String, String>>{};

  final order = <String>[];

  var nonEmptyRowCount = 0;

  for (var i = 1; i < sheet.rows.length; i++) {
    final row = sheet.rows[i];

    String valueAt(String column) {
      final index = headers[column];

      if (index == null || index >= row.length) {
        return '';
      }

      return cellText(row[index]);
    }

    final hasAnyValue = headers.keys.any(
      (header) => valueAt(header).isNotEmpty,
    );

    // 完全空白的 Excel 行直接忽略
    if (!hasAnyValue) {
      continue;
    }

    nonEmptyRowCount++;

    final headword = valueAt('国语字');

    // 没有国语字的未完成行继续保留
    if (headword.isEmpty) {
      final key = '__row_$i';

      mergedRows[key] = {
        for (final header in headers.keys) header: valueAt(header),
      };

      order.add(key);
      continue;
    }

    final key = headword.toLowerCase();

    if (!mergedRows.containsKey(key)) {
      mergedRows[key] = {
        for (final header in headers.keys) header: valueAt(header),
      };

      order.add(key);
      continue;
    }

    final existing = mergedRows[key]!;

    for (final header in headers.keys) {
      final oldValue = existing[header] ?? '';
      final newValue = valueAt(header);

      if (newValue.isEmpty) {
        continue;
      }

      if (oldValue.isEmpty) {
        existing[header] = newValue;
        continue;
      }

      if (oldValue == newValue) {
        continue;
      }

      if (header == '国语字' && oldValue.toLowerCase() == newValue.toLowerCase()) {
        continue;
      }

      // 这 4 个已人工确认可以合并中文释义
      if (header == '中文') {
        if (key == 'công thức') {
          existing[header] = '公式；配方；程式';
          continue;
        }

        if (key == 'nhưng mà') {
          existing[header] = '但是；可是';
          continue;
        }

        if (key == 'phức tạp') {
          existing[header] = '复杂；复杂的';
          continue;
        }

        if (key == 'thành tích') {
          existing[header] = '成绩；成就';
          continue;
        }
      }

      // 其他冲突不自动覆盖，保留第一份并提示
      print(
        '冲突未自动处理：'
        '$headword / $header\n'
        '  原值: $oldValue\n'
        '  新值: $newValue',
      );
    }
  }

  final newExcel = Excel.createExcel();
  final newSheet = newExcel['词汇'];

  final headerList = headers.entries.toList()
    ..sort(
      (a, b) => a.value.compareTo(b.value),
    );

  newSheet.appendRow(
    headerList
        .map(
          (e) => TextCellValue(e.key),
        )
        .toList(),
  );

  for (final key in order) {
    final row = mergedRows[key]!;

    newSheet.appendRow(
      headerList
          .map(
            (e) => TextCellValue(
              row[e.key] ?? '',
            ),
          )
          .toList(),
    );
  }

  // Excel.createExcel() 默认会有 Sheet1
  if (newExcel.tables.containsKey('Sheet1')) {
    newExcel.delete('Sheet1');
  }

  final outputBytes = newExcel.encode();

  if (outputBytes == null) {
    print('Excel 生成失败');
    return;
  }

  File(outputPath).writeAsBytesSync(
    outputBytes,
  );

  print('');
  print('完成');
  print('原始非空数据行数: $nonEmptyRowCount');
  print('去重后数据行数: ${order.length}');
  print('输出: $outputPath');
}
