---
phase: phase-1
milestone: v9.0
status: completed
---

# v9.0 phase-1 — ARCHITECTURE § 3.1 + § 3.5 정전화

## Spec

```json
{
  "phase": "phase-1",
  "status": "completed",
  "scope": "development/ARCHITECTURE.md § 3.1 정체성 paragraph 확장 + § 3.5 Adapter taxonomy 표 갱신. 본 phase = v9.0 의 '정전화만' 본질 (INTENT goal 직접 정합) 의 source narrative 박기 — phase-2 cascade 10 host edit 의 '정합 확인' source.",
  "changes": [
    {
      "type": "edit",
      "path": "development/ARCHITECTURE.md",
      "description": "§ 3.1 line 69 정체성 첫 줄 단수 → 복수 표현 cascade — 'Claude Code adapter maintainer' → 'reference adapter maintainer (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)' (d_3 + d_6 한국어 host 정합). paragraph 헤더 timestamp 갱신 = '(v4.0_harness-composer-pivot, 2026-05-13; v8.x adapter-neutral remodel; v9.0_multi-llm-adapter-tiers, 2026-05-28)'."
    },
    {
      "type": "edit",
      "path": "development/ARCHITECTURE.md",
      "description": "§ 3.1 line 98 paragraph 끝 다음에 v9.0 paragraph 추가 = 'Multi-LLM 어댑터 tier 정전화' — (1) 핵심 원칙 한 줄 정전 (d_4 한국어 + 영어 derived) + (2) 4 tier 분류 표 (Core methodology / Reference adapter / Portable adapters / Optional integration) (d_1) + (3) 격상 본질 narrative (d_8 — line 71 existing 분리 원칙 격상, major bump v9.0 정당성 = 정체성 첫 줄 breaking change + 10 host 정합). § 3.2 시작 line 100 앞 자연 삽입."
    },
    {
      "type": "edit",
      "path": "development/ARCHITECTURE.md",
      "description": "§ 3.5 Adapter taxonomy 표 (line 122-128 → 갱신) — Tier column 추가 (Reference adapter / Portable adapter / Optional integration 3 tier 매핑) + MCP row 신규 추가 (Surface = MCP server wrapping portable CLI / Status = Optional / Tier = Optional integration / Boundary = portable CLI 안정화 후 진행, CLI-first 후 2차). 표 다음 narrative 추가 = Tier column 매핑 정합 narrative (Core methodology = § 3.5 외 본질, Reference/Portable/Optional integration 3 tier 가 § 3.5 안 거주). d_9 정합."
    }
  ],
  "verification": [
    {
      "method": "smoke",
      "result": "PASS",
      "detail": "smoke-spec-verification (PASS=538/0 회귀 부재 — execute/phase-1.md 신규 1 PASS 추가 + status 필드 보정 후 정합) + smoke-cross-ref (broken ref 0) — phase-1 ARCHITECTURE edit 후 검증 통과 (commit 전 사전 확인 자연)."
    },
    {
      "method": "manual",
      "result": "PASS",
      "detail": "본 paragraph 안 v9.0 narrative 정확 — line 71 existing 분리 원칙 격상 본질 명시 + § 3.5 표 cross-ref + v9.0 milestone cross-ref ([`milestones/v9.0/MILESTONE.md`](../v9.0/MILESTONE.md)) 자연. 격상 본질 narrative trace 정합."
    },
    {
      "method": "pre-commit",
      "result": "pending",
      "detail": "pre-commit 자동 검증 = commit 시점 진행 예정. 사용자 명시 commit 결정 후 자동 실행 — 본 phase-1 작성 시점 실 실행 부재로 사전 PASS 보장 부재. commit 진행 시 모든 active hook 통과 시 commit 자연."
    }
  ],
  "commit": {
    "sha": "pending",
    "message": "feat(meta): [v9.0 EXECUTE phase-1] ARCHITECTURE § 3.1 정체성 첫 줄 multi-LLM tier 격상 + § 3.5 표 갱신"
  }
}
```

## Narrative

본 phase-1 = v9.0 의 source narrative 박기 = ARCHITECTURE § 3.1 정체성 paragraph 확장 + § 3.5 Adapter taxonomy 표 갱신. 3 change (정체성 첫 줄 변경 / v9.0 paragraph 추가 / § 3.5 표 갱신) 안 d_1 (tier schema) + d_3 (정체성 표현) + d_4 (codex 정확 표현) + d_8 (격상 본질) + d_9 (§ 3.5 표 갱신) 5 decisions 모두 흡수.

격상 본질 narrative (d_8) 정합 = line 71 existing 'Core / Adapter 분리 원칙' (v4.0 도입) 이 이미 분리 본질 거주하나 정체성 첫 줄 narrative 안 '단수 Claude Code adapter maintainer' 종속 표현으로 정합 부재 — v9.0 = 본 분리 원칙을 첫 줄 narrative + tier schema 로 격상 (신규 도입 아님). major bump v9.0 정당성 = 정체성 첫 줄 breaking change (단수 → 복수 표현 cascade).

검증 = smoke 2건 사전 PASS (spec-verification 538/0 — execute/phase-1.md 신규 1 PASS 추가 + status 필드 보정 후 정합 + cross-ref broken 0) — commit 전 사용자 확인 게이트 정합. pre-commit 자동 검증은 commit 시점 진행 예정 (사전 PASS 보장 부재). 본 phase-1 commit 후 SHA 갱신 = Spec.commit.sha + MILESTONE.md ## EXECUTE phases_executed[].commits[].sha 2 위치 동시 갱신 본질 (frontmatter 안 commit SHA 필드 부재 — schema 정합).

다음 phase-2 = cascade 10 host edit + 검증 (primary 7 host 안 단수 → 복수 표현 cascade + 별 표현 3 host 안 v4.0 ecosystem-integrator 패턴 보존/보정). 본 phase-1 source narrative 박힘 후 phase-2 cascade '정합 확인' 가능 자연.
