# 视频播放流量优化真机验收记录

[English](../en/playback-traffic-validation-2026-10-04.md) | **简体中文**

**日期：2026-10-04**  
**测试脚本：Clyven Playback Traffic Verification v6**  
**平台：Android 真机**  
**包名：`com.example.clyven`**

## 验收结论

本轮真机测试成功。

Clyven 第一阶段视频播放流量优化的核心行为已经通过验证，可以确认以下机制已真实运行，而不是仅停留在代码实现层：

- HLS 播放链路正常
- 本地媒体缓存机制工作
- 已出现真实 HLS Segment 缓存命中
- 字幕片段直接复用原视频时间轴播放
- 单句循环正常工作
- Shorts 快速滑动时旧播放器会释放
- 下一条 Shorts Manifest 预热正常
- App 进入后台时播放器会暂停
- 播放诊断与缓存诊断日志正常输出

## 真机日志结果

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

## 本地缓存证据

测试中出现：

```text
PLAYBACK_CACHE_STATE postId=55 seg1=true seg2=false seg4=false storageBytes=184922301
```

说明至少一个 HLS Segment 已经真实存在于本地缓存中，并被缓存检测命中。

测试期间本地媒体缓存占用约为：

```text
184,922,301 bytes ≈ 176 MB
187,297,869 bytes ≈ 179 MB
```

## 字幕片段循环

测试结果：

```text
PLAYBACK_CLIP_START = 2
PLAYBACK_CLIP_LOOP  = 29
```

说明字幕搜索片段可以基于原视频时间轴播放，并正常执行重复循环。

本轮连续循环次数已经超过原验收目标的 20 次。

## Shorts 生命周期

测试结果：

```text
PLAYBACK_SHORTS_RELEASED = 8
PREWARMED_MANIFEST       = 8
```

说明：

- 用户快速滑离 Shorts 后，旧播放器会被释放。
- 下一条 Shorts 的 Manifest 预热机制正常运行。
- 当前实现没有证据显示会一次性完整预加载大量后续 Shorts。

## App 后台生命周期

测试结果：

```text
PLAYBACK_APP_PAUSED  = 5
PLAYBACK_APP_RESUMED = 1
```

说明 App 进入后台时播放器能够收到生命周期事件并暂停。

## 当前 P0 状态

| 项目 | 状态 |
|---|---|
| HLS 多清晰度基础 | 已实现 |
| ABR Auto | 已实现 |
| 本地媒体缓存 | 已验证通过 |
| 重复播放缓存复用 | 已有真机证据 |
| 字幕片段复用原视频 | 已验证通过 |
| 单句循环 | 已验证通过 |
| Shorts 旧播放器释放 | 已验证通过 |
| Shorts 下一条轻量预热 | 已验证通过 |
| App 后台暂停 | 已验证通过 |
| 用户手动画质选择 | 尚未完成 |

## 尚未覆盖

本轮测试没有精确测量：

- 第一次播放下载了多少 MB
- 第二次重复播放减少了多少 MB
- 单句循环 20 次实际额外产生多少云端流量
- CDN Cache Hit Ratio
- GCS / CDN 实际回源次数
- 每分钟观看对应的真实下载字节数

这些属于下一阶段的请求级流量与云端指标验证。

## 最终记录

截至 2026-10-04：

**Clyven 视频播放流量优化 P0 核心行为已通过真机测试。**

后续不需要重复验证本轮已经确认的播放器生命周期、字幕循环、Shorts 释放和基础本地缓存机制，除非相关代码发生重大修改。


---

## v10 冷缓存 / 热缓存重复播放验收

**测试日期：2026-10-04**  
**测试脚本：Clyven 播放流量验证 v10**

测试前通过 `pm clear` 清空 Clyven 本地数据，建立真正冷缓存环境；随后使用同一个普通 HLS 视频、完全相同的播放区间进行两次播放。

### 阶段 A：冷缓存首次播放

```text
VIDEO_CACHE_TASK = 69
缓存命中证据 = 0
cache 目录增长 = 31,804,416 bytes
日志中不同媒体 URL = 5
```

### 阶段 B：热缓存重复播放

```text
VIDEO_CACHE_TASK = 6
缓存命中证据 = 1
cache 目录继续增长 = 4,255,744 bytes
日志中不同媒体 URL = 4
```

### 结论

- `VIDEO_CACHE_TASK` 从 69 降到 6，下降约 **91.3%**。
- 第二次播放明确出现本地 HLS Segment 缓存命中。
- 第二次播放的缓存目录新增量约 4.1 MB，显著低于首次播放约 30.3 MB。
- 因此可以正式确认：**重复观看同一视频同一区间时，Clyven 会复用本地 HLS Segment 缓存，不会重新完整下载相同内容。**
- 该结果证明客户端重复播放缓存机制有效，但 cache 目录增长量不能直接等同于 Google Cloud 账单中的实际出口流量。

### 状态更新

| 项目 | 状态 |
|---|---|
| 普通视频重复播放缓存复用 | ✅ 冷/热缓存真机对照验证通过 |
| Shorts 旧播放器释放 | ✅ 已通过 |
| Shorts 下一条 Manifest 预热 | ✅ 已通过 |
| App 后台暂停 | ✅ 已通过 |
| 字幕片段循环功能 | ✅ 功能已验证（v6 循环 29 次） |
| 字幕片段循环是否避免重复下载 | 待专项验证 |


---

## v12 字幕片段循环流量验收

**测试日期：2026-10-04**  
**测试脚本：Clyven 字幕片段循环流量验证 v12**

### 首次片段播放

```text
PLAYBACK_CLIP_START = 1
PLAYBACK_CLIP_LOOP = 5
VIDEO_CACHE_TASK = 45
不同媒体 URL = 4
cache 增长 = 8,182,784 bytes
```

### 后续同片段循环

```text
PLAYBACK_CLIP_LOOP = 17
VIDEO_CACHE_TASK = 0
不同媒体 URL = 1
cache 继续增长 = 0 bytes
```

阶段 A 和阶段 B 合计记录到 **22 次循环**。

### 结论

- 同一个字幕片段在首次加载后，后续连续循环没有产生新的 `VIDEO_CACHE_TASK`。
- 后续 17 次循环期间，App `cache` 目录增长为 **0 bytes**。
- 说明字幕片段循环会复用已经加载/缓存的 HLS Segment，而不是每循环一次重新下载。
- 因此可正式确认：**字幕片段连续循环的重复下载优化已通过真机验证。**

### 状态更新

| 项目 | 状态 |
|---|---|
| 普通视频重复播放缓存复用 | ✅ 冷/热缓存真机对照通过 |
| 字幕片段循环避免重复下载 | ✅ 真机验证通过 |
| Shorts 旧播放器释放 | ✅ 已通过 |
| Shorts 下一条 Manifest 预热 | ✅ 已通过 |
| App 后台暂停 | ✅ 已通过 |

---

## v13 Shorts 快速滑动流量观察

**测试日期：2026-10-04**

快速滑动 Shorts 时观察到：

```text
初始化次数：10
释放次数：9
预热次数：8
VIDEO_CACHE_TASK：131
cache 增长：约 26.1 MB
```

随后停留约 20 秒再次观察：

```text
VIDEO_CACHE_TASK：32
cache 增长：约 23.2 MB
```

### 结论

- Shorts 生命周期释放逻辑可以正常触发。
- 下一条 Manifest 预热可以正常触发。
- 但快速切换时仍会产生较明显的媒体请求。
- 因此继续调查 Segment 时长与快速滑走造成的浪费。

---

## v15 新 HLS 版本与 ABR 启动行为

新转码视频：

```text
videoId=57
media version=v1
```

测试观察到：

```text
/transcoded/57/v1/
```

并使用新版多档 HLS。

本次运行中，新视频启动时没有同时拉取多个清晰度的大量 Segment，ABR 启动行为基本正常。

### 结论

新版多码率 HLS 本身没有发现明显的“启动即同时下载全部清晰度”问题。

---

## v20 BYTERANGE 正确解析

进一步检查确认 HLS 使用：

```text
#EXT-X-BYTERANGE
```

因此，TS 对象的 HTTP `Content-Length` 不能直接当作单个 Segment 大小。

对 `videoId=57` 的 v1 6 秒 Segment 正确解析后：

```text
360p：
首段 626,416 bytes
约 0.597 MiB
平均约 0.835 Mbps

480p：
首段 958,800 bytes
约 0.914 MiB
平均约 1.278 Mbps

720p：
首段 1,756,672 bytes
约 1.675 MiB
平均约 2.342 Mbps

1080p：
首段 3,224,012 bytes
约 3.075 MiB
平均约 4.299 Mbps
```

### 结论

码率没有异常。

此前“一个 Segment 特别大”的判断来自把整个共享 TS 对象大小误认为单个 Segment。

---

## Shorts v2：3 秒 Segment

后端调整：

```text
普通 Video：6 秒 Segment
Short：3 秒 Segment
新媒体版本：v2
```

相关 commit：

```text
1f30e91
Optimize Shorts HLS segment duration and media versioning
```

Cloud Run 新 revision：

```text
glyphora-server-00086-b8j
```

并已切换到：

```text
100% latest revision
```

### 新 Short 验证

新上传：

```text
videoId=58
```

Manifest：

```text
gs://glyphora-video-storage-11129163384/transcoded/58/v2/manifest.m3u8
```

四档 Playlist 均验证：

```text
TARGETDURATION=3
SegmentCount=9
FirstSegment=3.000s
MaxSegment=3.000s
```

### 480p 首段对比

旧 v1：

```text
videoId=57
6 秒
958,800 bytes
约 0.914 MiB
```

新 v2：

```text
videoId=58
3 秒
479,776 bytes
约 0.458 MiB
平均码率约 1.279 Mbps
```

首段字节减少：

```text
50.0%
```

### 结论

Short 专用 3 秒 Segment 已上线并通过验证。

在平均码率基本相同的情况下，快速滑走时首个 480p Segment 的潜在浪费约减少一半。

---

## Shorts 划走后的缓存任务取消

后续测试发现：

```text
PLAYBACK_SHORTS_RELEASED
```

虽然已经触发，但缓存层中已排队的下一段仍可能继续下载。

因此 App 增加缓存取消逻辑。

相关 commit：

```text
32fa154
Cancel Shorts cache tasks after swipe
```

新增诊断：

```text
PLAYBACK_CACHE_CANCELLED
```

最终真机测试中：

```text
20:55:43.520 PLAYBACK_CACHE_CANCELLED postId=50
20:55:43.522 PLAYBACK_SHORTS_RELEASED postId=50
20:55:43.540 PLAYBACK_INITIALIZING postId=49
20:55:43.540 PREWARMED_MANIFEST postId=49
```

被释放的 `postId=50` 当时已有一个正在进行中的 Range：

```text
Task ID=125
TotalBytes=2,136,432
```

该在途任务随后仍完成。

但是在测试窗口内，没有继续观察到新的 `postId=50` 媒体 Segment 任务被排入。

### 结论

- 划走 Short 时缓存取消路径已实际执行。
- 已经在途的 HTTP Range 可能仍然收尾。
- 当前观察中，释放后没有继续为旧 Short 排新的 Segment。
- 不为了强制中断最后一个接近完成的 Range 去 fork / 魔改缓存库。

---

## 2026-10-04 最终状态补充

| 项目 | 状态 |
|---|---|
| HLS 多清晰度 | ✅ |
| ABR Auto | ✅ |
| 普通视频重复播放缓存复用 | ✅ |
| 字幕片段循环避免重复下载 | ✅ |
| Shorts 旧播放器释放 | ✅ |
| Shorts 下一条 Manifest 预热 | ✅ |
| Shorts v2 3 秒 Segment | ✅ |
| 普通 Video 6 秒 Segment | ✅ |
| Short 首段 480p 流量约减少 50% | ✅ |
| Short 划走调用缓存取消 | ✅ |
| 已在途 Range 强制中断 | 不保证 |
| App 后台暂停 | ✅ |
| 精确 GCP egress | 尚未用云端账单/请求指标专项验证 |

### 工程判断

本轮 P0 播放流量优化已经完成主要目标。

需要长期保留的两个重要注意事项：

1. `cache` 目录增长不能直接等同于 Google Cloud 实际 egress。
2. BYTERANGE HLS 中，共享 TS 文件总大小不能当作一个 Segment 的大小。

后续如需要精确成本分析，应使用 GCS / CDN / Cloud Logging 或账单指标进行请求级验证。
