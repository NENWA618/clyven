# 删除失败恢复测试（仅 staging）

此功能默认关闭。生产环境必须不设置以下故障注入变量。

故障注入须同时满足三个守卫：

- `GLYPHORA_STAGING=true`
- `GLYPHORA_REQUIRE_CLOUDFLARE=true`
- `GLYPHORA_DELETE_FAULT_ENABLE=true`

并且明确指定 **新建、可以永久删除** 的视频：
- `GLYPHORA_DELETE_FAULT_VIDEO_ID=<staging 视频 ID>`
- `GLYPHORA_DELETE_FAULT_STEP=before_stream|after_stream|after_r2`

程序在同一 Container 进程中针对匹配的视频及步骤只注入一次异常。下一次后台 sweep 会重试。但是 **Container 重启会重置此内存标记**，因此重启前应关闭故障注入，否则可能重新触发；多个 Container 也各自持有独立标记。仅限单实例 staging 故障模拟，不能当成完整分布式端到端证明。

步骤分别意味着：
1. `before_stream`：Stream 尚未删除时触发，数据库视频应隐藏且持久保留删除任务。
2. `after_stream`：Stream 删除后、R2 删除前触发，下一次重试应能容忍已不存在的 Stream 资产。
3. `after_r2`：Stream、R2 都删除后、数据库记录尚未删除前触发，下一次重试应能容忍资源已不存在。

**不要在现有剩余的视频 ID=1 上进行测试。** 新上传临时视频后先观察，确认 UID/对象归属于临时视频。验证完毕移除相关环境变量、重新部署 staging。

此 PR 只添加受控故障注入与纯逻辑单元测试；不自动设置任何 Secret、不改生产环境、不执行删除。真实故障恢复仍须人工 staging 验收。
