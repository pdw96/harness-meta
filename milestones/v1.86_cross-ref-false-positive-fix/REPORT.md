# Milestone v1.86_cross-ref-false-positive-fix — REPORT

**완료일**: 2026-05-07
**상태**: ✅ 완료 (1 PLAN, 1 commit)
**선행**: v1.85_roadmap-housekeeping

## 최종 결과

### 변경 파일 (총 3)

| 영역 | 파일 |
|------|------|
| 핵심 fix | `tests/smoke-cross-ref.sh` (+4 -3) |
| milestone 문서 | `milestones/v1.86_cross-ref-false-positive-fix/PLAN.md` + `REPORT.md` (본 파일) |
| plan 문서 | `milestones/v1.86_cross-ref-false-positive-fix/plan-1-milestone-exclusion/PLAN.md` + `REPORT.md` |

### Commit 매트릭스

| # | Commit | 내용 |
|:-:|--------|------|
| 1 | `724baf0` | fix(meta): v1.86 plan-1 phase-1 — smoke-cross-ref milestones/ 제외 추가 |

## 구현 요약

### plan-1-milestone-exclusion (commit 724baf0)

`tests/smoke-cross-ref.sh`에 `_VER_MILE` regex 신규 + `should_exclude()` OR 조건 추가. v1.84 L2 false positive 재발 경로 차단.

- `_VER_MILE = re.compile(r'^milestones/v\d+\.\d+[^/]*/.*\.md$')`
- `_VER_SESS` `[^/]+\.md$` → `.*\.md$` (depth 방어적 완화)
- E2E 양방향 검증: milestone fixture 제외 PASS + living doc 감지 FAIL

## 판정

| milestone PLAN 성공 기준 | 결과 |
|------------------------|:----:|
| `milestones/v*/` 하위 파일 모두 `should_exclude()` → `True` | ✅ 11/11 케이스 PASS |
| `_VER_SESS` `.*\.md$` 갱신 | ✅ |
| E2E: milestone fixture broken ref → PASS | ✅ |
| E2E: living doc broken ref → FAIL | ✅ |
| 기존 smoke PASS=1 회귀 0 | ✅ |
| smoke-scope-contract PASS=194 회귀 0 | ✅ |
| smoke-spec-verification PASS=608 회귀 0 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|---|---|
| library | (N/A) |
| topic | (N/A) |
| findings | (N/A) |
| drift | N/A |
| re-verify | (N/A) |

**Citations**: 외부 spec 의존 없음 — Python stdlib (`re`, `pathlib`). drift=N/A 정합.

## Lessons Learned

- **L1 — markdownlint MD032**: bullet list 앞 blank line 의무. `**근거**:` 뒤 bullet list에서 첫 commit 실패 → 수정 후 재commit.
- **L2 — commit background wait**: Windows Git Bash pre-commit hook이 긴 smoke를 실행하면 TaskOutput 대기 필요 (timeout=300s).
- **L3 — E2E MSYS2 path**: Python `-c` 인자에 경로 포함 시 MSYS2 path translation 문제 → `sys.argv` 경유 패턴 의무 (v1.70 답습).

## 후속 세션

§3-B `smoke-cross-ref-false-positive-fix` → 완료 처리. ROADMAP §8 이동.

## 관련 문서

- 본 milestone PLAN: [PLAN.md](PLAN.md)
- smoke fix: [../../tests/smoke-cross-ref.sh](../../tests/smoke-cross-ref.sh)
- v1.84 L2 발원: [../../milestones/v1.84_workflow-revamp/REPORT.md](../../milestones/v1.84_workflow-revamp/REPORT.md)
- ROADMAP: [../../sessions/meta/ROADMAP.md](../../sessions/meta/ROADMAP.md)
