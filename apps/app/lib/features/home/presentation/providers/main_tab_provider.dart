import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainTabRequestNotifier extends Notifier<int?> {
  @override
  int? build() => null;

  void request(int index) {
    state = index;
  }

  void clear() {
    state = null;
  }
}

/// Set to a bottom-nav tab index to request MainPage switch to it
/// (e.g. from the home page bell icon), then reset to null once handled.
final mainTabRequestProvider = NotifierProvider<MainTabRequestNotifier, int?>(
  MainTabRequestNotifier.new,
);
