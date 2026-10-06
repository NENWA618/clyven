# glyphora_studio

[English](README.md) | **简体中文**

Glyphora 的创作者后台，使用 Jaspr（Dart Web）构建。创作者在这里上传和管理视频、管理字幕和词典、管理评论。

它通过生成的 `glyphora_backend_client` 包与统一的 Serverpod 后端（`server/backend_server`）通信，并复用 `glyphora_subtitle_editor` 中的字幕编辑器。

## 运行

在仓库根目录执行，后端需要已经启动：

```bash
melos run dev:studio   # 服务地址 http://localhost:8083
```

或者直接运行：

```bash
cd apps/studio
jaspr serve --port 8083
```

## 构建

```bash
cd apps/studio
jaspr build
```

构建产物输出到 `build/jaspr/`。
