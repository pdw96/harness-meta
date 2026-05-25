---
id: milestone-artifact-json-field-reduction
title: milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)
version: v6.1
stage: RESEARCH
status: in_progress
---

# RESEARCH — v6.1

## Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "context7 /websites/code_claude docs/en/memory", "finding": "Target under 200 lines per CLAUDE.md, markdown headers + bullets, concise instructions"},
    {"id": "ext_2", "source": "context7 docs/en/sub-agents", "finding": "Sub-agent = YAML frontmatter (name/description/tools/model) + Markdown body, JSON 코드 블록 부재"},
    {"id": "ext_3", "source": "context7 docs/en/plugins-reference", "finding": "Plugin agent = 동일 YAML+Markdown 패턴 (name/description/model/effort/maxTurns/disallowedTools)"},
    {"id": "ext_4", "source": "context7 docs/en/agent-sdk/structured-outputs", "finding": "JSON schema = 런타임 SDK output 검증 전용 (output_format), 컨텍스트 파일 안 권장 부재"},
    {"id": "ext_5", "source": "context7 docs/en/memory § Project Structure for Rules", "finding": ".claude/rules/<topic>.md 모듈식 분리 — 토픽별 작은 파일"}
  ],
  "codebase": [
    {"id": "cb_1", "source": "active 28 milestone 실측", "finding": "milestone 당 평균 top 32.3 / nested 106. max top 48 / nested 185. smoke baseline top 16 / nested 18. 잉여 = top ~16 / nested ~88"},
    {"id": "cb_2", "source": "smoke-spec-verification.sh", "finding": "강제 16 across 8 stage: PLAN/INTENT 5 + RESEARCH 4 + DESIGN 2 + APPROVE 1 + VERIFY 2 + REPORT 1 + PROPOSE 1 + execute 2"},
    {"id": "cb_3", "source": "v6.0 INTENT.md 135 LOC", "finding": "top 9 / nested 20. 비강제 4 top = version/motivation/dependencies/harness_engineering_mapping"},
    {"id": "cb_4", "source": "memory feedback_intent_md_schema_required + feedback_approve_md_schema_wrap", "finding": "v5.7/v5.8 phase-1 1차 commit 회귀 cycle 2 evidence — schema 변경 시 회귀 risk 높음"},
    {"id": "cb_5", "source": "ARCHITECTURE § 7 AI Native 운영 (v6.0)", "finding": "§ 7.1 컨텍스트 효율 면 정의 — 본 v6.1 첫 실 적용"},
    {"id": "cb_6", "source": "post-report-write.sh hook", "finding": "stage 진행 안내 메시지, schema 필드 직접 참조 부재"}
  ],
  "options": [
    {"id": "opt_C1", "name": "자연어 단락 흡수", "predicted_effect": "top 32→16, nested 106→~18", "anthropic_alignment": "직접 (ext_1)"},
    {"id": "opt_C2", "name": "필드 공용화 (manifest 분리)", "predicted_effect": "top 32→14, nested ~95", "anthropic_alignment": "약"},
    {"id": "opt_C3", "name": "중첩 평탄화 (nested → flat key)", "predicted_effect": "top 32→~50 (역행)", "anthropic_alignment": "반"},
    {"id": "opt_C4", "name": "Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body)", "predicted_effect": "top 32→16, nested 106→~20", "anthropic_alignment": "직접 × 2 (ext_2 + ext_3)"}
  ],
  "risks_identified": [
    {"id": "risk_1", "severity": "high", "item": "smoke 갱신 회귀 (memory cycle 2 evidence)", "mitigation": "phase-1 도그푸드 즉시 검증"},
    {"id": "risk_2", "severity": "med", "item": "정보 손실 — 자동화 도구 검색 제약", "mitigation": "보존 필드 명시 + YAML/JSON/MD 3 layer 흡수"},
    {"id": "risk_3", "severity": "med", "item": "28 milestone 일괄 회귀", "mitigation": "migration script dry-run + controlled 비교"},
    {"id": "risk_4", "severity": "low", "item": "chicken-and-egg — v6.1 자체 산출물", "mitigation": "phase-1 도그푸드 (4건 재작성)"},
    {"id": "risk_5", "severity": "low", "item": "post-report-write.sh hook 영향", "mitigation": "phase-1 검증 step"}
  ]
}
```

## 외부 source 1차 발견 — Anthropic 패턴 = YAML+Markdown

context7 4 query 결과 일관된 패턴:

1. **CLAUDE.md** = Markdown headers + bullets, JSON 코드 블록 부재 (ext_1)
2. **Sub-agent** = YAML frontmatter (최소 메타) + Markdown body (ext_2)
3. **Plugin agent** = 동일 YAML+Markdown 패턴 (ext_3)
4. **JSON schema** = 런타임 SDK output 검증 전용 (ext_4)
5. **모듈 분리** = `.claude/rules/<topic>.md` 토픽별 분리 (ext_5)

본 repo 의 "MD + JSON 코드 블록" 패턴은 Anthropic 표준 외 자체 도입 — smoke-spec-verification 자동화 의무로 정당화되지만, **자동화 범위 밖 필드는 JSON 보존 정당성 약함**. v6.1 = 이 불일치 해소 첫 milestone.

## 코드베이스 실측 — milestone 당 nested 106

active 28 milestone 평균:

| 산출물 | top avg | top max | nested avg | nested max |
|---|---|---|---|---|
| INTENT | 7.7 | 11 | 10.6 | 20 |
| RESEARCH | 5.4 | 9 | 28.9 | 74 |
| DESIGN | 5.9 | 10 | 23.9 | 48 |
| VERIFY | 6.1 | 9 | 19.4 | 63 |
| REPORT | 4.4 | 8 | 15.7 | 34 |
| PROPOSE | 3.8 | 6 | 11.0 | 20 |

가장 큰 부풀음 = RESEARCH/DESIGN/VERIFY 안 nested array (`[{id, description}, ...]` 패턴). 평균 4~6 item × 3~4 array = nested 부풀음 주범.

## 4 옵션 매트릭스 (DESIGN 결정 대상)

| 차원 | C1 자연어 흡수 | C2 필드 공용화 | C3 중첩 평탄화 | C4 Anthropic 하이브리드 |
|---|---|---|---|---|
| top-level 감축 | 32 → 16 | 32 → 14 | 32 → 50 (역행) | 32 → 16 |
| nested 감축 | 106 → ~18 | 106 → ~95 | 106 → 0 (flat) | 106 → ~20 |
| Anthropic 정합 | 직접 | 약 | 반 | 직접 × 2 |
| 변경 폭 | smoke 무변경 | 신규 manifest | smoke 갱신 | YAML+smoke 갱신 |
| 단순성 | ★★★★★ | ★★ | ★★★ | ★★★ |

## 우선순위 요약

- **효과 ranking**: C4 ≈ C1 > C2 > C3 (C3 역행)
- **Anthropic 정합 ranking**: C4 (직접 × 2) > C1 (직접) > C2 (약) > C3 (반)
- **단순성 ranking**: C1 > C3 > C4 > C2
- **추천**: C4 (효과 + 정합 최고)

DESIGN 안 사용자 결정 게이트 후 채택.

## 관련

- 외부 source: context7 `/websites/code_claude` 4 query (memory + sub-agents + plugins-reference + agent-sdk/structured-outputs)
- 실측 source: `projects/*/milestones/v[0-9]*/` active 28 milestone
- INTENT cross-ref: [`INTENT.md`](INTENT.md)
- smoke 강제 schema: [`../../../../tests/smoke-spec-verification.sh`](../../../../tests/smoke-spec-verification.sh)
- ARCHITECTURE § 7.1: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- v5.7 spec-drift spike 패턴: ARCHITECTURE § 6
