# RESEARCH — v3.15 changelog-v3-backfill

```json
{
  "external": [
    {
      "source": "Keep a Changelog v1.1.0 (https://keepachangelog.com/en/1.1.0/)",
      "topic": "version entry 포맷 + 카테고리",
      "findings": "헤더 `## [vX.Y] - YYYY-MM-DD` (breaking 은 `## [vX.Y]! - YYYY-MM-DD` — 현 repo convention, L7 narrative `! after a version marker denotes a breaking change`). 카테고리: Added / Changed / Deprecated / Removed / Fixed / Security. 본 repo 는 Performance 추가 카테고리 사용 (v2.1 entry L11 선례). [Unreleased] 섹션 최상단 권장 (현 파일 L37 v2.0 아래 위치 = 권장 위반이나 본 milestone scope 외 — 단 신규 v3.x entry 삽입 위치 결정 필요).",
      "drift": "현 [Unreleased] 위치 (L37, v2.0 아래) 가 Keep a Changelog 권장 위반. 본 milestone scope 외 narrative — DESIGN 단계에서 v3.x 신규 entry 삽입 위치 결정 시 [Unreleased] 처리 방안 옵션 결정."
    },
    {
      "source": "SemVer (https://semver.org/)",
      "topic": "본 repo 적용 범위",
      "findings": "L5 narrative — `.harness.toml` schema 레벨 SemVer 적용 (repo 자체 버전 아님). v3.0 milestone hierarchy 재구성은 schema 레벨 breaking 아니지만 milestone trace 구조 breaking → ROADMAP entry summary L149 `breaking change → major bump (v2 → v3)` narrative 정합. CHANGELOG entry 도 `!` 마커 부합.",
      "drift": "없음 — v2.0 선례 (`## [v2.0]! - 2026-05-10` L21) 와 동일 패턴."
    }
  ],
  "codebase": {
    "affected_files_explicit": [
      "CHANGELOG.md (단일 backfill 대상)"
    ],
    "untouched_files_explicit": [
      "projects/meta/ROADMAP.md (entry 추가 외 narrative 변경 부재, source 인용만)",
      "projects/meta/ARCHITECTURE.md (era 정책 § 6.1 / 동결 § 6.2 현행 보존)",
      "projects/meta/milestones/v3.0~v3.14/REPORT.md (1차 source 참조만, 본문 변경 부재)",
      "projects/meta/milestones/v3.0~v3.14/ROADMAP entry summary (1차 source 참조만)",
      "claude/commands/harness-meta.md (workflow narrative 보존, § 6.2 동결)",
      "tests/* smoke (회귀 검증만)"
    ],
    "current_state": "CHANGELOG.md 149 lines. 헤더 (L1-7) + v2.1 (L9-19, 2026-05-10) + v2.0 BREAKING (L21-35, 2026-05-10) + [Unreleased] (L37-45, 5 항목 v1.x~v2.0 사이 인프라) + v1.14 (L47) ~ v1.0-v1.4 (L143-149). v3.0~v3.14 entry 부재.",
    "target_state": "헤더 (L1-7) + v3.x 13~14 entry 신규 (역순: v3.14 최신 → v3.0 BREAKING `!`) + 기존 v2.1/v2.0/[Unreleased]/v1.x entry 보존. 총 LOC ~290~320 예상 (13 entry × 평균 ~10~13 lines).",
    "source_map": {
      "v3.14": "ROADMAP L11-18 (deferred-revaluation-cycle-2, AND FAIL verdict, lightweight 모드 단일 phase 1 commit f50ad5d)",
      "v3.13": "ROADMAP L20-28 (pending-milestone-renumber-policy, v1.x pending → deferred + § 6.2 적용)",
      "v3.12": "ROADMAP L30-37 (deprecated-skill-narrative-cleanup, SKILL.md 9건 일괄)",
      "v3.11": "ROADMAP L39-47 (legacy-narrative-cleanup, claude/CLAUDE.md + upbit ARCHITECTURE.md + CHANGELOG.md L3 era 카테고리)",
      "v3.10": "ROADMAP L49-56 (stage-byproduct-clarification, Stage B/C/D 부산물 정의 + PROPOSE 흡수)",
      "v3.9":  "ROADMAP L58-65 (inactive-smoke-git-mv-checklist, tests/CLAUDE.md 체크리스트 4단계)",
      "v3.8":  "ROADMAP L67-74 (inactive-smoke-cd-path-fix, 8 파일 ../.. 일괄)",
      "v3.7":  "ROADMAP L76-84 (smoke-posttooluse-9stage-tests, Tests T/U/V 25/25 PASS)",
      "v3.6":  "ROADMAP L113-120 (overengineering-audit, lightweight 모드 + § 6.2 동결 정책 도입 + tests/_inactive/ 22 archive)",
      "v3.5":  "ROADMAP L104-111 (open-stage-discipline-strengthening, smoke-open-stage-discipline + Stage D 동기)",
      "v3.4":  "ROADMAP L95-102 (open-stage-milestones-md-protocol, Stage A step 7 신규)",
      "v3.3":  "ROADMAP L86-93 (ci-inactive-smoke-cleanup, CI glob → active 6 명시)",
      "v3.2":  "ROADMAP L122-129 (workflow-narrative-strengthening, Stage F / cp949 / Skeleton)",
      "v3.1":  "ROADMAP L131-143 (workflow-policy-fine-tuning, markdownlint trap + milestones.md + smoke-bundle-trigger)",
      "v3.0":  "ROADMAP L145-158 (milestones-restructure, BREAKING `!` major bump, v2.2_* 4건 흡수)"
    },
    "ordering": "역순 (Keep a Changelog 권장) — v3.14 최신 → v3.0 BREAKING. v2.1 (현 최상단 = L9) 위에 13~14 entry 삽입."
  },
  "options": [
    {
      "id": "A",
      "name": "전체 13 entry 풀 backfill + [Unreleased] 보존",
      "approach": "v3.0~v3.14 13 entry 모두 신규 작성. [Unreleased] 섹션 현 위치 (L37 v2.0 아래) 보존 — Keep a Changelog 권장 위반 narrative drift 는 본 milestone scope 외. 신규 entry 는 v2.1 위에 삽입.",
      "pros": "외부 visible artifact 정전 (milestone 1:1 entry 매핑). scope 명확. § 6.2 lightweight cap 부합 가능 (각 entry ~5~10 lines).",
      "cons": "[Unreleased] 위치 권장 위반 잔존 (단 본 milestone 도입 부재, 기존 drift 보존)."
    },
    {
      "id": "B",
      "name": "주요 milestone 만 backfill (v3.0/v3.6/v3.14)",
      "approach": "BREAKING (v3.0) + 정책 도입 (v3.6) + 최신 verdict (v3.14) 3 entry 만 backfill. 나머지 11 entry 는 'v3.1~v3.13 incremental' 묶음 entry 1건으로 압축.",
      "pros": "LOC cap 가장 슬림 (~50 lines 추가).",
      "cons": "외부 visible 정전 부족 — 사용자가 11 milestone trace 가 어떻게 진화했는지 불투명. milestone 1:1 매핑 원칙 위반."
    },
    {
      "id": "C",
      "name": "단일 'v3 era' 큰 entry 통합 (date range)",
      "approach": "`## [v3.0~v3.14]! - 2026-05-10 ~ 2026-05-13` 단일 entry — narrative 압축.",
      "pros": "가장 짧음.",
      "cons": "milestone 1:1 매핑 원칙 위반 + SemVer 정합 narrative 위반 + Keep a Changelog 규약 위반. 강제 회피."
    }
  ],
  "risks_identified": [
    {
      "risk": "pre-commit markdownlint MD040 (fenced code lang) 위반",
      "likelihood": "low",
      "impact": "low",
      "evidence": "CHANGELOG.md 현 패턴은 fenced code block 부재 (bullet list 만). 위반 가능성 낮음."
    },
    {
      "risk": "entry summary 너무 길어 § 6.2 narrative cap 위반",
      "likelihood": "medium",
      "impact": "medium",
      "evidence": "ROADMAP entry summary 가 평균 ~300 chars. 풀 인용하면 ~4000 chars × 13 entry = 매우 큰 LOC. CHANGELOG 는 외부 visible 압축 narrative 가 적합 — 각 entry ~5~10 bullet 으로 압축 의무."
    },
    {
      "risk": "[Unreleased] 위치 권장 위반 노출",
      "likelihood": "high",
      "impact": "low",
      "evidence": "현 [Unreleased] L37 (v2.0 아래) 가 Keep a Changelog 권장 위반. 본 milestone scope 외 narrative — DESIGN 단계에서 명시적으로 'out_of_scope 보존' 처리 narrative 강조 필요."
    },
    {
      "risk": "Source 1차 인용 시 ROADMAP entry summary narrative drift 위험",
      "likelihood": "low",
      "impact": "medium",
      "evidence": "REPORT.md 1차 source 와 ROADMAP summary 가 일치하는지 검증 부담. 단 본 milestone 은 ROADMAP summary 만 인용 (lightweight 모드 정합) — REPORT 재해석 회피."
    },
    {
      "risk": "v3.6 의 § 6.2 동결 정책 narrative 가 CHANGELOG 안 잘못 표현",
      "likelihood": "low",
      "impact": "medium",
      "evidence": "§ 6.2 는 workflow self-improvement 동결 정책 — CHANGELOG entry 가 본 정책을 'workflow 변경' 으로 잘못 표현하면 § 6.2 자기참조 위반 narrative drift. 'Added: ARCHITECTURE § 6.2 동결 정책 narrative' 식으로 정전화 (정책 도입 narrative 한정)."
    },
    {
      "risk": "v3.0 BREAKING `!` 마커 누락",
      "likelihood": "low",
      "impact": "high",
      "evidence": "v3.0 milestone 자체가 v2→v3 major bump breaking change. ROADMAP L149 narrative 명시 — CHANGELOG entry 헤더 `[v3.0]!` 의무. v2.0 선례 (L21) 패턴 정합."
    }
  ]
}
```

## 부가 narrative

- **lightweight 모드 산출물 LOC cap 정합**: § 6.2 narrative cap 정책 — CHANGELOG entry 13건 × 평균 ~10 lines = ~130 LOC 추가 (현 149 → ~280). 본 milestone 산출물 자체 LOC (INTENT + RESEARCH + DESIGN + APPROVE + VERIFY + REPORT + PROPOSE) 는 cap 850 LOC 미만 권장.

- **Source 인용 정전**: 각 CHANGELOG entry 는 ROADMAP entry `summary` 의 핵심 narrative 만 압축 — REPORT.md 1차 source 는 commit hash 와 정량 결과 (smoke / 회귀 / hook count) 만 인용. milestone 안 부산물 narrative drift 회피.

- **out_of_scope 부산물 정책** (v3.10): RESEARCH `untouched_files_explicit` + `risks_identified` 안 entry 들은 (a) 본 milestone 의 영향 부재 파일 / 식별 risk 의 사실 진술만. 후속 candidates 발의는 Stage I (PROPOSE) 단일 책임.

## 관련

- 상위 컨테이너: [`milestones.md`](milestones.md)
- 선행 stage: [`INTENT.md`](INTENT.md)
- 후행 stage: [`DESIGN.md`](DESIGN.md) (Stage D 작성 후)
- 단일 source: [`../../../../CHANGELOG.md`](../../../../CHANGELOG.md), [`../../ROADMAP.md`](../../ROADMAP.md)
