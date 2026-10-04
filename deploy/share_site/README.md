# Share site (Firebase Hosting)

**English** | [简体中文](README.zh-CN.md)

Hosts the `https://share.glyphora.net/v/<videoId>` page used by shared videos, plus the domain-verification files that let phones open those links inside the app.

Before deploying, fill in:

- `public/.well-known/assetlinks.json`: SHA-256 fingerprint of the app signing certificate
- `public/.well-known/apple-app-site-association`: Apple Team ID
- store URLs in `public/v/index.html` (optional, once the app is published)

Deploy: run `firebase deploy --only hosting` from this folder.

The domain must match `CLYVEN_SHARE_BASE_URL` (default `https://share.glyphora.net`), the intent filter in `AndroidManifest.xml`, and the `applinks:` entry in `ios/Runner/Runner.entitlements`.

The full setup steps are in the [owner checklist](../../docs/en/owner-checklist.md).
