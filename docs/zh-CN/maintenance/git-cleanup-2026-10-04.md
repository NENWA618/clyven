# Clyven / Glyphora Git 仓库清理记录

[English](../../en/maintenance/git-cleanup-2026-10-04.md) | **简体中文**

日期：2026-10-04

## 本次清理目标

本次清理主要针对：

- 一次性补丁文件
- 临时修补脚本
- 本地备份目录
- 构建产物
- 构建报告
- 未被项目引用的开发截图
- 已经进入正式源码、不再需要保留的历史临时文件

本次没有删除正常业务代码、数据库迁移、Serverpod 生成代码、测试代码、正式配置、正式文档或平台源码。

---

## 一、从当前 `main` 删除的文件

### 1. Shorts 临时补丁文件

以下文件已经从当前仓库删除：

- `isolate-shorts-interaction-buttons.patch`
- `like-red-only-when-liked.patch`
- `rebuild-shorts-action-rail.patch`
- `shorts-nav-true-overlay-v2.patch`
- `shorts-nav-true-overlay.patch`
- `shorts-overlay-nav.patch`

这些文件是此前修复 Shorts / 短视频界面时产生的一次性 Git patch。

对应功能已经进入正式源码，因此不再需要继续保留这些 patch。

---

### 2. 一次性 PowerShell 修补脚本

删除：

- `rebuild-shorts-action-rail.ps1`

这是与 Shorts action rail 修复对应的一次性脚本。

正式代码已经完成修改后，该脚本不再属于长期项目资产。

---

### 3. Clyven Admin 构建产物

删除：

- `apps/clyven_admin/build/.last_build_id`

并从历史中清除了：

- `apps/clyven_admin/build/**`

这是 Jaspr / Dart 构建过程中自动产生的内容，可以通过重新 build 生成，不应长期进入 Git。

---

### 4. Android Gradle 构建产物

删除：

- `apps/clyven_app/android/build/reports/problems/problems-report.html`

并从历史中清除了：

- `apps/clyven_app/android/build/**`

这是 Android / Gradle 自动生成的构建报告和构建目录，不属于正式源码。

---

### 5. 未使用的 Flutter 截图

删除：

- `apps/clyven_app/flutter_01.png`

该图片大小约 606 KB。

检查仓库后，没有发现项目代码或文档引用该图片，因此将其视为开发过程中留下的截图并清除。

---

## 二、从整个 Git 历史中清除的内容

本次使用 `git filter-repo` 重写了约 232 个 commit 的历史。

### 1. 本地 patch backup 历史

彻底清除：

- `.clyven-patch-backup/**`

该目录是此前自动修补脚本生成的本地备份目录，不属于正式项目代码。

清理后执行：

```powershell
git log --all -- .clyven-patch-backup
```

无输出，说明这些路径已经不在当前可达 Git 历史中。

---

### 2. `.patch` 文件历史

历史清理时使用了：

```text
--path-glob "*.patch"
```

因此整个历史中匹配 `*.patch` 的文件均被移除。

目前已知被清除的主要是：

- `isolate-shorts-interaction-buttons.patch`
- `like-red-only-when-liked.patch`
- `rebuild-shorts-action-rail.patch`
- `shorts-nav-true-overlay-v2.patch`
- `shorts-nav-true-overlay.patch`
- `shorts-overlay-nav.patch`

这些均为开发过程中的临时 patch。

---

### 3. 一次性修补脚本历史

彻底清除：

- `rebuild-shorts-action-rail.ps1`

---

### 4. Admin build 历史

彻底清除：

- `apps/clyven_admin/build/**`

验证：

```powershell
git log --all -- apps/clyven_admin/build
```

无输出。

---

### 5. Android build 历史

彻底清除：

- `apps/clyven_app/android/build/**`

验证：

```powershell
git log --all -- apps/clyven_app/android/build
```

无输出。

---

### 6. Flutter 截图历史

彻底清除：

- `apps/clyven_app/flutter_01.png`

验证：

```powershell
git log --all -- apps/clyven_app/flutter_01.png
```

无输出。

---

### 7. Clyven Web / Jaspr 历史构建产物

第二轮历史清理彻底移除了：

- `apps/clyven_web/build/**`

其中历史大文件榜中确认存在的构建产物包括：

- `apps/clyven_web/build/jaspr/main.client.dart.js`
- `apps/clyven_web/build/jaspr/packages/$sdk/dev_compiler/web/dart_stack_trace_mapper.js`
- `apps/clyven_web/build/jaspr/packages/build_web_compilers/src/dev_compiler_stack_trace/stack_trace_mapper.dart.js`

这些全部属于 Jaspr / Dart Web 构建生成物，不是源码。

验证：

```powershell
git log --all -- apps/clyven_web/build
```

无输出。

---

## 三、`.gitignore` 更新

为避免这些文件以后再次进入仓库，增加或保留了以下忽略规则：

```gitignore
.clyven-patch-backup/
**/build/
/*.patch
/*.bak
apps/clyven_web/build/jaspr/
```

其中：

- `.clyven-patch-backup/`：忽略本地 patch 备份
- `**/build/`：忽略所有嵌套项目的 build 目录
- `/*.patch`：忽略根目录临时 patch
- `/*.bak`：忽略根目录备份文件
- `apps/clyven_web/build/jaspr/`：明确忽略 Jaspr build

---

## 四、明确保留的内容

以下内容没有作为垃圾清理：

- `123.md`
- `README.md`
- `docs/**`
- `tool/**`
- `server/**/migrations/**`
- `server/**/generated/**`
- `packages/**/generated/**`
- `serverpod_test_tools.dart`
- `config/*.yaml`
- `cloudbuild.server.yaml`
- `cors.json`
- `dev.cmd`
- Flutter / Android / iOS / Windows / Linux / macOS 正式平台代码
- 所有正式业务源码
- 所有数据库 migration
- 所有正式测试
- 所有当前仍属于项目结构的 Serverpod 文件

尤其是 Serverpod migration 中较大的 `definition.json`，虽然出现在大文件排行榜中，但它们属于数据库迁移历史，因此保留。

---

## 五、Git 历史变化

第一次历史清理后：

- 原 `main`：`8fdd8db`
- 重写后 `main`：`5658827`

第二次继续清除 `apps/clyven_web/build/**` 后：

- 原 `main`：`5658827`
- 新 `main`：`376ac81`

由于使用了 `git filter-repo`，历史中的 commit SHA 会重新计算，这是正常行为。

所有主要分支均已执行 force push 更新。

---

## 六、空间变化

在第一次历史清理后，使用前后 mirror 仓库比较：

```text
清理前 size-pack：3.04 MiB
第一次清理后 size-pack：3.33 MiB
```

第一次清理没有明显节省 pack 空间，因为：

- 删除的垃圾本身体积不大
- 232 个 commit 被重写
- Git pack / delta 压缩结构发生变化
- 新旧 commit/tree 对象重新生成

第二轮清理进一步删除了 `apps/clyven_web/build/**`。

历史大文件榜中仅明确看到的 Jaspr build 文件，未压缩大小已经超过约 0.8 MB，实际该目录历史总量还包括更多较小文件。

因此本次清理的主要收益不是单纯追求仓库体积，而是：

- Git 历史更干净
- 构建产物不再混入源码历史
- 临时 patch 不再长期保存
- 本地 backup 不再污染仓库
- 后续协作与代码审查更清晰

---

## 七、备份

历史重写前已创建 mirror 备份：

```text
C:\Users\USER\Documents\Flutter\flutter_application_3-before-history-clean.git
```

第一次历史清理后又创建了：

```text
C:\Users\USER\Documents\Flutter\flutter_application_3-after-history-clean.git
```

因此目前仍有可用于恢复旧历史的本地备份。

---

## 八、最终结果

当前仓库已经完成以下清理：

- 临时 patch：已删除
- 一次性修补脚本：已删除
- patch backup：已从历史清除
- Admin build：已从当前版本及历史清除
- Android build：已从当前版本及历史清除
- Jaspr Web build：已从历史清除
- 未使用 Flutter 截图：已从当前版本及历史清除
- `.gitignore`：已加强
- 主要分支：已 force push 到重写后的新历史
- 正式源码 / migration / generated / tests：保留

本次属于“清理开发垃圾和构建产物”，没有对 Clyven / Glyphora 的正式业务代码和核心项目结构做删减。
