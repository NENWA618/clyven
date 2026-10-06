# glyphora_backend_client

[English](README.md) | **简体中文**

所有 Glyphora 前端共用的 Serverpod 客户端。代码由 Serverpod 根据服务端项目生成，请不要手动修改生成的文件。重新生成的方法：

```bash
cd server/backend_server
serverpod generate
```

调用 endpoint 的格式是 `client.<endpoint>.<method>(...)`，例如 `client.notification.list()`。更多说明见 [Serverpod 文档](https://docs.serverpod.dev)。
