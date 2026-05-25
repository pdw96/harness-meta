# phase-3 — cascade narrative cleanup (claude/CLAUDE.md + tests/CLAUDE.md + bootstrap/agents/CLAUDE.md + ARCHITECTURE.md + CHANGELOG)

```json
{
  "phase": 3,
  "title": "cascade narrative cleanup — claude/CLAUDE.md + tests/CLAUDE.md + bootstrap/agents/CLAUDE.md + ARCHITECTURE.md + CHANGELOG",
  "status": "in_progress",
  "affected_files": [
    "claude/CLAUDE.md (L63 verify.{ps1,sh} 갱신 line 폐기)",
    "tests/CLAUDE.md (L31~32 inactive 표 row 2건 제거)",
    "bootstrap/agents/CLAUDE.md (매트릭스 row 2 추가 + 트리 standalone narrative + § Audit/Sync 책임 신규 sub-section)",
    "projects/meta/ARCHITECTURE.md (§ 3.1 끝 정체성 paragraph 직후 'mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리' paragraph 1건 정전화)",
    "CHANGELOG.md ([v4.2] entry 추가 — Unreleased 직후, v4.0 entry 직전)",
    "projects/meta/milestones/v4.2/execute/phase-3.md (실행 노트)"
  ],
  "execution_notes": "DESIGN.phases[3] 정합. v3.21 narrative 정전화 3 단계 패턴 (DESIGN 정확 문구 1차 source + EXECUTE Edit 그대로 삽입 + VERIFY grep) 적용 6 cycle 누적 (v3.18 + v3.20 + v3.21 + v4.1 + v4.2). DESIGN.narrative_canonicalization_3step.design_canonical_text 정확 문구 그대로 ARCHITECTURE.md § 3.1 끝 (line 67 정체성 paragraph 직후) Edit 삽입. cross-ref 추가 zero (단일 source, v3.20 패턴 정합). 5 host edit 모두 atomic Edit (replace_all=false 정확 anchor). bootstrap/agents/CLAUDE.md 3 edit (매트릭스 + 트리 + § Audit/Sync 책임 sub-section 신규) 모두 동일 파일 — D11 정합. CHANGELOG [v4.2] entry Added/Removed 분리 (Keep a Changelog v1.1.0 정합).",
  "commit_message": "feat(meta): v4.2 phase-3 — cascade narrative cleanup 5 host (verify/sync 흡수 후속)"
}
```

## 작업 결과

- `claude/CLAUDE.md` L63 line 폐기 (Hook 추가 시 5번째 step `verify.{ps1,sh}` 갱신)
- `tests/CLAUDE.md` L31~32 row 2 제거 (smoke-sync-agents + smoke-verify-sh-parity)
- `bootstrap/agents/CLAUDE.md` — 매트릭스 표 audit/ row 2 추가 + 헤더 'Team / Standalone Subagent' 변경 + 트리 narrative 안 standalone 1줄 + 신규 sub-section § 'Audit/Sync 책임' (~33 line)
- `projects/meta/ARCHITECTURE.md` § 3.1 끝 신규 paragraph 1건 (~5 line)
- `CHANGELOG.md` [v4.2] entry 추가 (~20 line)

## 검증 (VERIFY 단계 이전 self-check)

- v3.21 3 단계 패턴 (a) DESIGN 정확 문구 → ARCHITECTURE.md 안 Edit 시 정확 문구 그대로 삽입 확인 (b) phase-3 EXECUTE Edit 완료
- VERIFY grep 키워드 (Stage G) — `mechanical 본질 vs Claude Code spec 의무 컴포넌트 분리`, `v4.2_verify-infra-agent-absorption 도입`, `spec 의무 컴포넌트는 agent 흡수 불가능` 3건 ARCHITECTURE.md 안 grep 검증 의무

## 관련

- DESIGN.phases[3]: [`../DESIGN.md`](../DESIGN.md)
- phase-1 (agent fleet 신규): [`phase-1.md`](phase-1.md)
- phase-2 (mechanical 폐기): [`phase-2.md`](phase-2.md)
