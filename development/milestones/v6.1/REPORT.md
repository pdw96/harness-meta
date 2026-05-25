---
id: milestone-artifact-json-field-reduction
title: milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)
version: v6.1
stage: REPORT
status: completed
---

# REPORT — v6.1

## Spec

```json
{
  "summary": "AI Native 운영 § 7.1 컨텍스트 효율 면 첫 실 적용 milestone. C4 Anthropic 정합 하이브리드 schema (YAML frontmatter + 축소 JSON + Markdown body) 채택, smoke 자동 식별 추가, active 28 milestone (meta 27 + upbit 1) backfill, cascade 5 host 정전화. 정량 결과: JSON top 32.3→13.9 (-57.1%, sc_1 ✓) + nested 106→60.1 (-43.3%, sc_1 acknowledged 미충족) + YAML +34.5. 7-round pre-PLAN dialog + 5 관점 검토 pass-with-comments + v3.21 narrative 3 단계 패턴 cycle 26 도그푸드. 2 phase 2 commit (10ffa2c + 5d7164a), pre-commit 14 hook 모두 PASS, 회귀 0."
}
```

## Delta

| 차원 | baseline (v6.0 시점) | post-v6.1 | 변화 |
|---|---|---|---|
| milestone 산출물 schema | MD + JSON 코드 블록 (id/title/version JSON top-level) | Anthropic 정합 하이브리드 (YAML frontmatter 5 필드 + 축소 JSON + MD body) | breaking-minor (smoke 자동 식별 backward compat 으로 minor 가능) |
| JSON top-level / milestone | 32.3 | 13.9 | -57.1% |
| JSON nested / milestone | 106 | 60.1 | -43.3% |
| YAML frontmatter / milestone | 0 | 34.5 | +34.5 (신규) |
| Active milestone backfill | 0 | 28 | 27 meta + 1 upbit |
| Cascade host 갱신 | 0 | 5 | CLAUDE.md / ARCHITECTURE / harness-meta.md / AGENTS.md / tests/CLAUDE.md |
| smoke-spec-verification 강제 schema | 16 강제 (id/title 포함) | 16 강제 (frontmatter id/title 5 + JSON 강제 11 분리) | 동급 (분리 + 자동 식별) |
| markdownlint config | default + MD025 enabled + MD037 enabled | MD025 front_matter_title 비활성 + MD037 비활성 | frontmatter title 공존 + underscore 식별자 보존 |
| context7 외부 source 정합 | 자체 패턴 | Anthropic sub-agent + plugin agent 패턴 직접 정합 (ext_2/ext_3) | 외부 표준 정합 신규 |

## Lessons learned

- **L1: Anthropic 표준 패턴 = YAML frontmatter + Markdown** — context7 4 query 일관 evidence (sub-agent / plugin agent / CLAUDE.md / 모듈 분리). JSON 은 런타임 SDK output 검증 전용. 본 repo "MD + JSON 코드 블록" 패턴은 자체 도입 — smoke 자동화 의무로 정당화 되나 자동화 범위 밖 필드는 정당성 약함. v6.1 = 이 불일치 해소 첫 evidence.
- **L2: nested ≤ 20 hardcode 한계** — smoke 강제 nested array (success_criteria[] / out_of_scope[] / decisions[] / risks_identified[] 등) 필수 보존 의무 — 추가 감축은 item 객체 → string 단순화 등 별 mechanism 필요. risk_2 mitigation 정합 (narrative 흡수 한계 인지 + 후속 candidate 등재).
- **L3: 도그푸드 chicken-and-egg = phase 분할로 해소** — phase-1 (smoke 갱신 + v6.1 자체 4 건 도그푸드) → phase-2 (backfill + 자기 결과 신규 schema 자연 적용). v3.21 narrative 3 단계 패턴 cycle 26 완성.
- **L4: markdownlint config 조정 의무** — frontmatter title + 본문 H1 공존 시 MD025 충돌 / underscore 식별자 (`tests/_inactive/` 등) MD037 false positive — Anthropic 패턴 도입 시 lint config 동기 조정 필요. .markdownlint.json `MD025 front_matter_title: ""` + `MD037: false` hardcode.
- **L5: migration script 임시 + 삭제 패턴** — `scripts/v6_1_migrate.py` D6/D7 정합 — 일회성 mechanical 변환, 사용 직후 삭제로 repo 인프라 잔존 0. lint-friendly `_sanitize_inline` + `_short_json` 변환 함수.
- **L6: cascade 5 host = narrative 정전화 3 단계 패턴 cycle 26** — DESIGN D8 표 → EXECUTE phase-2 Edit → VERIFY grep (jangsu drift 0). 도그푸드 완성. 누적 26 cycle = harness-meta 핵심 인프라.
- **L7: smoke 자동 식별 = backward compat 절차** — extract_frontmatter() 함수 + check_json_fields() 분기 = 신규 schema (frontmatter 존재) vs 현 schema (부재) 양립. backfill 중 mixed state 안전 + _archive 영향 0.

## Review summary

5 관점 검토 inline (DESIGN D11) — verdict pass-with-comments / decisive 0 / P1 5 + P2 1 모두 흡수.

| 관점 | pre-EXECUTE verdict | post-EXECUTE 실측 |
|---|---|---|
| architecture | pass | ✓ ARCHITECTURE § 3.3 Workflow 행 cascade 정합 |
| scope contract | pass | ✓ oos 5건 명료, scope creep 0 (디렉토리 평탄화 v6.2 분리 정합) |
| spec-drift | pass | ✓ ext_1~ext_5 + cb_2 spec evidence 충분, RESEARCH → DESIGN → EXECUTE 검증 |
| 회귀 risk | pass | ✓ risk_1 mitigation 강함 (phase-1 도그푸드), 회귀 0 |
| 보안 | pass | ✓ side effect 부재, migration script 임시 + 삭제 |

## Round summary — 7 round pre-PLAN dialog (memory feedback_iterative_pre_plan_review)

본 milestone = 사용자 결정 누적 7 round 의 산출:

1. **후보 선택**: JSON 필드 감축 (entry title smoke 는 v6.2 와 bundling)
2. **감축 기준**: 자연어 흡수 → "접근 자체 재검토" 확장
3. **적용 범위**: 전체 backfill → active 27 + upbit 1 축소
4. **유지 필드**: RESEARCH 외부 source 확인 후 결정
5. **디렉토리 평탄화**: v6.2 분리
6. **DESIGN 옵션**: C4 Anthropic 하이브리드
7. **APPROVE**: 승인

## 관련

- INTENT/RESEARCH/DESIGN/APPROVE: [`INTENT.md`](INTENT.md) + [`RESEARCH.md`](RESEARCH.md) + [`DESIGN.md`](DESIGN.md) + [`APPROVE.md`](APPROVE.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- phase-1 / phase-2: [`execute/phase-1.md`](execute/phase-1.md) + [`execute/phase-2.md`](execute/phase-2.md)
- commit: 10ffa2c (phase-1) + 5d7164a (phase-2)
