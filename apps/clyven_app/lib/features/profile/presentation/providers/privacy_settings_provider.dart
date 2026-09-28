import 'dart:async';

import 'package:clyven_app/core/errors/app_error.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class PrivacySettingsNotifier extends AsyncNotifier<PrivacySettings> {
  @override
  Future<PrivacySettings> build() async {
    final user = await ref.watch(authProvider.future);

    if (user == null) {
      throw const AppException(AppErrorCode.notLoggedIn);
    }

    final client = ref.read(serverpodClientProvider);
    return client.privacySettings.get();
  }

  void setPrivateAccount(bool enabled) {
    unawaited(_update(privateAccount: enabled));
  }

  void setAllowComments(bool enabled) {
    unawaited(_update(allowComments: enabled));
  }

  void setShowActivityStatus(bool enabled) {
    unawaited(_update(showActivityStatus: enabled));
  }

  Future<void> _update({
    bool? privateAccount,
    bool? allowComments,
    bool? showActivityStatus,
  }) async {
    final current = state.value;

    if (current != null) {
      state = AsyncData(
        current.copyWith(
          privateAccount: privateAccount,
          allowComments: allowComments,
          showActivityStatus: showActivityStatus,
        ),
      );
    }

    final client = ref.read(serverpodClientProvider);
    final updated = await client.privacySettings.update(
      privateAccount: privateAccount,
      allowComments: allowComments,
      showActivityStatus: showActivityStatus,
    );

    state = AsyncData(updated);
  }
}

final privacySettingsProvider =
    AsyncNotifierProvider<PrivacySettingsNotifier, PrivacySettings>(
      PrivacySettingsNotifier.new,
    );
