# PROPOSE — v3.5 open-stage-discipline-strengthening

```json
{
  "version": "v3.5",
  "id": "open-stage-discipline-strengthening",
  "next_candidates": [
    {
      "version": "v3.6",
      "id": "milestones-md-validation-extension",
      "title": "milestones.md 검증 확장 — orphan 디렉토리 검출 + sub_milestones[] schema 검증 (bundle 후보)",
      "summary": "v3.5 INTENT.out_of_scope #1 + #3 의 직접 후속 + RESEARCH options #3 + DESIGN R5 등재 권고. sub-milestone 2건 통합 후보. (1) **orphan 디렉토리 검출 (inverse drift)** — projects/<name>/milestones/v{X.Y}/ 디렉토리 존재하나 ROADMAP entry 부재인 경우 검출 (현 smoke-bundle-trigger + smoke-open-stage-discipline 모두 ROADMAP → 디렉토리 또는 디렉토리 → milestones.md 방향만 검증, 디렉토리 → ROADMAP 역방향 미커버). (2) **milestones.md sub_milestones[] schema 검증** — 본 milestone v3.5 phase-2 에서 Stage D 단계 milestones.md sub_milestones 동기 갱신 의무 명시했으나, sub_milestones[] 필드 (phase / title / status / commit) 정합 자동 검증 부재. v3.6 bundle 단일 milestone 통합 후보 — 같은 모듈 (tests/ smoke 인프라) + 같은 주제 (milestones.md 와 관련 검증 확장) + 두 sub-milestone 모두 v3.5 의 검증 책임 경계 직접 확장.",
      "trigger": "B_regression",
      "trigger_type": "v3.5 out_of_scope #1 + #3 / DESIGN R5"
    },
    {
      "version": "v3.7",
      "id": "workflow-narrative-strengthening-v2",
      "title": "workflow narrative 강화 v2 — INTENT motivation phrasing 정합 + violation 주입 cp949 mojibake standard step (bundle 후보)",
      "summary": "v3.5 lessons L3 (INTENT.motivation 의 RESEARCH 후 미세 조정 의무) + L5 (cp949 mojibake 반복 발견) bundle 후보. sub-milestone 2건. (1) **claude/commands/harness-meta.md Stage B INTENT 작성 narrative 보강** — 'RESEARCH 단계 codebase deep dive 결과 motivation phrasing 미세 조정 빈발' 명시 + Stage C → B 역방향 흡수 narrative 강화. (2) **tests/CLAUDE.md § '회귀 검증 절차' 신규 smoke 추가 절차 5번** — violation 주입 시 cp949 mojibake 정상 출력 narrative standard step 명시 (v3.1 L5 + v3.5 L5 반복 → 회피 가능한 인지 부담). 두 sub-milestone 모두 narrative 강화 (자동 강제 부재) + 같은 주제 (workflow 작성 가이드 강화). v3.6 (milestones-md-validation-extension) 와는 주제 grouping 다름 (자동 강제 vs narrative 강화) — v3.7 별 milestone 운용 (smoke-bundle-trigger 가 같은 version 2건 검출 자동 강제).",
      "trigger": "C_improvement",
      "trigger_type": "v3.5 lessons L3 + L5"
    }
  ],
  "propose_summary": "v3.5 의 forward 후속 — 2 candidates 등재 (v3.6 + v3.7 minor bump 분리). v3.6_milestones-md-validation-extension (B_regression, v3.5 out_of_scope 의 자동 검증 확장 후속) 와 v3.7_workflow-narrative-strengthening-v2 (C_improvement, lessons L3 + L5 narrative 강화). **분리 운용 의사 결정 narrative**: 초안에서 두 후보 모두 v3.6 minor bump 시도했으나 Stage G commit 시점 `smoke-bundle-trigger.sh` 가 같은 version 값 2건 검출 → bundling 정책 (ARCHITECTURE.md § 6.1 'version 단위 1 milestone') 강제. 두 sub-milestone 의 주제 grouping 다름 (자동 강제 vs narrative 강화) → 별 version (v3.6 + v3.7) 분리 자연. **smoke 의 자동 강제력이 PROPOSE 의 분기점에서 직접 작동한 첫 사례** (v3.5 L8 추가 lessons). v3.5 자체는 bundle 의 두 번째 사례 (v3.1 첫) — bundling 정책 누적 검증 완료."
}
```

## 후속 등재 narrative

### v3.6 (1) milestones-md-validation-extension

본 v3.5 의 검증 책임 경계 (디렉토리 → milestones.md 방향) 확장:

- **inverse drift** — `projects/<name>/milestones/v{X.Y}/` 디렉토리 존재하나 ROADMAP entry 부재 (또는 status: pending 인데 디렉토리 + milestones.md 모두 존재) — 현 smoke 미커버.
- **schema 검증** — `milestones.md` 안 `sub_milestones[]` 필드 정합 (phase 단조 / title non-placeholder / status pending|in_progress|complete / commit null|hash 형식). 본 milestone phase-2 의 Stage D 신규 step 의 사후 검증 책임.

두 후보 같은 의미 grouping (milestones.md 와 관련 검증 확장 + tests/ 모듈) → v3.6 bundle 단일 milestone 운용 권고.

### v3.7 workflow-narrative-strengthening-v2

- **L3 흡수** — Stage B INTENT 작성 시 RESEARCH 후 motivation phrasing 미세 조정이 빈발. claude/commands/harness-meta.md Stage B 절차에 'RESEARCH 후 INTENT 미세 조정 의무' 명시 권고.
- **L5 흡수** — violation 주입 cp949 mojibake 가 v3.1 + v3.5 반복 발견. tests/CLAUDE.md § '회귀 검증 절차' 안 standard step 명시 (현재는 § '흔한 함정' 6번 + controlled 비교 narrative 안 산재).

두 후보는 narrative 강화 (자동 강제 부재) + 같은 주제 (workflow 작성 가이드). v3.7 단일 bundle 운용 권고 (자동 강제 후보 v3.6 와 주제 grouping 분리).

### 분리 운용 narrative (smoke 자동 강제 의사 결정)

초안에서 두 후보 모두 v3.6 minor bump 시도. Stage G commit 시점 `smoke-bundle-trigger.sh` 가 같은 version 값 2건 검출 → bundling 정책 (ARCHITECTURE.md § 6.1 'version 단위 1 milestone') 자동 강제. 두 후보의 주제 grouping 다름 (자동 강제 vs narrative 강화) → 별 version 분리 자연. **smoke 의 자동 강제력이 PROPOSE 단계 의사 결정 분기점에서 직접 작동한 첫 사례** — REPORT lessons_learned L8 신규 등재 가능.

## 다음 milestone OPEN 단계 결정 사항

다음 v3.6 + v3.7 OPEN 단계 각자:

- (1) v3.6 — sub-milestone phase 분할 확정 (orphan + schema 통합 단일 bundle)
- (2) v3.7 — sub-milestone phase 분할 확정 (narrative 강화 통합 단일 bundle)
- 우선순위 (v3.6 B_regression 선행 / v3.7 C_improvement 후속)

## 관련

- 1차 source: [`REPORT.md`](REPORT.md) lessons_learned + [`INTENT.md`](INTENT.md) out_of_scope
- 부모: [`../v3.4/PROPOSE.md`](../v3.4/PROPOSE.md) (v3.5 등재 원본)
- bundling 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
