import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glyphora_language_core/glyphora_language_core.dart';

import '../../data/models/subtitle_playback_state.dart';
import '../providers/subtitle_playback_provider.dart';

Future<void> showClyvenSubtitleSettingsSheet({
  required BuildContext context,
  required String videoId,
  required List<serverpod.SubtitleTrack> tracks,
}) async {
  await showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SubtitleSettingsSheet(
      videoId: videoId,
      tracks: tracks,
    ),
  );
}

class SubtitleSettingsSheet extends ConsumerWidget {
  final String videoId;
  final List<serverpod.SubtitleTrack> tracks;

  const SubtitleSettingsSheet({
    super.key,
    required this.videoId,
    required this.tracks,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final uiLanguageCode = Localizations.localeOf(context).languageCode;
    final state = ref.watch(subtitlePlaybackProvider(videoId));
    final notifier = ref.read(subtitlePlaybackProvider(videoId).notifier);
    final primary = resolvePrimarySubtitleSelection(tracks, state);
    final secondary = resolveSecondarySubtitleSelection(tracks, state);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.82,
      minChildSize: 0.48,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Material(
          color: scheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          clipBehavior: Clip.antiAlias,
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 34),
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: scheme.primaryContainer,
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      Icons.subtitles_rounded,
                      color: scheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '字幕',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text('选择语言、文字系统与双字幕'),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest.withValues(alpha: 0.55),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: SwitchListTile(
                  value: state.enabled,
                  onChanged: notifier.setEnabled,
                  secondary: Icon(
                    state.enabled
                        ? Icons.closed_caption_rounded
                        : Icons.closed_caption_off_rounded,
                  ),
                  title: const Text(
                    '显示字幕',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              if (state.enabled) ...[
                const SizedBox(height: 26),
                _SectionHeader(
                  title: '主字幕',
                  subtitle: primary == null
                      ? '选择主要显示的字幕'
                      : _selectionSummary(primary, tracks, uiLanguageCode),
                ),
                const SizedBox(height: 10),
                for (final track in tracks)
                  _SubtitleTrackCard(
                    track: track,
                    selection: primary,
                    uiLanguageCode: uiLanguageCode,
                    onTrackSelected: () => notifier.selectPrimary(
                      subtitleSelectionFromTrack(track),
                    ),
                    onScriptSelected: (script) => notifier.selectPrimary(
                      subtitleSelectionFromTrack(track, scriptCode: script),
                    ),
                  ),
                const SizedBox(height: 26),
                Row(
                  children: [
                    const Expanded(
                      child: _SectionHeader(
                        title: '第二字幕',
                        subtitle: '另一种语言，或同一语言的另一种文字',
                      ),
                    ),
                    if (secondary != null)
                      TextButton(
                        onPressed: notifier.clearSecondary,
                        child: const Text('关闭'),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                if (secondary == null)
                  OutlinedButton.icon(
                    onPressed: () {
                      final candidate = suggestSecondarySubtitleSelection(
                        tracks,
                        primary,
                      );
                      if (candidate != null) {
                        notifier.selectSecondary(candidate);
                      }
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('添加第二字幕'),
                  )
                else ...[
                  Container(
                    padding: const EdgeInsets.all(13),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: scheme.secondaryContainer.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _selectionSummary(secondary, tracks, uiLanguageCode),
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  for (final track in tracks)
                    _SubtitleTrackCard(
                      track: track,
                      selection: secondary,
                      uiLanguageCode: uiLanguageCode,
                      onTrackSelected: () {
                        final candidate = subtitleSelectionFromTrack(track);
                        if (!sameSubtitleSelection(primary, candidate)) {
                          notifier.selectSecondary(candidate);
                        }
                      },
                      onScriptSelected: (script) {
                        final candidate = subtitleSelectionFromTrack(
                          track,
                          scriptCode: script,
                        );
                        if (!sameSubtitleSelection(primary, candidate)) {
                          notifier.selectSecondary(candidate);
                        }
                      },
                    ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: TextStyle(
            color: scheme.onSurface.withValues(alpha: 0.58),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _SubtitleTrackCard extends StatelessWidget {
  final serverpod.SubtitleTrack track;
  final SubtitlePlaybackSelection? selection;
  final String uiLanguageCode;
  final VoidCallback onTrackSelected;
  final ValueChanged<String> onScriptSelected;

  const _SubtitleTrackCard({
    required this.track,
    required this.selection,
    required this.uiLanguageCode,
    required this.onTrackSelected,
    required this.onScriptSelected,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final selected = selection != null &&
        subtitleSelectionMatchesTrack(selection!, track);
    final language = LanguageConfig.findByCode(track.languageCode);
    final variant = track.variantCode == null
        ? null
        : LanguageVariantConfig.findByCode(track.variantCode!);
    final scripts = subtitleScriptsForTrack(track);
    final languageName = language?.nameOf(uiLanguageCode) ??
        (track.label.trim().isNotEmpty
            ? track.label.trim()
            : track.languageCode.toUpperCase());

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: selected
            ? scheme.primaryContainer.withValues(alpha: 0.52)
            : scheme.surfaceContainerHighest.withValues(alpha: 0.34),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected
              ? scheme.primary.withValues(alpha: 0.55)
              : scheme.outlineVariant.withValues(alpha: 0.55),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTrackSelected,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (language?.flag.isNotEmpty == true) ...[
                    Text(language!.flag, style: const TextStyle(fontSize: 21)),
                    const SizedBox(width: 10),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          languageName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if (variant != null)
                          Text(
                            variant.nameOf(uiLanguageCode),
                            style: TextStyle(
                              color: scheme.onSurface.withValues(alpha: 0.56),
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (selected)
                    Icon(Icons.check_circle_rounded, color: scheme.primary),
                ],
              ),
              if (selected && scripts.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  '文字系统',
                  style: TextStyle(
                    color: scheme.onSurface.withValues(alpha: 0.58),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final script in scripts)
                      ChoiceChip(
                        selected: selection?.scriptCode == script,
                        label: Text(_scriptLabel(language, script, uiLanguageCode)),
                        onSelected: (_) => onScriptSelected(script),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

String _scriptLabel(
  LanguageConfig? language,
  String scriptCode,
  String uiLanguageCode,
) {
  return language?.scriptNameOf(scriptCode, uiLanguageCode) ??
      ScriptConfig.findByCode(scriptCode)?.nameOf(uiLanguageCode) ??
      scriptCode;
}

String _selectionSummary(
  SubtitlePlaybackSelection selection,
  List<serverpod.SubtitleTrack> tracks,
  String uiLanguageCode,
) {
  final track = resolveSubtitleTrack(tracks, selection);
  final language = LanguageConfig.findByCode(selection.languageCode);
  final languageName = language?.nameOf(uiLanguageCode) ??
      track?.label ??
      selection.languageCode.toUpperCase();
  final variant = selection.variantCode == null
      ? null
      : LanguageVariantConfig.findByCode(selection.variantCode!);
  final script = selection.scriptCode == null
      ? null
      : _scriptLabel(language, selection.scriptCode!, uiLanguageCode);

  return [
    languageName,
    if (variant != null) variant.nameOf(uiLanguageCode),
    if (script != null) script,
  ].join(' · ');
}
