import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class DictionaryEndpoint extends Endpoint {
  Future<DictionaryEntryDetail?> lookup(
    Session session, {
    required String languageCode,
    required String normalizedText,
    required String entryType,
    required String explanationLanguageCode,
  }) async {
    final entry = await DictionaryEntry.db.findFirstRow(
      session,
      where: (e) =>
          e.languageCode.equals(languageCode) &
          e.normalizedText.equals(normalizedText) &
          e.entryType.equals(entryType),
    );

    if (entry == null) {
      return null;
    }

    final definitions = await DictionaryDefinition.db.find(
      session,
      where: (d) =>
          d.entryId.equals(entry.id) &
          d.explanationLanguageCode.equals(
            explanationLanguageCode,
          ),
    );

    final forms = await DictionaryForm.db.find(
      session,
      where: (f) => f.entryId.equals(entry.id),
    );

    final examples = await DictionaryExample.db.find(
      session,
      where: (e) => e.entryId.equals(entry.id),
      orderBy: (e) => e.position,
    );

    final exampleDetails = <DictionaryExampleDetail>[];

    for (final example in examples) {
      final texts = await DictionaryExampleText.db.find(
        session,
        where: (t) => t.exampleId.equals(example.id),
      );

      exampleDetails.add(
        DictionaryExampleDetail(
          example: example,
          texts: texts,
        ),
      );
    }

    final relations = await DictionaryRelation.db.find(
      session,
      where: (r) => r.sourceEntryId.equals(entry.id),
      orderBy: (r) => r.position,
    );

    final relationDetails = <DictionaryRelationDetail>[];

    for (final relation in relations) {
      final targetEntry = await DictionaryEntry.db.findById(
        session,
        relation.targetEntryId,
      );

      if (targetEntry == null) {
        continue;
      }

      final targetDefinitions = await DictionaryDefinition.db.find(
        session,
        where: (d) =>
            d.entryId.equals(targetEntry.id) &
            d.explanationLanguageCode.equals(
              explanationLanguageCode,
            ),
      );

      relationDetails.add(
        DictionaryRelationDetail(
          relation: relation,
          targetEntry: targetEntry,
          targetDefinitions: targetDefinitions,
        ),
      );
    }

    return DictionaryEntryDetail(
      entry: entry,
      definitions: definitions,
      forms: forms,
      examples: exampleDetails,
      relations: relationDetails,
    );
  }

  Future<DictionaryEntryDetail?> getById(
    Session session, {
    required int entryId,
    required String explanationLanguageCode,
  }) async {
    final entry = await DictionaryEntry.db.findById(
      session,
      entryId,
    );

    if (entry == null) {
      return null;
    }

    final definitions = await DictionaryDefinition.db.find(
      session,
      where: (definition) =>
          definition.entryId.equals(entryId) &
          definition.explanationLanguageCode.equals(
            explanationLanguageCode,
          ),
    );

    final forms = await DictionaryForm.db.find(
      session,
      where: (form) => form.entryId.equals(entryId),
    );

    final examples = await DictionaryExample.db.find(
      session,
      where: (example) => example.entryId.equals(entryId),
      orderBy: (example) => example.position,
    );

    final exampleDetails = <DictionaryExampleDetail>[];

    for (final example in examples) {
      final exampleId = example.id;

      if (exampleId == null) {
        continue;
      }

      final texts = await DictionaryExampleText.db.find(
        session,
        where: (text) => text.exampleId.equals(exampleId),
      );

      exampleDetails.add(
        DictionaryExampleDetail(
          example: example,
          texts: texts,
        ),
      );
    }

    final relations = await DictionaryRelation.db.find(
      session,
      where: (relation) => relation.sourceEntryId.equals(entryId),
      orderBy: (relation) => relation.position,
    );

    final relationDetails = <DictionaryRelationDetail>[];

    for (final relation in relations) {
      final targetEntry = await DictionaryEntry.db.findById(
        session,
        relation.targetEntryId,
      );

      if (targetEntry == null) {
        continue;
      }

      final targetDefinitions = await DictionaryDefinition.db.find(
        session,
        where: (definition) =>
            definition.entryId.equals(targetEntry.id) &
            definition.explanationLanguageCode.equals(
              explanationLanguageCode,
            ),
      );

      relationDetails.add(
        DictionaryRelationDetail(
          relation: relation,
          targetEntry: targetEntry,
          targetDefinitions: targetDefinitions,
        ),
      );
    }

    return DictionaryEntryDetail(
      entry: entry,
      definitions: definitions,
      forms: forms,
      examples: exampleDetails,
      relations: relationDetails,
    );
  }

  Future<List<DictionaryEntryDetail>> listEntries(
    Session session, {
    required String languageCode,
    int offset = 0,
    int limit = 50,
  }) async {
    if (session.authenticated == null) {
      throw Exception('需要登录后才能查看 Studio 词库');
    }

    final safeOffset = offset < 0 ? 0 : offset;
    final safeLimit = limit.clamp(1, 100).toInt();

    final entries = await DictionaryEntry.db.find(
      session,
      where: (e) => e.languageCode.equals(
        languageCode.trim().toLowerCase(),
      ),
      orderBy: (e) => e.id,
      offset: safeOffset,
      limit: safeLimit,
    );

    if (entries.isEmpty) {
      return [];
    }

    final entryIds = entries.map((entry) => entry.id).whereType<int>().toSet();

    final definitions = await DictionaryDefinition.db.find(
      session,
      where: (d) => d.entryId.inSet(entryIds),
    );

    final forms = await DictionaryForm.db.find(
      session,
      where: (f) => f.entryId.inSet(entryIds),
    );

    final examples = await DictionaryExample.db.find(
      session,
      where: (e) => e.entryId.inSet(entryIds),
      orderBy: (e) => e.position,
    );

    final exampleIds = examples
        .map((example) => example.id)
        .whereType<int>()
        .toSet();

    final exampleTexts = exampleIds.isEmpty
        ? <DictionaryExampleText>[]
        : await DictionaryExampleText.db.find(
            session,
            where: (t) => t.exampleId.inSet(exampleIds),
          );

    final definitionsByEntryId = <int, List<DictionaryDefinition>>{};

    for (final definition in definitions) {
      definitionsByEntryId
          .putIfAbsent(
            definition.entryId,
            () => [],
          )
          .add(definition);
    }

    final formsByEntryId = <int, List<DictionaryForm>>{};

    for (final form in forms) {
      formsByEntryId
          .putIfAbsent(
            form.entryId,
            () => [],
          )
          .add(form);
    }

    final exampleTextsByExampleId = <int, List<DictionaryExampleText>>{};

    for (final text in exampleTexts) {
      exampleTextsByExampleId
          .putIfAbsent(
            text.exampleId,
            () => [],
          )
          .add(text);
    }

    final examplesByEntryId = <int, List<DictionaryExampleDetail>>{};

    for (final example in examples) {
      final exampleId = example.id;

      if (exampleId == null) {
        continue;
      }

      examplesByEntryId
          .putIfAbsent(
            example.entryId,
            () => [],
          )
          .add(
            DictionaryExampleDetail(
              example: example,
              texts: exampleTextsByExampleId[exampleId] ?? [],
            ),
          );
    }

    return [
      for (final entry in entries)
        DictionaryEntryDetail(
          entry: entry,
          definitions: entry.id == null
              ? []
              : definitionsByEntryId[entry.id!] ?? [],
          forms: entry.id == null ? [] : formsByEntryId[entry.id!] ?? [],
          examples: entry.id == null ? [] : examplesByEntryId[entry.id!] ?? [],
          relations: [],
        ),
    ];
  }

  Future<void> updateEntryRow(
    Session session, {
    required int entryId,
    required String headword,
    required String nomText,
    required String chineseGloss,
    required String partOfSpeech,
    required String vietnameseExample,
    required String nomExample,
    required String chineseExample,
  }) async {
    if (session.authenticated == null) {
      throw Exception('需要登录后才能修改词库');
    }

    final entry = await DictionaryEntry.db.findById(
      session,
      entryId,
    );

    if (entry == null) {
      throw Exception('词条不存在');
    }

    final cleanHeadword = headword.trim();

    if (cleanHeadword.isEmpty) {
      throw Exception('国语字不能为空');
    }

    entry.text = cleanHeadword;
    entry.normalizedText = cleanHeadword.toLowerCase();
    entry.partOfSpeech = partOfSpeech.trim().isEmpty
        ? null
        : partOfSpeech.trim();
    entry.updatedAt = DateTime.now();

    await DictionaryEntry.db.updateRow(
      session,
      entry,
    );

    final existingNom = await DictionaryForm.db.findFirstRow(
      session,
      where: (f) => f.entryId.equals(entryId) & f.scriptCode.equals('nom'),
    );

    if (existingNom != null) {
      existingNom.text = nomText.trim();
      existingNom.normalizedText = nomText.trim().toLowerCase();

      await DictionaryForm.db.updateRow(
        session,
        existingNom,
      );
    } else if (nomText.trim().isNotEmpty) {
      await DictionaryForm.db.insertRow(
        session,
        DictionaryForm(
          entryId: entryId,
          scriptCode: 'nom',
          text: nomText.trim(),
          normalizedText: nomText.trim().toLowerCase(),
          isPrimary: false,
        ),
      );
    }

    final existingDefinition = await DictionaryDefinition.db.findFirstRow(
      session,
      where: (d) =>
          d.entryId.equals(entryId) & d.explanationLanguageCode.equals('zh'),
    );

    if (existingDefinition != null) {
      existingDefinition.gloss = chineseGloss.trim();
      existingDefinition.updatedAt = DateTime.now();

      await DictionaryDefinition.db.updateRow(
        session,
        existingDefinition,
      );
    } else if (chineseGloss.trim().isNotEmpty) {
      await DictionaryDefinition.db.insertRow(
        session,
        DictionaryDefinition(
          entryId: entryId,
          explanationLanguageCode: 'zh',
          gloss: chineseGloss.trim(),
        ),
      );
    }

    var example = await DictionaryExample.db.findFirstRow(
      session,
      where: (e) => e.entryId.equals(entryId),
      orderBy: (e) => e.position,
    );

    final hasAnyExample =
        vietnameseExample.trim().isNotEmpty ||
        nomExample.trim().isNotEmpty ||
        chineseExample.trim().isNotEmpty;

    if (example == null && hasAnyExample) {
      example = await DictionaryExample.db.insertRow(
        session,
        DictionaryExample(
          entryId: entryId,
          position: 0,
        ),
      );
    }

    if (example == null || example.id == null) {
      return;
    }

    Future<void> upsertExampleText({
      required String languageCode,
      required String scriptCode,
      required String text,
    }) async {
      final existing = await DictionaryExampleText.db.findFirstRow(
        session,
        where: (t) =>
            t.exampleId.equals(example!.id!) &
            t.languageCode.equals(languageCode) &
            t.scriptCode.equals(scriptCode),
      );

      if (existing != null) {
        existing.text = text.trim();
        existing.updatedAt = DateTime.now();

        await DictionaryExampleText.db.updateRow(
          session,
          existing,
        );

        return;
      }

      if (text.trim().isEmpty) {
        return;
      }

      await DictionaryExampleText.db.insertRow(
        session,
        DictionaryExampleText(
          exampleId: example!.id!,
          languageCode: languageCode,
          scriptCode: scriptCode,
          text: text.trim(),
        ),
      );
    }

    await upsertExampleText(
      languageCode: 'vi',
      scriptCode: 'latn',
      text: vietnameseExample,
    );

    await upsertExampleText(
      languageCode: 'vi',
      scriptCode: 'nom',
      text: nomExample,
    );

    await upsertExampleText(
      languageCode: 'zh',
      scriptCode: 'hans',
      text: chineseExample,
    );
  }
}
