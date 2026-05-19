---
id: milestone-artifact-directory-flattening
title: milestone 산출물 디렉토리 평탄화 (단일 파일 통합)
version: v6.2
stage: DESIGN
status: in_progress
---

# DESIGN — v6.2

## Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "(opt-A) era 분기 자연 확장 채택 — _era_detect.py 안 9-stage-flattened 신규 era 추가. (opt-B) glob 별 분기 = era 단일 source 부정 / (opt-C) version hardcode = 사용자 결정 (3) 변질 — 모두 거부."},
    {"id": "D2", "decision": "MILESTONE.md schema = YAML frontmatter (milestone-level, 1건) + H2 9 섹션 (## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES). 각 H2 섹션 안 = `## Spec ` + ```json``` 축소 JSON 코드 블록 + Markdown body (현 hybrid schema 동치)."},
    {"id": "D3", "decision": "YAML frontmatter **4 필드** (v6.1 5 필드 → v6.2 4 필드 reduction) = id (milestone-level slug) + title (active form, ≤60자) + version (v{X.Y}) + status (in_progress/completed). stage 필드 제거 — milestone-level 통합 표지 (H2 섹션 자체가 stage 표지). 5 관점 spec-drift P1 #1 흡수 (자기모순 정정)."},
    {"id": "D4", "decision": "execute/ 별책 보존 — execute/phase-{n}.md 별도 디렉토리 유지 (v6.1 형태 그대로). 본책 (MILESTONE.md) 안 ## EXECUTE 섹션 = phase 별 summary table + execute/phase-{n}.md cross-ref. 별책 실 구현 일지 분리."},
    {"id": "D5", "decision": "## SUB_MILESTONES 섹션 = 기존 milestones.md 흡수. 구조 = `## Spec ` + ```json``` (`sub_milestones[]` array) + Markdown Notes (origin / trigger / scope 결정 / out_of_scope / 5요소 매핑 / 버전 bump / AI Native 시리즈 위치 등)."},
    {"id": "D6", "decision": "era 분기 — `tests/_era_detect.py` 안 9-stage-flattened 신규 분류 추가. 검사 순서 = 9-stage-flattened (디렉토리 명 `^v\\d+\\.\\d+$` + MILESTONE.md 존재) → 9-stage-bundled (디렉토리 명 + milestones.md) → 9-stage (INTENT+APPROVE+PROPOSE) → 7-stage → skip. MILESTONE.md 검사 = milestones.md 검사 직전 우선 (둘 동시 존재 케이스는 phase-2 retrofit 중간 일시적 — 어느 쪽이 우선이든 deterministic 결정 필요, MILESTONE.md 우선 채택)."},
    {"id": "D7", "decision": "smoke 4종 변경 — (a) smoke-spec-verification.sh: H2 섹션 grep + JSON 코드블록 추출 (flattened era 분기). 9-stage era 8 stage 각각 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute) 분기 모두 flattened 정합 (regression P2 #2 흡수, PROPOSE stage 8 분기 명시), (b) smoke-scope-contract.sh: detect_era 결과 flattened 시 MILESTONE.md 안 H2 ## INTENT/## APPROVE 섹션 grep + 안 JSON 추출, (c) smoke-bundle-trigger.sh: milestones_path regex = `^milestones/(_archive/)?v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$` (regression P1 #1 흡수, `_archive/` prefix 보존 — `v4.0_harness-composer-pivot` 안 _archive entry 정합성 보장), (d) smoke-open-stage-discipline.sh: 디렉토리 명 매칭 + (MILESTONE.md OR milestones.md) 페어링 (era 양립)."},
    {"id": "D8", "decision": "post-report-write hook 영향 = 부재 처리 + smoke-posttooluse-hook NOOP 경로 검증 행 추가. MILESTONE.md edit 시 ## REPORT 섹션 신규 출현 자동 검출 = 구현 복잡 + trigger 점 모호. 단순함 우선 — MILESTONE.md edit 시 hook trigger 부재 (사용자가 PROPOSE 직접 진행). R4 mitigation 정합. tests/smoke-posttooluse-hook.sh 안 v6.2 flattened era 입력 시 NOOP 경로 검증 행 추가 (architecture P1 #2 흡수). post-report-write hook 자동 era 분기는 후속 milestone v6.x 으로 deferred (architecture P2 #1 흡수, PROPOSE 안 next_candidate 등재)."},
    {"id": "D9", "decision": "cascade 정전화 **12 host** (v3.21 narrative 정전화 3 단계 패턴 cycle 27, architecture P1 #1 흡수 — 11→12 보정) — 1) ARCHITECTURE.md § 6.1 (표 4→5 row + flattened era paragraph 신규), 2) CLAUDE.md (root), 3) projects/meta/CLAUDE.md, 4) **claude/CLAUDE.md** (신규 — PostToolUse + 디렉토리 구성 narrative), 5) tests/CLAUDE.md (smoke 매트릭스 4 row narrative + smoke-posttooluse-hook narrative), 6) claude/commands/harness-meta.md (Stage A OPEN narrative), 7) tests/_era_detect.py (분류 코드 + docstring), 8) tests/smoke-spec-verification.sh, 9) tests/smoke-scope-contract.sh, 10) tests/smoke-bundle-trigger.sh, 11) tests/smoke-open-stage-discipline.sh, 12) tests/smoke-posttooluse-hook.sh (NOOP 경로 검증 + claude/hooks/post-report-write.sh narrative comment 추가)."},
    {"id": "D10", "decision": "2 phase 분할 — phase-1: 11 host 갱신 (smoke 4종 + _era_detect.py + 5 narrative host + hook narrative 명시) + schema 정전 정의 + smoke regression PASS 검증. phase-2: v6.2 자체 retrofit (INTENT/RESEARCH/DESIGN/APPROVE.md 4건 + milestones.md → MILESTONE.md 통합) + VERIFY/REPORT/PROPOSE 신규 H2 섹션 작성 + execute/phase-{n}.md 별책 작성 + ROADMAP milestones_path 갱신."},
    {"id": "D11", "decision": "도그푸드 sc_4 — phase-1 시점에 schema 정전 정의 (ARCHITECTURE § 6.1 paragraph) → phase-2 시점에 v6.2 자체 retrofit (chicken-and-egg 회피 — schema 정의 먼저, 적용 나중). v6.1 phase-1 도그푸드 (4건 신규 schema 재작성) 와 동일 패턴 — 단 v6.2 = 디렉토리 구조 변경이라 retrofit 시점 = phase-2 (smoke regression PASS 후 안전)."},
    {"id": "D12", "decision": "정보 손실 mitigation (r_1) — 통합 procedure 명시. (a) MILESTONE.md frontmatter = INTENT.md frontmatter 안 id/title/version/status 4 필드 (stage 제거, D3 정합), (b) 각 stage 산출물 (## Spec + body) → 1 H2 섹션 (예: INTENT.md `## Spec ```json``` + body` → MILESTONE.md `## INTENT \\n\\n### Spec ```json``` + body`), (c) `## 관련` 섹션 통합 (각 stage 산출물 끝 cross-ref 1 통합 ## 관련 섹션), (d) milestones.md → ## SUB_MILESTONES (## Spec + Notes 보존)."},
    {"id": "D13", "decision": "5 관점 검토 = subagent 병렬 호출 (사용자 명시 결정). architecture (Plan agent) + spec-drift / regression / security / dictionary-semantics (general-purpose 4건). 결과: verdict pass-with-comments × 4 + pass × 1 (security) / decisive 0건 / P1 11건 + P2 9건 모두 흡수."},
    {"id": "D14", "decision": "MILESTONE.md H2 9 섹션 = **9-stage 단어 fidelity 8 stage + 1 listing 책임 명시 분리** (dictionary-semantics P1 #3 흡수). H2 8 stage 섹션 (## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE) = v2.0_workflow-word-fidelity 정전화 단어 = 단일 책임 1:1 매핑 보존. H2 +1 섹션 (## SUB_MILESTONES) = sub-milestone listing 별 책임 (9-stage 외 추가, milestones.md 흡수 책임). 두 책임 명료 분리."},
    {"id": "D15", "decision": "bundling 정책 v6.2+ era 보존 — ARCHITECTURE § 6.1 bundling 정책 (version 단위 1 milestone + sub-milestone phase 매핑) 본질 = ## SUB_MILESTONES 섹션 안 흡수 = bundling 본질 보존 (dictionary-semantics P1 #2 흡수). era 명명 분리 (bundled vs flattened) ≠ bundling 정책 폐기. bundled era = milestones.md 별파일 listing / flattened era = ## SUB_MILESTONES 섹션 listing — 형식 차이만, bundling 정책 동일 적용."},
    {"id": "D16", "decision": "ext_2 context7 추정 후속 = DESIGN 즉시 정정 (spec-drift P1 #3 흡수, v5.7 spike 패턴 (c) DESIGN 즉시 정정 분기 채택, phase-1 spike 부재). Anthropic Claude Code patterns 안 '1 entity = 1 primary file' = milestone 1건 = MILESTONE.md 1 본책 (+ execute/ 별책 디렉토리 = 실 구현 일지) = 정합. (b) 하이브리드 정의 = mix of distinct kinds (단일 파일 + 다파일 디렉토리, dictionary-semantics P2 #7 흡수)."},
    {"id": "D17", "decision": "phase-2 retrofit atomic commit 강제 (architecture P1 #3 + regression P1 #2 cross-cover) — D10 phase-2 (f) `git rm INTENT.md RESEARCH.md DESIGN.md APPROVE.md milestones.md` + `git add MILESTONE.md` + commit = 단일 atomic commit 강제. git rm 5건 N:1 매핑 = git mv 불가, commit 메시지 안 source 5 파일 hash 인용 narrative 정전화 (history 추적 보존, R5 mitigation). 중간 상태 (MILESTONE.md + 개별 파일 동시 존재) 도 detect_era 검사 순서 (flattened 우선, D6) deterministic 보장."}
  ],
  "phases": [
    {
      "phase": 1,
      "name": "smoke 4종 era 분기 + _era_detect.py 갱신 + cascade 11 host 정전화 + schema 정전 정의",
      "scope": "(a) tests/_era_detect.py 안 9-stage-flattened 신규 분류 추가 (검사 순서 우선), (b) smoke 4종 era 분기 추가 (D7 정합), (c) ARCHITECTURE § 6.1 era 정책 paragraph 5 row + flattened paragraph 신규, (d) 5 narrative host 갱신 (CLAUDE.md root + projects/meta + tests + harness-meta.md), (e) smoke regression PASS 검증 — v3.0~v6.1 28 active milestone 모두 PASS 유지.",
      "verification": "(1) bash tests/smoke-spec-verification.sh PASS + bash tests/smoke-scope-contract.sh PASS + bash tests/smoke-bundle-trigger.sh PASS + bash tests/smoke-open-stage-discipline.sh PASS + pre-commit 14 hook 모두 PASS, 회귀 0. (2) controlled 비교 4-step (tests/CLAUDE.md § 회귀 검증 절차 — git show HEAD: baseline + CRLF 정규화 diff, regression P2 #1 흡수). (3) cb_4 regex 정확 hardcode 검증 — `tests/smoke-bundle-trigger.sh:47` 안 실 regex 확인 후 D7 (c) 갱신 (spec-drift P1 #2 + architecture P2 #2 cross-cover)."
    },
    {
      "phase": 2,
      "name": "v6.2 자체 retrofit (INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md → MILESTONE.md 통합) + VERIFY/REPORT/PROPOSE H2 섹션 신규 작성",
      "scope": "(a) MILESTONE.md 신규 작성 (D2/D12 schema 적용 — frontmatter 4 필드 + ## INTENT/## RESEARCH/## DESIGN/## APPROVE H2 섹션 = 기존 산출물 4건 통합), (b) ## SUB_MILESTONES 섹션 = milestones.md 흡수, (c) ## VERIFY/## REPORT/## PROPOSE H2 섹션 신규 작성, (d) ## EXECUTE 섹션 = phase 별 summary table + execute/phase-{n}.md cross-ref, (e) ## 관련 섹션 통합, (f) git rm INTENT.md RESEARCH.md DESIGN.md APPROVE.md milestones.md (5건 삭제) + git add MILESTONE.md = **단일 atomic commit** (D17 정합, architecture P1 #3), (g) ROADMAP entry milestones_path = `milestones/v6.2/MILESTONE.md#sub-milestones` 갱신. commit 메시지 안 source 5 파일 hash 인용 narrative (regression P1 #2 history 보존).",
      "verification": "bash tests/smoke-spec-verification.sh PASS (v6.2 MILESTONE.md 첫 검증) + smoke 4종 PASS + pre-commit 14 hook PASS + 통합 후 정보 손실 0 (controlled 비교 — 통합 전 INTENT/RESEARCH/DESIGN/APPROVE/milestones.md 5건 LOC 합 vs MILESTONE.md LOC 정성 동치)."
    }
  ]
}
```

## Risk mitigation

| risk | severity | mitigation |
|---|---|---|
| r_1: 정보 손실 — phase-2 통합 시 H2 경계 misalignment | high | D12 통합 procedure 명시 — 각 stage 산출물 → 1 H2 섹션 1:1 매핑 + ## Spec JSON 코드블록 보존 + Markdown body 보존 + ## 관련 1 통합 섹션 |
| r_2: smoke 회귀 — era 분기 신규 logic 안 v3.0~v6.1 28 milestone PASS 유지 | high | phase-1 안 controlled 비교 4-step (tests/CLAUDE.md § 회귀 검증 절차 직접 참조, regression P2 #1 흡수) — git show HEAD: baseline + CRLF 정규화 diff. v3.0~v6.1 28 milestone 모두 PASS 검증. |
| r_3: CHANGELOG.md drift — [v6.2] entry 안 잘못된 link | low | Stage I PROPOSE 안 cross-ref 정합 + smoke-cross-ref.sh autofix |
| r_4: post-report-write hook 모호 — MILESTONE.md ## REPORT 섹션 추가 검출 | med | D8 결정 = hook trigger 부재 (사용자 manual PROPOSE 진행). 단순함 우선. tests/smoke-posttooluse-hook.sh 안 NOOP 경로 검증 추가 (D8). |
| r_5: smoke-bundle-trigger regex anchor false-positive + `_archive/` 누락 | med | D7 (c) regex 엄격 = `^milestones/(_archive/)?v[0-9]+\.[0-9]+/(MILESTONE\.md(#sub-milestones)?\|milestones\.md)$` — `_archive/` prefix 보존 (regression P1 #1). git rm 5건 N:1 매핑 = commit 메시지 안 source hash 인용 narrative (regression P1 #2). |
| r_6: chicken-and-egg — v6.2 schema 정의 (phase-1) vs v6.2 자체 retrofit (phase-2) | low | D11 = phase 순서 정합 (schema 먼저, 적용 나중) — v6.1 동일 패턴 (phase-1 도그푸드 vs phase-2 backfill) 정합 |
| r_7: phase-2 retrofit 중간 동시 존재 (MILESTONE.md + 개별 파일) | med | D17 atomic commit 강제 (architecture P1 #3 흡수). detect_era 검사 순서 (flattened 우선, D6) deterministic 보장. |
| r_8: smoke-spec-verification PROPOSE stage 8 flattened 분기 미명시 | low | D7 (a) 안 8 stage 분기 모두 flattened 정합 명시 (regression P2 #2 흡수). |

## 5 관점 검토 결과

| 관점 | verdict | 핵심 |
|---|---|---|
| architecture | pass-with-comments | cascade host 11→12 (claude/CLAUDE.md 추가) + smoke-posttooluse-hook NOOP + atomic commit 강제 — D9/D8/D17 흡수 |
| spec-drift | pass-with-comments | D3 자기모순 정정 + cb_4 regex hardcode + ext_2 DESIGN 즉시 정정 (1 entity = 1 primary file 정합) — D3/D7(c)/D16 흡수 |
| regression | pass-with-comments | r_5 regex `_archive/` 보존 + git rm history 보존 (hash 인용) + controlled 비교 4-step + PROPOSE stage 8 분기 — D7/r_5/r_8 흡수 |
| security | **pass** | 외부 입력 부재 + side effect 부재 + git history 보존 + 권한 escalation 부재 + 민감 정보 N/A + OWASP top 10 N/A. 보안 표면 변화 부재. |
| dictionary-semantics | pass-with-comments | '평탄화'/'하이브리드'/'본책+별책'/'MILESTONE.md 대문자'/title 4 원칙 = pass. ## SUB_MILESTONES = 8 stage + 1 listing 책임 분리 명시 — D14/D15/D16 흡수 |

**verdict**: pass-with-comments. **decisive 0건**. **P1 11건 + P2 9건 모두 흡수** (D3/D7/D8/D9/D14/D15/D16/D17 신규 + r_5/r_7/r_8 신규 + verification step (2)(3) 추가).

## 신규 schema 명세 (MILESTONE.md)

### 구조 (D2/D3/D12 정합)

````text
---
id: <milestone-level-slug>
title: <active form, ≤ 60자>
version: v{X.Y}
status: in_progress | completed
---

# v{X.Y} — <title>

## INTENT

### Spec
```json
{ "goal": "...", "success_criteria": [...], "out_of_scope": [...] }
```

<Markdown body — motivation / dependencies / harness_engineering_mapping / 명료화>

## RESEARCH

### Spec
```json
{ "external_sources": [...], "codebase_findings": [...], "options": [...], "risks_identified": [...] }
```

<Markdown body>

## DESIGN

### Spec
```json
{ "decisions": [...], "phases": [...] }
```

<Markdown body — risk_mitigation / 5 관점 검토 결과 / schema 명세>

## APPROVE

### Spec
```json
{ "approval": { "approved_by": "user", "date": "YYYY-MM-DD" } }
```

<Markdown body — approval narrative>

## EXECUTE

| phase | name | commit | execute file |
|:-:|---|---|---|
| 1 | <phase 1 name> | <commit hash> | [`execute/phase-1.md`](execute/phase-1.md) |
| 2 | <phase 2 name> | <commit hash> | [`execute/phase-2.md`](execute/phase-2.md) |

## VERIFY

### Spec
```json
{ "smoke_results": [...], "criteria_check": [...], "verdict": "pass | pass-with-comments | fail" }
```

<Markdown body>

## REPORT

### Spec
```json
{ "summary": "...", "delta": {...}, "lessons_learned": [...] }
```

<Markdown body>

## PROPOSE

### Spec
```json
{ "next_candidates": [...] }
```

<Markdown body>

## SUB_MILESTONES

### Spec
```json
{ "sub_milestones": [{"id": "...", "phase": 1, "commit": "..."}, ...] }
```

### Notes

<origin / trigger / scope 결정 / out_of_scope / 5요소 매핑 / 버전 bump / AI Native 시리즈 위치 등>

## 관련

- (1 통합 cross-ref 섹션 — 모든 stage 산출물 끝 cross-ref 흡수)
````

### era 표지 (D6 정합)

- 디렉토리 명: `^v\d+\.\d+$` (밑줄 부재, v3.0+ 9-stage-bundled era 와 동일)
- 본책 파일: `MILESTONE.md` (대문자, milestone-level 통합)
- 별책 디렉토리: `execute/` (보존)
- 부재 파일: `milestones.md` (## SUB_MILESTONES 흡수)
- 부재 파일 5건: `INTENT.md` / `RESEARCH.md` / `DESIGN.md` / `APPROVE.md` (그 외 VERIFY/REPORT/PROPOSE 도 부재 — H2 섹션 흡수)

## era 분기 구현 (smoke + _era_detect.py)

### tests/_era_detect.py 갱신 (D6)

```python
def detect_era(mdir: Path) -> str:
    # v6.2+ 9-stage-flattened (신규, 검사 순서 우선)
    if re.match(r'^v\d+\.\d+$', mdir.name) and (mdir / "MILESTONE.md").is_file():
        return "9-stage-flattened"
    # v3.0~v6.1 9-stage-bundled (현 분기)
    if re.match(r'^v\d+\.\d+$', mdir.name) and (mdir / "milestones.md").is_file():
        return "9-stage-bundled"
    # 이하 동일
    ...
```

### smoke 4종 era 분기 (D7)

| smoke | 분기 추가 |
|---|---|
| smoke-spec-verification | `era in ("9-stage", "9-stage-bundled")` → `era in ("9-stage", "9-stage-bundled", "9-stage-flattened")` + flattened 시 MILESTONE.md 안 H2 섹션 grep |
| smoke-scope-contract | `era in ("9-stage", "9-stage-bundled")` → flattened 추가 + MILESTONE.md 안 ## INTENT/## APPROVE 안 JSON 추출 |
| smoke-bundle-trigger | regex `^milestones/v[0-9]+\.[0-9]+/milestones\.md$` → `^milestones/v[0-9]+\.[0-9]+/(MILESTONE\.md(#sub-milestones)?\|milestones\.md)$` |
| smoke-open-stage-discipline | 페어링 = `milestones.md` → `(MILESTONE.md OR milestones.md)` |

## cascade host 정전화 (12 host, D9)

| # | host | 갱신 내용 |
|---|---|---|
| 1 | `projects/meta/ARCHITECTURE.md` § 6.1 | 표 4 row → 5 row (9-stage-flattened v6.2+ 신규 row) + flattened era paragraph + 자기참조 부합 paragraph 갱신 (cycle 2번째 적용 narrative) |
| 2 | `CLAUDE.md` (root) | milestone 산출물 narrative — v6.2+ 신규 era 추가 |
| 3 | `projects/meta/CLAUDE.md` | 디렉토리 구조 narrative — v6.2+ flattened era 추가 |
| 4 | `claude/CLAUDE.md` (architecture P1 #1 신규 추가) | PostToolUse + 디렉토리 구성 narrative — v6.2+ flattened era 진화 이력 |
| 5 | `tests/CLAUDE.md` | smoke 매트릭스 5 row narrative (spec-verification / scope-contract / bundle-trigger / open-stage-discipline + posttooluse-hook NOOP) — v6.2+ era 분기 |
| 6 | `claude/commands/harness-meta.md` | Stage A OPEN narrative — v6.2+ era 시 MILESTONE.md ## SUB_MILESTONES 첫 작성 |
| 7 | `tests/_era_detect.py` | 9-stage-flattened 분류 신규 + docstring |
| 8 | `tests/smoke-spec-verification.sh` | era 분기 + H2 grep + JSON 추출 (8 stage 분기 모두 flattened 정합) |
| 9 | `tests/smoke-scope-contract.sh` | era 분기 + H2 grep + JSON 추출 |
| 10 | `tests/smoke-bundle-trigger.sh` | milestones_path regex 갱신 (`_archive/` prefix 보존) |
| 11 | `tests/smoke-open-stage-discipline.sh` | 페어링 era 분기 |
| 12 | `tests/smoke-posttooluse-hook.sh` (architecture P1 #2) + `claude/hooks/post-report-write.sh` (narrative comment) | flattened era 입력 시 NOOP 경로 검증 + post-report-write 안 comment 추가 |

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- era 정책 source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- era 분류 source: [`../../../../tests/_era_detect.py`](../../../../tests/_era_detect.py)
- v6.1 schema source: [`../v6.1/DESIGN.md`](../v6.1/DESIGN.md)
- milestones.md: [`milestones.md`](milestones.md)
