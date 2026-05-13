# APPROVE — v5.0 plugin-pivot

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-14",
    "approval_summary": "v5.0_plugin-pivot DESIGN 사용자 명시 승인 — Stage F EXECUTE 진입 게이트 통과. (1) 5 관점 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 전체 PASS 또는 PASS_WITH_COMMENTS 의견 충돌 0건 + 7 권고 모두 DESIGN.md 안 흡수 narrative 갱신 완료 (D6 commands precedent + hooks.json minimum schema + D10 책임 분리 narrative 구체화 + D3 PowerShell 동치 + D9 dual-active 검출 step 5 + D2 'v5.0+ 환경에서는 비활성' 명시화). (2) 사용자 명시 결정 round 1 (4 question 통합) — D1 O1 (Plugin 변환 + paths 명시 + 현 구조 보존) / D2 deprecation 표지 / D3 manual cleanup 권고 / D4 3 phase 분할 모두 Recommended 채택. (3) 본 v5.0 = v4.0_harness-composer-pivot (정체성 pivot, 첫 major bump) 직접 후속 두 번째 major bump (v4→v5) — breaking change. (4) Stage F EXECUTE 진입 — phase-1 (manifest 신규 + 사용자 onboarding cascade 3 host + hooks.json 신규) → phase-2 (내부 narrative cascade 10 host) → phase-3 (D7 책임 분리 + CHANGELOG [v5.0]! + bootstrap/claude-code-catalog/README.md.bak cleanup). 각 phase = 1 commit (conventional commits). commit timing (b) — Stage G commit 안 INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE/milestones.md/ROADMAP 통합."
  }
}
```

## 승인 narrative

v5.0_plugin-pivot DESIGN 본 milestone 의 의도 (INTENT) + 조사 (RESEARCH) + 설계 (DESIGN) + 5 관점 검토 결과 종합 narrative 사용자 명시 검토 후 승인 결정. 본 APPROVE 게이트 = Stage E APPROVE single source 의무 (메인 Claude 자동 작성 금지, 사용자 round 1 명시 + 5 관점 검토 PASS 확인 후).

## 5 관점 검토 결과 종합

| # | 관점 | agent | verdict | 핵심 권고 흡수 |
|:-:|------|-------|---------|----------|
| 1 | architecture | Plan | PASS_WITH_COMMENTS | hooks.json 결정 명시 (권고 #2) / D10 책임 분리 구체화 (권고 #3) / phase-1 transient note 분석 (권고 #4 흡수) / D6 결과 정전화 (권고 #1) |
| 2 | spec-drift | general-purpose + context7 | PASS_WITH_COMMENTS | D6 commands precedent narrative (권고 #1) / hooks.json minimum schema enumeration (권고 #2) / statusline 필드 부재 narrative (권고 #2 분기) |
| 3 | 회귀 risk | Explore | PASS_WITH_COMMENTS | 5 조건 Stage G 흡수 (manifest jq / D11 narrative discipline / smoke-cross-ref --fix 시점 / phase 별 JSON 유효성) |
| 4 | 보안 | general-purpose + security-review | PASS_WITH_COMMENTS | D3 PowerShell 동치 + 사전 verify (권고 #5) / D9 dual-active 검출 step 5 (권고 #6) / D2 deprecation 명시 (권고 #7) |
| 5 | scope contract | Explore | PASS | sc 10/10 매핑 / oos 6/6 사실 진술 / forward propose 명령형 0건 / v3.10 부산물 정책 정합 |

5 관점 합산: PASS / PASS_WITH_COMMENTS 5 + FAIL 0 + 의견 충돌 0 = APPROVE 게이트 통과 정합.

## 13 결정 사용자 명시 (D1 ~ D13)

| Decision | 결정 | 사용자 round |
|---|---|---|
| D1 | O1 채택 (Plugin 변환 + paths 명시 + 현 디렉토리 구조 보존) | round 1 명시 'O1 (Recommended)' |
| D2 | 자연어 호출 narrative deprecation 표지 | round 1 명시 'Deprecation 표지 (Recommended)' |
| D3 | manual cleanup 권고 narrative (5 멤버 SymbolicLink) | round 1 명시 'Cleanup 권고 (Recommended)' |
| D4 | 3 phase 분할 (manifest+onboarding / 내부 cascade / D7+CHANGELOG+cleanup) | round 1 명시 '3 phase (Recommended)' |
| D5 | plugin install scope = user default | DESIGN 안 narrative 명시 |
| D6 | paths 명시 sub-dir 별 안전 + Stage G mandatory 검증 | DESIGN + 5 관점 권고 #1 흡수 |
| D7 | marketplace name + plugin name = 'harness-meta' (source = '.') | DESIGN 안 narrative 명시 |
| D8 | bootstrap/claude-code-catalog/README.md.bak cleanup | DESIGN 안 narrative 명시 |
| D9 | Stage G VERIFY 5 step (실 plugin install + dual-active 검출) | DESIGN + 5 관점 권고 #6 흡수 |
| D10 | D7 sequence 책임 분리 narrative (custom vs Plugin install) | DESIGN + 5 관점 권고 #3 흡수 |
| D11 | v3.21 narrative 정전화 3 단계 패턴 8 번째 cycle | DESIGN 안 narrative 명시 |
| D12 | commit timing (b) — Stage G 통합 commit | DESIGN 안 narrative 명시 |
| D13 | forward propose 명령형 회피 + grep 검증 의무 | DESIGN 안 narrative 명시 |

## 7 권고 흡수 narrative (5 관점 결과)

| 권고 # | 출처 | 보정 위치 | status |
|---|---|---|---|
| 1 | architecture + spec-drift | D6 rationale + phase-1 paths 명시 1차 source | 흡수 완료 (DESIGN 안) |
| 2 | architecture + spec-drift | phase-1 hooks.json 결정 + minimum schema | 흡수 완료 (phase-1 affected_files 추가 + 1차 source) |
| 3 | architecture | D10 책임 분리 narrative 구체화 | 흡수 완료 (DESIGN 안 narrative) |
| 4 | architecture | phase-1 transient note 분석 | 흡수 완료 (회귀 risk Explore PASS 안 자연 흡수, 추가 narrative 부재 채택) |
| 5 | 보안 | D3 cleanup 권고 PowerShell 동치 + 사전 verify | 흡수 완료 (cascade 표준 narrative 안 명시) |
| 6 | 보안 | D9 VERIFY dual-active 검출 step 5 | 흡수 완료 (5 step 정전화) |
| 7 | 보안 | D2 deprecation 'v5.0+ 환경에서는 비활성' 명시 | 흡수 완료 (cascade 표준 narrative 안 명시) |

## EXECUTE 진입 준비 상태

- INTENT.md: 완료 (`success_criteria` 10 + `out_of_scope` 6 + `dependencies` 4)
- RESEARCH.md: 완료 (context7 5 source 검증 + cascade host 16 inventory + options 4 + risks 8)
- DESIGN.md: 완료 (decisions 13 + phases 3 + risk_mitigation 10 + 5 관점 검토 + 7 권고 흡수)
- APPROVE.md: 본 파일 (사용자 명시 승인, `approved_by: "user"` + `date: "2026-05-14"`)
- 다음 진입: Stage F EXECUTE phase-1

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- ROADMAP entry status: `in_progress` (v5.0 plugin-pivot)
- 선행 milestone: v4.3_subagent-discovery-path-research (RESEARCH 1차 source) + v4.0_harness-composer-pivot (정체성)
