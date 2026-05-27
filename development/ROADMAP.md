# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-27-v8.13-completed",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = GitHub Releases (v6.19+ 단일 source, commit marker [release:v{X.Y}] → release-publish.yml; CHANGELOG.md 는 v6.19 까지 historical, Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). milestones[] completed ≤ 3 강제 = tests/smoke-roadmap-archival.sh (v8.13). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md(9-stage)/LIGHTWEIGHT.md ## 기록(가벼운 흐름) + git log + GitHub Release(v6.19+ 단일 source, v6.19 까지 CHANGELOG entry — v8.13_archival-mechanism-reconciliation 정합). entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE 종합, v7.0 T1.2 후 lessons P2 자동 종합 제외) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제. next_candidates[] append = 사용자 명시 결정 게이트 후만 (자동 append 폐지, v7.0 T1.2 정전화). lessons P2/P3 자동 enumerate 폐지 — PROPOSE stage 안 사용자 명시 결정만 candidate 본질 source (scripts/propose_next.py lessons P2 grep/count 제거 정합). 기존 33 next_candidates (부산물 cycle 누적 임시 후보) 일괄 폐기 — git history 보존.",
  "deferred_note": "동결 정책 은퇴 (v8.1_meta-lightweight-flow-design, 2026-05-26). 구 동결 정책 (v3.13_pending-milestone-renumber-policy + v3.14_deferred-revaluation-cycle-2 자기참조 milestone 동결 + v4.0 § 6.2 폐지 후 재발의 trigger 조건 '외부 적용 5건+ ∧ 사용자 명시 발의') 은 컨설턴트 정체성 (harness engineering 컨설턴트) + 가벼운 흐름 창구 (ARCHITECTURE § 7.4) 도입으로 무의미해짐 — '§ 6.2 부활' 아닌 deferred_note drift 해소 (memory feedback_section_6_2_abolished 정합, 자기참조 루프 우려가 가벼운 흐름으로 흡수). deferred 3건 처리 = (1) v1.5_research-cascade-grep-discipline → v8.2 가벼운 흐름 도그푸드 실처리 (completed) + (2) v1.4_hook-narrative-separation / v1.4_design-review-trace → next_candidates[] 전환 (작은 건 = 가벼운 흐름 후보) → **v8.12 후 pre-PLAN 검토에서 양쪽 전제 broke 확인되어 폐기 (retired, 2026-05-27)**: design-review-trace = v6.2 평탄화 + v7.0 T1.3 (verdict + comments + disposition 인라인 DESIGN.five_perspective_review 보존) 이 핵심 trace 를 이미 흡수 → raw 전체 보존은 토큰효율 우선과 충돌, 사실상 해소(superseded). hook-narrative-separation = post-report-write.sh 메시지가 정적 hard-code 가 아닌 동적 템플릿 (FILE_TYPE 분기 + ${FILE_BASENAME}/${SECTIONS} 런타임 보간) 이라 'hook = 단순 reader' 전제 불성립 — MD 분리 시 hook 이 reader + 템플릿엔진 + 분기선택 + 런타임 파일의존을 떠안아 오히려 복잡화. 거명 보존 (재발의 trigger 부재). 부수 발견 (폐기와 별개, 미등재) = hook PROPOSE 메시지 (line 178) 의 'completed > 3 archival' 규칙이 schema_note ('recent 3만') + 실제 운영 (milestones[] 16건 누적) 과 3중 드리프트 — 별도 검토 후보 (사용자 게이트). deferred[] = 빈 배열 (동결 대상 부재).",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v8.13",
      "id": "archival-mechanism-reconciliation",
      "title": "archival 메커니즘 드리프트 해소 및 재발방지 강제 신설",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v8.13/MILESTONE.md#sub-milestones",
      "summary": "v8.12 후속 부수 발견 origin (사용자 명시 큰 건 결정, 2026-05-27). archival = 두 반쪽(① milestones[] recent 3 trim + ② 잘라낸 entry 영구 보존). v6.19 가 보존 대상을 CHANGELOG.md → GitHub Releases 로 의도적 이전(marker [release:v{X.Y}] → workflow 자동 발행). 실측 드리프트: (a) GitHub Releases 발행이 v8.1 직후부터 산발 — RESEARCH ext_2 실측 누락 10건(가벼운 흐름 6: v8.2/v8.3/v8.5/v8.7/v8.10/v8.12 = release-publish.yml 구조적 발행 불가 + 9-stage 4: v8.4/v8.8/v8.9/v8.11 = marker 누락. OPEN 추정 6건은 과소집계) + (b) milestones[] trim 이 v6.19 경부터 멈춰 16건 누적(recent 3 이어야) + (c) hook(post-report-write.sh:178)·schema_note·ARCHITECTURE·CLAUDE.md 가 아직 'CHANGELOG.md archival' stale + (d) 길이 강제 smoke 부재로 무탐지. 근본 = archival 이 PROPOSE 수동 작업인데 가벼운 흐름엔 PROPOSE 부재 + v6.2 평탄화로 MILESTONE.md hook NOOP(reminder 사망) + 강제 smoke 부재. scope = stale 문서 정합 + catch-up(trim 16→3 + 누락 10건 발행) + 재발방지 smoke 신설(smoke-roadmap-archival) + 트랙별 trigger 명문화. smoke 판정 재설계 = 큰 건(9-stage). verdict RESOLVED — sc 6/6 PASS + risk 5/5 MITIGATED. catch-up 발행 10건 + milestones[] trim 16→3 + smoke-roadmap-archival 신설 + 트랙별 archival trigger 명문화."
    },
    {
      "version": "v8.12",
      "id": "area4-detect-refinement-external-verify",
      "title": "정련된 영역 4 detect 기준 실효를 price-compare 실 audit으로 검증",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.12/LIGHTWEIGHT.md",
      "summary": "가벼운 흐름 (4 섹션) — v8.11 oos_2 소비. v8.11 이 영역 4 detect 기준을 'SessionStart event gate + 책임 토큰(write-time Edit|Write guard 제외)'으로 정련했으나 그 실효(정련 기준이 실 audit 에서 secret-guard.py 보유 프로젝트를 gap=true surface = 과억제 false-negative 교정)는 agent prompt-time 분기라 정적 smoke 밖(v8.11 L3). v8.9→v8.10 패턴 정합으로 price-compare working tree(HEAD 14bb1a3) 재audit. OPEN 전 세션 동결 재현(reload 전 probe=옛 name-token 기준) → 사용자 /reload-plugins(17 agents) + 재probe(v8.11 event-gate 기준 그대로 인용)로 반영 실측 후 audit-orchestrator Step1~4 read-only(Step5 미spawn, 외부 repo write 0). 결과: (A) gap=true 확인(secret-guard.py[Edit|Write]를 SessionStart gate 정확 제외 → v8.10 gap=false 직접 교정, 실질도 옳음 — secret-guard.py 는 write payload 만 scan, settings.local.json:37-38 평문 secret 은 못 잡음) + (B) over-recommend false-positive 0(유일 권고=session-start-secret-scan.sh adopt, secret-guard.py replace 0) + fact-verify mismatch 0. v8.9→v8.12 영역 4 통로 신설·실효·결함·수정·수정실효 5 단계 검증 체인 닫힘. 부수 재확인=price-compare 평문 secret v8.7 이후 미회수(외부 repo write 0, 사용자 회수 몫)."
    },
    {
      "version": "v8.11",
      "id": "area4-detect-criterion-refinement",
      "title": "영역 4 gap detect 기준을 matcher/책임 기반으로 정련",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v8.11/MILESTONE.md#sub-milestones",
      "summary": "v8.10 (C) 결함 origin (next_candidate area4-detect-criterion-refinement 소비). v8.10 실 price-compare audit 에서 검출 — harness-gap-analyzer d_2 의 name-token detect 기준이 secret-guard.py(PreToolUse Edit|Write, write-time 차단)와 session-start-secret-scan.sh(SessionStart, settings*.json 저장 secret warn-only)의 책임 직교를 구분 못 해 'secret' 토큰 매칭만으로 gap=false 처리 → 잠재 false-negative. OPEN 전 사용자 pre-PLAN 대화에서 (a) project-scanner 가 이미 hook 별 matcher 출력(v8.4식 upstream 함정 없음 — scanner 충분) 검증 + (b) 수정 범위 = 이 자산만 정밀 수정(기준 일반화는 SCOPE_OUT, 2번째 자산 등록이 원래 trigger) 결정. 고칠 곳 2군데 = gap-analyzer d_2 detect 기준 + 카탈로그 § 4 '권고 case' 컬럼, matcher(SessionStart)+책임 기반 판별. 컨설팅 자산(agent+catalog) 변경 = 큰 건(9-stage, v8.4 패턴 — 외부 적용 결함 검출→큰 건 승격)."
    }
  ],
  "next_candidates": [
    {
      "id": "open-stage-entry-title-precheck",
      "title": "OPEN stage title entry-title 사전 검증 권고 추가",
      "trigger": "B_regression",
      "origin_milestone": "v7.1",
      "target_version": "v7.2",
      "description": "v7.1 L4 origin — entry-title gate (smoke-entry-title-guideline) 가 v7.1 EXECUTE 중 title 의 ' + ' 를 실제 차단 (도그푸드). 2 반쪽 bundling milestone 은 OPEN 시점에 title 의 ' + ' P1 정합을 사전 확인하면 EXECUTE 중 재커밋 cost 회피. stage-open skill 또는 propose-next 안 title 사전 검증 checklist 1줄 추가 후보."
    },
    {
      "id": "release-workflow-node24-migration",
      "title": "release-publish/ci 워크플로우 actions Node 24 마이그레이션",
      "trigger": "B_regression",
      "origin_milestone": "v8.13",
      "target_version": "v8.14",
      "description": "v8.13 phase-3 catch-up 발행 로그에서 검출 — actions/checkout@v4 가 Node.js 20(deprecated, 2026-06-02 Node 24 강제 + 2026-09-16 runner 제거) 위에서 실행. release-publish.yml + ci.yml actions 버전을 Node 24 지원 버전으로 업 또는 FORCE_JAVASCRIPT_ACTIONS_TO_NODE24 설정. 날짜 의무(2026-06-02) 보유, 작은 건(가벼운 흐름 후보)."
    }
  ]
}
```

## 의도 (v5.21+ schema A2)

본 ROADMAP 은 **forward-looking 이정표** — 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 정합. `milestones[]` = 현재 진행 (in_progress) + 최근 완료 (recent 3건, carry-over context) + deferred (재발의 trigger 조건 보유) + `next_candidates[]` = PROPOSE 발의 후보 (forward-looking 본질).

**과거 completed entry archival** = **GitHub Releases** (v6.19+ 단일 source — commit marker `[release:v{X.Y}]` → `.github/workflows/release-publish.yml` 자동 발행, 두 트랙 모두: 9-stage=MILESTONE.md ## REPORT / 가벼운 흐름=LIGHTWEIGHT.md ## 기록, v8.13). [`../../CHANGELOG.md`](../CHANGELOG.md) 는 v6.19 까지 historical hybrid (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). trace 3중 보존:

1. **GitHub Release** — 외부 visible artifact (release note, v6.19+; v6.19 까지는 CHANGELOG.md entry)
2. **milestones/v{X.Y}/REPORT.md** (9-stage) 또는 **LIGHTWEIGHT.md ## 기록** (가벼운 흐름) — milestone 종합 backward (lessons + delta)
3. **git log** — 원자 commit history + diff

## v5.21 정전화 1차 source

본 schema redesign 정전화 = [`milestones/v5.21/`](milestones/v5.21/) (RESEARCH + DESIGN + REPORT). [`ARCHITECTURE.md`](ARCHITECTURE.md) § 4 끝 #3 narrative 본질 변경 (drift 수용 → drift 해소 사례 정전화).

## 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../CLAUDE.md)
- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- subdirectory CLAUDE.md (lazy load): [`CLAUDE.md`](CLAUDE.md)
- 최근 완료 milestone: [`milestones/v6.2/`](milestones/v6.2/) (completed, 2026-05-19 — milestone 산출물 디렉토리 평탄화 / 9-stage-flattened era)
- 과거 completed milestone (v1.0 ~ v5.20) 종합: [`../../CHANGELOG.md`](../CHANGELOG.md) — entry 별 REPORT.md cross-ref
- Archive (v4.0 phase-2 분리): `milestones/_archive/v1.0_*` ~ `v3.21/` (역사적 디렉토리 보존)

## 비고

본 ROADMAP 은 v5.21_roadmap-forward-looking-redesign-and-changelog-archival (2026-05-19) 에서 schema A2 재설계. 이전 schema (v3.0+ 9-stage-bundled era, v3.0_milestones-restructure 도입) 는 `milestones[]` 단일 array 안 forward + past 혼재 = ~30~40% 부합 drift (v3.19/v5.9 정전화). v5.21 schema A2 는 `milestones[]` + `next_candidates[]` 명료 이원 분리 + CHANGELOG.md archival 흡수 = ~95%+ 부합 도달. 본 파일이 meta 진행/완료/후보 trace 의 단일 source — 단 past trace 본질은 GitHub Releases 위임 (v6.19+ 단일 source, CHANGELOG.md 는 v6.19 까지 historical; v8.13_archival-mechanism-reconciliation 정합).
