import 'package:clyven_backend_client/clyven_backend_client.dart' as api;
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../services/web_client.dart';

class LanguageCategoryHomeSection extends StatefulComponent {
  const LanguageCategoryHomeSection({super.key});

  @override
  State<LanguageCategoryHomeSection> createState() =>
      _LanguageCategoryHomeSectionState();
}

class _HomeVideoCard {
  const _HomeVideoCard({required this.video, required this.coverUrl});

  final api.Video video;
  final String? coverUrl;
}

class _LanguageCategoryHomeSectionState
    extends State<LanguageCategoryHomeSection> {
  static const _languageNames = <String, String>{
    'vi': 'Tiếng Việt',
    'zh': '中文',
    'ms': 'Bahasa Melayu',
    'id': 'Bahasa Indonesia',
    'en': 'English',
    'ru': 'Русский',
    'th': 'ไทย',
    'lo': 'ລາວ',
    'tr': 'Türkçe',
    'az': 'Azərbaycanca',
    'kk': 'Қазақша',
    'ky': 'Кыргызча',
    'uz': 'Oʻzbekcha',
    'ug': 'ئۇيغۇرچە',
    'mn': 'Монгол',
    'ja': '日本語',
    'ko': '한국어',
    'fr': 'Français',
    'de': 'Deutsch',
    'es': 'Español',
    'pt': 'Português',
    'ar': 'العربية',
    'fa': 'فارسی',
    'hi': 'हिन्दी',
    'my': 'မြန်မာဘာသာ',
  };

  bool _loading = true;
  String? _error;
  String? _selectedLanguage;
  String? _selectedCategory;

  List<_HomeVideoCard> _videos = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  String? _normalLanguage(String? code) {
    final normalized = code?.trim().toLowerCase();

    if (normalized == null || normalized.isEmpty) {
      return null;
    }

    final separator = normalized.indexOf(RegExp('[-_]'));

    if (separator > 0) {
      return normalized.substring(0, separator);
    }

    return normalized;
  }

  String _languageName(String code) {
    return _languageNames[code] ?? code.toUpperCase();
  }

  Future<void> _load() async {
    try {
      final rawVideos = await webClient.video.getVideos();

      final usable = rawVideos
          .where((video) => video.id != null)
          .take(36)
          .toList();

      final cards = <_HomeVideoCard>[];

      for (final video in usable) {
        String? coverUrl;
        final coverKey = video.coverStorageKey?.trim();

        if (coverKey != null && coverKey.isNotEmpty) {
          try {
            coverUrl = await webClient.video.getVideoUrl(path: coverKey);
          } catch (_) {
            coverUrl = null;
          }
        }

        cards.add(_HomeVideoCard(video: video, coverUrl: coverUrl));
      }

      if (!mounted) return;

      setState(() {
        _videos = cards;
        _loading = false;
        _error = null;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _loading = false;
        _error = error.toString();
      });
    }
  }

  Map<String, int> get _languageCounts {
    final counts = <String, int>{};

    for (final item in _videos) {
      final code = _normalLanguage(item.video.languageCode);

      if (code == null) continue;

      counts.update(code, (count) => count + 1, ifAbsent: () => 1);
    }

    return counts;
  }

  List<String> get _languages {
    final counts = _languageCounts;

    final languages = counts.keys.toList()
      ..sort((a, b) {
        final countCompare = (counts[b] ?? 0).compareTo(counts[a] ?? 0);

        if (countCompare != 0) {
          return countCompare;
        }

        return _languageName(a).compareTo(_languageName(b));
      });

    return languages;
  }

  List<String> get _categories {
    final values = <String>{};

    for (final item in _videos) {
      final language = _normalLanguage(item.video.languageCode);

      if (_selectedLanguage != null && language != _selectedLanguage) {
        continue;
      }

      final category = item.video.category.trim();

      if (category.isNotEmpty) {
        values.add(category);
      }
    }

    final result = values.toList()..sort((a, b) => a.compareTo(b));

    return result;
  }

  List<_HomeVideoCard> get _filteredVideos {
    return _videos.where((item) {
      final video = item.video;
      final language = _normalLanguage(video.languageCode);

      if (_selectedLanguage != null && language != _selectedLanguage) {
        return false;
      }

      if (_selectedCategory != null &&
          video.category.trim() != _selectedCategory) {
        return false;
      }

      return true;
    }).toList();
  }

  void _selectLanguage(String? language) {
    setState(() {
      _selectedLanguage = language;
      _selectedCategory = null;
    });
  }

  void _selectCategory(String? category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  Component _filterButton({
    required String label,
    required bool selected,
    required void Function() onClick,
    String? count,
  }) {
    return button(
      type: ButtonType.button,
      classes:
          'home-filter-chip'
          '${selected ? ' is-active' : ''}',
      onClick: onClick,
      [
        span(classes: 'home-filter-chip-label', [.text(label)]),
        if (count != null)
          span(classes: 'home-filter-chip-count', [.text(count)]),
      ],
    );
  }

  Component _videoCard(_HomeVideoCard item) {
    final video = item.video;
    final coverUrl = item.coverUrl;
    final language = _normalLanguage(video.languageCode);

    return a(href: '/watch/${video.id}', classes: 'home-language-video-card', [
      div(
        classes:
            'home-language-video-thumb'
            '${coverUrl == null ? ' no-cover' : ''}',
        attributes: {
          if (coverUrl != null)
            'style':
                "background-image:url('${coverUrl.replaceAll("'", "%27")}');",
        },
        [
          if (coverUrl == null)
            span(classes: 'home-language-video-placeholder', [.text('CLYVEN')]),
          if (language != null)
            span(classes: 'home-language-video-language', [
              .text(_languageName(language)),
            ]),
        ],
      ),
      div(classes: 'home-language-video-info', [
        h3(classes: 'home-language-video-title', [.text(video.title)]),
        div(classes: 'home-language-video-author', [.text(video.authorName)]),
        div(classes: 'home-language-video-meta', [
          if (video.category.trim().isNotEmpty)
            span([.text(video.category.trim())]),
          span([.text('${video.viewCount} views')]),
        ]),
      ]),
    ]);
  }

  @override
  Component build(BuildContext context) {
    if (_loading) {
      return section(classes: 'home-language-browser', [
        div(classes: 'home-language-browser-heading', [
          div([
            h2([.text('按语言浏览')]),
            p([.text('语言是 Clyven 主页的第一层分类')]),
          ]),
        ]),
        div(classes: 'home-language-loading', [.text('正在加载语言分类…')]),
      ]);
    }

    if (_error != null) {
      return section(classes: 'home-language-browser', [
        div(classes: 'home-language-browser-heading', [
          div([
            h2([.text('按语言浏览')]),
            p([.text('语言是 Clyven 主页的第一层分类')]),
          ]),
        ]),
      ]);
    }

    final languages = _languages;
    final languageCounts = _languageCounts;
    final categories = _categories;
    final videos = _filteredVideos;

    return section(classes: 'home-language-browser', [
      div(classes: 'home-language-browser-heading', [
        div([
          h2([.text('按语言浏览')]),
          p([
            .text(
              _selectedLanguage == null
                  ? '先选语言，再按内容类型继续筛选'
                  : '${_languageName(_selectedLanguage!)} · 再选择内容分类',
            ),
          ]),
        ]),
      ]),

      div(classes: 'home-language-primary-row', [
        _filterButton(
          label: '全部语言',
          selected: _selectedLanguage == null,
          count: _videos.length.toString(),
          onClick: () => _selectLanguage(null),
        ),
        for (final language in languages)
          _filterButton(
            label: _languageName(language),
            selected: _selectedLanguage == language,
            count: (languageCounts[language] ?? 0).toString(),
            onClick: () => _selectLanguage(language),
          ),
      ]),

      if (categories.isNotEmpty)
        div(classes: 'home-language-secondary-row', [
          span(classes: 'home-language-secondary-label', [.text('内容')]),
          _filterButton(
            label: '全部',
            selected: _selectedCategory == null,
            onClick: () => _selectCategory(null),
          ),
          for (final category in categories)
            _filterButton(
              label: category,
              selected: _selectedCategory == category,
              onClick: () => _selectCategory(category),
            ),
        ]),

      if (videos.isEmpty)
        div(classes: 'home-language-empty', [.text('这个分类暂时还没有视频')])
      else
        div(classes: 'home-language-video-grid', [
          for (final item in videos) _videoCard(item),
        ]),
    ]);
  }
}
