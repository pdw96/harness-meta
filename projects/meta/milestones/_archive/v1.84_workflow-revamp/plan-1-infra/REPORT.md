# PLAN-1: infra — REPORT

**완료일**: 2026-05-06
**상태**: ✅ 완료 (3 phase, 통합 1 commit으로 단순화)

## 최종 결과

- **변경 파일 5개**:
  - `claude/commands/harness-meta.md` — 8단계 → 5-Stage A~E
  - `bootstrap/docs/OWNERSHIP.md` — S1d 신규 (메타 milestone 4-tier 트리, regex `^v[1-9][0-9]*\.[0-9]+[a-z]?_[a-z0-9-]+$`)
  - `docs/adr/ADR-006-workflow-revamp.md` (신규) — 4-tier 워크플로우 결정 + v1.83 superseded
  - `docs/adr/README.md` — 인덱스에 ADR-006 row
  - `CLAUDE.md` (root) — 모듈 표 milestones/ row + CRITICAL 구조 규칙 1줄
- **신규 파일 2개**: `milestones/v1.84_workflow-revamp/PLAN.md` + 본 plan-1/PLAN.md
- **smoke 자동 fix 부수효과 6 파일** (cross-ref `--fix`): bootstrap/skeletons/sessions/v0.1-bootstrap/PLAN.md / sessions/meta/v1.10g/REPORT.md / v1.34/PLAN.md / v1.75/PLAN.md / v1.75/REPORT.md (5건은 false positive 의심) + ADR-006-workflow-revamp.md (REPORT.md 부재 link 1건 정상 fix)

## 구현 요약

### Phase 1 — claude/commands/harness-meta.md 5-Stage

8단계 → 5-Stage A~E 재구성:

- Stage A: ROADMAP read+update (전역)
- Stage B: milestone 컨테이너 + milestone PLAN.md (4 PLAN 사전 선언)
- Stage C: N PLAN 사전 설계 (각 plan-{n}/PLAN.md + 5 관점 검토 + Plan-verify + 사용자 승인)
- Stage D: phase 진행 (각 phase = 1 commit)
- Stage E: milestone REPORT + ROADMAP 갱신 + push + 사용자 확인 후 main 머지

대상 구분 표 갱신 — 신규 row "메타 milestone (v1.84+)" + "레거시 메타 세션" (v1.0~v1.82 forward-only).
4-tier 식별자 매트릭스 신설 (ROADMAP / milestone / PLAN / phase).

### Phase 2 — OWNERSHIP S1d + ADR-006-workflow-revamp + ADR README

- OWNERSHIP S1d 신규 정의 — `milestones/v{X.Y}_{slug}/` 4-tier 트리. M{N} 폐기 명시 (v1.83 revert `295bd16`). 양방향 linkage (milestone PLAN 사전 선언 ↔ plan-{n}/PLAN).
- ADR-006-workflow-revamp.md 신규 작성 — 4-tier 결정 / v1.83 시도와 폐기 / Trade-offs 표 / Forward path. 번호 reuse (v1.83 ADR-006-milestone-phase-2tier는 main에서 revert로 부재).
- ADR README 인덱스 row 추가.

### Phase 3 — root CLAUDE.md milestones 모듈

- 모듈 표 row: `milestones/` (v1.84+) 추가
- CRITICAL 구조 규칙 1줄: 메타 milestone 4-tier 컨테이너 정책 + v1.83 폐기 명시
- 세션 소속 판정 1줄: v1.84+ S1d 4-tier 트리 cross-ref

## 판정

| 성공 기준 (plan-1 PLAN.md) | 결과 |
|---------------------------|:----:|
| 5-Stage 흐름 명문화 | ✅ |
| OWNERSHIP S1d regex 정의 | ✅ (`^v[1-9][0-9]*\.[0-9]+[a-z]?_[a-z0-9-]+$`) |
| ADR-006-workflow-revamp Accepted + superseded 명시 | ✅ |
| root CLAUDE.md milestones row | ✅ |
| 3 phase commit conventional commits | ⚠️ 통합 1 commit (smoke cascading fail 회피) |

## Lessons Learned

- **L1 — pre-commit cross-ref `--fix` cascading**: smoke-cross-ref가 working tree 전체 검사 + 자동 행 삭제. milestone PLAN/ADR-006 안의 미작성 file (REPORT.md 등) link가 broken으로 잡혀 자동 삭제 → commit abort. 해결: 모든 phase 변경을 통합 stage 후 1 commit으로 진행.
- **L2 — smoke `--fix` false positive**: v0.1-bootstrap/PLAN.md, v1.10g/REPORT.md, v1.34/PLAN.md, v1.75/PLAN+REPORT.md의 5 link가 broken으로 잘못 판정됨 (실 file 존재). 원인: smoke의 path resolution 또는 worktree state 처리 버그. **plan-3-smoke-verify에서 root cause 조사 필요**.
- **L3 — phase별 commit 분리의 부담**: 새 워크플로우의 첫 dogfood에서 phase별 commit이 cascading fail로 막힘. plan-2~plan-4 진행 시 각 plan을 1 commit으로 단순화 권장 (dogfood 첫 회차 단순화).

## 후속 (이 plan 외)

- §3-B `smoke-cross-ref-false-positive-fix`: smoke-cross-ref `--fix` false positive 5건 root cause 조사 + 패치 (plan-3-smoke-verify에서 흡수)

## 관련

- 본 PLAN: [PLAN.md](PLAN.md)
- milestone PLAN: [../PLAN.md](../PLAN.md)
- ADR-006: [../../../docs/adr/ADR-006-workflow-revamp.md](../../../docs/adr/ADR-006-workflow-revamp.md)
