# PLAN — v1.77 Cross-ref broken link fix

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: 4건 — `bootstrap/CLAUDE.md` (S2) + `bootstrap/docs/SPEC_VERIFICATION.md` (S2) + `docs/adr/ADR-004-permission-pattern.md` (S3) + `docs/ARCHITECTURE.md` (S3)
- T1 (경로 다수결): S2×2 + S3×2 = 모두 meta 소유 scope
- v1.72-docs-cleanup / v1.76-roadmap-audit-cleanup 패턴 답습 (docs only cleanup)

## Scope inheritance (verbatim from 사용자 발의)

**Source — 사용자 발의 (v1.77 "다음 audit 진행" + AskUserQuestion 응답)** (verbatim):

> Cross-ref 링크 audit: CLAUDE.md (root + 5 모듈) + bootstrap/docs/*.md + README.md에서 깨진 내부 링크 감지. 안 개별 path resolve 검증. 결과함수: 깨진 링크 list + fix proposal.

**Parsed sub-items (4 — pre-PLAN audit round 확정, 사용자 4 AskUserQuestion 응답 매핑)**:

1. **B1 — `bootstrap/CLAUDE.md:109` upbit v0.1-bootstrap reference 삭제** (upbit는 글로벌화 이전 추가 → bootstrap 세션 부재)
2. **B2 — `bootstrap/docs/SPEC_VERIFICATION.md` SKILL path 정정** (`../skills/harness-plan-verify/` → `../skills/audit/harness-plan-verify/` — v1.36 sub-category 후 path)
3. **B3 — `docs/adr/ADR-004-permission-pattern.md:43` upbit v1.2-bash-permission-update reference 삭제** (upbit v1.2는 python-overlay-apply)
4. **B4 — `docs/ARCHITECTURE.md:45` PHILOSOPHY.md row 삭제** (파일 자체 부재)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `tests/smoke-cross-ref.sh` 인프라 신설 (audit 자동화) | 후속 미정 (v1.78 또는 evidence 누적 후) |
| backtick 내부 false positive filter 정밀화 | 위 smoke 인프라 신설 시 동반 |
| @import 패턴 false positive (AGENTS_MD_STRATEGY / INTERVIEW_FLOW / interview.md) | 본 audit에서 false positive로 식별 — 정정 불필요 |
| Legacy session PLAN @import refs (v1.0-bootstrap / v1.10b-bootstrap-agents-md 등) | Forward-only 면제 — historical record immutable |
| `sessions/**/*.md` (271 files) 전수 cross-ref 검증 | Out of scope (immutable history) |
| `bootstrap/skeletons/**/*.md` template placeholder refs | template placeholder 의도 — 정정 불필요 |
| PHILOSOPHY.md 신설 또는 다른 row replace | 사용자 결정 = row 삭제 (단순 정정) |
| upbit v0.1-bootstrap / v1.2-bash-permission 대체 reference 작성 | 사용자 결정 = 단순 삭제 |
| 5 관점 병렬 review | 4 파일 trivial line-edit + smoke 자동 검증 가능 — v1.76 패턴 답습 (사용자 결정 시 재검토) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 docs 4 파일 broken ref 정정, 외부 spec 의존 없음 |
| **re-verify** | N/A |

**Citations**: N/A (markdown link 형식 / Claude Code @import / shell / Anthropic spec 모두 무관)

## 배경

- 선행: [`v1.76-roadmap-audit-cleanup/`](../v1.76-roadmap-audit-cleanup/) (2026-05-05) — ROADMAP 4 영역 정정
- 사용자 "다음 audit 진행" 발의 → AskUserQuestion 응답 = Cross-ref 링크 audit 채택
- pre-PLAN audit script 실행 → living docs 26 파일 196 refs 중 16 broken 후보 → false positive 필터 후 **실 broken 4건** 확정
- v1.72 / v1.76 docs cleanup 패턴 답습 (단일 commit, smoke 자동 검증)

## 목표

- [ ] B1: `bootstrap/CLAUDE.md` line 109 upbit v0.1-bootstrap row 삭제
- [ ] B2: `bootstrap/docs/SPEC_VERIFICATION.md` SKILL path → `audit/` sub-category 추가
- [ ] B3: `docs/adr/ADR-004-permission-pattern.md` line 43 upbit v1.2-bash-permission row 삭제
- [ ] B4: `docs/ARCHITECTURE.md` line 45 PHILOSOPHY.md row 삭제
- [ ] post-fix audit 재실행 → living docs broken=0 확인
- [ ] smoke 3종 (spec-verification + scope-contract + roadmap-sync) PASS — 회귀 0
- [ ] PLAN/REPORT 한 쌍 + 단일 commit

## 변경 대상

- `bootstrap/CLAUDE.md` (1 line 삭제 + 인접 빈 줄 정리)
- `bootstrap/docs/SPEC_VERIFICATION.md` (1 path 수정)
- `docs/adr/ADR-004-permission-pattern.md` (1 line 삭제)
- `docs/ARCHITECTURE.md` (1 row 삭제)
- `sessions/meta/v1.77-cross-ref-broken-link-fix/{PLAN.md, REPORT.md}` (세션 기록)

## 성공 기준

- [ ] 4 hunk edit 정확 (각 파일 1 hunk)
- [ ] post-fix audit script 실행 → living docs broken=0
- [ ] smoke 3종 PASS — 회귀 0
- [ ] git diff 변경 4 파일 (의도 외 회귀 0)
- [ ] PLAN `Scope inheritance` 4 sub-item ↔ REPORT 구현 4건 1:1 매핑

## 커밋 전략

단일 커밋:

```text
docs(meta): sessions/meta/v1.77-cross-ref-broken-link-fix — living docs broken ref 4건 정정
```

## 후속 세션 연결

- **선행**: [`v1.72-docs-cleanup/`](../v1.72-docs-cleanup/) + [`v1.76-roadmap-audit-cleanup/`](../v1.76-roadmap-audit-cleanup/) — docs cleanup 패턴 source
- **후속 (잠재)**: `tests/smoke-cross-ref.sh` 인프라 신설 (v1.78 또는 evidence 누적 후) — backtick filter 정밀화 + 자동 검증 + `--fix` mode
