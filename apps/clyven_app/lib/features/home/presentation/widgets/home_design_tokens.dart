import 'package:flutter/material.dart';

abstract final class HomeDesignTokens {
  static const brand = Color(0xFFA85F36);
  static const brandDark = Color(0xFFD49A6A);
  static const lightBackground = Color(0xFFF1EFEA);
  static const darkBackground = Color(0xFF0D0D0C);
  static const lightSurface = Color(0xFFF9F7F2);
  static const darkSurface = Color(0xFF191918);
  static const lightBorder = Color(0xFFDED9D0);
  static const darkBorder = Color(0xFF302E2A);

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkBackground
      : lightBackground;

  static Color surface(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkSurface
      : lightSurface;

  static Color border(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? darkBorder
      : lightBorder;

  static Color muted(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color(0xFFA6A098)
      : const Color(0xFF716D66);

  static Color brandFor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? brandDark : brand;

  static List<BoxShadow> cardShadow(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const []
      : const [
          BoxShadow(
            color: Color(0x140E0D0B),
            blurRadius: 30,
            offset: Offset(0, 12),
          ),
        ];
}
