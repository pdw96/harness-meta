# INTENT — v3.0_milestones-restructure

```json
{
  "version": "v3.0",
  "id": "milestones-restructure",
  "title": "milestone hierarchy 재구성 — version > sub-milestone > phase + v2.2_* 4건 흡수",
  "goal": "ROADMAP `milestones[]` schema 의 version+id 분리 + 디렉토리 구조 milestones/v{X.Y}/ + milestones.md (sub-milestone listing per version) 도입으로 동일 X.Y 후속 candidates 의 통합 milestone 운용을 가능케 하고, 그 자기참조 첫 적용 사례로 v2.2_* 4건 (era-detect-shared-module / smoke-cp949-encoding-pattern / smoke-controlled-comparison-pattern / historical-7stage-stage1-decision) 을 v3.0 sub-milestone phase 5-8 로 흡수한다.",
  "motivation": "v2.2_* 4건 검토 round 중 사용자 통찰 (2026-05-10) — '같은 v2.2 인데 따로 실행하는 이유가 명명 구조 v{X.Y}_{slug} 자체 때문이다'. 동일 X.Y 후속 candidates 가 별도 milestone 으로 분리 강제되면 (a) 토큰 비효율 (각자 INTENT~PROPOSE 8 산출 = 4 × 8 = 32 산출물 vs 통합 8 산출물 = 75% 감소), (b) merge conflict 위험 (예: v2.2_smoke-cp949-encoding-pattern + v2.2_smoke-controlled-comparison-pattern 모두 tests/CLAUDE.md 수정), (c) 의존 관계 표현 어려움 (예: v2.2_historical-7stage-stage1-decision 는 v2.2_era-detect-shared-module 의 분리 모듈 위에 작업해야 함). 5요소 매트릭스 'Workflow' 정전 — '단어=책임 1:1' 정합 보존하면서 묶을 수 있는 단위 (= version) 도입. 통합 milestone (1 INTENT + N phase commit) 로 표현 가능. 자기참조 부합 (도그푸드) — v3.0 자체가 신 구조 (milestones/v3.0/ + milestones.md) 첫 적용 사례, v2.0_workflow-word-fidelity 자기참조 회피 표지와 대조.",
  "success_criteria": [
    "ROADMAP `milestones[]` schema 변경: 모든 entry 가 `version` + `id` 분리 형식 (기존 `id: v{X.Y}_{slug}` flat 폐기, version 단위 1 entry — sub-milestone 상세는 milestones.md 위임)",
    "신 디렉토리 구조 milestones/v{X.Y}/ 마운트 가능 (자기참조: milestones/v3.0/ 자체 신 구조 작성, 예외 표지 없음)",
    "milestones/v{X.Y}/milestones.md 신규 파일 — sub-milestone listing per version (id/title/status/summary/dependencies/phase 매핑 JSON 코드블록)",
    "smoke era 분기 4 era 인식: 4-tier (v1.84~v1.88) / 7-stage (v1.0~v1.4) / 9-stage (v2.0~v2.1) / 9-stage-bundled (v3.0+) — smoke-spec-verification + smoke-scope-contract 모두 PASS",
    "정책 명문화 host 4곳: CLAUDE.md (root) / claude/commands/harness-meta.md (slash command) / projects/meta/ARCHITECTURE.md (정전 single source) / projects/meta/CLAUDE.md (subdirectory) — bundling trigger 조건 + version > sub-milestone > phase 계층 + forward-only 정책 + 자기참조 부합 권장",
    "v2.2_* 4건 흡수: ROADMAP entry 4건 제거 + v3.0 milestones.md sub-milestone phase 5-8 로 책임 완료 (era-detect / cp949 / controlled-comparison / historical-decision 각자 변경 적용)",
    "forward-only — historical milestone (v1.84~v1.88 4-tier, v1.0~v2.1 9-stage 이전) 디렉토리 명 unchanged + smoke 인식 유지",
    "pre-commit smoke 5 hook 모두 PASS, 회귀 0"
  ],
  "out_of_scope": [
    "historical milestone (v1.x ~ v2.1) retroactive renaming 또는 디렉토리 이동 (별도 milestone, 위험 큼)",
    "다른 pending milestone (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_legacy-narrative-cleanup / v1.5_research-cascade-grep-discipline / v2.1_pending-milestone-renumber-policy / v2.1_smoke-posttooluse-9stage-tests) 의 bundling 검토 — 별도 후속 milestone",
    "root `ROADMAP.md` (thin index, project 단위) schema 변경 — 본 milestone 은 milestone schema (`projects/<name>/ROADMAP.md`) 만 다룸",
    "upbit 프로젝트 ROADMAP schema 변경 — meta 정책 정착 후 별도 후속",
    "4-tier era milestone (v1.84~v1.88) 디렉토리 변경 (historical 보존)",
    "v3.0 sub-milestone (phase 5-8) 자체의 9-stage workflow 내부 적용 — sub-milestone 은 phase 단위 (1 commit) 로만 운용, 각자 INTENT/RESEARCH/DESIGN/APPROVE 산출 부재 (v3.0 통합 산출물에 흡수)",
    "기존 smoke 의 era 자동 식별 알고리즘 자체 재설계 (v2.0 detect_era 함수 + v2.1 batched python3 spawn 보존, 4 era 인식 패턴만 추가)"
  ],
  "dependencies": {
    "predecessors": [
      "v2.0_workflow-word-fidelity (2026-05-10) — 9-stage workflow 정착, 본 milestone 의 sub-milestone 단위 (= phase) 매핑 기반",
      "v2.1_smoke-spawn-batching (2026-05-10) — smoke 인프라 (era 자동 식별, batched python3 spawn) 기반, 본 milestone 의 era 분기 4 era 확장",
      "v2.2_era-detect-shared-module (pending → 흡수 phase-5)",
      "v2.2_smoke-cp949-encoding-pattern (pending → 흡수 phase-6)",
      "v2.2_smoke-controlled-comparison-pattern (pending → 흡수 phase-7)",
      "v2.2_historical-7stage-stage1-decision (pending → 흡수 phase-8)"
    ],
    "successors": []
  }
}
```

## 의도

사용자 발의: **"milestone에서 같은 버전인데 다 따로 실행해야하는 이유를 모르겠어."** (2026-05-10) — v2.2_* 4건 OPEN 검토 중.

사용자 통찰 도출 round (4회):

1. **"v2.2_* 4건 따로 실행 이유?"** → 분석 결과 단순 분리는 토큰 비효율 (4× 산출물) + merge conflict (tests/CLAUDE.md 동시 수정 사례) + 의존 관계 표현 어려움.
2. **"통합 한 건에 phase로 구분?"** → bundle 정책 + 자기참조 부합 결정 (5 phase 구조, v2.0 자기참조 회피 선례와 대조).
3. **"명명 구조가 root cause?"** → `v{X.Y}_{slug}` 자체가 같은 X.Y 후속을 별 milestone 으로 분리 강제. 명명 구조 변경 (B 옵션 — `v{X.Y}_{group-slug}` + `phase-{n}`) + forward-only + breaking change → v3.0.
4. **"ROADMAP에서 version과 id 분리 + milestones.md?"** → schema 변경 + 디렉토리 구조 변경 (milestones/v{X.Y}/ + milestones.md sub-milestone listing). 8 phase scope (정책 4 + 흡수 4) 한 milestone (자기참조 부합).

본 milestone 은 단순히 v2.2_* 4건의 통합이 아니라, **명명/schema/디렉토리 자체의 재구성**으로 향후 모든 후속 candidates 의 통합 milestone 운용을 가능케 한다. v2.0_workflow-word-fidelity 가 7-stage → 9-stage 단어 책임 정정 (워크플로우 dimension) 이었다면, v3.0 은 milestone hierarchy 정정 (구조 dimension) — 동일 정신의 자연스러운 후속.

자기참조 부합 — milestones/v3.0/ 자체가 신 구조 첫 적용 사례. v2.0 의 자기참조 회피 표지 (예외 7-stage 포맷) 와 대조하여 도그푸드 우선. INTENT~APPROVE 산출물도 milestones/v3.0/ 신 구조에서 작성 (uncommitted), EXECUTE phase-1 (smoke era branching 선결) 후 phase-2 에서 commit.

## 검증 가능한 게이트

success_criteria 8건 모두 자동 측정 가능:

- schema 1건: `python3 -c "import json; data=json.load(open('projects/meta/ROADMAP.md'))"` 후 모든 entry `version` + `id` 분리 확인
- 디렉토리 1건: `Test-Path milestones/v3.0/` 및 INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE.md 존재
- milestones.md 1건: `Test-Path milestones/v3.0/milestones.md` + JSON parse 후 sub-milestones[] 8건 (phase-1~8)
- smoke era 1건: smoke-spec-verification + smoke-scope-contract 가 4 era 모두 PASS (4-tier / 7-stage / 9-stage / 9-stage-bundled)
- 정책 명문화 1건: 4 host (CLAUDE.md / harness-meta.md / ARCHITECTURE.md / projects/meta/CLAUDE.md) grep 으로 bundle 정책 + version 계층 + forward-only + 자기참조 부합 패턴 확인
- 흡수 1건: ROADMAP에서 v2.2_* 4건 부재 + v3.0 milestones.md sub-milestone phase 5-8 = 4건 존재 + 각자 변경 commit 적용
- forward-only 1건: historical milestone 디렉토리 명 unchanged (`git diff --name-only HEAD~ HEAD -- milestones/v1.* milestones/v2.0_* milestones/v2.1_*` empty 또는 README 같은 비구조 변경만)
- 회귀 1건: `pre-commit run --all-files` PASS, smoke 5 hook 모두 통과

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 5요소 매트릭스 + § 6 era 정책 (본 milestone 후 4 era — 4-tier / 7-stage / 9-stage / 9-stage-bundled)
- slash command: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
- subdirectory CLAUDE.md: [`../../CLAUDE.md`](../../CLAUDE.md)
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
- 선행 milestone:
  - [`../v2.0_workflow-word-fidelity/REPORT.md`](../v2.0_workflow-word-fidelity/REPORT.md) — 9-stage workflow 정착 + 자기참조 회피 표지 선례
  - [`../v2.1_smoke-spawn-batching/REPORT.md`](../v2.1_smoke-spawn-batching/REPORT.md) — smoke 인프라 (batched python3 spawn + era 자동 식별)
- 흡수 대상 (pending → v3.0 sub-milestone):
  - v2.2_era-detect-shared-module → phase-5
  - v2.2_smoke-cp949-encoding-pattern → phase-6
  - v2.2_smoke-controlled-comparison-pattern → phase-7
  - v2.2_historical-7stage-stage1-decision → phase-8
