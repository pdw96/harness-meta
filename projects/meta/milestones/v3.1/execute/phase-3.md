# execute/phase-3 — v3.1_workflow-policy-fine-tuning

```json
{
  "phase": 3,
  "title": "tests/smoke-bundle-trigger.sh 신규 + pre-commit 등록 (12 → 13 hook)",
  "status": "completed",
  "sub_milestone_id": "bundle-trigger-smoke",
  "absorbed_from": "v3.1_smoke-bundle-trigger-validation (v3.0 PROPOSE next_candidates)",
  "scope_implemented": [
    "tests/smoke-bundle-trigger.sh 신규 작성 — 단일 책임 (bundling validation, D2). 검증 책임 (D8): (1) 같은 version 값 v3.0+ entry 1건 강제 (= bundling 강제), (2) v3.0+ entry milestones_path 필드 형식 검증 (^milestones/v[0-9]+\\.[0-9]+/milestones\\.md$ + 실 파일 존재), (3) historical entry (version 필드 부재) 무시 (forward-only)",
    "표준 절차 적용 (D10): (a) batched python3 heredoc — 단일 호출 (smoke-projects-scope-discipline 동일 패턴), (b) cp949 reconfigure errors='replace' (tests/CLAUDE.md § '흔한 함정' 6번), (c) defense-in-depth — 100KB size guard + milestones_path regex",
    "detect_era 미호출 (D16) — ROADMAP entry schema 직접 검사 (`version` 필드 존재 여부) 로 9-stage-bundled 신 schema entry 식별. era 분류 (tests/_era_detect.py) 와 책임 분리",
    "controlled 비교 4-step 적용 (v3.0 phase-7 흡수): (1) baseline 부재 (신규 smoke), (2) post 신규 smoke + 현 ROADMAP, (3) 의도된 violation 주입 검증 — 중복 v3.0 entry 주입 시 FAIL exit=1 (smoke FAIL narrative 출력 + 정상 복원)",
    ".pre-commit-config.yaml 신규 hook 등록 (D3 — 자동 강제 누적 정신, 12 → 13 hook). entry: `bash tests/smoke-bundle-trigger.sh` (direct, --fix 미지원, D9). files: `ROADMAP\\.md$|projects/.*/ROADMAP\\.md$` (smoke-projects-scope-discipline 동일 패턴)",
    "tests/CLAUDE.md 갱신 (D15 — phase-3 책임): § smoke 매트릭스 헤더 카운트 27 → 28 + § '핵심 정책 검증' 1 row 추가 (smoke-bundle-trigger.sh) + § Pre-commit 통합 active hook 5 → 6 (v1.1 5 + v3.1 1) + 매트릭스 1 row 추가",
    "projects/meta/milestones/v3.1/milestones.md sub_milestones[1] status: completed → sub_milestones[2] status: in_progress → completed 갱신 (phase-3 commit 후)",
    "projects/meta/milestones/v3.1/execute/phase-2.md status: in_progress → completed (commit_sha: 4bd4ec6 추가)"
  ],
  "affected_files": [
    "tests/smoke-bundle-trigger.sh",
    ".pre-commit-config.yaml",
    "tests/CLAUDE.md",
    "projects/meta/milestones/v3.1/milestones.md",
    "projects/meta/milestones/v3.1/execute/phase-2.md",
    "projects/meta/milestones/v3.1/execute/phase-3.md"
  ],
  "self_check_pre_commit": {
    "smoke_bundle_trigger_pass": "bash tests/smoke-bundle-trigger.sh → 'smoke-bundle-trigger PASS' (현 ROADMAP v3.0/v3.1 entry 정합)",
    "violation_injection_fail": "중복 v3.0 entry 주입 → 'smoke-bundle-trigger FAIL' exit=1 + 'version=v3.0 entry 2건 발견 - bundling 정책 위반' narrative + 정상 복원",
    "ast_audit": "smoke-python-entry-boilerplate § P2 — Python heredoc reconfigure 의무 PASS (cp949 회피 boilerplate 적용)",
    "shellcheck": "shellcheck SC1102/SC2010/SC2064/SC2088/SC2034 violation 부재",
    "markdownlint": "tests/CLAUDE.md / phase-3.md 안 underscore identifier 백틱 escape (D13/D18 적용)"
  },
  "execution_notes": "phase-3 가 본 milestone 의 가장 무거운 phase — smoke 신규 + pre-commit 등록 + tests/CLAUDE.md 매트릭스 + 카운트 동기화. 자동 강제 누적 (5요소 매트릭스 'Constraint' 정전, D3). detect_era 미호출 (D16) 로 era 분류와 schema 검증 책임 분리 보장. v3.0 도그푸드 entry (version='v3.0') 가 본 smoke validation 시 PASS — milestones_path 필드 + 실 파일 존재 + 1건. v3.1 entry 도 동일 PASS. R2/R3 mitigation 검증 완료.",
  "commit_message_intent": "feat(meta): v3.1 phase-3 — tests/smoke-bundle-trigger.sh 신규 + pre-commit 등록 (12→13 hook, v3.1_smoke-bundle-trigger-validation 흡수)"
}
```

## 진행 narrative

phase-3 = ARCHITECTURE.md § 6.1 bundling 정책 자동 강제 누적. v3.0 phase-5 도입 milestones.md spec + § 6.1 bundling narrative 가 narrative 1차 source 였다면, 본 phase 는 자동 강제 (smoke 차단) 보조 — 5요소 매트릭스 'Constraint' 정전 정신 직접 적용 (자동 차단 우선).

검증 책임 (D8) 3건:

1. **같은 version 값 v3.0+ entry 1건 강제** — `version` 필드 보유 entry (v3.0+ 신 schema 표지) 가 같은 version 값 둘 이상 보유 시 FAIL. bundling 강제 (= 같은 version 의 후속 candidates 통합 milestone 운용)
2. **milestones_path 필드 형식 검증** — `^milestones/v[0-9]+\.[0-9]+/milestones\.md$` regex + 실 파일 존재. 신 schema 정합 보장
3. **historical entry 무시** — `version` 필드 부재 (id flat = `v{X.Y}_{slug}` 보유) entry 는 즉시 skip. forward-only 정책 일관

표준 절차 (D10) 적용 — batched python3 heredoc + cp949 reconfigure errors='replace' + AST audit boilerplate (smoke-python-entry-boilerplate § P2 PASS). detect_era 미호출 (D16) — ROADMAP entry schema 직접 검사 (책임 분리).

controlled 비교 4-step (v3.0 phase-7 흡수) 적용:

1. baseline 부재 (신규 smoke)
2. post — 신규 smoke + 현 ROADMAP (v3.0/v3.1 entry 정합 PASS)
3. 의도된 violation 주입 — 중복 v3.0 entry → FAIL exit=1 + narrative 출력 (cp949 errors='replace' 정상 작동, mojibake 발생하지만 crash 부재)
4. 정상 복원 후 PASS 재확인

.pre-commit-config.yaml 신규 hook 등록 — entry: direct (D9), files: `ROADMAP\.md$|projects/.*/ROADMAP\.md$` (smoke-projects-scope-discipline 동일 패턴, 단일 책임 분리). 12 → 13 hook 누적.

tests/CLAUDE.md 동기화 (D15 — phase-3 책임): 매트릭스 헤더 27 → 28 + 핵심 정책 검증 표 1 row 추가 + Pre-commit 통합 5 → 6 active hook + 매트릭스 1 row 추가.

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) (D2/D3/D8/D9/D10/D15/D16 + phase-3 scope)
- 상위 정전: [`../../../ARCHITECTURE.md`](../../../ARCHITECTURE.md) § 6.1
- v3.0 PROPOSE 흡수 source: [`../../v3.0/PROPOSE.md`](../../v3.0/PROPOSE.md) (next_candidates v3.1_smoke-bundle-trigger-validation)
- 표준 절차 reference: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md) § 'smoke 작성 5-step 흐름' + § '흔한 함정' 6번 (cp949)
