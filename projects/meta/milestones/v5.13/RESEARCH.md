# RESEARCH — v5.13 audit-chain-fact-verification-protocol-procedure

```json
{
  "id": "v5.13_audit-chain-fact-verification-protocol-procedure",
  "external": [
    {
      "source": "projects/meta/ARCHITECTURE.md § 4 끝",
      "topic": "Audit chain fact 인용 검증 의무 paragraph (v5.11 정전화)",
      "findings": "검증 의무 (a)(b) 명시 — (a) audit chain 산출물 안 fact 인용 (boolean/표/수치) 발견 시 synthesizer 가 직접 source 매핑 검증, (b) hallucination 발견 시 산출물 archive 보존 + 정정 narrative inline + cascade 흡수 위치 동기 정정. 본 paragraph 가 '무엇을 해야 하는가' 단일 source.",
      "drift": "workflow 절차 문서 (harness-meta.md command / audit-team CLAUDE.md) 안 대응 step 부재 — '어디서 어떻게 하는가' 절차 gap"
    }
  ],
  "codebase": {
    "current_state": {
      "harness_meta_md_audit_branch": "claude/commands/harness-meta.md --audit 분기 (L74~L85) = scanner → analyzer → mapper → proposer → proposal-draft.md → 사용자 결정 게이트 → installer. fact 검증 step 부재.",
      "audit_team_claude_md_d8": "agents/project-harness-audit-team/CLAUDE.md Orchestration sequence (D8) = Step 1~5 sequential + 병렬 가능성 note. synthesizer 검증 의무 step 부재.",
      "architecture_paragraph": "ARCHITECTURE.md § 4 끝 L137 = 검증 의무 (a)(b) 명시 + 진단 1차 source cross-ref (v5.11/v5.10 milestones + audit-2026-05-18). 이미 정전화 완료."
    },
    "affected_files": [
      "claude/commands/harness-meta.md",
      "agents/project-harness-audit-team/CLAUDE.md",
      "projects/meta/ARCHITECTURE.md (cross-ref 갱신 option)"
    ],
    "untouched_files": [
      "agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer,component-installer}.md (agent 내부 구현 불변)",
      "tests/ (smoke 신규 추가 out_of_scope)"
    ],
    "target_state": "claude/commands/harness-meta.md --audit 분기 안 'fact 검증 step' 명시 추가 + agents/project-harness-audit-team/CLAUDE.md D8 sequence 안 또는 별도 Note 안 synthesizer 검증 책임 명시"
  },
  "options": [
    {
      "id": "O1",
      "label": "harness-meta.md --audit 분기 안 step 추가 단독",
      "scope": "claude/commands/harness-meta.md 1 파일",
      "pros": ["가장 minimal scope", "audit 사용 시점에 자연 노출 (workflow-embedded)"],
      "cons": ["audit-team CLAUDE.md 독자 (D8 독립 참조자) 에게 검증 의무 미노출"]
    },
    {
      "id": "O2",
      "label": "audit-team CLAUDE.md D8 sequence 안 Note 추가 단독",
      "scope": "agents/project-harness-audit-team/CLAUDE.md 1 파일",
      "pros": ["D8 orchestration 문서와 검증 책임 근접 배치", "audit-team 독립 참조자 coverage"],
      "cons": ["harness-meta.md --audit 분기 안 검증 절차 step 부재 유지 — 실 workflow 실행 경로와 거리"]
    },
    {
      "id": "O3",
      "label": "양쪽 모두: harness-meta.md step 추가 + audit-team CLAUDE.md Note 추가 (cross-ref)",
      "scope": "claude/commands/harness-meta.md + agents/project-harness-audit-team/CLAUDE.md 2 파일",
      "pros": ["두 독자 경로 모두 coverage", "ARCHITECTURE § 4 끝 paragraph 와 3-layer 보완 (정의 → orchestration → workflow step)"],
      "cons": ["scope 약간 확대 (2 파일)", "cross-ref 관리 필요"]
    }
  ],
  "risks_identified": [
    {
      "risk": "harness-meta.md --audit 분기 코드블록 길이 증가",
      "severity": "low",
      "note": "현재 L74~L85 = 12 라인. step 추가 시 ~3~5 라인 증가 — 가독성 유지 가능"
    },
    {
      "risk": "두 파일 동기 drift (O3 선택 시)",
      "severity": "low",
      "note": "cross-ref 명시 + v3.21 3 단계 패턴 (DESIGN.D2 → EXECUTE Edit → VERIFY grep) 적용 시 관리 가능"
    }
  ]
}
```

## narrative

현재 'Audit chain fact 인용 검증 의무' 는 ARCHITECTURE.md § 4 끝에 정전화되어 있으나 (v5.11), 실 workflow 실행 경로 (harness-meta.md --audit 분기) 와 orchestration 문서 (audit-team CLAUDE.md D8) 안에는 대응 step 이 부재하다. 3 option 분석 결과 — O3 (양쪽 추가 cross-ref) 가 coverage 측면 최우수이나 scope 2 파일. O1 단독도 유효 — 실 실행 경로 embedded 효과.

결정은 Stage D DESIGN 에서.
