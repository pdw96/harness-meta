# VERIFY — v3.0_milestones-restructure

```json
{
  "verdict": "pass",
  "regressions": 0,
  "smoke_tests": [
    {"name": "smoke-projects-scope-discipline", "command": "pre-commit run smoke-projects-scope-discipline --all-files", "result": "PASS", "output": "root ROADMAP thin index 강제 — 위반 0"},
    {"name": "smoke-spec-verification", "command": "bash tests/smoke-spec-verification.sh", "result": "PASS=116 FAIL=0 SKIP=81", "output": "9 stage 검증 모두 PASS — v3.0 신규 산출물 8건 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7종 + execute/phase-{1..8}.md 8건) 모두 인식"},
    {"name": "smoke-scope-contract", "command": "bash tests/smoke-scope-contract.sh", "result": "PASS=19 FAIL=0 SKIP=21", "output": "v3.0 = 9-stage-bundled era 분류 → INTENT.out_of_scope + APPROVE.approval.approved_by='user' 검증 활성화 (R2 mitigation 완성)"},
    {"name": "smoke-cross-ref", "command": "pre-commit run smoke-cross-ref --all-files", "result": "PASS", "output": "cascade host 6곳 + ARCHITECTURE.md cross-ref 정합 — 위반 0"},
    {"name": "smoke-claude-md-drift", "command": "pre-commit run smoke-claude-md-drift --all-files", "result": "PASS", "output": "root CLAUDE.md ↔ 모듈 CLAUDE.md drift 0 — smoke 카운트 27 보존, helper 1 (_era_detect.py) 별도 narrative"},
    {"name": "smoke-python-entry-boilerplate", "command": "bash tests/smoke-python-entry-boilerplate.sh", "result": "PASS (Stage 3 E2E PASS=3 FAIL=0)", "output": "P1 write_text newline + P2 __main__ + print + reconfigure(encoding=) 검증 모두 정상 (D15 errors='replace' 통일 narrative 만)"},
    {"name": "pre-commit run --all-files", "command": "pre-commit run --all-files", "result": "PASS (12 hook 모두 PASS)", "output": "built-in 5 + shellcheck + markdownlint + smoke 5 모두 통과"}
  ],
  "manual_checks": [
    {"check": "milestones/v3.0/ 디렉토리 + 8 산출물 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7 + milestones.md + execute/phase-{1..8}.md) 존재", "result": "PASS", "notes": "v3.0 = 자기참조 부합 9-stage-bundled era 첫 적용 사례, milestones.md 단일 source per version"},
    {"check": "ROADMAP.md schema — v3.0 entry 신 schema (version + id 분리) + v2.2_* 4건 entry 부재 + 보존 entry 기존 schema 유지", "result": "PASS", "notes": "schema_note 필드 신규 명시 (신/기존 schema 공존)"},
    {"check": "milestones/v3.0/milestones.md sub_milestones[] 8건 listing — 모두 status: completed", "result": "PASS", "notes": "phase-1 (smoke era) / phase-2 (era-detect 흡수) / phase-3 (정책 명문화) / phase-4 (ROADMAP schema) / phase-5 (milestones.md) / phase-6 (cp949 흡수) / phase-7 (controlled-comparison 흡수) / phase-8 (historical-decision 흡수)"},
    {"check": "forward-only — historical milestone (v1.84~v2.1) 디렉토리 명 unchanged", "result": "PASS", "notes": "git diff HEAD~9 HEAD --name-only -- 'projects/meta/milestones/v1.*' 'projects/meta/milestones/v2.0_*' 'projects/meta/milestones/v2.1_*' empty (변경 0)"},
    {"check": "자기참조 부합 — v3.0 자체가 신 구조 첫 적용 (예외 표지 부재)", "result": "PASS", "notes": "milestones/v3.0/ + milestones.md + INTENT/RESEARCH/DESIGN/APPROVE 모두 신 schema (version + id 분리) — D7 도그푸드 정신 부합"},
    {"check": "tests/_era_detect.py 단일 source — smoke-spec-verification (호출 부재) + smoke-scope-contract (import 사용)", "result": "PASS", "notes": "v2.2_era-detect-shared-module 흡수 phase-2 — drift risk 0"},
    {"check": "cascade host 9곳 narrative 정합 (CLAUDE.md root + projects/meta/CLAUDE.md + harness-meta.md + tests/CLAUDE.md + AGENTS.md + README.md + GUARDRAILS.md + ADR-006 + ARCHITECTURE.md)", "result": "PASS", "notes": "보수 cross-ref 1줄 ~ 핵심 narrative 갱신 — 본문 중복 회피, ARCHITECTURE.md § 6.1 단일 source"}
  ],
  "criteria_check": [
    {"criterion": "ROADMAP `milestones[]` schema 변경: 모든 entry 가 `version` + `id` 분리 형식 (기존 `id: v{X.Y}_{slug}` flat 폐기, version 단위 1 entry — sub-milestone 상세는 milestones.md 위임)", "phase": 4, "verified_by": "manual + smoke", "result": "PASS (절충: v3.0+ 신 schema 적용, 보존 entry 기존 schema 유지 = forward-only 정합)"},
    {"criterion": "신 디렉토리 구조 milestones/v{X.Y}/ 마운트 가능 (자기참조: milestones/v3.0/ 자체 신 구조 작성, 예외 표지 없음)", "phase": "1+OPEN", "verified_by": "manual", "result": "PASS"},
    {"criterion": "milestones/v{X.Y}/milestones.md 신규 파일 — sub-milestone listing per version (id/title/status/summary/dependencies/phase 매핑 JSON 코드블록)", "phase": 5, "verified_by": "manual", "result": "PASS (spec picture-frame + Instance + 흡수 추적성 표 + 의존 그래프)"},
    {"criterion": "smoke era 분기 4 era 인식: 4-tier (v1.84~v1.88) / 7-stage (v1.0~v1.4) / 9-stage (v2.0~v2.1) / 9-stage-bundled (v3.0+) — smoke-spec-verification + smoke-scope-contract 모두 PASS", "phase": "1+2", "verified_by": "smoke", "result": "PASS (PASS 113→116 phase-3~8 산출물 추가, scope-contract 17→19 v3.0 era 인식 활성화)"},
    {"criterion": "정책 명문화 host 4곳 + cascade 5곳: CLAUDE.md (root) / claude/commands/harness-meta.md / projects/meta/ARCHITECTURE.md / projects/meta/CLAUDE.md / tests/CLAUDE.md / AGENTS.md / README.md / GUARDRAILS.md / docs/adr/ADR-006-workflow-revamp.md — bundling trigger 조건 + version > sub-milestone > phase 계층 + forward-only 정책 + 자기참조 부합 권장", "phase": 3, "verified_by": "manual + smoke (cross-ref)", "result": "PASS (단일 source = ARCHITECTURE.md § 6.1, 보수 cross-ref)"},
    {"criterion": "v2.2_* 4건 흡수: ROADMAP entry 4건 제거 + v3.0 milestones.md sub-milestone phase 5-8 로 책임 완료 (era-detect / cp949 / controlled-comparison / historical-decision 각자 변경 적용)", "phase": "2+4+6+7+8", "verified_by": "manual + commit ref", "result": "PASS (D6 swap 으로 era-detect = phase-2, cp949 = phase-6, controlled-comparison = phase-7, historical-decision = phase-8 흡수. 각 phase commit 메시지에 원 v2.2 milestone id reference)"},
    {"criterion": "forward-only — historical milestone (v1.84~v1.88 4-tier, v1.0~v2.1 9-stage 이전) 디렉토리 명 unchanged + smoke 인식 유지", "phase": "all", "verified_by": "manual + smoke", "result": "PASS (디렉토리 명 변경 0, smoke 4 era 인식 모두 PASS)"},
    {"criterion": "pre-commit smoke 5 hook 모두 PASS, 회귀 0", "phase": "all", "verified_by": "pre-commit run --all-files", "result": "PASS (12 hook 모두 PASS, regressions 0)"}
  ],
  "phase_commit_summary": [
    {"phase": 1, "commit": "b70431a", "title": "smoke era branching (4 era 인식)", "smoke_result": "PASS=109/17"},
    {"phase": 2, "commit": "2c75f02", "title": "tests/_era_detect.py 분리 (v2.2_era-detect-shared-module 흡수)", "smoke_result": "PASS=109/17"},
    {"phase": 3, "commit": "55e5cce", "title": "milestone hierarchy 정책 명문화 + INTENT~APPROVE 자기참조 commit", "smoke_result": "PASS=111/17"},
    {"phase": 4, "commit": "a94d4a3", "title": "ROADMAP schema (version+id 분리) + v2.2_* 4건 entry 제거", "smoke_result": "PASS=112/17"},
    {"phase": 5, "commit": "53fa077", "title": "milestones.md (sub-milestone listing per version)", "smoke_result": "PASS=113/19 (v3.0 era 분류 변환 → APPROVE 검증 활성화)"},
    {"phase": 6, "commit": "0a80280", "title": "v2.2_smoke-cp949-encoding-pattern 흡수 (cp949 패턴 + D15 errors='replace')", "smoke_result": "PASS=114/19"},
    {"phase": 7, "commit": "6888a0c", "title": "v2.2_smoke-controlled-comparison-pattern 흡수 (controlled 비교 4-step)", "smoke_result": "PASS=115/19 (narrative 만, +1 phase-7.md)"},
    {"phase": 8, "commit": "fec7894", "title": "v2.2_historical-7stage-stage1-decision 흡수 (결정 (a) 보존)", "smoke_result": "PASS=116/19"}
  ],
  "go_no_go_gate_results": {
    "phase_1_smoke_pass": true,
    "phase_2_era_detect_import_compat": true,
    "phase_3_self_reference_commit": true,
    "all_phases_smoke_pass": true,
    "regressions_count": 0
  }
}
```

## verdict 종합

**PASS** — INTENT.success_criteria 8건 모두 PASS (manual 5건 + smoke 3건). regressions 0. pre-commit run --all-files 12 hook 모두 통과.

**자기참조 부합 검증** (D7 도그푸드 핵심):

- v3.0 milestone 자체가 milestones/v3.0/ + milestones.md + INTENT~APPROVE 신 schema 첫 적용 사례
- phase-5 commit 후 detect_era('milestones/v3.0/') = '9-stage-bundled' 정착 (D10 표지)
- smoke-scope-contract Stage 1+2 가 v3.0 INTENT.out_of_scope + APPROVE.approval 검증 활성화 (PASS 17→19)
- 예외 표지 (v2.0 7-stage 회피 선례) 부재 — 도그푸드 정신 부합

**R2 (자기참조 inconsistency) mitigation 완성**:

- phase-1 smoke era branching 선결 commit → phase-3 INTENT~APPROVE 일괄 commit (smoke 신 era 인식 통과)
- phase-5 milestones.md 작성 후 v3.0 era 분류 = 9-stage-bundled 변환 → R2 transition state 종료

**v2.2_* 4건 흡수 책임 보존** (D14 + R7 mitigation):

- 각 phase commit 메시지에 원 v2.2 milestone id reference 의무 적용
- milestones.md sub-milestone entry 마다 absorbed_from 필드 명시
- 흡수 추적성 표 (4 v2.2 → phase 2/6/7/8) milestones.md § 흡수 추적성

## 회귀 검증 절차 (controlled 비교 — phase-7 흡수 직접 적용)

본 milestone 자체가 phase-7 패턴 직접 적용:

- phase-1~8 각 commit 후 smoke 실행 → phase commit summary 표
- 회귀 0 확인 (PASS 변동은 v3.0 신규 산출물 추가 + v3.0 era 분류 변환 = 의도된 변경)
- phase commit summary narrative 기록 (의도된 변경 vs 회귀 분기)

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- INTENT: [`INTENT.md`](INTENT.md) (success_criteria 8건)
- DESIGN: [`DESIGN.md`](DESIGN.md) (D1~D19 결정 + 8 phases)
- APPROVE: [`APPROVE.md`](APPROVE.md) (사용자 명시 승인 + go/no-go gate)
- milestones.md: [`milestones.md`](milestones.md) (sub-milestone 8건 status: completed)
- execute/: phase-{1..8}.md 8 산출물
