# Share Links

**English** | [简体中文](../zh-CN/share-links.md)

Sharing a video produces a normal web link. Tapping it on a phone with the app installed opens the video inside the app. Previously the app shared the raw video file URL, so tapping it downloaded the file.

Status: implemented. Links work end to end only after the share site is deployed and verified; see the [owner checklist](owner-checklist.md#3-share-site-and-domain).

## Link format

```text
https://share.glyphora.net/v/<videoId>      verified web link
clyven://video/<videoId>                     app-scheme fallback
```

The share text is the video title, the author name, and the link.

## How it works

1. The user taps share in the app. The text contains `https://share.glyphora.net/v/<videoId>`.
2. A recipient taps the link:
   * **App installed and the domain verified**: Android App Links / iOS Universal Links open the app directly. `DeepLinkHandler` (the `app_links` package) extracts the video id and calls `openGlobalVideo`. This works on a cold start and while the app is running.
   * **Otherwise**: the browser shows the landing page, which tries `clyven://video/<id>` once on phones and also offers an "Open in Clyven" button and, once configured, store buttons.
3. Whether the video can be watched is still decided by the app's existing logic. The link does not expose the media file URL.

## Why Firebase Hosting

The backend runs on Cloud Run, which exposes only the API port, and the API server cannot host custom web routes. The landing page and the verification files are therefore static files on Firebase Hosting (`deploy/share_site`).

## Why a dedicated subdomain

Android and iOS fetch the verification files (`/.well-known/assetlinks.json` and `/.well-known/apple-app-site-association`) **without following redirects**. The root domain redirects to `www` with a 308, and `www` hosts the main website, so neither can be used. The share site lives on its own subdomain, `share.glyphora.net`.

If you change the host, update all of these together:

* `ShareLinks.baseUrl` default in `apps/clyven_app/lib/core/sharing/share_links.dart` (or pass `--dart-define=CLYVEN_SHARE_BASE_URL=...`)
* the `android:host` of the https intent filter in `AndroidManifest.xml`
* the `applinks:` entry in `ios/Runner/Runner.entitlements`

## Limitations

* The link preview shown by chat apps is generic ("Clyven"), not the specific video's title and cover. The landing page is static and crawlers do not run JavaScript. A dynamic page (for example Cloud Functions) would be needed for per-video previews.
* Until the verification files are filled in, links open the landing page first and the app is launched from its button.
* The package name is still the example `com.example.clyven`. Changing it requires updating both verification files and the Firebase apps.

## Key files

* `apps/clyven_app/lib/core/sharing/share_links.dart` (building and parsing links)
* `apps/clyven_app/lib/core/sharing/deep_link_handler.dart`
* `apps/clyven_app/android/app/src/main/AndroidManifest.xml` (intent filters)
* `apps/clyven_app/ios/Runner/Info.plist` (URL scheme) and `Runner.entitlements` (associated domain)
* `deploy/share_site/` (Firebase Hosting site)
* `apps/clyven_app/test/core/share_links_test.dart`
