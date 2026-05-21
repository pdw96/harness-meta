---
name: stage-design
description: milestone DESIGN stage 작성 시 ## DESIGN section 안 설계 (decisions / approach / phases / risk_mitigation / 5 관점 review) mechanical task. 사용 case = 사용자가 'DESIGN stage 작성' / 'milestone DESIGN 진입' / '## DESIGN 섹션 작성' 언급 또는 9-stage workflow Stage D (설계) 진행. SKIP = 'design' 일반 디자인 표현 (예: 'UI design' / 'design system') / 다른 도메인. 본 skill = ARCHITECTURE.md § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-design — milestone DESIGN stage 작성 checklist

> 본 skill 은 `projects/meta/ARCHITECTURE.md` § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.18_stage-skill-expansion-7-stages 에서 도입 (v6.16 시범 OPEN+PROPOSE 후 7 stage 확장 cycle 2). 본 skill 은 9-stage workflow 안 Stage D (DESIGN 설계) 진행 시 forcing function 역할 — schema template + checklist 만 제공, narrative judgment 은 LLM at runtime.

stage 단어 책임 (v2.0_workflow-word-fidelity 정합) = `설계` (design) — RESEARCH 안 조사 fact 기반으로 decisions + approach + phases + risk_mitigation 4 본질 결정 + 5 관점 review 본질 자기 검토.

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## RESEARCH` 섹션 (Stage C 산출물). RESEARCH 안 options + risks_identified 가 DESIGN 안 decisions + risk_mitigation 매핑 source. INTENT goal/sc 가 approach 결정 본질 source.

읽을 곳:

- `projects/<name>/milestones/v{X.Y}/MILESTONE.md` 안:
  - `## INTENT` → goal / success_criteria / dependencies
  - `## RESEARCH` → external / codebase / options / risks_identified
- `projects/<name>/ARCHITECTURE.md` — § 4 끝 매트릭스 + 본문 paragraph (cascade host 후보 source)

## 작성할 것

MILESTONE.md 안 `## DESIGN` H2 section 안 `### Spec` JSON 코드블록 + `### Narrative` 본문 작성.

### 1. `### Spec` 안 JSON schema

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "{본 decision narrative — sc/oos/risk 와 1:1 매핑 본질}",
      "rationale": "{왜 본 decision 채택 — RESEARCH option_X 채택 또는 risk_X mitigation 본질 source}"
    }
  ],
  "approach": "{본 milestone 진행 approach narrative — phase 분할 본질 + sub-step 본질 + cascade host 정합 명시}",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "{본 phase scope narrative}",
      "deliverable": "{산출물 명시 — 파일 path 또는 narrative}",
      "verification": "{검증 method — smoke / lint / 사용자 확인}"
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_X",
      "method": "{mitigation method narrative — RESEARCH risks_identified[].mitigation 정합}"
    }
  ],
  "five_perspective_review": {
    "method": "{inline self-review (lightweight) 또는 subagent 5 관점 (architecture/spec-drift/security/performance/dx) 병렬 호출}",
    "perspectives": [
      {
        "perspective": "{architecture|spec-drift|security|performance|dx}",
        "verdict": "{PASS|pass-with-comments|FAIL}",
        "comments": "{5 관점 결과 narrative — decisive issue 발견 시 즉시 흡수 + P2/P3 lessons learned source}"
      }
    ]
  }
}
```

필드 정합:

- `decisions[].id`: regex `^d_\d+$`
- `phases[].phase`: regex `^phase-\d+$`
- `risk_mitigation[].risk_ref`: RESEARCH risks_identified[].id 정합 매핑
- `risk_mitigation[].decision_ref`: decisions[].id 정합 매핑
- `five_perspective_review.perspectives[].perspective`: enum 5 값 (architecture / spec-drift / security / performance / dx)
- `verdict`: enum 3 값 (PASS / pass-with-comments / FAIL)

### 2. `### Narrative` 본문

설계 본질 요약 + decisions 핵심 결정 trace + approach narrative + risk_mitigation 매핑 정합 + 5 관점 review 결과 종합 narrative 1~3 paragraph. LLM judgment 본질 — decisions ↔ risks ↔ sc 1:1 매핑 검증 + cascade host 명시 (v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 source 본질).

5 관점 review = inline self-review (lightweight 본질) 또는 subagent 5 관점 병렬 호출 (decisive 발견 시 즉시 흡수). v6.17 패턴 = inline (decisive 0 + P2 0 + P3 0). subagent 호출 cycle 정합 = v6.1/v6.2/v6.3/v6.4 누적 (architecture=Plan + 4 general-purpose, MEMORY feedback_subagent_parallel_review_evidence 정합).

narrative judgment 본질 보존 — LLM at runtime, schema template forcing function 보조.

## 검증

DESIGN stage 작성 후 회귀 차단 smoke:

```bash
bash tests/smoke-spec-verification.sh
```

기대 결과 = PASS. DESIGN 섹션 안 ```json``` 코드블록 형식 + decisions 필드 강제 검증.

cascade drift 검증 (v6.4 mechanism):

```bash
python scripts/cascade_sync.py --check
```

= cascade marker hash compare + drift detect (DESIGN 안 cascade host 식별 시).

## 관련

1차 source narrative:

- [`projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 7.3 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 — 9-stage workflow Stage D (DESIGN) 책임 = `설계 (decisions, approach, phases, risk_mitigation) + 5 관점 검토`
- [`projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 매트릭스 — cascade host 후보 source
- [`projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 6.2 — Narrative 정전화 3 단계 패턴 (v3.21 정전화, (a) DESIGN 1차 source + (b) EXECUTE Edit + (c) VERIFY grep)

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) — root 운영 가이드
- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command (Stage D 5 관점 review 본질 narrative 포함)

9 stage skill cross-ref (workflow 순서):

- `skills/stage-research/` — C. RESEARCH stage (이전)
- `skills/stage-design/` — D. DESIGN stage (본 skill)
- `skills/stage-approve/` — E. APPROVE stage (다음)
- 나머지 6 stage skill = OPEN / INTENT / EXECUTE / VERIFY / REPORT / PROPOSE
