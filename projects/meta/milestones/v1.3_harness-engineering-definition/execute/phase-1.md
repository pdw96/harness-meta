# EXECUTE phase-1 — 정의 본문 + 5요소 매트릭스 박기

```json
{
  "milestone": "v1.3_harness-engineering-definition",
  "phase": 1,
  "status": "in_progress",
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
  "execution_notes": []
}
```

## 진행 상태

- [x] phase-1.md 작성 (in_progress)
- [ ] projects/meta/ARCHITECTURE.md § 3 신규 삽입 + § 3~6 시프트
- [ ] pre-commit smoke 통과
- [ ] commit
- [ ] phase-1.md status complete + execution_notes 갱신
