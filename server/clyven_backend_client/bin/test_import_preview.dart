import 'dart:convert';

import 'package:clyven_backend_client/clyven_backend_client.dart';

Future<void> main() async {
  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  );

  final rowsJson = [
    jsonEncode({
      '喃字': '碎',
      '国语字': 'tôi',
      '中文': '我',
      '词性': '代词',
      '喃字例句': '碎當咹粓',
      '国语字例句': 'Tôi đang ăn cơm.',
      '中文例句': '我在吃饭',
    }),
    jsonEncode({
      '喃字': '伴',
      '国语字': 'bạn',
      '中文': '你',
      '词性': '代词',
      '喃字例句': '伴當䀡tivi',
      '国语字例句': 'Bạn đang xem tivi.',
      '中文例句': '你在看电视',
    }),
    jsonEncode({
      '国语字': 'anh ấy',
      '中文': '他',
      '词性': '代词',
      '国语字例句': 'Anh ấy đang chạy.',
      '中文例句': '他在跑',
    }),
  ];

  final preview =
      await client.dictionaryImport.previewRows(
    profileId: 1,
    rowsJson: rowsJson,
  );

  if (preview == null) {
    print('Profile not found');
    return;
  }

  print('Profile: ${preview.profile.name}');
  print('Total: ${preview.totalRows}');
  print('Valid: ${preview.validRows}');
  print('Warnings: ${preview.warningRows}');
  print('Errors: ${preview.errorRows}');
  print('');

  for (final row in preview.rows) {
    print(
      'Row ${row.rowNumber}: '
      '${row.headword} '
      '[${row.status}]',
    );

    if (row.message != null) {
      print('Message: ${row.message}');
    }

    final normalized = jsonDecode(
      row.normalizedJson,
    );

    const encoder = JsonEncoder.withIndent('  ');

    print(
      encoder.convert(normalized),
    );

    print('--------------------');
  }
}