# milestones — v3.0 (sub-milestone listing per version)

본 파일은 v3.0+ 9-stage-bundled era 의 sub-milestone listing per version 정전 source. 9-stage workflow 의 통합 milestone 안 sub-책임을 phase 단위로 매핑.

상위 정책 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1.

## Spec (picture-frame, D5/D17)

```json
{
  "spec_version": "v3.0",
  "spec_description": "9-stage-bundled era milestones.md schema — sub-milestone listing per version",
  "fields": {
    "version": "string (e.g., 'v3.0') — milestone 디렉토리 명과 일치",
    "milestone_id": "string (group-slug, e.g., 'milestones-restructure') — ROADMAP entry id 와 일치",
    "title": "string — milestone 통합 주제",
    "phase_count": "integer — sub_milestones[] 길이",
    "status": "in_progress | completed",
    "self_reference_compliance": "boolean — true(도그푸드, D7) | false(회피 표지, v2.0 선례)",
    "sub_milestones": "array — 각 entry: {id, phase, status, title, summary, dependencies, absorbed_from?}"
  },
  "sub_milestone_fields": {
    "id": "string (sub-책임 group-slug)",
    "phase": "integer (1..N) — execute/phase-{n}.md 와 1:1",
    "status": "pending | in_progress | completed",
    "title": "string",
    "summary": "string (1-3 문장)",
    "dependencies": "array — 선행/후행 sub-milestone phase 번호 list (within version) 또는 외부 milestone id",
    "absorbed_from": "string (선택) — 원 ROADMAP milestone id (v2.2_*) — 흡수 추적성 보존 (D14)"
  }
}
```

## Instance (v3.0_milestones-restructure)

```json
{
  "version": "v3.0",
  "milestone_id": "milestones-restructure",
  "title": "milestone hierarchy 재구성 — version > sub-milestone > phase + v2.2_* 4건 흡수",
  "phase_count": 8,
  "status": "in_progress",
  "self_reference_compliance": true,
  "sub_milestones": [
    {
      "id": "smoke-era-branching",
      "phase": 1,
      "status": "completed",
      "title": "smoke era branching — 4 era 인식 (4-tier / 7-stage / 9-stage / 9-stage-bundled)",
      "summary": "smoke-spec-verification + smoke-scope-contract detect_era 4 era 분기 추가 (D10 9-stage-bundled era 표지) + glob v[0-9]* + post-report-write.sh milestones.md NOOP (D16). R2 자기참조 inconsistency mitigation 선결.",
      "dependencies": []
    },
    {
      "id": "era-detect-shared-module-extraction",
      "phase": 2,
      "status": "completed",
      "title": "tests/_era_detect.py 분리 — 두 smoke 의 detect_era drift 방지",
      "summary": "tests/_era_detect.py 신규 모듈 (D5/D15 일원화 source) + smoke-scope-contract import. spec-verification 은 호출 부재로 정의 제거. drift 잠재 1 phase 단축 (D6 swap).",
      "dependencies": [1],
      "absorbed_from": "v2.2_era-detect-shared-module"
    },
    {
      "id": "policy-codification",
      "phase": 3,
      "status": "completed",
      "title": "milestone hierarchy 정책 명문화 + INTENT~APPROVE 자기참조 commit",
      "summary": "ARCHITECTURE.md § 6.1 정전 (4 era + bundling trigger + 자기참조 부합 + breaking change + era 영구화) + cascade 6 host (root CLAUDE.md / projects/meta/CLAUDE.md / harness-meta.md / tests/CLAUDE.md / AGENTS.md / README.md / GUARDRAILS.md / docs/adr/ADR-006-workflow-revamp.md) 보수 cross-ref. INTENT/RESEARCH/DESIGN/APPROVE 4 산출물 milestones/v3.0/ 신 구조 commit (D7 자기참조 부합).",
      "dependencies": [1, 2]
    },
    {
      "id": "roadmap-schema-migration",
      "phase": 4,
      "status": "completed",
      "title": "ROADMAP schema (version+id 분리) + v2.2_* 4건 entry 제거",
      "summary": "v3.0 entry 신 schema 변환 (version + id 분리, milestones_path + absorbed_milestones 필드). v2.2_* 4건 entry 제거 (phase-2/6/7/8 흡수). schema_note 필드 신규 (신/기존 schema 공존). 보존 entry (v2.0~v2.1 / v1.0~v1.4) 는 기존 schema 유지 (forward-only).",
      "dependencies": [3]
    },
    {
      "id": "milestones-md-spec",
      "phase": 5,
      "status": "completed",
      "title": "milestones.md 신규 작성 + spec picture-frame",
      "summary": "본 파일 — milestones/v3.0/milestones.md 신규. spec picture-frame (신 schema 정식 키 매핑) + sub_milestones[] 8건 listing (phase 1-8 매핑, dependencies + absorbed_from). spec-drift 권고 #2 picture-frame 의무.",
      "dependencies": [4]
    },
    {
      "id": "cp949-encoding-pattern",
      "phase": 6,
      "status": "completed",
      "title": "Windows cp949 콘솔 인코딩 회피 패턴 강제 (smoke 작성 표준)",
      "summary": "v2.1 lessons L1 — phase-1 첫 실행 시 Windows cp949 콘솔 em dash UnicodeEncodeError 발견. tests/CLAUDE.md § '흔한 함정' 6번째 항목 추가 + smoke 5-step Step 3 (Generate) Python heredoc boilerplate 의무 + smoke-spec-verification + smoke-scope-contract 의 reconfigure 호출 errors='replace' 명시 통일 (D15). AST audit (smoke-python-entry-boilerplate § P2) 은 v1.87 시점 이미 sys.stdout.reconfigure 검증 활성.",
      "dependencies": [3],
      "absorbed_from": "v2.2_smoke-cp949-encoding-pattern"
    },
    {
      "id": "controlled-comparison-pattern",
      "phase": 7,
      "status": "completed",
      "title": "tests/CLAUDE.md § '회귀 검증 절차' 에 controlled 비교 패턴 추가",
      "summary": "v2.1 lessons L3 — phase 검증 시 단순 baseline vs post 비교는 milestone 상태 변화로 PASS/SKIP 분포 차이. controlled 비교 (git show HEAD:smoke.sh > /tmp/old.sh + diff CRLF 정규화) 가 동치 검증 강력 도구. tests/CLAUDE.md § '회귀 검증 절차' '기존 smoke 수정 시' 항목에 4-step 패턴 명문화 (baseline / post / CRLF 정규화 diff / 의도된 변경 vs 회귀 분기).",
      "dependencies": [3],
      "absorbed_from": "v2.2_smoke-controlled-comparison-pattern"
    },
    {
      "id": "historical-7stage-stage1-decision",
      "phase": 8,
      "status": "pending",
      "title": "historical 7-stage migrate milestone 의 Stage 1 검증 누락 결정",
      "summary": "v2.1 lessons L6 — v2.0 hotfix 43472b7 가 detect_era 에 INTENT.md only 케이스 추가했으나 smoke-scope-contract Stage 1 코드는 era='7-stage' 시 fp=PLAN.md 만 체크 → historical migrate (PLAN→INTENT) milestone 의 out_of_scope 검증 SKIP. 옵션 (a/b/c) 결정 + 결정 결과 적용. phase 진행 시 AskUserQuestion 으로 사용자 결정.",
      "dependencies": [2],
      "absorbed_from": "v2.2_historical-7stage-stage1-decision"
    }
  ]
}
```

## 흡수 추적성 (D14)

| 원 v2.2 milestone | 흡수 phase | sub-milestone id |
|---|:-:|---|
| v2.2_era-detect-shared-module | 2 | era-detect-shared-module-extraction |
| v2.2_smoke-cp949-encoding-pattern | 6 | cp949-encoding-pattern |
| v2.2_smoke-controlled-comparison-pattern | 7 | controlled-comparison-pattern |
| v2.2_historical-7stage-stage1-decision | 8 | historical-7stage-stage1-decision |

각 흡수 commit 메시지에 원 milestone id reference 의무 (D14, S6).

## 의존 그래프

```text
phase-1 (smoke era branching, 선결)
    ├── phase-2 (era-detect 분리, drift 방지)
    │       └── phase-8 (historical-7stage Stage 1, era 분기 의존)
    └── phase-3 (정책 명문화 + INTENT~APPROVE commit)
            └── phase-4 (ROADMAP schema 변환)
                    └── phase-5 (milestones.md 작성, 본 파일)
            ├── phase-6 (cp949 흡수)
            └── phase-7 (controlled-comparison 흡수)
```

phase-1 → phase-2 → phase-3 → phase-4 → phase-5 (선형 critical path).
phase-3 후 phase-6/7 (병렬 가능). phase-8 은 phase-2 의존 (era 분기 코드).

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- APPROVE: [`APPROVE.md`](APPROVE.md)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (v3.0 entry, milestones_path 필드)
