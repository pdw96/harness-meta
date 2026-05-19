---
id: milestone-artifact-json-field-reduction
title: milestone 산출물 JSON 필드 감축 (AI 컨텍스트 효율)
version: v6.1
stage: DESIGN
status: in_progress
---

# DESIGN — v6.1

## Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "C4 Anthropic 하이브리드 채택 — YAML frontmatter (id/title/version/stage/status) + JSON 코드 블록 (smoke 강제 필드만, id/title 제거) + Markdown body (나머지 narrative)"},
    {"id": "D2", "decision": "YAML frontmatter 필드 5건 = id (slug) + title (active form, ≤60자) + version (v{X.Y}) + stage (INTENT/.../PROPOSE) + status (in_progress/completed)"},
    {"id": "D3", "decision": "JSON 강제 필드 = smoke 현 강제 필드에서 id/title 제거. PLAN/INTENT 5→3, RESEARCH 4, DESIGN 2, APPROVE 1, VERIFY 2, REPORT 1, PROPOSE 1, execute 2 유지"},
    {"id": "D4", "decision": "Markdown body 흡수 대상 = motivation/dependencies/harness_engineering_mapping/preliminary_options_summary/approach/risk_mitigation/perspectives_review_summary/delta/lessons_learned 등"},
    {"id": "D5", "decision": "smoke-spec-verification.sh 자동 식별 — YAML frontmatter 존재 = 신규 schema / 부재 = 현 schema (backward compat). PyYAML 의존 회피 — 단순 regex + line split"},
    {"id": "D6", "decision": "EXECUTE 2 phase 분할 — phase-1: smoke 갱신 + v6.1 자체 도그푸드 (4건). phase-2: 28 milestone backfill + cascade 6 host"},
    {"id": "D7", "decision": "Mechanical 변환 규칙 = YAML frontmatter 생성 (id/title/version 보존, stage 파일명 추출, status REPORT 유무로 분기) + JSON id/title 제거 + 나머지 키 → MD body h2 섹션"},
    {"id": "D8", "decision": "cascade 정전화 6 host (v3.21 cycle 26) — root CLAUDE.md / projects/meta/CLAUDE.md / ARCHITECTURE § 6.1 / tests/CLAUDE.md / AGENTS.md / README.md. keyword: 'MD + JSON 코드블록' → 'Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body)'"},
    {"id": "D9", "decision": "smoke 변경 hardcode 패턴 — YAML parser 함수 추가 (~30-50 LOC) + 강제 필드 array 조정. 외부 의존 없음"},
    {"id": "D10", "decision": "도그푸드 sc_5 — phase-1 v6.1 자체 4건 (INTENT/RESEARCH/DESIGN/APPROVE) 신규 schema 재작성. VERIFY/REPORT/PROPOSE 는 phase 끝 후 자연 신규 schema"},
    {"id": "D11", "decision": "5 관점 검토 inline (architecture / scope contract / spec-drift / 회귀 risk / 보안). v6.1 고위험으로 v6.0 lightweight 3 관점보다 강화"}
  ],
  "phases": [
    {
      "phase": 1,
      "name": "smoke 갱신 + v6.1 자체 도그푸드",
      "scope": "(a) tests/smoke-spec-verification.sh 갱신 (YAML parser + 자동 식별), (b) v6.1 자체 INTENT/RESEARCH/DESIGN/APPROVE 4건 신규 schema 재작성, (c) smoke 검증 (v6.1 신규 + 기존 27 active 동시 PASS)",
      "verification": "bash tests/smoke-spec-verification.sh PASS — 신규 v6.1 4건 + 기존 27 active 통과"
    },
    {
      "phase": 2,
      "name": "Mechanical backfill 28 milestone + cascade 정전화",
      "scope": "(a) migration script (scripts/v6_1_migrate.py 임시), (b) backfill 적용 (meta v4.0~v6.0 27 + upbit v1.4 1), (c) cascade 6 host 정전화, (d) script 삭제 후 commit",
      "verification": "smoke PASS + pre-commit 14 hook PASS + nested 106→≤20 정량 측정 + cascade drift grep 0"
    }
  ]
}
```

## Risk mitigation

| risk | severity | mitigation |
|---|---|---|
| risk_1: smoke 갱신 회귀 | high | phase-1 v6.1 자체 4건 도그푸드 즉시 검증. 회귀 시 phase commit revert |
| risk_2: 정보 손실 | med | D7 변환 규칙 = JSON content 100% YAML/JSON/MD body 흡수 |
| risk_3: 28 일괄 회귀 | med | phase-2 dry-run + controlled 비교 (v2.1 패턴) |
| risk_4: chicken-and-egg | low | D10 phase-1 도그푸드 |
| risk_5: hook 영향 | low | phase-1 검증 step |

## 5 관점 검토 결과

| 관점 | verdict | 핵심 |
|---|---|---|
| architecture | pass | C4 Anthropic 정합. § 3.3 Context 행 cross-ref |
| scope contract | pass | oos 5건 명료, scope creep 작음 |
| spec-drift | pass | ext_1~ext_5 + cb_2 spec evidence 충분 |
| 회귀 risk | pass | risk_1 mitigation 강함 (phase-1 도그푸드) |
| 보안 | pass | side effect 부재, migration script 임시 |

**verdict**: pass-with-comments. **decisive 0건**, **P1 5건** (각 관점 1건 — 모두 흡수), **P2 1건** (architecture: perspectives_review_summary 객체 chicken-and-egg → 부분 도그푸드로 흡수).

## 신규 schema 명세

산출물 구조 (실 적용 = [`INTENT.md`](INTENT.md) / [`RESEARCH.md`](RESEARCH.md) / [`APPROVE.md`](APPROVE.md) / 본 DESIGN.md 자체):

1. **YAML frontmatter** (최상단, `---` ... `---` 블록) — `id` (slug, ≤60자) + `title` (active form, ≤60자) + `version` (`v{X.Y}`) + `stage` (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE) + `status` (in_progress/completed)
2. **H1 본문 제목** (옵션) — `# <Stage> — v{X.Y}` (markdownlint config 안 MD025 frontmatter_title 비활성, 본문 H1 허용)
3. **`## Spec`** + 축소 JSON 코드 블록 — smoke 강제 필드만 (id/title 제거, stage 별 의무 필드)
4. **`## <narrative h2 sections>`** — Markdown body, motivation/dependencies/risk_mitigation/perspectives_review_summary 등 자연어 흡수
5. **`## 관련`** — cross-ref 링크

## YAML frontmatter parser (smoke 갱신 D5)

PyYAML 외부 의존 회피 — 단순 regex + line-by-line 파싱. 30-50 LOC 신규 함수.

## Migration script 변환 규칙 (D7)

```text
입력: milestone 산출물 (현 schema)
처리:
  1. JSON 파싱
  2. YAML frontmatter 생성:
     - id = JSON.id 그대로
     - title = JSON.title 그대로 (≤60자 검증)
     - version = JSON.version 또는 디렉토리명 추출
     - stage = 파일명 추출 (INTENT.md → INTENT)
     - status = REPORT.md 존재 → completed / 부재 → in_progress
  3. JSON 재작성:
     - 강제 필드 유지
     - id/title 키 제거
  4. MD body 흡수:
     - 제거 대상 키 → h2 섹션 (## <한국어 key>)
     - array → 불릿 / object → sub-h3 또는 단락
     - 기존 '## 명료화' h2 보존 (append)
```

## cascade 6 host (D8)

| Host | 현 keyword | 신규 keyword |
|---|---|---|
| `CLAUDE.md` § '구조 규칙' | "MD + JSON 코드블록 포맷 의무" | "Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body) 의무" |
| `projects/meta/CLAUDE.md` | 동일 | 동일 |
| `projects/meta/ARCHITECTURE.md` § 6.1 | 동일 | 동일 |
| `tests/CLAUDE.md` smoke 매트릭스 | smoke-spec-verification 검증 대상 | YAML frontmatter parser 언급 추가 |
| `AGENTS.md` | 영문 동일 표현 | 영문 갱신 |
| `README.md` | 있다면 동일 | 갱신 |

## 정량 측정 목표 (sc_1 검증)

phase-2 끝 시점 측정:

| 지표 | baseline (v6.0 평균) | 목표 | 평가 source |
|---|---|---|---|
| top-level 합계 / milestone | 32.3 | ≤ 16 | sc_1 |
| nested 합계 / milestone | 106 | ≤ 20 | sc_1 |
| INTENT top-level | 7.7 | 3 | — |
| RESEARCH top-level | 5.4 | 4 (그대로) | — |
| DESIGN top-level | 5.9 | 2 | — |
| VERIFY top-level | 6.1 | 2 | — |
| REPORT top-level | 4.4 | 1 | — |
| PROPOSE top-level | 3.8 | 1 | — |
| YAML frontmatter 필드 / 산출물 | 0 | 5 | 신규 |

## 관련

- INTENT cross-ref: [`INTENT.md`](INTENT.md)
- RESEARCH cross-ref: [`RESEARCH.md`](RESEARCH.md)
- smoke 강제 schema: [`../../../../tests/smoke-spec-verification.sh`](../../../../tests/smoke-spec-verification.sh)
- ARCHITECTURE § 6.1 era 정책: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- v3.21 narrative 정전화 3 단계 패턴: ARCHITECTURE § 6.2
- v5.7 spec-drift spike 패턴: ARCHITECTURE § 6
- milestones.md: [`milestones.md`](milestones.md)
