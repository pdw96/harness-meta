# execute/phase-1 — v3.1_workflow-policy-fine-tuning

```json
{
  "phase": 1,
  "title": "tests/CLAUDE.md § '흔한 함정' 7번째 항목 — markdownlint MD032/MD049 trap narrative",
  "status": "completed",
  "commit_sha": "0a86598",
  "commit_message_actual": "feat(meta): v3.1 phase-1 — markdownlint MD032/MD049 trap narrative + milestones.md 신규",
  "sub_milestone_id": "markdownlint-trap-narrative",
  "absorbed_from": "v3.1_markdownlint-trap-narrative (v3.0 PROPOSE next_candidates)",
  "scope_implemented": [
    "milestones/v3.1/milestones.md 신규 (R1 mitigation — detect_era 9-stage-bundled 인식 보장) + spec picture-frame cross-ref (D17 — v3.0/milestones.md spec 섹션, 본문 spec 정의 복제 부재) + sub_milestones[] 3건 (phase-1 status: in_progress, phase-2/3 status: pending) + dependencies 표현 (D14: phase-1=[], phase-2=[1], phase-3=[2]) + 흡수 추적성 표 + 의존 그래프",
    "tests/CLAUDE.md § '흔한 함정' 표 7번째 row 추가 — markdownlint MD032/MD049 자동 차단. 증상 (a) MD032 강조 직후 list 빈 줄 부재 (b) MD049 underscore intra-word emphasis 오인. 회피 (a) 빈 줄 1개 의무 (b) 백틱 escape + MD049 spec 직접 인용 (D18)",
    "tests/CLAUDE.md § '흔한 함정' 헤더 narrative 갱신 ('6 evidence-base, v1.75+ / v3.0 cp949 추가' → '7 evidence-base, v1.75+ / v3.0 cp949 / v3.1 markdownlint 추가')"
  ],
  "affected_files": [
    "tests/CLAUDE.md",
    "projects/meta/milestones/v3.1/milestones.md",
    "projects/meta/milestones/v3.1/execute/phase-1.md"
  ],
  "self_check_pre_commit": {
    "markdownlint": "pre-commit run markdownlint --files tests/CLAUDE.md projects/meta/milestones/v3.1/milestones.md projects/meta/milestones/v3.1/execute/phase-1.md",
    "smoke_cross_ref": "bash tests/smoke-cross-ref.sh --fix (D13 + R4 mitigation)",
    "smoke_spec_verification": "milestones/v3.1/ 디렉토리 detect_era → 9-stage-bundled 인식 + INTENT/RESEARCH/DESIGN/APPROVE/milestones.md 검증",
    "smoke_scope_contract": "v3.1 INTENT.out_of_scope + APPROVE.approved_by gate 검증"
  },
  "execution_notes": "phase-1 시작 직후 milestones.md 즉시 작성 (R1 mitigation, CRITICAL — 회귀 risk Explore agent 권고). detect_era (tests/_era_detect.py) 가 v3.1 디렉토리를 9-stage-bundled era 로 인식하기 위한 표지 = 디렉토리 명 `^v\\d+\\.\\d+$` + milestones.md 존재. milestones.md 부재 시 7-stage 또는 9-stage 오인 가능성. 따라서 INTENT/RESEARCH/DESIGN/APPROVE.md 작성 직후 milestones.md 마운트 의무.",
  "commit_message_intent": "feat(meta): v3.1 phase-1 — tests/CLAUDE.md § '흔한 함정' markdownlint MD032/MD049 trap (v3.0 lessons L10 + v3.1_markdownlint-trap-narrative 흡수)"
}
```

## 진행 narrative

phase-1 = v3.0 lessons L10 (markdownlint 자동 차단 함정) 직접 후속 흡수. v3.0 phase-3 commit 시 발견된 두 함정:

1. **MD032 (blanks-around-lists)**: `**필수 게이트**:` 같은 강조 직후 list 시작 시 빈 줄 부재로 markdownlint fail. v3.0 APPROVE.md / DESIGN.md 작성 시 trigger.
2. **MD049 (emphasis-style consistent)**: v3.0 INTENT.md 안 `v{X.Y}_{slug}` 패턴의 `_` pair 가 emphasis (italic) 오인 → fail. markdownlint 공식 spec: "intra-word emphasis is restricted to asterisk to avoid unwanted emphasis for words containing internal underscores".

회피 권고:

- (a) 강조 직후 list 시 빈 줄 1개 의무
- (b) underscore 포함 identifier 백틱 escape (`` `v{X.Y}_{slug}` ``)

자동 강제 부재 — markdownlint pre-commit hook 자체가 이미 차단하지만, 작성 시 사전 안내 narrative (tests/CLAUDE.md § '흔한 함정' 7번째 row) 누적. v3.0+ 9-stage-bundled era 첫 후속 통합 milestone 사례 — milestones.md 신규 (R1 CRITICAL mitigation) + sub_milestones[] dependencies 표현 (D14).

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) (D11/D17/D18 + phase-1 scope)
- 상위 정전: [`../../../ARCHITECTURE.md`](../../../ARCHITECTURE.md) § 6.1
- v3.0 lessons L10 source: [`../../v3.0/REPORT.md`](../../v3.0/REPORT.md)
- v3.0 PROPOSE 흡수 source: [`../../v3.0/PROPOSE.md`](../../v3.0/PROPOSE.md)
