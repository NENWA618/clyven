import 'package:glyphora_backend_client/backend_client.dart';

extension NotificationSettingsFilter on NotificationSettings {
  bool isEnabledFor(NotificationType type) {
    return switch (type) {
      NotificationType.like => likeEnabled,
      NotificationType.comment => commentEnabled,
      NotificationType.follow => followEnabled,
    };
  }
}
