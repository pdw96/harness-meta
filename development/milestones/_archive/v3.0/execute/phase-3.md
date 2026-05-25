# phase-3 — 정책 명문화 (ARCHITECTURE § 6.1 + cascade 6 host) + INTENT~APPROVE 자기참조 commit

```json
{
  "phase": 3,
  "status": "completed",
  "title": "milestone hierarchy 정책 명문화 (단일 source = ARCHITECTURE.md § 6.1) + 자기참조 부합 산출 commit",
  "scope": [
    "projects/meta/ARCHITECTURE.md: § 1 디렉토리 구조 (4 era 공존), § 3.3 'Workflow' 행 (4 era 발전 narrative), § 4 9-stage workflow 헤더 + § 4.1 Bundling 신규 섹션, § 6.1 era 정책 (4 era 표 + bundling trigger 조건 + 자기참조 부합 + breaking change + era 영구화 trade-off)",
    "projects/meta/CLAUDE.md: 모듈 가이드 milestone 산출물 narrative 갱신 (3 era 공존)",
    "claude/commands/harness-meta.md: 9-stage workflow 헤더 + bundling narrative + 대상 구분 표 + Stage A 컨테이너 mkdir 갱신",
    "tests/CLAUDE.md: smoke 매트릭스 헤더 (27 + helper 1) + smoke-spec-verification + smoke-scope-contract narrative 4 era 갱신",
    "CLAUDE.md (root): 모듈별 가이드 + 워크플로우 표 + 구조 규칙 (CRITICAL) milestone 번호 정책 4 era 갱신",
    "AGENTS.md: 영문 narrative 3건 (Milestone artifacts / Legacy era preservation / Boundaries)",
    "README.md: 영문 narrative 2건 (디렉토리 구조 + Workflow)",
    "GUARDRAILS.md: H1 (산출물 list) + C4 (major bump 사례) + § 4 헤더",
    "docs/adr/ADR-006-workflow-revamp.md: 후속 ADR 발전 narrative + cross-ref 갱신",
    "INTENT.md / RESEARCH.md / DESIGN.md / APPROVE.md 자기참조 부합 commit (milestones/v3.0/ 신 구조)"
  ],
  "rationale": "정책 명문화 (D12) — bundling trigger 조건 + version 계층 + forward-only + 자기참조 부합 + breaking change + era 영구화 정전 single source = ARCHITECTURE.md § 6.1. cascade 6 host 는 보수 cross-ref + 핵심 narrative 갱신 (R8 mitigation, 본문 중복 회피). 자기참조 부합 (D7) — INTENT~APPROVE 4 산출물이 자체 milestones/v3.0/ 신 구조에 commit (도그푸드).",
  "decisions_referenced": ["D12 (bundling trigger 명문화 = ARCHITECTURE.md § 6.1)", "D7 (자기참조 부합)", "D17 (breaking change + era 영구화)", "D2 (id ↔ 디렉토리 inconsistency narrative)", "D10 (9-stage-bundled era 표지)", "R8 (cascade host 보수 cross-ref)"],
  "verification": {
    "smoke_spec_verification": "PASS=109 FAIL=0 SKIP=81 (phase-2 동일, INTENT 필드 검증 PASS)",
    "smoke_scope_contract": "PASS=17 FAIL=0 SKIP=23 (phase-2 동일, v3.0 7-stage fallback transition state)",
    "smoke_cross_ref": "PASS (cascade 6 host cross-ref 정합)",
    "smoke_claude_md_drift": "PASS (smoke 카운트 27 보존, helper 1 별도 narrative)"
  }
}
```

## 작업 내용

### 정책 명문화 — 정전 single source

1. **ARCHITECTURE.md § 6.1** (정전): 4 era 표 (4-tier / 7-stage / 9-stage / 9-stage-bundled) + bundling 정책 (의미 단위 grouping trigger) + 자기참조 부합 (도그푸드 narrative) + breaking change → major bump (semver 정합) + era 영구화 trade-off (forward-only 비용)
2. **ARCHITECTURE.md § 4.1**: Bundling 신규 섹션 (v3.0+ 9-stage-bundled era)
3. **ARCHITECTURE.md § 1 / § 3.3**: 디렉토리 구조 + 5요소 매트릭스 'Workflow' 행 갱신

### Cascade 6 host — 보수 cross-ref + 핵심 narrative

- **projects/meta/CLAUDE.md**: 모듈 가이드 milestone 산출물 narrative
- **claude/commands/harness-meta.md**: 9-stage workflow 헤더 + bundling 1단락 + 대상 구분 표 + Stage A mkdir 갱신
- **tests/CLAUDE.md**: smoke 매트릭스 헤더 + 두 smoke narrative
- **CLAUDE.md (root)**: 워크플로우 표 + CRITICAL 규칙 milestone 번호 정책
- **AGENTS.md**: 영문 narrative 3건
- **README.md**: 영문 narrative 2건
- **GUARDRAILS.md**: H1 / C4 / § 4 헤더
- **docs/adr/ADR-006-workflow-revamp.md**: 후속 ADR 발전 narrative + cross-ref

### 자기참조 부합 산출물 commit

INTENT.md (Stage B), RESEARCH.md (Stage C), DESIGN.md (Stage D), APPROVE.md (Stage E) 모두 `milestones/v3.0/` 신 구조 (자기참조 부합) 에 작성. phase-1 smoke era branching + phase-2 _era_detect.py 분리 후 phase-3 commit 으로 신 era 인식 보장 (R2 mitigation 완성).

## execution_notes

- 정책 명문화 단일 source = ARCHITECTURE.md § 6.1. cascade host 는 본문 중복 회피하며 핵심 narrative 1줄~1단락만 갱신
- 자기참조 부합: v3.0 INTENT.md JSON 안 id 형식 = 신 schema (`{"version": "v3.0", "id": "milestones-restructure"}`). ROADMAP.md entry 는 임시 기존 schema (D11 transition state, phase-4 변환)
- v3.0 milestone 의 era 분류는 현 시점 7-stage fallback (PROPOSE.md + milestones.md 부재) → smoke-scope-contract Stage 2 SKIP. phase-5 milestones.md 작성 후 9-stage-bundled 로 변환되어 APPROVE.md 검증 활성화 (R2 mitigation transient cost)
- 14 파일 commit (정책 9 + 산출 4 + phase-3.md 1) — partial fail 시 git revert <phase-3 commit>

## commit

```
feat(meta): v3.0 phase-3 — milestone hierarchy 정책 명문화 + INTENT~APPROVE 자기참조 commit
```
