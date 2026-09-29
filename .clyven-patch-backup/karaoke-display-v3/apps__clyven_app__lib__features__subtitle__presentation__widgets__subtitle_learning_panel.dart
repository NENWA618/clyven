import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../dictionary/presentation/providers/dictionary_provider.dart';
import '../../../known_entry/data/repositories/known_entry_repository.dart';
import '../../../known_entry/presentation/providers/known_entry_provider.dart';

class SubtitleLearningPanel extends ConsumerStatefulWidget {
  final serverpod.SubtitleCueDetail? primaryDetail;
  final serverpod.SubtitleCueDetail? secondaryDetail;
  final String primaryLanguageCode;
  final String? primaryScriptCode;
  final String? secondaryLanguageCode;
  final String? secondaryScriptCode;
  final int videoPositionMs;

  const SubtitleLearningPanel({
    super.key,
    required this.primaryDetail,
    required this.secondaryDetail,
    required this.primaryLanguageCode,
    required this.primaryScriptCode,
    required this.secondaryLanguageCode,
    required this.secondaryScriptCode,
    required this.videoPositionMs,
  });

  @override
  ConsumerState<SubtitleLearningPanel> createState() {
    return _SubtitleLearningPanelState();
  }
}

class _SubtitleLearningPanelState extends ConsumerState<SubtitleLearningPanel> {
  final Map<String, Future<serverpod.DictionaryEntryDetail?>> _lookupCache = {};

  String _displayText(serverpod.SubtitleCueDetail? detail, String? scriptCode) {
    if (detail == null) return '';

    final texts = detail.texts ?? const <serverpod.SubtitleCueText>[];
    final requestedScript = scriptCode?.trim();

    if (requestedScript != null && requestedScript.isNotEmpty) {
      for (final text in texts) {
        if (text.scriptCode == requestedScript && text.text.trim().isNotEmpty) {
          return text.text;
        }
      }
    }

    for (final text in texts) {
      if (text.isPrimary && text.text.trim().isNotEmpty) {
        return text.text;
      }
    }

    if (texts.isNotEmpty && texts.first.text.trim().isNotEmpty) {
      return texts.first.text;
    }

    return detail.cue.text;
  }

  serverpod.SubtitlePhrase? _phraseForPosition(int position) {
    final detail = widget.primaryDetail;
    if (detail == null) return null;

    for (final phrase in detail.phrases) {
      if (position >= phrase.startPosition && position <= phrase.endPosition) {
        return phrase;
      }
    }

    return null;
  }

  List<_LearningWord> _words() {
    final detail = widget.primaryDetail;
    if (detail == null) return const <_LearningWord>[];

    final requestedScript = widget.primaryScriptCode?.trim();

    final tokens = detail.tokens.where((token) {
      if (requestedScript == null || requestedScript.isEmpty) {
        return true;
      }

      final tokenScript = token.scriptCode?.trim();

      return tokenScript == null ||
          tokenScript.isEmpty ||
          tokenScript == requestedScript;
    }).toList()..sort((left, right) => left.position.compareTo(right.position));

    if (tokens.isNotEmpty) {
      return [
        for (final token in tokens)
          _LearningWord(
            text: token.text,
            normalizedText: token.normalizedText ?? token.text,
            position: token.position,
            entryId: token.entryId,
            phrase: _phraseForPosition(token.position),
          ),
      ];
    }

    // Legacy subtitle fallback. These positions still match the current
    // word-by-word Karaoke fallback generation.
    final source = _displayText(detail, widget.primaryScriptCode).trim();

    if (source.isEmpty) return const <_LearningWord>[];

    final matches = RegExp(r'\S+').allMatches(source).toList();

    return [
      for (var index = 0; index < matches.length; index++)
        _LearningWord(
          text: matches[index].group(0)!,
          normalizedText: _normalizeFallbackWord(matches[index].group(0)!),
          position: index,
          entryId: null,
          phrase: null,
        ),
    ];
  }

  String _normalizeFallbackWord(String value) {
    var result = value.trim();

    const punctuation = '.,!?;:()[]{}"“”‘’…—-';

    while (result.isNotEmpty && punctuation.contains(result[0])) {
      result = result.substring(1);
    }

    while (result.isNotEmpty &&
        punctuation.contains(result[result.length - 1])) {
      result = result.substring(0, result.length - 1);
    }

    return result.toLowerCase();
  }

  String get _explanationLanguageCode {
    final secondary = widget.secondaryLanguageCode?.trim();

    if (secondary != null &&
        secondary.isNotEmpty &&
        secondary.toLowerCase() != widget.primaryLanguageCode.toLowerCase()) {
      return secondary.toLowerCase();
    }

    // Word gloss is a dictionary-learning feature, not the second subtitle.
    // Current Vietnamese dictionary data is mainly populated in Chinese.
    return 'zh';
  }

  Color _knowledgeColor(BuildContext context, String state) {
    switch (state) {
      case 'exactKnown':
        return const Color(0xFF2E9B55);

      case 'relatedKnown':
        return const Color(0xFFD49A00);

      case 'unknown':
      default:
        return Theme.of(context).colorScheme.onSurface;
    }
  }

  Future<serverpod.DictionaryEntryDetail?> _lookupWord(_LearningWord word) {
    return _lookupEntry(
      normalizedText: word.normalizedText,
      entryType: 'word',
      entryId: word.entryId,
    );
  }

  Future<serverpod.DictionaryEntryDetail?> _lookupEntry({
    required String normalizedText,
    required String entryType,
    int? entryId,
  }) {
    final requestedLanguage = _explanationLanguageCode;
    final uiLanguage = Localizations.localeOf(
      context,
    ).languageCode.toLowerCase();

    final languages = <String>[];

    void addLanguage(String value) {
      final code = value.trim().toLowerCase();
      if (code.isEmpty || languages.contains(code)) return;
      languages.add(code);
    }

    addLanguage(requestedLanguage);
    addLanguage('zh');
    addLanguage(uiLanguage);
    addLanguage('en');

    final key =
        '${widget.primaryLanguageCode}|${languages.join(',')}|'
        '$entryType|${entryId ?? ''}|$normalizedText';

    return _lookupCache.putIfAbsent(key, () async {
      final repository = ref.read(dictionaryRepositoryProvider);

      Future<serverpod.DictionaryEntryDetail?> load(
        String explanationLanguage,
      ) {
        if (entryId != null) {
          return repository.getById(
            entryId: entryId,
            explanationLanguageCode: explanationLanguage,
          );
        }

        if (normalizedText.trim().isEmpty) {
          return Future<serverpod.DictionaryEntryDetail?>.value(null);
        }

        return repository.lookup(
          languageCode: widget.primaryLanguageCode,
          normalizedText: normalizedText,
          entryType: entryType,
          explanationLanguageCode: explanationLanguage,
        );
      }

      serverpod.DictionaryEntryDetail? firstResolvedEntry;

      for (final explanationLanguage in languages) {
        final data = await load(explanationLanguage);

        firstResolvedEntry ??= data;

        if (data != null && data.definitions.isNotEmpty) {
          return data;
        }
      }

      return firstResolvedEntry;
    });
  }

  String _inlineGloss(serverpod.DictionaryEntryDetail? data) {
    if (data == null || data.definitions.isEmpty) {
      return '';
    }

    // Per-word text is ONLY the dictionary gloss.
    // Never use dictionary examples or long definitions here.
    return data.definitions.first.gloss.trim();
  }

  double? _karaokeProgress(_LearningWord word) {
    final detail = widget.primaryDetail;
    if (detail == null) return null;

    final segments =
        detail.karaokeSegments ?? const <serverpod.SubtitleKaraokeSegment>[];

    final requestedScript = widget.primaryScriptCode?.trim().toLowerCase();

    serverpod.SubtitleKaraokeSegment? segment;

    for (final item in segments) {
      if (item.position != word.position) continue;

      final segmentScript = item.scriptCode?.trim().toLowerCase();

      if (requestedScript != null &&
          requestedScript.isNotEmpty &&
          segmentScript != null &&
          segmentScript.isNotEmpty &&
          segmentScript != requestedScript) {
        continue;
      }

      segment = item;
      break;
    }

    if (segment == null) return null;

    final relativeMs = widget.videoPositionMs - detail.cue.startMs;

    if (relativeMs <= segment.startOffsetMs) return 0;
    if (relativeMs >= segment.endOffsetMs) return 1;

    final duration = segment.endOffsetMs - segment.startOffsetMs;

    if (duration <= 0) return 1;

    return ((relativeMs - segment.startOffsetMs) / duration)
        .clamp(0.0, 1.0)
        .toDouble();
  }

  Widget _karaokeWord({
    required BuildContext context,
    required _LearningWord word,
    required String knowledgeState,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final baseColor = _knowledgeColor(context, knowledgeState);
    final progress = _karaokeProgress(word);

    final baseStyle = TextStyle(
      color: baseColor,
      fontSize: 19,
      height: 1.05,
      fontWeight: FontWeight.w900,
    );

    Widget text;

    if (progress == null || progress <= 0) {
      text = Text(word.text, style: baseStyle);
    } else if (progress >= 1) {
      text = Text(word.text, style: baseStyle.copyWith(color: scheme.primary));
    } else {
      final p = progress.clamp(0.0, 1.0).toDouble();

      text = ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [scheme.primary, scheme.primary, baseColor, baseColor],
            stops: [0, p, p, 1],
          ).createShader(bounds);
        },
        child: Text(word.text, style: baseStyle.copyWith(color: Colors.white)),
      );
    }

    if (word.phrase == null) {
      return text;
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: scheme.primary, width: 2)),
      ),
      child: text,
    );
  }

  Future<void> _showWord(BuildContext context, _LearningWord word) {
    return _showDictionaryEntry(
      context: context,
      text: word.text,
      normalizedText: word.normalizedText,
      entryType: 'word',
      entryId: word.entryId,
    );
  }

  Future<void> _showPhrase(
    BuildContext context,
    serverpod.SubtitlePhrase phrase,
  ) {
    return _showDictionaryEntry(
      context: context,
      text: phrase.text,
      normalizedText: phrase.normalizedText ?? phrase.text,
      entryType: 'phrase',
      entryId: phrase.entryId,
    );
  }

  List<Widget> _buildDictionaryContent(
    BuildContext context,
    WidgetRef sheetRef,
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
                if (definition.definition?.trim().isNotEmpty == true) ...[
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
            ? sheetRef
                  .read(knownEntryRepositoryProvider)
                  .getKnowledgeState(
                    languageCode: widget.primaryLanguageCode,
                    normalizedText: target.normalizedText,
                    entryType: target.entryType,
                  )
            : sheetRef
                  .read(knownEntryRepositoryProvider)
                  .getKnowledgeStatesByEntryIds(entryIds: [targetEntryId])
                  .then((states) => states[targetEntryId] ?? 'unknown');

        widgets.add(
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              _showDictionaryEntry(
                context: context,
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

  Future<void> _showDictionaryEntry({
    required BuildContext context,
    required String text,
    required String normalizedText,
    required String entryType,
    int? entryId,
  }) async {
    final lookupFuture = _lookupEntry(
      normalizedText: normalizedText,
      entryType: entryType,
      entryId: entryId,
    );

    await showModalBottomSheet<void>(
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
                        final statesAsync = sheetRef.watch(
                          entryKnowledgeStatesProvider(
                            EntryKnowledgeBatchRequest(
                              entryIds: [resolvedEntryId],
                            ),
                          ),
                        );

                        state =
                            statesAsync.value?[resolvedEntryId] ?? 'unknown';
                      } else {
                        final query = (
                          languageCode: widget.primaryLanguageCode,
                          normalizedText: normalizedText,
                          entryType: entryType,
                        );

                        final knowledgeAsync = sheetRef.watch(
                          knowledgeStateProvider(query),
                        );

                        state = knowledgeAsync.value ?? 'unknown';
                      }

                      final isKnown = state == 'exactKnown';

                      final statusText = state == 'exactKnown'
                          ? '✓ 已会'
                          : state == 'relatedKnown'
                          ? '相关词已会'
                          : '未标记';

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
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    final exampleText = _displayText(
      widget.primaryDetail,
      widget.primaryScriptCode,
    );

    final exampleTranslation = _displayText(
      widget.secondaryDetail,
      widget.secondaryScriptCode,
    );

    final words = _words();

    final entryIds = words
        .map((word) => word.entryId)
        .whereType<int>()
        .toSet()
        .toList();

    final fallbackQueries = [
      for (final word in words)
        if (word.entryId == null && word.normalizedText.trim().isNotEmpty)
          KnowledgeStateRequest(
            languageCode: widget.primaryLanguageCode,
            normalizedText: word.normalizedText,
            entryType: 'word',
          ),
    ];

    final entryStatesAsync = ref.watch(
      entryKnowledgeStatesProvider(
        EntryKnowledgeBatchRequest(entryIds: entryIds),
      ),
    );

    final fallbackStatesAsync = ref.watch(
      knowledgeStatesProvider(KnowledgeBatchRequest(queries: fallbackQueries)),
    );

    final entryStates = entryStatesAsync.value ?? <int, String>{};

    final fallbackStates = fallbackStatesAsync.value ?? <String, String>{};

    String knowledgeStateFor(_LearningWord word) {
      final entryId = word.entryId;

      if (entryId != null) {
        return entryStates[entryId] ?? 'unknown';
      }

      return fallbackStates[knowledgeStateKey(
            languageCode: widget.primaryLanguageCode,
            normalizedText: word.normalizedText,
            entryType: 'word',
          )] ??
          'unknown';
    }

    return Material(
      color: scheme.surface,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxHeight: 340),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: scheme.outlineVariant.withValues(alpha: 0.65),
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 13, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.school_outlined, size: 17, color: scheme.primary),
                  const SizedBox(width: 7),
                  const Text(
                    '学习字幕',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                  ),
                  const Spacer(),
                  Text(
                    '${widget.primaryLanguageCode.toUpperCase()}'
                    '${widget.secondaryLanguageCode == null ? '' : ' + ${widget.secondaryLanguageCode!.toUpperCase()}'}',
                    style: TextStyle(
                      color: scheme.onSurfaceVariant,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              if (words.isEmpty)
                Text(
                  exampleText.isEmpty ? '当前没有字幕' : exampleText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                )
              else
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 9,
                  runSpacing: 13,
                  children: [
                    for (final word in words)
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          _showWord(context, word);
                        },
                        onLongPress: word.phrase == null
                            ? null
                            : () {
                                _showPhrase(context, word.phrase!);
                              },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 3,
                            vertical: 3,
                          ),
                          child:
                              FutureBuilder<serverpod.DictionaryEntryDetail?>(
                                future: _lookupWord(word),
                                builder: (context, snapshot) {
                                  final gloss = _inlineGloss(snapshot.data);

                                  final visibleGloss =
                                      snapshot.connectionState ==
                                          ConnectionState.waiting
                                      ? '…'
                                      : gloss.isEmpty
                                      ? '—'
                                      : gloss;

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ConstrainedBox(
                                        constraints: const BoxConstraints(
                                          maxWidth: 110,
                                        ),
                                        child: SizedBox(
                                          height: 17,
                                          child: Text(
                                            visibleGloss,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: scheme.onSurfaceVariant,
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      _karaokeWord(
                                        context: context,
                                        word: word,
                                        knowledgeState: knowledgeStateFor(word),
                                      ),
                                    ],
                                  );
                                },
                              ),
                        ),
                      ),
                  ],
                ),

              if (exampleText.trim().isNotEmpty) ...[
                const SizedBox(height: 15),
                Text(
                  '例句',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exampleText,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],

              if (exampleTranslation.trim().isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  '例句翻译',
                  style: TextStyle(
                    color: scheme.onSurfaceVariant,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  exampleTranslation,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 16,
                    height: 1.4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],

              if (words.any((word) => word.phrase != null)) ...[
                const SizedBox(height: 11),
                Row(
                  children: [
                    Container(width: 18, height: 2, color: scheme.primary),
                    const SizedBox(width: 7),
                    Text(
                      '下划线表示词组；长按其中任一词可查看词组',
                      style: TextStyle(
                        color: scheme.onSurfaceVariant,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LearningWord {
  final String text;
  final String normalizedText;
  final int position;
  final int? entryId;
  final serverpod.SubtitlePhrase? phrase;

  const _LearningWord({
    required this.text,
    required this.normalizedText,
    required this.position,
    required this.entryId,
    required this.phrase,
  });
}
