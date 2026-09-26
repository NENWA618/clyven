import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';

//è¿™é‡Œæ˜¯è¿™ä»¶æˆ¿å­çš„wifiè·¯ç”±å™¨

final serverpodClientProvider = Provider<Client>((ref) {
  final client =
      Client('https://karaoke-test---glyphora-server-kxl54btipa-as.a.run.app/')
        ..connectivityMonitor = FlutterConnectivityMonitor()
        ..authSessionManager = FlutterAuthSessionManager();

  return client;
});



