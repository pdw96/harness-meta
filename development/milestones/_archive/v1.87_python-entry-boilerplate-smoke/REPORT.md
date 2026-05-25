# Milestone v1.87_python-entry-boilerplate-smoke — REPORT

## 최종 결과

- 변경 파일: 5 (1 신규 smoke + 2 docs + 2 PLAN — milestone PLAN + plan-1-smoke PLAN)
- milestone 구성: plan-1-smoke (1 phase, 1 commit `3abb7f9`)
- 신규 smoke: `tests/smoke-python-entry-boilerplate.sh` (~140 lines, AST 기반)
- smoke 매트릭스 27 → 28
- smoke 6종 PASS: 새 smoke 8/8 dogfood + 3/3 E2E + 회귀 0 (claude-md-drift 16/16 + scope-contract 196/196 + cross-ref 1/1 + roadmap-sync 31/31 + spec-verification 608/608 SKIP=4)

## 구현 요약

### plan-1-smoke (commit: `3abb7f9 feat(meta): v1.87 plan-1 phase-1 — smoke-python-entry-boilerplate.sh 신설`)

| 변경 | 내용 |
|------|------|
| `tests/smoke-python-entry-boilerplate.sh` 신규 | AST 기반 Python entry-point 정적 audit. P1 (`write_text` newline) + P2 (entry-point stdout reconfigure) 동시 검증. Stage 1+2 dogfood + Stage 3 E2E (mktemp fixture 3 case) |
| `tests/CLAUDE.md` | smoke 매트릭스 count 27→28 + "도메인 별 회귀" 1 row 추가 |
| `CLAUDE.md` (root) | "smoke 27 매트릭스" → "smoke 28 매트릭스" |

## 판정

milestone PLAN.md 성공 기준 6 체크박스 완수:

- [x] `tests/smoke-python-entry-boilerplate.sh` 신규 (Stage 1 + Stage 2 + Stage 3 E2E)
- [x] dogfood: harness-meta 8 `.py` 모두 PASS
- [x] E2E fixture: 3 case 모두 정확 detect
- [x] `tests/CLAUDE.md` count 27→28 + 1 row
- [x] `CLAUDE.md` (root) "smoke 27" → "smoke 28"
- [x] 회귀 0 (5 smoke regression PASS)

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | Python (`/websites/python_3_10`) |
| topic | `pathlib.Path.write_text(newline=)` + `io.TextIOWrapper.reconfigure(encoding=)` |
| findings | (1) `Path.write_text(data, encoding=None, errors=None, newline=None)` — newline 파라미터 Python 3.10 추가, `None` (default) 시 universal newline 변환 (Windows CRLF), `"\n"` 명시 시 LF byte-level 보존. (2) `TextIOWrapper.reconfigure(*, encoding, errors, newline, line_buffering, write_through)` Python 3.7+ — `sys.stdout` reconfigure 가능, cp949 환경 emoji UnicodeEncodeError 차단. |
| drift | no |
| re-verify | 24 months (Python stdlib stable API) |

**Citations**:

- `/websites/python_3_10/library/pathlib.html` — `Path.write_text()` signature
- `/websites/python_3_10/library/io.html` — `TextIOWrapper.reconfigure()` (Python 3.7 추가)

## Lessons Learned

- **L1: AST > regex for Python pattern matching**. multi-line `write_text(...)` + string literal 안 paren의 false-count risk → `ast.parse` + `ast.walk`로 paren-aware 정확 detect. v1.88 Bash entry boilerplate smoke는 (Bash AST 부재) 다른 접근 필요 (shellcheck 위임 또는 `set -euo pipefail` regex grep).

- **L2: Worktree 환경 smoke 검증 시 `HARNESS_META_ROOT="$(pwd)"` override 필수**. `smoke-claude-md-drift.sh` 등 `cd "$HARNESS_META_ROOT"` 사용 smoke는 기본 `~/harness-meta` (main repo) 스캔. v1.86 L2/L3 lesson 재확인. 본 smoke는 `git rev-parse --show-toplevel`로 worktree-aware 구성 — 다른 smoke 패턴 비교 시 차이 명확화.

- **L3: markdownlint MD038 — backtick code span 안 escaped pipe + 공백 (`` `\| ` ``) 위반**. table syntax 문서화 시 backtick 회피 + 일반 prose 권장. pre-commit이 잡아줘서 manual fix 후 재커밋.

- **L4: cross-platform 화석화 첫 milestone — Python entry-point 영역만 커버**. v1.18d / v1.69 lesson 두 가지 화석화 완료. 잔존 lesson:
  - v1.30b pipefail (Bash 영역) → v1.88
  - v1.65 newline (smoke `--fix` 영역) → v1.65 / v1.71에서 부분 적용, 추가 smoke `--fix` 패턴 evidence 누적 시
  - v1.66 shellcheck SC1102/SC2010/SC2064/SC2088/SC2034 → v1.88
  - v1.70 MSYS2 path translation → v1.87b (case 의존성 evidence 누적 시)

- **L5: AST audit 1 file당 ~50ms (Python startup overhead)**. 8 file dogfood ~400ms. pre-commit hook 부담 증가 우려 — 향후 50+ Python file 시 AST batch 처리 (1 Python invoke + 모든 file 처리) 검토. 현 시점 8 file이라 무관.

## 다음 후보

| 항목 | 분류 | 조건 |
|------|------|------|
| `v1.87b-python-msys2-path-fossilize` | §3-A | `sys.argv[0]` vs `__file__` MSYS2 path. evidence 3+ 누적 시 |
| `v1.87c-python-boilerplate-fix-mode` | §3-A | `--fix` auto-add (P1/P2 violation 발생 시) |
| `v1.87d-python-boilerplate-precommit` | §3-B | `.pre-commit-config.yaml` 등록 (Python script 추가 후 회귀 evidence 시) |
| `v1.88-bash-entry-boilerplate-smoke` | §3-A | cross-platform 화석화 #2 — Bash 영역 (pipefail + shellcheck SC2010/SC2064/SC2088/SC2034 잔존). v1.30b/v1.66 lesson 화석화 |
