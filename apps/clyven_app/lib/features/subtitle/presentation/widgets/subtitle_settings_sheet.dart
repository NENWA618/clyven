import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glyphora_language_core/glyphora_language_core.dart';

import '../../data/models/subtitle_playback_state.dart';
import '../providers/subtitle_playback_provider.dart';
import '../providers/subtitle_provider.dart';

Future<void> showClyvenSubtitleSettingsSheet({
  required BuildContext context,
  required String videoId,
  required List<SubtitleTrackAvailability> availability,
}) async {
  final overlay = Overlay.maybeOf(context, rootOverlay: true);

  if (overlay == null) {
    throw StateError(
      'Cannot open subtitle settings because no Overlay was found.',
    );
  }

  late final OverlayEntry entry;
  var closed = false;

  void close() {
    if (closed) {
      return;
    }

    closed = true;
    entry.remove();
  }

  entry = OverlayEntry(
    builder: (overlayContext) {
      return Stack(
        fit: StackFit.expand,
        children: [
          ModalBarrier(
            dismissible: true,
            color: Colors.black54,
            onDismiss: close,
          ),
          Positioned.fill(
            child: SafeArea(
              child: SubtitleSettingsSheet(
                videoId: videoId,
                availability: availability,
                onClose: close,
              ),
            ),
          ),
        ],
      );
    },
  );

  overlay.insert(entry);
}

class SubtitleSettingsSheet extends ConsumerWidget {
  final String videoId;
  final List<SubtitleTrackAvailability> availability;
  final VoidCallback? onClose;

  const SubtitleSettingsSheet({
    super.key,
    required this.videoId,
    required this.availability,
    this.onClose,
  });

  void _close(BuildContext context) {
    final callback = onClose;

    if (callback != null) {
      callback();
      return;
    }

    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final state = ref.watch(subtitlePlaybackProvider(videoId));
    final notifier = ref.read(subtitlePlaybackProvider(videoId).notifier);

    final tracks = [for (final item in availability) item.track];

    final primary = _normalizeSelection(
      resolvePrimarySubtitleSelection(tracks, state),
      availability,
    );

    final secondary = _normalizeSelection(
      resolveSecondarySubtitleSelection(tracks, state),
      availability,
    );

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
                    child: Text(
                      '字幕',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _close(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Material(
                color: !state.enabled
                    ? scheme.primaryContainer.withValues(alpha: 0.55)
                    : scheme.surfaceContainerHighest.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(16),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  leading: Icon(
                    !state.enabled
                        ? Icons.check_circle_rounded
                        : Icons.closed_caption_off_rounded,
                    color: !state.enabled ? scheme.primary : null,
                  ),
                  title: const Text(
                    '关闭字幕',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  onTap: () {
                    notifier.setEnabled(false);
                    _close(context);
                  },
                ),
              ),
              const SizedBox(height: 24),
              const _SectionLabel(
                title: '字幕位置',
                subtitle: '视频内适合观看；视频下方会展开逐词翻译与完整句意',
              ),
              const SizedBox(height: 12),
              SegmentedButton<SubtitleDisplayMode>(
                segments: const [
                  ButtonSegment<SubtitleDisplayMode>(
                    value: SubtitleDisplayMode.overlay,
                    icon: Icon(Icons.ondemand_video_rounded),
                    label: Text('视频内'),
                  ),
                  ButtonSegment<SubtitleDisplayMode>(
                    value: SubtitleDisplayMode.learningPanel,
                    icon: Icon(Icons.view_agenda_outlined),
                    label: Text('视频下方'),
                  ),
                ],
                selected: <SubtitleDisplayMode>{state.displayMode},
                onSelectionChanged: (selection) {
                  if (selection.isEmpty) return;
                  notifier.setDisplayMode(selection.first);
                },
              ),
              const SizedBox(height: 24),
              const _SectionLabel(title: '主字幕', subtitle: '选择语言与该视频实际存在的文字系统'),
              const SizedBox(height: 12),
              for (final item in availability) ...[
                _LanguageGroup(
                  item: item,
                  selection: primary,
                  onSelected: (selection) {
                    notifier.selectPrimary(selection);
                    _close(context);
                  },
                ),
                const SizedBox(height: 18),
              ],
              const SizedBox(height: 6),
              Row(
                children: [
                  const Expanded(
                    child: _SectionLabel(
                      title: '第二字幕',
                      subtitle: '只能选择这个视频实际已上传的字幕',
                    ),
                  ),
                  if (secondary != null)
                    TextButton(
                      onPressed: notifier.clearSecondary,
                      child: const Text('关闭'),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              if (secondary == null)
                OutlinedButton.icon(
                  onPressed: () {
                    final candidate = _suggestSecondary(availability, primary);

                    if (candidate != null) {
                      notifier.selectSecondary(candidate);
                    }
                  },
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('添加第二字幕'),
                )
              else
                for (final item in availability) ...[
                  _LanguageGroup(
                    item: item,
                    selection: secondary,
                    disabledSelection: primary,
                    onSelected: (selection) {
                      if (sameSubtitleSelection(primary, selection)) {
                        return;
                      }

                      notifier.selectSecondary(selection);
                      _close(context);
                    },
                  ),
                  const SizedBox(height: 18),
                ],
            ],
          ),
        );
      },
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionLabel({required this.title, required this.subtitle});

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

class _LanguageGroup extends StatelessWidget {
  final SubtitleTrackAvailability item;
  final SubtitlePlaybackSelection? selection;
  final SubtitlePlaybackSelection? disabledSelection;
  final ValueChanged<SubtitlePlaybackSelection> onSelected;

  const _LanguageGroup({
    required this.item,
    required this.selection,
    required this.onSelected,
    this.disabledSelection,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final uiLanguageCode = Localizations.localeOf(context).languageCode;
    final track = item.track;
    final language = LanguageConfig.findByCode(track.languageCode);

    final languageName =
        language?.nameOf(uiLanguageCode) ??
        (track.label.trim().isNotEmpty
            ? track.label.trim()
            : track.languageCode.toUpperCase());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (language?.flag.isNotEmpty == true) ...[
              Text(language!.flag, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 9),
            ],
            Expanded(
              child: Text(
                languageName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            if (track.variantCode != null)
              Text(
                track.variantCode!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest.withValues(alpha: 0.32),
            borderRadius: BorderRadius.circular(18),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              for (var index = 0; index < item.scriptCodes.length; index++) ...[
                _ScriptTile(
                  track: track,
                  scriptCode: item.scriptCodes[index],
                  language: language,
                  uiLanguageCode: uiLanguageCode,
                  selected: _matches(selection, track, item.scriptCodes[index]),
                  disabled: _matches(
                    disabledSelection,
                    track,
                    item.scriptCodes[index],
                  ),
                  onTap: () {
                    onSelected(
                      subtitleSelectionFromTrack(
                        track,
                        scriptCode: item.scriptCodes[index],
                      ),
                    );
                  },
                ),
                if (index != item.scriptCodes.length - 1)
                  const Divider(height: 1),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ScriptTile extends StatelessWidget {
  final serverpod.SubtitleTrack track;
  final String scriptCode;
  final LanguageConfig? language;
  final String uiLanguageCode;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  const _ScriptTile({
    required this.track,
    required this.scriptCode,
    required this.language,
    required this.uiLanguageCode,
    required this.selected,
    required this.disabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final script = ScriptConfig.findByCode(scriptCode);
    final sample = script?.sampleText.trim();

    final label =
        language?.scriptNameOf(scriptCode, uiLanguageCode) ??
        script?.nameOf(uiLanguageCode) ??
        scriptCode;

    return ListTile(
      enabled: !disabled,
      onTap: disabled ? null : onTap,
      leading: sample == null || sample.isEmpty
          ? const Icon(Icons.translate_rounded)
          : SizedBox(
              width: 42,
              child: Text(
                sample,
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w900 : FontWeight.w700,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check_circle_rounded, color: scheme.primary)
          : null,
    );
  }
}

bool _matches(
  SubtitlePlaybackSelection? selection,
  serverpod.SubtitleTrack track,
  String scriptCode,
) {
  if (selection == null) {
    return false;
  }

  return subtitleSelectionMatchesTrack(selection, track) &&
      selection.scriptCode == scriptCode;
}

SubtitlePlaybackSelection? _normalizeSelection(
  SubtitlePlaybackSelection? selection,
  List<SubtitleTrackAvailability> availability,
) {
  if (selection == null) {
    return null;
  }

  SubtitleTrackAvailability? item;

  for (final candidate in availability) {
    if (subtitleSelectionMatchesTrack(selection, candidate.track)) {
      item = candidate;
      break;
    }
  }

  if (item == null || item.scriptCodes.isEmpty) {
    return null;
  }

  if (selection.scriptCode != null &&
      item.scriptCodes.contains(selection.scriptCode)) {
    return selection;
  }

  final defaultScript = item.track.defaultScriptCode?.trim();

  if (defaultScript != null &&
      defaultScript.isNotEmpty &&
      item.scriptCodes.contains(defaultScript)) {
    return subtitleSelectionFromTrack(item.track, scriptCode: defaultScript);
  }

  return subtitleSelectionFromTrack(
    item.track,
    scriptCode: item.scriptCodes.first,
  );
}

SubtitlePlaybackSelection? _suggestSecondary(
  List<SubtitleTrackAvailability> availability,
  SubtitlePlaybackSelection? primary,
) {
  for (final item in availability) {
    for (final scriptCode in item.scriptCodes) {
      final candidate = subtitleSelectionFromTrack(
        item.track,
        scriptCode: scriptCode,
      );

      if (!sameSubtitleSelection(primary, candidate)) {
        return candidate;
      }
    }
  }

  return null;
}
