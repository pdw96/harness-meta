# INTENT — v3.6 overengineering-audit

```json
{
  "id": "v3.6_overengineering-audit",
  "title": "Overengineering audit — workflow 자기참조 사이클 진단 + lightweight remediation",
  "goal": "외부 best practice (Martin Fowler / OpenAI / Anthropic / Pi) + 내부 정량 (workflow self-improvement 9/24 milestone, narrative ÷ 코드 변경 5~9x, pending 4/6 워크플로우 강화, 18일간 workflow 3회 major bump) 진단 결과 확인된 자기참조 사이클을 탈출하고, 권고 7건 중 즉시 적용 가능한 lightweight remediation 을 실행한다.",
  "motivation": "본 repo 는 'meta repo 자체의 하네스 정의·진화' 책임을 가지고 시작했으나, 18일간 24개 milestone 중 9건이 workflow self-improvement, pending 6건 중 4건이 workflow narrative 강화로 메타-메타 사이클에 진입. 외부 권위 (Martin Fowler 'lightweight harness', OpenAI Bitter Lesson 'do not build massive control flows', Anthropic Skills 'progressive disclosure') 와 정면 충돌. 외부 프로젝트 (upbit) 실 적용 0건 상태로 메타 자체가 자산화 — 모델·요구 변경 시 deprecate 위험. 자기참조 사이클 탈출이 본 milestone 의 핵심.",
  "success_criteria": [
    "권고 #1 적용: workflow 자기개선 milestone (v3.6 milestones-md-validation-extension / v3.7 workflow-narrative-strengthening-v2 pending entry) defer 처리 완료, ROADMAP audit trail 보존 (git history)",
    "권고 #4 적용: smoke inactive 22 처분 결정 — (a) active 통합 / (b) archive 이동 / (c) 삭제 중 사용자 명시 선택 + 실행",
    "권고 #6 적용: milestone narrative 산출물 cap 정책 명문화 — `claude/commands/harness-meta.md` 또는 ARCHITECTURE.md 에 'lightweight 모드' 표지 정책 + 산출물 LOC cap 가이드 narrative 추가",
    "권고 #7 적용: 외부 프로젝트 (upbit) 실 적용 milestone 1건 발의 — `projects/upbit/ROADMAP.md` 에 pending entry 추가 (PROPOSE 단계)",
    "본 milestone 자체가 lightweight 모드 자기참조 회피 표지 정합 — 산출물 총 LOC < 800줄 (v3.5 897줄 대비 -10% 이상)",
    "권고 #2 (9-stage trim) + #3 (5 관점 trim) + #5 (4 era forward migration) 는 본 milestone scope 외 — PROPOSE 에서 후속 milestone 후보 등재 (즉시 적용 시 breaking change → 본 milestone lightweight 정신 위배)",
    "회귀 0 — pre-commit 7 hook 모두 PASS"
  ],
  "out_of_scope": [
    "9-stage workflow trim (권고 #2) — breaking change + 단어 의미 부합 재검토 필요, 별 milestone 분리",
    "5 관점 검토 trim 정책 명문화 (권고 #3) — claude/commands/harness-meta.md Stage D 절차 변경 = workflow 자체 변경, 별 milestone 분리 (자기참조 사이클 재진입 위험)",
    "4 era forward migration (권고 #5) — historical 16 milestone git mv + smoke 분기 통합 = 별 milestone (breaking change, major bump 후보)",
    "subagent 5 관점 병렬 검토 — 본 milestone lightweight 모드 표지로 생략",
    "milestone narrative 의 retroactive cap 적용 (기존 24 milestone 산출물 trim) — 본 milestone scope 외, 가치 부재"
  ],
  "dependencies": {
    "prior": [
      "v3.5_open-stage-discipline-strengthening (직접 부모 — 자기참조 사이클의 가장 최근 사례)",
      "v2.0_workflow-word-fidelity (자기참조 회피 표지 선례)"
    ],
    "blocks": [],
    "external_evidence": [
      "Martin Fowler — Harness engineering for coding agent users (lightweight 권고)",
      "OpenAI — Harness engineering: leveraging Codex (Bitter Lesson — do not build massive control flows)",
      "Anthropic — Claude Code Agent Skills (progressive disclosure)",
      "Pi (canonical slim harness — minimalist counterpoint)"
    ]
  }
}
```

## 비고

본 INTENT.md 자체가 lightweight 모드 cap 적용 — 79줄. 일반 INTENT.md (v3.5 79줄 / v3.4 35줄) 와 동등 또는 더 간결.
