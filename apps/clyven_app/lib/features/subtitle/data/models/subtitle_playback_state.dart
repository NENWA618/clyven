import 'package:clyven_backend_client/clyven_backend_client.dart' as serverpod;
import 'package:glyphora_language_core/glyphora_language_core.dart';

enum SubtitleDisplayMode { overlay, learningPanel }

class SubtitlePlaybackSelection {
  final int? trackId;
  final String languageCode;
  final String? variantCode;
  final String? scriptCode;

  const SubtitlePlaybackSelection({
    required this.trackId,
    required this.languageCode,
    required this.variantCode,
    required this.scriptCode,
  });
}

class SubtitlePlaybackState {
  final bool enabled;
  final SubtitleDisplayMode displayMode;
  final SubtitlePlaybackSelection? primary;
  final SubtitlePlaybackSelection? secondary;

  const SubtitlePlaybackState({
    this.enabled = true,
    this.displayMode = SubtitleDisplayMode.overlay,
    this.primary,
    this.secondary,
  });

  SubtitlePlaybackState copyWith({
    bool? enabled,
    SubtitleDisplayMode? displayMode,
    SubtitlePlaybackSelection? primary,
    SubtitlePlaybackSelection? secondary,
    bool clearPrimary = false,
    bool clearSecondary = false,
  }) {
    return SubtitlePlaybackState(
      enabled: enabled ?? this.enabled,
      displayMode: displayMode ?? this.displayMode,
      primary: clearPrimary ? null : primary ?? this.primary,
      secondary: clearSecondary ? null : secondary ?? this.secondary,
    );
  }
}

bool subtitleSelectionMatchesTrack(
  SubtitlePlaybackSelection selection,
  serverpod.SubtitleTrack track,
) {
  if (selection.trackId != null && track.id != null) {
    return selection.trackId == track.id;
  }

  return selection.languageCode == track.languageCode &&
      selection.variantCode == track.variantCode;
}

List<String> subtitleScriptsForTrack(serverpod.SubtitleTrack track) {
  final result = <String>[];

  void add(String? value) {
    final code = value?.trim();
    if (code == null || code.isEmpty || result.contains(code)) return;
    result.add(code);
  }

  final language = LanguageConfig.findByCode(track.languageCode);
  if (language != null) {
    for (final code in language.scriptCodes) {
      add(code);
    }
  }

  for (final script in ScriptConfig.allScripts) {
    if (script.languageCodes.any(
      (code) => code.toLowerCase() == track.languageCode.toLowerCase(),
    )) {
      add(script.code);
    }
  }

  add(track.defaultScriptCode);
  return result;
}

String? preferredScriptForTrack(serverpod.SubtitleTrack track) {
  final preferred = track.defaultScriptCode?.trim();
  if (preferred != null && preferred.isNotEmpty) return preferred;

  final scripts = subtitleScriptsForTrack(track);
  return scripts.isEmpty ? null : scripts.first;
}

SubtitlePlaybackSelection subtitleSelectionFromTrack(
  serverpod.SubtitleTrack track, {
  String? scriptCode,
}) {
  return SubtitlePlaybackSelection(
    trackId: track.id,
    languageCode: track.languageCode,
    variantCode: track.variantCode,
    scriptCode: scriptCode ?? preferredScriptForTrack(track),
  );
}

serverpod.SubtitleTrack? resolveSubtitleTrack(
  List<serverpod.SubtitleTrack> tracks,
  SubtitlePlaybackSelection? selection,
) {
  if (selection == null) return null;

  for (final track in tracks) {
    if (subtitleSelectionMatchesTrack(selection, track)) return track;
  }

  return null;
}

serverpod.SubtitleTrack? defaultSubtitleTrack(
  List<serverpod.SubtitleTrack> tracks,
) {
  if (tracks.isEmpty) return null;

  for (final track in tracks) {
    if (track.isDefault) return track;
  }

  final withIds = tracks.where((track) => track.id != null).toList();
  if (withIds.isNotEmpty) {
    withIds.sort((a, b) => a.id!.compareTo(b.id!));
    return withIds.first;
  }

  return tracks.first;
}

SubtitlePlaybackSelection? resolvePrimarySubtitleSelection(
  List<serverpod.SubtitleTrack> tracks,
  SubtitlePlaybackState state,
) {
  if (!state.enabled || tracks.isEmpty) return null;

  final explicit = state.primary;
  final track = resolveSubtitleTrack(tracks, explicit);
  if (explicit != null && track != null) {
    final scripts = subtitleScriptsForTrack(track);
    if (explicit.scriptCode == null ||
        scripts.isEmpty ||
        scripts.contains(explicit.scriptCode)) {
      return explicit;
    }
    return subtitleSelectionFromTrack(track);
  }

  final fallback = defaultSubtitleTrack(tracks);
  return fallback == null ? null : subtitleSelectionFromTrack(fallback);
}

SubtitlePlaybackSelection? resolveSecondarySubtitleSelection(
  List<serverpod.SubtitleTrack> tracks,
  SubtitlePlaybackState state,
) {
  if (!state.enabled || state.secondary == null) return null;

  final track = resolveSubtitleTrack(tracks, state.secondary);
  if (track == null) return null;

  final scripts = subtitleScriptsForTrack(track);
  if (state.secondary!.scriptCode == null ||
      scripts.isEmpty ||
      scripts.contains(state.secondary!.scriptCode)) {
    return state.secondary;
  }

  return subtitleSelectionFromTrack(track);
}

bool sameSubtitleSelection(
  SubtitlePlaybackSelection? a,
  SubtitlePlaybackSelection? b,
) {
  if (a == null || b == null) return false;
  return a.trackId == b.trackId &&
      a.languageCode == b.languageCode &&
      a.variantCode == b.variantCode &&
      a.scriptCode == b.scriptCode;
}

SubtitlePlaybackSelection? suggestSecondarySubtitleSelection(
  List<serverpod.SubtitleTrack> tracks,
  SubtitlePlaybackSelection? primary,
) {
  if (primary != null) {
    final track = resolveSubtitleTrack(tracks, primary);
    if (track != null) {
      for (final script in subtitleScriptsForTrack(track)) {
        final candidate = subtitleSelectionFromTrack(track, scriptCode: script);
        if (!sameSubtitleSelection(candidate, primary)) return candidate;
      }
    }
  }

  for (final track in tracks) {
    final scripts = subtitleScriptsForTrack(track);
    if (scripts.isEmpty) {
      final candidate = subtitleSelectionFromTrack(track);
      if (!sameSubtitleSelection(candidate, primary)) return candidate;
      continue;
    }

    for (final script in scripts) {
      final candidate = subtitleSelectionFromTrack(track, scriptCode: script);
      if (!sameSubtitleSelection(candidate, primary)) return candidate;
    }
  }

  return null;
}
