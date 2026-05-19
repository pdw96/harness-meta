# mapper-output (fixture — table-mismatch)

audit chain `claude-docs-mapper` 산출 모방 fixture — 표 안 `source_path` column 1건 존재 안 함 (cycle 1 v5.10 + cycle 3 v5.12 evidence 모방).

| # | gap | tool | source_path |
|---|-----|------|-------------|
| 1 | bootstrap docs | CLAUDE.md | CLAUDE.md |
| 2 | nonexistent fact | mapper | projects/meta/nonexistent-fact.md |
| 3 | roadmap thin index | ROADMAP | ROADMAP.md |

본 fixture 호출 시 `audit_fact_verify.py` 가 row 2 `source_path: projects/meta/nonexistent-fact.md` 부재 검출 → exit 1 FAIL + mismatch 보고.
