---
id: archival-mechanism-reconciliation
title: archival 메커니즘 드리프트 해소 및 재발방지 강제 신설
version: v8.13
status: open
---

# v8.13 — archival 메커니즘 드리프트 해소 및 재발방지 강제 신설

> **OPEN 시점 진단 요약** (Stage B INTENT 에서 정식화) — v8.12 후속 부수 발견 origin (사용자 명시 큰 건 결정, 2026-05-27). archival = 두 반쪽 (① milestones[] recent 3 trim + ② 잘라낸 entry 영구 보존). v6.19 가 보존 대상을 CHANGELOG.md → GitHub Releases 로 의도적 이전 (commit marker `[release:v{X.Y}]` → workflow 자동 발행). 실측 드리프트: (a) GitHub Releases 발행이 v8.6 까지만 — v8.7~v8.12 (6건) 누락 (marker 미사용) / (b) milestones[] trim 이 v6.19 경부터 멈춤 → 현재 16건 누적 (recent 3 = v8.12/v8.11/v8.10 이어야 함) / (c) hook(post-report-write.sh:178) + ROADMAP schema_note + ARCHITECTURE(§3.3, §6.1 영역) + CLAUDE.md 가 아직 'CHANGELOG.md archival' 로 stale (v6.19 이후 보존 대상은 GitHub Releases) / (d) milestones[] 길이 강제 smoke 부재 → 드리프트 무탐지 (smoke 512건 통과). 근본 원인 = archival 이 9-stage PROPOSE 수동 작업인데 가벼운 흐름엔 PROPOSE 부재 + v6.2 평탄화로 MILESTONE.md hook NOOP (reminder 사망) + 강제 smoke 부재 → v8.6 이후 트랙 무관 누락.

## INTENT

### Spec

```json
{
  "id": "archival-mechanism-reconciliation",
  "title": "archival 메커니즘 드리프트 해소 및 재발방지 강제 신설",
  "goal": "archival 메커니즘의 4겹 드리프트(stale 문서 + 미발행 6건 + milestones[] 16건 누적 + 강제 smoke 부재)를 실 데이터까지 catch-up 으로 해소하고, 두 트랙(9-stage/가벼운 흐름) 모두에 재발방지 강제(① 길이 smoke + ② 트랙별 archival trigger 명문화)를 신설한다.",
  "motivation": "v8.12 후속 부수 발견 origin (사용자 명시 큰 건 결정 — smoke 판정 재설계 = 큰 건, 2026-05-27). archival = 두 반쪽(① milestones[] recent 3 trim + ② 잘라낸 entry 영구 보존). v6.19 가 보존 대상을 CHANGELOG.md → GitHub Releases 로 의도적 이전(commit marker [release:v{X.Y}] → release-publish.yml 자동 발행). 실측 드리프트: (a) GitHub Releases 발행이 v8.6 까지만 — v8.7~v8.12 6건 누락. INTENT 재개 중 추가 검출: 누락 6건 중 가벼운 흐름 3건(v8.7/v8.10/v8.12)은 marker 누락이 아니라 release-publish.yml 이 development/milestones/v{X.Y}/MILESTONE.md ## REPORT 추출만 하고 LIGHTWEIGHT.md 를 못 잡는 구조적 구멍(workflow line 83·98) — v8.1 두 트랙 공존 미반영. 9-stage 3건(v8.8/v8.9/v8.11)은 marker 누락. (b) milestones[] trim 이 v6.19 경부터 멈춰 16건 누적(recent 3 = schema_note 규칙). (c) hook(post-report-write.sh:178) + ROADMAP schema_note + ARCHITECTURE(§3.3,§6.1) + CLAUDE.md 가 아직 'CHANGELOG.md archival' stale. (d) milestones[] 길이 강제 smoke 부재 → 드리프트 무탐지(smoke 512건 통과). 근본 = archival 이 PROPOSE 수동 작업인데 가벼운 흐름엔 PROPOSE 부재 + v6.2 평탄화로 MILESTONE.md hook NOOP + 강제 smoke 부재.",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "stale 문서 정합 — hook(post-report-write.sh:178) + ROADMAP schema_note + ARCHITECTURE(§3.3,§6.1) + CLAUDE.md 의 'CHANGELOG.md archival' 표현이 RESEARCH/DESIGN 에서 확정한 단일 보존 target 으로 일관 갱신(잔존 stale grep 0건)."
    },
    {
      "id": "sc_2",
      "criterion": "milestones[] trim catch-up — development/ROADMAP.md milestones[] 의 completed entry 가 schema_note 규칙(recent 3)에 부합(현재 16건 → trim 완료, 잘라낸 entry 는 확정 target 에 영구 보존)."
    },
    {
      "id": "sc_3",
      "criterion": "미발행 catch-up — RESEARCH ext_2 실측으로 정정(OPEN 추정 6건 → 실 10건): milestones[] completed 중 GitHub Release 누락 10건(가벼운 흐름 6건 v8.2/v8.3/v8.5/v8.7/v8.10/v8.12 + 9-stage 4건 v8.4/v8.8/v8.9/v8.11)이 확정 target 에 모두 발행 완료. 발행 후 gh release list 대조 누락 0건."
    },
    {
      "id": "sc_4",
      "criterion": "재발방지 smoke 신설 — milestones[] completed entry 수가 recent 3 초과 시 FAIL 하는 smoke 신설 + 현 상태 PASS + 위반 fixture 로 FAIL 실증."
    },
    {
      "id": "sc_5",
      "criterion": "트랙별 archival trigger 명문화 — 9-stage(PROPOSE 시점) + 가벼운 흐름(## 기록 시점) 양 트랙의 archival 의무 시점이 1차 source(ARCHITECTURE + CLAUDE.md)에 명문화(가벼운 흐름 PROPOSE 부재 구멍 해소)."
    },
    {
      "id": "sc_6",
      "criterion": "전체 smoke PASS — 신설 smoke 포함 회귀 0(기존 512건 + 신설 무손상)."
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "③ hook reminder 부활(post-report-write.sh archival reminder MILESTONE.md/LIGHTWEIGHT.md 두 트랙 재발화) — 사용자 결정 제외. soft 알림 보조라 ①smoke + ②trigger 명문화로 재발 구조적 차단 충분. 재발 관측 시 후속 candidate."
    },
    {
      "id": "oos_2",
      "item": "외부 적용(upbit/price-compare 등) ROADMAP 의 archival 정합 — 본 milestone 은 meta 자체(development/ROADMAP.md) archival 만. 외부 project ROADMAP 은 별 트랙."
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "v6.19_changelog-github-releases-migration (CHANGELOG.md → GitHub Releases 보존 대상 이전)",
      "purpose": "본 milestone 이 해소할 stale 문서 드리프트의 origin + RESEARCH 의 target 방향 판단(유지 vs reverse) 입력. release-publish.yml [release:v] marker 워크플로우 본체."
    },
    {
      "id": "dep_2",
      "ref": "v8.1_meta-lightweight-flow-design (두 트랙 공존 도입)",
      "purpose": "가벼운 흐름 PROPOSE 부재가 archival trigger 구멍의 구조적 원인 — sc_5 트랙별 trigger 명문화의 직접 대상. release-publish.yml 의 LIGHTWEIGHT.md 미지원 구조적 구멍도 동일 origin."
    },
    {
      "id": "dep_3",
      "ref": "development/ROADMAP.md schema_note (milestones[] recent 3 규칙) + ARCHITECTURE §3.3/§6.1",
      "purpose": "sc_2 trim 기준 + sc_4 smoke 판정 기준의 1차 source. sc_1 stale 정합의 갱신 대상."
    }
  ]
}
```

### Narrative

본 milestone 은 v8.12 종료 후 pre-PLAN 검토에서 드러난 부수 발견을 사용자 명시 큰 건 결정으로 격상한 것이다 (smoke 판정 재설계 = 컨설팅 자산 영향, ARCHITECTURE § 7.4 승격 기준 정합 → 9-stage). archival 은 **두 반쪽** — milestones[] 를 recent 3 으로 trim + 잘라낸 entry 를 영구 보존 — 인데, v6.19 가 보존 대상을 CHANGELOG.md 에서 GitHub Releases 로 의도적 이전한 이후 양 반쪽 모두 v8.6 경부터 멈췄다.

INTENT 재개 중 OPEN 진단에 없던 **구조적 사실** 하나를 추가 검출했다: 미발행 6건이 단일 원인이 아니다. release-publish.yml 은 `MILESTONE.md` 의 `## REPORT` 섹션만 추출하므로(workflow line 83·98), `LIGHTWEIGHT.md` 만 산출하는 가벼운 흐름 3건(v8.7/v8.10/v8.12)은 워크플로우가 **구조적으로 발행 불가** — v8.1 두 트랙 공존이 발행 메커니즘에 반영 안 됨. 나머지 9-stage 3건(v8.8/v8.9/v8.11)만 marker 누락이 원인이다. 이 발견이 sc_5(트랙별 archival trigger 명문화)와 sc_3(catch-up 6건)의 본질 — 가벼운 흐름 PROPOSE 부재가 archival 의무 시점을 비워둔 구조적 구멍이다.

**핵심 결정 (pre-PLAN round 누적):**

- 보존 target 방향(GitHub Releases 유지 vs CHANGELOG.md 복귀)은 v6.19 milestone 결정의 reverse 여부가 걸린 큰 분기라 **RESEARCH/DESIGN 으로 이관** — INTENT 는 'archival 드리프트 해소 + catch-up + 재발방지'만 commit, target 방향 미확정. 따라서 sc_1/sc_2/sc_3 모두 "확정한 단일 보존 target" 으로 표현(목표 무손상, HOW 는 후속 stage).
- catch-up 은 **전부 실행** — milestones[] 16→recent 3 trim + 미발행 보존(OPEN 추정 6건 → RESEARCH ext_2 실측 10건, sc_3)을 EXECUTE 에서 실수행해 드리프트를 실 데이터로 0 으로 만든다 (메커니즘/문서만 고치고 데이터 catch-up 을 후속으로 미루지 않음).
- 재발방지는 **① milestones[] 길이 강제 smoke + ② 트랙별 archival trigger 명문화** 2개 — ①이 trim 드리프트를 정적으로 강제하고 ②가 가벼운 흐름 PROPOSE 부재 구멍을 메운다. ③ hook reminder 부활은 soft 보조라 사용자 결정으로 제외(oos_1).

scope 본질 = meta 자체(development/ROADMAP.md) archival 만, 외부 project ROADMAP 은 별 트랙(oos_2).

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "CHANGELOG.md (repo) — ## [v6.19] entry + 끝 note",
      "finding": "v6.19 가 archival 보존 대상을 CHANGELOG.md → GitHub Releases 로 이전한 **사유 = CHANGELOG.md SIZE_LIMIT 회귀** (v6.18 evidence 99998 bytes / 100000 -2 한계). 시간 분기 3 era 명시 — v1.0~v5.21 archived 1줄 단축 / v6.0~v6.18 본문 잔존 / **v6.20+ = GitHub Releases 단일 source**. v6.19 entry 끝 note 직접 인용: '본 entry = CHANGELOG.md 안 last full entry (hybrid 분기 marker). v6.20+ release note = GitHub Releases 단일 source. CHANGELOG.md 안 entry 추가 단속'. → CHANGELOG.md 복귀는 SIZE_LIMIT 회귀를 재도입 + v6.19 milestone 결정 reverse 본질."
    },
    {
      "id": "ext_2",
      "source": "gh release list --limit 50 (실 발행 목록) vs development/ROADMAP.md milestones[] completed 대조",
      "finding": "실 발행 release = 10건 (v6.19/v6.20/v6.21/v6.22/v6.23/v7.0/v7.1/v8.0/v8.1/v8.6) — **불연속** (v8.2~v8.5 건너뜀). milestones[] completed 16건 중 release 누락 = **10건** (OPEN 진단 6건은 과소집계). 누락 트랙 분류: 가벼운 흐름 6건 (v8.2/v8.3/v8.5/v8.7/v8.10/v8.12, release-publish.yml 구조적 발행 불가) + 9-stage 4건 (v8.4/v8.8/v8.9/v8.11, marker 누락만). 발행이 v8.6 에서 '멈춘' 게 아니라 v8.1 직후부터 산발적 — 가벼운 흐름은 사실상 한 번도 안정 발행된 적 없음."
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": ".github/workflows/release-publish.yml:83,98",
      "finding": "워크플로우가 MILESTONE_PATH='development/milestones/${VERSION}/MILESTONE.md' 만 locate (line 83, 부재 시 exit 1) + awk '/^## REPORT/.../^## PROPOSE/' 로 ## REPORT 섹션 추출 (line 98). LIGHTWEIGHT.md (가벼운 흐름 산출물, ## 기록 섹션) 미지원 → 가벼운 흐름 6건 구조적 발행 불가. trigger = commit msg [release:v{X.Y}] marker (line 34,52) 또는 workflow_dispatch (version input, line 12~22). 과거 merged 커밋도 workflow_dispatch 로 발행 가능."
    },
    {
      "id": "cb_2",
      "ref": "claude/hooks/post-report-write.sh:178 (PROPOSE case)",
      "finding": "PROPOSE hook 메시지 stale: 'archival cycle (completed > 3 시 가장 오래된 entry CHANGELOG.md 이전)'. (a) 보존 대상이 CHANGELOG.md stale (v6.20+ = GitHub Releases) + (b) MILESTONE.md(v6.2 평탄화) 작성은 FILE_TYPE=REPORT 분기로 안 가 PROPOSE 메시지 미발화 NOOP + (c) 가벼운 흐름엔 PROPOSE 자체 부재."
    },
    {
      "id": "cb_3",
      "ref": "CLAUDE.md:34,68 + development/ARCHITECTURE.md:219 + development/ROADMAP.md schema_note",
      "finding": "operational 현재-지침 stale 4곳 — 모두 '과거 completed entry archival = CHANGELOG.md' (v6.20+ GitHub Releases 미반영). 단 ARCHITECTURE 156/166/179/199 (v5.21 drift 해소 사례 + #13 row + migration paragraph) 은 **historical 기술 서술로 정확** → 변경 금지 (cascade host 분리). cascade grep 3 형식 (relative/절대/anchor) 적용 — 본 enumerate 는 Grep content 매칭이라 path form 무관 cover."
    },
    {
      "id": "cb_4",
      "ref": "tests/smoke-*.sh (13건) + tests/CLAUDE.md",
      "finding": "milestones[] 길이/completed 개수 강제 smoke 부재 (13건 중 무) → 16건 누적이 smoke 512+건 통과하며 무탐지. 신설 위치 = tests/smoke-roadmap-archival.sh (가칭) + pre-commit 등재 (smoke-entry-title-guideline 패턴, ARCHITECTURE §본문 313 정합). 판정 = development/ROADMAP.md milestones[] 안 status=='completed' 개수 ≤ 3 (recent 3, schema_note 규칙). in_progress/deferred 제외 필수."
    },
    {
      "id": "cb_5",
      "ref": "development/milestones/v8.{2,3,5,7,10,12}/LIGHTWEIGHT.md (## 기록)",
      "finding": "가벼운 흐름 6건 모두 LIGHTWEIGHT.md 4 섹션 (## 문제/## 결정/## 적용/## 기록) 보유 (smoke 확인). ## 기록 섹션이 release body source 후보 — release-publish.yml LIGHTWEIGHT.md 분기 시 ## 기록 추출 (MILESTONE.md ## REPORT 동치 역할)."
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "[채택] 보존 target = GitHub Releases 유지 + fix-forward",
      "rationale": "ext_1 — v6.19 가 CHANGELOG SIZE_LIMIT 회귀 때문에 의도적 이전. 복귀 = 그 회귀 재도입 + v6.19 milestone reverse. fix-forward = (a) stale 4곳을 GitHub Releases 로 정합 (b) release-publish.yml LIGHTWEIGHT.md ## 기록 분기 추가 (c) 누락 10건 catch-up 발행. 단일 source 유지 (memory feedback_token_efficiency_priority 정합)."
    },
    {
      "id": "opt_2",
      "label": "[폐기] CHANGELOG.md 복귀",
      "rationale": "stale 문서 다수가 CHANGELOG 가리키니 차라리 복귀 — 그러나 ext_1 SIZE_LIMIT 회귀 재도입 + v6.19 milestone 결정 reverse (큰 비용). 폐기."
    },
    {
      "id": "opt_3",
      "label": "[폐기] 트랙별 target 이원화 (9-stage→Releases / 가벼운→CHANGELOG)",
      "rationale": "워크플로우 가벼운 흐름 미지원을 우회하는 안이나, 보존 target 이 트랙별로 갈려 단일 source 파괴 + 조회 혼란. workflow LIGHTWEIGHT.md 분기 1개 추가 (opt_1 b) 가 더 단순. 폐기."
    },
    {
      "id": "opt_4",
      "label": "[채택 후보] 누락 catch-up 발행 방식 — workflow_dispatch (9-stage 4건) + workflow LIGHTWEIGHT 분기 수리 후 dispatch (가벼운 6건)",
      "rationale": "9-stage 4건은 워크플로우 현행으로 workflow_dispatch(version input) 발행 가능. 가벼운 6건은 release-publish.yml LIGHTWEIGHT.md 분기 수리(opt_1 b) 선행 후 dispatch. 수동 gh release create 대비 워크플로우 경유가 재발방지(향후 가벼운 흐름 자동 발행)와 동시 충족. DESIGN 확정."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "trim(16→recent 3) 을 발행 전 수행 시, release 없는 entry(v8.2~v8.12 누락분)의 forward 가시성 상실 — milestones[]에서 빠지는데 GitHub Releases에도 없어 양쪽 부재.",
      "mitigation": "EXECUTE phase 순서 = 발행 catch-up(10건) 선행 → 그 다음 trim. publish-then-trim 강제. DESIGN d_X 에 phase ordering 명시."
    },
    {
      "id": "risk_2",
      "description": "신설 smoke 가 현 상태(16 completed)에서 즉시 FAIL → trim 전 commit 차단 (chicken-egg).",
      "mitigation": "EXECUTE 에서 trim(데이터 정합) 과 smoke 신설을 같은 phase 또는 trim-후-smoke 순서. smoke 가 PASS 하는 상태로 phase 종료. DESIGN phase 매핑."
    },
    {
      "id": "risk_3",
      "description": "smoke 판정이 in_progress(v8.13) / deferred entry 를 completed 로 오집계 → false positive.",
      "mitigation": "smoke 판정 = status=='completed' 정확 매칭만 count, in_progress/deferred 제외. fixture(4 completed) FAIL 실증 + 현 trim 후 상태 PASS 양방 검증 (sc_4)."
    },
    {
      "id": "risk_4",
      "description": "GitHub Releases 발행 catch-up = 외부 visible 배포 행위 (outward-facing) — 무단 실행 부적절.",
      "mitigation": "CLAUDE.md '커밋·배포 전 사용자 확인' 정합 — EXECUTE 발행 phase 는 사용자 명시 확인 게이트 후만. APPROVE.md 승인 + 발행 직전 재확인."
    },
    {
      "id": "risk_5",
      "description": "smoke scope — 재발방지 smoke 를 meta(development/ROADMAP.md)만 vs 모든 ROADMAP(upbit 등 schema A2) 적용? oos_2 는 데이터 catch-up 을 meta 한정했으나 smoke 규칙은 일반.",
      "mitigation": "DESIGN 결정 — smoke 는 schema A2 milestones[] 보유 ROADMAP 전체 적용 가능(재발방지 일반 강제) 하되 본 milestone 데이터 정합은 meta 만. DESIGN d_X 명시."
    }
  ]
}
```

### Narrative

RESEARCH 의 결정적 finding 둘 — (1) **보존 target 방향이 사실상 확정**된다: ext_1 에서 v6.19 의 CHANGELOG→GitHub Releases 이전이 SIZE_LIMIT 회귀(99998/100000 한계) 회피를 위한 의도적 결정이었음이 확인됐다. CHANGELOG.md 복귀(opt_2)는 그 회귀를 재도입하고 v6.19 milestone 을 reverse 하는 큰 비용이라 폐기 — **GitHub Releases 유지 + fix-forward(opt_1)** 가 단일 source 보존과 정합한다(INTENT Q1 RESEARCH 이관의 답). (2) **드리프트 범위가 OPEN 진단보다 넓다**: ext_2 에서 release 누락이 6건이 아니라 **10건**(v8.2/v8.3/v8.4/v8.5 + v8.7~v8.12)이고, 발행이 v8.6 에서 멈춘 게 아니라 v8.1 직후부터 산발적이었다. 가벼운 흐름 6건은 release-publish.yml 의 MILESTONE.md ## REPORT 전용 추출(cb_1, line 83·98)로 **구조적으로 발행 불가**했고, 9-stage 4건은 marker 누락이다.

이 finding 은 sc_3(catch-up 6건→10건 으로 정정 필요) + sc_5(트랙별 trigger)의 본질을 재정의한다. fix-forward 의 구체는 opt_1+opt_4 — (a) stale 4곳(cb_3: CLAUDE.md 34/68 + ARCHITECTURE 219 + ROADMAP schema_note)을 GitHub Releases 로 정합하되 ARCHITECTURE 156/166/179/199 historical 서술은 무손상, (b) release-publish.yml 에 LIGHTWEIGHT.md ## 기록 추출 분기 추가, (c) 누락 10건을 9-stage 4건(workflow_dispatch) + 가벼운 6건(워크플로우 수리 후 dispatch)으로 catch-up.

재발방지 2개(INTENT 확정)는 cb_4(smoke 신설: development/ROADMAP.md milestones[] completed ≤ 3 강제) + cb_2/cb_5(트랙별 archival trigger 명문화: 9-stage PROPOSE / 가벼운 흐름 ## 기록 시점). 주요 risk 는 **순서 의존** — risk_1(publish-then-trim: 발행 전 trim 시 forward 가시성 상실) + risk_2(smoke 가 trim 전 즉시 FAIL chicken-egg) 가 EXECUTE phase ordering 을 강제하고, risk_4(발행 = outward-facing 배포 → 사용자 확인 게이트) + risk_3(smoke status 정확 매칭 false-positive 회피) + risk_5(smoke scope = 일반 vs meta) 가 DESIGN 결정 대상이다.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "보존 target = GitHub Releases 유지 (CHANGELOG.md 복귀 ❌, 트랙별 이원화 ❌).",
      "rationale": "RESEARCH opt_1 채택 / opt_2,opt_3 폐기. ext_1 — v6.19 가 SIZE_LIMIT 회귀 회피로 의도적 이전, 복귀 = 회귀 재도입 + milestone reverse. 단일 source 보존."
    },
    {
      "id": "d_2",
      "decision": "stale 정합 범위 = operational 현재-지침 **전체** (초안 4곳 → design-review spec-drift 흡수로 확장): (a) CLAUDE.md:34,68 (b) ARCHITECTURE.md:219 (c) development/ROADMAP.md schema_note + 의도 섹션(line 182~186 'trace 3중 보존 = CHANGELOG.md entry') (d) **skills/stage-report/SKILL.md:12,29,75,121 (archival 실행 stage 의 1차 checklist)** (e) **skills/stage-open/SKILL.md:113** (f) skills/stage-propose/SKILL.md (있을 시). historical 기술 서술(ARCHITECTURE 156/166/179/199) 무손상. 정합 문구 = hybrid era 명시 (v6.19까지 CHANGELOG.md / v6.20+ GitHub Releases 단일 source).",
      "rationale": "cb_3 + design-review(spec-drift) — sc_1 'operational 잔존 stale grep 0건' 목표가 초안 '4곳만' scope 와 충돌. grep 실측으로 stage-report SKILL(archival 절차 전체 stale) + stage-open SKILL + ROADMAP 의도 섹션에도 잔존 확인 → phase-1 scope 를 실 stale 전체로 확장해야 sc_1 verification PASS. 156/166/179/199 는 v5.21/v6.19 migration 의 정확한 historical 서술이라 변경 시 거짓 (cascade host 분리)."
    },
    {
      "id": "d_3",
      "decision": "release-publish.yml 에 LIGHTWEIGHT.md fallback 분기 추가 — MILESTONE.md 부재 시 LIGHTWEIGHT.md 사용. **3곳 모두** fallback 대상: (1) Locate step(line 77~89) LIGHTWEIGHT.md locate, (2) Extract step(line 91~119) ## 기록 섹션 추출(## REPORT 동치), (3) **Create Release step(line 170~173) title 추출 — 하드코딩 MILESTONE_PATH 를 Locate step output(steps.milestone.outputs.path)으로 치환**해 LIGHTWEIGHT.md frontmatter title 도 읽도록. design-review spec-drift decisive 흡수.",
      "rationale": "cb_1/cb_5 — 가벼운 흐름 6건 구조적 발행 불가의 직접 수리. v8.1 두 트랙 공존을 발행 메커니즘에 반영. sc_3 catch-up + sc_5 재발방지 동시 충족. design-review(spec-drift FAIL) — line 170~173 세 번째 MILESTONE.md 하드코딩 의존을 Locate/Extract 2곳만 다룬 초안이 누락 → title 추출 실패/pipefail risk. EXECUTE 시 line 170~173 의 별도 MILESTONE_PATH 재구성을 Locate output 으로 통일."
    },
    {
      "id": "d_4",
      "decision": "catch-up 발행 방식 = workflow_dispatch (version input, dry_run=false) 10건 모두. 순서 = 발행(publish) 선행 → trim 후행 (publish-then-trim).",
      "rationale": "RESEARCH opt_4. 과거 merged 커밋 발행 = workflow_dispatch. risk_1 (발행 전 trim 시 forward 가시성 상실) mitigation = publish-then-trim 강제."
    },
    {
      "id": "d_5",
      "decision": "milestones[] trim = 발행 catch-up 후 16 completed → recent 3 (v8.12/v8.11/v8.10 유지). 잘라낸 13건 trace = GitHub Releases + REPORT.md/LIGHTWEIGHT.md + git log 3중 보존.",
      "rationale": "sc_2. schema_note 'recent 3' 규칙 정합. trace 3중 보존(ROADMAP §의도 정합)으로 trim 안전."
    },
    {
      "id": "d_6",
      "decision": "재발방지 smoke 신설 = tests/smoke-roadmap-archival.sh — schema A2 milestones[] 보유 ROADMAP(development/ROADMAP.md + projects/*/ROADMAP.md) 전체에서 status=='completed' 개수 ≤ 3 강제. pre-commit 등재. in_progress/deferred 제외.",
      "rationale": "sc_4 + risk_3(status 정확 매칭 false-positive 회피) + risk_5(scope = 전체 ROADMAP 일반 강제, 단 데이터 catch-up 은 meta 만 = oos_2). smoke-entry-title-guideline 패턴 정합."
    },
    {
      "id": "d_7",
      "decision": "트랙별 archival trigger 명문화 = ARCHITECTURE(§4 끝 #13 paragraph + schema_note 영역) + CLAUDE.md + hook(post-report-write.sh:178) — 9-stage = PROPOSE 시점 / 가벼운 흐름 = ## 기록 작성 시점. hook 178 메시지도 두 트랙 + GitHub Releases 반영.",
      "rationale": "cb_2/cb_5. sc_5 — 가벼운 흐름 PROPOSE 부재 구멍을 '## 기록 시점' 명문화로 해소. d_2 stale 정합과 동일 host(hook 178) 동시 처리."
    },
    {
      "id": "d_8",
      "decision": "발행 catch-up(phase-3) = 사용자 명시 확인 게이트 후만 실행. APPROVE 승인 + 발행 직전 재확인 2중.",
      "rationale": "risk_4 — GitHub Releases 발행 = outward-facing 배포 (CLAUDE.md '커밋·배포 전 사용자 확인' 정합)."
    },
    {
      "id": "d_9",
      "decision": "③ hook reminder 부활(MILESTONE.md 작성 시 PROPOSE archival 메시지 발화) = 미실시. hook 178 은 메시지 문구만 정합(d_7), 발화 trigger 재배선 안 함.",
      "rationale": "oos_1 — 사용자 결정 제외. ①smoke + ②trigger 명문화로 재발 구조적 차단 충분."
    },
    {
      "id": "d_10",
      "decision": "sc_6(전체 smoke 회귀 0) = 각 phase verification 의 게이트 + 최종 VERIFY 에서 전체 smoke 일괄. decision-level 명시로 1:1 매핑 완결.",
      "rationale": "design-review(architecture P2) — sc_6 가 decision 매핑 부재로 narrative 1:1 매핑이 5/6 이던 것 보완. 신설 smoke(d_6) 포함 기존 513+건 무손상 게이트."
    }
  ],
  "approach": "4 phase 순차 — phase-1 (문서 정합: stale 4곳 + 트랙별 trigger 명문화) → phase-2 (release-publish.yml LIGHTWEIGHT.md 분기) → phase-3 (catch-up 발행 10건, 사용자 게이트, outward-facing) → phase-4 (milestones[] trim + 재발방지 smoke 신설). 순서 본질 = risk_1(publish phase-3 선행 → trim phase-4 후행) + risk_2(trim 과 smoke 동일 phase-4, smoke 가 trim 후 PASS). cascade host = ARCHITECTURE §4 끝 #13 row paragraph(release mechanism 에 LIGHTWEIGHT 분기 + recent-3 smoke 추가 반영) — v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 source / (b) EXECUTE Edit / (c) VERIFY grep.",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "stale operational 전체(d_2: CLAUDE.md:34,68 + ARCHITECTURE.md:219 + ROADMAP schema_note+의도 182~186 + skills/stage-report/SKILL.md:12,29,75,121 + skills/stage-open/SKILL.md:113 + stage-propose/SKILL.md + hook:178) 을 'v6.20+ GitHub Releases 단일 source' 로 정합 + 트랙별 archival trigger(9-stage PROPOSE / 가벼운 흐름 ## 기록) 명문화. historical 서술(ARCHITECTURE 156/166/179/199) 무손상.",
      "deliverable": "CLAUDE.md + development/ARCHITECTURE.md + development/ROADMAP.md + skills/stage-report/SKILL.md + skills/stage-open/SKILL.md + skills/stage-propose/SKILL.md + claude/hooks/post-report-write.sh",
      "verification": "grep -rn 'CHANGELOG.md' operational 잔존 0 (historical 서술 제외 수동 확인) + bash tests/smoke-cross-ref.sh + smoke-spec-verification PASS"
    },
    {
      "phase": "phase-2",
      "scope": "release-publish.yml 에 MILESTONE.md 부재 시 LIGHTWEIGHT.md ## 기록 추출 fallback 분기 추가 (Locate + Extract step 양쪽).",
      "deliverable": ".github/workflows/release-publish.yml",
      "verification": "로컬 awk 시뮬레이션 (LIGHTWEIGHT.md ## 기록 추출 결과 non-empty) + yaml 구조 검토 + 가능 시 workflow_dispatch dry_run=true (v8.12 lightweight 대상)"
    },
    {
      "phase": "phase-3",
      "scope": "catch-up 발행 10건 — 9-stage 4건(v8.4/v8.8/v8.9/v8.11) + 가벼운 6건(v8.2/v8.3/v8.5/v8.7/v8.10/v8.12) workflow_dispatch dry_run=false. 사용자 명시 확인 게이트 후만.",
      "deliverable": "GitHub Releases 10건 (외부 visible artifact)",
      "verification": "gh release list 대조 — milestones[] completed 16건 전부 release 존재 (누락 0) + 사용자 확인"
    },
    {
      "phase": "phase-4",
      "scope": "development/ROADMAP.md milestones[] trim (16 completed → recent 3: v8.12/v8.11/v8.10) + 재발방지 smoke 신설(tests/smoke-roadmap-archival.sh) + pre-commit 등재. trim 선행 → smoke 가 PASS 하는 상태로 phase 종료.",
      "deliverable": "development/ROADMAP.md (trimmed) + tests/smoke-roadmap-archival.sh + .pre-commit-config.yaml",
      "verification": "신설 smoke PASS (현 상태 ≤ 3) + 위반 fixture(4 completed) FAIL 실증 + 전체 smoke 회귀 0"
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_4",
      "method": "publish-then-trim 강제 — 발행(phase-3) 이 trim(phase-4) 선행. 발행 없는 entry 가 milestones[]에서 빠지기 전 GitHub Releases 에 보존됨 보장."
    },
    {
      "risk_ref": "risk_2",
      "decision_ref": "d_6",
      "method": "trim 과 smoke 신설을 동일 phase-4, trim 선행 → smoke 가 ≤ 3 상태에서 PASS. chicken-egg(16>3 즉시 FAIL) 회피."
    },
    {
      "risk_ref": "risk_3",
      "decision_ref": "d_6",
      "method": "smoke 판정 = status=='completed' 정확 문자열 매칭만 count, in_progress/deferred 제외. fixture(4 completed) FAIL + 실 상태 PASS 양방 검증."
    },
    {
      "risk_ref": "risk_4",
      "decision_ref": "d_8",
      "method": "발행 phase-3 = APPROVE 승인 + 발행 직전 사용자 재확인 2중 게이트. outward-facing 배포 무단 실행 방지."
    },
    {
      "risk_ref": "risk_5",
      "decision_ref": "d_6",
      "method": "smoke scope = schema A2 milestones[] 보유 ROADMAP 전체(재발방지 일반 강제) / 데이터 catch-up(발행+trim) 은 meta(development/ROADMAP.md) 한정(oos_2). 분리 명시."
    }
  ],
  "five_perspective_review": {
    "method": "subagent (harness-meta:design-review) 3 관점 병렬 — architecture/spec-drift/security. fact 인용 직접 재검증 후 흡수(MEMORY feedback_subagent_fact_hallucination_correction 정합).",
    "perspectives": [
      {
        "perspective": "architecture",
        "verdict": "pass-with-comments",
        "comments": "phase 순서가 risk_1(publish-then-trim)+risk_2(smoke chicken-egg)를 옳게 강제 PASS. decisive: sc_6↔decision 매핑 부재(P2) → d_10 신설로 흡수. cascade host(#13) 표현 모호(P2) → narrative 에서 stale 정합 host(d_2)와 cascade 정전화 host(#13) 분리 명시로 해소. 우연 발견: ARCHITECTURE §4 매트릭스 #14/#15 row 번호 물리 순서 어긋남(기존 drift, scope 외 거명)."
      },
      {
        "perspective": "spec-drift",
        "verdict": "FAIL",
        "comments": "decisive 2건 흡수: (1) [P0] d_3 LIGHTWEIGHT fallback 이 release title 추출(line 170~173 세 번째 MILESTONE.md 하드코딩 의존) 누락 → d_3 에 3곳 모두 fallback 명시로 흡수. (2) [실질 P1] sc_1 'stale grep 0' ↔ d_2 '4곳만' 충돌 — grep 실측으로 stage-report/stage-open SKILL + ROADMAP 의도 섹션 stale 확인 → d_2/phase-1 scope 확장 흡수. **기각 1건**: agent 의 'completed=15(16-1)' 주장은 실측 오류 — milestones[] = completed 16 + in_progress 1 = total 17 entry 직접 재검증, '16 completed' 정확(d_5 13건 trim 유지). REPORT 추출 line 83/98 인용 정합 확인."
      },
      {
        "perspective": "security",
        "verdict": "pass-with-comments",
        "comments": "발행 게이트(d_8) 충분 PASS. tag conflict — catch-up 10건(v8.2~v8.12 minus v8.6) ↔ 기 발행 10건(v6.19~v8.6) disjoint 직접 대조 확인, 중복 risk 0(release-publish.yml line 121~131 tag check 정합). P2 흡수: 발행 게이트 건별 vs 일괄 모호 → EXECUTE 에서 9-stage 4건/가벼운 6건 그룹별 확인으로 명시 예정. 후속 거명: 부분 실패 시 resume 절차 부재(phase-3 운영 가벼운 보강 후보, scope 외)."
      }
    ]
  }
}
```

### Narrative

DESIGN 의 중심 결정은 d_1 (보존 target = GitHub Releases 유지) — RESEARCH ext_1 이 v6.19 이전을 SIZE_LIMIT 회귀 회피로 확정했으므로 복귀(opt_2)는 회귀 재도입이고, fix-forward 가 단일 source 를 지킨다. 나머지 결정은 INTENT 6 sc + RESEARCH 5 risk 와 1:1 매핑된다 — d_2(stale 4곳 정합, historical 무손상)↔sc_1, d_5(trim)↔sc_2, d_3+d_4(LIGHTWEIGHT 분기+10건 발행)↔sc_3, d_6(smoke 신설)↔sc_4, d_7(트랙별 trigger)↔sc_5, d_9(hook reminder 제외)↔oos_1.

approach 의 4 phase 순서는 risk 가 직접 강제한다 — risk_1(publish-then-trim)이 phase-3(발행) → phase-4(trim) 순서를, risk_2(smoke chicken-egg)가 trim 과 smoke 를 phase-4 동일 묶음으로 만든다. risk_4(발행=outward-facing)는 phase-3 을 사용자 확인 게이트 뒤로 격리(d_8). 여기서 **두 host 를 구분**한다 — (1) cascade 정전화 host = ARCHITECTURE §4 끝 #13 row paragraph(release mechanism 에 LIGHTWEIGHT 분기 + recent-3 smoke 의 forward operational 규칙을 historical 서술과 경계 두고 추가) / (2) stale 정합 host = d_2 의 operational 잔존 전체(CLAUDE.md + ARCHITECTURE 219 + ROADMAP + SKILL 3건 + hook). 전자는 v3.21 narrative 정전화 3 단계 패턴 (a) 본 DESIGN 1차 source / (b) EXECUTE Edit / (c) VERIFY grep 으로 닫고, 후자는 phase-1 grep 검증으로 닫는다. historical 서술(156/166/179/199)은 무손상.

5 관점 review 는 본 milestone 이 outward-facing 발행 + workflow YAML 변경 + smoke 판정 신설을 포함하는 큰 건이라 design-review subagent 3 관점(architecture/spec-drift/security)으로 검토했다 (MEMORY feedback_subagent_parallel_review_evidence 정합). 결과 = spec-drift FAIL(decisive 2 흡수) + architecture/security pass-with-comments. 흡수 = d_3 확장(line 170~173 title fallback) + d_2/phase-1 scope 확장(stale 전체) + d_10 신설(sc_6 매핑). **기각 1건** = agent 의 'completed 15건' 주장은 실측 재검증(completed 16 + in_progress 1 = 17 entry)으로 오류 확인, '16 completed → recent 3, 13건 trim' 유지(MEMORY fact-hallucination 검증 의무 정합). 이로써 INTENT 6 sc 전부 decision 1:1 매핑 완결.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-27",
    "approval_method": "자연어 명시 응답 '승인할게, APPROVE 기록하고 EXECUTE 진행해줘' — DESIGN 4 phase (phase-3 GitHub Releases 10건 발행 outward-facing 포함) 제시 후 명시 승인.",
    "scope_confirmed": [
      "Q1(보존 target) RESEARCH 이관 → ext_1 SIZE_LIMIT 근거로 GitHub Releases 유지 fix-forward 확정(d_1)",
      "Q2(catch-up 범위) '전부 실행' → milestones[] 16→recent 3 trim + 미발행 10건 발행(d_4/d_5)",
      "Q3(재발방지) ①smoke + ②트랙별 trigger (③ hook reminder 제외) → d_6/d_7/d_9",
      "sc_3 정정 '6건→10건' 승인(RESEARCH ext_2 실측 교정)",
      "design-review decisive 흡수 결과(d_3 title fallback 확장 + phase-1 stale scope 확장 + d_10) 포함 DESIGN 명시 승인"
    ]
  }
}
```

### Narrative

사용자가 DESIGN 4 phase 전체(특히 phase-3 GitHub Releases 10건 발행 = outward-facing 배포, d_8 게이트 대상)를 제시받은 뒤 자연어로 명시 승인했다. INTENT pre-PLAN 3 round 결정(Q1 RESEARCH 이관 / Q2 catch-up 전부 / Q3 ①+②) + RESEARCH sc_3 정정 + design-review decisive 흡수까지 누적된 scope 가 confirm 됐다. EXECUTE 진입 — phase-1(문서 정합) → phase-2(워크플로우 LIGHTWEIGHT 분기) → phase-3(발행, 사용자 재확인 게이트) → phase-4(trim + smoke 신설) 순. repo 변경 commit + 발행은 각 시점 사용자 확인 후 (CLAUDE.md § 개발 프로세스 정합).

## EXECUTE

### Spec

```json
{
  "phases_executed": [
    {
      "phase": "phase-1",
      "status": "completed",
      "deliverable_path": "execute/phase-1.md",
      "commits": [
        {
          "sha": "pending",
          "message": "docs(meta): [v8.13] phase-1 archival 보존 target stale 정합 + 트랙별 trigger 명문화"
        }
      ],
      "summary": "stale operational 정합 (d_2/d_7) — CLAUDE.md(34,68) + ARCHITECTURE(110 Trace row/199 #13 cascade/219 schema/371 §7.4 트랙 trigger) + ROADMAP(schema_note/의도/비고) + stage-report SKILL(archival 절차 재작성) + stage-open SKILL(113) + hook(178). 'archival = CHANGELOG.md' → 'v6.19+ GitHub Releases 단일 source (두 트랙 발행)'. historical 서술(ARCHITECTURE 156/166/179) 무손상. design-review spec-drift 흡수로 SKILL 2건 + ROADMAP 의도/비고 확장. verification = operational stale grep 0 + smoke 3종 PASS."
    },
    {
      "phase": "phase-2",
      "status": "completed",
      "deliverable_path": "execute/phase-2.md",
      "commits": [
        {
          "sha": "pending",
          "message": "feat(meta): [v8.13] phase-2 release-publish.yml 가벼운 흐름 LIGHTWEIGHT.md fallback 분기"
        }
      ],
      "summary": "release-publish.yml 3 step fallback (d_3) — Locate(MILESTONE.md→LIGHTWEIGHT.md, track/section output) + Extract(범용 awk -v sec, ## REPORT/## 기록 양쪽) + Title(하드코딩 제거, Locate output 사용, design-review spec-drift decisive 흡수). 검증 = yaml OK + 로컬 awk 시뮬 양쪽 트랙 + title fallback PASS."
    },
    {
      "phase": "phase-3",
      "status": "completed",
      "deliverable_path": "execute/phase-3.md",
      "commits": [],
      "summary": "catch-up 발행 10건 (d_4/d_8, outward-facing 사용자 게이트). dry-run(v8.12 lightweight) 선행 검증 → 10건 live dispatch 전부 success. gh release list 대조 — completed 16건 전부 release 존재 누락 0 (sc_3). 가벼운 흐름 6건이 phase-2 LIGHTWEIGHT fallback 으로 처음 발행. repo 파일 변경 0 (별책 phase-3.md 제외)."
    },
    {
      "phase": "phase-4",
      "status": "completed",
      "deliverable_path": "execute/phase-4.md",
      "commits": [
        {
          "sha": "pending",
          "message": "feat(meta): [v8.13] phase-4 milestones[] trim 16→3 + 재발방지 smoke-roadmap-archival 신설"
        }
      ],
      "summary": "milestones[] trim 16→recent 3 (v8.12/v8.11/v8.10, d_5, publish-then-trim) + 재발방지 smoke 신설 (tests/smoke-roadmap-archival.sh, d_6) + pre-commit 등재. smoke scope = development/ROADMAP.md 만 (risk_5 실측 — upbit completed 21건이라 전체 적용 불가, 사용자 결정 + oos_2). sc_4 = fixture violation-4 FAIL 실증. smoke-claude-md-drift count 14 정합."
    }
  ]
}
```

### Narrative

EXECUTE 는 publish-then-trim 순서(risk_1)로 phase-1(문서) → phase-2(워크플로우) → phase-3(발행, 사용자 게이트) → phase-4(trim+smoke) 4 phase 전부 완료. phase-1 stale 정합(design-review 흡수로 SKILL 2건+ROADMAP 의도/비고 확장, sc_1), phase-2 release-publish.yml LIGHTWEIGHT fallback 3곳(d_3), phase-3 catch-up 10건 발행(dry-run 선행 검증 후 사용자 게이트, sc_3 누락 0), phase-4 trim 16→3 + 재발방지 smoke 신설(sc_4). 도중 RESEARCH 정정 2건 — 누락 6→10건(ext_2) + smoke scope 전체→development만(risk_5 실측, upbit 21건). 상세 = execute/phase-{1..4}.md.

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
