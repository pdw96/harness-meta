# DESIGN — v3.11 legacy-narrative-cleanup

```json
{
  "id": "v3.11_legacy-narrative-cleanup",
  "decisions": [
    {
      "decision": "Option A 채택 — 3위치 일괄 1 phase 1 commit",
      "rationale": "Lightweight 모드 LOC cap 정합 + narrative 정리 단순 작업 = 1 phase 적합. v3.10 1 phase 선례 일관. 회귀 risk 0 (narrative 변경, 패턴/코드 변경 부재). 3 파일 atomic 보장.",
      "alternatives_rejected": ["B (3 phase 분리, 과잉)", "C (scope 확장, 사용자 historical 보존 결정 위배)"]
    },
    {
      "decision": "claude/CLAUDE.md L39 narrative 갱신 — 현행 패턴 = v3.0+ 9-stage-bundled era 명시 + 정리 예정 narrative 제거",
      "rationale": "RESEARCH current_state vs target_state 명시. post-report-write.sh 실 코드는 이미 9-stage 갱신 (L2), narrative 만 4-tier era 잔존 표현. 정리 예정 narrative 제거로 stale completion.",
      "alternatives_rejected": ["narrative 유지 (drift 영속)", "patterns 코드 변경 (out of scope, 코드 이미 fix)"]
    },
    {
      "decision": "projects/upbit/ARCHITECTURE.md L106 stale path 갱신 — 'harness-meta/sessions/upbit/' → 'harness-meta repo: projects/meta/milestones/v{X.Y}/ 또는 v{X.Y}_{slug}/'",
      "rationale": "현행 구조 정합. L100~105 upbit 고유 slash command 안내 / L133 historical 이력 은 본 scope 외 (사용자 historical 보존 결정).",
      "alternatives_rejected": ["L100~105 동시 정리 (scope 침범)", "L133 historical 갱신 (forward-only 보존 위배)"]
    },
    {
      "decision": "CHANGELOG.md L3 era 카테고리 추가 — v3.0+ 9-stage-bundled era 명시 + 기존 'v2.0+ 9-stage / v1.0~v1.4 7-stage' 정합 유지",
      "rationale": "v3.0+ era 도입 후 CHANGELOG 안 detailed change records 경로 narrative 가 v2.0+ / v1.0~v1.4 두 era 만 거명 → 누락 보완. v3.0+ era 추가 거명 단순 narrative 갱신.",
      "alternatives_rejected": ["L3 narrative 재작성 (간섭 과대)", "CHANGELOG 안 다른 위치 갱신 (sessions/ 거명 부재, 본 scope 외)"]
    },
    {
      "decision": "Lightweight 모드 적용 — 5 관점 subagent 병렬 검토 생략",
      "rationale": "§ 6.2 trigger 3건 모두 충족. self_reference_policy: 'avoid' (milestones.md 이미 명시). 자기참조 도그푸드 회피 — 본 milestone 본질은 4-tier 잔존 narrative 정리, workflow self-improvement 부재.",
      "alternatives_rejected": ["일반 모드 (3 관점 architecture/spec-drift/scope contract)"]
    }
  ],
  "approach": "단일 phase 1 commit 으로 3 파일 narrative 갱신. Edit tool 3회 호출 (claude/CLAUDE.md L39 + projects/upbit/ARCHITECTURE.md L106 + CHANGELOG.md L3). pre-commit 14 hook 자동 실행 → 모두 PASS 후 commit. Stage G VERIFY 단계에서 narrative drift 수동 grep 검증.",
  "phases": [
    {
      "n": 1,
      "title": "3위치 stale narrative 일괄 갱신 (claude/CLAUDE.md L39 + upbit/ARCHITECTURE.md L106 + CHANGELOG.md L3)",
      "scope": "narrative 갱신 only (패턴/코드 변경 부재). 3 파일 1 commit atomic.",
      "affected_files": [
        "claude/CLAUDE.md",
        "projects/upbit/ARCHITECTURE.md",
        "CHANGELOG.md",
        "projects/meta/milestones/v3.11/execute/phase-1.md"
      ],
      "rationale": "RESEARCH target_state 직접 구현. 1 phase 1 commit (conventional `feat(meta): v3.11 phase-1 — stale 3위치 narrative 일괄 갱신`).",
      "risks": [
        "markdownlint rule (line length / list 들여쓰기) 위반 risk → pre-commit hook 자동 검증",
        "narrative drift (post-report-write.sh 실 패턴 vs claude/CLAUDE.md narrative) → Stage G VERIFY 수동 grep"
      ]
    }
  ],
  "risk_mitigation": [
    {"risk": "narrative 갱신 후 drift 잔존", "mitigation": "Stage G VERIFY 단계 grep 'sessions/' (excluding historical preserve / milestone artifact / upbit slash command L100~105) → 0 hit 검증"},
    {"risk": "pre-commit hook 회귀", "mitigation": "phase-1 commit 후 pre-commit 14 hook 자동 실행, FAIL 시 narrative 재조정"},
    {"risk": "ROADMAP entry v1.5 제거 + v3.11 추가 commit 시점 혼란", "mitigation": "Stage G VERIFY commit 안 INTENT/RESEARCH/DESIGN/APPROVE/milestones.md 4종 + execute/phase-1.md 포함 (b 패턴 권장, v3.1 L6)"}
  ]
}
```

## Stage D 완료 직전 의무 step (v3.5)

`phases[]` 1건 확정 → `milestones/v3.11/milestones.md` `sub_milestones[]` 1:1 동기 갱신 (placeholder title 교체). 다음 step 으로 진행.
