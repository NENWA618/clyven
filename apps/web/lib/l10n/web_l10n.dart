import 'dart:html' as html;

import 'package:jaspr/jaspr.dart';

/// Language preference, mirroring the app's system / English / Simplified
/// Chinese options.
enum WebLocalePreference { system, en, zh }

enum WebLang { en, zh }

const _storageKey = 'glyphora.web_locale';

WebLocalePreference _readPreference() {
  try {
    return switch (html.window.localStorage[_storageKey]) {
      'en' => WebLocalePreference.en,
      'zh' => WebLocalePreference.zh,
      _ => WebLocalePreference.system,
    };
  } catch (_) {
    return WebLocalePreference.system;
  }
}

void _writePreference(WebLocalePreference preference) {
  try {
    if (preference == WebLocalePreference.system) {
      html.window.localStorage.remove(_storageKey);
    } else {
      html.window.localStorage[_storageKey] = preference.name;
    }
  } catch (_) {
    // Keep the in-memory selection even if persistence is unavailable.
  }
}

WebLang _resolve(WebLocalePreference preference) {
  switch (preference) {
    case WebLocalePreference.en:
      return WebLang.en;
    case WebLocalePreference.zh:
      return WebLang.zh;
    case WebLocalePreference.system:
      final system = (html.window.navigator.language).toLowerCase();
      return system.startsWith('zh') ? WebLang.zh : WebLang.en;
  }
}

/// Owns the language preference and exposes it to the tree via [WebL10n].
class WebLocaleRoot extends StatefulComponent {
  const WebLocaleRoot({required this.child, super.key});

  final Component child;

  @override
  State<WebLocaleRoot> createState() => _WebLocaleRootState();
}

class _WebLocaleRootState extends State<WebLocaleRoot> {
  WebLocalePreference _preference = _readPreference();

  void _setPreference(WebLocalePreference preference) {
    _writePreference(preference);
    html.document.documentElement?.lang = _resolve(preference) == WebLang.zh
        ? 'zh'
        : 'en';
    setState(() => _preference = preference);
  }

  @override
  void initState() {
    super.initState();
    html.document.documentElement?.lang = _resolve(_preference) == WebLang.zh
        ? 'zh'
        : 'en';
  }

  @override
  Component build(BuildContext context) {
    return WebL10n(
      preference: _preference,
      lang: _resolve(_preference),
      setPreference: _setPreference,
      child: component.child,
    );
  }
}

class WebL10n extends InheritedComponent {
  const WebL10n({
    required this.preference,
    required this.lang,
    required this.setPreference,
    required super.child,
    super.key,
  });

  final WebLocalePreference preference;
  final WebLang lang;
  final void Function(WebLocalePreference preference) setPreference;

  static WebL10n of(BuildContext context) {
    final scope = context.dependOnInheritedComponentOfExactType<WebL10n>();
    assert(scope != null, 'WebL10n is missing from the component tree.');
    return scope!;
  }

  @override
  bool updateShouldNotify(WebL10n oldComponent) =>
      oldComponent.lang != lang || oldComponent.preference != preference;
}

extension WebL10nContext on BuildContext {
  WebStrings get l10n => WebStrings(WebL10n.of(this).lang);
}

/// All user-facing strings of the web client. Every entry carries both
/// languages side by side so a missing translation is a compile-time gap.
class WebStrings {
  const WebStrings(this.lang);

  final WebLang lang;

  bool get isZh => lang == WebLang.zh;

  String _(String en, String zh) => isZh ? zh : en;

  // Shell
  String get brandTagline => _('Watch across languages', '跨语言观看');
  String get navHome => _('Home', '首页');
  String get navExplore => _('Explore', '探索');
  String get navLanguages => _('Languages', '语言');
  String get studio => _('Studio', '创作工坊');
  String get searchHint =>
      _('Search videos, creators or categories', '搜索视频、作者、分类');
  String get searchPrompt =>
      _('Enter a title, creator or category', '输入标题、作者或分类');
  String get searchNoResults => _('No related videos found', '没有找到相关视频');
  String get searchLoadFailed => _('Failed to load', '加载失败');
  String get searchTitle => _('Search', '搜索');
  String get searchAction => _('Search', '搜索');
  String get searchPageHint => _(
    'Search videos, creators, categories and descriptions.',
    '搜索视频、作者、分类和简介。',
  );
  String searchResultsFor(String query) =>
      _('Results for "$query"', '“$query”的搜索结果');
  String searchNoResultsHint(String query) =>
      _('No videos matched "$query".', '没有视频匹配“$query”。');
  String get searchVideosSection => _('Videos', '视频');
  String get searchUsersSection => _('Users', '用户');
  String get subtitleMatches => _('Subtitle matches', '字幕匹配');
  String get originalSubtitle => _('Original subtitle', '原文字幕');
  String get translatedSubtitle => _('Translated subtitle', '翻译字幕');
  String get searchingVideosAndSubtitles =>
      _('Searching videos and subtitles...', '正在搜索视频和字幕...');

  // Language switcher (same labels as the app)
  String get language => _('Language', '语言');
  String get languageSystem => _('System default', '跟随系统');
  String get languageEnglish => 'English';
  String get languageChinese => _('Simplified Chinese', '简体中文');

  // Home
  String get invalidVideoId => _('Invalid video id.', '无效的视频编号。');
  String get heroEyebrow => 'GLYPHORA WEB';
  String get heroTitle =>
      _('One video. More than one way to read it.', '一个视频，不止一种读法。');
  String get heroBody => _(
    'Watch ordinary videos while Glyphora keeps language, '
        'subtitle and script choices close to the content.',
    '像平常一样观看视频，Glyphora 把语言、字幕和文字的选择放在内容旁边。',
  );
  String get badgeVideo => _('Video', '视频');
  String get badgeSubtitles => _('Subtitles', '字幕');
  String get badgeScripts => _('Scripts', '文字');
  String get latestVideos => _('Latest videos', '最新视频');
  String get latestVideosSubtitle =>
      _('Public videos from Glyphora creators.', 'Glyphora 创作者发布的公开视频。');
  String get loading => _('Loading...', '加载中...');
  String get refresh => _('Refresh', '刷新');
  String get noPublicVideos => _('No public videos yet', '还没有公开视频');
  String get noPublicVideosHint =>
      _('Published videos will appear here.', '发布后的视频会显示在这里。');
  String get unknownLanguage => _('unknown', '未知');
  String views(int count) => _('$count views', '$count 次观看');
  String viewsShort(int count) {
    if (count >= 1000000) {
      final value = (count / 1000000).toStringAsFixed(1);
      return _('${value}M views', '$value 百万次观看');
    }
    if (count >= 1000) {
      final value = (count / 1000).toStringAsFixed(1);
      return _('${value}K views', '$value 千次观看');
    }
    return views(count);
  }

  String likes(int count) => _('$count likes', '$count 个赞');
  String viewsAndLanguage(int count, String? languageCode) =>
      '${views(count)} · ${languageCode ?? unknownLanguage}';

  // Language browser
  String get browseByLanguage => _('Browse by language', '按语言浏览');
  String get browseByLanguageSubtitle => _(
    'Language is the first level of Glyphora categories',
    '语言是 Glyphora 主页的第一层分类',
  );
  String get browseLoading => _('Loading language categories…', '正在加载语言分类…');
  String get pickLanguageFirst =>
      _('Pick a language, then filter by content type', '先选语言，再按内容类型继续筛选');
  String pickCategory(String languageName) =>
      _('$languageName · pick a category', '$languageName · 再选择内容分类');
  String get allLanguages => _('All languages', '全部语言');
  String get contentLabel => _('Content', '内容');
  String get all => _('All', '全部');
  String get noVideosInCategory =>
      _('No videos in this category yet', '这个分类暂时还没有视频');

  // Video categories. The backend stores the Chinese names; this mirrors the
  // app's topic labels and passes unknown categories through unchanged.
  String topic(String category) {
    final key = category.trim();

    return switch (key) {
      '全部' => _('All', '全部'),
      '影像' => _('Visual', '影像'),
      '技术' => _('Technology', '技术'),
      '语言' => _('Language', '语言'),
      '游戏' => _('Gaming', '游戏'),
      '音乐' => _('Music', '音乐'),
      '城市' => _('City', '城市'),
      '纪录' => _('Documentary', '纪录'),
      _ => key,
    };
  }

  // Recommended
  String get recommendedVideos => _('Recommended videos', '推荐视频');
  String get recommendedLoading =>
      _('Loading recommended videos…', '正在加载推荐视频…');
  String get recommendedEmpty => _('No other public videos yet', '暂时没有其他公开视频');

  // Auth / avatar
  String get enterEmailAndPassword =>
      _('Please enter your email and password', '请输入邮箱和密码');
  String loginFailed(Object error) =>
      _('Sign-in failed: $error', '登录失败：$error');
  String get avatarTooLarge =>
      _('Avatar image must be under 10 MB', '头像图片不能超过 10 MB');
  String get cannotReadImage =>
      _('Could not read the selected image', '无法读取所选图片');
  String avatarUploadFailed(Object error) =>
      _('Avatar upload failed: $error', '头像上传失败：$error');
  String get signInToGlyphora => _('Sign in to Glyphora', '登录 Glyphora');
  String get signInBenefits => _(
    'Sign in to sync your avatar, favorites, history and subtitle state.',
    '登录后可同步头像、收藏、历史记录和字幕状态。',
  );
  String get email => _('Email', '邮箱');
  String get password => _('Password', '密码');
  String get signIn => _('Sign in', '登录');
  String get signingIn => _('Signing in...', '登录中...');
  String get uploading => _('Uploading...', '上传中...');
  String get changeAvatar => _('Change avatar', '更换头像');
  String get signOut => _('Sign out', '退出登录');
  String get account => _('Account', '账号');
  String get openAccountMenu => _('Open account menu', '打开账号菜单');
  String get settings => _('Settings', '设置');

  // Settings shell
  String get settingsEyebrow => 'SETTINGS';
  String get backToSettings => _('← Settings', '← 设置');
  String get accountSectionTitle => _('Account', '账号');
  String get accountAndProfile => _('Account & profile', '账号与资料');
  String get accountAndProfileSubtitle =>
      _('Display name, avatar and bio', '昵称、头像、个人简介');
  String get privacy => _('Privacy', '隐私');
  String get privacySubtitle =>
      _('Privacy and content visibility', '隐私与内容可见范围');
  String get notificationsTitle => _('Notifications', '通知');
  String get notificationsSettingsSubtitle =>
      _('Manage echoes and push notifications', '管理回响与推送通知');
  String get about => _('About', '关于');
  String get aboutSubtitle => _('Version and app information', '版本与应用信息');
  String get identitySectionTitle => _('Current identity', '当前身份');
  String get logoutCurrentIdentity => _('Log out of this identity', '退出当前身份');
  String get settingsSignedOut =>
      _('Please sign in to view settings.', '请先登录后再查看设置。');

  // Account & profile settings page
  String get displayName => _('Display name', '显示名称');
  String get username => _('Username', '用户名');
  String get bio => _('Bio', '个人简介');
  String get changeAvatarHint =>
      _('Choose a clear, recognizable photo.', '选择清晰、容易辨认的照片。');
  String get saveChanges => _('Save changes', '保存更改');
  String get saving => _('Saving...', '保存中...');
  String get saveFailed => _('Could not save profile', '保存失败，请重试');

  // Privacy settings page
  String get privateAccount => _('Private account', '私密账号');
  String get privateAccountSubtitle => _(
    'Only your followers can see your videos when this is on',
    '开启后，只有关注者能看到你的投稿',
  );
  String get allowComments => _('Allow comments', '允许评论');
  String get allowCommentsSubtitle =>
      _('Let other people comment on your videos', '允许其他人评论你的投稿');
  String get showActivityStatus => _('Show activity status', '显示动态状态');
  String get showActivityStatusSubtitle => _(
    'Let other people see your recent views and interactions',
    '让其他人看到你的最近观看与互动',
  );

  // Notification settings page
  String get pushNotifications => _('Push notifications', '推送通知');
  String get pushNotificationsSubtitle =>
      _('Turn off to stop receiving echo alerts', '关闭后将不再收到回响提醒');
  String get notificationTypesSectionTitle => _('Notification types', '通知类型');
  String get likeNotifications => _('Likes', '点赞');
  String get likeNotificationsSubtitle =>
      _('Notify me when someone likes my videos', '有人喜欢你的投稿时提醒你');
  String get commentNotifications => _('Comments', '评论');
  String get commentNotificationsSubtitle =>
      _('Notify me when someone comments on my videos', '有人评论你的投稿时提醒你');
  String get followNotifications => _('Follows', '关注');
  String get followNotificationsSubtitle =>
      _('Notify me when someone follows me', '有人关注你时提醒你');

  // Echoes / notifications feed
  String get echoesEyebrow => 'ECHOES';
  String get navEchoes => _('Echoes', '回响');
  String get openNotifications => _('Open echoes', '打开回响');
  String get noEchoesYet => _('No echoes yet', '暂无回响');
  String get notificationsLoadFailed => _('Failed to load echoes', '回响加载失败');
  String get markAllRead => _('Mark all read', '全部已读');
  String get justNow => _('Just now', '刚刚');
  String minutesAgo(int count) =>
      _('$count minute${count == 1 ? '' : 's'} ago', '$count 分钟前');
  String hoursAgo(int count) =>
      _('$count hour${count == 1 ? '' : 's'} ago', '$count 小时前');
  String daysAgo(int count) =>
      _('$count day${count == 1 ? '' : 's'} ago', '$count 天前');
  String get notificationCommentTitle => _('New comment', '有人回复了你的投稿');
  String notificationCommentMessage(String actor, String content) =>
      _('$actor replied: "$content"', '$actor 回复：“$content”');
  String get notificationLikeTitle => _('Your video got a like', '你的影像获得了喜欢');
  String notificationLikeMessage(String actor) =>
      _('$actor liked your submission.', '$actor 喜欢了你的投稿。');
  String get notificationFollowTitle => _('New follower', '新的关注');
  String notificationFollowMessage(String actor) =>
      _('$actor started following you.', '$actor 开始关注你。');

  // About page
  String get aboutEyebrow => 'ABOUT';
  String aboutVersion(String version) => _('Version $version', '版本 $version');
  String get aboutAppDescription => _(
    'Glyphora is a multilingual video and subtitle community.',
    'Glyphora 是一个多语言视频与字幕社区。',
  );
  String get aboutCopyright => '© 2026 Glyphora';

  // Player
  String get qualityOriginal => _('Original', '原画');
  String get qualityAuto => _('Auto', '自动');
  String get subtitlesInVideo => _('In video', '视频内');
  String get subtitlesBelowVideo => _('Below video', '视频下');
  String get standardMode => _('Standard', '标准');
  String get wideMode => _('Wide', '宽屏');
  String get videoProgress => _('Video progress', '视频进度');
  String get volume => _('Volume', '音量');

  // Watch page
  String get primarySubtitle => _('Primary', '主字幕');
  String get secondarySubtitle => _('Secondary', '第二字幕');
  String get subtitles => _('Subtitles', '字幕');
  String get chooseLanguage => _('Choose a language', '选择语言');
  String chooseScriptFor(String languageLabel) =>
      _('Choose a script for $languageLabel', '选择 $languageLabel 的文字');
  String get primaryBadge => _('1st', '主');
  String get secondaryBadge => _('2nd', '副');
  String scriptCount(int count) =>
      _(count == 1 ? '1 script' : '$count scripts', '$count 种文字');
  String get languageList => _('Languages', '语言列表');
  String get shown => _('On', '显示中');
  String get off => _('Off', '关闭');
  String get noSubtitlesAvailable => _('No subtitles available', '没有可用字幕');
  String get playToSeeWords => _(
    'Play to a subtitled moment to see word-by-word content here.',
    '播放到有字幕的位置后，这里会显示逐词内容。',
  );
  String get noTokenData => _(
    'This subtitle has no word-level token data yet.',
    '这条字幕暂时没有逐词 token 数据。',
  );
  String get dictionary => _('Dictionary', '词典');
  String get lookingUp => _('Looking up…', '查询中…');
  String lookupFailed(Object error) =>
      _('Lookup failed: $error', '查询失败：$error');
  String get noDefinition =>
      _('No definition for this entry yet.', '暂时没有这个词条的释义。');
  String get noLocalizedDefinition =>
      _('This entry has no Chinese definition yet.', '这个词条暂时没有中文释义。');
  String get comments => _('Comments', '评论');
  String get noComments => _('No comments yet.', '还没有评论。');
  String get loadingVideo => _('Loading video…', '正在加载视频…');
  String get loadingVideoDetail =>
      _('Loading video, subtitles and comments.', '正在加载视频、字幕和评论。');
  String get videoUnavailable => _('Video unavailable', '视频无法播放');
  String get unknownError => _('Unknown error', '未知错误');
  String get backHome => _('Back home', '返回首页');
  String get backHomeArrow => _('← Home', '← 首页');
  String get available => _('Available', '可用字幕');

  // Word lists
  String get wordLists => _('Word lists', '词表');
  String get wordListsSubtitle =>
      _('Build your vocabulary with curated lists', '用精选词表积累你的词汇');
  String get wordListsLoading => _('Loading word lists…', '正在加载词表…');
  String wordListEntryCount(int count) =>
      _(count == 1 ? '1 entry' : '$count entries', '$count 个词条');
  String get wordNoDefinition => _('No definition yet', '暂无释义');
  String get entryTypePhrase => _('Phrase', '短语');
  String get entryTypeWord => _('Word', '单词');
  String get wordListNotFound =>
      _('This word list could not be found', '找不到这份词表');
  String get backToWordLists => _('← Word lists', '← 词表');
}
