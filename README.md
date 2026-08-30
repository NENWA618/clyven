# Clyven

> A full-stack Flutter + Serverpod video platform monorepo built with Riverpod.

**Clyven** æ˜¯ä¸€ä¸ªä½¿ç”¨ Flutter å¼€å‘çš„è§†é¢‘å¹³å°é¡¹ç›®ã€‚

é¡¹ç›®æ­£åœ¨å®žçŽ°ä»Žç”¨æˆ·è®¤è¯ã€è§†é¢‘æµè§ˆã€æœç´¢ã€æ’­æ”¾ã€æŠ•ç¨¿ï¼Œåˆ°ç‚¹èµžã€è¯„è®ºã€å…³æ³¨ã€è§‚çœ‹åŽ†å²ã€é€šçŸ¥å’Œä¸ªäººä¸»é¡µç­‰å®Œæ•´çš„è§†é¢‘å¹³å°åŠŸèƒ½ã€‚

å®¢æˆ·ç«¯ä½¿ç”¨ **Riverpod** ç®¡ç†çŠ¶æ€ï¼Œå¹¶é€šè¿‡ **Serverpod** ä¸ŽåŽç«¯æœåŠ¡é€šä¿¡ã€‚

---

## Features

### Video

* è§†é¢‘é¦–é¡µ
* è§†é¢‘åˆ—è¡¨
* è§†é¢‘è¯¦æƒ…
* è§†é¢‘æ’­æ”¾
* è§†é¢‘æœç´¢
* è§†é¢‘æŠ•ç¨¿
* æœ¬åœ°è§†é¢‘é€‰æ‹©
* è§†é¢‘æ—¶é•¿è¯»å–
* è§†é¢‘å¤„ç†
* è§†é¢‘åˆ†äº«

### Creator

* åˆ›ä½œè€…ä¸»é¡µ
* å…³æ³¨åˆ›ä½œè€…
* å·²å…³æ³¨åˆ›ä½œè€…åˆ—è¡¨

### Interaction

* ç‚¹èµž
* è¯„è®º
* è§†é¢‘äº’åŠ¨çŠ¶æ€
* åˆ†äº«

### User

* ç”¨æˆ·è®¤è¯
* Auth Gate
* ä¸ªäººä¸»é¡µ
* è§‚çœ‹åŽ†å²
* é€šçŸ¥

### Discovery

* é¦–é¡µæŽ¨è
* å‘çŽ°é¡µé¢
* è§†é¢‘æœç´¢

---

# Tech Stack

## Client

* Flutter
* Dart
* Material UI

## State Management

* Riverpod

## Backend Communication

* Serverpod
* Serverpod Client
* Serverpod Flutter
* Serverpod Auth

## Video

* `video_player`
* `video_duration_native`
* FFmpeg

## Media

* `image_picker`

## Sharing

* `share_plus`

---

# Architecture

å®¢æˆ·ç«¯é‡‡ç”¨ä»¥ Feature ä¸ºå•ä½çš„æ¨¡å—åŒ–ç»“æž„ã€‚

```text
lib/
â”‚
â”œâ”€â”€ core/
â”‚   â””â”€â”€ serverpod/
â”‚
â”œâ”€â”€ features/
â”‚   â”œâ”€â”€ auth/
â”‚   â”œâ”€â”€ comments/
â”‚   â”œâ”€â”€ creator/
â”‚   â”œâ”€â”€ history/
â”‚   â”œâ”€â”€ home/
â”‚   â”œâ”€â”€ notifications/
â”‚   â”œâ”€â”€ profile/
â”‚   â”œâ”€â”€ video/
â”‚   â””â”€â”€ video_interactions/
â”‚
â””â”€â”€ main.dart
```

æ¯ä¸ª Feature æ ¹æ®éœ€è¦ç»§ç»­æ‹†åˆ†ï¼š

```text
feature/
â”œâ”€â”€ data/
â”‚   â”œâ”€â”€ models/
â”‚   â””â”€â”€ repositories/
â”‚
â””â”€â”€ presentation/
    â”œâ”€â”€ pages/
    â”œâ”€â”€ providers/
    â””â”€â”€ widgets/
```

æ•´ä½“æ•°æ®æµå¯ä»¥ç†è§£ä¸ºï¼š

```text
UI
 â”‚
 â–¼
Riverpod Provider
 â”‚
 â–¼
Repository
 â”‚
 â–¼
Serverpod Client
 â”‚
 â–¼
Backend
 â”‚
 â–¼
Database / Video Storage
```

---

# Main Modules

## Authentication

```text
features/auth/
```

è´Ÿè´£ç”¨æˆ·ç™»å½•çŠ¶æ€ä»¥åŠåº”ç”¨å…¥å£è®¤è¯æµç¨‹ã€‚

åº”ç”¨å¯åŠ¨åŽç”±ï¼š

```text
AuthGate
```

å†³å®šç”¨æˆ·åº”è¯¥è¿›å…¥è®¤è¯æµç¨‹è¿˜æ˜¯ä¸»åº”ç”¨ã€‚

---

## Home

```text
features/home/
```

é¦–é¡µæ¨¡å—åŒ…å«ï¼š

```text
home_page.dart
discover_page.dart
main_page.dart
video_search_page.dart
```

è´Ÿè´£ï¼š

* ä¸»å¯¼èˆª
* é¦–é¡µè§†é¢‘å†…å®¹
* å‘çŽ°å†…å®¹
* è§†é¢‘æœç´¢

---

## Video

```text
features/video/
```

è§†é¢‘æ¨¡å—è´Ÿè´£å¹³å°çš„æ ¸å¿ƒè§†é¢‘åŠŸèƒ½ã€‚

ä¸»è¦é¡µé¢ï¼š

```text
create_video_page.dart
video_detail_page.dart
```

åŒ…æ‹¬ï¼š

```text
è§†é¢‘é€‰æ‹©
   â†“
è§†é¢‘å¤„ç†
   â†“
æŠ•ç¨¿
   â†“
ä¸Šä¼ 
   â†“
åŽç«¯åˆ›å»ºè§†é¢‘è®°å½•
   â†“
é¦–é¡µ / æœç´¢
   â†“
è§†é¢‘è¯¦æƒ…
   â†“
è§†é¢‘æ’­æ”¾
```

---

# Video Upload Flow

æŠ•ç¨¿ä¸åªæ˜¯ç®€å•ä¸Šä¼ ä¸€ä¸ªæ–‡ä»¶ã€‚

å½“å‰å®¢æˆ·ç«¯å·²ç»å¼•å…¥ï¼š

* `image_picker`
* `video_duration_native`
* FFmpeg

ç”¨äºŽåª’ä½“é€‰æ‹©ä¸Žè§†é¢‘å¤„ç†ã€‚

æ•´ä½“æµç¨‹è®¾è®¡ä¸ºï¼š

```text
é€‰æ‹©è§†é¢‘
   â”‚
   â–¼
è¯»å–è§†é¢‘ä¿¡æ¯
   â”‚
   â–¼
å‡†å¤‡æŠ•ç¨¿èµ„æ–™
   â”‚
   â–¼
è§†é¢‘å¤„ç†
   â”‚
   â–¼
ä¸Šä¼ 
   â”‚
   â–¼
Serverpod Backend
   â”‚
   â–¼
ä¿å­˜è§†é¢‘æ•°æ®
   â”‚
   â–¼
è§†é¢‘å‘å¸ƒ
```

å¯¹äºŽè¾ƒå¤§çš„è§†é¢‘æ–‡ä»¶ï¼Œä¸Šä¼ å±žäºŽç‹¬ç«‹çš„ä»»åŠ¡æµç¨‹ï¼Œè€Œä¸æ˜¯è¦æ±‚ç”¨æˆ·ä¸€ç›´åœç•™åœ¨æŠ•ç¨¿é¡µé¢ã€‚

---

# Video Playback

é¡¹ç›®ä½¿ç”¨ï¼š

```text
video_player
```

å¤„ç†å®¢æˆ·ç«¯è§†é¢‘æ’­æ”¾ã€‚

è§†é¢‘è¯¦æƒ…é¡µè´Ÿè´£æ•´åˆï¼š

```text
è§†é¢‘æ’­æ”¾
+
è§†é¢‘ä¿¡æ¯
+
ä½œè€…ä¿¡æ¯
+
äº’åŠ¨çŠ¶æ€
+
è¯„è®º
```

å½¢æˆå®Œæ•´çš„è§†é¢‘è§‚çœ‹é¡µé¢ã€‚

---

# Comments

```text
features/comments/
```

è¯„è®ºä½œä¸ºç‹¬ç«‹ Feature ç®¡ç†ã€‚

ç»“æž„åŒ…å«ï¼š

```text
data/
presentation/
```

ä½¿è¯„è®ºçš„æ•°æ®è¯·æ±‚ã€çŠ¶æ€å’Œç•Œé¢ä¸Žè§†é¢‘ä¸»ä½“æ¨¡å—ä¿æŒè§£è€¦ã€‚

---

# Video Interactions

```text
features/video_interactions/
```

äº’åŠ¨é€»è¾‘ä¸Žè§†é¢‘å†…å®¹æœ¬èº«åˆ†ç¦»ã€‚

è¯¥æ¨¡å—ç”¨äºŽç®¡ç†è§†é¢‘ç›¸å…³ç”¨æˆ·è¡Œä¸ºï¼Œä¾‹å¦‚ï¼š

```text
Like
Follow
Interaction State
```

è¿™ç§æ‹†åˆ†å¯ä»¥é¿å…æŠŠæ‰€æœ‰é€»è¾‘é›†ä¸­åœ¨ `video_detail_page.dart` ä¸­ã€‚

---

# Creator

```text
features/creator/
```

åˆ›ä½œè€…æ¨¡å—åŒ…å«ï¼š

```text
creator_profile_page.dart
following_creators_page.dart
```

ç”¨äºŽå±•ç¤ºåˆ›ä½œè€…èµ„æ–™ä»¥åŠç”¨æˆ·å·²ç»å…³æ³¨çš„åˆ›ä½œè€…ã€‚

---

# History

```text
features/history/
```

è´Ÿè´£ä¿å­˜å’Œå±•ç¤ºç”¨æˆ·çš„è§†é¢‘è§‚çœ‹åŽ†å²ã€‚

---

# Notifications

```text
features/notifications/
```

ç”¨äºŽé›†ä¸­å¤„ç†å¹³å°é€šçŸ¥ç›¸å…³åŠŸèƒ½ã€‚

æœªæ¥å¯ä»¥ç»§ç»­æ‰©å±•ï¼š

```text
Like Notification
Comment Notification
Follow Notification
Creator Notification
System Notification
```

---

# Profile

```text
features/profile/
```

è´Ÿè´£ç”¨æˆ·è‡ªå·±çš„èµ„æ–™åŠç›¸å…³ä¸ªäººåŠŸèƒ½ã€‚

---

# Serverpod

å®¢æˆ·ç«¯é€šè¿‡ï¼š

```text
serverpod_client
serverpod_flutter
serverpod_auth_idp_flutter
```

è¿žæŽ¥åŽç«¯ã€‚

Serverpod Client Provider ä½äºŽï¼š

```text
lib/core/serverpod/serverpod_client_provider.dart
```

å› æ­¤ä¸šåŠ¡æ¨¡å—ä¸éœ€è¦è‡ªè¡Œåˆ›å»ºåŽç«¯ Clientï¼Œè€Œæ˜¯é€šè¿‡ç»Ÿä¸€ Provider èŽ·å–è¿žæŽ¥ã€‚

---

# Monorepo

Clyven now uses a single-repository Flutter + Serverpod architecture.

```text
clyven/
|-- apps/
|   `-- clyven_app/
|-- packages/
|   `-- clyven_backend_client/
|-- server/
|   `-- clyven_backend_server/
|-- pubspec.yaml
`-- pubspec.lock
```

The Flutter app, generated Serverpod client, and Serverpod backend are managed by one Dart workspace:

```yaml
workspace:
  - apps/clyven_app
  - packages/clyven_backend_client
  - server/clyven_backend_server
```

The backend and generated client no longer need to be cloned as separate repositories.

---
# Getting Started

## 1. Clone

```bash
git clone https://github.com/chengyang1017/clyven.git
cd clyven
```

## 2. Install Workspace Dependencies

From the repository root:

```bash
dart pub get
```

## 3. Generate Serverpod Code

```bash
cd server/clyven_backend_server
serverpod generate
cd ../..
```

## 4. Run Backend

```bash
cd server/clyven_backend_server
dart run bin/main.dart --apply-migrations
```

## 5. Run Flutter App

In another terminal:

```bash
cd apps/clyven_app
flutter run
```

## 6. Validate

Flutter app:

```bash
cd apps/clyven_app
flutter test
flutter analyze
```

Generated client:

```bash
cd packages/clyven_backend_client
dart analyze
```

Backend:

```bash
cd server/clyven_backend_server
dart analyze
dart test
```

---
# Project Structure

```text
clyven/
â”‚
â”œâ”€â”€ lib/
â”‚   â”‚
â”‚   â”œâ”€â”€ core/
â”‚   â”‚   â””â”€â”€ serverpod/
â”‚   â”‚       â””â”€â”€ serverpod_client_provider.dart
â”‚   â”‚
â”‚   â”œâ”€â”€ features/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ auth/
â”‚   â”‚   â”‚   â”œâ”€â”€ data/
â”‚   â”‚   â”‚   â””â”€â”€ presentation/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ comments/
â”‚   â”‚   â”‚   â”œâ”€â”€ data/
â”‚   â”‚   â”‚   â””â”€â”€ presentation/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ creator/
â”‚   â”‚   â”‚   â”œâ”€â”€ data/
â”‚   â”‚   â”‚   â””â”€â”€ presentation/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ history/
â”‚   â”‚   â”‚   â”œâ”€â”€ data/
â”‚   â”‚   â”‚   â””â”€â”€ presentation/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ home/
â”‚   â”‚   â”‚   â””â”€â”€ presentation/
â”‚   â”‚   â”‚       â”œâ”€â”€ pages/
â”‚   â”‚   â”‚       â”œâ”€â”€ providers/
â”‚   â”‚   â”‚       â””â”€â”€ widgets/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ notifications/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ profile/
â”‚   â”‚   â”‚
â”‚   â”‚   â”œâ”€â”€ video/
â”‚   â”‚   â”‚   â”œâ”€â”€ data/
â”‚   â”‚   â”‚   â””â”€â”€ presentation/
â”‚   â”‚   â”‚
â”‚   â”‚   â””â”€â”€ video_interactions/
â”‚   â”‚       â”œâ”€â”€ data/
â”‚   â”‚       â””â”€â”€ presentation/
â”‚   â”‚
â”‚   â””â”€â”€ main.dart
â”‚
â”œâ”€â”€ android/
â”œâ”€â”€ ios/
â”œâ”€â”€ linux/
â”œâ”€â”€ macos/
â”œâ”€â”€ web/
â”œâ”€â”€ windows/
â”‚
â””â”€â”€ pubspec.yaml
```

---

# State Management

åº”ç”¨å…¥å£ä½¿ç”¨ï¼š

```dart
ProviderScope
```

åŒ…è£…æ•´ä¸ªåº”ç”¨ï¼š

```text
ProviderScope
     â”‚
     â–¼
ClyvenApp
     â”‚
     â–¼
AuthGate
     â”‚
     â–¼
Application
```

å„ä¸ª Feature å¯ä»¥æ‹¥æœ‰è‡ªå·±çš„ Providerï¼Œå¹¶é€šè¿‡ Riverpod ç®¡ç†ï¼š

```text
Loading
Data
Error
User Actions
```

é¿å…è®©é¡µé¢ Widget ç›´æŽ¥æ‰¿æ‹…æ•°æ®è¯·æ±‚å’Œä¸šåŠ¡çŠ¶æ€ã€‚

---

# Design Direction

è¿™ä¸ªé¡¹ç›®ä¸æ˜¯å•ç‹¬å®žçŽ°ä¸€ä¸ªï¼š

```text
VideoPlayer
```

è€Œæ˜¯åœ¨é€æ­¥å®žçŽ°å®Œæ•´çš„è§†é¢‘å¹³å°ç»“æž„ï¼š

```text
Authentication
      â”‚
      â–¼
Video Feed
      â”‚
 â”Œâ”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”
 â–¼    â–¼     â–¼
Search Video Creator
      â”‚
      â–¼
Video Detail
      â”‚
 â”Œâ”€â”€â”€â”€â”¼â”€â”€â”€â”€â”€â”€â”€â”€â”
 â–¼    â–¼        â–¼
Like Comment Follow
      â”‚
      â–¼
History / Notifications / Profile
```

å‰ç«¯åŠŸèƒ½æŒ‰ç…§ä¸šåŠ¡é¢†åŸŸæ‹†åˆ†ï¼Œä½¿åŽç»­ç»§ç»­å¢žåŠ åŠŸèƒ½æ—¶èƒ½å¤Ÿä¿æŒä»£ç ç»“æž„æ¸…æ™°ã€‚

---

# Roadmap

* [x] Flutter å®¢æˆ·ç«¯åŸºç¡€ç»“æž„
* [x] Riverpod çŠ¶æ€ç®¡ç†
* [x] Serverpod Client é›†æˆ
* [x] ç”¨æˆ·è®¤è¯å…¥å£
* [x] é¦–é¡µç»“æž„
* [x] å‘çŽ°é¡µé¢
* [x] è§†é¢‘æœç´¢
* [x] è§†é¢‘è¯¦æƒ…
* [x] è§†é¢‘æ’­æ”¾
* [x] è§†é¢‘æŠ•ç¨¿åŸºç¡€æµç¨‹
* [x] è¯„è®ºæ¨¡å—
* [x] åˆ›ä½œè€…æ¨¡å—
* [x] è§†é¢‘äº’åŠ¨æ¨¡å—
* [x] åŽ†å²æ¨¡å—
* [x] é€šçŸ¥æ¨¡å—
* [x] ä¸ªäººèµ„æ–™æ¨¡å—
* [ ] å®Œå–„å¤§åž‹è§†é¢‘ä¸Šä¼ æµç¨‹
* [ ] å®Œå–„æŠ•ç¨¿ä»»åŠ¡ç®¡ç†
* [ ] å®Œå–„è§†é¢‘å¤„ç†ä¸Žå°é¢æµç¨‹
* [ ] å®Œå–„æŽ¨èç³»ç»Ÿ
* [ ] å®Œå–„é€šçŸ¥ç³»ç»Ÿ
* [ ] å®Œå–„æ’­æ”¾ä½“éªŒ
* [ ] å®Œå–„é”™è¯¯æ¢å¤ä¸Žç½‘ç»œçŠ¶æ€å¤„ç†
* [ ] å®Œå–„ç”Ÿäº§çŽ¯å¢ƒéƒ¨ç½²

---

# Status

This project is currently under active development.

çŽ°é˜¶æ®µé‡ç‚¹æ˜¯å»ºç«‹è§†é¢‘å¹³å°çš„å®Œæ•´å®¢æˆ·ç«¯æž¶æž„ä¸Ž Serverpod åŽç«¯é€šä¿¡æµç¨‹ã€‚

éƒ¨åˆ†åŠŸèƒ½ä»å¤„äºŽå¼€å‘å’Œå®Œå–„é˜¶æ®µï¼Œä¸ä»£è¡¨ç”Ÿäº§çŽ¯å¢ƒæœ€ç»ˆå®žçŽ°ã€‚

---

# Author

**Cheng Yang**

A Flutter video platform project exploring modular client architecture, Riverpod state management, Serverpod backend integration, media processing, and scalable video platform features.

> From video playback to a complete video platform.
