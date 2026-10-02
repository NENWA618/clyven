import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';
import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/notification_settings_filter.dart';
import '../providers/notification_provider.dart';
import '../providers/notification_settings_provider.dart';
import 'notification_labels.dart';

/// Opens the notification dropdown anchored under the widget behind
/// [anchorContext]. [onViewAll] opens the full echoes page.
Future<void> showNotificationDropdown(
  BuildContext anchorContext, {
  required VoidCallback onViewAll,
}) {
  final box = anchorContext.findRenderObject()! as RenderBox;
  final anchor = box.localToGlobal(Offset.zero) & box.size;

  return showGeneralDialog<void>(
    context: anchorContext,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(
      anchorContext,
    ).modalBarrierDismissLabel,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 120),
    transitionBuilder: (context, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    ),
    pageBuilder: (dialogContext, _, _) {
      final screen = MediaQuery.sizeOf(dialogContext);
      final width = (screen.width - 24).clamp(0.0, 360.0);
      final right = (screen.width - anchor.right).clamp(12.0, screen.width);

      return Stack(
        children: [
          Positioned(
            top: anchor.bottom + 8,
            right: right,
            width: width,
            child: _NotificationDropdown(
              maxHeight: screen.height * 0.6,
              onViewAll: () {
                Navigator.of(dialogContext).pop();
                onViewAll();
              },
              onOpenVideo: (videoId) {
                Navigator.of(dialogContext).pop();
                openGlobalVideo(videoId.toString());
              },
            ),
          ),
        ],
      );
    },
  );
}

class _NotificationDropdown extends ConsumerWidget {
  final double maxHeight;
  final VoidCallback onViewAll;
  final ValueChanged<int> onOpenVideo;

  const _NotificationDropdown({
    required this.maxHeight,
    required this.onViewAll,
    required this.onOpenVideo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final settings =
        ref.watch(notificationSettingsProvider).unwrapPrevious().value ??
        NotificationSettings(userId: '');
    final async = ref.watch(notificationProvider);
    final visible = (async.value ?? const <AppNotification>[])
        .where((n) => settings.isEnabledFor(n.type))
        .toList(growable: false);
    final hasUnread = visible.any((n) => !n.isRead);

    return Material(
      elevation: 8,
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(18),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.navEchoes,
                      style: TextStyle(
                        color: scheme.onSurface,
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  if (hasUnread)
                    TextButton(
                      onPressed: () => ref
                          .read(notificationProvider.notifier)
                          .markAllAsRead(),
                      child: Text(
                        l10n.markAllRead,
                        style: TextStyle(
                          color: scheme.secondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(height: 1),
            Flexible(
              child: async.when(
                loading: () =>
                    const _Message(child: CircularProgressIndicator()),
                error: (_, _) =>
                    _Message(child: Text(l10n.notificationsLoadFailed)),
                data: (_) => visible.isEmpty
                    ? _Message(child: Text(l10n.noEchoesYet))
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        itemCount: visible.length,
                        itemBuilder: (context, index) => _Item(
                          notification: visible[index],
                          onTap: () async {
                            final n = visible[index];
                            await ref
                                .read(notificationProvider.notifier)
                                .markAsRead(n.id!);
                            if (n.videoId != null) onOpenVideo(n.videoId!);
                          },
                        ),
                      ),
              ),
            ),
            const Divider(height: 1),
            InkWell(
              onTap: onViewAll,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: Text(
                    l10n.seeAll,
                    style: TextStyle(
                      color: scheme.secondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  final Widget child;
  const _Message({required this.child});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(28),
    child: Center(child: child),
  );
}

class _Item extends StatelessWidget {
  final AppNotification notification;
  final VoidCallback onTap;

  const _Item({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: notification.isRead
            ? null
            : scheme.secondary.withValues(alpha: 0.08),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: scheme.secondary.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(notification.icon, size: 18),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title(l10n),
                    style: TextStyle(
                      color: scheme.onSurface,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    notification.message(l10n),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: scheme.onSurface.withValues(alpha: 0.65),
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.timeAgo(l10n),
                    style: TextStyle(
                      color: scheme.onSurface.withValues(alpha: 0.45),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            if (!notification.isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(top: 5, left: 8),
                decoration: BoxDecoration(
                  color: scheme.secondary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
