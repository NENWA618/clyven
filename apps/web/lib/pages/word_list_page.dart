import 'package:glyphora_backend_client/backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/web_client.dart';

class WordListPage extends StatefulComponent {
  const WordListPage({required this.listId, super.key});

  final int listId;

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  bool _loading = true;
  String? _error;

  /// Detail per explanation language. Both are loaded once so switching the
  /// UI language needs no reload; dictionary data is mostly filled in
  /// Chinese, so an entry falls back to the other language when empty.
  api.WordListDetail? _zh;
  api.WordListDetail? _en;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<api.WordListDetail?> _detail(String code) {
    return webClient.wordList.getListDetail(
      listId: component.listId,
      explanationLanguageCode: code,
    );
  }

  Future<void> _load() async {
    try {
      final results = await Future.wait([_detail('zh'), _detail('en')]);

      if (!mounted) return;

      setState(() {
        _zh = results[0];
        _en = results[1];
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error.toString();
        _loading = false;
      });
    }
  }

  String? _gloss(api.WordListItemDetail item, bool preferZh) {
    final first = preferZh ? _zh : _en;
    final second = preferZh ? _en : _zh;

    for (final detail in [first, second]) {
      if (detail == null) continue;

      for (final candidate in detail.items) {
        if (candidate.entry.id != item.entry.id) continue;
        if (candidate.definitions.isNotEmpty) {
          return candidate.definitions.first.gloss;
        }
      }
    }

    return null;
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;
    final detail = _zh ?? _en;

    return div(classes: 'wordlist-page', [
      Link(
        to: '/',
        child: span(classes: 'watch-back-link', [.text(l10n.backHomeArrow)]),
      ),
      if (_loading)
        div(classes: 'page-message', [.text(l10n.wordListsLoading)])
      else if (_error != null)
        div(classes: 'page-message error', [.text(_error!)])
      else if (detail == null)
        div(classes: 'empty-state', [
          h3([.text(l10n.wordListNotFound)]),
        ])
      else ...[
        section(classes: 'wordlist-header', [
          h1([.text(detail.wordList.name)]),
          if ((detail.wordList.description ?? '').trim().isNotEmpty)
            p([.text(detail.wordList.description!)]),
          span(classes: 'wordlist-count', [
            .text(l10n.wordListEntryCount(detail.items.length)),
          ]),
        ]),
        div(classes: 'wordlist-items', [
          for (final item in detail.items) _row(l10n, item),
        ]),
      ],
    ]);
  }

  Component _row(WebStrings l10n, api.WordListItemDetail item) {
    final gloss = _gloss(item, l10n.isZh);

    return div(classes: 'wordlist-item', [
      div(classes: 'wordlist-item-main', [
        strong([.text(item.entry.text)]),
        p([.text(gloss ?? l10n.wordNoDefinition)]),
      ]),
      span(classes: 'wordlist-item-type', [
        .text(
          item.entry.entryType == 'phrase'
              ? l10n.entryTypePhrase
              : l10n.entryTypeWord,
        ),
      ]),
    ]);
  }
}
