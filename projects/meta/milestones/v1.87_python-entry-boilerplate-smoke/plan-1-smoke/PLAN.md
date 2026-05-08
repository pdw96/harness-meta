# Plan 1 — `smoke` (PLAN)

**상위 milestone**: [v1.87_python-entry-boilerplate-smoke](../PLAN.md)

## 목표

- [ ] `tests/smoke-python-entry-boilerplate.sh` 신규 작성 — 정적 audit + E2E dynamic
- [ ] P1 (`write_text` newline) + P2 (entry-point stdout reconfigure) 동시 검증
- [ ] dogfood: 기존 8 `.py` PASS (회귀 0)
- [ ] tests/CLAUDE.md + root CLAUDE.md smoke count 갱신

## Phase 매트릭스

| phase | 변경 파일 | commit 메시지 |
|:---:|---------|--------------|
| 1 | `tests/smoke-python-entry-boilerplate.sh` (신규) + `tests/CLAUDE.md` + `CLAUDE.md` (root) | `feat(meta): v1.87 plan-1 phase-1 — smoke-python-entry-boilerplate.sh 신설 (P1 write_text newline + P2 stdout reconfigure)` |

## 변경 파일 (3건)

1. **`tests/smoke-python-entry-boilerplate.sh`** (신규, ~150 lines)
   - Header: shellcheck pragma + `set -euo pipefail`
   - SCAN_GLOB: `bootstrap/skills/**/*.py`
   - Stage 1 (P1): For each `.py` → grep `\.write_text(` → require `newline=` in same call (Python heredoc multi-line aware)
   - Stage 2 (P2): For each `.py` with `__name__ == "__main__"` AND `print(` → require `sys\.stdout\.reconfigure` somewhere
   - Stage 3 (E2E): mktemp fixture dir → 3 fixture (violation P1 / violation P2 / both clean) → expect FAIL FAIL PASS
   - PASS=N FAIL=N 출력, exit 0/1

2. **`tests/CLAUDE.md`**
   - smoke matrix count 27 → 28
   - "도메인 별 회귀" 섹션에 `smoke-python-entry-boilerplate.sh` 1 row 추가 — "Python entry-point boilerplate (AST audit) — P1 `write_text` newline + P2 `__main__` stdout reconfigure (v1.87)"

3. **`CLAUDE.md`** (root)
   - `tests/` 행: "smoke 27 매트릭스" → "smoke 28 매트릭스"

## 성공 기준

- [ ] `bash tests/smoke-python-entry-boilerplate.sh` exit 0 (PASS=N FAIL=0, dogfood)
- [ ] E2E fixture: violation 주입 → FAIL detect (각 case 별)
- [ ] `bash tests/smoke-claude-md-drift.sh` PASS (count 28 정합)
- [ ] 기존 smoke 5종 회귀 0 (spec-verification / scope-contract / cross-ref / claude-md-drift / roadmap-sync)

## 의존성

- **선행**: 없음 (독립 신규 smoke)
- **후행**: v1.87b/c/d/v1.88 (모두 evidence-driven)

## 구현 노트

- `pipefail` (v1.30b lesson) — `set -euo pipefail` header 의무
- Python 함수 호출이 multi-line일 수 있음 (`obj.write_text(\n    data,\n    encoding="utf-8",\n    newline="\n")`) → multi-line `awk` 또는 Python `ast`/`re` 위임 권장. 단순화: Python 3 heredoc 위임 (v1.71 패턴)
- shellcheck SC1102 (subshell `$(<()`) 회피 — 직접 `python3 - <<EOF` heredoc
- mktemp fixture cleanup `trap` (single quote, v1.66 SC2064)
- exit code 0/1만 (smoke 일반 컨벤션)
