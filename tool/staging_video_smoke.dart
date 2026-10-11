import 'dart:io';

import 'package:glyphora_backend_client/backend_client.dart';

Future<void> main() async {
  final host = Platform.environment['STAGING_HOST']?.trim() ?? '';
  if (!host.startsWith('glyphora-api-staging.') ||
      !host.endsWith('.workers.dev')) {
    stderr.writeln('Refusing non-staging API hostname.');
    exitCode = 2;
    return;
  }

  final client = Client(
    'https://$host/',
    connectionTimeout: const Duration(seconds: 65),
  );
  try {
    final videos = await client.video.getVideos();
    stdout.writeln('Dart Serverpod client: video.getVideos() succeeded.');
    stdout.writeln('Public staging videos: ${videos.length}');
  } catch (error) {
    stderr.writeln('Dart Serverpod client failed: ${error.runtimeType}');
    stderr.writeln(error.toString());
    exitCode = 1;
  } finally {
    await client.close();
  }
}
