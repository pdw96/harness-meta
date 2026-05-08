# EXECUTE phase-2 — root CLAUDE.md cross-ref 추가

```json
{
  "milestone": "v1.3_harness-engineering-definition",
  "phase": 2,
  "status": "in_progress",
  "title": "root CLAUDE.md cross-ref 1줄 추가",
  "scope": "lazy load 약점 보강 — 자동 로드 primary host (root CLAUDE.md) 에 § 3 정의 host cross-ref 추가",
  "affected_files": [
    "CLAUDE.md",
    "projects/meta/milestones/v1.3_harness-engineering-definition/execute/phase-2.md"
  ],
  "changes": [
    {
      "file": "CLAUDE.md",
      "action": "L7 직후 (License / AGENTS.md 관계 단락 다음, '@ROADMAP.md' 직전) 에 '**하네스 엔지니어링 정의** (정전 single source): ...' 1줄 단락 추가",
      "intent": "Claude 매 세션 자동 로드 시 § 3 정의 host 인지 가능. 본문은 projects/meta/ARCHITECTURE.md § 3 단일 source, root CLAUDE.md 는 cross-ref 만 (DESIGN.decisions[3] 단일 source 정합 강제)."
    }
  ],
  "commit_message_planned": "feat(meta): v1.3 phase-2 — root CLAUDE.md 에 하네스 엔지니어링 정의 cross-ref 1줄 추가",
  "execution_notes": []
}
```

## 진행 상태

- [x] phase-2.md 작성 (in_progress)
- [ ] root CLAUDE.md L7 직후 cross-ref 1줄 추가
- [ ] pre-commit smoke 통과
- [ ] commit
- [ ] phase-2.md status complete + execution_notes 갱신
