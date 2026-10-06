import 'package:flutter/material.dart';

enum GlyphoraThemeMode { accentOnly, full }

enum GlyphoraDisplayMode { day, night }

enum GlyphoraThemeColor {
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

class GlyphoraThemeSettings {
  final GlyphoraThemeMode mode;
  final GlyphoraThemeColor color;
  final GlyphoraThemeColor companionColor;
  final GlyphoraDisplayMode displayMode;

  const GlyphoraThemeSettings({
    this.mode = GlyphoraThemeMode.accentOnly,
    this.color = GlyphoraThemeColor.orange,
    this.companionColor = GlyphoraThemeColor.orange,
    this.displayMode = GlyphoraDisplayMode.day,
  });

  GlyphoraThemeSettings copyWith({
    GlyphoraThemeMode? mode,
    GlyphoraThemeColor? color,
    GlyphoraThemeColor? companionColor,
    GlyphoraDisplayMode? displayMode,
  }) {
    return GlyphoraThemeSettings(
      mode: mode ?? this.mode,
      color: color ?? this.color,
      companionColor: companionColor ?? this.companionColor,
      displayMode: displayMode ?? this.displayMode,
    );
  }
}

class GlyphoraTheme {
  GlyphoraTheme._();

  /// Legacy preset names are retained for stored settings compatibility, while
  /// their tones are brought into the current editorial palette.
  static const Color brandAcid = Color(0xFFC7A66A);
  static const Color originalPurple = Color(0xFF87563A);
  static const Color originalBackground = Color(0xFFF1EFEA);
  static const Color ink = Color(0xFF171714);

  // Day mode keeps the original Glyphora background exactly.
  static const Color nightBackground = Color(0xFF0D0D0C);
  static const Color nightCard = Color(0xFF191918);
  static const Color nightText = Color(0xFFF0EDE7);

  static Color accentFor(GlyphoraThemeColor color) {
    return switch (color) {
      GlyphoraThemeColor.acid => brandAcid,
      GlyphoraThemeColor.yellow => const Color(0xFFFFD84D),
      GlyphoraThemeColor.purple => const Color(0xFF8B6CFF),
      GlyphoraThemeColor.blue => const Color(0xFF2563EB),
      GlyphoraThemeColor.green => const Color(0xFF4FD18B),
      GlyphoraThemeColor.orange => const Color(0xFFA85F36),
      GlyphoraThemeColor.pink => const Color(0xFFFF6FAE),
      GlyphoraThemeColor.cyan => const Color(0xFF47D7E8),
      GlyphoraThemeColor.red => const Color(0xFFFF625F),
    };
  }

  static ThemeData build(GlyphoraThemeSettings settings) {
    final accent = accentFor(settings.color);
    final fullTheme = settings.mode == GlyphoraThemeMode.full;
    final isNight = settings.displayMode == GlyphoraDisplayMode.night;
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

  static List<GlyphoraThemeColor> allowedCompanionsFor(GlyphoraThemeColor primary) {
    return switch (primary) {
      GlyphoraThemeColor.acid => const [GlyphoraThemeColor.purple],
      GlyphoraThemeColor.yellow => const [
        GlyphoraThemeColor.yellow,
        GlyphoraThemeColor.orange,
        GlyphoraThemeColor.green,
      ],
      GlyphoraThemeColor.purple => const [
        GlyphoraThemeColor.purple,
        GlyphoraThemeColor.blue,
        GlyphoraThemeColor.pink,
      ],
      GlyphoraThemeColor.blue => const [
        GlyphoraThemeColor.blue,
        GlyphoraThemeColor.purple,
        GlyphoraThemeColor.cyan,
      ],
      GlyphoraThemeColor.green => const [
        GlyphoraThemeColor.green,
        GlyphoraThemeColor.cyan,
        GlyphoraThemeColor.yellow,
      ],
      GlyphoraThemeColor.orange => const [
        GlyphoraThemeColor.orange,
        GlyphoraThemeColor.red,
        GlyphoraThemeColor.pink,
      ],
      GlyphoraThemeColor.pink => const [
        GlyphoraThemeColor.pink,
        GlyphoraThemeColor.purple,
        GlyphoraThemeColor.red,
      ],
      GlyphoraThemeColor.cyan => const [
        GlyphoraThemeColor.cyan,
        GlyphoraThemeColor.blue,
        GlyphoraThemeColor.green,
      ],
      GlyphoraThemeColor.red => const [
        GlyphoraThemeColor.red,
        GlyphoraThemeColor.orange,
        GlyphoraThemeColor.pink,
      ],
    };
  }

  static GlyphoraThemeColor defaultCompanionFor(GlyphoraThemeColor primary) {
    return switch (primary) {
      GlyphoraThemeColor.acid => GlyphoraThemeColor.purple,
      GlyphoraThemeColor.yellow => GlyphoraThemeColor.yellow,
      GlyphoraThemeColor.purple => GlyphoraThemeColor.purple,
      GlyphoraThemeColor.blue => GlyphoraThemeColor.blue,
      GlyphoraThemeColor.green => GlyphoraThemeColor.green,
      GlyphoraThemeColor.orange => GlyphoraThemeColor.orange,
      GlyphoraThemeColor.pink => GlyphoraThemeColor.pink,
      GlyphoraThemeColor.cyan => GlyphoraThemeColor.cyan,
      GlyphoraThemeColor.red => GlyphoraThemeColor.red,
    };
  }

  static bool isCompanionAllowed(
    GlyphoraThemeColor primary,
    GlyphoraThemeColor companion,
  ) {
    return allowedCompanionsFor(primary).contains(companion);
  }

  static Color companionAccentFor(GlyphoraThemeColor color) {
    return switch (color) {
      GlyphoraThemeColor.acid => originalPurple,
      GlyphoraThemeColor.yellow => const Color(0xFFE0A82E),
      GlyphoraThemeColor.purple => const Color(0xFF5D4DB3),
      GlyphoraThemeColor.blue => const Color(0xFF2F6FD4),
      GlyphoraThemeColor.green => const Color(0xFF2E9B67),
      GlyphoraThemeColor.orange => const Color(0xFF87563A),
      GlyphoraThemeColor.pink => const Color(0xFFD94F91),
      GlyphoraThemeColor.cyan => const Color(0xFF2398A8),
      GlyphoraThemeColor.red => const Color(0xFFD94744),
    };
  }

  static Color secondaryForPair(
    GlyphoraThemeColor primary,
    GlyphoraThemeColor companion,
  ) {
    // Glyphora Default is a fixed brand preset.
    if (primary == GlyphoraThemeColor.acid) {
      return originalPurple;
    }

    final safeCompanion = isCompanionAllowed(primary, companion)
        ? companion
        : defaultCompanionFor(primary);

    // Each allowed pair has its own tuned final secondary color.
    // This keeps combinations cohesive instead of reusing one generic hue.
    return switch ((primary, safeCompanion)) {
      // Yellow family
      (GlyphoraThemeColor.yellow, GlyphoraThemeColor.yellow) => const Color(
        0xFFE0A82E,
      ),
      (GlyphoraThemeColor.yellow, GlyphoraThemeColor.orange) => const Color(
        0xFFE3A23A,
      ),
      (GlyphoraThemeColor.yellow, GlyphoraThemeColor.green) => const Color(
        0xFF9AAE48,
      ),

      // Purple family
      (GlyphoraThemeColor.purple, GlyphoraThemeColor.purple) => const Color(
        0xFF5D4DB3,
      ),
      (GlyphoraThemeColor.purple, GlyphoraThemeColor.blue) => const Color(
        0xFF5A67C8,
      ),
      (GlyphoraThemeColor.purple, GlyphoraThemeColor.pink) => const Color(
        0xFFB45F9D,
      ),

      // Blue family
      (GlyphoraThemeColor.blue, GlyphoraThemeColor.blue) => const Color(0xFF2F6FD4),
      (GlyphoraThemeColor.blue, GlyphoraThemeColor.purple) => const Color(
        0xFF665EC4,
      ),
      (GlyphoraThemeColor.blue, GlyphoraThemeColor.cyan) => const Color(0xFF3B93C7),

      // Green family
      (GlyphoraThemeColor.green, GlyphoraThemeColor.green) => const Color(
        0xFF2E9B67,
      ),
      (GlyphoraThemeColor.green, GlyphoraThemeColor.cyan) => const Color(
        0xFF329C91,
      ),
      (GlyphoraThemeColor.green, GlyphoraThemeColor.yellow) => const Color(
        0xFF93A94A,
      ),

      // Orange family
      (GlyphoraThemeColor.orange, GlyphoraThemeColor.orange) => const Color(
        0xFF87563A,
      ),
      (GlyphoraThemeColor.orange, GlyphoraThemeColor.red) => const Color(
        0xFF9C5D4D,
      ),
      (GlyphoraThemeColor.orange, GlyphoraThemeColor.pink) => const Color(
        0xFFA46668,
      ),

      // Pink family
      (GlyphoraThemeColor.pink, GlyphoraThemeColor.pink) => const Color(0xFFD94F91),
      (GlyphoraThemeColor.pink, GlyphoraThemeColor.purple) => const Color(
        0xFFB85FA7,
      ),
      (GlyphoraThemeColor.pink, GlyphoraThemeColor.red) => const Color(0xFFE85D75),

      // Cyan family
      (GlyphoraThemeColor.cyan, GlyphoraThemeColor.cyan) => const Color(0xFF2398A8),
      (GlyphoraThemeColor.cyan, GlyphoraThemeColor.blue) => const Color(0xFF3A83BF),
      (GlyphoraThemeColor.cyan, GlyphoraThemeColor.green) => const Color(
        0xFF369B86,
      ),

      // Red family
      (GlyphoraThemeColor.red, GlyphoraThemeColor.red) => const Color(0xFFD94744),
      (GlyphoraThemeColor.red, GlyphoraThemeColor.orange) => const Color(
        0xFFE46D45,
      ),
      (GlyphoraThemeColor.red, GlyphoraThemeColor.pink) => const Color(0xFFE76782),

      // Defensive fallback. Normally unreachable because of the whitelist.
      _ => companionAccentFor(safeCompanion),
    };
  }

  static Color _surfaceFor(GlyphoraThemeColor color) {
    return switch (color) {
      GlyphoraThemeColor.acid => originalBackground,
      GlyphoraThemeColor.yellow => const Color(0xFFFFF6D8),
      GlyphoraThemeColor.purple => const Color(0xFFF3F0FF),
      GlyphoraThemeColor.blue => const Color(0xFFF7F9FC),
      GlyphoraThemeColor.green => const Color(0xFFEFF8F3),
      GlyphoraThemeColor.orange => const Color(0xFFF1EFEA),
      GlyphoraThemeColor.pink => const Color(0xFFFFF0F6),
      GlyphoraThemeColor.cyan => const Color(0xFFEDF9FB),
      GlyphoraThemeColor.red => const Color(0xFFFFF0EE),
    };
  }

  static Color _nightSurfaceFor(GlyphoraThemeColor color) {
    if (color == GlyphoraThemeColor.acid) {
      return nightBackground;
    }

    return Color.alphaBlend(
      accentFor(color).withValues(alpha: 0.025),
      nightBackground,
    );
  }

  static Color _nightCardFor(GlyphoraThemeColor color) {
    if (color == GlyphoraThemeColor.acid) {
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

extension GlyphoraThemeContext on BuildContext {
  Color get glyphoraAccent => Theme.of(this).colorScheme.primary;
  Color get glyphoraSecondary => Theme.of(this).colorScheme.secondary;
  Color get glyphoraSurface => Theme.of(this).colorScheme.surface;
}
