# Owner Checklist

**English** | [简体中文](../zh-CN/owner-checklist.md)

The code for picture-in-picture, push notifications, and share links is written. What remains is configuration that only the project owner can do: accounts, keys, DNS, and device testing. Work through the sections in order and tick the boxes.

Related documents: [Picture-in-picture](picture-in-picture.md), [Push notifications](push-notifications.md), [Share links](share-links.md).

**Never commit** the Firebase service-account JSON, the Apple `.p8` key, or `config/passwords.yaml`.

## 0. Decisions to make first

- [ ] **Application ID / bundle ID.** The app still uses the example `com.example.glyphora` on both platforms. Google Play does not accept IDs starting with `com.example`. If you plan to publish, change it now: the Android `applicationId` and `namespace`, the iOS bundle identifier, the Firebase apps, `google-services.json`, `GoogleService-Info.plist`, and both verification files in section 3 all depend on it. Changing it later means redoing those steps.
- [ ] **Share domain.** The code uses `share.glyphora.net`. Keep it, or pick another subdomain and update the three places listed in [Share links](share-links.md#why-a-dedicated-subdomain).

Push notifications and share links do **not** require a Google Play listing; they work with sideloaded builds. Costs: FCM and Firebase Hosting are free at this scale. The only paid items are the Apple Developer Program (about 99 USD per year, needed for iOS push) and, only if you publish on Android, a Google Play developer account (one-time 25 USD). Check the Firebase console's usage and billing page for current terms.

## 1. Firebase console

- [ ] Open the [Firebase console](https://console.firebase.google.com), choose "Add project", and select your existing Google Cloud project `glyphora-video`. Using the same project keeps Firebase next to the backend.
- [ ] Add an **Android app** with the package name from section 0 (currently `com.example.glyphora`). Download `google-services.json` and place it at `apps/app/android/app/google-services.json`.
- [ ] Add an **iOS app** with the same bundle ID. Download `GoogleService-Info.plist` and keep it for section 2.
- [ ] Open Project settings → Service accounts → "Generate new private key" and download the JSON. This is the key the server uses to send pushes. Keep it private; it is used in section 4.

## 2. Apple Developer and Xcode (iOS only)

Requires a paid Apple Developer account and a Mac.

- [ ] In Certificates, Identifiers & Profiles → Identifiers, open the app's identifier and enable **Push Notifications** and **Associated Domains**, then save.
- [ ] Under Keys, create a key with **Apple Push Notifications service (APNs)** enabled and download the `.p8` file. It can only be downloaded once. Note the Key ID and your Team ID.
- [ ] In the Firebase console, open Project settings → Cloud Messaging → iOS app configuration and upload the `.p8`, entering the Key ID and Team ID.
- [ ] Open `apps/app/ios/Runner.xcworkspace` in Xcode. Drag `GoogleService-Info.plist` into the Runner group, tick "Copy items if needed" and the Runner target.
- [ ] In Runner → Signing & Capabilities, confirm Push Notifications, Associated Domains, and Background Modes (Audio, and Remote notifications) are present. Add any that are missing.

## 3. Share site and domain

The share landing page and verification files live in `deploy/share_site`, hosted on Firebase Hosting.

- [ ] In the Firebase console open Hosting and choose "Add custom domain". Enter `share.glyphora.net`.
- [ ] In your DNS provider add the records Firebase shows (a TXT verification record and an A record or CNAME). This only affects the `share` subdomain; the root domain and `www` are untouched.
- [ ] Wait for Firebase to issue the HTTPS certificate (minutes to hours).
- [ ] Fill in `deploy/share_site/public/.well-known/assetlinks.json`: replace `REPLACE_WITH_SIGNING_CERT_SHA256` with the SHA-256 fingerprint of the certificate that signs the Android app.
  * Debug builds: `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android`
  * Play-signed releases: use the fingerprint shown in Play Console → App integrity.
- [ ] Fill in `deploy/share_site/public/.well-known/apple-app-site-association`: replace `REPLACE_WITH_TEAM_ID` with your Apple Team ID.
- [ ] Deploy: from `deploy/share_site` run `firebase deploy --only hosting`.
- [ ] Optional, once the app is published: put the store URLs into the two variables at the top of the script in `deploy/share_site/public/v/index.html` so the store buttons appear.

## 4. Server

- [ ] Add the service-account JSON from section 1 as the Serverpod password `fcmServiceAccountJson`.
  * Local development: in `server/backend_server/config/passwords.yaml`, under `shared:`, as a single-line JSON string.
  * Cloud Run: store the JSON in Secret Manager and expose it to the service as the environment variable `SERVERPOD_PASSWORD_fcmServiceAccountJson`.
- [ ] Grant the Cloud Run runtime service account the **Secret Manager Secret Accessor** role on that secret.
- [ ] Deploy the server and start it with `--apply-migrations` so the `device_token` table and its `languageCode` column are created (two migrations).

## 5. Verify on devices

Use physical devices. The iOS simulator cannot receive push or show picture-in-picture.

Push notifications:

- [ ] After signing in, the notification permission prompt appears; allow it.
- [ ] The `device_token` table gains a row, with `languageCode` set to `zh` or `en`.
- [ ] From a second account, like one of the first account's videos: the first phone receives a push, in the foreground and in the background.
- [ ] Tapping the push opens the right video.
- [ ] Switching the in-app language changes the language of the next push.
- [ ] Turning off the push master switch, or one notification type, stops the matching pushes.
- [ ] If nothing arrives, check the server log for `FCM send failed` and its status code. Typical causes: the secret is missing or truncated, the service account belongs to a different Firebase project, the APNs key was not uploaded, or the device has no Google services.

Share links:

- [ ] Sharing a video produces a `https://share.glyphora.net/v/<id>` link.
- [ ] Tapping the link on a phone with the app opens the video in the app. Without the verification files filled in, it opens the landing page first and the "Open in Glyphora" button opens the app.
- [ ] On a phone without the app, the landing page shows.

Picture-in-picture:

- [ ] Android 12 or later: play a video on the detail page, press Home, and a floating window continues playback.
- [ ] Android 8 to 11: the same, if you have such a device.
- [ ] iOS: the same on a real iPhone. Also check the mini-player transition and the subtitle overlay for stutter, because iOS now renders these videos through a platform view.
- [ ] Closing the floating window pauses playback.

## 6. Before a store release

- [ ] Change `aps-environment` in `apps/app/ios/Runner/Runner.entitlements` from `development` to `production`.
- [ ] Replace the example application ID if you have not already (section 0).
- [ ] Put the production signing fingerprint into `assetlinks.json` and redeploy the share site.

## Known limitations

* FCM does not work on Android phones without Google services (common in mainland China). Reaching that audience needs a vendor-channel or aggregator push service.
* Shared-link previews in chat apps are generic, not per video.
* Push text exists in Simplified Chinese and English only; other languages fall back to English.
