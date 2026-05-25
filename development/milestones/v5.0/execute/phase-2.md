# phase-2 — v5.0 plugin-pivot

```json
{
  "phase": 2,
  "title": "내부 narrative cascade — 10 host edit (claude/CLAUDE.md + bootstrap/* + projects/meta/ARCHITECTURE.md + tests/CLAUDE.md + Makefile + .env.example + claude/commands/harness-meta.md + GUARDRAILS.md + bootstrap/claude-code-catalog/README.md + bootstrap/agents/CLAUDE.md)",
  "status": "complete",
  "scope": "10 host edit — 각 host 안 install/symlink/junction/D7 sequence 관련 narrative 안 'deprecated since v5.0, v5.0+ 환경에서는 비활성' 표지 추가 + 'claude plugin install' 표준 narrative 정합. cascade 표준 narrative 정확 문구 정전화 (v3.21 3 단계 패턴 (b)).",
  "affected_files": [
    "projects/meta/milestones/v5.0/execute/phase-2.md",
    "claude/CLAUDE.md",
    "bootstrap/agents/CLAUDE.md",
    "bootstrap/skills/CLAUDE.md",
    "projects/meta/ARCHITECTURE.md",
    "tests/CLAUDE.md",
    "Makefile",
    ".env.example",
    "claude/commands/harness-meta.md",
    "GUARDRAILS.md",
    "bootstrap/claude-code-catalog/README.md"
  ],
  "commit_message": "feat(meta): v5.0 phase-2 — 내부 narrative cascade 10 host (claude/CLAUDE.md + bootstrap/agents/CLAUDE.md + bootstrap/skills/CLAUDE.md + projects/meta/ARCHITECTURE.md + tests/CLAUDE.md + Makefile + .env.example + claude/commands/harness-meta.md + GUARDRAILS.md + bootstrap/claude-code-catalog/README.md)",
  "execution_notes": [
    "projects/meta/ARCHITECTURE.md § 3.1 끝 'Install 정책 본질 + Claude Code Plugin spec 대안' paragraph (v4.3 도입) → 'Install 정책 = Claude Code Plugin spec 전면 채택' (v5.0 정전화) + 'Historical narrative — Install 정책 본질' (v4.3 source 보존) 두 paragraph 로 갱신",
    "bootstrap/agents/CLAUDE.md § Install/Update/Cleanup 책임 (v4.0 B3) → § Install/Update/Cleanup 책임 (v5.0 Plugin spec 채택, component-installer 책임 분리). D7 mechanical sequence → Plugin install 표준 명령 narrative + custom component lifecycle 보존 narrative",
    "claude/CLAUDE.md 배포 메커니즘 (v4.1 갱신) → 배포 메커니즘 (v5.0 Plugin spec 채택). hooks.json + statusline settings.json narrative + Plugin install lifecycle 채택 narrative",
    "bootstrap/skills/CLAUDE.md ~/.claude/skills/ symlink 평탄화 narrative → Plugin paths 인식 (bootstrap/skills/ add-to-default) narrative",
    "GUARDRAILS.md H5/C1/C2 narrative 갱신 — v5.0+ Plugin install lifecycle + .claude-plugin/plugin.json paths 인식 narrative",
    "Makefile install target stub message → v5.0+ claude plugin marketplace add + install 표준 명령 narrative",
    "claude/commands/harness-meta.md 신규 프로젝트 도입 narrative 갱신 — v5.0+ project-scope plugin install 옵션",
    "tests/CLAUDE.md 인프라 검증 카테고리 narrative 안 v5.0 Plugin install lifecycle 표지 추가",
    "bootstrap/claude-code-catalog/README.md 헤더 narrative 안 'v5.0 부터 본 repo 자체가 Plugin' 사실 진술 추가",
    ".env.example HARNESS_META_ROOT comment 안 component-installer 책임 분리 narrative 갱신",
    "v3.21 narrative 정전화 3 단계 패턴 (b) 적용 — DESIGN cascade 표준 narrative 정확 문구 EXECUTE Edit tool 안 그대로 삽입 (claude plugin install / plugin marketplace add / .claude-plugin/plugin.json 3 키워드 + deprecation 표지 narrative)"
  ]
}
```

## 진행 순서

1. projects/meta/ARCHITECTURE.md § 3.1 끝 'Install 정책 본질 + Plugin spec 대안' paragraph 흡수 (v4.3 도입 narrative 갱신 — Plugin 채택 정전화)
2. bootstrap/agents/CLAUDE.md § Install/Update/Cleanup 책임 / § Component-installer mechanical sequence (D7) deprecation 표지 + Plugin install 표준 narrative
3. claude/CLAUDE.md 글로벌 layer narrative (install 배포 narrative + 충돌 정책) cascade
4. bootstrap/skills/CLAUDE.md skill 배포 narrative cascade
5. claude/commands/harness-meta.md `/harness-meta` 안 D7 sequence 거명 갱신
6. GUARDRAILS.md install/deploy 가드레일 narrative cascade
7. bootstrap/claude-code-catalog/README.md catalog narrative
8. tests/CLAUDE.md smoke 매트릭스 안 install 거명 narrative
9. Makefile install target stub 갱신
10. .env.example HARNESS_META_ROOT narrative (단일 occurrence — 미세 edit)
11. phase-2.md status complete + execution_notes 갱신
12. git add + commit

## 관련

- DESIGN.phases[1]: [`../DESIGN.md`](../DESIGN.md)
- cascade 표준 narrative: DESIGN § "cascade 표준 narrative"
