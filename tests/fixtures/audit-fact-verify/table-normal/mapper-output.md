# mapper-output (fixture — table-normal)

audit chain `claude-docs-mapper` 산출 모방 fixture — 표 안 `source_path` column 모두 실 존재 path.

| # | gap | tool | source_path |
|---|-----|------|-------------|
| 1 | bootstrap docs | CLAUDE.md | CLAUDE.md |
| 2 | architecture canonical | ARCHITECTURE | projects/meta/ARCHITECTURE.md |
| 3 | roadmap thin index | ROADMAP | ROADMAP.md |

본 fixture 호출 시 `audit_fact_verify.py` 가 3 row 안 `source_path` 모두 존재 확인 → exit 0 PASS.
