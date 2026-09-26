import 'package:clyven_backend_client/clyven_backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/web_client.dart';

class WordListsHomeSection extends StatefulComponent {
  const WordListsHomeSection({super.key});

  @override
  State<WordListsHomeSection> createState() => _WordListsHomeSectionState();
}

class _WordListsHomeSectionState extends State<WordListsHomeSection> {
  bool _loading = true;
  List<api.WordList> _lists = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final lists = await webClient.wordList.getLists();

      if (!mounted) return;

      setState(() {
        _lists = lists.where((list) => list.id != null).toList();
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      // The home page stays usable without word lists.
      setState(() => _loading = false);
    }
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    if (!_loading && _lists.isEmpty) {
      return const Component.text('');
    }

    return section(classes: 'home-wordlists', [
      div(classes: 'home-wordlists-heading', [
        h2([.text(l10n.wordLists)]),
        p([.text(l10n.wordListsSubtitle)]),
      ]),
      if (_loading)
        div(classes: 'home-wordlists-loading', [.text(l10n.wordListsLoading)])
      else
        div(classes: 'home-wordlists-grid', [
          for (final list in _lists)
            Link(
              to: '/wordlists/${list.id}',
              child: article(classes: 'home-wordlist-card', [
                div(classes: 'home-wordlist-icon', [.text('Aa')]),
                div(classes: 'home-wordlist-copy', [
                  h3([.text(list.name)]),
                  p([.text(_descriptionOf(list))]),
                ]),
                span(classes: 'home-wordlist-language', [
                  .text(list.languageCode.toUpperCase()),
                ]),
              ]),
            ),
        ]),
    ]);
  }

  String _descriptionOf(api.WordList list) {
    final description = list.description?.trim();
    return description == null || description.isEmpty
        ? list.languageCode.toUpperCase()
        : description;
  }
}
