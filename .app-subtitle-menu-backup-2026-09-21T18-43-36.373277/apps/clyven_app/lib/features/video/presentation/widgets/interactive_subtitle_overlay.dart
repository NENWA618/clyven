import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dictionary/presentation/providers/dictionary_provider.dart';
import '../../../known_entry/data/repositories/known_entry_repository.dart';
import '../../../known_entry/presentation/providers/known_entry_provider.dart';

class InteractiveSubtitleOverlay extends ConsumerWidget {
  final serverpod.SubtitleCueDetail detail;

  final String languageCode;
  final String? scriptCode;
  final String explanationLanguageCode;

  const InteractiveSubtitleOverlay({
    super.key,
    required this.detail,
    required this.languageCode,
    this.scriptCode,
    this.explanationLanguageCode = 'zh',
  });

  String _displayText() {
    final texts = detail.texts ?? const <serverpod.SubtitleCueText>[];

    final requestedScript = scriptCode?.trim();

    if (requestedScript != null && requestedScript.isNotEmpty) {
      for (final text in texts) {
        if (text.scriptCode == requestedScript) {
          return text.text;
        }
      }

      // Explicit script selection is strict: no cross-script fallback.
      return '';
    }

    for (final text in texts) {
      if (text.isPrimary) {
        return text.text;
      }
    }

    if (texts.isNotEmpty) {
      return texts.first.text;
    }

    return detail.cue.text;
  }

  Color _knowledgeColor(String state) {
    switch (state) {
      case 'exactKnown':
        return const Color(0xFF7EE787);

      case 'relatedKnown':
        return const Color(0xFFFFD166);

      case 'unknown':
      default:
        return Colors.white;
    }
  }

  List<Widget> _buildDictionaryContent(
    BuildContext context,
    WidgetRef ref,
    serverpod.DictionaryEntryDetail data,
  ) {
    final widgets = <Widget>[];

    if (data.definitions.isEmpty) {
      widgets.add(
        const Text('这个词条暂时没有当前语言的释义', style: TextStyle(fontSize: 16)),
      );
    } else {
      for (final definition in data.definitions) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  definition.gloss,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (definition.definition != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    definition.definition!,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ],
            ),
          ),
        );
      }
    }

    final components = data.relations
        .where((item) => item.relation.relationType == 'component')
        .toList();

    if (components.isNotEmpty) {
      widgets.add(const Divider());
      widgets.add(const SizedBox(height: 8));

      widgets.add(
        const Text(
          '组成',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
      );

      widgets.add(const SizedBox(height: 12));

      for (final component in components) {
        final target = component.targetEntry;

        final meaning = component.targetDefinitions.isEmpty
            ? '暂无释义'
            : component.targetDefinitions.first.gloss;

        final targetEntryId = target.id;

        final knowledgeFuture = targetEntryId == null
            ? ref
                  .read(knownEntryRepositoryProvider)
                  .getKnowledgeState(
                    languageCode: languageCode,
                    normalizedText: target.normalizedText,
                    entryType: target.entryType,
                  )
            : ref
                  .read(knownEntryRepositoryProvider)
                  .getKnowledgeStatesByEntryIds(entryIds: [targetEntryId])
                  .then((states) => states[targetEntryId] ?? 'unknown');

        widgets.add(
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              _showDictionaryEntry(
                context: context,
                ref: ref,
                text: target.text,
                normalizedText: target.normalizedText,
                entryType: target.entryType,
                entryId: target.id,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  Text(
                    target.text,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(meaning, style: const TextStyle(fontSize: 16)),
                  ),
                  FutureBuilder<String>(
                    future: knowledgeFuture,
                    builder: (context, snapshot) {
                      final state = snapshot.data ?? 'unknown';

                      if (state == 'exactKnown') {
                        return const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, size: 18),
                            SizedBox(width: 4),
                            Text('已会'),
                          ],
                        );
                      }

                      if (state == 'relatedKnown') {
                        return const Text('相关词已会');
                      }

                      return const Text(
                        '未标记',
                        style: TextStyle(color: Colors.grey),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, size: 20),
                ],
              ),
            ),
          ),
        );
      }
    }

    return widgets;
  }

  serverpod.SubtitlePhrase? _findPhraseForToken(serverpod.SubtitleToken token) {
    for (final phrase in detail.phrases) {
      if (token.position >= phrase.startPosition &&
          token.position <= phrase.endPosition) {
        return phrase;
      }
    }

    return null;
  }

  void _showDictionaryEntry({
    required BuildContext context,
    required WidgetRef ref,
    required String text,
    required String normalizedText,
    required String entryType,
    int? entryId,
  }) {
    final repository = ref.read(dictionaryRepositoryProvider);

    final lookupFuture = entryId == null
        ? repository.lookup(
            languageCode: languageCode,
            normalizedText: normalizedText,
            entryType: entryType,
            explanationLanguageCode: explanationLanguageCode,
          )
        : repository.getById(
            entryId: entryId,
            explanationLanguageCode: explanationLanguageCode,
          );

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return FutureBuilder<serverpod.DictionaryEntryDetail?>(
          future: lookupFuture,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entryType == 'phrase' ? 'Phrase' : 'Token',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Consumer(
                    builder: (context, sheetRef, child) {
                      final resolvedEntryId =
                          entryId ?? snapshot.data?.entry.id;

                      String state;

                      if (resolvedEntryId != null) {
                        final entryStatesAsync = sheetRef.watch(
                          entryKnowledgeStatesProvider(
                            EntryKnowledgeBatchRequest(
                              entryIds: [resolvedEntryId],
                            ),
                          ),
                        );

                        state =
                            entryStatesAsync.value?[resolvedEntryId] ??
                            'unknown';
                      } else {
                        final query = (
                          languageCode: languageCode,
                          normalizedText: normalizedText,
                          entryType: entryType,
                        );

                        final knowledgeAsync = sheetRef.watch(
                          knowledgeStateProvider(query),
                        );

                        state = knowledgeAsync.value ?? 'unknown';
                      }

                      final isKnown = state == 'exactKnown';

                      String statusText;

                      if (state == 'exactKnown') {
                        statusText = '✓ 已会';
                      } else if (state == 'relatedKnown') {
                        statusText = '相关词已会';
                      } else {
                        statusText = '未标记';
                      }

                      return Row(
                        children: [
                          Text(
                            statusText,
                            style: TextStyle(
                              fontWeight: state == 'unknown'
                                  ? FontWeight.normal
                                  : FontWeight.w700,
                              color: state == 'unknown' ? Colors.grey : null,
                            ),
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: resolvedEntryId == null
                                ? null
                                : () async {
                                    final repository = sheetRef.read(
                                      knownEntryRepositoryProvider,
                                    );

                                    await repository.setKnown(
                                      entryId: resolvedEntryId,
                                      known: !isKnown,
                                    );

                                    sheetRef.invalidate(
                                      entryKnowledgeStatesProvider,
                                    );

                                    sheetRef.invalidate(knowledgeStateProvider);

                                    sheetRef.invalidate(
                                      knowledgeStatesProvider,
                                    );

                                    sheetRef.invalidate(
                                      knownEntriesForListProvider,
                                    );
                                  },
                            icon: Icon(
                              isKnown
                                  ? Icons.remove_circle_outline
                                  : Icons.check_circle_outline,
                            ),
                            label: Text(isKnown ? '取消已会' : '标记已会'),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 18),
                  const SizedBox(height: 18),
                  if (snapshot.connectionState == ConnectionState.waiting)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (snapshot.hasError)
                    Text(
                      '查询失败：${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    )
                  else if (snapshot.data == null)
                    const Text('暂时没有这个词条的释义', style: TextStyle(fontSize: 16))
                  else
                    ..._buildDictionaryContent(context, ref, snapshot.data!),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (detail.tokens.isEmpty) {
      return Text(
        _displayText(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      );
    }

    final tokens = [...detail.tokens]
      ..sort((a, b) => a.position.compareTo(b.position));

    final entryIds = <int>[];
    final fallbackQueries = <KnowledgeStateRequest>[];

    var queryIndex = 0;

    while (queryIndex < tokens.length) {
      final token = tokens[queryIndex];
      final phrase = _findPhraseForToken(token);

      if (phrase != null && phrase.startPosition == token.position) {
        final phraseEntryId = phrase.entryId;

        if (phraseEntryId != null) {
          entryIds.add(phraseEntryId);
        } else {
          fallbackQueries.add(
            KnowledgeStateRequest(
              languageCode: languageCode,
              normalizedText: phrase.normalizedText ?? phrase.text,
              entryType: 'phrase',
            ),
          );
        }

        while (queryIndex < tokens.length &&
            tokens[queryIndex].position <= phrase.endPosition) {
          queryIndex++;
        }

        continue;
      }

      final tokenEntryId = token.entryId;

      if (tokenEntryId != null) {
        entryIds.add(tokenEntryId);
      } else {
        fallbackQueries.add(
          KnowledgeStateRequest(
            languageCode: languageCode,
            normalizedText: token.normalizedText ?? token.text,
            entryType: 'word',
          ),
        );
      }

      queryIndex++;
    }

    final uniqueEntryIds = entryIds.toSet().toList();

    final entryStateAsync = ref.watch(
      entryKnowledgeStatesProvider(
        EntryKnowledgeBatchRequest(entryIds: uniqueEntryIds),
      ),
    );

    final fallbackStateAsync = ref.watch(
      knowledgeStatesProvider(KnowledgeBatchRequest(queries: fallbackQueries)),
    );

    final entryStates = entryStateAsync.value ?? <int, String>{};
    final fallbackStates = fallbackStateAsync.value ?? <String, String>{};
    final children = <Widget>[];

    var index = 0;

    while (index < tokens.length) {
      final token = tokens[index];
      final phrase = _findPhraseForToken(token);

      if (phrase != null && phrase.startPosition == token.position) {
        final normalizedText = phrase.normalizedText ?? phrase.text;

        final phraseEntryId = phrase.entryId;

        final knowledgeState = phraseEntryId == null
            ? fallbackStates[knowledgeStateKey(
                    languageCode: languageCode,
                    normalizedText: normalizedText,
                    entryType: 'phrase',
                  )] ??
                  'unknown'
            : entryStates[phraseEntryId] ?? 'unknown';

        children.add(
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _showDictionaryEntry(
                context: context,
                ref: ref,
                text: phrase.text,
                normalizedText: normalizedText,
                entryType: 'phrase',
                entryId: phrase.entryId,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                phrase.text,
                style: TextStyle(
                  color: _knowledgeColor(knowledgeState),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );

        while (index < tokens.length &&
            tokens[index].position <= phrase.endPosition) {
          index++;
        }

        continue;
      }

      final normalizedText = token.normalizedText ?? token.text;

      final tokenEntryId = token.entryId;

      final knowledgeState = tokenEntryId == null
          ? fallbackStates[knowledgeStateKey(
                  languageCode: languageCode,
                  normalizedText: normalizedText,
                  entryType: 'word',
                )] ??
                'unknown'
          : entryStates[tokenEntryId] ?? 'unknown';

      children.add(
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _showDictionaryEntry(
              context: context,
              ref: ref,
              text: token.text,
              normalizedText: normalizedText,
              entryType: 'word',
              entryId: token.entryId,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            child: Text(
              token.text,
              style: TextStyle(
                color: _knowledgeColor(knowledgeState),
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );

      index++;
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 4,
      children: children,
    );
  }
}
