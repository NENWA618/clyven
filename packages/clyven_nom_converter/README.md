# Clyven Nôm Converter

Shared conversion core for Vietnamese Quốc Ngữ (Latin) ↔ Chữ Nôm.

The converter does **not** invent dictionary mappings. Mappings come from the
maintained Excel dictionary and are imported into `data/nom_dictionary.json`.

## Data flow

```text
Excel maintained by Chengyang
        ↓
tool/import_nom_excel.py
        ↓
data/nom_dictionary.json
        ↓
NomDictionary
        ↓
NomConverter
        ↓
Clyven Review / standalone converter / future tools
```

## Current rules

- Latin → Nôm uses longest phrase matching.
- When one source has multiple mappings, higher `priority` wins.
- All alternatives remain available in `NomConversionSegment.candidates`.
- Unmatched text is preserved instead of guessed.
- Nôm → Latin is also supported.
- The core has no UI dependency and no Serverpod dependency.

## Excel import

Install the importer dependency once:

```powershell
py -m pip install openpyxl
```

Then:

```powershell
cd C:\Users\USER\Documents\Flutter\flutter_application_3\packages\clyven_nom_converter
py tool\import_nom_excel.py "C:\path\to\your_dictionary.xlsx"
```

The importer tries to detect Latin / Quốc Ngữ and Nôm columns. If the real
Excel headers are different, specify them explicitly:

```powershell
py tool\import_nom_excel.py "C:\path\dictionary.xlsx" `
  --latin-column "YOUR LATIN HEADER" `
  --nom-column "YOUR NOM HEADER"
```

Do not rename or reshape the real Excel merely to satisfy the importer. The
import mapping should adapt to the source Excel.
