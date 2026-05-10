# ADR-006: 메타 milestone 4-tier 워크플로우 (v1.84+)

- **상태**: Accepted
- **날짜**: 2026-05-06
- **세션**: milestones/v1.84_workflow-revamp/
- **Supersedes**: 부재 — v1.83의 ADR-006-milestone-phase-2tier는 main에 squash 머지됐다가 revert(`295bd16`)되어 본 ADR이 같은 번호로 새로 정의됨.

## 결정

메타 세션 워크플로우를 **4-tier 계층**으로 표준화한다:

```
ROADMAP (전역)
  └── milestone (vX.Y_{slug})
       └── PLAN (milestone당 N개)
            └── phase (각 PLAN의 commit 단위)
```

물리 경로:

```
sessions/meta/ROADMAP.md                                  # 전역, 1 파일
milestones/v{X.Y}_{slug}/                                 # milestone 컨테이너
├── PLAN.md                                               # 무거운 § (Scope inheritance / Out of scope / ...)
├── plan-1-{slug-1}/                                      # PLAN 1
│   ├── PLAN.md                                           # 가벼운 § (목표 / phase 표 / 의존성)
│   ├── phase-1/                                          # phase 디렉토리 (옵션, NOTES.md용)
│   ├── phase-2/
│   └── REPORT.md                                         # PLAN 완료 시 작성
├── plan-2-{slug-2}/
│   └── ...
└── REPORT.md                                             # milestone 완료 시 작성 (전체 요약)
```

운영 흐름은 **5-Stage**로 표준화:

- **Stage A** — ROADMAP read+update (전역)
- **Stage B** — milestone 컨테이너 + milestone PLAN.md (4 PLAN 사전 선언)
- **Stage C** — N PLAN 사전 설계 (각 plan-{n}/PLAN.md + 5 관점 검토 + Plan-verify + 사용자 진입 승인)
- **Stage D** — phase 진행 (각 phase = 1 commit, conventional commits)
- **Stage E** — milestone REPORT + ROADMAP §8/§9 갱신 + push + 사용자 확인 후 main 머지

## 배경

### v1.83 시도와 폐기

`sessions/meta/v1.83-milestone-phase-infra/` (PR #1, squash merge `d8ada7b`)에서 milestone-phase **2-tier**를 도입했으나, 사용자 검토 후 다음 4 차이가 식별됐다:

1. **phase별 PLAN.md 의무** — 각 phase에 PLAN.md+REPORT.md pair 의무. 단일 milestone 안에서 PLAN이 phase별로 분리되어 milestone-level 통합 PLAN이 부재.
2. **ROADMAP 단계 명시 부재** — 8단계 흐름 중 단계 3에서만 ROADMAP 읽기. Stage A로 전면화 필요.
3. **푸시·머지 단계 부재** — 8단계는 commit으로 종료. push/merge는 묵시적.
4. **M{N} 식별자 vs vX.Y 식별자 병존** — milestone 식별자가 M-번호(창설 순서). 기존 sessions/meta/vX.Y와 별도 번호 공간 → 두 체계 병존 부담.

이를 해결하기 위해 v1.83 인프라는 revert(`295bd16`, 29 files, -1071 +49)로 폐기 — milestones/M{1,2}/, sessions/meta/v1.83/, 이전 ADR-006-milestone-phase-2tier 모두 main에서 제거.

### v1.84의 4-tier 재설계

사용자 발의 (2026-05-06): "Roadmap/v{X.Y}_milestone/n개 Plan/각 Plan의 Phase 이런식으로 관리하고 싶은데"

이 제안의 핵심 전환:

- **계층 추가** (2-tier → 4-tier): ROADMAP / milestone / PLAN / phase
- **PLAN 다수화**: 1 milestone 안에 N PLAN. milestone PLAN은 4 PLAN 사전 선언만.
- **vX.Y 통합**: milestone 식별자가 vX.Y_{slug} (sessions/meta/와 통합 번호 공간, 단조 증가).
- **5-Stage 명시화**: ROADMAP / milestone / PLAN / phase / push+merge 5 stage.

## 결과

### Forward 효과

1. **ROADMAP 크기 축소**: §8 "최근 완료"는 milestone 단위 1 row (phase 상세는 milestone REPORT 위임). v1.83 직전 §8 ~250 rows → milestone-summary로 ~50% 감소 목표 (plan-2-roadmap-redesign에서 적용).
2. **버전 관리 단조성**: vX.Y 단일 번호 공간. v1.0~v1.82 (sessions/meta/) + v1.84+ (milestones/) 통합. v1.83은 폐기로 부재.
3. **PLAN 다수화의 자유도**: 1 milestone 안에 관련 작업을 N PLAN으로 묶음. 각 PLAN은 독립 PLAN.md+REPORT.md (가벼운 §). milestone PLAN은 무거운 § + 사전 선언만.
4. **Stage E push/merge 명시**: 사용자 확인 후 push (사용자 personal CLAUDE.md "커밋·배포 전 확인 요청" 정합).

### Backward 영향

- **Legacy sessions/meta/v1.0~v1.82**: forward-only soft-skip (smoke `LEGACY_REPORTS` 패턴 답습). 신규 작성 금지, ROADMAP만 유지.
- **sessions/meta/v1.83**: revert로 부재.
- **projects/<name>/ROADMAP.md**: 기존 evidence-driven 적용 (v1.36+). milestone 적용은 후속 `project-workflow-extension` (evidence-driven, 사용자 진행 결정 시).
- **smoke**: smoke 4종 (`cross-ref`, `scope-contract`, `spec-verification`, `claude-md-drift`) glob에 `milestones/v{X.Y}_*/` 추가 (plan-3-smoke-verify에서 적용).

### Trade-offs

| 영역 | v1.83 (폐기) | v1.84 (본 ADR) |
|------|------------|---------------|
| 계층 | 2 (milestone / phase) | 4 (ROADMAP / milestone / PLAN / phase) |
| PLAN 다수화 | × (phase별 1 PLAN) | ✓ (milestone당 N PLAN) |
| ROADMAP 단계 | 단계 3에서만 | Stage A 전면 |
| push/merge | 묵시적 | Stage E 명시 |
| 식별자 | M{N} (창설 순서) | vX.Y_{slug} (단조 증가) |
| 번호 공간 | sessions/meta/와 별도 | sessions/meta/와 통합 |
| ROADMAP §8 | phase별 1 row (누적) | milestone별 1 row (~50% 감소) |
| dogfood | M1-milestone-phase-infra (1 phase) | v1.84_workflow-revamp (4 PLAN, 7 phase) |

**복잡도 증가**: 4-tier는 2-tier보다 디렉토리 깊이 +2. 단 milestone PLAN의 사전 선언 표가 N PLAN을 한 시각에 보여주므로 navigation 부담 작음.

**M-번호 폐기의 영향**: v1.83에서 도입했던 M-번호 정책 (`^M[1-9][0-9]*$`, 창설 순서)은 폐기. 단 vX.Y 통합은 sessions/meta/ legacy + milestones/ 신규의 번호 공간을 일원화하는 장점 큼.

## Forward path

본 ADR을 정의하는 milestone(v1.84_workflow-revamp) 자체가 새 워크플로우의 첫 dogfood:

- 4 PLAN: plan-1-infra (3 phase) / plan-2-roadmap-redesign (1) / plan-3-smoke-verify (2) / plan-4-dogfood (1)
- 8 commit on branch (revert + milestone PLAN + 7 phase)
- Stage E에서 main 머지 → 사용 시작

후속 milestone (v1.85+)부터 본 흐름을 기본 적용.

**현재 era 정책 (v3.0+)**: 본 ADR-006 (v1.84_workflow-revamp 시점 4-tier era 도입) 이후 워크플로우는 v1.0_workflow-redesign (7-stage 도입) → v2.0_workflow-word-fidelity (9-stage 단어 부합) → v3.0_milestones-restructure (9-stage-bundled hierarchy) 로 발전. 4 era 공존 (4-tier / 7-stage / 9-stage / 9-stage-bundled, forward-only). 정전 정책: [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 6.1.

## 관련 문서

- 운영 흐름: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) (v3.0+ 9-stage-bundled era — § 4.1 Bundling)
- 본 milestone PLAN: [`../../projects/meta/milestones/v1.84_workflow-revamp/PLAN.md`](../../projects/meta/milestones/v1.84_workflow-revamp/PLAN.md)
- v1.83 폐기 commit: `295bd16` (revert)
- v1.83 원본 (history only): `d8ada7b` (PR #1 squash merge, revert됨)
