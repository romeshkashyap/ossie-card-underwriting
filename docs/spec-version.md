# Pinned Apache Ossie spec version

| Item | Version | Why |
| --- | --- | --- |
| Apache Ossie spec | **0.1.1** | dbt Core 1.12 parses only Ossie 0.1.0 and 0.1.1; other versions raise a parse error |
| dbt Core | 1.12.x | First release with native Ossie support (`osi/` folder, `osi_document.json` artifact) |
| dbt-duckdb | 1.9+ | Adapter for DuckDB and MotherDuck |

Verified 2026-10-31: `dbt parse` on this project writes `target/osi_document.json` with `"version": "0.1.1"`.

## Notes for later stories

- The spec's main branch is moving toward 0.2.0 (some tools, such as Hex, already target `0.2.0.dev0`).
  Revisit this pin before S7; if dbt adds 0.2 support, upgrade and record the change here.
- dbt reads Ossie documents as **JSON** files in `osi/`. Author in YAML if you prefer, then convert to JSON.
- Each Ossie dataset must point to a **dbt model** (not a source, seed or snapshot), so the star schema
  from S6 must exist as models before S7.
- Unsupported metric types are dropped with warning I078; check `logs/dbt.log` during S8.
