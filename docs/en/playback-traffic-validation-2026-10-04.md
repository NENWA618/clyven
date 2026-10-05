# Playback Traffic Optimization: Device Validation Record

**English** | [简体中文](../zh-CN/playback-traffic-validation-2026-10-04.md)

**Date: 2026-10-04**
**Test script: Clyven Playback Traffic Verification v6**
**Platform: physical Android device**
**Package name: `com.example.clyven`**

## Conclusion

This round of device testing succeeded.

The core behavior of the first phase of playback traffic optimization is verified. These mechanisms are confirmed to run on a real device, not only to exist in code:

- The HLS playback path works.
- The local media cache works.
- Real HLS segment cache hits were observed.
- Subtitle clips play directly on the original video timeline.
- Single-sentence looping works.
- The previous player is released during fast Shorts swiping.
- Manifest prewarming for the next Short works.
- The player pauses when the app goes to the background.
- Playback and cache diagnostic logs are emitted.

## Device log counts

```text
PLAYBACK_INITIALIZING          13
PLAYBACK_MEDIA_DELIVERY        13
PLAYBACK_CACHE_STATE           6
PLAYBACK_CACHE_POLICY          13
PLAYBACK_SOURCE_READY          13
PLAYBACK_CLIP_START            2
PLAYBACK_CLIP_LOOP             29
PLAYBACK_SHORTS_RELEASED       8
PLAYBACK_APP_PAUSED            5
PLAYBACK_APP_RESUMED           1
PLAYBACK_DATA_SAVER            36
PREWARMED_MANIFEST             8
VIDEO_CACHE_TASK               7
```

## Local cache evidence

The test produced:

```text
PLAYBACK_CACHE_STATE postId=55 seg1=true seg2=false seg4=false storageBytes=184922301
```

At least one HLS segment exists in the local cache and was found by the cache check.

Local media cache usage during the test:

```text
184,922,301 bytes ≈ 176 MB
187,297,869 bytes ≈ 179 MB
```

## Subtitle clip looping

Result:

```text
PLAYBACK_CLIP_START = 2
PLAYBACK_CLIP_LOOP  = 29
```

A subtitle search result plays from the original video's timeline and repeats correctly. The number of consecutive loops exceeded the original acceptance target of 20.

## Shorts lifecycle

Result:

```text
PLAYBACK_SHORTS_RELEASED = 8
PREWARMED_MANIFEST       = 8
```

This shows that:

- After the user quickly swipes away from a Short, the old player is released.
- Manifest prewarming for the next Short runs.
- There is no evidence that the current implementation preloads many following Shorts in full.

## App background lifecycle

Result:

```text
PLAYBACK_APP_PAUSED  = 5
PLAYBACK_APP_RESUMED = 1
```

The player receives lifecycle events and pauses when the app goes to the background.

## P0 status

| Item | Status |
|---|---|
| HLS multi-resolution basics | Implemented |
| ABR Auto | Implemented |
| Local media cache | Verified |
| Cache reuse on repeated playback | Device evidence available |
| Subtitle clips reuse the original video | Verified |
| Single-sentence loop | Verified |
| Old Shorts player released | Verified |
| Lightweight prewarm of the next Short | Verified |
| Pause when the app is backgrounded | Verified |
| Manual quality selection by the user | Not done yet |

## Not covered

This round did not measure precisely:

- How many MB the first playback downloaded
- How many MB the second, repeated playback saved
- How much extra cloud traffic 20 single-sentence loops generated
- The CDN cache hit ratio
- Actual GCS / CDN origin fetches
- Real downloaded bytes per minute of viewing

These belong to the next stage: request-level traffic and cloud-metric validation.

## Final note

As of 2026-10-04:

**The core behavior of Clyven's P0 playback traffic optimization has passed device testing.**

There is no need to repeat the checks for player lifecycle, subtitle looping, Shorts release, and basic local caching unless the related code changes significantly.


---

## v10: cold-cache and warm-cache repeated playback

**Test date: 2026-10-04**
**Test script: Clyven Playback Traffic Verification v10**

Before the test, Clyven's local data was cleared with `pm clear` to create a true cold-cache environment. The same regular HLS video was then played twice over exactly the same range.

### Phase A: first playback with a cold cache

```text
VIDEO_CACHE_TASK = 69
Cache hit evidence = 0
Cache directory growth = 31,804,416 bytes
Distinct media URLs in the log = 5
```

### Phase B: repeated playback with a warm cache

```text
VIDEO_CACHE_TASK = 6
Cache hit evidence = 1
Cache directory growth = 4,255,744 bytes
Distinct media URLs in the log = 4
```

### Conclusion

- `VIDEO_CACHE_TASK` fell from 69 to 6, a drop of about **91.3%**.
- The second playback clearly shows a local HLS segment cache hit.
- The cache directory grew by about 4.1 MB on the second playback, far below the first playback's roughly 30.3 MB.
- It is therefore confirmed that **when the same video is watched again over the same range, Clyven reuses the local HLS segment cache and does not download the same content in full again.**
- This proves the client's repeated-playback cache works, but cache directory growth cannot be treated as equal to the egress traffic on the Google Cloud bill.

### Status update

| Item | Status |
|---|---|
| Cache reuse for repeated regular-video playback | ✅ Cold/warm device comparison passed |
| Old Shorts player released | ✅ Passed |
| Next Short manifest prewarm | ✅ Passed |
| Pause when the app is backgrounded | ✅ Passed |
| Subtitle clip loop feature | ✅ Verified (29 loops in v6) |
| Subtitle clip loop avoids repeated downloads | Pending a dedicated test |


---

## v12: subtitle clip loop traffic

**Test date: 2026-10-04**
**Test script: Clyven Subtitle Clip Loop Traffic Verification v12**

### First clip playback

```text
PLAYBACK_CLIP_START = 1
PLAYBACK_CLIP_LOOP = 5
VIDEO_CACHE_TASK = 45
Distinct media URLs = 4
Cache growth = 8,182,784 bytes
```

### Later loops of the same clip

```text
PLAYBACK_CLIP_LOOP = 17
VIDEO_CACHE_TASK = 0
Distinct media URLs = 1
Further cache growth = 0 bytes
```

Phases A and B together recorded **22 loops**.

### Conclusion

- After the first load, the same subtitle clip produced no new `VIDEO_CACHE_TASK` during later consecutive loops.
- During the following 17 loops the app's `cache` directory grew by **0 bytes**.
- Looping a subtitle clip reuses the HLS segments that are already loaded or cached instead of downloading them again on every loop.
- It is therefore confirmed that **the optimization that avoids repeated downloads during consecutive subtitle clip loops passed device validation.**

### Status update

| Item | Status |
|---|---|
| Cache reuse for repeated regular-video playback | ✅ Cold/warm device comparison passed |
| Subtitle clip loop avoids repeated downloads | ✅ Device validation passed |
| Old Shorts player released | ✅ Passed |
| Next Short manifest prewarm | ✅ Passed |
| Pause when the app is backgrounded | ✅ Passed |

---

## v13: traffic while swiping quickly through Shorts

**Test date: 2026-10-04**

Observed while swiping quickly through Shorts:

```text
Initializations: 10
Releases: 9
Prewarms: 8
VIDEO_CACHE_TASK: 131
Cache growth: about 26.1 MB
```

After staying put for about 20 seconds:

```text
VIDEO_CACHE_TASK: 32
Cache growth: about 23.2 MB
```

### Conclusion

- The Shorts lifecycle release logic fires correctly.
- The next-manifest prewarm fires correctly.
- Fast switching still produces noticeable media requests.
- Investigation therefore continued into segment duration and the waste caused by quickly swiping away.

---

## v15: new HLS version and ABR start-up behavior

Newly transcoded video:

```text
videoId=57
media version=v1
```

The test observed:

```text
/transcoded/57/v1/
```

and the new multi-bitrate HLS was in use.

In this run the new video did not fetch many segments of several qualities at start-up, so ABR start-up behavior was essentially normal.

### Conclusion

The new multi-bitrate HLS itself showed no obvious problem of downloading every quality at start-up.

---

## v20: correct BYTERANGE parsing

Further inspection confirmed that HLS uses:

```text
#EXT-X-BYTERANGE
```

The HTTP `Content-Length` of a TS object therefore cannot be used directly as the size of a single segment.

With the v1 6-second segments of `videoId=57` parsed correctly:

```text
360p:
First segment 626,416 bytes
about 0.597 MiB
average about 0.835 Mbps

480p:
First segment 958,800 bytes
about 0.914 MiB
average about 1.278 Mbps

720p:
First segment 1,756,672 bytes
about 1.675 MiB
average about 2.342 Mbps

1080p:
First segment 3,224,012 bytes
about 3.075 MiB
average about 4.299 Mbps
```

### Conclusion

The bitrates are not abnormal.

The earlier suspicion that "one segment is unusually large" came from mistaking the size of the whole shared TS object for the size of a single segment.

---

## Shorts v2: 3-second segments

Backend change:

```text
Regular Video: 6-second segments
Short: 3-second segments
New media version: v2
```

Related commit:

```text
1f30e91
Optimize Shorts HLS segment duration and media versioning
```

New Cloud Run revision:

```text
glyphora-server-00086-b8j
```

Traffic was switched to:

```text
100% latest revision
```

### Validation with a new Short

Newly uploaded:

```text
videoId=58
```

Manifest:

```text
gs://glyphora-video-storage-11129163384/transcoded/58/v2/manifest.m3u8
```

All four playlists were verified:

```text
TARGETDURATION=3
SegmentCount=9
FirstSegment=3.000s
MaxSegment=3.000s
```

### First 480p segment comparison

Old v1:

```text
videoId=57
6 seconds
958,800 bytes
about 0.914 MiB
```

New v2:

```text
videoId=58
3 seconds
479,776 bytes
about 0.458 MiB
average bitrate about 1.279 Mbps
```

First-segment bytes reduced by:

```text
50.0%
```

### Conclusion

Dedicated 3-second segments for Shorts are live and verified.

With essentially the same average bitrate, the potential waste of the first 480p segment when swiping away quickly is cut by about half.

---

## Canceling cache tasks after swiping away from a Short

Later testing found that:

```text
PLAYBACK_SHORTS_RELEASED
```

fired, but the next segment already queued in the cache layer could still keep downloading.

The app therefore gained cache cancellation logic.

Related commit:

```text
32fa154
Cancel Shorts cache tasks after swipe
```

New diagnostic:

```text
PLAYBACK_CACHE_CANCELLED
```

In the final device test:

```text
20:55:43.520 PLAYBACK_CACHE_CANCELLED postId=50
20:55:43.522 PLAYBACK_SHORTS_RELEASED postId=50
20:55:43.540 PLAYBACK_INITIALIZING postId=49
20:55:43.540 PREWARMED_MANIFEST postId=49
```

The released `postId=50` had a Range request in flight at that moment:

```text
Task ID=125
TotalBytes=2,136,432
```

That in-flight task still completed afterwards. However, within the test window no new media segment task for `postId=50` was observed being queued.

### Conclusion

- The cache cancellation path actually ran when a Short was swiped away.
- An HTTP Range request already in flight may still finish.
- In the current observation, no further segments were queued for the old Short after release.
- The cache library is not forked or hacked just to force-abort a last Range request that is nearly done.

---

## Final status on 2026-10-04

| Item | Status |
|---|---|
| HLS multi-resolution | ✅ |
| ABR Auto | ✅ |
| Cache reuse for repeated regular-video playback | ✅ |
| Subtitle clip loop avoids repeated downloads | ✅ |
| Old Shorts player released | ✅ |
| Next Short manifest prewarm | ✅ |
| Shorts v2 3-second segments | ✅ |
| Regular Video 6-second segments | ✅ |
| First 480p Short segment about 50% smaller | ✅ |
| Cache cancellation called when a Short is swiped away | ✅ |
| Force-aborting a Range request already in flight | Not guaranteed |
| Pause when the app is backgrounded | ✅ |
| Precise GCP egress | Not yet validated with cloud billing or request metrics |

### Engineering assessment

This round of P0 playback traffic optimization has met its main goals.

Two notes should be kept long term:

1. Growth of the `cache` directory cannot be treated as equal to actual Google Cloud egress.
2. In BYTERANGE HLS, the total size of a shared TS file must not be used as the size of one segment.

For precise cost analysis later, use GCS / CDN / Cloud Logging or billing metrics to validate at the request level.
