# RESEARCH — v3.5 open-stage-discipline-strengthening

```json
{
  "version": "v3.5",
  "id": "open-stage-discipline-strengthening",
  "external": [
    {
      "source": "v3.4 REPORT.md lessons_learned",
      "topic": "L1 cascade smoke 부재 / L3 Stage D narrative 미명시",
      "findings": "L1: Stage A step 7 narrative 강제 자동 검출 부재. L3: Stage D 절차에 milestones.md sub_milestones 동기 갱신 step 미명시.",
      "drift": "본 milestone (v3.5) 의 직접 motivation. 두 lessons 모두 narrative 강제만 → cascade 검출 필요."
    },
    {
      "source": "v3.1 lessons L2 (CRITICAL)",
      "topic": "milestones.md 부재 시 era 오인 + smoke-bundle-trigger.sh status 분기",
      "findings": "milestones.md 부재 시 `tests/_era_detect.py` 가 9-stage-bundled 표지 미충족 → 9-stage / 7-stage / skip 오인. status: in_progress → milestones_path 필드 + 실 파일 검증 의무 (smoke-bundle-trigger).",
      "drift": "v3.5 의 phase-1 cascade smoke 의 검출 책임 경계 명확화 — bundle-trigger 가 이미 entry → 실 파일 방향은 검출. 신규 검증은 디렉토리 → entry 방향 (forward) 또는 디렉토리명 + milestones.md 페어링 검증."
    },
    {
      "source": "ARCHITECTURE.md § 6.1",
      "topic": "v3.0+ 9-stage-bundled era 디렉토리 구조 정의",
      "findings": "디렉토리 명 `v{X.Y}/` (sub-id 부재) + milestones.md (sub-milestone listing) 페어링 의무. forward-only 정책 (v2.0~v2.1 / v1.0~v1.4 / v1.84~v1.88 보존).",
      "drift": "9-stage-bundled era 의 디렉토리명 ↔ milestones.md 페어링 자동 검증 부재."
    }
  ],
  "codebase": {
    "affected_files": [
      "tests/smoke-open-stage-discipline.sh (신규, option (a) 선택 시)",
      "tests/smoke-bundle-trigger.sh (확장, option (b) 선택 시)",
      "tests/CLAUDE.md (smoke 매트릭스 1 row 추가 또는 기존 row narrative 갱신)",
      ".pre-commit-config.yaml (option (a) 시 hook 1건 추가, option (b) 시 entry 무변경)",
      "claude/commands/harness-meta.md (Stage D 절차 narrative 동기 갱신 — phase-2)",
      "projects/meta/milestones/v3.5/* (본 milestone 산출물 일체)"
    ],
    "untouched_files": [
      "tests/_era_detect.py (era 분류 책임 무변경 — D5/D15 일원화 source 보존)",
      "tests/smoke-spec-verification.sh + smoke-scope-contract.sh (era 분류 결과 활용만 — 디렉토리 ↔ milestones.md 페어링 검증은 본 milestone scope 외)",
      "ARCHITECTURE.md § 6.1 (era 정책 narrative 무변경 — phase-2 cross-ref 만 추가 후보)"
    ],
    "current_state": {
      "stage_a_step_7": "v3.4 도입 narrative 강제 — `claude/commands/harness-meta.md:86-106` Stage A step 7 명시 + Stage F 게이트 narrative 갱신 + skeleton 최소 필드 1차 source.",
      "smoke_bundle_trigger": "v3.1 도입 — `tests/smoke-bundle-trigger.sh:91-112` status 분기 (pending → continue / in_progress|completed → milestones_path 필드 + 형식 + 실 파일 검증).",
      "era_detect": "`tests/_era_detect.py:27` — 9-stage-bundled 표지: 디렉토리 명 `^v\\d+\\.\\d+$` + milestones.md 존재. 둘 중 하나 부재 시 다음 era 표지로 fallthrough.",
      "stage_d_narrative": "`claude/commands/harness-meta.md:138-167` Stage D 절차 — decisions/approach/phases/risk_mitigation + 5 관점 검토만 명시. milestones.md sub_milestones 동기 갱신 step 부재.",
      "stage_a_step_7_cross_ref": "Stage A step 7 안에 'Stage D DESIGN 단계에서 phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신' forward cross-ref 존재. 그러나 Stage D 절차에는 backward cross-ref 부재 (asymmetric)."
    },
    "target_state": {
      "stage_a_step_7": "narrative 무변경 — v3.4 도입 narrative 그대로 보존 (forward cross-ref 도 그대로).",
      "smoke_cascade_validation": "option (a) — tests/smoke-open-stage-discipline.sh 신규 도입. 책임: '9-stage-bundled era 디렉토리 ↔ milestones.md 페어링 자동 검증' (디렉토리 명 `^v\\d+\\.\\d+$` 이면서 milestones.md 부재 시 FAIL). bundle-trigger 와 책임 분리 (bundle-trigger 는 ROADMAP entry schema 검증, open-stage-discipline 은 디렉토리 페어링 검증).",
      "stage_d_step_added": "Stage D 절차에 신규 step (phases[] 확정 후) — 'milestones.md sub_milestones 1:1 동기 갱신' 명시 + Stage A step 7 와 backward cross-ref 추가.",
      "tests_clauder_md_matrix": "smoke 매트릭스 §'핵심 정책 검증' 표에 smoke-open-stage-discipline 1 row 추가. 회귀 차단 책임 narrative 명시.",
      "precommit_config": "option (a) 시 신규 hook 1건 추가 (active, --fix 미지원, direct entry, files: `'projects/.*/milestones/v[^/]+/.*'` 패턴)."
    }
  },
  "options": [
    {
      "name": "phase-1 option (a) — 신규 smoke 도입 (smoke-open-stage-discipline.sh)",
      "pros": [
        "책임 분리 명확: bundle-trigger 는 ROADMAP entry → 실 파일 방향, open-stage-discipline 은 디렉토리 → milestones.md 페어링 방향",
        "명명 의도 명확 (OPEN stage discipline 강제)",
        "tests/CLAUDE.md L208 책임 분리 규약 (V3.1 L3 D16) 정합",
        "향후 era 확장 (예: 10-stage) 시 본 smoke 만 분기 확장하면 됨"
      ],
      "cons": [
        "smoke 1건 증가 (28 → 29) + pre-commit hook 1건 증가 (6 → 7)",
        "_era_detect 와 일부 책임 중복 가능 (디렉토리명 regex 검사)"
      ]
    },
    {
      "name": "phase-1 option (b) — 기존 smoke-bundle-trigger 검증 책임 확장",
      "pros": [
        "smoke 개수 동일 (28 unchanged)",
        "단일 진입점"
      ],
      "cons": [
        "smoke 명명 'bundle-trigger' 와 'open-stage discipline' 책임 부정합 (bundling = ROADMAP entry 1:N 검증, open-stage = 디렉토리 페어링)",
        "tests/CLAUDE.md L208 책임 분리 규약 위배 (단일 smoke 에 두 책임 혼재 → 향후 era 추가 시 복잡도 누적)",
        "bundle-trigger 의 책임 2 (in_progress entry → 실 파일) 와 신규 책임 (디렉토리 → entry 역방향) 의 방향 차이로 코드 분기 복잡"
      ]
    },
    {
      "name": "phase-2 option (a) — Stage D 절차에 step 신규 추가 + Stage A step 7 backward cross-ref",
      "pros": [
        "DRY (Stage A step 7 forward cross-ref + Stage D backward cross-ref 양방향)",
        "사용자가 Stage D 진입 시 즉시 발견 (narrative 위치 정합)"
      ],
      "cons": []
    },
    {
      "name": "phase-2 option (b) — Stage A step 7 에 narrative 보강만 (Stage D 무변경)",
      "pros": [
        "변경 최소"
      ],
      "cons": [
        "Stage D 진입 시 검출 fail (사용자가 Stage A step 7 narrative 재독해 의무 → 인지 부담 증가)",
        "L3 갭 미해소 (사용자가 Stage D 진입 시 forward cross-ref 발견 어려움)"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "topic": "신규 smoke 도입으로 pre-commit 시간 증가",
      "likelihood": "low",
      "impact": "medium",
      "narrative": "v2.1 batching 최적화로 pre-commit 전체 15.4s. 신규 smoke 가 디렉토리 nameregex + milestones.md 존재 검증만 → <1s 예상. 영향 미미."
    },
    {
      "id": "R2",
      "topic": "신규 smoke 가 기존 milestone 디렉토리에서 false positive",
      "likelihood": "medium",
      "impact": "high",
      "narrative": "기존 v3.0/v3.1/v3.2/v3.3/v3.4 모두 milestones.md 보유 — 본 milestone 작성 시 v3.5/milestones.md 도 작성됨. 그러나 historical 9-stage / 7-stage / 4-tier 디렉토리 (예: v2.1_smoke-spawn-batching, v1.84_*) 는 디렉토리명 `^v\\d+\\.\\d+$` 정규식 매칭 부재 (밑줄 포함) → 검증 대상 외 (forward-only 정책 정합). 다만 정규식 정확성 검증 의무 (검증 코드 작성 시)."
    },
    {
      "id": "R3",
      "topic": "phase-2 narrative 갱신 시 v3.4 도입 narrative 와 충돌",
      "likelihood": "low",
      "impact": "low",
      "narrative": "v3.4 phase-1 Stage A step 7 narrative 와 phase-2 Stage D 신규 step narrative 는 책임 분리 (Stage A 작성 시점 / Stage D 갱신 시점). 충돌 부재 + cross-ref 양방향 보강."
    },
    {
      "id": "R4",
      "topic": "phase-1 신규 smoke 의 file: 패턴 결정 (pre-commit hook 등록 시)",
      "likelihood": "medium",
      "impact": "medium",
      "narrative": "smoke-bundle-trigger 와 동일 패턴 (`ROADMAP\\.md$|projects/.*/ROADMAP\\.md$`) 사용 시 ROADMAP 변경 시 트리거. 그러나 본 smoke 책임은 디렉토리 페어링 → milestones.md 변경 시 트리거가 더 정확. 후보 패턴: `projects/[^/]+/milestones/v[^/]+/milestones\\.md$` 또는 `projects/[^/]+/milestones/v[^/]+/.*` (디렉토리 신규 생성 추적). DESIGN 단계에서 결정."
    },
    {
      "id": "R5",
      "topic": "inverse drift 미검출 (디렉토리 존재 + ROADMAP entry 부재 = orphan)",
      "likelihood": "low",
      "impact": "medium",
      "narrative": "본 milestone scope: 디렉토리 → milestones.md 페어링만. 디렉토리 → ROADMAP entry 매핑 (orphan 검출) 은 out_of_scope. 별 milestone 후보 (PROPOSE 단계 등재 가능)."
    },
    {
      "id": "R6",
      "topic": "phase-1 smoke 자체 자기참조 (v3.5/ 디렉토리 + milestones.md 부재 시 본 smoke FAIL → pre-commit 통과 불가)",
      "likelihood": "high",
      "impact": "high",
      "narrative": "본 milestone 의 OPEN 단계에서 milestones.md 작성 후 phase-1 진행 → 본 smoke 첫 실행 시 v3.5/milestones.md 보유 (PASS). 자기참조 부합 (도그푸드). 다만 phase 작성 순서 의무 — milestones.md 먼저, smoke 그 다음."
    },
    {
      "id": "R7",
      "topic": "DESIGN 5 관점 검토 범위 (≤5 vs 6~15 파일)",
      "likelihood": "low",
      "impact": "low",
      "narrative": "변경 affected_files: harness-meta.md + smoke 1건 (신규 또는 확장) + tests/CLAUDE.md + .pre-commit-config.yaml (option a) + milestone 산출물. 구현 파일만 4개 (option a). ≤5 파일 → 3 관점 (architecture / spec-drift / scope contract). smoke 변경은 회귀 risk 핵심이므로 +1 (4 관점) 권장 검토."
    }
  ]
}
```

## options 종합

### phase-1 결정 후보 (cascade 검증 smoke)

**option (a) 신규 smoke 도입** vs **option (b) 기존 smoke 확장** — tests/CLAUDE.md L208 책임 분리 규약 (v3.1 L3 D16) 정합 + 향후 era 확장 유연성으로 option (a) 권장. DESIGN 단계 사용자 결정 의무.

### phase-2 결정 후보 (Stage D narrative)

**option (a) Stage D step 신규 + backward cross-ref** vs **option (b) Stage A step 7 narrative 보강만** — option (b) 는 L3 갭 미해소 (Stage D 진입 사용자 forward cross-ref 발견 부담), option (a) 권장.

### scope 외

- inverse drift (orphan 디렉토리 검출) — 별 milestone 후보 (PROPOSE 등재 검토)
- milestones.md 본문 schema 검증 (sub_milestones[] 필드 정합) — 별 smoke 책임 후보 (PROPOSE 등재 검토)

## 자기참조 검증 (도그푸드)

phase-1 신규 smoke 가 적용되는 첫 milestone = 본 v3.5. OPEN 단계 종료 시점에 `projects/meta/milestones/v3.5/milestones.md` 이미 보유 → phase-1 commit 시 자기 smoke 가 자기 디렉토리 검증 PASS. 자기참조 부합.

## 관련

- 직속 부모 lessons: [`../v3.4/REPORT.md`](../v3.4/REPORT.md) L1 + L3
- 1차 source: [`milestones.md`](milestones.md), [`INTENT.md`](INTENT.md)
- 참조 ARCHITECTURE: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- 워크플로우 갱신 대상: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md) Stage D
- smoke 매트릭스 갱신 대상: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
