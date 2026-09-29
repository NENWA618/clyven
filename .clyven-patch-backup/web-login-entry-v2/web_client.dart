import 'package:clyven_backend_client/clyven_backend_client.dart';

final webClient = Client(
  'https://glyphora-server-11129163384.asia-southeast1.run.app/',
  connectionTimeout: const Duration(minutes: 2),
);
