import 'package:clyven_backend_client/clyven_backend_client.dart';
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart';

import '../services/studio_client.dart';

class DictionaryPage extends StatefulComponent {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  List<DictionaryEntryDetail> entries = [];

  bool loading = true;
  String? error;

  int visibleCount = 100;
  final Map<int, String> editedHeadwords = {};
  final Map<int, String> editedNomTexts = {};
  final Map<int, String> editedChineseGlosses = {};
  final Map<int, String> editedPartsOfSpeech = {};
  final Map<int, String> editedVietnameseExamples = {};
  final Map<int, String> editedNomExamples = {};
  final Map<int, String> editedChineseExamples = {};

  final Set<int> savingEntryIds = {};
  final Set<int> savedEntryIds = {};
  final Map<int, String> saveErrors = {};

  @override
  void initState() {
    super.initState();

    _loadEntries();
  }

  Future<void> _loadEntries() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      await studioClient.auth.initialize();

      if (!studioClient.auth.isAuthenticated) {
        setState(() {
          loading = false;
          error = '请先登录 Clyven Studio';
        });

        return;
      }

      const pageSize = 100;

      final allEntries = <DictionaryEntryDetail>[];

      var offset = 0;

      while (true) {
        final page = await studioClient.dictionary.listEntries(
          languageCode: 'vi',
          offset: offset,
          limit: pageSize,
        );

        allEntries.addAll(page);

        if (page.length < pageSize) {
          break;
        }

        offset += page.length;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        entries = allEntries;
        loading = false;
        visibleCount = 100;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
        error = e.toString();
      });
    }
  }

  String _form(
    DictionaryEntryDetail detail,
    String scriptCode,
  ) {
    for (final form in detail.forms) {
      if (form.scriptCode == scriptCode) {
        return form.text;
      }
    }

    return '';
  }

  String _definition(
    DictionaryEntryDetail detail,
    String languageCode,
  ) {
    for (final definition in detail.definitions) {
      if (definition.explanationLanguageCode == languageCode) {
        return definition.gloss;
      }
    }

    return '';
  }

  String _example(
    DictionaryEntryDetail detail, {
    required String languageCode,
    required String scriptCode,
  }) {
    for (final example in detail.examples) {
      for (final text in example.texts) {
        if (text.languageCode == languageCode && text.scriptCode == scriptCode) {
          return text.text;
        }
      }
    }

    return '';
  }

  @override
  Component build(BuildContext context) {
    final count = visibleCount < entries.length ? visibleCount : entries.length;

    return div(
      classes: 'dictionary-page',
      [
        div(
          classes: 'page-heading',
          [
            h1([
              .text('Dictionary'),
            ]),
            p([
              .text(
                '搜索与维护词条、释义、字形和例句。',
              ),
            ]),
          ],
        ),

        div(
          classes: 'panel dictionary-table-panel',
          [
            div(
              classes: 'panel-header',
              [
                div(
                  [
                    h2([
                      .text('Vietnamese Dictionary'),
                    ]),
                    p([
                      .text(
                        '生产数据库中的越南语主词表',
                      ),
                    ]),
                  ],
                ),
                div(
                  classes: 'dictionary-table-count',
                  [
                    .text('${entries.length} entries'),
                  ],
                ),
              ],
            ),

            div(
              classes: 'panel-body',
              [
                if (loading)
                  div(
                    classes: 'preview-loading',
                    [
                      .text('正在读取词库...'),
                    ],
                  )
                else if (error != null)
                  div(
                    classes: 'preview-error',
                    [
                      .text(error!),
                    ],
                  )
                else if (entries.isEmpty)
                  p(
                    classes: 'empty-state',
                    [
                      .text('数据库目前没有词条'),
                    ],
                  )
                else ...[
                  div(
                    classes: 'dictionary-table-scroll',
                    [
                      div(
                        classes: 'dictionary-table-row dictionary-table-header',
                        [
                          div([
                            .text('#'),
                          ]),
                          div([
                            .text('国语字'),
                          ]),
                          div([
                            .text('喃字'),
                          ]),
                          div([
                            .text('中文'),
                          ]),
                          div([
                            .text('词性'),
                          ]),
                          div([
                            .text('国语字例句'),
                          ]),
                          div([
                            .text('喃字例句'),
                          ]),
                          div([
                            .text('中文例句'),
                          ]),
                        ],
                      ),

                      for (var index = 0; index < count; index++)
                        _buildRow(
                          index,
                          entries[index],
                        ),
                    ],
                  ),

                  if (visibleCount < entries.length)
                    div(
                      classes: 'dictionary-load-more',
                      [
                        button(
                          classes: 'import-button',
                          onClick: () {
                            setState(() {
                              final next = visibleCount + 100;

                              visibleCount = next > entries.length ? entries.length : next;
                            });
                          },
                          [
                            .text(
                              '加载更多 · '
                              '剩余 ${entries.length - visibleCount} 条',
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _saveEntry(
    DictionaryEntryDetail detail,
  ) async {
    final entryId = detail.entry.id;

    if (entryId == null) {
      return;
    }

    setState(() {
      savingEntryIds.add(entryId);
      savedEntryIds.remove(entryId);
      saveErrors.remove(entryId);
    });

    try {
      await studioClient.dictionary.updateEntryRow(
        entryId: entryId,
        headword: editedHeadwords[entryId] ?? detail.entry.text,
        nomText: editedNomTexts[entryId] ?? _form(detail, 'nom'),
        chineseGloss: editedChineseGlosses[entryId] ?? _definition(detail, 'zh'),
        partOfSpeech: editedPartsOfSpeech[entryId] ?? detail.entry.partOfSpeech ?? '',
        vietnameseExample:
            editedVietnameseExamples[entryId] ??
            _example(
              detail,
              languageCode: 'vi',
              scriptCode: 'latn',
            ),
        nomExample:
            editedNomExamples[entryId] ??
            _example(
              detail,
              languageCode: 'vi',
              scriptCode: 'nom',
            ),
        chineseExample:
            editedChineseExamples[entryId] ??
            _example(
              detail,
              languageCode: 'zh',
              scriptCode: 'hans',
            ),
      );

      if (!mounted) {
        return;
      }

      setState(() {
        savingEntryIds.remove(entryId);
        savedEntryIds.add(entryId);
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        savingEntryIds.remove(entryId);
        saveErrors[entryId] = e.toString();
      });
    }
  }

  Component _buildRow(
    int index,
    DictionaryEntryDetail detail,
  ) {
    final entryId = detail.entry.id;

    if (entryId == null) {
      return div([]);
    }

    final headword = editedHeadwords[entryId] ?? detail.entry.text;

    final nomText =
        editedNomTexts[entryId] ??
        _form(
          detail,
          'nom',
        );

    final chineseGloss =
        editedChineseGlosses[entryId] ??
        _definition(
          detail,
          'zh',
        );

    final partOfSpeech = editedPartsOfSpeech[entryId] ?? detail.entry.partOfSpeech ?? '';

    final vietnameseExample =
        editedVietnameseExamples[entryId] ??
        _example(
          detail,
          languageCode: 'vi',
          scriptCode: 'latn',
        );

    final nomExample =
        editedNomExamples[entryId] ??
        _example(
          detail,
          languageCode: 'vi',
          scriptCode: 'nom',
        );

    final chineseExample =
        editedChineseExamples[entryId] ??
        _example(
          detail,
          languageCode: 'zh',
          scriptCode: 'hans',
        );

    return div(
      classes: 'dictionary-table-row',
      [
        div(
          [
            span([
              .text('${index + 1}'),
            ]),
            button(
              classes: 'dictionary-save-button',
              attributes: savingEntryIds.contains(entryId)
                  ? {
                      'disabled': 'disabled',
                    }
                  : null,
              onClick: () {
                _saveEntry(detail);
              },
              [
                .text(
                  savingEntryIds.contains(entryId)
                      ? '保存中'
                      : savedEntryIds.contains(entryId)
                      ? '✓'
                      : '保存',
                ),
              ],
            ),
            if (saveErrors[entryId] != null)
              span(
                classes: 'dictionary-save-error',
                [
                  .text('!'),
                ],
              ),
          ],
        ),

        div([
          input<String>(
            type: InputType.text,
            attributes: {
              'value': headword,
            },
            events: events<String>(
              onInput: (value) {
                editedHeadwords[entryId] = value;
                savedEntryIds.remove(entryId);
              },
            ),
          ),
        ]),

        div([
          input<String>(
            type: InputType.text,
            attributes: {
              'value': nomText,
            },
            events: events<String>(
              onInput: (value) {
                editedNomTexts[entryId] = value;
                savedEntryIds.remove(entryId);
              },
            ),
          ),
        ]),

        div([
          input<String>(
            type: InputType.text,
            attributes: {
              'value': chineseGloss,
            },
            events: events<String>(
              onInput: (value) {
                editedChineseGlosses[entryId] = value;
                savedEntryIds.remove(entryId);
              },
            ),
          ),
        ]),

        div([
          input<String>(
            type: InputType.text,
            attributes: {
              'value': partOfSpeech,
            },
            events: events<String>(
              onInput: (value) {
                editedPartsOfSpeech[entryId] = value;
                savedEntryIds.remove(entryId);
              },
            ),
          ),
        ]),

        div([
          input<String>(
            type: InputType.text,
            attributes: {
              'value': vietnameseExample,
            },
            events: events<String>(
              onInput: (value) {
                editedVietnameseExamples[entryId] = value;
                savedEntryIds.remove(entryId);
              },
            ),
          ),
        ]),

        div([
          input<String>(
            type: InputType.text,
            attributes: {
              'value': nomExample,
            },
            events: events<String>(
              onInput: (value) {
                editedNomExamples[entryId] = value;
                savedEntryIds.remove(entryId);
              },
            ),
          ),
        ]),

        div([
          input<String>(
            type: InputType.text,
            attributes: {
              'value': chineseExample,
            },
            events: events<String>(
              onInput: (value) {
                editedChineseExamples[entryId] = value;
                savedEntryIds.remove(entryId);
              },
            ),
          ),
        ]),
      ],
    );
  }
}
