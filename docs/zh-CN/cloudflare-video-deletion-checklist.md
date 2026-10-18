# Cloudflare 视频删除流程（待验证）

此变更不会立即部署，合并前应在 CI / staging 验证。

- API 收到作者删除请求后，把 `video.transcodeState` 标记为 `DELETING`，设置 `isPublic=false` 和 `status=failed`。状态写入数据库后才开始执行远程清理。
- 先删除 Cloudflare Stream 视频 UID（来自 `cfstream:<uid>`）；HTTP 404 被视为已删除，便于重试。
- 然后删除 R2 原视频及封面；完成后清理视频关联的字幕、评论等数据库记录，最后删除 Video 行。
- 遇到外部 API 错误会保留含视频 UID、R2 keys 的 Video 行；每两分钟扫描一次 `DELETING` 状态重试，进程重启不会丢失任务。
- 现有模型字段复用以避免引入未经生成的 Serverpod migrations；这是过渡性任务状态，而非独立审计表。

## 验收前必须检查

1. 在 CI 运行 `dart analyze` 以及受影响的服务端测试；确认 Serverpod ORM 和字段筛选兼容。
2. 在单个 staging 实例测试删除成功、Stream 已不存在(404)、R2 文件消失、Neon 视频/关联行消失。
3. 模拟 Stream API 故障，确认数据库保持 DELETING 且视频不在首页/详情/HLS 接口出现；恢复凭证后重试清理。
4. 模拟 R2 删除失败，确认下次重试不会被已删除的 Stream 资产阻塞。
5. 多实例部署前审核并发互斥：当前 `_processing` 是进程内保护，尚未实现数据库级租约；多个 Containers 可能重复调用删除。生产规模化前应加数据库租约/独立任务表。
6. 旧 Google Transcoder 资源没有被本变更删除；仅覆盖 Cloudflare Stream UID。
7. 现有 R2/GCS `deleteFile` 实现在对象缺失时的行为必须实测；若非幂等，需改成忽略已不存在对象的删除。

**勿在验证以上事项之前合并并部署到正式环境。**
