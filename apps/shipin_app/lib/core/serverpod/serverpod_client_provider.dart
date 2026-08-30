import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glyphora_backend_client/glyphora_backend_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

final serverpodClientProvider = Provider<Client>((ref) {
  final client = Client(
    'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  )
    ..connectivityMonitor =
        FlutterConnectivityMonitor()
    ..authSessionManager =
        FlutterAuthSessionManager();

  return client;
});