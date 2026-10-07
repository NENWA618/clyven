import 'dart:html' as html;

String? readStored(String key) {
  try {
    return html.window.localStorage[key];
  } catch (_) {
    return null;
  }
}

void writeStored(String key, String? value) {
  try {
    if (value == null) {
      html.window.localStorage.remove(key);
    } else {
      html.window.localStorage[key] = value;
    }
  } catch (_) {
    // Keep the in-memory selection even if persistence is unavailable.
  }
}

String browserLanguage() => html.window.navigator.language;

String locationHash() => html.window.location.hash;

void setDocumentLang(String lang) {
  html.document.documentElement?.lang = lang;
}
