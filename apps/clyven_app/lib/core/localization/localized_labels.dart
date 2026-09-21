import 'package:clyven_app/l10n/app_localizations.dart';

String localizedTopicLabel(AppLocalizations l10n, String topic) {
  return switch (topic) {
    '全部' => l10n.topicAll,
    '影像' => l10n.topicImage,
    '技术' => l10n.topicTechnology,
    '语言' => l10n.topicLanguage,
    '游戏' => l10n.topicGaming,
    '音乐' => l10n.topicMusic,
    '城市' => l10n.topicCity,
    '纪录' => l10n.topicDocumentary,
    _ => topic,
  };
}
