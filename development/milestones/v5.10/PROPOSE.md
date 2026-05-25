---
id: v5.10_external-audit-team-second-call-with-diff
title: PROPOSE v5.10
version: v5.10
stage: PROPOSE
status: completed
---

# PROPOSE — v5.10 external-audit-team-second-call-with-diff

## Spec

```json
{
  "next_candidates": [
    {
      "id": "upbit-plugin-json-hooks-mcpservers-extension",
      "origin": "audit-2026-05-18 N4/A1 gap MEDIUM",
      "rationale": "upbit `.claude-plugin/plugin.json` 안 hooks + mcpServers 필드 미포함 (v1.17 G1 초안 대비 축소 적용). plugin install 단일 동작으로 hook/MCP 자동 활성화 = Plugin spec 정합. 외부 적용 milestone — upbit repo target.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ S2/S3 SPIKE 해소 후 통합 결정",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "upbit-settings-local-stale-cp-cleanup",
      "origin": "audit-2026-05-18 N5/A2 gap LOW (cascade drift)",
      "rationale": "upbit `.claude/settings.local.json` allow 목록 cp 명령 3건 구 경로 (`.claude/commands/` → `.claude-plugin/`). cascade drift 유형 (v5.7 spec-drift spike 패턴 정합). 외부 적용 milestone — upbit repo target.",
      "trigger_condition": "사용자 명시 발의 (A_user) — 정리 우선순위 낮음",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "upbit-session-init-hook-implementation",
      "origin": "audit-2026-05-18 A3 gap LOW (S1/S3 SPIKE 연동)",
      "rationale": "upbit docs/HARNESS.md 안 SessionStart hook 언급 vs `.claude/hooks/` 안 실 부재. UX 향상 옵션. 외부 적용 milestone.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ S1/S3 SPIKE 해소 후",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "upbit-claude-md-repo-root-creation",
      "origin": "audit-2026-05-18 A4 gap MEDIUM",
      "rationale": "upbit repo root 안 CLAUDE.md 자체 부재 (scanner: claude_md_in_repo: false). v1.17 G3 narrative 교체 = 단락 수정이지 파일 생성 아님. /init 명령 활용 가능. 외부 적용 milestone — upbit repo target.",
      "trigger_condition": "사용자 명시 발의 (A_user) — 프로젝트 컨텍스트 자동 로드 가치 평가",
      "decision": "거명만 (ROADMAP 등재 zero)",
      "_v5_11_correction": "후보 무효 (INVALIDATED) — HALLUCINATION cascade. 실 상태 = upbit/CLAUDE.md 거주 (9430 bytes, v1.17 phase-3 commit a856ddc 2026-05-14 cascade narrative 변경 시점부터 거주). origin scanner-output.md L77 `claude_md_in_repo: false` = hallucination 확정. rationale 안 'CLAUDE.md 자체 부재' + 'v1.17 G3 narrative 교체 = 단락 수정이지 파일 생성 아님' = 동일 hallucination cascade 흡수. 정정 source = [`../v5.11/RESEARCH.md`](../v5.11/RESEARCH.md) external.git_log + ARCHITECTURE.md § 4 끝 'Audit chain fact 인용 검증 의무' paragraph (v5.11 정전화). v5.11_audit-chain-fact-verification-discipline 안 본 entry 가 evidence cycle 2 origin (memory feedback_subagent_fact_hallucination_correction 누적 2 cycle direct evidence)."
    },
    {
      "id": "meta-review-bundled-skill-narrative-cleanup",
      "origin": "audit-2026-05-18 D3 minor drift (`/review` bundled skill 분류)",
      "rationale": "v1.17 mapper narrative 안 '/review built-in' 표현 → 정확히는 'bundled skill' (context7 code.claude.com/docs/en/skills §Bundled skills 명시). harness-meta narrative cleanup 본질. workflow self-improvement 약함 (외부 spec drift 정정).",
      "trigger_condition": "사용자 명시 발의 (A_user) — narrative 정확성 우선 시",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "external-audit-team-cycle-3-call",
      "origin": "본 v5.10 후속 evidence 누적 (v1.17 + v5.10 = 2 cycle, cycle 3 후보)",
      "rationale": "audit-team 외부 호출 cycle 누적 = ecosystem integrator 정체성 vector 운용 evidence 강화. cycle 3 trigger 조건 누적 후 발의 가능. 본 milestone 후속 자연.",
      "trigger_condition": "사용자 명시 발의 (A_user) — 외부 적용 vector 추가 누적 후",
      "decision": "거명만 (ROADMAP 등재 zero)"
    }
  ]
}
```

## Roadmap registration count

0

## Policy compliance

- **section_6_2_abolished**: v4.0 폐지 정합. workflow self-improvement narrative 거론 zero — 새 정체성 부합 약함 표현으로 대체.
- **ecosystem_integrator_alignment**: 본 PROPOSE next_candidates 6건 중 외부 vector 직접 trigger = #1~#4 (upbit 외부 적용) + #6 (cycle 3 audit) = 5건 / 간접 = #5 (meta narrative cleanup) 1건. ecosystem integrator 정체성 vector 자연 부합 강력.
- **roadmap_registration_zero_policy**: 거명만 (ROADMAP 등재 0건) = lightweight 모드 누적 10 cycle 정합. 본 v5.10 = 10 번째 cycle 누적 (v4.0~v5.10 누적 11 cycle: v4.0/v4.1/v4.2/v4.3/v5.0/v5.6/v5.7/v5.8/v5.9 + 본 v5.10).

## Roadmap status update pending

Stage I 종료 시점 projects/meta/ROADMAP.md 안 v5.10 entry status: in_progress → completed 갱신 + summary 본 REPORT 흡수 (Stage G+H+I 통합 chore commit 시점)

## narrative

본 PROPOSE 는 v5.10 milestone 의 후속 forward proposal. ROADMAP 등재 0건 (거명만) — lightweight 모드 10 번째 + § 6.2 폐지 후 가드레일 정신 정합 + ecosystem integrator 정체성 vector 자연 부합 강력 (6 candidates 중 5건 외부 vector trigger).

### next_candidates 6건 거명

1. `upbit-plugin-json-hooks-mcpservers-extension` (N4) — upbit Plugin spec 확장
2. `upbit-settings-local-stale-cp-cleanup` (N5) — upbit cascade drift 정리
3. `upbit-session-init-hook-implementation` (A3) — upbit SessionStart hook 추가
4. `upbit-claude-md-repo-root-creation` (A4) — upbit CLAUDE.md 신규 생성
5. `meta-review-bundled-skill-narrative-cleanup` (D3) — meta narrative 정확화
6. `external-audit-team-cycle-3-call` (본 후속) — audit cycle 3 누적

### ROADMAP 등재 0건 정책 정합

v4.0~v5.10 lightweight 모드 누적 11 cycle 정합. 본 v5.10 = 10 번째 v5.x lightweight cycle 누적 (v4.x 1 + v5.x 6 + v5.10). 사용자 명시 trigger 만 발의 default.

### Stage I 종료 시점 ROADMAP 갱신

`projects/meta/ROADMAP.md` 안 v5.10 entry status: in_progress → completed + summary 본 REPORT 흡수.
