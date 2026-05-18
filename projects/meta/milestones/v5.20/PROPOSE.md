# PROPOSE — v5.20 audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade

```json
{
  "id": "v5.20",
  "roadmap_registration_count": 0,
  "next_candidates": [
    {
      "id": "audit-cycle-8-evidence-isolation-with-commit",
      "origin": "v5.20 L2 + v5.19 PROPOSE#1 carry-over — narrative effect isolation 한계 evidence 첫 직접 확인",
      "rationale": "본 v5.20 cycle 7 = stability cycle 안 hallucination 발현 분포 본질 evidence 첫 직접 확인 (cycle 6 0건 vs cycle 7 2건 동일 baseline). v5.19 PROPOSE#1 trigger 조건 'cycle 7+ commit 발생 후 호출 = 새 fact source 추가 = narrative 효과 단일 evidence 가능' 강화. cycle 8 = upbit commit 발생 후 audit chain 8 호출 = 새 fact source 추가 = narrative 효과 단일 source 분리 가능 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ cycle 8+ 호출 + upbit commit 발생 (새 fact source 추가)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero, lightweight default 동결 정합)"
    },
    {
      "id": "audit-agent-tool-permission-enhancement-v2",
      "origin": "v5.20 L6 + v5.18 PROPOSE#4 carry-over — D10 우회 패턴 한계 sub-evidence 누적",
      "rationale": "본 v5.20 cycle 7 = mapper D10 우회 패턴 안 hallucination 2건 발현 = D10 우회 한계 추가 evidence 누적 (cycle 5 + cycle 7 = 2 cycle 발현). v5.18 PROPOSE#4 carry-over trigger 가속. mapper+proposer agent .md frontmatter `tools:` 안 `Read` 추가 진급 candidate (Read tool 보유 = 직접 Read 가능 = D10 우회 패턴 단순화).",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ D10 우회 한계 추가 evidence cycle 8+ 발현 누적",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "audit-output-markdown-lint-rule-hardcode-expansion-md034",
      "origin": "v5.20 L3 cascade + v5.19 PROPOSE#3 carry-over — MD034 발현 2 cycle 누적 (cycle 6 11건 + cycle 7 4건 = N=2)",
      "rationale": "MD034 발현 cycle 6 + cycle 7 = 2 cycle 누적. MD028 (cycle 6 1건) + MD038 (cycle 5 1건) + MD034 (cycle 6+7 = 2 cycle 누적) = hardcode 외 rule 3종 누적 + MD034 cycle 8+ 추가 발현 시 hardcode 확장 trigger 충족. ARCHITECTURE § 4 끝 'Agent 산출 markdown lint precheck 의무' paragraph + claude/commands/harness-meta.md `--audit` 분기 안 MD034 hardcode 추가 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ cycle 8+ MD034 추가 발현 누적",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "section-4-narrative-canonicalization-matrix-row-append-pattern-canonicalization",
      "origin": "v5.20 L4 — matrix row append 의무 narrative 정전화 candidate",
      "rationale": "본 v5.20 = 매트릭스 표 안 row 7건 + matrix sub-section 마지막 narrative '신규 § 4 끝 paragraph 추가 시 본 매트릭스 row append 의무 (v3.21 narrative 정전화 3 단계 패턴 정합 — (b) EXECUTE Edit 단계에서 매트릭스 row append 동기 수행)' 추가. 단 본 narrative 자체는 paragraph 본문 매핑 자연 — v3.21 패턴 정전화 위치 (§ 6.2) 안 row append 의무 명문화 candidate. cycle 8+ 추가 정전화 시 매트릭스 row append 자연 검증 가능.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 새 § 4 끝 paragraph 정전화 + matrix row append 누락 사례 발생",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "smoke-cross-ref-fix-paragraph-row-deletion-pattern-warning",
      "origin": "v5.20 L3 — smoke --fix paragraph/row 1행 자동 삭제 회귀 2 cycle 누적",
      "rationale": "본 v5.20 phase-2 + phase-3 commit 안 smoke-cross-ref --fix mode 가 broken ref 1행 자동 삭제 = paragraph 본문 또는 matrix row 통째 손실 위험. 정정 패턴 = (a) 복원 + (b) cross-ref 정정 + (c) 2차 commit. tests/smoke-cross-ref.sh --fix mode 안 'paragraph/row 1행 단위 삭제 → 작성자 검토 의무' warning narrative 추가 candidate.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ smoke --fix paragraph/row 자동 삭제 회귀 cycle 8+ 추가 발생",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "section-4-bundling-sub-section-renumber-cleanup",
      "origin": "v5.20 L5 — § 4.1 Bundling vs matrix 무넘버 sub-section layout 불일치 정정 candidate",
      "rationale": "본 v5.20 = matrix sub-section 무넘버 H3 처리 (외부 cross-ref 다수 cascade drift 회피). 단 layout 깔끔성 약화 (sub-section 번호 § 4.1 Bundling 만 존재 + matrix 무넘버). 후속 milestone 안 § 4.1 → § 4.2 (Bundling) 재번호 + matrix § 4.1 (Matrix Index) 일괄 cascade (외부 cross-ref ADR-006 + milestones v3.0/v5.9/v5.10/v5.11/_archive/v3.20/_archive/v3.21 안 § 4.1 reference 일괄 갱신). cascade drift 위험 vs layout 깔끔 trade-off.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ § 4 sub-section 번호 layout 깔끔성 우선 결정",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero, cascade drift risk 우선)"
    },
    {
      "id": "self-loop-classification-criteria-definition",
      "origin": "v5.19 PROPOSE#9 = v5.18 PROPOSE#7 = v5.17 PROPOSE#6 carry-over — self-loop 분류 기준 narrative 정전화 candidate",
      "rationale": "본 v5.20 self-loop 카운팅 20/26 = 76.9% (D6) vs scope 확장 후 21/27 = 77.8% — 분자 self-loop 매핑 narrative 부재. ARCHITECTURE.md 안 self-loop 분류 기준 paragraph 정전화 candidate. carry-over 3 cycle 누적 (v5.17 → v5.18 → v5.19 → v5.20 = 4 cycle).",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ 추가 카운팅 모호 사례 발생",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "architecture-section-3-1-baseline-drift-cleanup",
      "origin": "v5.19 PROPOSE#6 = v5.18 PROPOSE#5 carry-over — § 3.1 92.3% self-loop vs 현재 ~76.9% 누적 stale",
      "rationale": "본 v5.20 = § 3.1 baseline narrative 본문 변경 부재 (out_of_scope#4 정합). v5.10/v5.14/v5.15/v5.16/v5.17/v5.18/v5.19/본 v5.20 cycle 8회 누적 후 더욱 stale (92.3% → 76.9% = 15.4pp 차이).",
      "trigger_condition": "사용자 명시 발의 (A_user)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero)"
    },
    {
      "id": "harness-cost-tracker-spike-reevaluation",
      "origin": "v5.19 PROPOSE#10 = v5.18 PROPOSE#9 = v5.17 PROPOSE#9 carry-over — F4 SPIKE 본 v5.20 cycle 7 carry-over Accept (a)",
      "rationale": "본 v5.20 = cycle 6 사용자 결정 Accept (a) /usage built-in 우선 carry-over. mechanical apply 부재 (P3 보류 유지). cycle 8+ pain point evidence (자동 누적 로그 / 임계값 알림 / 복수 세션 집계) 발생 시 옵션 b (harness-cost-tracker SKILL) 재평가 trigger.",
      "trigger_condition": "사용자 명시 발의 (A_user) ∧ pain point evidence 누적",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero, F4 SPIKE cycle 7 carry-over absorbed)"
    },
    {
      "id": "upbit-v1.16-untracked-artifact-cleanup",
      "origin": "v5.19 L7 carry-over — upbit repo 안 v1.16 PROPOSE/REPORT untracked 2건 발견",
      "rationale": "upbit repo 안 milestones/v1.16/PROPOSE.md + REPORT.md 2건 untracked carry-over. v1.16 milestone closing 누락 가능성. 본 v5.20 scope 외 (upbit repo 책임). cycle 8+ audit 시 동일 발견 시 trigger 가속.",
      "trigger_condition": "사용자 명시 발의 (A_user, upbit scope)",
      "trigger_type": "C_improvement",
      "decision": "거명만 (ROADMAP 등재 zero, upbit scope)"
    }
  ],
  "policy_compliance": {
    "lightweight_default_freeze_compliance": "ROADMAP 등재 0건 (lightweight default 동결 정합). 본 v5.20 자체는 lightweight 이탈 (scenario B 3-phase + chore = 4 commit) — D15 결정 narrative 흡수. 단 next_candidates 등재 0건 정합 = 동결 정책 유지. v5.7 ~ v5.19 누적 13 cycle 동결 + 본 v5.20 등재 0건 = 14 cycle 동결 사례 (단 lightweight 이탈 milestone 등재 1건).",
    "byproduct_absorption_compliance": "INTENT.out_of_scope 9건 사실 진술 + RESEARCH.untouched_files_explicit 5건 + risks_identified 8건 + DESIGN.decisions D1~D15 rationale + phases[1+2+3].scope 본 PROPOSE 안 통합 흡수 (v3.10 단일 origin 강제). next_candidates 10건 = B/C/D 부산물 흡수 (5 carry-over from v5.19 + 4 신규 origin from v5.20 L1~L6) + cycle 6 carry-over (F4). forward propose 명령형 부재 (B/C/D 안 거명 부재 검증)."
  },
  "propose_summary": "v5.20 후속 forward proposal 10건 (거명만 10건, ROADMAP 등재 0). 신규 origin 5건 = (1) audit-cycle-8-evidence-isolation-with-commit (L2 narrative effect isolation 한계 첫 확인) / (2) audit-agent-tool-permission-enhancement-v2 (L6 D10 우회 한계 2 cycle 누적) / (3) audit-output-markdown-lint-rule-hardcode-expansion-md034 (L3 MD034 2 cycle 누적) / (4) section-4-narrative-canonicalization-matrix-row-append-pattern-canonicalization (L4 매트릭스 row append 의무) / (5) smoke-cross-ref-fix-paragraph-row-deletion-pattern-warning (L3 smoke --fix 회귀 2 cycle) + (6) section-4-bundling-sub-section-renumber-cleanup (L5 layout trade-off). carry-over 5건 = v5.19 PROPOSE.next_candidates#1+#4+#6+#9+#10 (evidence isolation + tool permission + § 3.1 baseline + self-loop 분류 + F4 cost tracker + upbit v1.16 untracked) — 일부 absorbed (#1+#4 v5.20 안 부분 흡수 narrative). 모두 lightweight default 동결 정합. 사용자 결정 게이트 = 본 milestone PROPOSE 안 ROADMAP 등재 부재 default."
}
```

## narrative

### ROADMAP 등재 0건 — lightweight default 동결 정합 (단 본 v5.20 자체는 lightweight 이탈)

본 milestone 안 사용자 명시 신규 발의 부재 (다음 cycle 8+ 시 진급 candidate). 모두 거명만 (lightweight default 동결, v4.0 § 6.2 폐지 후 가드레일 narrative 흡수). 단 본 v5.20 자체 = scenario B (3-phase bundling) 채택으로 lightweight 이탈 — D15 정당화 narrative 흡수 (bundling 키워드 정합).

### next_candidates 10건 분류

| ID | origin | trigger_condition | trigger_type |
|---|---|---|:-:|
| `audit-cycle-8-evidence-isolation-with-commit` | v5.20 L2 + v5.19 PROPOSE#1 carry-over | cycle 8+ commit 발생 후 호출 | C_improvement |
| `audit-agent-tool-permission-enhancement-v2` | v5.20 L6 + v5.18 PROPOSE#4 carry-over | D10 우회 한계 cycle 8+ 발현 누적 | C_improvement |
| `audit-output-markdown-lint-rule-hardcode-expansion-md034` | v5.20 L3 + v5.19 PROPOSE#3 carry-over | cycle 8+ MD034 추가 발현 누적 | C_improvement |
| `section-4-narrative-canonicalization-matrix-row-append-pattern-canonicalization` | v5.20 L4 | 새 § 4 끝 paragraph + row append 누락 | C_improvement |
| `smoke-cross-ref-fix-paragraph-row-deletion-pattern-warning` | v5.20 L3 | smoke --fix 회귀 cycle 8+ 추가 | C_improvement |
| `section-4-bundling-sub-section-renumber-cleanup` | v5.20 L5 | layout 깔끔 우선 결정 | C_improvement |
| `self-loop-classification-criteria-definition` | v5.19 PROPOSE#9 carry-over | 추가 모호 사례 | C_improvement |
| `architecture-section-3-1-baseline-drift-cleanup` | v5.19 PROPOSE#6 carry-over | 사용자 명시 | C_improvement |
| `harness-cost-tracker-spike-reevaluation` | v5.19 PROPOSE#10 carry-over | pain point evidence | C_improvement |
| `upbit-v1.16-untracked-artifact-cleanup` | v5.19 L7 carry-over | 사용자 명시 (upbit scope) | C_improvement |

### v3.10 부산물 통합 흡수 정합

- B (INTENT.out_of_scope 9건): 모두 사실 진술 — forward propose 명령형 부재. PROPOSE.next_candidates 안 통합 흡수 ✅
- C (RESEARCH.untouched_files_explicit 5건 + risks_identified 8건): 식별 risk + 영향 부재 파일 — '거명 candidate' 명시 부재 ✅
- D (DESIGN.decisions D1~D15 + phases[1+2+3].scope): 결정 기술 + 단계 범위 사실 진술 — 'next_candidates 진급 narrative' 부재 ✅

본 PROPOSE 안 origin 단일화 (v3.10 단일 origin 강제 정합).

### v5.19 PROPOSE#4 + #8 absorbed (본 milestone 자체)

v5.19 PROPOSE.next_candidates#4 (`audit-cycle-stability-pattern-canonicalization-architecture`, stability paragraph 정전화) + #8 (`architecture-section-4-end-paragraph-matrix-canonicalization`, § 4 매트릭스화) = 본 v5.20 자체 (cycle 7 + paragraph + 매트릭스화 통합) 안 흡수. v5.20 PROPOSE 안 별 carry-over entry 부재 (absorbed by self).

### v5.20 → next ROADMAP 등재 결정

본 milestone 완료 + Stage I PROPOSE 안 ROADMAP 등재 0건 default. 사용자 명시 발의 시 위 next_candidates 10건 중 1건 선택 후 ROADMAP 등재 (Stage I actual operation step 2).

## 관련

- INTENT: [INTENT.md](INTENT.md)
- REPORT: [REPORT.md](REPORT.md) (lessons L1~L7)
- VERIFY: [VERIFY.md](VERIFY.md)
- v5.19 PROPOSE.md (carry-over 5건 origin)
- v5.19 cycle 6 산출물: `projects/upbit/audit-2026-05-19-cycle6/`
- v5.20 cycle 7 산출물: `projects/upbit/audit-2026-05-19-cycle7/`
