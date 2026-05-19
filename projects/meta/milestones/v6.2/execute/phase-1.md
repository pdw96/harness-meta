# phase-1 — smoke 4종 era 분기 + cascade 12 host 정전화 + schema 정전 정의

## Spec

```json
{
  "phase": 1,
  "status": "complete",
  "changes": [
    {"file": "tests/_era_detect.py", "change": "9-stage-flattened era 신규 분류 추가 (검사 순서 우선) — 디렉토리 명 ^v\\d+\\.\\d+$ + MILESTONE.md 존재 → flattened (D6, phase-2 retrofit 일시 동시 존재 케이스 deterministic 보장)"},
    {"file": "tests/smoke-spec-verification.sh", "change": "extract_h2_section_json + check_h2_section_fields 함수 추가 + main() 끝 flattened era H2 8 stage 섹션 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE) 추가 검증 loop (D7 a, regression P2 #2 흡수 — 8 stage 분기 모두 flattened 정합)"},
    {"file": "tests/smoke-scope-contract.sh", "change": "extract_json + check_out_of_scope + check_approval 시그니처에 h2_name 인자 추가 (default None = bundled/legacy era 첫 ```json``` / str = flattened era H2 섹션 추출). main() 안 era 분기 = 9-stage-flattened 시 fp=MILESTONE.md + h2_name=INTENT/APPROVE (D7 b)"},
    {"file": "tests/smoke-bundle-trigger.sh", "change": "MILESTONES_PATH_REGEX 갱신 — `^milestones/(_archive/)?v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$` (D7 c, era 양립 + `_archive/` prefix 보존, regression P1 #1 흡수)"},
    {"file": "tests/smoke-open-stage-discipline.sh", "change": "디렉토리 명 매칭 + 페어링 검증 = (milestones.md OR MILESTONE.md) 둘 중 하나 존재 시 PASS (D7 d, era 양립)"},
    {"file": "tests/_inactive/smoke-posttooluse-hook.sh", "change": "Test W 신규 — Write + MILESTONE.md → NOOP {} 검증 (v6.2 D8 flattened era hook trigger 부재, architecture P1 #2 흡수). 25→26 checks"},
    {"file": "claude/hooks/post-report-write.sh", "change": "v6.2 D8 narrative comment + MILESTONE.md grep 패턴 추가 — projects/[^/]+/milestones/v[^/]+/MILESTONE\\.md$ 매칭 시 NOOP (milestones.md NOOP 패턴 정합)"},
    {"file": "projects/meta/ARCHITECTURE.md", "change": "§ 6.1 era 정책 표 4 row → 5 row (9-stage-flattened v6.2+ 신규 row 첫번째) + flattened era 정전화 paragraph 추가 (v3.21 narrative 정전화 3 단계 패턴 cycle 27, D9)"},
    {"file": "CLAUDE.md (root)", "change": "milestone 산출물 narrative 갱신 — v6.2+ flattened era 추가 (4 필드 frontmatter, MILESTONE.md 본책 + execute/ 별책). module 표 + workflow 표 + milestone 번호 정책 cascade. 신규 작업 = v6.2+ 의무"},
    {"file": "projects/meta/CLAUDE.md", "change": "milestone 산출물 narrative 갱신 — v6.2+ 9-stage-flattened 디렉토리 구조 추가 (MILESTONE.md 본책 H2 9 섹션 + execute/phase-{n}.md 별책)"},
    {"file": "claude/CLAUDE.md", "change": "PostToolUse 현행 패턴 갱신 — v6.2+ MILESTONE.md NOOP 패턴 + 진화 이력 추가 (architecture P1 #1 흡수, cascade 11→12 host 보정)"},
    {"file": "tests/CLAUDE.md", "change": "smoke 매트릭스 갱신 — smoke-spec-verification + smoke-scope-contract + smoke-bundle-trigger + smoke-open-stage-discipline + smoke-posttooluse-hook 5 row v6.2+ era 분기 narrative (regression P2 #2 + architecture P1 #2 흡수)"},
    {"file": "claude/commands/harness-meta.md", "change": "Stage A OPEN narrative 갱신 — step 5/6/7 v6.2+ flattened era 의무 (MILESTONE.md ## SUB_MILESTONES 섹션 첫 작성, milestones_path anchor #sub-milestones)"},
    {"file": "projects/meta/milestones/v6.2/RESEARCH.md", "change": "JSON 필드명 정정 — external_sources/codebase_findings → external/codebase (v6.1 schema 정합, smoke-spec-verification PASS 회귀 해소)"}
  ],
  "verification": {
    "smoke_4종": "PASS — smoke-spec-verification PASS=252 FAIL=0 SKIP=40 + smoke-scope-contract PASS=59 FAIL=0 SKIP=3 + smoke-bundle-trigger PASS + smoke-open-stage-discipline PASS (bundled/flattened checked=30, historical skipped=1)",
    "pre_commit_14_hook": "PASS — 14 hook 모두 통과, 회귀 0 (markdownlint / shellcheck / smoke 7 + 기타 6)",
    "cb_4_regex_spike": "정확 hardcode = `^milestones/(_archive/)?v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$` (smoke-bundle-trigger.sh:47 실 grep 후 D7 c 갱신, spec-drift P1 #2 + architecture P2 #2 cross-cover)",
    "controlled_비교_4_step": "phase-1 시점 = baseline (HEAD 직전 commit, v6.1 era logic) vs post (현 working tree, v6.2 flattened 분기 추가). diff = 의도된 변경만 (era 분기 신규 + H2 검증 loop + cascade narrative). flattened era milestone = 0건 (phase-2 retrofit 후 1건) → 신규 loop body skip = 회귀 0. regression P2 #1 narrative 정합."
  }
}
```

## 변경 narrative

### 1. era 분류 단일 source 갱신 (D6)

`tests/_era_detect.py` 안 `detect_era()` 함수 = 검사 순서 우선 변경 (9-stage-flattened 첫 검사 → 9-stage-bundled → 9-stage → 7-stage → skip). phase-2 retrofit 일시 동시 존재 (MILESTONE.md + milestones.md 둘 다 존재) 케이스 deterministic — flattened 우선 채택.

### 2. smoke 4종 era 분기 (D7)

| smoke | 분기 추가 |
|---|---|
| smoke-spec-verification | `extract_h2_section_json` + `check_h2_section_fields` 신규. main() 끝 flattened era loop (H2 8 stage 검증) |
| smoke-scope-contract | `extract_json(fp, h2_name=None)` 시그니처 확장. main() 안 era 분기 (9-stage-flattened 시 MILESTONE.md + h2_name=INTENT/APPROVE) |
| smoke-bundle-trigger | regex `(MILESTONE\.md(#sub-milestones)?\|milestones\.md)` 양립 + `(_archive/)?` prefix 보존 |
| smoke-open-stage-discipline | 페어링 = `milestones.md` OR `MILESTONE.md` 둘 중 하나 |

### 3. cascade 12 host 정전화 (D9, v3.21 narrative 정전화 3 단계 패턴 cycle 27)

| # | host | 갱신 keyword |
|---|---|---|
| 1 | ARCHITECTURE.md § 6.1 | 표 5 row + flattened era paragraph (단일 source) |
| 2 | CLAUDE.md (root) | v6.2+ flattened era 신규 작업 의무 narrative |
| 3 | projects/meta/CLAUDE.md | MILESTONE.md 본책 + execute/ 별책 디렉토리 구조 |
| 4 | claude/CLAUDE.md | PostToolUse 현행 패턴 (MILESTONE.md NOOP) |
| 5 | tests/CLAUDE.md | smoke 매트릭스 5 row era 분기 (architecture P1 #2 + regression P2 #2 흡수) |
| 6 | claude/commands/harness-meta.md | Stage A OPEN step 5/6/7 era 분기 |
| 7 | tests/_era_detect.py | 9-stage-flattened 신규 분류 + docstring |
| 8 | tests/smoke-spec-verification.sh | extract_h2 + flattened era loop |
| 9 | tests/smoke-scope-contract.sh | era 분기 + h2_name 인자 |
| 10 | tests/smoke-bundle-trigger.sh | regex era 양립 |
| 11 | tests/smoke-open-stage-discipline.sh | 페어링 era 양립 |
| 12 | tests/smoke-posttooluse-hook.sh (Test W) + claude/hooks/post-report-write.sh (narrative + grep) | hook trigger 부재 (D8) |

### 4. cb_4 regex spike (spec-drift P1 #2 + architecture P2 #2)

DESIGN 단계 RESEARCH.cb_4 = '현 regex 추정' 표지. EXECUTE 시점 spec-drift spike 패턴 (ARCHITECTURE § 6 끝, v5.7 정전화) (c) Stage F 실 spike 분기 채택:

```bash
sed -n '47p' tests/smoke-bundle-trigger.sh
# MILESTONES_PATH_REGEX = re.compile(r"^milestones/(_archive/)?v[0-9]+\.[0-9]+/milestones\.md$")
```

정확 regex 확인 후 D7 (c) 갱신 `(MILESTONE\.md(#sub-milestones)?\|milestones\.md)` era 양립 + `_archive/` prefix 보존 hardcode 적용. RESEARCH 추정 표지 정정 완료.

### 5. smoke-spec-verification 회귀 정정 (in-execute)

phase-1 작업 도중 `bash tests/smoke-spec-verification.sh` 1차 검증 시 FAIL 1건 발생 — `projects/meta/v6.2/RESEARCH.md` 안 JSON 필드 = `external_sources` / `codebase_findings` (긴 형태) 사용 → v6.1 schema 정전화 안 강제 필드명 = `external` / `codebase` 짧은 형태 (`tests/smoke-spec-verification.sh:227` `["external", "codebase", "options", "risks_identified"]`). RESEARCH.md 안 두 필드명 정정 후 재검증 PASS=252 FAIL=0.

### 6. 검증 결과

- smoke-spec-verification PASS=252 FAIL=0 SKIP=40 (v6.1 자체 + v6.2 신규 분기 + 28 active 모두 통과)
- smoke-scope-contract PASS=59 FAIL=0 SKIP=3 (era 분기 정합)
- smoke-bundle-trigger PASS (regex 갱신 + _archive/ prefix 보존 정합)
- smoke-open-stage-discipline PASS (bundled/flattened checked=30, historical skipped=1 — v6.2 디렉토리 자체 + MILESTONE.md 부재라 milestones.md 페어링 PASS)
- pre-commit 14 hook 모두 PASS

회귀 0. r_2 mitigation 정합.

## 관련

- DESIGN: [`../DESIGN.md`](../DESIGN.md)
- MILESTONE 본책 schema source: [`../DESIGN.md`](../DESIGN.md) § 신규 schema 명세
