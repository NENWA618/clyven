import 'dart:convert';
import 'dart:io';

import 'package:clyven_backend_client/clyven_backend_client.dart';

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print(
      '用法: dart run bin/test_excel_preview.dart "C:\\路径\\越南语.xlsx"',
    );
    return;
  }

  final file = File(args.first);

  if (!await file.exists()) {
    print('找不到文件: ${file.path}');
    return;
  }

  print('读取 Excel: ${file.path}');

  final bytes = await file.readAsBytes();

  print('文件大小: ${bytes.length} bytes');

  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  );

  final preview =
      await client.dictionaryImport.previewExcelBase64(
    profileId: 1,
    excelBase64: base64Encode(bytes),
  );

  if (preview == null) {
    print('Profile 1 不存在');
    return;
  }

  print('');
  print('Profile: ${preview.profile.name}');
  print('Total: ${preview.totalRows}');
  print('Valid: ${preview.validRows}');
  print('Warnings: ${preview.warningRows}');
  print('Errors: ${preview.errorRows}');
  print('');

  const encoder = JsonEncoder.withIndent('  ');

  // 先只显示前 10 行，避免 800 多条全部刷出来。
  for (final row
    in preview.rows.where(
      (row) => row.status == 'error',
    )) {
    print(
      'Row ${row.rowNumber}: '
      '${row.headword ?? '(no headword)'} '
      '[${row.status}]',
    );

    if (row.message != null) {
      print('Message: ${row.message}');
    }

    print(
      encoder.convert(
        jsonDecode(row.normalizedJson),
      ),
    );

    print('--------------------');
  }
}