import 'package:clyven_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/utils/require_login.dart';
import '../../../creator/presentation/pages/following_creators_page.dart';
import '../../../history/presentation/pages/watch_history_page.dart';
import '../../../video_interactions/presentation/pages/favorite_videos_page.dart';
import '../../../word_list/presentation/pages/word_lists_page.dart';
import '../../data/models/user_profile.dart';
import '../providers/my_profile_provider.dart';
import 'my_submissions_page.dart';
import 'settings_page.dart';
import 'edit_profile_page.dart';

import 'package:clyven_app/features/video/presentation/controllers/global_video_player_controller.dart';

class MyProfilePage extends ConsumerWidget {
  const MyProfilePage({super.key});

  static const Color _ink = Color(0xFF171714);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    if (authAsync.isLoading) {
      return Scaffold(
        backgroundColor: scheme.surface,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final user = authAsync.value;

    if (user == null) {
      return _buildGuestContent(context, ref, l10n);
    }

    final profileAsync = ref.watch(myProfileProvider);

    return Scaffold(
      backgroundColor: scheme.surface,
      body: profileAsync.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return SafeArea(
            child: Column(
              children: [
                _buildTopBar(context, l10n),
                Expanded(
                  child: Center(
                    child: FilledButton(
                      onPressed: () {
                        ref.invalidate(myProfileProvider);
                      },
                      child: Text(l10n.reload),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        data: (profile) {
          return _buildContent(context, ref, profile, l10n);
        },
      ),
    );
  }

  Widget _buildGuestContent(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final scheme = Theme.of(context).colorScheme;

    Future<void> login() async {
      await requireLogin(context, ref);
    }

    return Scaffold(
      backgroundColor: scheme.surface,
      body: SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar(context, l10n)),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 82,
                      height: 82,
                      decoration: BoxDecoration(
                        color: _ink,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: const Color(0xFFD49A6A),
                        size: 34,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.guest,
                            style: TextStyle(
                              color: scheme.onSurface,
                              fontSize: 27,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            l10n.guestProfileSubtitle,
                            style: TextStyle(
                              color: scheme.brightness == Brightness.dark
                                  ? const Color(0xFFBEB9B0)
                                  : const Color(0xFF77736C),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: _buildLibraryRow(
                  context,
                  l10n,
                  submissionsTap: login,
                  favoritesTap: login,
                  historyTap: login,
                  followingTap: login,
                  wordListsTap: login,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
                child: SizedBox(
                  height: 52,
                  child: FilledButton(
                    onPressed: login,
                    style: FilledButton.styleFrom(
                      backgroundColor: scheme.brightness == Brightness.dark
                          ? scheme.primary
                          : _ink,
                      foregroundColor: scheme.brightness == Brightness.dark
                          ? scheme.onPrimary
                          : scheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      l10n.loginOrRegister,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 60)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
    AppLocalizations l10n,
  ) {
    return SafeArea(
      bottom: false,
      child: RefreshIndicator(
        onRefresh: () {
          return ref.read(myProfileProvider.notifier).refresh();
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          slivers: [
            SliverToBoxAdapter(child: _buildTopBar(context, l10n)),
            SliverToBoxAdapter(child: _buildIdentity(context, ref, profile)),
            SliverToBoxAdapter(child: _buildStats(context, profile, l10n)),
            SliverToBoxAdapter(child: _buildLibrary(context, l10n)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 32, 20, 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.myTrack,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      l10n.myFrames,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF9E9991)
                            : const Color(0xFF99938A),
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final video = profile.videos[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: _buildVideo(context, video, index, l10n),
                  );
                }, childCount: profile.videos.length),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 50)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, AppLocalizations l10n) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.profileEyebrow,
                  style: TextStyle(
                    color: scheme.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.navProfile,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 30,
                    height: 1.05,
                    letterSpacing: -.8,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF191918)
                    : const Color(0xFFF9F7F2),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: const Icon(Icons.settings_outlined, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdentity(
    BuildContext context,
    WidgetRef ref,
    UserProfile profile,
  ) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 22, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: 82,
              height: 82,
              color: _ink,
              child: profile.avatarUrl.isEmpty
                  ? Center(
                      child: Text(
                        profile.displayName.isEmpty
                            ? '?'
                            : profile.displayName.substring(0, 1).toUpperCase(),
                        style: TextStyle(
                          color: const Color(0xFFD49A6A),
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : Image.network(profile.avatarUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: TextStyle(
                    color: scheme.onSurface,
                    fontSize: 27,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '@${profile.username}',
                  style: TextStyle(
                    color: scheme.brightness == Brightness.dark
                        ? const Color(0xFFBEB9B0)
                        : const Color(0xFF77736C),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  profile.bio,
                  style: TextStyle(
                    color: scheme.brightness == Brightness.dark
                        ? const Color(0xFFCFCAC2)
                        : const Color(0xFF4F4B45),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                OutlinedButton.icon(
                  onPressed: () async {
                    final changed = await Navigator.push<bool>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProfilePage(profile: profile),
                      ),
                    );
                    if (changed == true) {
                      ref.invalidate(myProfileProvider);
                    }
                  },
                  icon: const Icon(Icons.edit_outlined, size: 16),
                  label: Text(
                    Localizations.localeOf(context).languageCode == 'zh'
                        ? '编辑资料'
                        : 'Edit profile',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(
    BuildContext context,
    UserProfile profile,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        height: 88,
        decoration: BoxDecoration(
          color: _ink,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            _stat(
              context,
              _count(context, profile.followerCount),
              l10n.followers,
            ),
            _line(),
            _stat(
              context,
              _count(context, profile.followingCount),
              l10n.followingStat,
            ),
            _line(),
            _stat(
              context,
              _count(context, profile.videoCount),
              l10n.submissionsStat,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLibrary(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: _buildLibraryRow(
        context,
        l10n,
        submissionsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MySubmissionsPage();
              },
            ),
          );
        },
        favoritesTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FavoriteVideosPage();
              },
            ),
          );
        },
        historyTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const WatchHistoryPage();
              },
            ),
          );
        },
        followingTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const FollowingCreatorsPage();
              },
            ),
          );
        },
        wordListsTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const WordListsPage();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildLibraryRow(
    BuildContext context,
    AppLocalizations l10n, {
    required VoidCallback submissionsTap,
    required VoidCallback favoritesTap,
    required VoidCallback historyTap,
    required VoidCallback followingTap,
    required VoidCallback wordListsTap,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _libraryItem(
                context: context,
                icon: Icons.video_library_outlined,
                title: l10n.submissions,
                subtitle: l10n.myWorks,
                onTap: submissionsTap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _libraryItem(
                context: context,
                icon: Icons.bookmark_border_rounded,
                title: l10n.favorites,
                subtitle: l10n.savedContent,
                onTap: favoritesTap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _libraryItem(
                context: context,
                icon: Icons.history_rounded,
                title: l10n.history,
                subtitle: l10n.watchHistory,
                onTap: historyTap,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _libraryItem(
                context: context,
                icon: Icons.people_outline_rounded,
                title: l10n.followingStat,
                subtitle: l10n.myChannels,
                onTap: followingTap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _libraryItem(
                context: context,
                icon: Icons.menu_book_rounded,
                title: '词表',
                subtitle: '我的词汇学习',
                onTap: wordListsTap,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _libraryItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final secondary = scheme.secondary;
    final isDark = scheme.brightness == Brightness.dark;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 108,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF191918) : const Color(0xFFF9F7F2),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: secondary.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: secondary, size: 20),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: false,
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.clip,
              softWrap: false,
              style: TextStyle(
                color: isDark
                    ? const Color(0xFF9E9991)
                    : const Color(0xFF99938A),
                fontSize: 9,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideo(
    BuildContext context,
    ProfileVideo video,
    int index,
    AppLocalizations l10n,
  ) {
    final number = (index + 1).toString().padLeft(2, '0');
    final scheme = Theme.of(context).colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        openGlobalVideo(video.id);
      },
      child: Container(
        height: 125,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF191918) : const Color(0xFFF9F7F2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(19),
              ),
              child: SizedBox(
                width: 145,
                height: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(video.coverUrl, fit: BoxFit.cover),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _ink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _duration(video.durationSeconds),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.frameNumber(number),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 8,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.3,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Expanded(
                      child: Text(
                        video.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: scheme.onSurface,
                          fontSize: 15,
                          height: 1.25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text(
                      l10n.viewsCount(_count(context, video.viewCount)),
                      style: TextStyle(
                        color: isDark
                            ? const Color(0xFF9E9991)
                            : const Color(0xFF908A81),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stat(BuildContext context, String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white54, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget _line() {
    return Container(width: 1, height: 30, color: Colors.white12);
  }

  String _count(BuildContext context, int value) {
    final localeName = Localizations.localeOf(context).toString();
    return NumberFormat.compact(locale: localeName).format(value);
  }

  static String _duration(int seconds) {
    final duration = Duration(seconds: seconds);
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');

    return '$minutes:$remainingSeconds';
  }
}
