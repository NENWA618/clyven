/// Builds the Google Cloud Transcoder HLS job used by Clyven.
///
/// The master playlist exposes four H.264 renditions so the native player can
/// use HLS adaptive bitrate playback instead of being locked to one quality.
///
/// Only height is fixed. Width is derived from the source aspect ratio, which
/// keeps portrait Shorts and landscape videos correct.
Map<String, dynamic> buildVideoTranscodeJob({
  required String inputUri,
  required String outputUri,
  required Duration segmentDuration,
}) => {
  'inputUri': inputUri,
  'outputUri': outputUri,
  'config': {
    'elementaryStreams': [
      for (final rendition in [
        (
          key: 'video-360',
          height: 360,
          bitrate: 650000,
        ),
        (
          key: 'video-480',
          height: 480,
          bitrate: 1100000,
        ),
        (
          key: 'video-720',
          height: 720,
          bitrate: 2200000,
        ),
        (
          key: 'video-1080',
          height: 1080,
          bitrate: 4200000,
        ),
      ])
        {
          'key': rendition.key,
          'videoStream': {
            'h264': {
              'heightPixels': rendition.height,
              'frameRate': 30,
              'bitrateBps': rendition.bitrate,
            },
          },
        },
      {
        'key': 'audio',
        'audioStream': {
          'codec': 'aac',
          'bitrateBps': 128000,
        },
      },
    ],
    'muxStreams': [
      for (final quality in ['360', '480', '720', '1080'])
        {
          'key': quality,
          'container': 'ts',
          'elementaryStreams': ['video-$quality', 'audio'],
          'segmentSettings': {
            'segmentDuration': '${segmentDuration.inSeconds}s',
          },
        },
    ],
    'manifests': [
      {
        'fileName': 'manifest.m3u8',
        'type': 'HLS',
        'muxStreams': ['360', '480', '720', '1080'],
      },
    ],
  },
};
