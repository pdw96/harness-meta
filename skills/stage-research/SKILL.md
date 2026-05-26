---
name: stage-research
description: milestone RESEARCH stage 작성 시 ## RESEARCH section 안 조사 (external / codebase / options / risks_identified) mechanical task. 사용 case = 사용자가 'RESEARCH stage 작성' / 'milestone RESEARCH 진입' / '## RESEARCH 섹션 작성' 언급 또는 9-stage workflow Stage C (조사) 진행. SKIP = 'research' 일반 조사 표현 (예: 'web research') / '연구 논문 검색' 등 다른 도메인. 본 skill = ARCHITECTURE.md § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist.
---

# stage-research — milestone RESEARCH stage 작성 checklist

> 본 skill 은 `development/ARCHITECTURE.md` § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v6.18_stage-skill-expansion-7-stages 에서 도입 (v6.16 시범 OPEN+PROPOSE 후 7 stage 확장 cycle 2). 본 skill 은 9-stage workflow 안 Stage C (RESEARCH 조사) 진행 시 forcing function 역할 — schema template + checklist 만 제공, narrative judgment 은 LLM at runtime.

stage 단어 책임 (v2.0_workflow-word-fidelity 정합) = `조사` (research) — INTENT 목표 달성 위한 외부 + codebase + options + risks 4 본질 사실 수집.

## 입력

이전 stage 위치 = `MILESTONE.md` 안 `## INTENT` 섹션 (Stage B 산출물). INTENT goal + sc + dependencies 가 RESEARCH 안 조사 대상 결정 source.

읽을 곳:

- `projects/<name>/milestones/v{X.Y}/MILESTONE.md` 안 `## INTENT` — goal / sc / dependencies
- `projects/<name>/ARCHITECTURE.md` — codebase 안 정전 본질 source (cross-ref)
- 외부 1차 source — context7 (Anthropic Claude Code docs / 사용 library spec) + GitHub repos + Web search (필요 시)
- ROADMAP `next_candidates[]` + 이전 milestone PROPOSE — origin 본질 source

> ★ **cascade host 조사 grep 규율** (v8.2 가벼운 흐름 — deferred `v1.5_research-cascade-grep-discipline` 해소): 1차 source ↔ host narrative cascade 를 RESEARCH 할 때 host enumerate grep 은 **3 형식 모두** 커버해야 한다 — (1) **relative path** (`../ARCHITECTURE.md`, `../../development/...` 등 상대 경로), (2) **절대/repo-root path** (`development/ARCHITECTURE.md`), (3) **symlink/anchor 변형** (`#sub-milestones` anchor, `~/` 확장). v1.4 lessons #1 origin — relative path (`../ARCHITECTURE.md`) 1건 누락으로 cascade host 1건 미검출. mechanical 강화 = `cascade-source` marker 기반 자동 동기 (`scripts/cascade_sync.py`, v6.4) 가 marker-있는 host 는 cover 하나, marker 미부착 narrative host enumerate 는 여전히 manual grep — 따라서 grep 패턴에 3 형식 OR (`grep -rE '\.\./|development/|#'`) 적용 의무.

## 작성할 것

MILESTONE.md 안 `## RESEARCH` H2 section 안 `### Spec` JSON 코드블록 + `### Narrative` 본문 작성.

### 1. `### Spec` 안 JSON schema

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "{외부 1차 source 명시 — 예: context7 query /websites/code_claude / GitHub repo / spec URL}",
      "finding": "{본 source 안 조사 finding narrative — fact 인용 시 path:line 또는 직접 인용 보존}"
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": "{repo 안 파일 path + line range}",
      "finding": "{본 위치 안 finding narrative — 본 milestone INTENT 안 영향 본질}"
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "{옵션 label — 채택/폐기 명시 자연}",
      "rationale": "{본 옵션 채택/폐기 근거 narrative}"
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "{risk 본질 narrative}",
      "mitigation": "{mitigation 방안 narrative — DESIGN 안 d_X 결정 + risk_mitigation 매핑 source}"
    }
  ]
}
```

필드 정합:

- `external[].id`: regex `^ext_\d+$`
- `codebase[].id`: regex `^cb_\d+$`
- `options[].id`: regex `^opt_\d+$` (smoke-spec-verification 안 `options` 키 강제, v6.17 L4 evidence + v6.18 RESEARCH 안 동일 패턴 자연 발현)
- `risks_identified[].id`: regex `^risk_\d+$`

### 2. `### Narrative` 본문

조사 본질 요약 + finding 핵심 + options 채택/폐기 결정 narrative + risks 인지 본질 1~3 paragraph. LLM judgment 본질 — fact 인용 무결성 (path:line 또는 직접 인용 보존, v5.13/v5.18 정전화 정합) + options 채택/폐기 근거 narrative + risks ↔ DESIGN risk_mitigation 매핑 정합.

narrative judgment 본질 보존 — LLM at runtime, schema template forcing function 보조.

## 검증

RESEARCH stage 작성 후 회귀 차단 smoke:

```bash
bash tests/smoke-spec-verification.sh
```

기대 결과 = PASS. RESEARCH 섹션 안 ```json``` 코드블록 형식 + `options` 키 (smoke 강제) 존재 검증.

audit chain fact 인용 안전 시 (v5.13/v5.18 정전화):

```bash
python scripts/audit_fact_verify.py --dir <audit-output>
```

= boolean/표/수치 fact 인용 안 hallucination 자동 검출 (v6.6 + v6.9 정전화, scope = audit chain 4 멤버 산출물 한정).

## 관련

1차 source narrative:

- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 7.3 — Stage 본질 (templated section 작성 task) canonicalization paragraph
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 4 — 9-stage workflow Stage C (RESEARCH) 책임 = `조사 (external, codebase, options, risks_identified)`
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 4 끝 #5 row — Audit chain fact 인용 검증 의무 (v5.11+v5.18 정전화)
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 4 끝 #10 row — audit chain hallucination 자동 검출 mechanism (v6.6+v6.9)

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) — root 운영 가이드
- [`claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md) — `/harness-meta` slash command

9 stage skill cross-ref (workflow 순서):

- `skills/stage-intent/` — B. INTENT stage (이전)
- `skills/stage-research/` — C. RESEARCH stage (본 skill)
- `skills/stage-design/` — D. DESIGN stage (다음)
- 나머지 6 stage skill = OPEN / APPROVE / EXECUTE / VERIFY / REPORT / PROPOSE
