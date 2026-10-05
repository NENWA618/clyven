import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Bridges Android and iOS picture-in-picture. Playback widgets report whether the
/// app may auto-enter PiP when the user leaves it (Home button / gesture).
class PipService {
  PipService._() {
    if (_supported) {
      _channel.setMethodCallHandler((call) async {
        if (call.method == 'pipChanged') {
          inPip.value = call.arguments == true;
        }
      });
    }
  }

  static bool get _supported =>
      !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  static final PipService instance = PipService._();

  static const MethodChannel _channel = MethodChannel('clyven/pip');

  final ValueNotifier<bool> inPip = ValueNotifier<bool>(false);

  bool _eligible = false;
  double _aspect = 0;

  Future<void> setEligible(bool eligible, {double aspectRatio = 16 / 9}) async {
    if (!_supported) return;
    if (_eligible == eligible && (_aspect - aspectRatio).abs() < 0.01) return;
    _eligible = eligible;
    _aspect = aspectRatio;
    try {
      await _channel.invokeMethod<void>('setEligible', {
        'eligible': eligible,
        'width': (aspectRatio * 1000).round(),
        'height': 1000,
      });
    } on PlatformException catch (error) {
      debugPrint('PIP_SET_ELIGIBLE_FAILED: $error');
    } on MissingPluginException {
      // Not running on the Android host (e.g. tests).
    }
  }
}
