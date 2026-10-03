/// HLS renditions that preserve the input aspect ratio and rotation metadata.
Map<String, dynamic> buildVideoTranscodeJob({
  required String inputUri,
  required String outputUri,
}) => {
  'inputUri': inputUri,
  'outputUri': outputUri,
  'config': {
    'elementaryStreams': [
      for (final rendition in [
        (key: 'video-sd', height: 360, bitrate: 1000000),
        (key: 'video-hd', height: 720, bitrate: 2500000),
      ])
        {
          'key': rendition.key,
          'videoStream': {
            'h264': {
              // Do not set both dimensions: that forces the source into a
              // fixed canvas. Google derives width from the input aspect ratio
              // and swaps output dimensions for rotation metadata when needed.
              // https://cloud.google.com/transcoder/docs/reference/rest/v1/JobConfig
              'heightPixels': rendition.height,
              'frameRate': 30,
              'bitrateBps': rendition.bitrate,
            },
          },
        },
      {
        'key': 'audio',
        'audioStream': {'codec': 'aac', 'bitrateBps': 128000},
      },
    ],
    'muxStreams': [
      for (final quality in ['sd', 'hd'])
        {
          'key': quality,
          'container': 'ts',
          'elementaryStreams': ['video-$quality', 'audio'],
          'segmentSettings': {'segmentDuration': '6s'},
        },
    ],
    'manifests': [
      {
        'fileName': 'manifest.m3u8',
        'type': 'HLS',
        'muxStreams': ['sd', 'hd'],
      },
    ],
  },
};
