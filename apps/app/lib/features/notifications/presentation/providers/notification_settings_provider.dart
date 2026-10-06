import 'dart:async';

import 'package:glyphora_app/core/errors/app_error.dart';
import 'package:glyphora_backend_client/backend_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/serverpod/serverpod_client_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class NotificationSettingsNotifier extends AsyncNotifier<NotificationSettings> {
  @override
  Future<NotificationSettings> build() async {
    final user = await ref.watch(authProvider.future);

    if (user == null) {
      throw const AppException(AppErrorCode.notLoggedIn);
    }

    final client = ref.read(serverpodClientProvider);
    return client.notificationSettings.get();
  }

  void setPushEnabled(bool enabled) {
    unawaited(_update(pushEnabled: enabled));
  }

  void setLikeEnabled(bool enabled) {
    unawaited(_update(likeEnabled: enabled));
  }

  void setCommentEnabled(bool enabled) {
    unawaited(_update(commentEnabled: enabled));
  }

  void setFollowEnabled(bool enabled) {
    unawaited(_update(followEnabled: enabled));
  }

  Future<void> _update({
    bool? pushEnabled,
    bool? likeEnabled,
    bool? commentEnabled,
    bool? followEnabled,
  }) async {
    final current = state.value;

    if (current != null) {
      state = AsyncData(
        current.copyWith(
          pushEnabled: pushEnabled,
          likeEnabled: likeEnabled,
          commentEnabled: commentEnabled,
          followEnabled: followEnabled,
        ),
      );
    }

    final client = ref.read(serverpodClientProvider);
    final updated = await client.notificationSettings.update(
      pushEnabled: pushEnabled,
      likeEnabled: likeEnabled,
      commentEnabled: commentEnabled,
      followEnabled: followEnabled,
    );

    state = AsyncData(updated);
  }
}

final notificationSettingsProvider =
    AsyncNotifierProvider<NotificationSettingsNotifier, NotificationSettings>(
      NotificationSettingsNotifier.new,
    );
