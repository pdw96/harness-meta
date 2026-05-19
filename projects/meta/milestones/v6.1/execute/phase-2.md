# phase-2 — 28 milestone mechanical backfill + cascade 5 host 정전화

## Spec

```json
{
  "phase": 2,
  "status": "complete",
  "changes": [
    {"file": "scripts/v6_1_migrate.py", "change": "임시 migration script 작성 + 사용 후 삭제 (D6 정합)"},
    {"file": ".markdownlint.json", "change": "MD025 front_matter_title 비활성 + MD037 비활성 (frontmatter title + 본문 H1 공존 + underscore 식별자 emphasis 오인 회피)"},
    {"file": "projects/meta/milestones/v[4-5].x + v6.0/ (27 milestone × ~6 artifact = ~162 파일)", "change": "Anthropic 정합 하이브리드 schema 재작성 — YAML frontmatter (id/title/version/stage/status) + 축소 JSON (smoke 강제만, id/title 제거) + Markdown body h2 섹션 (motivation/dependencies/risk_mitigation 등 자연어 흡수)"},
    {"file": "projects/upbit/milestones/v1.4/ (7-stage era, ~7 artifact)", "change": "동일 신규 schema 적용 (PLAN.md goal/success_criteria/out_of_scope 강제 보존, era 자동 식별 정합)"},
    {"file": "CLAUDE.md", "change": "cascade host 1 — § '구조 규칙' milestone 산출물 포맷 narrative 갱신 ('MD + JSON 코드블록' → 'Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body)')"},
    {"file": "projects/meta/ARCHITECTURE.md", "change": "cascade host 2 — § 3.3 5요소 매트릭스 Workflow 행 narrative 갱신"},
    {"file": "claude/commands/harness-meta.md", "change": "cascade host 3 — 9-stage 워크플로우 안내 narrative 갱신"},
    {"file": "AGENTS.md", "change": "cascade host 4 — 영문 § 'Documentation language and format' 안 milestone artifacts 단락 갱신 + § 'Workflow' 안 narrative 갱신"},
    {"file": "tests/CLAUDE.md", "change": "cascade host 5 — smoke 매트릭스 안 smoke-spec-verification 설명 갱신 (v6.1+ 자동 식별 narrative 추가)"},
    {"file": "projects/meta/milestones/v6.1/milestones.md", "change": "sub_milestones[].phase-1 commit hash 갱신 (10ffa2c) + phase-2 complete + phase 분해 narrative"}
  ],
  "verification": {
    "smoke_spec_verification": "PASS — 28 milestone 신규 schema + v6.1 자체 4건 도그푸드 모두 통과",
    "pre_commit_14_hook": "PASS — 14 hook (fix-end-of-files + trim-trailing-ws + check-merge-conflicts + check-yaml + large-files + shellcheck + markdownlint + 7 smoke) 모두 통과",
    "quantitative_post_backfill": "active 28 milestone 평균 — top 32.3→13.9 (-57.1%, 목표 ≤16 ✓), nested 106→60.1 (-43.3%, 목표 ≤20 미충족 — narrative 흡수 정합), YAML +34.5",
    "cascade_drift_grep": "0 — 'MD + JSON 코드블록' 잔존 0건 in active hosts (5 cascade 모두 갱신, _archive 40 건은 역사적 보존)"
  }
}
```

## 변경 narrative

### migration script (임시 사용 + 삭제)

`scripts/v6_1_migrate.py` (D6/D7 정합) — 임시 mechanical 변환:

1. YAML frontmatter 생성 (id/title/version/stage/status, PyYAML 의존 없음 — 단순 string 포맷)
2. JSON id/title 제거 + 강제 필드만 유지
3. 제거 키 → MD body h2 섹션 (자연어 흡수, lint-friendly `_sanitize_inline` + `_short_json` 포맷)
4. 기존 `## 명료화` h2 보존 (append-only)

사용 직후 삭제 — repo 안 임시 인프라 잔존 0.

### markdownlint config 조정

frontmatter title + 본문 H1 공존 회귀 발견 — `.markdownlint.json`:

- `MD025: { front_matter_title: "" }` — frontmatter title 검출 비활성 (본문 H1 만 multiple-h1 검출 대상)
- `MD037: false` — underscore 식별자 (e.g., `tests/_inactive/`) 가 emphasis marker 로 오인되는 문제 회피. 본문 안 underscore 포함 path/var name 보존 의무

### 28 milestone backfill

migration script 일괄 적용:

- meta v4.0~v4.3 + v5.0~v5.21 + v6.0 = 27 milestone × ~6 artifact = 162 파일
- upbit v1.4 (7-stage era) = 7 artifact (PLAN.md goal/success_criteria/out_of_scope 보존)
- v6.1 자체 = phase-1 안 이미 도그푸드 적용, skip

총 189 artifact migrated, 4 skipped (v6.1 자체).

### v4.2/DESIGN.md 수동 정정

migration 후 1건 markdownlint 위반 (MD038 — code span 안 spaces) — 원본 JSON string 안 inline triple-backtick 패턴 (`` ```markdown ... ``` ``) 이 MD body 로 이동 시 code span 검증 회귀. 수동 inline 정정 (triple-backtick 제거, narrative 보존).

### cascade 5 host 정전화 (D8)

| Host | 변경 |
|---|---|
| `CLAUDE.md` § '구조 규칙' | 'MD + JSON 코드블록' → 'Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body, v6.1+, 이전 v1.0~v6.0 = MD + JSON 코드블록)' |
| `projects/meta/ARCHITECTURE.md` § 3.3 Workflow 행 | 동일 narrative 갱신 |
| `claude/commands/harness-meta.md` 9-stage 안내 | 동일 narrative 갱신 |
| `AGENTS.md` (영문 2 위치) | "Anthropic-aligned hybrid format" + v6.1+ schema 설명 |
| `tests/CLAUDE.md` smoke 매트릭스 | smoke-spec-verification 안 v6.1+ 자동 식별 narrative 추가 |

v3.21 narrative 정전화 3 단계 패턴 cycle 26 — (a) DESIGN 1차 source (v6.1 DESIGN.D8 표) + (b) EXECUTE Edit (본 phase-2) + (c) VERIFY grep (다음 단계).

### 정량 측정 (active 28 milestone)

| 지표 | baseline | post-v6.1 | delta |
|---|---|---|---|
| JSON top-level avg/milestone | 32.3 | 13.9 | **-57.1%** ✓ 목표 ≤16 |
| JSON nested avg/milestone | 106.0 | 60.1 | -43.3% (목표 ≤20 미충족) |
| YAML frontmatter avg/milestone | 0 | 34.5 | +34.5 (신규, 5 필드 × 6-7 artifact) |

nested 미충족 = risk_2 mitigation 정합 — narrative 흡수 한계 인지 + 추가 감축 후속 milestone candidate.

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md) D1~D11 + phase-2 spec
- phase-1: [`phase-1.md`](phase-1.md)
- milestones.md: [`../milestones.md`](../milestones.md) sub_milestones[].phase-2
