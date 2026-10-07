import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import 'src/browser_env_stub.dart'
    if (dart.library.html) 'src/browser_env_web.dart';

/// Language preference, mirroring the app's system / English / Simplified
/// Chinese options.
enum WebLocalePreference { system, en, zh }

enum WebLang { en, zh }

const _storageKey = 'glyphora.web_locale';

/// Fragment key used to carry the language across origins (Web -> Studio).
const languageHandoffKey = 'lang';

/// Reads a language handed over in the URL fragment (`#lang=en|zh`) into
/// localStorage. Call before the first build; it does not touch other
/// fragment parameters.
void consumeLanguageHandoff() {
  final match = RegExp(
    '(?:^#|&)$languageHandoffKey=(en|zh)(?:&|\$)',
  ).firstMatch(locationHash());
  if (match == null) return;
  writeStored(_storageKey, match.group(1));
}

/// Adds the current language to [url]'s fragment so another origin can pick it
/// up with [consumeLanguageHandoff].
String withLanguageHandoff(String url, WebLocalePreference preference) {
  if (preference == WebLocalePreference.system) return url;
  final uri = Uri.parse(url);
  final fragment = uri.fragment.isEmpty
      ? '$languageHandoffKey=${preference.name}'
      : '${uri.fragment}&$languageHandoffKey=${preference.name}';
  return uri.replace(fragment: fragment).toString();
}

WebLocalePreference _readPreference() {
  return switch (readStored(_storageKey)) {
    'en' => WebLocalePreference.en,
    'zh' => WebLocalePreference.zh,
    _ => WebLocalePreference.system,
  };
}

void _writePreference(WebLocalePreference preference) {
  writeStored(
    _storageKey,
    preference == WebLocalePreference.system ? null : preference.name,
  );
}

WebLang _resolve(WebLocalePreference preference) {
  switch (preference) {
    case WebLocalePreference.en:
      return WebLang.en;
    case WebLocalePreference.zh:
      return WebLang.zh;
    case WebLocalePreference.system:
      return browserLanguage().toLowerCase().startsWith('zh')
          ? WebLang.zh
          : WebLang.en;
  }
}

/// Language for code that has no [BuildContext] (service errors, status text).
/// Reads the stored preference each time, so it always matches the switcher.
WebLang get currentWebLang => _resolve(_readPreference());

/// Picks the string for the current language without a [BuildContext]. The
/// result is fixed once produced, so use [BuildContext.tr] for anything that
/// must follow a later language switch.
String trNow(String en, String zh) =>
    currentWebLang == WebLang.zh ? zh : en;

/// Owns the language preference and exposes it to the tree via [WebL10n].
class WebLocaleRoot extends StatefulComponent {
  const WebLocaleRoot({required this.child, super.key});

  final Component child;

  @override
  State<WebLocaleRoot> createState() => _WebLocaleRootState();
}

class _WebLocaleRootState extends State<WebLocaleRoot> {
  late WebLocalePreference _preference;

  void _applyLang(WebLocalePreference preference) {
    setDocumentLang(_resolve(preference) == WebLang.zh ? 'zh' : 'en');
  }

  void _setPreference(WebLocalePreference preference) {
    _writePreference(preference);
    _applyLang(preference);
    setState(() => _preference = preference);
  }

  @override
  void initState() {
    super.initState();
    consumeLanguageHandoff();
    _preference = _readPreference();
    _applyLang(_preference);
  }

  @override
  Component build(BuildContext context) {
    return WebL10n(
      preference: _preference,
      lang: _resolve(_preference),
      setPreference: _setPreference,
      child: component.child,
    );
  }
}

class WebL10n extends InheritedComponent {
  const WebL10n({
    required this.preference,
    required this.lang,
    required this.setPreference,
    required super.child,
    super.key,
  });

  final WebLocalePreference preference;
  final WebLang lang;
  final void Function(WebLocalePreference preference) setPreference;

  static WebL10n of(BuildContext context) {
    final scope = context.dependOnInheritedComponentOfExactType<WebL10n>();
    assert(scope != null, 'WebL10n is missing from the component tree.');
    return scope!;
  }

  @override
  bool updateShouldNotify(WebL10n oldComponent) =>
      oldComponent.lang != lang || oldComponent.preference != preference;
}

extension WebL10nTr on BuildContext {
  /// Current language, registering a dependency so the caller rebuilds when
  /// the user switches language.
  WebLang get lang => WebL10n.of(this).lang;

  bool get isZh => lang == WebLang.zh;

  /// Picks the string for the current language.
  String tr(String en, String zh) => isZh ? zh : en;
}

/// The language `<select>` (system / English / Simplified Chinese). Labels
/// are fixed per option so they stay recognisable in any language.
class LanguageSwitcher extends StatelessComponent {
  const LanguageSwitcher({super.key});

  @override
  Component build(BuildContext context) {
    final scope = WebL10n.of(context);
    final label = context.tr('Language', '语言');

    return select(
      classes: 'language-switcher',
      value: scope.preference.name,
      attributes: {'aria-label': label, 'title': label},
      onChange: (values) {
        if (values.isEmpty) return;
        scope.setPreference(
          WebLocalePreference.values.firstWhere(
            (p) => p.name == values.first,
            orElse: () => WebLocalePreference.system,
          ),
        );
      },
      [
        option(
          value: 'system',
          selected: scope.preference == WebLocalePreference.system,
          [.text(context.tr('System default', '跟随系统'))],
        ),
        option(
          value: 'en',
          selected: scope.preference == WebLocalePreference.en,
          [.text('English')],
        ),
        option(
          value: 'zh',
          selected: scope.preference == WebLocalePreference.zh,
          [.text(context.tr('Simplified Chinese', '简体中文'))],
        ),
      ],
    );
  }
}
