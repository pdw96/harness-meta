# PROPOSE — v3.15 changelog-v3-backfill

```json
{
  "next_candidates": [
    {
      "id_candidate": "v3.16_unreleased-section-position-cleanup",
      "title_candidate": "CHANGELOG.md [Unreleased] 섹션 Keep a Changelog 권장 위치 (최상단) 정합화",
      "origin": "L2 (DESIGN D2 / REPORT L2) — 본 milestone scope 외 narrative drift 보존, [Unreleased] L37 (현 L195, v2.0 아래) 가 Keep a Changelog 권장 (최상단) 위반",
      "scope_estimate": "CHANGELOG.md 단일 파일. [Unreleased] 섹션 5 항목 (CI / pre-commit / GUARDRAILS / .env.example / CHANGELOG.md 자체) 의 v1.x~v2.0 사이 인프라 → v1.x / v2.x entry 안 흡수 동시 결정 가능 (sub-decision)",
      "trigger": "C_improvement",
      "trigger_type": "narrative cleanup (외부 visible artifact 권장 정합화)",
      "freeze_consideration": "§ 6.2 workflow self-improvement 동결 정책 영향 부재 — CHANGELOG.md 단일 파일, workflow / smoke / hook 미영향. lightweight 모드 적합 (narrative cleanup 본질).",
      "registration_recommendation": "사용자 결정 — ROADMAP `pending` 등재 vs 거명만 동결. v3.12 선례 (narrative cleanup 자연 후속 등재) 패턴 적합 / v3.11~v3.14 default 동결 패턴 양 옵션 가능."
    },
    {
      "id_candidate": "v3.X_changelog-backfill-pattern-formalization",
      "title_candidate": "CHANGELOG.md backfill 패턴 정전화 narrative — claude/commands/harness-meta.md 또는 ARCHITECTURE.md",
      "origin": "L6 (REPORT — backfill 패턴 첫 적용, milestone 1:1 매핑 원칙 + Keep a Changelog 권장 정합)",
      "scope_estimate": "workflow narrative (claude/commands/harness-meta.md Stage H REPORT 또는 ARCHITECTURE.md § 6.X) 추가",
      "trigger": "D_design",
      "trigger_type": "workflow narrative 강화",
      "freeze_consideration": "§ 6.2 workflow self-improvement 동결 정책 직접 적용 대상 — workflow 자체 narrative 변경. 외부 projects/<name> (name ≠ meta) 실 적용 milestone 1건 완료 + 정량 데이터 기반 명시 발의 trigger 조건 충족 시 재발의.",
      "registration_recommendation": "거명만 (§ 6.2 default 동결 권고 정합) — ROADMAP 미등재. v3.13/v3.14 deferred 3건 패턴 정합."
    }
  ],
  "propose_summary": "v3.15 lessons 6건 (L1~L6) 중 후속 candidate 발의 2건. L1 (lightweight 모드 누적 5건) / L3 (source 인용 정책) / L4 (commit timing) / L5 (cross-ref 누적 효과) 는 lessons narrative 정합 — 별도 milestone 발의 가치 부재 (자연 누적 evidence). L2 origin candidate 1건 (v3.16_unreleased-section-position-cleanup) 은 narrative cleanup 본질 + workflow 미영향 = lightweight 모드 적합, 사용자 결정으로 ROADMAP 등재 vs 거명만 선택. L6 origin candidate 1건 (v3.X_changelog-backfill-pattern-formalization) 은 workflow narrative 본질 = § 6.2 default 동결 거명만. 본 PROPOSE Stage I 단일 책임 (forward) — REPORT (backward) 분리 정책 정합."
}
```

## B/C/D 부산물 origin 검증 (v3.10 정합)

본 PROPOSE 의 `next_candidates` 2건 origin 검증:

- candidate 1 (v3.16_unreleased-section-position-cleanup) — REPORT L2 origin = 본 milestone Stage D (DESIGN.D2 [Unreleased] 현행 보존 결정) 부산물 사실 진술. PROPOSE 안 통합 흡수 정합.
- candidate 2 (v3.X_changelog-backfill-pattern-formalization) — REPORT L6 origin = 본 milestone Stage H (REPORT lessons L6) 부산물 사실 진술. PROPOSE 안 통합 흡수 정합.

INTENT/RESEARCH/DESIGN 안 forward propose 명령형 표현 부재 grep 검증 (v3.10 도그푸드 정합) — 본 milestone 산출물 안 'PROPOSE.md `next_candidates` 발의' 표현 단일 source = PROPOSE.md 1곳.

## ROADMAP 등재 결정 (사용자 명시, 2026-05-13)

- candidate 1 (v3.16_unreleased-section-position-cleanup) — **거명만 (동결)**. 사용자 명시 결정 — v3.11~v3.14 default 동결 패턴 정합 (§ 6.2 자기참조 사이클 회피). 향후 자연 필요 시 사용자 명시 재발의 가능.
- candidate 2 (v3.X_changelog-backfill-pattern-formalization) — **ROADMAP 미등재** (§ 6.2 default 동결 권고, 거명만).

**ROADMAP 등재 0건** — v3.11~v3.14 패턴 정합 (lightweight cleanup 본질 milestone 의 후속 candidate 거명만 default).

## actual operation 후속

1. ✅ ROADMAP `v3.15_changelog-v3-backfill` entry status `in_progress` → `completed` 갱신 (본 PROPOSE 안 결정).
2. Stage G commit (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE.md + milestones.md + ROADMAP) — INTENT~APPROVE commit 시점 (b) default 정합.
3. push (사용자 확인) + PR 결정.

## 관련

- 선행 stage: [`INTENT.md`](INTENT.md), [`RESEARCH.md`](RESEARCH.md), [`DESIGN.md`](DESIGN.md), [`APPROVE.md`](APPROVE.md), [`VERIFY.md`](VERIFY.md), [`REPORT.md`](REPORT.md), [`execute/phase-1.md`](execute/phase-1.md)
- ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- 단일 source: [`../../../../CHANGELOG.md`](../../../../CHANGELOG.md)
