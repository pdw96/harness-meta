# EXECUTE phase-1 — 정의 본문 + 5요소 매트릭스 박기

```json
{
  "milestone": "v1.3_harness-engineering-definition",
  "phase": 1,
  "status": "complete",
  "title": "정의 본문 + 5요소 매트릭스 박기 (projects/meta/ARCHITECTURE.md)",
  "scope": "정전 본체 추가 — 1~2문장 working definition + 명료화 단락 + working philosophy + 4컬럼 5요소 매트릭스 + 외부 컨벤션 관계 단락 + 단일 source 명시",
  "affected_files": [
    "projects/meta/ARCHITECTURE.md",
    "projects/meta/milestones/v1.3_harness-engineering-definition/execute/phase-1.md"
  ],
  "changes": [
    {
      "file": "projects/meta/ARCHITECTURE.md",
      "action": "신규 § 3 '하네스 엔지니어링 정의 (정전 — single source)' 삽입 + 기존 § 3~6 헤더 번호 § 4~7 로 시프트. § 3 본문 = working_definition + clarifying_paragraph + user_philosophy_statement + 5요소 4컬럼 매트릭스 + external_relation_narrative + 단일 source 명시.",
      "intent": "DESIGN.approach + DESIGN.definition_draft 의 1:1 옮김. 본 파일 = 정전 single source."
    }
  ],
  "commit_message_planned": "feat(meta): v1.3 phase-1 — 하네스 엔지니어링 정의 본문 박기 (projects/meta/ARCHITECTURE.md § 3 신규)",
  "commit_hash": "b7a7007",
  "execution_notes": [
    "ARCHITECTURE.md 가 77줄 → 110줄로 증가 (예상 110~120줄 내, 운영 적정 L130 이하 유지).",
    "기존 § 3~6 → § 4~7 시프트 적용. 헤더 번호 일관성 유지 (root CLAUDE.md / AGENTS.md 의 cross-ref 는 본 파일 자체 경로만 가리키므로 시프트 영향 없음 — phase-2 cross-ref 1줄은 아직 미추가).",
    "pre-commit smoke 8건 모두 통과: end-of-files / trim trailing whitespace / merge conflicts / large files / markdownlint / smoke-projects-scope-discipline / smoke-spec-verification (7-stage JSON schema) / smoke-scope-contract (out_of_scope + DESIGN.approval) / smoke-cross-ref. shellcheck / yaml / claude-md-drift 는 affected 파일 없어 skip.",
    "PLAN.success_criteria 1~3 충족 확인: (1) working definition 1~2문장 § 3.1 grep 가능, (2) 4컬럼 5요소 매트릭스 § 3.3, (3) working philosophy § 3.2 명문화. SC #4 (단일 source) 는 phase-2 의 root CLAUDE.md cross-ref 추가로 보강 예정. SC #5 (next_candidates) 는 Stage G 책임 — DESIGN 재해석 명시.",
    "DESIGN.approval=user/2026-05-09 게이트 통과 후 진입."
  ]
}
```

## 진행 상태

- [x] phase-1.md 작성 (in_progress)
- [x] projects/meta/ARCHITECTURE.md § 3 신규 삽입 + § 3~6 시프트
- [x] pre-commit smoke 통과 (8건 PASS)
- [x] commit (b7a7007)
- [x] phase-1.md status complete + execution_notes 갱신
