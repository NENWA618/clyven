import 'dart:io';

import 'package:flutter/material.dart';

class HomeMedia extends StatelessWidget {
  final String path;
  final BoxFit fit;

  const HomeMedia({super.key, required this.path, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    if (path.isEmpty) return const _MediaFallback();
    final network = path.startsWith('http://') || path.startsWith('https://');
    if (network) {
      return Image.network(
        path,
        fit: fit,
        errorBuilder: (_, _, _) => const _MediaFallback(),
      );
    }
    return Image.file(
      File(path),
      fit: fit,
      errorBuilder: (_, _, _) => const _MediaFallback(),
    );
  }
}

class _MediaFallback extends StatelessWidget {
  const _MediaFallback();

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ColoredBox(
      color: dark ? const Color(0xFF24221F) : const Color(0xFFE4DFD6),
      child: Center(
        child: Icon(
          Icons.play_circle_outline_rounded,
          size: 36,
          color: dark ? const Color(0xFF777168) : const Color(0xFF9A9287),
        ),
      ),
    );
  }
}

class VideoDurationBadge extends StatelessWidget {
  final String duration;

  const VideoDurationBadge({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xE0121110),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        child: Text(
          duration,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            height: 1,
            fontWeight: FontWeight.w700,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ),
    );
  }
}

class CreatorAvatar extends StatelessWidget {
  final String name;
  final double size;

  const CreatorAvatar({super.key, required this.name, this.size = 28});

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isEmpty ? 'C' : name.trim()[0].toUpperCase();
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF3B2D25)
            : const Color(0xFFEADBCF),
        shape: BoxShape.circle,
      ),
      child: Text(
        initial,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFF0C6A2)
              : const Color(0xFF7E472A),
          fontSize: size * .38,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
