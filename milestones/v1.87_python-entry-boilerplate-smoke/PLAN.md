# Milestone v1.87_python-entry-boilerplate-smoke — PLAN

**vX.Y**: v1.87
**slug**: python-entry-boilerplate-smoke
**생성일**: 2026-05-07
**선행**: v1.86_cross-ref-false-positive-fix

## 세션 소속 근거 (self-apply)

**세션 소속**: `milestones/v1.87_python-entry-boilerplate-smoke/` (Meta-only, S3 다수파)

**근거**:

- 변경 파일: `tests/smoke-python-entry-boilerplate.sh` (T5 meta default) × 1 신규 + `tests/CLAUDE.md` (T5) + `CLAUDE.md` (S3) — 총 3 파일
- T1 경로 다수결 = meta 단독. T2 — 신규 smoke는 cross-platform 패턴 **스펙 정의** (한 번 추가하면 모든 Python 자산 영향) → meta 정합

## Scope inheritance (verbatim from 사용자 발의 2026-05-07 in-session)

**Source — 사용자 발의 (AskUserQuestion 2026-05-07 "병목 #2")** (verbatim):

> "cross-platform 마찰 재학습 — v1.18d cp949 reconfigure / v1.30b pipefail / v1.65 newline='\n' / v1.66 shellcheck SC1102 / v1.69 write_text(newline=) / v1.70 MSYS2 path translation. 매번 Lesson 등록하고 다음 세션이 또 밟음 — SKILL/template로 화석화 안 됨"
>
> "Python entry boilerplate smoke (Recommended) — 단일 smoke 신설 — repo 내 *.py 전수 스캔: (1) stdout UTF-8 reconfigure (2) write_text newline='\n' (3) sys.argv MSYS2 path. v1.70 smoke-scorer-output-newline 일반화."

**Parsed sub-items (2)**:

1. **P1 — `write_text` newline 인자 강제** — `bootstrap/skills/**/*.py` 모든 `\.write_text\(` 호출에 `newline="\n"` 인자 의무. v1.69 lesson 화석화. Python 3.10+ 공식 인자.
2. **P2 — entry-point stdout reconfigure 강제** — `if __name__ == "__main__":` 보유 + `print(` 호출하는 script는 `sys.stdout.reconfigure(encoding="utf-8")` 의무. v1.18d lesson 화석화. Python 3.7+ TextIOWrapper.reconfigure.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| P3: `sys.argv` vs `__file__` MSYS2 path translation | v1.87b — case 의존성 큼 (subprocess 내부에서만 문제), evidence 3+ 누적 시 진입 |
| Bash entry boilerplate smoke (`set -euo pipefail` + shellcheck SC2010/SC2064/SC2088/SC2034) | v1.88 별도 milestone — Python/Bash 도메인 분리 |
| Pre-commit hook 자동 등록 (`.pre-commit-config.yaml`) | v1.87b 후속 — v1.78→v1.78b 패턴 답습, broken pattern 재발 evidence 시 |
| `--fix` mode (auto-add `newline="\n"` / reconfigure block 삽입) | v1.87c — multi-line regex 복잡도, evidence 누적 후 (현재 P1/P2 violation 0건) |
| Pre-commit wait timeout 패턴 (v1.86 L2) | 별도 세션 — Bash/pre-commit 영역 |

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | Python (`/websites/python_3_10`) |
| topic | `pathlib.Path.write_text(newline=)` + `io.TextIOWrapper.reconfigure(encoding=)` |
| findings | (1) `Path.write_text(data, encoding=None, errors=None, newline=None)` — `newline` 파라미터 Python 3.10에서 추가, `None` (default) 시 universal newline 변환 (Windows CRLF), `"\n"` 명시 시 LF byte-level 보존. (2) `TextIOWrapper.reconfigure(*, encoding=None, errors=None, newline=None, ...)` Python 3.7+ — `sys.stdout`은 TextIOWrapper 인스턴스이므로 `sys.stdout.reconfigure(encoding="utf-8", errors="replace")` 동작. cp949 default Windows 환경에서 emoji `UnicodeEncodeError` 차단. |
| drift | no |
| re-verify | 24 months (Python stdlib stable API, deprecation 0년) |

**Citations**:

- `/websites/python_3_10/library/pathlib.html` — `Path.write_text()` signature + newline 인자 (Python 3.10 추가)
- `/websites/python_3_10/library/io.html` — `TextIOWrapper.reconfigure(encoding, errors, newline, ...)` (Python 3.7 추가)
- `/websites/python_3_10/library/functions.html` — newline 파라미터 universal newlines 동작 명세 (write 시 system default line separator 변환 vs 특정 문자열 지정)

## 배경

cross-platform 마찰 재학습 lesson (v1.18d / v1.65 / v1.69 / v1.70) 누적되었지만 **docs (Lesson Learned) 에만 살아있고 hot path 검증 부재**. 다음 사례:

- v1.18d (2026-04-30) — Windows cp949 emoji UnicodeEncodeError → `sys.stdout.reconfigure` 패턴 도입
- v1.69 (2026-05-04) — `score_codebase.py` + `html_renderer.py` `write_text(newline="\n")` 추가 (CRLF 회귀 방지)
- v1.70 (2026-05-05) — `tests/smoke-scorer-output-newline.sh` 신설 (scorer 산출물 byte-level CRLF 회귀)

v1.70은 **scorer 산출물 dynamic byte-level 검증** — 본 milestone과 직교. v1.87은 **모든 Python 소스 정적 패턴 audit** — 신규 Python skill 추가 시 회귀 차단. 두 smoke 공존 (defense in depth).

**선행**: [v1.86_cross-ref-false-positive-fix](../v1.86_cross-ref-false-positive-fix/) (smoke 인프라 패턴 답습) · [v1.70-scorer-newline-smoke](../../sessions/meta/v1.70-scorer-newline-smoke/) (scorer-specific dynamic 검증)

## N PLAN 사전 선언

| plan | slug | phases | 변경 파일 | commit 메시지 |
|:---:|------|:------:|---------|--------------|
| 1 | `smoke` | 1 | `tests/smoke-python-entry-boilerplate.sh` (신규) + `tests/CLAUDE.md` + `CLAUDE.md` | `feat(meta): v1.87 plan-1 phase-1 — smoke-python-entry-boilerplate.sh 신설 (P1 write_text newline + P2 stdout reconfigure)` |

## 성공 기준

- [ ] `tests/smoke-python-entry-boilerplate.sh` 신규 생성 — Stage 1 (P1 `write_text` newline 정적) + Stage 2 (P2 entry-point reconfigure 정적) + Stage 3 (E2E fixture violation→PASS)
- [ ] dogfood: harness-meta 8 `.py` 모두 PASS (P1 violation 0 + P2 violation 0 — 기존 `score_codebase.py`/`html_renderer.py` 정합 확인)
- [ ] E2E fixture: `write_text` without newline → FAIL detect / `__main__` + `print` without reconfigure → FAIL detect / 정합 fixture → PASS
- [ ] `tests/CLAUDE.md` smoke matrix count 27→28 + 1 row 추가
- [ ] `CLAUDE.md` (root) "smoke 27 매트릭스" → "smoke 28 매트릭스"
- [ ] 회귀 0: `bash tests/smoke-spec-verification.sh` + `bash tests/smoke-scope-contract.sh` + `bash tests/smoke-cross-ref.sh` + `bash tests/smoke-claude-md-drift.sh` + `bash tests/smoke-roadmap-sync.sh` 모두 PASS

## 후속 세션 (post-milestone candidates)

- **§3-A (evidence 의존)**:
  - `v1.87b-python-msys2-path-fossilize` — `sys.argv[0]` vs `__file__` MSYS2 path 패턴. evidence 3+ 누적 시 진입
  - `v1.87c-python-boilerplate-fix-mode` — `--fix` auto-add (P1/P2 violation 발생 시)
- **§3-B (회귀 evidence 의존)**:
  - `v1.87d-python-boilerplate-precommit` — `.pre-commit-config.yaml` 등록 (Python script 추가 후 회귀 evidence 시)
- **§3-A (별도 도메인)**:
  - `v1.88-bash-entry-boilerplate-smoke` — Bash 엔트리 패턴 (`set -euo pipefail` + shellcheck 잔존)
