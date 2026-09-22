import 'package:flutter/material.dart';

enum ClyvenThemeMode { accentOnly, full }

enum ClyvenDisplayMode { day, night }

enum ClyvenThemeColor {
  acid,
  yellow,
  purple,
  blue,
  green,
  orange,
  pink,
  cyan,
  red,
}

class ClyvenThemeSettings {
  final ClyvenThemeMode mode;
  final ClyvenThemeColor color;
  final ClyvenThemeColor companionColor;
  final ClyvenDisplayMode displayMode;

  const ClyvenThemeSettings({
    this.mode = ClyvenThemeMode.accentOnly,
    this.color = ClyvenThemeColor.orange,
    this.companionColor = ClyvenThemeColor.orange,
    this.displayMode = ClyvenDisplayMode.day,
  });

  ClyvenThemeSettings copyWith({
    ClyvenThemeMode? mode,
    ClyvenThemeColor? color,
    ClyvenThemeColor? companionColor,
    ClyvenDisplayMode? displayMode,
  }) {
    return ClyvenThemeSettings(
      mode: mode ?? this.mode,
      color: color ?? this.color,
      companionColor: companionColor ?? this.companionColor,
      displayMode: displayMode ?? this.displayMode,
    );
  }
}

class ClyvenTheme {
  ClyvenTheme._();

  /// Legacy preset names are retained for stored settings compatibility, while
  /// their tones are brought into the current editorial palette.
  static const Color brandAcid = Color(0xFFC7A66A);
  static const Color originalPurple = Color(0xFF87563A);
  static const Color originalBackground = Color(0xFFF1EFEA);
  static const Color ink = Color(0xFF171714);

  // Day mode keeps the original Clyven background exactly.
  static const Color nightBackground = Color(0xFF0D0D0C);
  static const Color nightCard = Color(0xFF191918);
  static const Color nightText = Color(0xFFF0EDE7);

  static Color accentFor(ClyvenThemeColor color) {
    return switch (color) {
      ClyvenThemeColor.acid => brandAcid,
      ClyvenThemeColor.yellow => const Color(0xFFFFD84D),
      ClyvenThemeColor.purple => const Color(0xFF8B6CFF),
      ClyvenThemeColor.blue => const Color(0xFF2563EB),
      ClyvenThemeColor.green => const Color(0xFF4FD18B),
      ClyvenThemeColor.orange => const Color(0xFFA85F36),
      ClyvenThemeColor.pink => const Color(0xFFFF6FAE),
      ClyvenThemeColor.cyan => const Color(0xFF47D7E8),
      ClyvenThemeColor.red => const Color(0xFFFF625F),
    };
  }

  static ThemeData build(ClyvenThemeSettings settings) {
    final accent = accentFor(settings.color);
    final fullTheme = settings.mode == ClyvenThemeMode.full;
    final isNight = settings.displayMode == ClyvenDisplayMode.night;
    final secondary = fullTheme
        ? secondaryForPair(settings.color, settings.companionColor)
        : originalPurple;

    final daySurface = fullTheme
        ? _surfaceFor(settings.color)
        : originalBackground;
    final nightSurface = fullTheme
        ? _nightSurfaceFor(settings.color)
        : nightBackground;
    final nightCardColor = fullTheme
        ? _nightCardFor(settings.color)
        : nightCard;
    final surface = isNight ? nightSurface : daySurface;
    final onSurface = isNight ? nightText : ink;

    final scheme = isNight
        ? ColorScheme.dark(
            primary: accent,
            onPrimary: _onAccent(accent),
            secondary: secondary,
            onSecondary: _onAccent(secondary),
            surface: surface,
            onSurface: onSurface,
            error: const Color(0xFFFF6B6B),
            onError: ink,
          )
        : ColorScheme.light(
            primary: accent,
            onPrimary: _onAccent(accent),
            secondary: secondary,
            onSecondary: _onAccent(secondary),
            surface: surface,
            onSurface: onSurface,
            error: const Color(0xFFD93B3B),
            onError: Colors.white,
          );

    final baseTextTheme =
        (isNight ? ThemeData.dark() : ThemeData.light()).textTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: isNight ? Brightness.dark : Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: surface,
      canvasColor: surface,
      cardColor: isNight ? nightCardColor : Colors.white,
      dividerColor: onSurface.withValues(alpha: 0.12),
      iconTheme: IconThemeData(color: onSurface),
      textTheme: baseTextTheme
          .apply(bodyColor: onSurface, displayColor: onSurface)
          .copyWith(
            headlineMedium: baseTextTheme.headlineMedium?.copyWith(
              color: onSurface,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.7,
            ),
            headlineSmall: baseTextTheme.headlineSmall?.copyWith(
              color: onSurface,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.4,
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: isNight ? nightCardColor : Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: _onAccent(accent),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),
      splashColor: accent.withValues(alpha: 0.12),
      highlightColor: accent.withValues(alpha: 0.08),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: accent),
      sliderTheme: SliderThemeData(
        activeTrackColor: accent,
        thumbColor: accent,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return _onAccent(accent);
          }
          return null;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return accent;
          }
          return null;
        }),
      ),
    );
  }

  static List<ClyvenThemeColor> allowedCompanionsFor(ClyvenThemeColor primary) {
    return switch (primary) {
      ClyvenThemeColor.acid => const [ClyvenThemeColor.purple],
      ClyvenThemeColor.yellow => const [
        ClyvenThemeColor.yellow,
        ClyvenThemeColor.orange,
        ClyvenThemeColor.green,
      ],
      ClyvenThemeColor.purple => const [
        ClyvenThemeColor.purple,
        ClyvenThemeColor.blue,
        ClyvenThemeColor.pink,
      ],
      ClyvenThemeColor.blue => const [
        ClyvenThemeColor.blue,
        ClyvenThemeColor.purple,
        ClyvenThemeColor.cyan,
      ],
      ClyvenThemeColor.green => const [
        ClyvenThemeColor.green,
        ClyvenThemeColor.cyan,
        ClyvenThemeColor.yellow,
      ],
      ClyvenThemeColor.orange => const [
        ClyvenThemeColor.orange,
        ClyvenThemeColor.red,
        ClyvenThemeColor.pink,
      ],
      ClyvenThemeColor.pink => const [
        ClyvenThemeColor.pink,
        ClyvenThemeColor.purple,
        ClyvenThemeColor.red,
      ],
      ClyvenThemeColor.cyan => const [
        ClyvenThemeColor.cyan,
        ClyvenThemeColor.blue,
        ClyvenThemeColor.green,
      ],
      ClyvenThemeColor.red => const [
        ClyvenThemeColor.red,
        ClyvenThemeColor.orange,
        ClyvenThemeColor.pink,
      ],
    };
  }

  static ClyvenThemeColor defaultCompanionFor(ClyvenThemeColor primary) {
    return switch (primary) {
      ClyvenThemeColor.acid => ClyvenThemeColor.purple,
      ClyvenThemeColor.yellow => ClyvenThemeColor.yellow,
      ClyvenThemeColor.purple => ClyvenThemeColor.purple,
      ClyvenThemeColor.blue => ClyvenThemeColor.blue,
      ClyvenThemeColor.green => ClyvenThemeColor.green,
      ClyvenThemeColor.orange => ClyvenThemeColor.orange,
      ClyvenThemeColor.pink => ClyvenThemeColor.pink,
      ClyvenThemeColor.cyan => ClyvenThemeColor.cyan,
      ClyvenThemeColor.red => ClyvenThemeColor.red,
    };
  }

  static bool isCompanionAllowed(
    ClyvenThemeColor primary,
    ClyvenThemeColor companion,
  ) {
    return allowedCompanionsFor(primary).contains(companion);
  }

  static Color companionAccentFor(ClyvenThemeColor color) {
    return switch (color) {
      ClyvenThemeColor.acid => originalPurple,
      ClyvenThemeColor.yellow => const Color(0xFFE0A82E),
      ClyvenThemeColor.purple => const Color(0xFF5D4DB3),
      ClyvenThemeColor.blue => const Color(0xFF2F6FD4),
      ClyvenThemeColor.green => const Color(0xFF2E9B67),
      ClyvenThemeColor.orange => const Color(0xFF87563A),
      ClyvenThemeColor.pink => const Color(0xFFD94F91),
      ClyvenThemeColor.cyan => const Color(0xFF2398A8),
      ClyvenThemeColor.red => const Color(0xFFD94744),
    };
  }

  static Color secondaryForPair(
    ClyvenThemeColor primary,
    ClyvenThemeColor companion,
  ) {
    // Clyven Default is a fixed brand preset.
    if (primary == ClyvenThemeColor.acid) {
      return originalPurple;
    }

    final safeCompanion = isCompanionAllowed(primary, companion)
        ? companion
        : defaultCompanionFor(primary);

    // Each allowed pair has its own tuned final secondary color.
    // This keeps combinations cohesive instead of reusing one generic hue.
    return switch ((primary, safeCompanion)) {
      // Yellow family
      (ClyvenThemeColor.yellow, ClyvenThemeColor.yellow) => const Color(
        0xFFE0A82E,
      ),
      (ClyvenThemeColor.yellow, ClyvenThemeColor.orange) => const Color(
        0xFFE3A23A,
      ),
      (ClyvenThemeColor.yellow, ClyvenThemeColor.green) => const Color(
        0xFF9AAE48,
      ),

      // Purple family
      (ClyvenThemeColor.purple, ClyvenThemeColor.purple) => const Color(
        0xFF5D4DB3,
      ),
      (ClyvenThemeColor.purple, ClyvenThemeColor.blue) => const Color(
        0xFF5A67C8,
      ),
      (ClyvenThemeColor.purple, ClyvenThemeColor.pink) => const Color(
        0xFFB45F9D,
      ),

      // Blue family
      (ClyvenThemeColor.blue, ClyvenThemeColor.blue) => const Color(0xFF2F6FD4),
      (ClyvenThemeColor.blue, ClyvenThemeColor.purple) => const Color(
        0xFF665EC4,
      ),
      (ClyvenThemeColor.blue, ClyvenThemeColor.cyan) => const Color(0xFF3B93C7),

      // Green family
      (ClyvenThemeColor.green, ClyvenThemeColor.green) => const Color(
        0xFF2E9B67,
      ),
      (ClyvenThemeColor.green, ClyvenThemeColor.cyan) => const Color(
        0xFF329C91,
      ),
      (ClyvenThemeColor.green, ClyvenThemeColor.yellow) => const Color(
        0xFF93A94A,
      ),

      // Orange family
      (ClyvenThemeColor.orange, ClyvenThemeColor.orange) => const Color(
        0xFF87563A,
      ),
      (ClyvenThemeColor.orange, ClyvenThemeColor.red) => const Color(
        0xFF9C5D4D,
      ),
      (ClyvenThemeColor.orange, ClyvenThemeColor.pink) => const Color(
        0xFFA46668,
      ),

      // Pink family
      (ClyvenThemeColor.pink, ClyvenThemeColor.pink) => const Color(0xFFD94F91),
      (ClyvenThemeColor.pink, ClyvenThemeColor.purple) => const Color(
        0xFFB85FA7,
      ),
      (ClyvenThemeColor.pink, ClyvenThemeColor.red) => const Color(0xFFE85D75),

      // Cyan family
      (ClyvenThemeColor.cyan, ClyvenThemeColor.cyan) => const Color(0xFF2398A8),
      (ClyvenThemeColor.cyan, ClyvenThemeColor.blue) => const Color(0xFF3A83BF),
      (ClyvenThemeColor.cyan, ClyvenThemeColor.green) => const Color(
        0xFF369B86,
      ),

      // Red family
      (ClyvenThemeColor.red, ClyvenThemeColor.red) => const Color(0xFFD94744),
      (ClyvenThemeColor.red, ClyvenThemeColor.orange) => const Color(
        0xFFE46D45,
      ),
      (ClyvenThemeColor.red, ClyvenThemeColor.pink) => const Color(0xFFE76782),

      // Defensive fallback. Normally unreachable because of the whitelist.
      _ => companionAccentFor(safeCompanion),
    };
  }

  static Color _surfaceFor(ClyvenThemeColor color) {
    return switch (color) {
      ClyvenThemeColor.acid => originalBackground,
      ClyvenThemeColor.yellow => const Color(0xFFFFF6D8),
      ClyvenThemeColor.purple => const Color(0xFFF3F0FF),
      ClyvenThemeColor.blue => const Color(0xFFF7F9FC),
      ClyvenThemeColor.green => const Color(0xFFEFF8F3),
      ClyvenThemeColor.orange => const Color(0xFFF1EFEA),
      ClyvenThemeColor.pink => const Color(0xFFFFF0F6),
      ClyvenThemeColor.cyan => const Color(0xFFEDF9FB),
      ClyvenThemeColor.red => const Color(0xFFFFF0EE),
    };
  }

  static Color _nightSurfaceFor(ClyvenThemeColor color) {
    if (color == ClyvenThemeColor.acid) {
      return nightBackground;
    }

    return Color.alphaBlend(
      accentFor(color).withValues(alpha: 0.025),
      nightBackground,
    );
  }

  static Color _nightCardFor(ClyvenThemeColor color) {
    if (color == ClyvenThemeColor.acid) {
      return nightCard;
    }

    return Color.alphaBlend(
      accentFor(color).withValues(alpha: 0.03),
      nightCard,
    );
  }

  static Color _onAccent(Color color) {
    return color.computeLuminance() > 0.55 ? ink : Colors.white;
  }
}

extension ClyvenThemeContext on BuildContext {
  Color get clyvenAccent => Theme.of(this).colorScheme.primary;
  Color get clyvenSecondary => Theme.of(this).colorScheme.secondary;
  Color get clyvenSurface => Theme.of(this).colorScheme.surface;
}
