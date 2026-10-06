# Glyphora Nôm 转换库

[English](README.md) | **简体中文**

越南语 Quốc Ngữ（拉丁字母）↔ Chữ Nôm 的共享转换核心。

转换器**不会自行编造词典映射**。映射来自持续维护的 Excel 词典，并导入到 `data/nom_dictionary.json`。

## 数据流

```text
由项目所有者维护的 Excel 词典
        ↓
tool/import_nom_excel.py
        ↓
data/nom_dictionary.json
        ↓
NomDictionary
        ↓
NomConverter
        ↓
Glyphora Review / 独立转换工具 / 未来的工具
```

## 当前规则

- 拉丁字母 → Nôm 使用最长短语匹配。
- 同一个来源有多个映射时，`priority` 更高的优先。
- 所有候选项都保留在 `NomConversionSegment.candidates` 中。
- 匹配不到的文本原样保留，不做猜测。
- 同时支持 Nôm → 拉丁字母。
- 核心库不依赖任何 UI，也不依赖 Serverpod。

## 导入 Excel

首次使用前安装导入工具的依赖：

```powershell
py -m pip install openpyxl
```

然后执行：

```powershell
cd packages\glyphora_nom_converter
py tool\import_nom_excel.py "C:\path\to\your_dictionary.xlsx"
```

导入工具会尝试自动识别拉丁字母 / Quốc Ngữ 列和 Nôm 列。如果真实 Excel 的表头不同，请显式指定：

```powershell
py tool\import_nom_excel.py "C:\path\dictionary.xlsx" `
  --latin-column "你的拉丁字母列表头" `
  --nom-column "你的 Nôm 列表头"
```

不要为了迁就导入工具而改名或重排真实的 Excel。导入映射应当去适配源 Excel。
