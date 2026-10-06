# Push Notifications

**English** | [简体中文](../zh-CN/push-notifications.md)

System-level push notifications for likes, comments, and follows, delivered through Firebase Cloud Messaging (FCM). FCM covers both Android and iOS (iOS delivery goes through Apple's APNs behind FCM).

Status: implemented on the server and in the app. Nothing is delivered until Firebase is configured; see the [owner checklist](owner-checklist.md#1-firebase-console).

## How it works

```text
User A likes / comments on / follows User B
        │
        ▼
createNotification()            inserts the in-app notification row
        │
        ▼
Respect B's settings            push master switch, plus like / comment / follow switches
        │
        ▼
PushService                     looks up B's registered devices
        │
        ▼
FCM HTTP v1                     one message per device, in that device's language
        │
        ▼
B's phone shows the notification; tapping it opens the video
```

## Server

* **Table `device_token`**: `userId`, `token` (unique), `platform`, `languageCode` (default `en`), `updatedAt`. Migrations: `add-device-token` and `device-token-language`.
* **Endpoint `pushDevice`**:
  * `register(token, platform, languageCode)` binds a token to the signed-in user. A token belongs to exactly one user, so it moves to the new user when someone else signs in on the same device.
  * `unregister(token)` removes it.
* **`PushService`** (`lib/src/services/push_service.dart`) authenticates with a Google service account (`googleapis_auth`) and calls the FCM HTTP v1 API. Dead tokens (HTTP 404, or a 400 containing `UNREGISTERED`) are deleted automatically. Failures are logged and never thrown, so a push problem cannot break a like or a comment.
* **`notification_service.dart`** sends the push after inserting the notification, unless the call runs inside a database transaction (the row would not be committed yet).
* **Localization**: the text is chosen per device from `languageCode`. Simplified Chinese (`zh`) and English are provided and mirror the app's own notification strings; any other language falls back to English. Add new languages in `_pushMessage` at the end of `notification_service.dart`.
* **Secret**: the Serverpod password `fcmServiceAccountJson` holds the full service-account JSON. If it is missing, pushing is a silent no-op, so local development still works.

## App

* `lib/core/push/push_notifications.dart` initializes Firebase, asks for notification permission, listens for token refreshes, and handles taps (a notification carrying a `videoId` opens that video through `openGlobalVideo`).
* `lib/main.dart` registers the device after sign-in and again whenever the in-app language changes, sending the effective language (`zh` or `en`; "follow system" uses the system language).
* `AuthNotifier.logout` unregisters the device before signing out, because the call needs the live session.
* If the Firebase config files are missing, initialization fails quietly and push is disabled. The in-app notification feed keeps working.
* Android: the `POST_NOTIFICATIONS` permission (required from Android 13), and the Google Services Gradle plugin, which is applied only when `google-services.json` exists so builds without Firebase keep working.
* iOS: `Runner.entitlements` with `aps-environment`, and the `remote-notification` background mode.

## Limitations

* FCM needs Google services. Android phones without them (typical in mainland China) will not receive pushes. A vendor-channel or aggregator service would be needed for that audience.
* Push text for comments is the comment preview and is not translated.
* The `aps-environment` entitlement is `development`. Change it to `production` before an App Store release.

## Key files

* `server/backend_server/lib/src/models/device_token.spy.yaml`
* `server/backend_server/lib/src/endpoints/push_device_endpoint.dart`
* `server/backend_server/lib/src/services/push_service.dart`
* `server/backend_server/lib/src/services/notification_service.dart`
* `apps/app/lib/core/push/push_notifications.dart`
* `apps/app/lib/main.dart`
