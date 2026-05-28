---
name: stage-verify
description: milestone VERIFY stage 작성 시 ## VERIFY section 안 검증 (smoke 결과 / criteria_check vs INTENT sc / verdict) mechanical task. 사용 case = 사용자가 'VERIFY stage 작성' / 'milestone VERIFY 진입' / '## VERIFY 섹션 작성' / 'sc 검증' 언급 또는 9-stage workflow Stage G (검증) 진행. SKIP = 'verify identity' / 'verify signature' 등 다른 도메인. 본 skill = WORKFLOW.md § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-verify — milestone VERIFY stage 작성 checklist

> 본 skill 은 `development/WORKFLOW.md` § 2 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.18_stage-skill-expansion-7-stages 에서 도입 (v6.16 시범 OPEN+PROPOSE 후 7 stage 확장 cycle 2). 본 skill 은 9-stage workflow 안 Stage G (VERIFY 검증) 진행 시 forcing function 역할 — schema template + checklist 만 제공, narrative judgment 은 LLM at runtime.

stage 단어 책임 (v2.0_workflow-word-fidelity 정합) = `검증` (verify) — EXECUTE 산출물의 smoke 결과 + INTENT sc 정합 + verdict 도출. word fidelity 95% 높은 부합 (WORKFLOW § 1 끝 #2 narrative 정합).

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## EXECUTE` 섹션 + `execute/phase-{n}.md` 별책 (Stage F 산출물). EXECUTE phases_executed[].deliverable + changes 가 검증 대상. INTENT success_criteria[] 가 검증 기준 source. DESIGN risk_mitigation 가 회귀 차단 본질.

읽을 곳:

- `projects/<name>/milestones/v{X.Y}/MILESTONE.md` 안:
  - `## INTENT` → success_criteria[] (검증 기준)
  - `## DESIGN` → risk_mitigation (회귀 차단 본질)
  - `## EXECUTE` → phases_executed (검증 대상)
- `projects/<name>/milestones/v{X.Y}/execute/phase-{n}.md` 별책 — phase 별 상세 changes + verification
- smoke 결과 — `bash tests/smoke-*.sh` 또는 pre-commit hook 실행 결과
- git log — commit trace (40-hex SHA + message + parents)

## 작성할 것

MILESTONE.md 안 `## VERIFY` H2 section 안 `### Spec` JSON 코드블록 + `### Narrative` 본문 작성.

### 1. `### Spec` 안 JSON schema

```json
{
  "smoke": {
    "method": "{pre-commit 18 hook 전체 / 개별 smoke 명시}",
    "result": "{PASS=N FAIL=M SKIP=K 정량 결과}",
    "detail": "{smoke 결과 narrative — FAIL 발생 시 정정 trace 포함}"
  },
  "criteria_check": [
    {
      "sc_ref": "sc_1",
      "verdict": "{PASS|FAIL|VACUOUS}",
      "evidence": "{검증 evidence narrative — path:line / smoke output / git commit SHA 등 1차 source 인용}"
    }
  ],
  "risk_check": [
    {
      "risk_ref": "risk_1",
      "mitigation_verdict": "{MITIGATED|PENDING|ACKNOWLEDGED}",
      "evidence": "{mitigation 효과 evidence narrative}"
    }
  ],
  "verdict": "{RESOLVED|PARTIAL|BLOCKED}"
}
```

필드 정합:

- `criteria_check[].sc_ref`: INTENT success_criteria[].id 정합 매핑 (sc_1, sc_2, ...)
- `criteria_check[].verdict`: enum 3 값 (PASS = 검증 통과 / FAIL = 검증 실패 → BLOCKED 또는 REPORT 안 P1 lessons / VACUOUS = scope 외 자연 PASS)
- `risk_check[].risk_ref`: RESEARCH risks_identified[].id 정합 매핑
- `risk_check[].mitigation_verdict`: enum 3 값 (MITIGATED = 명시 mitigation 효과 확인 / PENDING = 도그푸드 cycle 진행 중 / ACKNOWLEDGED = oos 또는 별 milestone 위임)
- `verdict`: enum 3 값 (RESOLVED = sc 전체 PASS + risk 전체 MITIGATED+ACKNOWLEDGED / PARTIAL = sc 일부 FAIL or risk PENDING / BLOCKED = 진입 차단 issue)

### 2. `### Narrative` 본문

검증 본질 요약 + sc 전체 verdict 결과 narrative + risk mitigation 효과 본질 + verdict 도출 근거 1~3 paragraph. LLM judgment 본질 — sc 안 evidence 인용 무결성 (path:line / smoke output / commit SHA) + risk 안 mitigation 본질 정합.

narrative judgment 본질 보존 — LLM at runtime, schema template forcing function 보조.

## 검증

VERIFY stage 작성 후 회귀 차단 smoke:

```bash
bash tests/smoke-spec-verification.sh
```

기대 결과 = PASS. VERIFY 섹션 안 ```json``` 코드블록 형식 + verdict 필드 강제 검증.

pre-commit 18 hook 전체 실행:

```bash
git add . && git commit  # 자동 실행
# 또는 수동:
pre-commit run --all-files
```

= 모든 smoke + lint + format hook 통과 시 VERIFY verdict 도출 자연.

## 관련

1차 source narrative:

- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 2 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/WORKFLOW.md`](../../development/WORKFLOW.md) § 1 — 9-stage workflow Stage G (VERIFY) 책임 = `검증 (smoke, criteria_check vs INTENT, verdict)`

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) — root 운영 가이드
- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command Stage G (VERIFY) 본문
- [`tests/CLAUDE.md`](../../tests/CLAUDE.md) — smoke 매트릭스 + 회귀 검증 절차

9 stage skill cross-ref (workflow 순서):

- `skills/stage-execute/` — F. EXECUTE stage (이전)
- `skills/stage-verify/` — G. VERIFY stage (본 skill)
- `skills/stage-report/` — H. REPORT stage (다음)
- 나머지 6 stage skill = OPEN / INTENT / RESEARCH / DESIGN / APPROVE / PROPOSE
