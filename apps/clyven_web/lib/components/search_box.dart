import 'dart:async';

import 'package:clyven_backend_client/clyven_backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

import '../l10n/web_l10n.dart';
import '../services/web_client.dart';

/// Header search. Like the app, it filters the public video feed by title,
/// creator, category and description on the client.
class SearchBox extends StatefulComponent {
  const SearchBox({super.key});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  static const _maxResults = 8;

  List<api.Video>? _videos;
  bool _loading = false;
  bool _failed = false;
  bool _open = false;
  String _query = '';
  Timer? _blurTimer;

  @override
  void dispose() {
    _blurTimer?.cancel();
    super.dispose();
  }

  Future<void> _ensureLoaded() async {
    if (_videos != null || _loading) return;

    setState(() {
      _loading = true;
      _failed = false;
    });

    try {
      final videos = await webClient.video.getVideos();

      if (!mounted) return;

      setState(() {
        _videos = videos.where((video) => video.id != null).toList();
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _failed = true;
      });
    }
  }

  List<api.Video> _results() {
    final keyword = _query.trim().toLowerCase();
    final videos = _videos;

    if (keyword.isEmpty || videos == null) return const [];

    return videos.where((video) {
      return video.title.toLowerCase().contains(keyword) ||
          video.authorName.toLowerCase().contains(keyword) ||
          video.category.toLowerCase().contains(keyword) ||
          video.description.toLowerCase().contains(keyword);
    }).toList();
  }

  @override
  Component build(BuildContext context) {
    final l10n = context.l10n;

    return div(classes: 'client-search', [
      input<String>(
        type: InputType.search,
        classes: 'client-search-input',
        value: _query,
        attributes: {
          'placeholder': l10n.searchHint,
          'aria-label': l10n.searchHint,
          'autocomplete': 'off',
        },
        events: {
          ...events<String>(
            onInput: (value) {
              setState(() {
                _query = value;
                _open = true;
              });
              _ensureLoaded();
            },
          ),
          'focus': (_) {
            _blurTimer?.cancel();
            setState(() => _open = true);
            _ensureLoaded();
          },
          'blur': (_) {
            // Delay so a click on a result still lands before the panel goes.
            _blurTimer = Timer(const Duration(milliseconds: 180), () {
              if (mounted) setState(() => _open = false);
            });
          },
        },
      ),
      if (_open) _panel(l10n),
    ]);
  }

  Component _panel(WebStrings l10n) {
    final String? message;
    var results = const <api.Video>[];

    if (_failed) {
      message = l10n.searchLoadFailed;
    } else if (_query.trim().isEmpty) {
      message = l10n.searchPrompt;
    } else if (_videos == null) {
      message = l10n.loading;
    } else {
      results = _results();
      message = results.isEmpty ? l10n.searchNoResults : null;
    }

    return div(classes: 'client-search-panel', [
      if (message != null)
        div(classes: 'client-search-message', [.text(message)]),
      for (final video in results.take(_maxResults))
        Link(
          to: '/watch/${video.id}',
          child: div(classes: 'client-search-result', [
            strong([.text(video.title)]),
            span([
              .text(
                [
                  video.authorName,
                  video.category,
                ].where((part) => part.trim().isNotEmpty).join(' · '),
              ),
            ]),
          ]),
        ),
    ]);
  }
}
