# DESIGN — v3.0_milestones-restructure

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "forward-only — historical milestone (v1.84~v2.1) 디렉토리 unchanged + 4 era 영구 분기",
      "rationale": "사용자 결정. git history 보존 + 회귀 risk 0 + 점진 마이그레이션. cons (smoke 분기 4 era 코드 복잡) 는 phase-2 _era_detect.py 공유 모듈 분리로 mitigate.",
      "alternatives_rejected": ["B (backward retroactive — git mv 시 history 손상 risk)", "C (dual representation — schema 복잡, 단일 source 위반)"]
    },
    {
      "id": "D2",
      "decision": "명명 구조 v{X.Y}_{group-slug} + phase-{n} (B' 옵션) — milestone id 검색성 보존",
      "rationale": "사용자 결정. 디렉토리는 milestones/v{X.Y}/ (version-only), id 의 group-slug 는 INTENT.md JSON / milestones.md 에서 표현. cons (디렉토리 ↔ id inconsistency) 는 ARCHITECTURE.md § 6 narrative 에 의도 1단락 명시 (architecture 권고 #3).",
      "alternatives_rejected": ["A' (slug 제거 — 식별 어려움)", "C' (dotted v{X.Y}.{n} — 기존 _ 패턴 불일치)"]
    },
    {
      "id": "D3",
      "decision": "ROADMAP entry = version 단위 1 entry (sub-milestone 상세는 milestones.md 위임)",
      "rationale": "사용자 결정. 정보 계층화 — high-level (ROADMAP) vs detailed (milestones.md). projects/<name>/ROADMAP.md 와 동형.",
      "alternatives_rejected": ["sub-milestone 단위 N entry (ROADMAP 장문화)"]
    },
    {
      "id": "D4",
      "decision": "milestones.md 위치 = milestones/v{X.Y}/milestones.md (version 별 1건)",
      "rationale": "사용자 결정. version 단위 자연스러운 hierarchy.",
      "alternatives_rejected": ["milestones/milestones.md (root, 단일 source 위반 risk)"]
    },
    {
      "id": "D5",
      "decision": "milestones.md 내용 = sub-milestone 상세 (id/title/status/summary/dependencies/phase 매핑)",
      "rationale": "사용자 결정. 상단 1 코드블록 = picture-frame (spec-drift 권고 #2 — 신 schema 정식 키 매핑 의무).",
      "alternatives_rejected": ["INTENT 종합 narrative (INTENT.md 와 중복)", "ROADMAP 복사본 (단일 source 위반)"]
    },
    {
      "id": "D6",
      "decision": "8 phase + phase-5 swap (사용자 결정 — architecture 권고 #5)",
      "rationale": "8 phase scope 보존 + tests/_era_detect.py 분리 (구 phase-5 = v2.2_era-detect-shared-module 흡수) 를 phase-2 로 swap. 효과: phase-1 두 smoke 4 era 동시 갱신 직후 phase-2 분리 → drift 잠재 1 phase 단축.",
      "alternatives_rejected": ["8 phase 그대로 (drift 잠재 5 phase 장기)", "9 phase phase-2 sub-split (사용자 첫 결정 변경 의무)"]
    },
    {
      "id": "D7",
      "decision": "자기참조 부합 (도그푸드) — v3.0 자체가 신 구조 (milestones/v3.0/ + milestones.md) 첫 적용",
      "rationale": "사용자 결정. spec-drift 권고 #4 (dogfooding 정신 정합) + architecture 권고 #2 (R9 INTENT.md JSON 신 schema 유지) + 보안 검토 verdict pass. v2.0 회피 표지 선례와 의도된 정책 차이 — v2.0 시점 신뢰 부족 + 7→9 정의 변경, v3.0 시점 v2.0+v2.1 누적 신뢰로 부합 채택.",
      "alternatives_rejected": ["회피 표지 (v2.0 선례 — bootstrapping safety, 본 milestone 무한 회귀 부재로 부적합)"]
    },
    {
      "id": "D8",
      "decision": "milestone id = milestones-restructure (group-slug)",
      "rationale": "사용자 결정. 재구성 본질 강조 — ROADMAP/디렉토리/milestones.md 포괄.",
      "alternatives_rejected": ["milestone-bundling-naming (이전 결정 → 재고)", "milestone-hierarchy-introduction"]
    },
    {
      "id": "D9",
      "decision": "INTENT.md JSON id 형식 = 신 schema (version + id 분리) — 자기참조 부합",
      "rationale": "architecture 권고 #2 + scope contract R9 mitigation. 도그푸드 정신 — INTENT.md 가 자신의 결과물 표현. ROADMAP.md transition state (phase-4 까지 임시 기존 schema) 는 DESIGN.decisions D11 에 명시.",
      "alternatives_rejected": ["임시 기존 schema (id flat) → phase-4 변환 (도그푸드 정신 약화)"]
    },
    {
      "id": "D10",
      "decision": "9-stage-bundled era 표지 규칙 = (a) 디렉토리 패턴 ^v\\d+\\.\\d+/$ + (b) milestones.md 존재 동시 충족",
      "rationale": "architecture 권고 #4. ambiguity 0 보장. 9-stage (v2.0~v2.1) 는 v{X.Y}_{slug} 패턴 + milestones.md 부재. 9-stage-bundled (v3.0+) 는 v{X.Y} only + milestones.md 존재. tests/_era_detect.py 신규 모듈 (phase-2) 에 정전 분류 의무.",
      "alternatives_rejected": ["디렉토리 패턴만 (milestones.md 부재 시 ambiguity)", "milestones.md 만 (디렉토리 명 정합 부재)", "ROADMAP 신 schema 만 (entry 단위 분기 어려움)"]
    },
    {
      "id": "D11",
      "decision": "ROADMAP transition state — phase-4 (ROADMAP schema 변경) 까지 v3.0 entry 임시 기존 schema (id flat = v3.0_milestones-restructure)",
      "rationale": "scope contract R9 mitigation. INTENT.md 신 schema (D9) ↔ ROADMAP 임시 기존 schema 간 inconsistency 는 phase-4 일괄 변환 으로 회복. 사전 명시로 검증자 혼란 회피.",
      "alternatives_rejected": ["INTENT.md 도 임시 기존 schema (도그푸드 약화)", "ROADMAP 도 OPEN 시점부터 신 schema (phase-1+2 smoke 인식 부재로 commit fail risk)"]
    },
    {
      "id": "D12",
      "decision": "bundling trigger 조건 정전 명문화 위치 = ARCHITECTURE.md § 6 era 정책",
      "rationale": "사용자 결정. 정전 single source. cascade host (root CLAUDE.md / README.md / AGENTS.md / GUARDRAILS.md / projects/meta/CLAUDE.md / claude/commands/harness-meta.md / tests/CLAUDE.md) 는 cross-ref 1줄만. spec-drift 권고 #3 (bundling trigger 조건 미명시 시 v3.1+ 의문 재발) mitigation.",
      "alternatives_rejected": ["claude/commands/harness-meta.md (slash command 분산)", "ARCHITECTURE + projects/meta/CLAUDE.md 이중 명시 (중복 risk)"]
    },
    {
      "id": "D13",
      "decision": "APPROVE.md 'go/no-go' gate — phase-1 smoke PASS 조건 명시",
      "rationale": "scope contract 의견 충돌 #1 (R2 자기참조 inconsistency) mitigation. phase-1 (smoke era branching) commit 후 smoke 4 era 인식 PASS 가 phase-3 INTENT~APPROVE commit 의 전제. APPROVE.md approval_summary 에 명시.",
      "alternatives_rejected": ["조건 명시 없음 (phase 의존 implicit)"]
    },
    {
      "id": "D14",
      "decision": "v2.2_* 4건 흡수 commit 메시지 = 원 milestone id reference 의무 + milestones.md `dependencies.absorbed_from` 필드 명시",
      "rationale": "보안 S6 (MEDIUM) + scope contract R7 mitigation. 정보 추적성 보존. 예: `feat(meta): v3.0 phase-6 — v2.2_smoke-cp949-encoding-pattern 흡수 (cp949 콘솔 인코딩 패턴)`.",
      "alternatives_rejected": ["흡수만 (commit 메시지 단순 — 추적성 약화)"]
    },
    {
      "id": "D15",
      "decision": "보안 S4 (sys.stdout.reconfigure errors='replace' 인자 명시 통일) phase-6 흡수",
      "rationale": "보안 검토 권고 #3. extract_json 의 errors='replace' 와 inconsistency 회피.",
      "alternatives_rejected": ["기존 inconsistency 보존 (보안 권고 무시)"]
    },
    {
      "id": "D16",
      "decision": "보안 S5 (post-report-write.sh milestones.md 매치 제외) phase-1 hook 갱신 시 적용",
      "rationale": "보안 검토 권고 #1. milestones.md 는 sub-milestone listing 으로 INTENT/RESEARCH/DESIGN 와 책임 다름 → write trigger 분기 필요 시 명시적 매치 제외 또는 신규 FILE_TYPE.",
      "alternatives_rejected": ["기본 매치 (false positive risk)"]
    },
    {
      "id": "D17",
      "decision": "spec-drift breaking change 명시 + era 영구화 trade-off narrative — phase-3 ARCHITECTURE.md § 6 갱신 시 흡수",
      "rationale": "spec-drift 권고 #1 + #5. INTENT § 의도 narrative 에 'breaking change → v3 major bump' 명시 (현재 RESEARCH 만 명시). era 영구화 trade-off (v4.0+ 추가 시 분기 N+1 누적) 1줄 명시.",
      "alternatives_rejected": ["narrative 생략 (사용자 의문 재발 risk)"]
    },
    {
      "id": "D18",
      "decision": "phase-4 ROADMAP schema 변경 rollback 절차 명시 — git diff HEAD~ HEAD -- projects/meta/ROADMAP.md 후 manual revert",
      "rationale": "scope contract 의견 충돌 #4 (R5 partial fail recovery) mitigation. phase-4 단일 phase commit 단위 revert 가능 명시.",
      "alternatives_rejected": ["rollback 절차 implicit (회귀 발견 시 결정 부담)"]
    },
    {
      "id": "D19",
      "decision": "VERIFY.md 작성 시점 = Stage G (별도 commit, 9-stage workflow 표준 절차)",
      "rationale": "scope contract 의견 충돌 #5 mitigation. EXECUTE 8 phase 완료 후 Stage G 진입 시 별도 commit. v2.0/v2.1 선례 동일.",
      "alternatives_rejected": ["phase-8 commit 일부 (책임 혼재)", "phase 별 mini-VERIFY (산출 분산)"]
    }
  ],
  "approach": "v3.0_milestones-restructure 는 milestone naming 구조 재구성을 위한 8 phase 통합 milestone. forward-only (historical 보존) + 자기참조 부합 (도그푸드) + breaking change → major bump (v2 → v3) 정책. 8 phase 분할: 인프라 (phase-1 smoke era branching + phase-2 _era_detect.py 분리) → 자기참조 commit (phase-3 정책 명문화 + INTENT~APPROVE) → schema/구조 (phase-4 ROADMAP schema + phase-5 milestones.md) → 흡수 (phase-6~8 v2.2_* 3건 cp949/controlled/historical-decision). v2.2_era-detect-shared-module 은 phase-2 swap 으로 흡수. phase-1 smoke era branching 선결로 R2 자기참조 inconsistency mitigate. APPROVE.md 'go/no-go' gate (phase-1 smoke PASS 조건) 명시.",
  "phases": [
    {
      "n": 1,
      "title": "smoke era branching (선결)",
      "scope": "smoke-spec-verification.sh + smoke-scope-contract.sh detect_era 4 era 인식 (4-tier / 7-stage / 9-stage / 9-stage-bundled, D10 표지 규칙) + post-report-write.sh hook 4 era 인식 + milestones.md 매치 제외 (D16)",
      "affected_files": [
        "tests/smoke-spec-verification.sh",
        "tests/smoke-scope-contract.sh",
        "claude/hooks/post-report-write.sh",
        "milestones/v3.0/execute/phase-1.md"
      ],
      "rationale": "자기참조 부합 INTENT~APPROVE commit (phase-3) 시 신 era 인식 의무 (R2 mitigation). post-report-write.sh 4 era 분기 + milestones.md 매치 제외 (보안 S5 D16).",
      "risks": ["detect_era 두 smoke 동시 갱신 = drift 잠재 (phase-2 _era_detect.py 분리로 즉시 해결)"]
    },
    {
      "n": 2,
      "title": "tests/_era_detect.py 분리 (v2.2_era-detect-shared-module 흡수)",
      "scope": "tests/_era_detect.py 신규 모듈 + smoke-spec-verification + smoke-scope-contract 양쪽 import. detect_era 함수 본문 단일 source.",
      "affected_files": [
        "tests/_era_detect.py (신규)",
        "tests/smoke-spec-verification.sh",
        "tests/smoke-scope-contract.sh",
        "milestones/v3.0/milestones.md (sub-milestone-2 entry)",
        "milestones/v3.0/execute/phase-2.md"
      ],
      "rationale": "phase-1 두 smoke 4 era 동시 갱신 직후 즉시 분리로 drift 잠재 1 phase 단축 (D6 swap). v2.2_era-detect-shared-module 책임 보존 (D14 commit ref).",
      "risks": ["import 경로 (Windows + WSL/MSYS2 호환) — 보안 S1 LOW"]
    },
    {
      "n": 3,
      "title": "정책 명문화 (ARCHITECTURE § 6 era 정책 + cascade 6 host) + INTENT~APPROVE 4 산출 commit (자기참조)",
      "scope": "ARCHITECTURE.md § 3 5요소 매트릭스 'Workflow' 행 + § 6 era 정책 (4 era 표 + bundling trigger 조건 + 자기참조 부합 권장 + breaking change 명시 + era 영구화 trade-off, D12+D17 흡수) / projects/meta/CLAUDE.md (subdirectory 갱신) / claude/commands/harness-meta.md (slash command 절차) / tests/CLAUDE.md (smoke matrix 4 era 인식) / cascade host (root CLAUDE.md / README.md / AGENTS.md / GUARDRAILS.md / docs/adr/ADR-006-workflow-revamp.md) cross-ref 1줄. INTENT.md / RESEARCH.md / DESIGN.md / APPROVE.md 4 산출 commit (자기참조 부합 D7).",
      "affected_files": [
        "projects/meta/ARCHITECTURE.md",
        "projects/meta/CLAUDE.md",
        "claude/commands/harness-meta.md",
        "tests/CLAUDE.md",
        "CLAUDE.md (root)",
        "README.md",
        "AGENTS.md",
        "GUARDRAILS.md",
        "docs/adr/ADR-006-workflow-revamp.md",
        "milestones/v3.0/INTENT.md",
        "milestones/v3.0/RESEARCH.md",
        "milestones/v3.0/DESIGN.md",
        "milestones/v3.0/APPROVE.md",
        "milestones/v3.0/execute/phase-3.md"
      ],
      "rationale": "정책 명문화 (D12) + INTENT~APPROVE commit (D7 자기참조). cascade 6 host 는 cross-ref 보수 (본문 중복 회피, R8 mitigation).",
      "risks": ["cascade host 중복 risk (보수 cross-ref 1줄만, 본문 중복 검증 의무)", "phase-1+2 commit 후 INTENT~APPROVE smoke 신 era 인식 PASS 조건 (D13 APPROVE 게이트)"]
    },
    {
      "n": 4,
      "title": "ROADMAP schema 변경 (version + id 분리) + v2.2_* 4건 entry 제거",
      "scope": "projects/meta/ROADMAP.md milestones[] 모든 entry 신 schema (version + id 분리, version 단위 1 entry) 일괄 변환 + v2.2_* 4건 entry 제거 + v3.0 entry 임시 schema → 신 schema 변환 (D11 transition 종료) + smoke-projects-scope-discipline 사전 검증.",
      "affected_files": [
        "projects/meta/ROADMAP.md",
        "milestones/v3.0/milestones.md (sub-milestone-4 entry)",
        "milestones/v3.0/execute/phase-4.md"
      ],
      "rationale": "schema 변경 single commit + v2.2_* 4건 통합 흡수 (D14 commit ref). rollback 절차 명시 (D18 — git diff HEAD~ HEAD -- projects/meta/ROADMAP.md).",
      "risks": ["smoke-projects-scope-discipline (회귀 risk #2 — entry 구조 강검증 안 함, PASS 예상)"]
    },
    {
      "n": 5,
      "title": "milestones.md 신규 작성 + spec picture-frame",
      "scope": "milestones/v3.0/milestones.md 신규 — JSON 코드블록 (version / spec picture-frame / sub_milestones[] 8건 listing, 각 entry: id/title/status/phase/summary/dependencies/dependencies.absorbed_from). 신 schema 정식 키 매핑 (spec-drift D17 picture-frame).",
      "affected_files": [
        "milestones/v3.0/milestones.md",
        "milestones/v3.0/execute/phase-5.md"
      ],
      "rationale": "spec-drift 권고 #2 picture-frame + R7 mitigation (정보 손실 방지, dependencies.absorbed_from 명시).",
      "risks": ["보안 S5 (post-report-write.sh 매치 제외 — phase-1 D16 에서 이미 처리)"]
    },
    {
      "n": 6,
      "title": "v2.2_smoke-cp949-encoding-pattern 흡수",
      "scope": "tests/CLAUDE.md § '흔한 함정' 6번째 항목 (Windows cp949 콘솔 em dash UnicodeEncodeError + sys.stdout.reconfigure 패턴, errors='replace' 명시 D15) + smoke 작성 5-step Step 3 (Generate) 의무 + tests/smoke-python-entry-boilerplate.sh AST audit (sys.stdout.reconfigure 검증) + milestones.md sub-milestone-6 entry 갱신 (status: completed).",
      "affected_files": [
        "tests/CLAUDE.md",
        "tests/smoke-python-entry-boilerplate.sh",
        "milestones/v3.0/milestones.md",
        "milestones/v3.0/execute/phase-6.md"
      ],
      "rationale": "v2.2_smoke-cp949-encoding-pattern 책임 보존 (D14 commit ref) + 보안 S4 (D15) 흡수.",
      "risks": ["smoke-python-entry-boilerplate 활성화 (회귀 risk #5 — 본 phase 결정)"]
    },
    {
      "n": 7,
      "title": "v2.2_smoke-controlled-comparison-pattern 흡수",
      "scope": "tests/CLAUDE.md § '회귀 검증 절차' 항목에 controlled 비교 패턴 (git show HEAD: + diff CRLF 정규화) 명시 + milestones.md sub-milestone-7 entry 갱신.",
      "affected_files": [
        "tests/CLAUDE.md",
        "milestones/v3.0/milestones.md",
        "milestones/v3.0/execute/phase-7.md"
      ],
      "rationale": "v2.2_smoke-controlled-comparison-pattern 책임 보존 (D14 commit ref).",
      "risks": ["없음 (narrative만)"]
    },
    {
      "n": 8,
      "title": "v2.2_historical-7stage-stage1-decision 흡수 + 결정 적용",
      "scope": "smoke-scope-contract Stage 1 코드 (era='7-stage' 시) fp=PLAN.md vs INTENT.md fallback 결정 (옵션 a/b/c — phase 진행 시 AskUserQuestion) + milestones.md sub-milestone-8 entry 갱신 + 결정 결과 반영.",
      "affected_files": [
        "tests/smoke-scope-contract.sh",
        "milestones/v3.0/milestones.md",
        "milestones/v3.0/execute/phase-8.md"
      ],
      "rationale": "v2.2_historical-7stage-stage1-decision 책임 보존 (D14 commit ref). 결정 자체는 옵션 a/b/c phase 진행 시 사용자 결정.",
      "risks": ["era 분류 일관성 — 결정 옵션에 따라 detect_era (phase-2 _era_detect.py) 갱신 가능"]
    }
  ],
  "risk_mitigation": [
    {"risk_id": "R1", "risk": "smoke era 분기 4 era 코드 복잡화", "mitigation": "phase-2 tests/_era_detect.py 공유 모듈 분리 (D6 swap 으로 phase-1 직후 즉시 적용) — drift 잠재 1 phase 단축"},
    {"risk_id": "R2", "risk": "자기참조 inconsistency — INTENT~APPROVE commit 시 smoke 신 era 인식 부재", "mitigation": "phase-1 smoke era branching 선결 (D13 APPROVE go/no-go gate 명시) → phase-3 INTENT~APPROVE 일괄 commit"},
    {"risk_id": "R3", "risk": "ROADMAP schema 변경 break — 외부 도구 호환성", "mitigation": "RESEARCH 사전 grep 완료 (deprecated SKILL 만 영향, 회귀 risk #2 — smoke-projects-scope-discipline PASS 예상) + phase-4 일괄 갱신"},
    {"risk_id": "R4", "risk": "post-report-write.sh write trigger 패턴", "mitigation": "phase-1 hook 4 era 인식 + milestones.md 매치 제외 (D16)"},
    {"risk_id": "R5", "risk": "8 phase 큰 scope — partial fail recovery", "mitigation": "각 phase 1 commit + revert 단위 격리 + phase-4 ROADMAP schema rollback 절차 명시 (D18 — git diff HEAD~ HEAD)"},
    {"risk_id": "R6", "risk": "historical milestone cross-ref 깨짐", "mitigation": "forward-only (D1) 보장 — historical 디렉토리 unchanged"},
    {"risk_id": "R7", "risk": "v2.2_* 4건 흡수 정보 손실", "mitigation": "milestones.md JSON dependencies.absorbed_from 필드 (D14) + 각 phase commit 메시지 원 v2.2 milestone id reference"},
    {"risk_id": "R8", "risk": "cascade host narrative 누락 (4 host + ADR-006)", "mitigation": "phase-3 cascade host 6곳 (root CLAUDE.md / README.md / AGENTS.md / GUARDRAILS.md / docs/adr/ADR-006-workflow-revamp.md / projects/meta/CLAUDE.md) cross-ref 1줄 (보수)"},
    {"risk_id": "R9", "risk": "INTENT vs ROADMAP schema transition state inconsistency", "mitigation": "INTENT.md 신 schema 유지 (D9 도그푸드) + ROADMAP transition 명시 (D11 — phase-4 까지 임시 기존 schema)"},
    {"risk_id": "R10", "risk": "5 관점 검토 의견 충돌", "mitigation": "5 관점 병렬 spawn 완료 + 의견 충돌 2건 사용자 결정 완료 (phase 분할/순서 + bundling trigger 위치)"},
    {"risk_id": "S4", "risk": "sys.stdout.reconfigure errors='replace' 인자 명시 부재 (보안 MEDIUM)", "mitigation": "phase-6 v2.2_smoke-cp949-encoding-pattern 흡수 시 errors='replace' 통일 (D15)"},
    {"risk_id": "S5", "risk": "milestones.md hook 오인 (보안 MEDIUM)", "mitigation": "phase-1 post-report-write.sh 패턴 갱신 시 milestones.md 매치 제외 (D16)"},
    {"risk_id": "S6", "risk": "v2.2_* 흡수 commit destructive (보안 MEDIUM)", "mitigation": "phase-4/6/7/8 commit 메시지에 원 v2.2 milestone id reference 의무 (D14) — 디렉토리 자체 삭제 금지 (pending 상태로 디렉토리 미생성)"}
  ]
}
```

## 5 관점 검토 종합

| # | 관점 | verdict | 핵심 권고 (개수) | 흡수 위치 |
|:-:|------|---------|------|-----------|
| 1 | architecture (Plan) | pass-with-comments | 5 | D6 (phase swap) / D9 (R9) / D10 (era 표지) / D2 (id ↔ 디렉토리 narrative) |
| 2 | spec-drift (general-purpose + context7) | pass-with-comments | 5 | D17 (breaking change + era 영구화) / D5 (picture-frame) / D12 (bundling trigger) / D7 (자기참조 정합) |
| 3 | 회귀 risk (Explore) | pass-with-comments | 5 | D6 (phase swap) / D11 (transition state) / D16 (hook) / phase-1 검증 매트릭스 |
| 4 | 보안 (general-purpose + security-review SKILL) | pass-with-comments (CRITICAL/HIGH 0, MEDIUM 3) | 5 | D15 (errors='replace') / D16 (hook 매치) / D14 (commit ref) / S1-S3 LOW 자동 |
| 5 | scope contract (Explore) | pass-with-comments | 5 의견 충돌 식별 | D9 (R9) / D13 (APPROVE gate) / D14+D5 (R7) / D18 (rollback) / D19 (VERIFY 시점) |

**의견 충돌 해소** (사용자 결정 2건):

- phase 분할/순서 → 8 phase + phase-5 swap (D6)
- bundling trigger 명문화 위치 → ARCHITECTURE.md § 6 (D12)

**자동 흡수** (DESIGN.decisions D7 / D9 / D10 / D14 / D15 / D16 / D17 / D18 / D19):

- C: 9-stage-bundled era 표지 = (a)+(b) 조합
- R9: INTENT.md 신 schema 유지 (도그푸드)
- 보안 4건 (S4 errors='replace' / S5 hook 매치 제외 / S6 commit ref / D7 자기참조 정합)
- spec-drift 5건 (breaking change / picture-frame / bundling trigger / 자기참조 / era 영구화)

## 결정 상세

D1~D19 = 사용자 결정 9건 (D1~D6, D8, D12) + 5 관점 권고 자동 흡수 10건 (D7, D9, D10, D11, D13~D19).

## phases 상세

8 phase = 인프라 (1+2) → 자기참조 commit (3) → schema/구조 (4+5) → 흡수 (6+7+8). phase-2 swap 으로 v2.2_era-detect-shared-module 흡수가 인프라 단계에 통합. phase-3 = 정책 명문화 + INTENT~APPROVE 동시 commit (자기참조 부합).

각 phase = 1 commit (conventional commits, R5 mitigation).

| phase | title | commit message 예 |
|:-:|------|------|
| 1 | smoke era branching | `feat(meta): v3.0 phase-1 — smoke era branching (4 era 인식)` |
| 2 | _era_detect.py 분리 | `feat(meta): v3.0 phase-2 — tests/_era_detect.py 분리 (v2.2_era-detect-shared-module 흡수)` |
| 3 | 정책 명문화 + INTENT~APPROVE commit | `feat(meta): v3.0 phase-3 — milestone hierarchy 정책 명문화 + 자기참조 산출` |
| 4 | ROADMAP schema 변경 | `feat(meta): v3.0 phase-4 — ROADMAP schema (version+id 분리) + v2.2_* 4건 흡수` |
| 5 | milestones.md 도입 | `feat(meta): v3.0 phase-5 — milestones.md (sub-milestone listing per version)` |
| 6 | cp949 흡수 | `feat(meta): v3.0 phase-6 — v2.2_smoke-cp949-encoding-pattern 흡수 (cp949 콘솔 인코딩)` |
| 7 | controlled-comparison 흡수 | `feat(meta): v3.0 phase-7 — v2.2_smoke-controlled-comparison-pattern 흡수 (회귀 검증 패턴)` |
| 8 | historical-decision 흡수 | `feat(meta): v3.0 phase-8 — v2.2_historical-7stage-stage1-decision 흡수 (era 7-stage Stage 1 결정)` |

## risk_mitigation 상세

13건 risk (R1~R10 + S4/S5/S6) 모두 mitigation 명시. R2 (high) 가 가장 결정적 — phase-1 선결 + APPROVE go/no-go gate (D13).

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 + § 6 (phase-3 갱신)
- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- 다음 단계: APPROVE.md 작성 (사용자 명시 승인 게이트, D13 phase-1 smoke PASS 조건 명시)
