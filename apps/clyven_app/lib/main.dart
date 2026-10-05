import 'core/media/video_cache_adapter.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/app_locale_provider.dart';
import 'core/push/push_notifications.dart';
import 'core/sharing/deep_link_handler.dart';
import 'core/serverpod/serverpod_client_provider.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'core/navigation/app_navigator.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_theme_provider.dart';
import 'features/auth/presentation/auth_gate.dart';
import 'l10n/app_localizations.dart';

import 'features/video/presentation/widgets/global_video_player_host.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeVideoCache();
  attachVideoCacheDiagnostics();
  unawaited(PushNotifications.init());
  unawaited(DeepLinkHandler.init());
  runApp(const ProviderScope(child: ClyvenApp()));
}

class ClyvenApp extends ConsumerWidget {
  const ClyvenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(appLocaleProvider);
    final themeSettings = ref.watch(appThemeProvider);

    // Bind this device to whoever is signed in so the server can push to it.
    void registerPush() {
      if (ref.read(authProvider).value == null) return;
      final languageCode = (locale ?? PlatformDispatcher.instance.locale)
          .languageCode;
      unawaited(
        PushNotifications.register(
          ref.read(serverpodClientProvider),
          languageCode: languageCode == 'zh' ? 'zh' : 'en',
        ),
      );
    }

    ref.listen(authProvider, (previous, next) {
      if (next.value != null && next.value?.id != previous?.value?.id) {
        registerPush();
      }
    });
    // The push language follows the in-app language setting.
    ref.listen(appLocaleProvider, (previous, next) => registerPush());

    return MaterialApp(
      navigatorKey: appNavigatorKey,
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: const {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.invertedStylus,
          PointerDeviceKind.trackpad,
        },
      ),
      theme: ClyvenTheme.build(themeSettings),
      builder: (context, child) {
        return GlobalVideoPlayerHost(child: child ?? const SizedBox.shrink());
      },
      home: const AuthGate(),
    );
  }
}
