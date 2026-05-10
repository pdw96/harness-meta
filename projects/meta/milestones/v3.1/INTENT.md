# INTENT — v3.1_workflow-policy-fine-tuning

```json
{
  "version": "v3.1",
  "id": "workflow-policy-fine-tuning",
  "title": "v3.0 bundling 정책 첫 후속 적용 — markdownlint trap / milestones.md historical / bundling trigger smoke",
  "goal": "v3.0_milestones-restructure 직접 후속 3건 (markdownlint MD032/MD049 함정 narrative / milestones.md spec 의 historical era 적용 결정 / bundling trigger 의미 단위 grouping 자동 검증 smoke) 을 v3.0+ 9-stage-bundled era 정책의 첫 후속 통합 milestone (sub-milestone 3건 = phase 매핑) 으로 적용하여 도그푸드 운영 신뢰를 누적하고, tests/ 모듈 안 정책 fine-tuning 의 의미 단위 grouping 첫 사례를 박는다.",
  "motivation": "v3.0 lessons_learned L10 (markdownlint MD032/MD049 trap — `v{X.Y}_{slug}` underscore emphasis 오인 + APPROVE/DESIGN list 앞뒤 빈 줄 부재) 발견 직후 별 narrative 추가 후보. v3.0 PROPOSE next_candidates 3건 (`v3.1_markdownlint-trap-narrative` / `v3.1_milestones-md-spec-formalization` / `v3.1_smoke-bundle-trigger-validation`) 모두 같은 X.Y (v3.1) + 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) 영향 — bundling trigger 조건 (의미 단위 grouping) 자체가 만족하므로 v3.0 도그푸드 첫 후속 적용 사례. 분리 시 (a) 토큰 비효율 (3× INTENT~PROPOSE 산출 = 24 산출물 vs 통합 8 산출물 = 67% 감소), (b) 작은 narrative/smoke 변경 3건이 각자 5 관점 검토 + APPROVE 게이트 반복, (c) 의존 관계 표현 어려움 (sub-milestone 1 의 markdownlint 함정 narrative 가 sub-milestone 3 smoke 입력일 가능성). v3.0 정책 자기참조 부합 — `~/harness-meta/projects/meta/ARCHITECTURE.md` § 6.1 bundling trigger 조건 적용. 5요소 매트릭스 'Constraint' 정전 — markdownlint 자동 차단 + bundling smoke 자동 검증 으로 narrative-only 정책의 자동 강제 누적.",
  "success_criteria": [
    "tests/CLAUDE.md § '흔한 함정' 7번째 항목 추가 — markdownlint MD032 (blanks-around-lists) + MD049 (emphasis-style underscore) 두 패턴 narrative + 회피 권고 (백틱 escape `v{X.Y}_{slug}` + 강조 직후 list 앞뒤 빈 줄)",
    "milestones.md spec 의 historical era 적용 정책 결정 명문화 — projects/meta/ARCHITECTURE.md § 6.1 (또는 milestones.md spec 자체) 에 forward-only 강제 (옵션 a) vs v2.x retroactive (옵션 b) vs 신규만 (옵션 c) 결정 + rationale narrative",
    "bundling trigger 의미 단위 grouping 자동 검증 smoke 추가 — ROADMAP `milestones[]` 안 같은 X.Y entry 가 부재 (v3.0+ 신 schema, version 단위 1 entry) 또는 동일 의미 단위 grouping 권고 narrative 매칭 검사 (신규 smoke 또는 기존 smoke 확장)",
    "smoke 추가/확장 시 batched python3 spawn 패턴 (v2.1) + cp949 reconfigure errors='replace' (v3.0 phase-6 흡수) + controlled 비교 4-step (v3.0 phase-7 흡수) 모두 적용",
    "milestones/v3.1/milestones.md 신규 — sub-milestone 3건 (markdownlint-trap-narrative / milestones-md-historical-decision / bundle-trigger-smoke) listing per version + spec picture-frame reference (v3.0 milestones.md spec section)",
    "v3.0 정책 자기참조 부합 (도그푸드) — milestones/v3.1/ 자체 신 구조 (sub-id 부재) + bundling 사례 narrative 보존",
    "pre-commit smoke 12 hook 모두 PASS (v3.0 baseline 유지) + 신규 bundling smoke 추가 시 12 → 13 hook 또는 기존 smoke 확장",
    "회귀 0 — historical milestone 디렉토리 (v1.84~v2.1) unchanged, smoke 4 era 분기 동치 (4-tier / 7-stage / 9-stage / 9-stage-bundled)"
  ],
  "out_of_scope": [
    "milestones.md spec historical 적용 결정이 옵션 (b) v2.x retroactive 일 경우의 실제 retroactive 작업 — 결정만 본 milestone, 실제 retroactive 마이그레이션은 별도 후속",
    "다른 pending milestone (v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_legacy-narrative-cleanup / v1.5_research-cascade-grep-discipline / v2.1_pending-milestone-renumber-policy / v2.1_smoke-posttooluse-9stage-tests) 의 bundling 검토 — 별 후속 milestone (의미 단위 grouping 부적합)",
    "markdownlint MD032/MD049 외 다른 markdownlint 규칙 (MD040 fenced-code-language / MD003 heading-style / 등) 자동 강제 — 본 milestone 은 v3.0 phase-3 발견 두 규칙만 다룸",
    "bundling trigger smoke 가 의미 단위 grouping 의 모든 휴리스틱 (모듈 분류 / 주제 추론) 자동 판정 — 보수적 검사 (같은 X.Y 신 schema 위반 / 동일 모듈 narrative 매칭 정도) 만, AI 판정은 out_of_scope",
    "milestones.md spec 자체의 schema 변경 (sub_milestones[] 필드 추가/제거) — v3.0 phase-5 spec 보존, 본 milestone 은 적용 era 정책만",
    "root `ROADMAP.md` (thin index) schema 변경 — 본 milestone 은 milestones[] schema (`projects/<name>/ROADMAP.md`) 만",
    "upbit 또는 신규 프로젝트의 milestones.md 도입 — meta 정책 정착 후 별 후속"
  ],
  "dependencies": {
    "predecessors": [
      "v3.0_milestones-restructure (2026-05-10, completed) — 9-stage-bundled era 도입 + milestones.md spec + bundling 정책 narrative + tests/_era_detect.py 단일 source. 본 milestone 은 v3.0 PROPOSE next_candidates 3건 + lessons L10 의 직접 후속.",
      "v2.1_smoke-spawn-batching (2026-05-10, completed) — smoke batched python3 spawn 패턴 + cp949 reconfigure errors='replace' (v3.0 phase-6 흡수). 신규 bundling smoke 작성 시 표준 절차."
    ],
    "successors": []
  }
}
```

## 의도

v3.0_milestones-restructure 의 직접 후속 — v3.0 PROPOSE 에 등록한 3건 (`v3.1_markdownlint-trap-narrative` / `v3.1_milestones-md-spec-formalization` / `v3.1_smoke-bundle-trigger-validation`) 모두 같은 X.Y (v3.1) + 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) 영향. v3.0 ARCHITECTURE.md § 6.1 bundling trigger 조건 (의미 단위 grouping) 자체가 만족 → 통합 milestone 운용 의무.

본 milestone 은 v3.0 정책의 **첫 후속 통합 milestone 사례** — v3.0 자체는 자기참조 부합 (도그푸드) 으로 v3.0 신 구조에 작성됐지만, v3.0 종결 후 별도 milestone 에서 통합 운용을 처음 적용. v3.0 통합이 8 phase (정책 4 + 흡수 4) 였다면, v3.1 통합은 3 phase (sub-milestone 3건) 의 **소규모 사례** — bundling 정책의 일상 운용 패턴을 박는다.

3 sub-milestone 책임:

1. **phase-1 markdownlint-trap-narrative**: v3.0 lessons L10 직접 후속. tests/CLAUDE.md § '흔한 함정' 7번째 항목 추가 (백틱 escape + 강조 직후 빈 줄). narrative-only — 자동 강제 부재.
2. **phase-2 milestones-md-historical-decision**: milestones.md spec 의 historical era (v2.0~v2.1, v1.0~v1.4) 적용 정책 결정. 옵션 (a) forward-only 강제 / (b) v2.x retroactive / (c) 신규만. 결정 + rationale narrative 박음. design_decision 만 — 실제 retroactive 작업 out_of_scope.
3. **phase-3 bundle-trigger-smoke**: bundling trigger 의 ROADMAP 자동 검증. 같은 X.Y 안 v3.0+ 신 schema 위반 (다중 entry) 또는 의미 단위 grouping 권고 매칭 검사 smoke. policy_enforcement.

## 검증 가능한 게이트

success_criteria 8건 모두 자동 측정 가능:

- 7번째 항목 narrative 1건: `grep -E '^### 7\\.' tests/CLAUDE.md` + MD032/MD049 키워드 매칭
- historical 결정 1건: `grep -E '(forward-only|retroactive)' projects/meta/ARCHITECTURE.md` + 결정 narrative 존재
- bundling smoke 1건: `tests/smoke-*.sh` 안 신규 또는 확장 + ROADMAP 같은 X.Y 신 schema 위반 검출 PASS
- 표준 절차 1건: 신규 smoke 가 batched python3 / cp949 / controlled 비교 4-step 모두 적용 (audit `smoke-python-entry-boilerplate` PASS)
- milestones.md 1건: `Test-Path milestones/v3.1/milestones.md` + JSON parse + sub_milestones[] 3건
- 자기참조 부합 1건: `Test-Path milestones/v3.1/` (sub-id 부재 디렉토리) + INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE.md 존재
- pre-commit 1건: `pre-commit run --all-files` PASS
- 회귀 1건: `git diff --stat HEAD~ HEAD -- projects/meta/milestones/v1.* projects/meta/milestones/v2.*` empty (historical 디렉토리 unchanged)

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1 bundling 정책
- slash command: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
- subdirectory CLAUDE.md: [`../../CLAUDE.md`](../../CLAUDE.md)
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
- 선행 milestone:
  - [`../v3.0/REPORT.md`](../v3.0/REPORT.md) — milestone hierarchy 재구성 + bundling 정책 + lessons L10
  - [`../v3.0/PROPOSE.md`](../v3.0/PROPOSE.md) — next_candidates 3건 (본 milestone 흡수)
  - [`../v3.0/milestones.md`](../v3.0/milestones.md) — milestones.md spec picture-frame reference
- 후속 흡수 대상 (PROPOSE 3건 → v3.1 sub-milestone):
  - v3.1_markdownlint-trap-narrative → phase-1
  - v3.1_milestones-md-spec-formalization → phase-2
  - v3.1_smoke-bundle-trigger-validation → phase-3
