import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'feed_diagnostics.dart';

// 这里是这件房子的 wifi 路由器。
final serverpodClientProvider = Provider<Client>((ref) {
  const apiUrl = String.fromEnvironment(
    'CLYVEN_API_URL',
    defaultValue:
        'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  );
  const revision = String.fromEnvironment(
    'CLYVEN_BUILD_REVISION',
    defaultValue: 'unset',
  );

  feedDiagnostic('FEED_CLIENT api=$apiUrl revision=$revision');

  final client = Client(apiUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  return client;
});
