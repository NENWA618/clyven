import '../../dictionary.dart';
import '../converter.dart';
import '../dictionary.dart';
import '../models.dart';
import '../profile.dart';

ScriptConversionProfile createVietnameseNomProfile() {
  return ScriptConversionProfile(
    id: 'vi-latn-nom',
    languageCode: 'vi',
    sourceScript: 'Latn',
    targetScript: 'Nom',
    sourceWordPattern: RegExp(
      "[A-Za-z\\u00C0-\\u00D6\\u00D8-\\u00F6\\u00F8-\\u1EF9\\u0110\\u0111]+"
      "(?:['\\u2019-][A-Za-z\\u00C0-\\u00D6\\u00D8-\\u00F6\\u00F8-\\u1EF9\\u0110\\u0111]+)*",
      unicode: true,
    ),
    normalizeSource: NomDictionary.normalizeLatin,
  );
}

class VietnameseNomScriptConverter {
  VietnameseNomScriptConverter(NomDictionary nomDictionary)
    : profile = createVietnameseNomProfile(),
      _converter = _createConverter(nomDictionary);

  final ScriptConversionProfile profile;
  final ScriptConverter _converter;

  ScriptConversionResult convertLatinToNom(String text) {
    return _converter.convertForward(text);
  }

  ScriptConversionResult convertNomToLatin(String text) {
    return _converter.convertReverse(text);
  }

  static ScriptConverter _createConverter(NomDictionary nomDictionary) {
    final profile = createVietnameseNomProfile();

    return ScriptConverter(
      profile: profile,
      dictionary: ScriptDictionary(
        nomDictionary.entries.map(
          (entry) => ScriptDictionaryEntry(
            source: entry.latin,
            target: entry.nom,
            priority: entry.priority,
            note: entry.note,
            metadata: entry.metadata,
          ),
        ),
        profile: profile,
      ),
    );
  }
}
