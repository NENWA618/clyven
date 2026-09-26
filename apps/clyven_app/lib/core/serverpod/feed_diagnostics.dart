import 'package:flutter/foundation.dart';

/// Enable in a release APK with --dart-define=CLYVEN_FEED_DIAGNOSTICS=true.
/// Never pass credentials, raw exceptions or signed resource URLs here.
void feedDiagnostic(String message) {
  if (kDebugMode || const bool.fromEnvironment('CLYVEN_FEED_DIAGNOSTICS')) {
    debugPrint(message);
  }
}
