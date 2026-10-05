# Cross-User Video Visibility Investigation (2026-09-26)

**English** | [简体中文](../zh-CN/video-visibility-investigation-2026-09-26.md)

## Final correction

The user later confirmed that the spinner they saw was part of the video's own content, not the player's loading indicator. It therefore cannot be treated as evidence that cross-account playback failed, and the earlier conclusion that the player was stuck is withdrawn. The investigation and its scope of verification are kept below. The cache, error-handling, and player-timeout changes are robustness improvements; they must not be presented as having confirmed and fixed a real cross-account playback root cause. Final Flutter analysis reported no issues and 9 Flutter tests passed. A new APK has not been verified on the user's phone.

## Conclusions and limits of verification

The user added that, apart from the video titled 《帅哥》, new videos were visible in the emulator but not in the APK they built and installed themselves.

**The exact failure point of that APK was not reproduced, so it must not be claimed that the real-phone problem is fully fixed.** No Android device was connected and no failing APK was available during the first pass. The user later supplied an APK; its static inspection is at the end of this document. The filter state and the actual responses at runtime on the phone were still not obtained.

Confirmed:

- The same live public API returns, anonymously, 《帅哥》(9), 《ai 代码教学》(17), and 《Self Introduction》(15), including different authors.
- 9 and 17 share one author and are both `status=published`, `isPublic=true`. For the three videos and their covers, all six HEAD requests returned HTTP 200.
- The deployed protocol and the repository disagree: the live service returns `isPublic` and no `contentType`, while the local Video schema has `contentType` and no `isPublic`. Requesting video and short on the live service returned the same 14 IDs.
- The local public feed has no authorId / currentUserId condition. There is no confirmed root cause of the form "the back end only queries the author's own videos".
- Reproducible local cache and error-handling defects exist. They were fixed and covered by tests, but that does not make them the only root cause of this APK's problem.

## Real record comparison

The complete fields and resource status are in `build/public-feed-audit.json`. They are persisted model records returned by the deployed API, **not a SQL dump taken directly from the production database**.

| Field | Normal example | Example of the new video the user described | New video by another author |
|---|---|---|---|
| id | 9 | 17 | 15 |
| title | 帅哥 | ai 代码教学 | Self Introduction |
| authorId | 019fde7d-f98c-7c6b-92fc-8fefaa5a1f64 | same | 01a0dd66-1c1b-7087-b187-1873040b5c95 |
| authorName | testing1 | testing1 | 時紡識 |
| description | 哈哈 | hai | Self Introduction |
| category | 城市 | 技术 | 语言 |
| languageCode | not in response | auto | ja |
| status | published | published | published |
| isPublic (live response) | true | true | true |
| createdAt / publishedAt (UTC) | 2026-08-14 06:44:16.741688 | 2026-09-26 14:39:17.658103 | 2026-09-26 13:31:28.168024 |
| Returned by the public API | yes | yes | yes |
| Video / cover HEAD | 200/200 | 200/200 | 200/200 |

URLs are not Video table fields. The table stores `videoStorageKey` and `coverStorageKey`, and `getVideoUrl` resolves them. The full keys and the URLs with signing query parameters removed are in the JSON.

Complete business fields of the local schema: id, authorId, authorName, title, description, category, contentType, languageCode, tags, videoStorageKey, coverStorageKey, durationSeconds, viewCount, likeCount, favoriteCount, commentCount, status, publishedAt, createdAt, updatedAt.

The local schema has no ownerId / userId / type / visibility / isPublic / published / moderationStatus / processingStatus / deleted / isDeleted / videoUrl / thumbnailUrl field. The live API returned none of these extra fields **except isPublic**. A field missing from the API does not prove that the live database lacks the column.

## Data storage and publishing lifecycle

Metadata lives in the Serverpod PostgreSQL `video` table. Videos and covers live in the Google Cloud Storage bucket `glyphora-video-storage-11129163384`, registered as `public`. This video path does not use Firebase or Firestore.

`CreateVideoPage` → `VideoUploadQueueNotifier` → FFmpeg prepares the video and cover → `ServerpodVideoRepository.createVideo` → request an upload description → upload to GCS → verifyUpload → `client.video.create` → `VideoEndpoint.create` → `Video.db.insertRow`.

The backend uses the authenticated session's userIdentifier as authorId and ignores any authorId sent by the client. On creation it sets `published` and publishedAt / createdAt directly. It then creates an ASR job and processes subtitles. The ASR states (processing / readyForReview / failed) are in another table, not Video.status, and are not a gate for the public feed. The app shows upload success only after create and the URL conversion have returned.

Videos 9, 17, and 15 were published; there is no evidence of a missing publishedAt or of being stuck as pending. The upload mechanism was not changed and these live records were not forcibly modified.

## The three query paths

| Entry | Call chain | Original filter | Ordering / other behavior |
|---|---|---|---|
| My submissions | MySubmissionsPage → myPublishedVideosProvider → loadUserVideos → client.video.getVideos() → VideoEndpoint.getVideos → Video.db.find | The API had no filter; Flutter filtered authorId == signed-in user id | createdAt descending; URLs resolved one by one |
| Home / recommended | HomePage → homeProvider → allPublishedVideosProvider → loadPublishedVideos(video) → client.video.getVideos(video) → VideoEndpoint.getVideos → Video.db.find | contentType == video; HomeNotifier then filters by the selected category | createdAt descending; real videos before mock cards, featured is still mock |
| Short | DiscoverPage → publishedShortsProvider → loadPublishedVideos(short) → client.video.getVideos(short) → VideoEndpoint.getVideos → Video.db.find | contentType == short; the page then filters by category | createdAt descending; URLs resolved one by one |

`getMyVideos` is an existing backend query for the authenticated author, but Flutter's loadUserVideos currently serves both the author profile and the profile page, so it cannot be replaced wholesale by getMyVideos; other authors' profile pages would wrongly show the current user's submissions. The call semantics were therefore kept.

After the fix, the local getVideos additionally requires `status == published` and does not filter by viewer. getVideo exposes non-published content only to the author. getMyVideos still lets an author query their own processing or failed content. No unfiltered whole-table public API was added and authentication rules were not changed.

**Deployment limit: the live service already has `isPublic` semantics and the local code does not. Obtain the live source or migration and align it before releasing the backend. The local status filter must not be treated as complete protection of private content.** The backend was not deployed, live permissions were not changed, and no claim is made that private / draft states, which do not exist in the local schema, were tested. The existing GCS storage is public; the private storage design for non-public media is outside this change.

## Cache, pagination, and error handling

- There is no on-disk feed cache and no pagination cursor / offset / limit, so there is no code path that fetches only one page and misses new videos. In the live result, ID 17 is first and the chronological order is normal.
- The public FutureProviders originally depended only on a long-lived repository / client; switching accounts did not invalidate them.
- MainPage uses an IndexedStack, so Home and Short are built ahead of time and stay mounted. If B stays in the app while A publishes, B's providers are not notified.
- A successful publish invalidates only the providers on the publisher's device, so the author is more likely to see their own new submission promptly.
- The original per-item URL resolution used `catch (_)`, which swallowed every exception, and a failed cover resolution made the whole video disappear. That can explain "some cards visible" without any error message or reason for exclusion.
- The home page still contains demo data, but `_loadFeed` does merge public videos, so seeing MockHomeRepository alone does not justify claiming the home page is not connected to the backend. No unrelated UI refactoring was done.

Changes: the public feed and detail now depend on the current account id; changing accounts triggers a new request while anonymous public reads remain allowed. Switching back to Home / Short refetches. Short's pull-to-refresh waits for the request to complete. A failed cover keeps the playable video; an old video with a clearly missing URL can be excluded and the reason logged; network / API errors while resolving a video URL propagate as errors instead of being disguised as an empty list.

## Logging and re-checking

Backend: POST_CREATED (id, owner, contentType, status, storage key, time); FEED_REQUEST (viewer, the real filter, ordering, returned count). The local schema has no visibility, so visibility=public is not fabricated. The storage key is logged rather than a signed URL that may carry credentials.

Flutter: FEED_CLIENT (API address, build revision); FEED_REQUEST; FEED_RESPONSE (counts, IDs); FEED_EXCLUDED (id, clearly missing URL); FEED_FAILED (id, exception type); THUMBNAIL_UNAVAILABLE.

Tokens, passwords, raw exception text, and signed URLs are not logged. Debug builds enable this by default; release builds must enable it explicitly:

```powershell
cd apps/clyven_app
flutter build apk --release --dart-define=CLYVEN_FEED_DIAGNOSTICS=true --dart-define=CLYVEN_BUILD_REVISION=3d38e08-visibility-diagnostic
adb logcat -v time | Select-String 'FEED_|THUMBNAIL_UNAVAILABLE'
```

Read-only comparison against the live service (run from the repository root, no login credentials sent):

```powershell
./tool/audit_public_feed.ps1
```

If the phone's FEED_RESPONSE does not contain 17, check the address it actually connects to, failed requests or stale caches, and the deployed version. If it contains 17 but FEED_EXCLUDED / FEED_FAILED appear, locate the cause from the URL resolution failure. If the record maps successfully but is not shown, check the current category and page state. If it shows but cannot play, check the device network and player errors. This separates the record query from media playback.

## Verification results

- dart format: the Dart files touched were formatted.
- flutter analyze --no-pub (apps/clyven_app): No issues found.
- flutter test --no-pub (apps/clyven_app): 6 passed.
- dart analyze (backend): 0 errors, 0 warnings; 52 existing infos from the dictionary scripts, server.dart, and subtitle_endpoint.dart, none in the files changed here.
- dart test (backend): 4 passed (the existing greeting test plus 3 visibility integration tests).
- Database tests use an isolated local PostgreSQL, real Serverpod endpoints, and real database queries; A and B are Serverpod test authentication sessions. They cover A→B Video, A→B Short, B→A Video / Short, author isolation, non-published status filtering, and detail permissions. Each test transaction rolls back automatically.
- The integration tests do not include real phone sign-in, MP4 upload, GCS, or ASR; a missing-media fixture avoids external ASR calls. They must not be described as live two-phone end-to-end tests.
- New Flutter tests verify the two kinds of feed after switching accounts, a cover 503 keeping the record, a video URL 503 surfacing as an error, and exclusion of a missing URL. The HTTP tests call a local test HTTP service through the real generated Serverpod client.
- The live media check was an anonymous HEAD returning 200, not MP4 playback with a real B login. It shows the tested resources can be read without A's credentials; it does not guarantee that the phone's network can reach them or that decoding succeeds.
- The release APK build failed with a Gradle / JDK `java.io.IOException: Unable to establish loopback connection`, underlying `UnixDomainSockets.connect0 / Invalid argument: connect`. Retrying with a shorter JVM temp directory still failed; no new APK was produced.

## Files changed

- apps/clyven_app/lib/core/serverpod/feed_diagnostics.dart
- apps/clyven_app/lib/core/serverpod/serverpod_client_provider.dart
- apps/clyven_app/lib/features/video/data/repositories/serverpod_video_repository.dart
- apps/clyven_app/lib/features/video/presentation/providers/video_detail_provider.dart
- apps/clyven_app/lib/features/home/presentation/pages/main_page.dart
- apps/clyven_app/lib/features/home/presentation/pages/discover_page.dart
- server/clyven_backend_server/lib/src/endpoints/video_endpoint.dart
- apps/clyven_app/test/feed_account_switch_test.dart
- apps/clyven_app/test/serverpod_feed_repository_test.dart
- server/clyven_backend_server/test/integration/video_visibility_test.dart
- tool/audit_public_feed.ps1
- docs/en/video-visibility-investigation-2026-09-26.md

Still needed: run the failing APK or connect the phone to collect logs and determine the APK's root cause; align the live backend protocol and the `isPublic` permission implementation; complete a real A/B two-phone re-test. The existing fixes apply to the local Video and Short data paths, but they cannot fix the fact that the old live backend still running does not support contentType.

## Inspection after the user supplied the APK

- File: `Downloads/app-release.apk`, 140179895 bytes.
- SHA256: `0D5587C0E1C5775410FBF87CCBBF9C3D95A1AD8797C29948C9BA1853FB31A8D1`.
- Package name: `com.example.clyven`; versionName `1.0.0`, versionCode `1`; minSdk 24, targetSdk 36.
- The manifest contains the INTERNET and ACCESS_NETWORK_STATE permissions. No custom networkSecurityConfig was found; cleartext is allowed. There is no evidence that the release build lacks a networking permission.
- It contains native libraries for arm64-v8a, armeabi-v7a, and x86_64. Both the ARM64 and x86_64 `libapp.so` contain the same live address, `https://glyphora-server-11129163384.asia-southeast1.run.app/`, matching the target of this public API check. A compile-time constant only proves the address is in the package; it is no substitute for capturing runtime requests.
- The package contains strings such as ServerpodVideoRepository, loadPublishedVideos, getVideos, and getVideoUrl. A Flutter release build is an AOT-compiled file, so the specific filter conditions cannot be reconstructed from strings alone.
- The diagnostic strings added in this change, such as FEED_CLIENT and FEED_REQUEST, were not found. This alone cannot show the APK was built from old source: a release build without the diagnostics flag has them removed by the compiler.
- The APK's `META-INF/version-control-info.textproto` says `generate_error_reason: NO_SUPPORTED_VCS_FOUND`, so there is no verifiable source commit. File times inside the ZIP are normalized to 1981; the downloaded file's modification time is not a reliable build time.
- The string `isPublic` is present in the AOT library, but it cannot be determined from that alone whether it belongs to the Video model, so it is not taken as proof of a schema difference in the APK.

This APK inspection did not modify the user's installation package, and found no static evidence sufficient to confirm the root cause of the phone missing new videos.

An attempt was made to run the APK in a temporary read-only, snapshot-free, windowless instance (emulator-5580) of the `Small_Phone` AVD. During start-up of the Android SDK 37 image the package installer service was not yet available, and the log then showed `com.android.systemui ... failed to complete startup` and an ANR. The APK was therefore not installed or started. This failure belongs to the emulator's system environment and cannot be attributed to Clyven. The temporary instance was shut down and the original AVD's apps and user data were not overwritten.

## User's further confirmation: the video screen keeps spinning after opening

The user stated clearly: the video can be opened, but the playback area keeps spinning; this happens on different phones, except the author's own. **The symptom is now located at player initialization and can no longer be described as a confirmed feed record that is not visible.** The actual runtime difference between the author and the viewers is still not obtained.

Additional read-only checks:

- The live `getVideo(9/15/17)` returns videoStorageKey / coverStorageKey identical to the feed, and the details can be fetched anonymously.
- Reading up to 1 MiB of each of the three MP4 files returned HTTP 206 for all, so Range is supported. All have the layout `ftyp → moov → free → mdat`; the playback index is not at the end of the file.
- 9: H.264 Main (profile 77, level 30), 360×640. 15: H.264 High (100/30), 640×360. 17: H.264 High (100/30), 474×850. All three have an mp4a audio track.
- All three have the Content-Type application/octet-stream, including the known playable 9, so this shared field cannot by itself explain the old/new difference.
- The encoding header differences do not prove decoding failure on a phone, and certainly do not prove a permission difference between users. Upload encoding and transcoding were not changed on this basis, and live media was not overwritten.
- The detail page uses the available value or an empty list for subtitle requests; it does not wait for subtitles before creating the player. The author's submission list and the home page both lead to the same VideoDetailPage / NetworkVideoPlayer. The current source's networkUrl passes no author-specific authentication header.

Player lifecycle defect found and fixed:

- The original `_initializePlayer()` waited indefinitely for initialize / setLooping / seekTo, so the FutureBuilder kept spinning until it finished.
- A 30-second limit now covers the whole initialization; on timeout the existing playback-failure message and a reload action are shown.
- A retry uses a new controller; the old controller is released once, and old requests / events cannot resume or pollute the new instance; leaving the page cancels the timer.
- A native error received after player initialization also shows the failure state; this state was not handled before.
- Logs added: PLAYBACK_INITIALIZING, PLAYBACK_READY, PLAYBACK_INIT_FAILED, and PLAYBACK_NATIVE_ERROR. They include postId, network / file, host, stage, and an allowed error category, and never raw exception text or signed URLs.
- Enabling logs in a release build still needs `--dart-define=CLYVEN_FEED_DIAGNOSTICS=true`. The capture command should also match `PLAYBACK_`.

Added or changed: `network_video_player.dart`, `video_detail_page.dart`, `test/network_video_player_test.dart`, `apps/clyven_app/pubspec.yaml` (explicitly references the existing video_player_platform_interface 6.9.0 used by tests; the runtime player was not upgraded), and `tool/audit_media_headers.py`. The media header evidence is saved as `build/media-header-audit.json`.

Additional verification: all 9 Flutter tests pass, including initialization that never returns, timeout release, a successful retry, late events, a native error after initialization, and leaving during loading. **These tests prove playback no longer waits forever; they do not prove another real account can now play.** Playback logs from a non-author phone, or the result of reading the new video directly in the same phone's browser, are still needed to separate app playback problems from device network or resource-read problems.
