// Non-browser fallback (VM tests): nothing is stored and the language is
// always the default.
String? readStored(String key) => null;
void writeStored(String key, String? value) {}
String browserLanguage() => 'en';
String locationHash() => '';
void setDocumentLang(String lang) {}
