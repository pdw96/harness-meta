# INTENT — v3.5 open-stage-discipline-strengthening

```json
{
  "version": "v3.5",
  "id": "open-stage-discipline-strengthening",
  "title": "OPEN/DESIGN stage milestones.md 동시 생성 절차 강화 — cascade 검증 smoke + Stage D narrative 동기 (bundle)",
  "goal": "v3.4 Stage A step 7 ('milestones.md 스켈레톤 즉시 작성') 의 narrative 강제만으로는 누락 검출 불가한 갭 — 디렉토리 ↔ milestones.md 페어링 — 을 (1) cascade 검증 smoke 와 (2) Stage D 절차 narrative 동기 갱신으로 메워, '9-stage-bundled era 디렉토리 (^v\\d+\\.\\d+$) ↔ milestones.md 페어링 자동 강제' + 'Stage D phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신 narrative 자동 강제' 두 의무를 달성한다.",
  "motivation": "v3.4 lessons L1 + L3 직접 후속. v3.4 phase-1 은 narrative 강제 (`harness-meta.md` Stage A step 7) 만 도입했고 자동 검증은 v3.1 도입 `smoke-bundle-trigger.sh` 의 status: in_progress 분기에 위임. (1) 그러나 smoke-bundle-trigger 는 ROADMAP entry schema → 실 파일 방향 (entry 가 milestones_path 보유 시 실 파일 검증) 만 커버. 진짜 갭은 **반대 방향** — 디렉토리 `v{X.Y}/` 생성됐으나 milestones.md 부재 + ROADMAP entry 자체 누락 (예: 사용자가 디렉토리만 만들고 step 6+7 누락) → smoke-bundle-trigger 트리거 부재 + `tests/_era_detect.py:27` 의 9-stage-bundled 표지 (디렉토리명 + milestones.md) 미충족 → era 오인 → smoke-spec-verification / smoke-scope-contract skip → 침묵 통과. (2) v3.4 step 7 narrative 안 'Stage D 단계에서 milestones.md sub_milestones 동기 갱신' cross-ref 있으나 Stage D 절차에는 미명시 → Stage A 의 placeholder title 이 Stage D 후에도 stale 잔존 가능. 두 갭 모두 bundle 한 milestone 에서 의미 grouping (OPEN/DESIGN 절차 강제) 으로 처리.",
  "success_criteria": [
    "OPEN 단계 종료 시점 '디렉토리 ↔ milestones.md 페어링 부재' 를 smoke 가 자동 검출 (디렉토리 명 `^v\\d+\\.\\d+$` 매칭 후 milestones.md 부재 시 FAIL) — `tests/_era_detect.py:27` 9-stage-bundled 표지와 1:1 정합",
    "Stage D 절차 narrative 에 'phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신' step 신규 명시 + Stage A step 7 와 cross-ref",
    "pre-commit 13 hook (또는 신규 smoke 도입 시 14 hook) 모두 PASS",
    "본 milestone 의 OPEN 단계 자체가 자기참조 부합 (이미 충족 — Stage A 종료 시점 3 조건 모두 보유)",
    "DESIGN 5 관점 (범위가 ≤5 파일이면 3 관점, 6~15 파일이면 4 관점) 병렬 검토 모두 pass 또는 pass-with-comments + 의견 충돌 시 사용자 결정 게이트",
    "VERIFY.criteria_check 가 본 success_criteria 와 1:1 매핑 PASS + 회귀 0"
  ],
  "out_of_scope": [
    "ROADMAP entry status: pending 인 milestone 의 milestones_path 부재 검증 (스펙상 pending → continue 허용 — v3.1 L2 mitigation 분기)",
    "v2.0~v2.1 9-stage 보존 era + v1.0~v1.4 7-stage 보존 era + v1.84~v1.88 4-tier era 의 milestones.md 부재 (forward-only 정책, v3.0 D12 + v3.1 L2)",
    "smoke 의 검증 책임을 'milestones.md 본문 schema 검증 (sub_milestones[] 필드 정합)' 까지 확장 (책임 분리 — schema 검증은 별도 smoke 후보 또는 _era_detect.py 책임)",
    "Stage D 외 다른 stage 에서 milestones.md sub_milestones 갱신 시점 명시 (Stage D phases[] 확정 시점만)",
    "사용자 명시 승인 없이 신규 smoke 의 pre-commit 자동 등록 (Stage E APPROVE 게이트 통과 후 결정)"
  ],
  "dependencies": [
    "v3.4_open-stage-milestones-md-protocol (직속 부모, Stage A step 7 narrative + Stage D cross-ref 발원)",
    "v3.1_workflow-policy-fine-tuning (smoke-bundle-trigger.sh 도입 부모, 본 milestone phase-1 옵션 (b) 의 확장 대상)",
    "v3.0_milestones-restructure (9-stage-bundled era 도입 + _era_detect.py 분리 + milestones.md 도입)"
  ]
}
```

## 의도 narrative

### v3.4 의 갭 (lessons L1)

v3.4 phase-1 은 `claude/commands/harness-meta.md` Stage A 에 step 7 ('milestones.md 스켈레톤 즉시 작성') 을 신규 추가했다. 이는 narrative 강제 (절차 명문화) 다. 그러나 자동 검증은 v3.1 도입 `tests/smoke-bundle-trigger.sh` 의 분기 로직에 위임됐다.

분기 로직:

- ROADMAP entry status: `pending` → continue (검증 없음)
- status: `in_progress` 또는 `completed` → `milestones_path` 필드 + 실 파일 존재 검증

문제: Stage A step 7 누락 시나리오 — Claude 가 step 5 (디렉토리 생성) + step 6 (ROADMAP entry 추가, status: in_progress) 후 step 7 (milestones.md 작성) 만 누락하면 다음 둘 중 하나:

1. step 6 에서 `milestones_path` 필드까지 추가했으면 → smoke 가 실 파일 부재 검출 → FAIL 신호 (OK)
2. step 6 에서 `milestones_path` 필드 누락한 채 status: in_progress 로만 추가했으면 → smoke 가 status: in_progress 인데 `milestones_path` 부재 자체를 FAIL 시그널로 처리하는지 미확인 → RESEARCH 단계에서 확정

즉 smoke-bundle-trigger 의 검증 책임 경계를 RESEARCH 단계에서 정확히 확인 + (확장 vs 신규) 옵션 결정 필요.

### v3.4 의 갭 (lessons L3)

v3.4 step 7 narrative 안 placeholder title 정당화: "OPEN 시점에서는 정확한 phase 분할 미확정 — phase-1 title placeholder 허용, Stage D DESIGN 단계에서 phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신". 이는 step 7 입장에서 forward cross-ref 다.

문제: Stage D 절차 자체 (`harness-meta.md` 의 Stage D 섹션) 에는 'milestones.md sub_milestones 동기 갱신' step 미명시. 즉 backward cross-ref 부재. Stage A 의 placeholder 가 Stage D 후에도 갱신 안 된 채 잔존 가능.

→ Stage D 절차에 'phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신' step 신규 추가 + Stage A step 7 양방향 cross-ref.

### bundle 정당화 (의미 grouping)

두 sub-milestone 모두:

- 같은 부모 (v3.4 lessons)
- 같은 모듈 (`claude/commands/harness-meta.md` + `tests/`)
- 같은 주제 (OPEN/DESIGN 단계 milestones.md 강제)

→ v3.0+ 9-stage-bundled era 의 bundle trigger 부합 — version 단위 1 milestone 운용 (ARCHITECTURE.md § 6.1).

## 자기참조 부합 (도그푸드)

본 milestone 의 OPEN 단계는 v3.4 Stage A step 7 첫 자기참조 적용 사례 — `milestones/v3.5/milestones.md` skeleton 이 Stage A 종료 시점에 작성됨 (3 조건 충족). 본 milestone 결과물 (phase-1 smoke 도입 / phase-2 Stage D narrative) 도 본 milestone 자체에 즉시 적용된다.

## 관련

- 직속 부모: [`../v3.4/REPORT.md`](../v3.4/REPORT.md) (L1 + L3)
- skeleton 1차 source: [`milestones.md`](milestones.md)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (v3.5)
- 워크플로우 진입점: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md) — phase-2 갱신 대상
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 + § 6.1
