import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class DictionaryImportWriter {
  static Future<DictionaryImportCommitResult> commit(
    Session session, {
    required DictionaryImportPreview preview,
  }) async {
    var insertedEntries = 0;
    var mergedEntries = 0;
    var skippedRows = 0;
    var failedRows = 0;

    final messages = <String>[];
    const importedWordListDescription = 'Clyven Studio dictionary import';

    final importedWordLists = <String, WordList>{};

    final nextWordListPositions = <int, int>{};

    String importedWordListName(
      String languageCode,
    ) {
      if (languageCode == 'vi') {
        return '\u8d8a\u5357\u8bed\u8bcd\u8868';
      }

      return '${languageCode.toUpperCase()} word list';
    }

    Future<WordList> ensureImportedWordList(
      String languageCode,
    ) async {
      final cached = importedWordLists[languageCode];

      if (cached != null) {
        return cached;
      }

      var wordList = await WordList.db.findFirstRow(
        session,
        where: (w) =>
            w.languageCode.equals(
              languageCode,
            ) &
            w.description.equals(
              importedWordListDescription,
            ),
      );

      wordList ??= await WordList.db.insertRow(
        session,
        WordList(
          name: importedWordListName(
            languageCode,
          ),
          languageCode: languageCode,
          description: importedWordListDescription,
        ),
      );

      final listId = wordList.id!;

      final existingItems = await WordListItem.db.find(
        session,
        where: (item) => item.listId.equals(listId),
        orderBy: (item) => item.position,
      );

      nextWordListPositions[listId] = existingItems.isEmpty
          ? 0
          : existingItems.last.position + 1;

      importedWordLists[languageCode] = wordList;

      return wordList;
    }

    Future<void> syncEntryToImportedWordList({
      required String languageCode,
      required int entryId,
    }) async {
      final wordList = await ensureImportedWordList(
        languageCode,
      );

      final listId = wordList.id!;

      final existingItem = await WordListItem.db.findFirstRow(
        session,
        where: (item) =>
            item.listId.equals(listId) & item.entryId.equals(entryId),
      );

      if (existingItem != null) {
        return;
      }

      final position = nextWordListPositions[listId] ?? 0;

      await WordListItem.db.insertRow(
        session,
        WordListItem(
          listId: listId,
          entryId: entryId,
          position: position,
        ),
      );

      nextWordListPositions[listId] = position + 1;
    }

    String? clean(dynamic value) {
      if (value == null) {
        return null;
      }

      final text = value.toString().trim();

      if (text.isEmpty) {
        return null;
      }

      return text;
    }

    for (final row in preview.rows) {
      // Excel 尚未补完的 warning 暂时不写数据库。
      if (row.status == 'warning') {
        skippedRows++;
        continue;
      }

      if (row.status != 'ok') {
        failedRows++;
        messages.add(
          'Row ${row.rowNumber}: ${row.message ?? '无法导入'}',
        );
        continue;
      }

      try {
        final decoded = jsonDecode(
          row.normalizedJson,
        );

        if (decoded is! Map) {
          throw const FormatException(
            'normalizedJson 不是 JSON object',
          );
        }

        final normalized = Map<String, dynamic>.from(
          decoded,
        );

        final rawEntry = normalized['entry'];

        if (rawEntry is! Map) {
          throw const FormatException(
            '缺少 entry',
          );
        }

        final entryData = Map<String, dynamic>.from(
          rawEntry,
        );

        final languageCode = clean(entryData['languageCode']);

        final headword = clean(entryData['text']);

        final entryType = clean(entryData['entryType']) ?? 'word';

        final primaryScriptCode = clean(
          entryData['primaryScriptCode'],
        );

        final partOfSpeech = clean(
          entryData['partOfSpeech'],
        );

        if (languageCode == null || headword == null) {
          skippedRows++;

          messages.add(
            'Row ${row.rowNumber}: '
            '词条尚未完成，已跳过',
          );

          continue;
        }

        final normalizedText = headword.toLowerCase();

        var entry = await DictionaryEntry.db.findFirstRow(
          session,
          where: (e) =>
              e.languageCode.equals(
                languageCode,
              ) &
              e.normalizedText.equals(
                normalizedText,
              ) &
              e.entryType.equals(
                entryType,
              ),
        );

        if (entry == null) {
          entry = await DictionaryEntry.db.insertRow(
            session,
            DictionaryEntry(
              languageCode: languageCode,
              text: headword,
              normalizedText: normalizedText,
              entryType: entryType,
              primaryScriptCode: primaryScriptCode,
              partOfSpeech: partOfSpeech,
            ),
          );

          insertedEntries++;
        } else {
          // Excel 是当前导入 Profile 的权威来源。
          entry.text = headword;

          if (primaryScriptCode != null) {
            entry.primaryScriptCode = primaryScriptCode;
          }

          if (partOfSpeech != null) {
            entry.partOfSpeech = partOfSpeech;
          }

          entry = await DictionaryEntry.db.updateRow(
            session,
            entry,
          );

          mergedEntries++;
        }

        final entryId = entry.id!;
        await syncEntryToImportedWordList(
          languageCode: languageCode,
          entryId: entryId,
        );

        // -------------------------
        // Forms
        // -------------------------

        final rawForms = normalized['forms'];

        if (rawForms is List) {
          for (final rawForm in rawForms) {
            if (rawForm is! Map) {
              continue;
            }

            final form = Map<String, dynamic>.from(
              rawForm,
            );

            final text = clean(form['text']);

            final scriptCode = clean(form['scriptCode']);

            if (text == null || scriptCode == null) {
              continue;
            }

            final existingForm = await DictionaryForm.db.findFirstRow(
              session,
              where: (f) =>
                  f.entryId.equals(
                    entryId,
                  ) &
                  f.scriptCode.equals(
                    scriptCode,
                  ) &
                  f.text.equals(
                    text,
                  ),
            );

            if (existingForm == null) {
              await DictionaryForm.db.insertRow(
                session,
                DictionaryForm(
                  entryId: entryId,
                  scriptCode: scriptCode,
                  text: text,
                  normalizedText: text.toLowerCase(),
                  isPrimary: false,
                ),
              );
            }
          }
        }

        // -------------------------
        // Definitions
        // -------------------------

        final rawDefinitions = normalized['definitions'];

        if (rawDefinitions is List) {
          for (final rawDefinition in rawDefinitions) {
            if (rawDefinition is! Map) {
              continue;
            }

            final definition = Map<String, dynamic>.from(
              rawDefinition,
            );

            final explanationLanguageCode = clean(
              definition['languageCode'],
            );

            final gloss = clean(
              definition['value'],
            );

            if (explanationLanguageCode == null || gloss == null) {
              continue;
            }

            final existingDefinition = await DictionaryDefinition.db
                .findFirstRow(
                  session,
                  where: (d) =>
                      d.entryId.equals(
                        entryId,
                      ) &
                      d.explanationLanguageCode.equals(
                        explanationLanguageCode,
                      ),
                );

            if (existingDefinition == null) {
              await DictionaryDefinition.db.insertRow(
                session,
                DictionaryDefinition(
                  entryId: entryId,
                  explanationLanguageCode: explanationLanguageCode,
                  gloss: gloss,
                ),
              );
            } else {
              existingDefinition.gloss = gloss;

              await DictionaryDefinition.db.updateRow(
                session,
                existingDefinition,
              );
            }
          }
        }

        // -------------------------
        // Examples
        // -------------------------

        final rawExamples = normalized['examples'];

        if (rawExamples is List) {
          for (
            var exampleIndex = 0;
            exampleIndex < rawExamples.length;
            exampleIndex++
          ) {
            final rawExample = rawExamples[exampleIndex];

            if (rawExample is! Map) {
              continue;
            }

            final exampleData = Map<String, dynamic>.from(
              rawExample,
            );

            var example = await DictionaryExample.db.findFirstRow(
              session,
              where: (e) =>
                  e.entryId.equals(
                    entryId,
                  ) &
                  e.position.equals(
                    exampleIndex,
                  ),
            );

            example ??= await DictionaryExample.db.insertRow(
              session,
              DictionaryExample(
                entryId: entryId,
                position: exampleIndex,
              ),
            );

            final exampleId = example.id!;

            final rawTexts = exampleData['texts'];

            if (rawTexts is! List) {
              continue;
            }

            for (final rawText in rawTexts) {
              if (rawText is! Map) {
                continue;
              }

              final textData = Map<String, dynamic>.from(
                rawText,
              );

              final languageCode = clean(
                textData['languageCode'],
              );

              final scriptCode = clean(
                textData['scriptCode'],
              );

              final text = clean(
                textData['text'],
              );

              if (languageCode == null || scriptCode == null || text == null) {
                continue;
              }

              final existingText = await DictionaryExampleText.db.findFirstRow(
                session,
                where: (t) =>
                    t.exampleId.equals(
                      exampleId,
                    ) &
                    t.languageCode.equals(
                      languageCode,
                    ) &
                    t.scriptCode.equals(
                      scriptCode,
                    ),
              );

              if (existingText == null) {
                await DictionaryExampleText.db.insertRow(
                  session,
                  DictionaryExampleText(
                    exampleId: exampleId,
                    languageCode: languageCode,
                    scriptCode: scriptCode,
                    text: text,
                  ),
                );
              } else {
                existingText.text = text;

                await DictionaryExampleText.db.updateRow(
                  session,
                  existingText,
                );
              }
            }
          }
        }
      } catch (error) {
        failedRows++;

        messages.add(
          'Row ${row.rowNumber}: $error',
        );
      }
    }

    return DictionaryImportCommitResult(
      totalRows: preview.totalRows,
      insertedEntries: insertedEntries,
      mergedEntries: mergedEntries,
      skippedRows: skippedRows,
      failedRows: failedRows,
      messages: messages,
    );
  }
}
