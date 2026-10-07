// One-off migration helper: rewrites literal colours and radii in a stylesheet
// to the shared design tokens in design/glyphora-tokens.css.
//
//   dart run tool/tokenize_css.dart <file.css> light|dark
//
// The second argument is the stylesheet's NATIVE mode (the palette its literal
// colours were written for). The file is rewritten in place; run it once, then
// maintain the result by hand (new colours should use the tokens directly).
import 'dart:io';
import 'dart:math' as math;

void main(List<String> args) {
  if (args.length != 2 || (args[1] != 'light' && args[1] != 'dark')) {
    stderr.writeln('usage: dart run tool/tokenize_css.dart <file.css> light|dark');
    exit(64);
  }
  final file = File(args[0]);
  final raw = file.readAsStringSync();
  final crlf = raw.contains('\r\n');
  final src = raw.replaceAll('\r\n', '\n');
  final t = _Tokenizer(darkNative: args[1] == 'dark');
  final out = t.run(src);
  file.writeAsStringSync(crlf ? out.replaceAll('\n', '\r\n') : out);
  stdout.writeln(
    '${args[0]}: ${t.colors} colours, ${t.radii} radii rewritten, ${t.kept} colours kept literal',
  );
}

enum _Kind { bg, text, border, shadow }

const _bgProps = {'background', 'background-color', 'background-image'};
const _borderProps = {
  'border', 'border-color', 'border-top', 'border-right', 'border-bottom',
  'border-left', 'border-top-color', 'border-right-color',
  'border-bottom-color', 'border-left-color', 'border-block', 'border-inline',
  'outline', 'outline-color', 'column-rule',
};
const _textProps = {
  'color', 'fill', 'stroke', 'caret-color', 'text-decoration-color',
  '-webkit-text-fill-color',
};
const _shadowProps = {'box-shadow', 'text-shadow', 'filter', 'drop-shadow'};
const _radiusProps = {
  'border-radius', 'border-top-left-radius', 'border-top-right-radius',
  'border-bottom-left-radius', 'border-bottom-right-radius',
};

class _Tokenizer {
  _Tokenizer({required this.darkNative});

  final bool darkNative;
  int colors = 0, radii = 0, kept = 0;

  // ------------------------------------------------------------ block walker

  String run(String s) {
    final out = StringBuffer();
    var i = 0;
    while (i < s.length) {
      final c = s[i];
      if (c == '/' && i + 1 < s.length && s[i + 1] == '*') {
        final end = s.indexOf('*/', i + 2);
        final stop = end == -1 ? s.length : end + 2;
        out.write(s.substring(i, stop));
        i = stop;
        continue;
      }
      if (c == '"' || c == "'") {
        final stop = _endOfString(s, i);
        out.write(s.substring(i, stop));
        i = stop;
        continue;
      }
      if (c == '(') {
        // url(...), gradients in preludes, :not(...) — copy balanced parens.
        final stop = _endOfParens(s, i);
        out.write(s.substring(i, stop));
        i = stop;
        continue;
      }
      if (c == '{') {
        final close = _leafClose(s, i);
        if (close != -1) {
          out.write('{');
          out.write(_transformBlock(s.substring(i + 1, close)));
          out.write('}');
          i = close + 1;
          continue;
        }
      }
      out.write(c);
      i++;
    }
    return out.toString();
  }

  int _endOfString(String s, int i) {
    final q = s[i];
    var j = i + 1;
    while (j < s.length && !(s[j] == q && s[j - 1] != '\\')) {
      j++;
    }
    return math.min(j + 1, s.length);
  }

  int _endOfParens(String s, int i) {
    var depth = 0;
    var j = i;
    while (j < s.length) {
      final c = s[j];
      if (c == '"' || c == "'") {
        j = _endOfString(s, j);
        continue;
      }
      if (c == '(') depth++;
      if (c == ')') {
        depth--;
        if (depth == 0) return j + 1;
      }
      j++;
    }
    return s.length;
  }

  /// If the block opened at [open] has no nested block, returns the index of
  /// its closing brace; otherwise -1.
  int _leafClose(String s, int open) {
    var j = open + 1;
    while (j < s.length) {
      final c = s[j];
      if (c == '/' && j + 1 < s.length && s[j + 1] == '*') {
        final end = s.indexOf('*/', j + 2);
        j = end == -1 ? s.length : end + 2;
        continue;
      }
      if (c == '"' || c == "'") {
        j = _endOfString(s, j);
        continue;
      }
      if (c == '(') {
        j = _endOfParens(s, j);
        continue;
      }
      if (c == '{') return -1;
      if (c == '}') return j;
      j++;
    }
    return -1;
  }

  // -------------------------------------------------------- declarations

  String _transformBlock(String block) {
    // Split into declarations, keeping the original separators/whitespace.
    final pieces = _splitKeep(block);
    // Pass 1: does this rule paint a solid, saturated or dark surface?
    var solidBg = false;
    for (final p in pieces) {
      final d = _decl(p);
      if (d == null || !_bgProps.contains(d.prop)) continue;
      for (final m in _colorRe.allMatches(d.value)) {
        final c = _parse(m.group(0)!);
        if (c == null || c.a < 0.6) continue;
        final sat = c.s > 0.25 && c.l > 0.2 && c.l < 0.62;
        final dark = darkNative ? false : c.l < 0.25;
        if (sat || dark) solidBg = true;
      }
    }
    final out = StringBuffer();
    for (final p in pieces) {
      final d = _decl(p);
      if (d == null) {
        out.write(p);
        continue;
      }
      var value = d.value;
      final prop = d.prop;
      if (_bgProps.contains(prop)) {
        value = _mapColors(value, _Kind.bg, solidBg);
      } else if (_borderProps.contains(prop)) {
        value = _mapColors(value, _Kind.border, solidBg);
      } else if (_textProps.contains(prop)) {
        value = _mapColors(value, _Kind.text, solidBg);
      } else if (_shadowProps.contains(prop)) {
        value = _mapColors(value, _Kind.shadow, solidBg);
      } else if (_radiusProps.contains(prop)) {
        value = _mapRadius(value);
      } else {
        out.write(p);
        continue;
      }
      out.write('${d.lead}${d.rawProp}:${d.gap}$value${d.important}${d.trail}');
    }
    return out.toString();
  }

  List<String> _splitKeep(String s) {
    final parts = <String>[];
    var depth = 0, start = 0;
    String? quote;
    for (var i = 0; i < s.length; i++) {
      final c = s[i];
      if (quote != null) {
        if (c == quote && s[i - 1] != '\\') quote = null;
        continue;
      }
      if (c == '"' || c == "'") {
        quote = c;
      } else if (c == '(') {
        depth++;
      } else if (c == ')') {
        depth--;
      } else if (c == ';' && depth == 0) {
        parts.add(s.substring(start, i + 1));
        start = i + 1;
      }
    }
    if (start < s.length) parts.add(s.substring(start));
    return parts;
  }

  _Decl? _decl(String piece) {
    final m = RegExp(
      r'^(\s*(?:/\*[\s\S]*?\*/\s*)*)([-a-zA-Z]+)(\s*):(\s*)([\s\S]*?)(\s*!important)?(\s*;?\s*)$',
    ).firstMatch(piece);
    if (m == null) return null;
    final value = m.group(5)!;
    if (value.trim().isEmpty) return null;
    return _Decl(
      lead: m.group(1)!,
      rawProp: m.group(2)! + m.group(3)!,
      prop: m.group(2)!.toLowerCase(),
      gap: m.group(4)!,
      value: value,
      important: m.group(6) ?? '',
      trail: m.group(7) ?? '',
    );
  }

  // ------------------------------------------------------------- radius

  String _mapRadius(String value) {
    return value.replaceAllMapped(RegExp(r'(?<![\w.-])(\d+(?:\.\d+)?)px'), (m) {
      final n = double.parse(m.group(1)!);
      String? token;
      if (n >= 6 && n <= 7) {
        token = 'var(--r-xs)';
      } else if (n >= 8 && n <= 13) {
        token = 'var(--r-sm)';
      } else if (n >= 14 && n <= 19) {
        token = 'var(--r-md)';
      } else if (n >= 20 && n < 100) {
        token = 'var(--r-lg)';
      } else if (n >= 100) {
        token = 'var(--r-pill)';
      }
      if (token == null) return m.group(0)!;
      radii++;
      return token;
    });
  }

  // ------------------------------------------------------------- colours

  static final _colorRe = RegExp(
    r'#[0-9a-fA-F]{8}\b|#[0-9a-fA-F]{6}\b|#[0-9a-fA-F]{3,4}\b|rgba?\([^)]*\)|(?<![\w-])(?:white|black)(?![\w-])',
    caseSensitive: false,
  );

  String _mapColors(String value, _Kind kind, bool solidBg) {
    final parts = <String>[];
    var last = 0;
    for (final m in RegExp(r'url\([^)]*\)').allMatches(value)) {
      parts.add(_mapSegment(value.substring(last, m.start), kind, solidBg));
      parts.add(m.group(0)!);
      last = m.end;
    }
    parts.add(_mapSegment(value.substring(last), kind, solidBg));
    return parts.join();
  }

  String _mapSegment(String seg, _Kind kind, bool solidBg) {
    return seg.replaceAllMapped(_colorRe, (m) {
      final c = _parse(m.group(0)!);
      if (c == null) return m.group(0)!;
      final mapped = _map(c, kind, solidBg);
      if (mapped == null) {
        kept++;
        return m.group(0)!;
      }
      colors++;
      return mapped;
    });
  }

  /// Hue family of a chromatic colour.
  String _family(_Color c) {
    final h = c.h;
    if (h < 15 || h >= 345) return 'danger';
    if (h < 70) return 'warn';
    if (h < 165) return 'ok';
    if (h >= 200 && h < 262) return 'accent';
    if (h >= 262 && h < 330) return 'accent';
    return 'other';
  }

  bool _neutral(_Color c) =>
      c.s < 0.15 || (c.h >= 195 && c.h <= 260 && c.s < 0.6 && (c.l > 0.8 || c.l < 0.2 || c.s < 0.35));

  String _alpha(String token, double a) {
    if (a >= 0.999) return token;
    final pct = (a * 100).round();
    return 'color-mix(in srgb, $token $pct%, transparent)';
  }

  String? _map(_Color c, _Kind kind, bool solidBg) {
    final l = c.l;
    final neutral = _neutral(c);
    final a = c.a;

    if (kind == _Kind.shadow) {
      if (neutral && l < 0.45) return 'rgba(var(--shadow-rgb), ${_fmt(a)})';
      if (!neutral && _family(c) == 'accent' && l >= 0.3 && l <= 0.7) {
        return _alpha('var(--accent)', a);
      }
      return null;
    }

    if (neutral) {
      switch (kind) {
        case _Kind.bg:
          // Translucent dark scrims (video overlays, tooltips) stay dark.
          if (a < 0.99 && l < (darkNative ? 0.12 : 0.5)) return null;
          return _alpha(_neutralBg(l, solidBg), a);
        case _Kind.text:
          return _neutralText(l, solidBg);
        case _Kind.border:
          return _alpha(_neutralBorder(l), a);
        case _Kind.shadow:
          return null;
      }
    }

    final fam = _family(c);
    if (fam == 'other') return null;
    final soft = 'var(--${fam == 'accent' ? 'accent' : fam}-soft)';
    final solid = switch (fam) {
      'accent' => 'var(--accent)',
      'ok' => 'var(--ok-solid)',
      'warn' => 'var(--warn-solid)',
      _ => 'var(--danger-solid)',
    };
    final textTok = switch (fam) {
      'accent' => 'var(--accent-text)',
      'ok' => 'var(--ok)',
      'warn' => 'var(--warn)',
      _ => 'var(--danger)',
    };

    switch (kind) {
      case _Kind.bg:
        if (darkNative) {
          if (l < 0.32) return _alpha(soft, a);
          if (l < 0.62) return _alpha(solid, a);
          return _alpha(soft, a);
        }
        if (l >= 0.88) return _alpha(soft, a);
        if (l >= 0.72) {
          return _alpha('color-mix(in srgb, $solid 24%, var(--surface))', a);
        }
        return _alpha(solid, a);
      case _Kind.text:
        if (darkNative) {
          return l >= 0.5 ? textTok : (l < 0.32 ? textTok : textTok);
        }
        return textTok;
      case _Kind.border:
        if (darkNative) {
          if (l < 0.32) return _alpha(soft, a);
          return _alpha(l < 0.62 ? solid : soft, a);
        }
        if (l >= 0.78) {
          return _alpha('color-mix(in srgb, $solid 28%, var(--surface))', a);
        }
        return _alpha(solid, a);
      case _Kind.shadow:
        return null;
    }
  }

  String _neutralBg(double l, bool solidBg) {
    if (darkNative) {
      if (l < 0.04) return 'var(--bg-alt)';
      if (l < 0.075) return 'var(--bg)';
      if (l < 0.125) return 'var(--surface)';
      if (l < 0.19) return 'var(--surface-2)';
      if (l < 0.3) return 'var(--surface-3)';
      if (l < 0.6) return 'var(--border-strong)';
      return 'var(--surface-3)';
    }
    if (l >= 0.995) return 'var(--surface)';
    if (l >= 0.935) return 'var(--bg)';
    if (l >= 0.87) return 'var(--surface-2)';
    if (l >= 0.72) return 'var(--surface-3)';
    if (l >= 0.5) return 'var(--border-strong)';
    return 'var(--solid)'; // dark chips / tooltips / dark buttons
  }

  String? _neutralText(double l, bool solidBg) {
    if (darkNative) {
      if (l >= 0.97) return solidBg ? null : 'var(--text)';
      if (l >= 0.8) return 'var(--text)';
      if (l >= 0.5) return 'var(--muted)';
      if (l >= 0.32) return 'var(--faint)';
      return null; // dark text on a bright surface: leave
    }
    if (l >= 0.93) return null; // white on accent / dark areas
    if (l < 0.3) return solidBg ? null : 'var(--text)';
    if (l < 0.5) return 'var(--muted)';
    if (l < 0.72) return 'var(--faint)';
    return null;
  }

  String _neutralBorder(double l) {
    if (darkNative) {
      if (l < 0.07) return 'var(--bg)';
      if (l < 0.3) return 'var(--border)';
      return 'var(--border-strong)';
    }
    if (l >= 0.995) return 'var(--surface)';
    if (l >= 0.84) return 'var(--border)';
    if (l >= 0.4) return 'var(--border-strong)';
    return 'var(--solid)';
  }

  String _fmt(double a) => double.parse(a.toStringAsFixed(3)).toString();

  // ------------------------------------------------------------- parsing

  _Color? _parse(String text) {
    final t = text.toLowerCase();
    if (t == 'white') return _Color.rgb(255, 255, 255, 1);
    if (t == 'black') return _Color.rgb(0, 0, 0, 1);
    if (t.startsWith('#')) {
      var hex = t.substring(1);
      if (hex.length == 3 || hex.length == 4) {
        hex = hex.split('').map((ch) => '$ch$ch').join();
      }
      final r = int.parse(hex.substring(0, 2), radix: 16);
      final g = int.parse(hex.substring(2, 4), radix: 16);
      final b = int.parse(hex.substring(4, 6), radix: 16);
      final a = hex.length == 8 ? int.parse(hex.substring(6, 8), radix: 16) / 255 : 1.0;
      return _Color.rgb(r, g, b, a);
    }
    final nums = RegExp(r'[\d.]+%?')
        .allMatches(t.substring(t.indexOf('(')))
        .map((m) => m.group(0)!)
        .toList();
    if (nums.length < 3) return null;
    double ch(String v) => v.endsWith('%')
        ? double.parse(v.substring(0, v.length - 1)) * 2.55
        : double.parse(v);
    final a = nums.length > 3
        ? (nums[3].endsWith('%')
              ? double.parse(nums[3].substring(0, nums[3].length - 1)) / 100
              : double.parse(nums[3]))
        : 1.0;
    return _Color.rgb(ch(nums[0]).round(), ch(nums[1]).round(), ch(nums[2]).round(), a);
  }
}

class _Decl {
  _Decl({
    required this.lead,
    required this.rawProp,
    required this.prop,
    required this.gap,
    required this.value,
    required this.important,
    required this.trail,
  });

  final String lead, rawProp, prop, gap, value, important, trail;
}

class _Color {
  _Color(this.h, this.s, this.l, this.a);

  factory _Color.rgb(int r, int g, int b, double a) {
    final rf = r / 255, gf = g / 255, bf = b / 255;
    final maxC = math.max(rf, math.max(gf, bf));
    final minC = math.min(rf, math.min(gf, bf));
    final l = (maxC + minC) / 2;
    var h = 0.0, s = 0.0;
    final d = maxC - minC;
    if (d != 0) {
      s = l > 0.5 ? d / (2 - maxC - minC) : d / (maxC + minC);
      if (maxC == rf) {
        h = ((gf - bf) / d + (gf < bf ? 6 : 0)) * 60;
      } else if (maxC == gf) {
        h = ((bf - rf) / d + 2) * 60;
      } else {
        h = ((rf - gf) / d + 4) * 60;
      }
    }
    return _Color(h, s, l, a);
  }

  final double h, s, l, a;
}
