import 'dart:convert';
import 'dart:io';

import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

class _MemoryAuthStorage implements ClientAuthSuccessStorage {
  AuthSuccess? _value;

  @override
  Future<AuthSuccess?> get() async {
    return _value;
  }

  @override
  Future<void> set(AuthSuccess? data) async {
    _value = data;
  }
}

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    print(
      '用法: dart run bin/test_dictionary_commit.dart '
      '"C:\\路径\\越南语_commit_test.xlsx"',
    );
    return;
  }

  final email =
      Platform.environment['CLYVEN_TEST_EMAIL'];

  final password =
      Platform.environment['CLYVEN_TEST_PASSWORD'];

  if (email == null || email.trim().isEmpty) {
    print('缺少环境变量 CLYVEN_TEST_EMAIL');
    return;
  }

  if (password == null || password.isEmpty) {
    print('缺少环境变量 CLYVEN_TEST_PASSWORD');
    return;
  }

  final file = File(args.first);

  if (!await file.exists()) {
    print('找不到 Excel: ${file.path}');
    return;
  }

  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
    connectionTimeout: const Duration(
      minutes: 2,
    ),
  );

  client.authSessionManager =
      ClientAuthSessionManager(
    storage: _MemoryAuthStorage(),
  );

  print('正在登录...');

  final authSuccess =
      await client.emailIdp.login(
    email: email.trim().toLowerCase(),
    password: password,
  );

  await client.auth.updateSignedInUser(
    authSuccess,
  );

  print(
    '登录成功: ${authSuccess.authUserId}',
  );

  final bytes = await file.readAsBytes();

  print(
    '读取测试 Excel: ${file.path}',
  );

  final result =
      await client.dictionaryImport
          .commitExcelBase64(
    profileId: 1,
    excelBase64: base64Encode(bytes),
  );

  print('');
  print('=== Import Result ===');
  print('Total: ${result.totalRows}');
  print(
    'Inserted: ${result.insertedEntries}',
  );
  print(
    'Merged: ${result.mergedEntries}',
  );
  print(
    'Skipped: ${result.skippedRows}',
  );
  print(
    'Failed: ${result.failedRows}',
  );

  if (result.messages.isNotEmpty) {
    print('');
    print('Messages:');

    for (final message in result.messages) {
      print('- $message');
    }
  }
}