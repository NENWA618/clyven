import 'package:flutter/material.dart';

enum ClyvenThemeMode {
  accentOnly,
  full,
}

enum ClyvenThemeColor {
  acid,
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

  const ClyvenThemeSettings({
    this.mode = ClyvenThemeMode.accentOnly,
    this.color = ClyvenThemeColor.acid,
  });

  ClyvenThemeSettings copyWith({
    ClyvenThemeMode? mode,
    ClyvenThemeColor? color,
  }) {
    return ClyvenThemeSettings(
      mode: mode ?? this.mode,
      color: color ?? this.color,
    );
  }
}

class ClyvenTheme {
  ClyvenTheme._();

  /// Original Clyven brand acid yellow. This color must always remain available.
  static const Color brandAcid = Color(0xFFE5FF58);
  static const Color originalPurple = Color(0xFF7657FF);
  static const Color originalBackground = Color(0xFFF4F1EA);
  static const Color ink = Color(0xFF161616);

  static Color accentFor(ClyvenThemeColor color) {
    return switch (color) {
      ClyvenThemeColor.acid => brandAcid,
      ClyvenThemeColor.purple => const Color(0xFF8B6CFF),
      ClyvenThemeColor.blue => const Color(0xFF4F8CFF),
      ClyvenThemeColor.green => const Color(0xFF4FD18B),
      ClyvenThemeColor.orange => const Color(0xFFFF9B4A),
      ClyvenThemeColor.pink => const Color(0xFFFF6FAE),
      ClyvenThemeColor.cyan => const Color(0xFF47D7E8),
      ClyvenThemeColor.red => const Color(0xFFFF625F),
    };
  }

  static ThemeData build(ClyvenThemeSettings settings) {
    final accent = accentFor(settings.color);
    final fullTheme = settings.mode == ClyvenThemeMode.full;
    final secondary = fullTheme
        ? _secondaryFor(settings.color)
        : originalPurple;
    final surface = fullTheme
        ? _surfaceFor(settings.color)
        : originalBackground;

    final scheme = ColorScheme.light(
      primary: accent,
      onPrimary: _onAccent(accent),
      secondary: secondary,
      onSecondary: _onAccent(secondary),
      surface: surface,
      onSurface: ink,
      error: const Color(0xFFD93B3B),
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: surface,
      canvasColor: surface,
      splashColor: accent.withValues(alpha: 0.12),
      highlightColor: accent.withValues(alpha: 0.08),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: accent,
      ),
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

  static Color _secondaryFor(ClyvenThemeColor color) {
    return switch (color) {
      ClyvenThemeColor.acid => originalPurple,
      ClyvenThemeColor.purple => const Color(0xFFE5FF58),
      ClyvenThemeColor.blue => const Color(0xFF6B5CFF),
      ClyvenThemeColor.green => const Color(0xFF3B8D77),
      ClyvenThemeColor.orange => const Color(0xFFFF668E),
      ClyvenThemeColor.pink => const Color(0xFF8B6CFF),
      ClyvenThemeColor.cyan => const Color(0xFF3478F6),
      ClyvenThemeColor.red => const Color(0xFFFFA84A),
    };
  }

  static Color _surfaceFor(ClyvenThemeColor color) {
    return switch (color) {
      ClyvenThemeColor.acid => originalBackground,
      ClyvenThemeColor.purple => const Color(0xFFF3F0FF),
      ClyvenThemeColor.blue => const Color(0xFFF0F5FF),
      ClyvenThemeColor.green => const Color(0xFFEFF8F3),
      ClyvenThemeColor.orange => const Color(0xFFFFF3E9),
      ClyvenThemeColor.pink => const Color(0xFFFFF0F6),
      ClyvenThemeColor.cyan => const Color(0xFFEDF9FB),
      ClyvenThemeColor.red => const Color(0xFFFFF0EE),
    };
  }

  static Color _onAccent(Color color) {
    return color.computeLuminance() > 0.55
        ? ink
        : Colors.white;
  }
}
