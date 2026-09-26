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
  final int videoPositionMs;

  const InteractiveSubtitleOverlay({
    super.key,
    required this.detail,
    required this.languageCode,
    required this.videoPositionMs,
    this.scriptCode,
    this.explanationLanguageCode = 'zh',
  });

  String _displayText() {
    // Published backend already projects the selected script representation
    // into cue.text. Do not re-select from detail.texts here, because legacy
    // data may contain both "latn" and "Latn" rows and the older row can win.
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
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
                if (definition.definition != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    definition.definition!,
                    style: TextStyle(fontSize: 16, height: 1.5),
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
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(meaning, style: TextStyle(fontSize: 16)),
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
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
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
                      style: TextStyle(color: Colors.red),
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

  List<serverpod.SubtitleKaraokeSegment> _sortedKaraokeSegments() {
    final requestedScript = scriptCode?.trim().toLowerCase();

    final segments =
        (detail.karaokeSegments ?? const <serverpod.SubtitleKaraokeSegment>[])
            .where((segment) {
              if (requestedScript == null || requestedScript.isEmpty) {
                return true;
              }

              final segmentScript = segment.scriptCode?.trim().toLowerCase();

              return segmentScript == null ||
                  segmentScript.isEmpty ||
                  segmentScript == requestedScript;
            })
            .toList()
          ..sort((a, b) => a.position.compareTo(b.position));

    return segments;
  }

  String _normalizeKaraokeUnit(String value) {
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  double _karaokeProgressForTokenRange(
    List<serverpod.SubtitleToken> tokens,
    int startPosition,
    int endPosition,
  ) {
    final segments = _sortedKaraokeSegments();

    if (segments.isEmpty || tokens.isEmpty) {
      return 0;
    }

    final sortedTokens = [...tokens]
      ..sort((a, b) => a.position.compareTo(b.position));

    var tokenCursor = 0;
    int? requestedStart;
    int? requestedEnd;

    for (final token in sortedTokens) {
      final length = _normalizeKaraokeUnit(token.text).runes.length;
      final tokenStart = tokenCursor;
      final tokenEnd = tokenCursor + length;

      if (token.position >= startPosition &&
          token.position <= endPosition) {
        requestedStart ??= tokenStart;
        requestedEnd = tokenEnd;
      }

      tokenCursor = tokenEnd;
    }

    if (requestedStart == null || requestedEnd == null) {
      return 0;
    }

    var segmentCursor = 0;
    final matches = <serverpod.SubtitleKaraokeSegment>[];

    for (final segment in segments) {
      final length = _normalizeKaraokeUnit(segment.text).runes.length;
      final segmentStart = segmentCursor;
      final segmentEnd = segmentCursor + length;

      final overlaps =
          segmentEnd > requestedStart && segmentStart < requestedEnd;

      if (overlaps) {
        matches.add(segment);
      }

      segmentCursor = segmentEnd;
    }

    if (matches.isEmpty) {
      return 0;
    }

    final relativeMs = videoPositionMs - detail.cue.startMs;
    final startMs = matches.first.startOffsetMs;
    final endMs = matches.last.endOffsetMs;

    if (relativeMs <= startMs) return 0;
    if (relativeMs >= endMs) return 1;

    final durationMs = endMs - startMs;
    if (durationMs <= 0) return 1;

    return ((relativeMs - startMs) / durationMs).clamp(0.0, 1.0).toDouble();
  }

  LinearGradient? _karaokeGradient(BuildContext context, double progress) {
    if (progress <= 0) {
      return null;
    }

    final accent = Theme.of(
      context,
    ).colorScheme.primary.withValues(alpha: 0.34);

    if (progress >= 1) {
      return LinearGradient(colors: [accent, accent]);
    }

    return LinearGradient(
      colors: [accent, accent, Colors.transparent, Colors.transparent],
      stops: [0.0, progress, progress, 1.0],
    );
  }

  Widget _buildPlainKaraoke(
    BuildContext context,
    List<serverpod.SubtitleKaraokeSegment> segments,
  ) {
    final relativeMs = videoPositionMs - detail.cue.startMs;
    final accent = Theme.of(context).colorScheme.primary;

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 0,
      runSpacing: 4,
      children: [
        for (final segment in segments)
          Builder(
            builder: (context) {
              final durationMs = segment.endOffsetMs - segment.startOffsetMs;

              double progress;

              if (relativeMs <= segment.startOffsetMs) {
                progress = 0;
              } else if (relativeMs >= segment.endOffsetMs) {
                progress = 1;
              } else if (durationMs <= 0) {
                progress = 1;
              } else {
                progress = (relativeMs - segment.startOffsetMs) / durationMs;
              }

              final safeProgress = progress.clamp(0.0, 1.0).toDouble();

              return ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) {
                  if (safeProgress <= 0) {
                    return const LinearGradient(
                      colors: [Colors.white, Colors.white],
                    ).createShader(bounds);
                  }

                  if (safeProgress >= 1) {
                    return LinearGradient(
                      colors: [accent, accent],
                    ).createShader(bounds);
                  }

                  return LinearGradient(
                    colors: [accent, accent, Colors.white, Colors.white],
                    stops: [0.0, safeProgress, safeProgress, 1.0],
                  ).createShader(bounds);
                },
                child: Text(
                  segment.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: _subtitleFontSize(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }

  double _subtitleFontSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // A 17sp subtitle is too large inside a phone-sized 16:9 player.
    // Keep the existing desktop/tablet size while tightening mobile.
    return width < 600 ? 12.0 : 17.0;
  }

  String _normalizeSubtitleForComparison(String value) {
    // Karaoke segments are edited independently and do not have to keep
    // the exact spaces from the sentence. Compare visible text, not storage
    // whitespace, so "Xin " + "chao" still matches "Xin chao".
    return value.replaceAll(RegExp(r'\s+'), '');
  }

  bool _karaokeMatchesDisplayText(
    List<serverpod.SubtitleKaraokeSegment> segments,
  ) {
    if (segments.isEmpty) return false;

    final karaokeText = segments.map((segment) => segment.text).join();

    return _normalizeSubtitleForComparison(karaokeText) ==
        _normalizeSubtitleForComparison(_displayText());
  }

  bool _tokensMatchDisplayText(List<serverpod.SubtitleToken> tokens) {
    if (tokens.isEmpty) return false;

    final sorted = [...tokens]
      ..sort((a, b) => a.position.compareTo(b.position));

    final tokenText = sorted.map((token) => token.text).join();

    String normalize(String value) {
      return value.replaceAll(RegExp(r'\s+'), '').trim();
    }

    return normalize(tokenText) == normalize(_displayText());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final karaokeSegments = _sortedKaraokeSegments();
    final tokensMatch =
        detail.tokens.isNotEmpty && _tokensMatchDisplayText(detail.tokens);

    final debugLabel =
        'tokens=${detail.tokens.length} | karaoke=${karaokeSegments.length} | script=${scriptCode ?? '-'}';

    if (!tokensMatch) {
      if (karaokeSegments.isNotEmpty &&
          _karaokeMatchesDisplayText(karaokeSegments)) {
        return _buildPlainKaraoke(context, karaokeSegments);
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            debugLabel,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _displayText(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: _subtitleFontSize(context),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
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
                gradient: _karaokeGradient(
                  context,
                  _karaokeProgressForTokenRange(
                    tokens,
                    phrase.startPosition,
                    phrase.endPosition,
                  ),
                ),
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
                  fontSize: _subtitleFontSize(context),
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
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
            decoration: BoxDecoration(
              gradient: _karaokeGradient(
                context,
                _karaokeProgressForTokenRange(
                  tokens,
                  token.position,
                  token.position,
                ),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              token.text,
              style: TextStyle(
                color: _knowledgeColor(knowledgeState),
                fontSize: _subtitleFontSize(context),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );

      index++;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          debugLabel,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.redAccent,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 6,
          runSpacing: 4,
          children: children,
        ),
      ],
    );
  }
}
