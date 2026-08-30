import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  static const Color _background =
      Color(0xFFF4F1EA);

  static const Color _ink =
      Color(0xFF161616);

  static const Color _purple =
      Color(0xFF7657FF);

  static const Color _acid =
      Color(0xFFE5FF58);

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),

            const Divider(
              height: 1,
              color: Color(0xFFE3DED5),
            ),

            Expanded(
              child: ListView(
                physics:
                    const BouncingScrollPhysics(),
                padding:
                    const EdgeInsets.fromLTRB(
                  20,
                  24,
                  20,
                  30,
                ),
                children: [
                  _buildSectionTitle(
                    'ACCOUNT',
                    '账号',
                  ),

                  const SizedBox(height: 12),

                  _SettingsItem(
                    icon:
                        Icons.person_outline_rounded,
                    title: '账号与资料',
                    subtitle: '昵称、头像、个人简介',
                    onTap: () {
                      // 下一步再接账号资料页
                    },
                  ),

                  const SizedBox(height: 10),

                  _SettingsItem(
                    icon:
                        Icons.lock_outline_rounded,
                    title: '隐私',
                    subtitle: '隐私与内容可见范围',
                    onTap: () {
                      // 下一步再接隐私设置
                    },
                  ),

                  const SizedBox(height: 30),

                  _buildSectionTitle(
                    'APP',
                    '应用',
                  ),

                  const SizedBox(height: 12),

                  _SettingsItem(
                    icon: Icons
                        .notifications_none_rounded,
                    title: '通知',
                    subtitle: '管理回响与推送通知',
                    onTap: () {
                      // 下一步再接通知设置
                    },
                  ),

                  const SizedBox(height: 10),

                  _SettingsItem(
                    icon:
                        Icons.info_outline_rounded,
                    title: '关于',
                    subtitle: '版本与应用信息',
                    onTap: () {
                      // 下一步再接关于页面
                    },
                  ),

                  const SizedBox(height: 36),

                  _buildSectionTitle(
                    'IDENTITY',
                    '当前身份',
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () async {
                        await ref
                            .read(
                              authProvider
                                  .notifier,
                            )
                            .logout();

                        if (!context.mounted) {
                          return;
                        }

                        Navigator.pop(context);
                      },
                      style:
                          OutlinedButton.styleFrom(
                        foregroundColor: _ink,
                        side: const BorderSide(
                          color:
                              Color(0xFFCAC5BB),
                        ),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            18,
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons
                                .logout_rounded,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '退出当前身份',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      'GLYPHORA',
                      style: TextStyle(
                        color:
                            Color(0xFFAAA49B),
                        fontSize: 9,
                        fontWeight:
                            FontWeight.w800,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        20,
        12,
      ),
      child: Row(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color:
                    Colors.white.withOpacity(
                  0.72,
                ),
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
                border: Border.all(
                  color:
                      const Color(0xFFE3DED5),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: _ink,
                size: 21,
              ),
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'SETTINGS',
                  style: TextStyle(
                    color: _purple,
                    fontSize: 9,
                    fontWeight:
                        FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '设置',
                  style: TextStyle(
                    color: _ink,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 10,
            height: 10,
            decoration:
                const BoxDecoration(
              color: _acid,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(
    String english,
    String title,
  ) {
    return Row(
      children: [
        Text(
          english,
          style: const TextStyle(
            color: _purple,
            fontSize: 9,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.8,
          ),
        ),

        const SizedBox(width: 10),

        Text(
          title,
          style: const TextStyle(
            color: _ink,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _SettingsItem
    extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(
            0.72,
          ),
          borderRadius:
              BorderRadius.circular(20),
          border: Border.all(
            color:
                const Color(0xFFE3DED5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(
                  0x147657FF,
                ),
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: Icon(
                icon,
                color: const Color(
                  0xFF7657FF,
                ),
                size: 21,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        const TextStyle(
                      color: Color(
                        0xFF161616,
                      ),
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style:
                        const TextStyle(
                      color: Color(
                        0xFF99938A,
                      ),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF99938A),
              size: 21,
            ),
          ],
        ),
      ),
    );
  }
}