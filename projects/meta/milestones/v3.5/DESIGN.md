# DESIGN — v3.5 open-stage-discipline-strengthening

```json
{
  "version": "v3.5",
  "id": "open-stage-discipline-strengthening",
  "decisions": [
    {
      "n": "D1",
      "decision": "phase-1 cascade 검증 smoke 는 **option (a) — `tests/smoke-open-stage-discipline.sh` 신규 도입**.",
      "rationale": "tests/CLAUDE.md L208 책임 분리 규약 (v3.1 L3 D16) 정합 — bundle-trigger 는 ROADMAP entry schema 검증, open-stage-discipline 은 디렉토리 ↔ milestones.md 페어링 검증. 명명 의도 명확 + 향후 era 확장 유연성. 사용자 명시 결정 (Stage C RESEARCH 후 AskUserQuestion).",
      "alternatives_rejected": ["option (b) bundle-trigger 확장 — 명명 부정합 + 책임 분리 규약 위배"]
    },
    {
      "n": "D2",
      "decision": "phase-2 Stage D narrative 갱신은 **option (a) — Stage D 절차에 step 신규 추가 + Stage A step 7 backward cross-ref**.",
      "rationale": "DRY 양방향 cross-ref (Stage A forward + Stage D backward). L3 갭 동쪽 해소. 사용자 명시 결정.",
      "alternatives_rejected": ["option (b) Stage A step 7 narrative 보강만 — L3 갭 미해소"]
    },
    {
      "n": "D3",
      "decision": "신규 smoke `tests/smoke-open-stage-discipline.sh` 의 검증 책임: **'9-stage-bundled era 디렉토리 ↔ milestones.md 페어링 자동 강제'**. 구체적으로 — `projects/<name>/milestones/v{X.Y}/` 디렉토리 (^v\\d+\\.\\d+$ 정규식 매칭) 안에 `milestones.md` 부재 시 FAIL.",
      "rationale": "_era_detect.py 의 9-stage-bundled 표지 (디렉토리명 + milestones.md) 와 1:1 정합 (`tests/_era_detect.py:27` 동치). ARCHITECTURE.md § 6.1 era 정책 행 1 narrative 정합. 표지 미충족 시 era 오인 가능 (smoke-spec-verification / smoke-scope-contract 의 검증 skip → 침묵 통과 위험) → 사전 차단. **bundle-trigger 의 책임 1 (version 중복 부재) + 책임 2 (entry → 실 파일) 와 본 smoke 의 책임 (디렉토리 → milestones.md) 은 검사 방향 직교** (책임 분리 보존, 향후 era 추가 시 복잡도 누적 회피).",
      "alternatives_rejected": ["검증 책임을 ROADMAP entry → 디렉토리 방향 (이미 bundle-trigger 검증) 으로 통합", "디렉토리 → ROADMAP entry orphan 검출 (inverse drift) — out_of_scope"]
    },
    {
      "n": "D4",
      "decision": "신규 smoke 의 `files:` 패턴 (pre-commit hook 등록 시): `'projects/[^/]+/milestones/v[0-9]+\\.[0-9]+/.*\\.md$|\\.pre-commit-config\\.yaml$'`",
      "rationale": "milestones/v{X.Y}/ 안 .md 파일 변경 시 (milestones.md 신규/삭제 포함) 트리거. pre-commit-config 자체 변경 시도 트리거 (자기참조 검증). pass_filenames: false — 전체 디렉토리 순회. **회귀 risk 검토 흡수**: 초안의 `v[^/]+` 패턴은 historical 디렉토리 (예: `v1.4_infra-minimization`) 도 매칭 → D6 의 검증 정규식 `^v\\d+\\.\\d+$` 와 모순 + 불필요 hook 트리거 누적. 따라서 files 패턴도 `v[0-9]+\\.[0-9]+` 명시 (D6 정규식과 1:1 정합).",
      "alternatives_rejected": ["ROADMAP\\.md 패턴 — 본 smoke 의 책임 (디렉토리 페어링) 과 무관", "`v[^/]+` — D6 정규식과 모순 (회귀 risk HIGH 흡수)"]
    },
    {
      "n": "D5",
      "decision": "신규 smoke 의 entry 형식: **direct** (`bash tests/smoke-open-stage-discipline.sh`, --fix 미지원).",
      "rationale": "tests/CLAUDE.md '핵심 정책 검증' 표 의 smoke-bundle-trigger 와 같은 정책 — '--fix 미지원 → direct entry'. milestones.md 자동 생성은 OPEN stage 책임이지 smoke 책임 외 (책임 분리).",
      "alternatives_rejected": ["--fix mode 도입 (milestones.md skeleton 자동 생성) — Stage A step 7 와 책임 중복 + 자동 생성 의미 부재 (사용자가 의도 작성)"]
    },
    {
      "n": "D6",
      "decision": "신규 smoke 의 historical era 처리: **forward-only 정책** (디렉토리명 `^v\\d+\\.\\d+$` 정규식 매칭 부재 디렉토리는 검증 skip).",
      "rationale": "v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier era 의 디렉토리명 (밑줄 포함) 은 정규식 매칭 부재 → 자연 skip. v3.0_milestones-restructure D12 forward-only 정책 일관.",
      "alternatives_rejected": ["전체 era 검증 — historical era 의 milestones.md 부재 정상이므로 false positive 발생"]
    },
    {
      "n": "D7",
      "decision": "신규 smoke 의 Python heredoc boilerplate: **v2.1 phase-1 / v3.0 phase-6 cp949 mojibake 회피 패턴 적용** (`sys.stdout.reconfigure(encoding='utf-8', errors='replace')`).",
      "rationale": "Windows cp949 콘솔 UnicodeEncodeError 회피 (tests/CLAUDE.md § '흔한 함정' 6번 + smoke-python-entry-boilerplate § P2 v1.87 AST audit 자동 강제).",
      "alternatives_rejected": ["pure bash 구현 — `^v\\d+\\.\\d+$` regex + 파일 존재 검증은 bash 가능하지만 milestone 디렉토리 순회 시 set -u + bash array 다루기 번거로움. Python heredoc 가독성 우선."]
    },
    {
      "n": "D8",
      "decision": "phase-2 Stage D 절차 신규 step 의 명명 + 삽입 위치: **Stage D 절차 끝 (5 관점 검토 직후)** 'milestones.md sub_milestones 1:1 동기 갱신' step.",
      "rationale": "Stage D 의 phases[] 확정 시점 = 5 관점 검토 후 (검토 의견 흡수 후 phases 확정). 즉 검토 직후 시점이 동기 갱신의 정확한 timing. Stage A step 7 의 forward cross-ref ('Stage D DESIGN 후 milestones.md sub_milestones 1:1 동기 갱신') 정합.",
      "alternatives_rejected": ["Stage D 절차 첫 step — phases[] 확정 전이므로 timing 부정합", "별 stage 분리 — 9-stage 워크플로우 변경 = breaking change v3→v4, scope 과대"]
    },
    {
      "n": "D9",
      "decision": "phase-2 Stage A step 7 의 backward cross-ref: **기존 forward cross-ref 유지 + Stage D 신규 step 안에 'Stage A step 7 와 cross-ref' 명시**.",
      "rationale": "Stage A step 7 narrative 안 'Stage D DESIGN 단계에서 phases[] 확정 후 ...' 는 보존 (forward). Stage D 신규 step narrative 안 'Stage A step 7 와 양방향 cross-ref' 명시 (backward). 사용자가 어느 stage 진입 시에도 페어링 발견 가능.",
      "alternatives_rejected": ["Stage A step 7 narrative 도 동시 갱신 — 변경 영역 확장, 회귀 risk 누적"]
    },
    {
      "n": "D10",
      "decision": "INTENT~APPROVE commit 시점: **(b) Stage G (VERIFY) commit 안 포함** (권장 default, v3.1 L6 + harness-meta.md Stage F 선결 조건).",
      "rationale": "VERIFY 전 산출물 영구 보존 보장 + phase-1/2 commit 깔끔 (구현 파일 변경만 포함). 본 milestone OPEN 단계 산출물 (milestones.md + INTENT/RESEARCH/DESIGN/APPROVE) 4건은 Stage G commit 에 함께 포함.",
      "alternatives_rejected": ["(a) phase-1 commit 포함 — 산출물 + 구현 혼재 위험", "(c) 별 chore commit — commit 수 증가"]
    },
    {
      "n": "D11",
      "decision": "5 관점 검토 범위: **4 관점 (architecture / spec-drift / 회귀 risk / scope contract)**.",
      "rationale": "변경 affected_files: harness-meta.md + smoke 신규 + tests/CLAUDE.md + .pre-commit-config.yaml = 4 구현 파일 (≤5 파일 → 3 관점 기준). 그러나 smoke 변경 + pre-commit hook 추가 = 회귀 risk 핵심 영역 → +1 (회귀 risk 명시) = 4 관점. 보안 관점은 16+ 파일 또는 외부 입력 처리 시만 적용 — 본 변경은 path traversal / 권한 / 외부 입력 무관, 적용 외.",
      "alternatives_rejected": ["3 관점만 (보안 + 회귀 risk 모두 생략) — smoke 변경 회귀 risk 우려 미해소"]
    }
  ],
  "approach": "v3.4 lessons L1 + L3 를 bundle 한 v3.5 의 핵심 전략: (1) **자동 강제** — 신규 smoke 1건 도입으로 9-stage-bundled era 디렉토리 ↔ milestones.md 페어링 자동 검출 (narrative 강제 → 자동 강제 전환). (2) **양방향 cross-ref** — Stage A step 7 + Stage D 신규 step 양방향 cross-ref 로 사용자 진입 stage 무관 발견. 두 sub-milestone 모두 v3.4 직속 후속이며 같은 모듈 (harness-meta.md + tests/) + 같은 주제 (OPEN/DESIGN 절차 강제) → bundle 운용.",
  "phases": [
    {
      "n": 1,
      "title": "cascade 검증 smoke 도입 — `tests/smoke-open-stage-discipline.sh` 신규 + pre-commit hook 등록 + tests/CLAUDE.md 매트릭스 갱신",
      "scope": "신규 smoke 1건 작성 + pre-commit hook 1건 등록 + smoke 매트릭스 1 row 추가",
      "affected_files": [
        "tests/smoke-open-stage-discipline.sh (신규 작성, executable)",
        ".pre-commit-config.yaml (active hook 1건 추가, smoke-bundle-trigger 직후)",
        "tests/CLAUDE.md (§ '핵심 정책 검증' 표에 1 row 추가 + § 'Pre-commit hook entry 정책' 현행 hook 6→7 갱신 + § '현행 hook 현황' 헤더 narrative milestone 거명 (v3.1 phase-3 옆 v3.5 phase-1 추가) + § 'inactive 22 의 회귀 차단 책임' narrative count 미세 보정 + § 'smoke 매트릭스' 헤더 카운트 28→29)",
        "projects/meta/milestones/v3.5/execute/phase-1.md (status: in_progress → complete + execution_notes)"
      ],
      "rationale": "v3.4 L1 직접 해소 — narrative 강제 (Stage A step 7) → 자동 강제 (신규 smoke). 자기참조 도그푸드 — 본 milestone v3.5 의 OPEN 단계 산출 milestones.md 가 신규 smoke 첫 PASS 대상.",
      "risks": ["R2 false positive (historical 디렉토리) — 정규식 정확성 의무", "R4 files: 패턴 결정 — D4 결정 적용", "R6 자기참조 fail (milestones.md 부재 시 phase-1 smoke FAIL) — OPEN step 7 선행 이미 충족"]
    },
    {
      "n": 2,
      "title": "Stage D 절차 narrative 동기 — `claude/commands/harness-meta.md` Stage D 신규 step + Stage A step 7 backward cross-ref",
      "scope": "harness-meta.md Stage D 섹션에 step 추가 + cross-ref 양방향 보강",
      "affected_files": [
        "claude/commands/harness-meta.md (Stage D 섹션 끝에 'milestones.md sub_milestones 1:1 동기 갱신' step 신규 + Stage A step 7 와 cross-ref 명시 — D8/D9 결정 적용)",
        "projects/meta/milestones/v3.5/execute/phase-2.md (status: in_progress → complete + execution_notes)"
      ],
      "rationale": "v3.4 L3 직접 해소 — Stage A forward cross-ref 만 있던 비대칭 → 양방향. Stage D 진입 사용자가 즉시 step 발견 가능 (인지 부담 감소).",
      "risks": ["R3 narrative 충돌 — v3.4 도입 step 7 narrative 유지 + Stage D 신규 step 책임 분리 (작성 시점 vs 갱신 시점)"]
    }
  ],
  "risk_mitigation": [
    {"risk_id": "R1", "mitigation": "신규 smoke 실행 시간 측정 (Stage G VERIFY 단계). 임계 1s 초과 시 alert. 현재 pre-commit 15.4s + <1s = 16s 이하 예상."},
    {"risk_id": "R2", "mitigation": "정규식 `^v\\d+\\.\\d+$` 정확성 — phase-1 smoke 안에 단위 검증 (Stage 1: regex 매칭 확인, Stage 2: milestones.md 페어링 확인). historical 디렉토리 (v1.x, v2.x 보존, v1.84~88) 의 디렉토리명 (밑줄 포함) 자연 skip 확인."},
    {"risk_id": "R3", "mitigation": "phase-2 narrative 갱신 시 v3.4 도입 narrative 유지 + 신규 step 책임 분리 명시 (D9). markdownlint 자동 차단 (MD032 강조 직후 list blanks-around-lists)."},
    {"risk_id": "R4", "mitigation": "D4 결정 적용 — `'projects/[^/]+/milestones/v[^/]+/.*\\.md$|\\.pre-commit-config\\.yaml$'`. Stage G smoke 실행 검증."},
    {"risk_id": "R5", "mitigation": "inverse drift (orphan 디렉토리) 는 본 milestone scope 외 — PROPOSE next_candidates 등재."},
    {"risk_id": "R6", "mitigation": "OPEN step 7 선행으로 v3.5/milestones.md 이미 보유 → 자기참조 PASS. phase-1 commit 전 자기 smoke 단독 실행 의무 (Stage G)."},
    {"risk_id": "R7", "mitigation": "D11 결정 — 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract)."}
  ]
}
```

## approach narrative

### phase-1: cascade 검증 smoke 도입

신규 smoke `tests/smoke-open-stage-discipline.sh` 의 검증 알고리즘:

```text
For each project_dir in projects/:
    For each milestone_dir in project_dir/milestones/:
        If milestone_dir.name matches ^v\d+\.\d+$ (9-stage-bundled era):
            If (milestone_dir / "milestones.md").exists():
                PASS (페어링 정합)
            Else:
                FAIL — "디렉토리 ↔ milestones.md 페어링 위배 — v3.0+ 9-stage-bundled era 의무 (ARCHITECTURE.md § 6.1)"
        Else:
            SKIP (historical era — v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier)
```

pre-commit hook 등록: `.pre-commit-config.yaml` 안 `smoke-bundle-trigger` 직후 (책임 인접) — `smoke-open-stage-discipline` 신규 active hook 1건. entry: `bash tests/smoke-open-stage-discipline.sh` (direct, --fix 미지원). files 패턴: `'projects/[^/]+/milestones/v[^/]+/.*\.md$|\.pre-commit-config\.yaml$'`.

tests/CLAUDE.md 매트릭스:

- § '핵심 정책 검증' 표에 1 row 추가 — `smoke-open-stage-discipline.sh` / "9-stage-bundled era 디렉토리 ↔ milestones.md 페어링 자동 강제" / `--fix` ❌
- § 'Pre-commit hook entry 정책' 현행 hook 6 → 7 갱신
- § 'smoke 매트릭스' 헤더 28 → 29 카운트 갱신

### phase-2: Stage D 절차 narrative 동기

`claude/commands/harness-meta.md` Stage D 섹션 끝 (5 관점 검토 표 후) 에 신규 step 삽입:

```text
**Stage D 완료 직전 의무 step**:

phases[] 확정 직후 (5 관점 검토 의견 흡수 후) → `milestones/v{X.Y}/milestones.md`
sub_milestones[] 를 phases[] 와 1:1 동기 갱신 (placeholder title 교체).
Stage A step 7 narrative (`milestones.md 스켈레톤 즉시 작성`) 의 forward cross-ref
('Stage D DESIGN 후 milestones.md sub_milestones 동기 갱신') 와 양방향 cross-ref.
```

Stage A step 7 안 forward cross-ref 는 보존. 두 stage 모두 명시 → 양방향.

## 4 관점 병렬 검토 진행

본 DESIGN.md 초안 → 4 관점 subagent 병렬 검토 (Stage D 표 의무):

1. architecture (Plan agent) — 디렉토리 구조 / 파일 책임 / 변경 영향
2. spec-drift (general-purpose) — 외부 spec 정합 (ARCHITECTURE.md § 6.1 / tests/CLAUDE.md 매트릭스)
3. 회귀 risk (Explore) — 기존 6 active pre-commit hook 영향 / 28 smoke 회귀
4. scope contract (Explore) — INTENT.success_criteria ↔ DESIGN.phases 매핑

검토 결과 종합 → DESIGN.decisions 미세 갱신 (필요 시) → milestones.md sub_milestones 동기 갱신 (phase-2 의 도그푸드 첫 적용) → APPROVE.md.

## 관련

- 1차 source: [`milestones.md`](milestones.md), [`INTENT.md`](INTENT.md), [`RESEARCH.md`](RESEARCH.md)
- 부모 lessons: [`../v3.4/REPORT.md`](../v3.4/REPORT.md) L1 + L3
- ARCHITECTURE: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- 갱신 대상: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md) Stage D + [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md) + [`../../../../.pre-commit-config.yaml`](../../../../.pre-commit-config.yaml)
