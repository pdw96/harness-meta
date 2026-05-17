# INTENT — v5.11 audit-chain-fact-verification-discipline

```json
{
  "id": "v5.11_audit-chain-fact-verification-discipline",
  "title": "audit chain 4 멤버 fact 인용 검증 의무 narrative 정전화 + v5.10/v1.17 audit 산출물 hallucination 정정 (memory feedback_subagent_fact_hallucination_correction 누적 2 cycle direct evidence)",
  "goal": "v5.10 audit-2026-05-18 chain 안 scanner-output.md `claude_md_in_repo: false` hallucination + cascade 흡수 4 산출물 fact 정정 + audit chain (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer) 외부 1차 source fact 인용 시 synthesizer 의 직접 매핑 검증 의무 narrative 1건 정전화 (v3.21 3 단계 패턴 13번째 cycle 도그푸드, lightweight 모드).",
  "motivation": "v5.10 PROPOSE.next_candidates#4 (`upbit-claude-md-repo-root-creation`) 사용자 명시 선택 후 Stage A OPEN 단계 결정적 이슈 round 안 upbit/CLAUDE.md 실존 발견 (v1.17 phase-3 commit a856ddc, 2026-05-14 cascade narrative 변경 시점부터 존재, 9430 bytes). v5.10 audit-2026-05-18 chain scanner-output.md 안 `claude_md_in_repo: false` 명시 + analyzer-output.md A4 gap MEDIUM + mapper-output.md G3 narrative + proposal-draft.md A4 gap → ROADMAP v5.10 entry summary 'A4 gap MEDIUM' fact 인용 = 모두 hallucination 기반. memory `feedback_subagent_fact_hallucination_correction` (v5.10 L1 component-proposer 12 항목 hallucination origin) 이 직접 evidence 누적 2 cycle (proposer + scanner) 신규 도달. synthesizer (메인 Claude) 가 PROPOSE 작성 시점 검증 누락 = 본 evidence cycle 의 실 원인. narrative 정전화 부재 시 동일 hallucination 흡수 패턴 재현 risk 누적.",
  "success_criteria": [
    "sc_1: projects/upbit/audit-2026-05-18/scanner-output.md 안 `claude_md_in_repo: false` fact 정정 (실 상태 `true` + 정정 narrative cross-ref v1.17 phase-3 commit a856ddc + bytes 9430)",
    "sc_2: projects/upbit/audit-2026-05-18/{analyzer-output,mapper-output,proposal-draft}.md 안 A4 (CLAUDE.md 부재) cascade fact 모두 정정 (3 산출물 1:1 매핑)",
    "sc_3: projects/meta/ROADMAP.md v5.10 entry summary 안 'audit-2026-05-18 A4 gap MEDIUM' fact 인용 정정 (stale 표지 + 정정 narrative) — Stage D 정확 위치 결정",
    "sc_4: audit chain 4 멤버 fact 인용 검증 의무 narrative 1건 정전화 (host = projects/meta/ARCHITECTURE.md 또는 bootstrap/agents/CLAUDE.md, Stage D D1 결정). 정전화 paragraph LOC ~10-20 line, v3.21 narrative 정전화 3 단계 패턴 (DESIGN 정확 문구 1차 source + EXECUTE Edit 그대로 삽입 + VERIFY grep 검증) 정합",
    "sc_5: v1.17_upbit-harness-plugin-pivot-and-audit-componentry audit 산출물 (upbit repo milestones/v1.17/ 안 또는 harness-meta 안 cascade) 동일 hallucination 검증 — 발견 시 본 milestone scope 안 흡수 + 정정 / 부재 시 사실 진술 (RESEARCH 단계 grep + Stage D 결정)",
    "sc_6: lightweight 모드 (5 관점 subagent 생략 + 자기참조 회피 표지 + LOC cap ~1500) — 누적 11/28 = 39.3% 갱신 (v5.10 까지 10/27 → 본 v5.11 = 11/28)",
    "sc_7: v3.21 narrative 정전화 3 단계 패턴 13 번째 cycle 도그푸드 완성 (v3.18 / v3.20 / v3.21 / v4.1 / v4.2 / v4.3 / v5.0 / v5.7 / v5.8 / v5.9 / v5.10 + 본 v5.11 = 12 누적 후 13 번째)",
    "sc_8: pre-commit 14 hook 모두 PASS + 회귀 0 + INTENT~APPROVE commit 시점 (b) default (Stage G 통합 chore commit 안 4 산출물 + milestones.md 포함)"
  ],
  "out_of_scope": [
    "본 milestone 은 audit chain 5 멤버 (project-scanner / harness-gap-analyzer / claude-docs-mapper / component-proposer / component-installer) agent 정의 자체 변경이 아니다 — fact 검증 의무 narrative 정전화 + 산출물 fact 정정 단일 source 한정 (사실 진술).",
    "본 milestone 은 upbit-claude-md-repo-root-creation 후속 발의가 아니다 — 대상 파일 (upbit/CLAUDE.md) 이미 존재로 무효 판명 (사실 진술).",
    "본 milestone 은 upbit/CLAUDE.md 자체 변경이 아니다 — 이미 v1.17 phase-3 commit a856ddc 안 cascade narrative 변경 완료, 보존 (사실 진술).",
    "본 milestone 은 audit chain agent 재실행이 아니다 — v5.10 audit-2026-05-18/ 4 산출물 cascade fact 정정 + narrative 정전화만, evidence 추가 수집 부재 (사실 진술).",
    "본 milestone 은 v5.10 PROPOSE.next_candidates 6건 안 다른 후보 (#1 upbit-plugin-json-hooks-mcpservers-extension / #2 upbit-settings-local-stale-cp-cleanup / #3 upbit-session-init-hook-implementation / #5 meta-review-bundled-skill-narrative-cleanup / #6 external-audit-team-cycle-3-call) 발의가 아니다 — 본 scope 외 (사실 진술)."
  ],
  "dependencies": {
    "predecessor": [
      "v5.10_external-audit-team-second-call-with-diff (audit-2026-05-18 산출물 거주 + PROPOSE.next_candidates#4 origin + L1 component-proposer hallucination cycle 1 evidence)",
      "v3.21_narrative-canonicalization-3step-pattern (3 단계 패턴 정의 — DESIGN 정확 문구 + EXECUTE Edit 정확 삽입 + VERIFY grep 검증)",
      "v1.17_upbit-harness-plugin-pivot-and-audit-componentry (upbit/CLAUDE.md 거주 시점 commit a856ddc / sc_5 v1.17 audit 산출물 검증 source)",
      "memory feedback_subagent_fact_hallucination_correction (v5.10 L1 origin, 본 v5.11 evidence cycle 2)"
    ],
    "successor_named_only": []
  }
}
```

## narrative

본 INTENT 는 v5.10 PROPOSE.next_candidates#4 사용자 선택 후 Stage A OPEN 단계 결정적 이슈 round 에서 발견된 audit chain hallucination 정정 + narrative 정전화 milestone 의 의도 단일 source.

### 핵심 motivation 요약

- v5.10 audit-2026-05-18 chain (scanner → analyzer → mapper → proposer) 4 산출물 안 scanner_output 1 차 hallucination → 3 산출물 cascade 흡수 → ROADMAP entry summary 5 차 인용 = **단일 hallucination 의 5 위치 fact 인용 누적**.
- synthesizer (메인 Claude) 가 PROPOSE 작성 시점 직접 매핑 검증 누락 = 본 evidence cycle 의 실 원인 (v5.10 L1 origin 의 누락 evidence 직접 재현).
- memory `feedback_subagent_fact_hallucination_correction` 이 v5.10 L1 시점 작성됐음에도 v5.10 PROPOSE 작성 시점 검증 운용 부재 → 누적 2 cycle direct evidence 도달 (proposer + scanner) → narrative 정전화 trigger 강력 (evidence-base trigger).

### success_criteria 정밀 정합

각 sc_n 는 VERIFY.criteria_check 안 1:1 매핑되어 검증 — sc_1~sc_5 = 산출물 fact 정정 (sc_5 = v1.17 검증 포함) + sc_4 = narrative 정전화 (v3.21 3 단계 패턴 13 번째 cycle) + sc_6~sc_7 = lightweight 모드 + 도그푸드 누적 / sc_8 = pre-commit 회귀 검증.

### out_of_scope 부산물 정책 정합 (v3.10)

본 INTENT.out_of_scope 5건 모두 (a) 사실 진술만 — '본 milestone 이 무엇이 **아닌가**'. 후속 milestone 발의 명령형 표현 부재 (forward propose 책임 = Stage I PROPOSE 통합 흡수). v3.10_stage-byproduct-clarification narrative 정합.

### dependencies 단방향성

predecessor 4건 (v5.10 / v3.21 / v1.17 / memory feedback) 본 milestone scope 안 직접 참조 — `successor_named_only` 빈 배열 (lightweight default 동결 정합 + § 6.2 폐지 narrative 정합).
