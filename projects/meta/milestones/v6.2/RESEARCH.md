---
id: milestone-artifact-directory-flattening
title: milestone 산출물 디렉토리 평탄화 (단일 파일 통합)
version: v6.2
stage: RESEARCH
status: in_progress
---

# RESEARCH — v6.2

## Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "memory/feedback_anthropic_yaml_frontmatter_pattern", "finding": "Anthropic Claude Code 표준 = YAML frontmatter + Markdown body. v6.1 도입 schema 정합 — MILESTONE.md 안 H2 섹션도 동일 schema 적용 (frontmatter 1건 + H2 9 섹션 안 축소 JSON 코드블록 + Markdown body)."},
    {"id": "ext_2", "source": "context7 (Stage D DESIGN 안 spec-drift agent 추정 검증 — Anthropic CLAUDE.md 단일 파일 vs 디렉토리 패턴)", "finding": "RESEARCH 시점 추정 — Anthropic 공식 patterns 안 CLAUDE.md = 1 repo 1 파일 단일 본책 (디렉토리 부재). agent .md / SKILL.md / hooks 안 1 entity = 1 파일 패턴. 본 milestone (b) 하이브리드 형태 정합."}
  ],
  "codebase": [
    {"id": "cb_1", "file": "tests/_era_detect.py:27-36", "finding": "era 분류 단일 source. 4 era 검사 순서 = 9-stage-bundled (milestones.md 존재) → 9-stage (INTENT+APPROVE+PROPOSE) → 7-stage (PLAN.md or INTENT.md) → skip. v6.2 신규 era 분류 추가 의무 — 검사 순서 우선 = 9-stage-flattened (MILESTONE.md 존재) 첫 검사."},
    {"id": "cb_2", "file": "tests/smoke-spec-verification.sh:222,233", "finding": "9-stage era 시 INTENT.md/APPROVE.md 파일 fp 존재 검증. v6.2+ flattened era = MILESTONE.md 안 H2 섹션 grep 으로 대체. era 분기 의무."},
    {"id": "cb_3", "file": "tests/smoke-scope-contract.sh:164-196", "finding": "detect_era 호출 + 9-stage/9-stage-bundled era 시 INTENT.md/APPROVE.md 검사. v6.2+ flattened era 분기 추가 의무 — MILESTONE.md 안 ## INTENT/## APPROVE H2 섹션 검출."},
    {"id": "cb_4", "file": "tests/smoke-bundle-trigger.sh:99-114", "finding": "ROADMAP milestones[] entry 안 milestones_path 필드 regex 검증 + 실 파일 존재 검증. 현 regex 추정 = `^milestones/v[0-9]+\\.[0-9]+/milestones\\.md$`. v6.2+ flattened era = `milestones/v6.2/MILESTONE.md#sub-milestones` (anchor 포함) 또는 `milestones/v6.2/MILESTONE.md` — anchor 허용 regex 갱신 의무."},
    {"id": "cb_5", "file": "tests/smoke-open-stage-discipline.sh:44,64-69", "finding": "9-stage-bundled era 표지 = 디렉토리 명 `^v\\d+\\.\\d+$` + milestones.md 존재. v6.2 = milestones.md 부재 → 현 smoke FAIL 발생. 분기 추가 의무 — `MILESTONE.md` 존재 시 9-stage-flattened era 인정 (별도 분기 PASS)."},
    {"id": "cb_6", "file": "claude/hooks/post-report-write.sh:177,179", "finding": "REPORT.md/REPORT.ipynb basename 매칭 시 PROPOSE 작성 안내 inject. v6.2 = MILESTONE.md 안 ## REPORT 섹션 추가 시 동일 trigger 필요. hook 안 era 분기 = (a) MILESTONE.md edit 시 + ## REPORT 섹션 신규 추가 검출 또는 (b) 단순 era 분기 부재 — MILESTONE.md edit 안 신규 ## REPORT 섹션 출현 시 trigger (구현 복잡도 trade-off DESIGN 안 결정)."},
    {"id": "cb_7", "file": "projects/meta/ARCHITECTURE.md:195-218", "finding": "§ 6.1 era 정책 표 4 row (9-stage-bundled / 9-stage / 7-stage / 4-tier) + bundling 정책 paragraph + 자기참조 부합 paragraph + breaking change paragraph + era 영구화 trade-off paragraph. v6.2+ 5번째 row 신규 추가 + 자기참조 부합 cycle 2번째 적용."},
    {"id": "cb_8", "file": "CLAUDE.md (root) — milestone 산출물 narrative", "finding": "현 narrative = '산출물 ... 은 Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body) 포맷 의무 (v6.1+ 신규 schema)'. v6.2+ flattened era 추가 cascade — '... v6.2+ 신규 era = MILESTONE.md 단일 파일 + execute/phase-{n}.md 별책'."},
    {"id": "cb_9", "file": "projects/meta/CLAUDE.md — milestone 산출물 narrative", "finding": "현 narrative = '`milestones/v{X.Y}/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `milestones.md` + `execute/phase-{n}.md`'. v6.2+ era 추가 cascade — 'v6.2+ flattened era: `milestones/v{X.Y}/MILESTONE.md` + `execute/phase-{n}.md`'."},
    {"id": "cb_10", "file": "tests/CLAUDE.md — smoke 매트릭스", "finding": "smoke-spec-verification + smoke-scope-contract + smoke-open-stage-discipline 행 narrative 갱신 (v6.2+ era 검증 추가). bundle-trigger 행은 milestones_path regex 갱신."},
    {"id": "cb_11", "file": "claude/commands/harness-meta.md — workflow stage narrative", "finding": "Stage A OPEN step 안 'milestones/v{X.Y}/milestones.md 스켈레톤 즉시 작성' narrative. v6.2+ era 분기 — MILESTONE.md 안 ## SUB_MILESTONES 섹션 첫 작성."}
  ],
  "options": [
    {"id": "opt_1", "name": "(opt-A) 단순 era 분기 (v3.0~v6.1 보존 + v6.2~ 신규)", "summary": "_era_detect.py 안 9-stage-flattened 분류 신규 추가 (검사 순서 우선) + 4 smoke era 분기 + 5 narrative cascade. 추정 작업량 11 host 갱신.", "pros": ["era 분기 자연 확장 + (1) 신규만 결정 정합", "v3.0~v6.1 디렉토리 era 완전 보존 (정보 손실 0)"], "cons": ["smoke 분기 복잡도 누적 (forward-only trade-off 직접 비용, ARCHITECTURE § 6.1 명시)"]},
    {"id": "opt_2", "name": "(opt-B) glob 별 분기 (디렉토리 detect)", "summary": "era 분기 대신 each milestone 디렉토리 안 MILESTONE.md vs 개별 파일 존재 검사 glob 직접 처리.", "pros": ["era 분류 logic 우회"], "cons": ["era 분류 단일 source (_era_detect.py) 부정 — 책임 분리 깨짐", "smoke 마다 중복 로직", "ARCHITECTURE § 6.1 narrative 4 row 표 깨짐"]},
    {"id": "opt_3", "name": "(opt-C) version 비교 분기 (v6.2 hardcode)", "summary": "directory 이름 v6.2 이상 = flattened era 가정. 검사 logic 단순.", "pros": ["가장 단순"], "cons": ["사용자 결정 (3) (1) 신규만 정합 안 함 — v6.2~ '신규 milestone 만' 의도가 'v6.2+ 모든 디렉토리' 로 변질", "v6.2 자체 도그푸드 retrofit 시점 (phase-2) 안 짧은 기간 era 모호", "future schema migration 시 hardcode 누적"]}
  ],
  "risks_identified": [
    {"id": "r_1", "description": "정보 손실 — Stage A~E 개별 파일 작성 후 phase-2 안 MILESTONE.md 통합 시 H2 섹션 경계 misalignment 가능", "mitigation": "Stage D DESIGN 안 통합 procedure 명시 (YAML frontmatter 1건 + 각 stage 산출물 1 H2 섹션 매핑 + 코드블록 fenced ```json 보존)"},
    {"id": "r_2", "description": "smoke 회귀 — era 분기 신규 logic 안 v3.0~v6.1 28 milestone PASS 유지 검증", "mitigation": "controlled 비교 패턴 (tests/CLAUDE.md v2.1 L3) 적용 — commit 전후 동일 milestone set 입력 동치 검증"},
    {"id": "r_3", "description": "외부 visible artifact drift — CHANGELOG.md [v6.2] entry 안 잘못된 link", "mitigation": "Stage I PROPOSE 안 cross-ref 정합 검증"},
    {"id": "r_4", "description": "post-report-write hook trigger 모호 — MILESTONE.md 안 ## REPORT 섹션 추가 검출 logic", "mitigation": "Stage D DESIGN 안 hook 분기 결정 — 가장 단순 = MILESTONE.md edit 시 trigger 부재 (era 분기 skip), 사용자 manual 진행. 단순함 vs 자동화 trade-off."},
    {"id": "r_5", "description": "smoke-bundle-trigger milestones_path regex 안 anchor (#sub-milestones) 허용 시 false-positive — 다른 anchor 도 통과", "mitigation": "regex 엄격 = `^milestones/v[0-9]+\\.[0-9]+/MILESTONE\\.md(#sub-milestones)?$` 또는 = `^milestones/v[0-9]+\\.[0-9]+/(MILESTONE\\.md(#sub-milestones)?|milestones\\.md)$` (era 양립)."}
  ]
}
```

## 코드베이스 grep 결과 정리

### era 분류 단일 source

- `tests/_era_detect.py:27-36` — 4 era (9-stage-bundled / 9-stage / 7-stage / skip) 검사 순서 정의. 9-stage-flattened 신규 era 추가 시 검사 순서 우선 변경 의무 (MILESTONE.md 검사 = milestones.md 검사 직전).

### smoke 4종 영향

| smoke | 현 era 분기 | v6.2+ flattened era 갱신 |
|---|---|---|
| smoke-spec-verification | 모든 milestone fp 존재 검증 (era 분기 부재, detect_era 호출 미사용 결정 후) | MILESTONE.md 안 H2 섹션 grep 추가 |
| smoke-scope-contract | detect_era 호출 + 9-stage/9-stage-bundled era 시 INTENT.md/APPROVE.md 검사 | flattened era 분기 추가 |
| smoke-bundle-trigger | milestones_path regex 검증 (`^milestones/v[0-9]+\\.[0-9]+/milestones\\.md$` 추정) | anchor 허용 + MILESTONE.md filename 양립 regex |
| smoke-open-stage-discipline | 9-stage-bundled era 표지 = 디렉토리 명 + milestones.md 페어링 | flattened era 표지 = 디렉토리 명 + MILESTONE.md 페어링 분기 추가 |

### narrative cascade host (5건)

1. `projects/meta/ARCHITECTURE.md` § 6.1 — 표 4 row → 5 row + 새 era paragraph
2. `CLAUDE.md` (root) — milestone 산출물 narrative
3. `projects/meta/CLAUDE.md` — 디렉토리 구조 narrative
4. `tests/CLAUDE.md` — smoke 매트릭스 4 row narrative
5. `claude/commands/harness-meta.md` — Stage A OPEN narrative (MILESTONE.md ## SUB_MILESTONES 첫 작성)

### hook (1건)

- `claude/hooks/post-report-write.sh:177-179` — REPORT_BASENAME 매칭 inject. v6.2+ era 분기 결정 = Stage D DESIGN 안.

## Options 비교

| opt | 책임 분리 | 단일 source 보존 | 사용자 결정 정합 | 작업량 |
|---|---|---|---|---|
| (opt-A) era 분기 | 정합 | 정합 | 정합 | 11 host |
| (opt-B) glob 별 분기 | **위배** (era 단일 source 부정) | **위배** | 모호 | 4 smoke + 5 narrative |
| (opt-C) version hardcode | 정합 | 정합 | **위배** (3 (1) 신규만 의도 변질) | 4 smoke |

**추천**: (opt-A) era 분기 — 사용자 결정 (3) (1) 신규만 정합 + era 단일 source 보존 + ARCHITECTURE § 6.1 forward-only 정책 일관.

## Risks 요약

5 위험 (r_1~r_5). 가장 큰 = r_1 (정보 손실, Stage D DESIGN 안 통합 procedure 명시 의무) + r_2 (smoke 회귀, controlled 비교 패턴 적용).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- era 정책 source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- era 분류 source: [`../../../../tests/_era_detect.py`](../../../../tests/_era_detect.py)
- v6.1 schema source: [`../v6.1/DESIGN.md`](../v6.1/DESIGN.md) (Anthropic 정합 하이브리드)
- memory: `feedback_anthropic_yaml_frontmatter_pattern` (RESEARCH 외부 source 보강)
- milestones.md: [`milestones.md`](milestones.md)
