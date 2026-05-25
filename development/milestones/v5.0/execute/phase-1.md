# phase-1 — v5.0 plugin-pivot

```json
{
  "phase": 1,
  "title": "Plugin manifest 신규 + 사용자 onboarding cascade (3 host + hooks.json 신규)",
  "status": "complete",
  "scope": "(a) `.claude-plugin/plugin.json` 신규 (manifest + paths 명시) + (b) `.claude-plugin/marketplace.json` 신규 (local marketplace) + (c) `claude/hooks/hooks.json` 신규 (Plugin schema PostToolUse + SessionStart matcher) + (d) README.md 설치 section 재작성 + (e) AGENTS.md 영문 onboarding 동치 + (f) CLAUDE.md root 설치 section 동치. cascade 표준 narrative 정확 문구 정전화 (v3.21 3 단계 패턴 (b)).",
  "affected_files": [
    "projects/meta/milestones/v5.0/execute/phase-1.md",
    ".claude-plugin/plugin.json (신규)",
    ".claude-plugin/marketplace.json (신규)",
    "claude/hooks/hooks.json (신규)",
    "README.md",
    "AGENTS.md",
    "CLAUDE.md"
  ],
  "commit_message": "feat(meta): v5.0 phase-1 — Plugin manifest 신규 + 사용자 onboarding cascade 3 host + hooks.json (.claude-plugin/{plugin,marketplace}.json + claude/hooks/hooks.json + README/AGENTS/CLAUDE.md install section 재작성)",
  "execution_notes": [
    "manifest 3건 신규 완료 — .claude-plugin/plugin.json (paths 명시 D6 안전 옵션: 2 standalone .md 개별 + project-harness-audit-team/ 디렉토리), .claude-plugin/marketplace.json (source: '.', name 동일 'harness-meta'), claude/hooks/hooks.json (PostToolUse Write|Edit + SessionStart matcher, ${CLAUDE_PLUGIN_ROOT} 변수 활용)",
    "cascade 3 host edit 완료 — README.md (Installation section 전면 재작성, claude plugin marketplace add + install 표준 명령 + migration cleanup 권고 OS 분기 + deprecation 표지), AGENTS.md (영문 onboarding 동치), CLAUDE.md root (Plugin spec narrative + ## 명령어 § 설치 section 재작성)",
    "v3.21 narrative 정전화 3 단계 패턴 (b) 적용 — DESIGN cascade 표준 narrative 정확 문구 EXECUTE Edit tool 안 그대로 삽입 (claude plugin install / plugin marketplace add / .claude-plugin/plugin.json 3 키워드 + deprecation 표지 + cleanup 권고 narrative)"
  ]
}
```

## 진행 순서

1. `.claude-plugin/` 디렉토리 생성
2. `.claude-plugin/plugin.json` 신규 (DESIGN § "phase-1 plugin.json 안 paths 명시 1차 source" 정확 문구)
3. `.claude-plugin/marketplace.json` 신규 (DESIGN § "phase-1 marketplace.json 안 plugin entry 1차 source" 정확 문구)
4. `claude/hooks/hooks.json` 신규 (DESIGN § "phase-1 plugin.json 안 hooks.json 결정" 안 minimum schema)
5. README.md '## 설치' section 재작성 (cascade 표준 narrative)
6. AGENTS.md 영문 onboarding 동치
7. CLAUDE.md root 설치 section 동치
8. phase-1.md status: complete + execution_notes 갱신
9. git add + commit (conventional commits)

## 관련

- DESIGN.phases[0]: [`../DESIGN.md`](../DESIGN.md)
- plugin.json + marketplace.json 1차 source: DESIGN § "phase-1 ... 1차 source"
- cascade 표준 narrative: DESIGN § "cascade 표준 narrative"
