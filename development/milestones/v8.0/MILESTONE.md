---
id: reclassify-meta-as-development
title: meta를 development/ 최상위로 재분류
version: v8.0
status: in_progress
---

# v8.0 — meta를 development/ 최상위로 재분류

## INTENT

### Spec

```json
{
  "id": "reclassify-meta-as-development",
  "title": "meta를 development/ 최상위로 재분류",
  "goal": "meta = 프로젝트 아닌 repo 제품-개발 이력 재구성의 **1단계** — projects/meta/ 디렉토리 전체를 최상위 development/ 로 git mv (history 보존) + 살아있는 배선 ~30-40개를 development/ 경로로 갱신. projects/ 에는 외부 적용(upbit)만 남긴다. 9단계 워크플로우 자체·반창고·검증철학은 손대지 않는 순수 위치 재분류 (의미 불변, 경로만 변경).",
  "motivation": "사용자 다라운드 pre-PLAN 대화(2026-05-26)로 도출. meta-work(프레임워크 진화 = '법 개정')와 외부 적용(upbit = '법 적용')은 결과물·사고방식이 본질적으로 다른데 같은 projects/ 서랍에 peer 로 분류돼 있다. 이 분류 오류가 ① dogfooding 이 외부 검증인 듯한 착시 ② 자기참조 루프를 낳았고, repo 는 이를 동결 정책(deferred workflow-self-improvement milestone)과 lightweight 1-phase 모드라는 두 반창고로 임시 봉합해왔다. v6.23 이 표본 — 9단계 전부 거친 산출물이 '버전 5중복 줄일까' 자기 장부정리 문단 1개였고, 그 5중복 문제 자체가 meta 를 프로젝트로 등재(frontmatter+디렉토리명+ROADMAP+git tag+Release)했기에 생긴 것. 파일 비율도 진단을 확증 — 자기 개발 기록 ~200 vs 외부 적용 ~6 (자기를 먹고 자란 구조). 재구성: meta 는 repo 라는 제품 자체의 개발 이력이므로 최상위 development/ 로 승격하고, projects/ 는 외부 적용 인스턴스 전용으로 정리한다. 본 milestone 은 이 재구성의 1단계(위치 이동)이며, 현 9단계(lightweight)로 기록되는 마지막 milestone — '옛 법으로 이사하고 다음 법을 바꾸는' 순서.",
  "success_criteria": [
    {"id": "sc_1", "criterion": "projects/meta/ 전체(ARCHITECTURE.md + ROADMAP.md + CLAUDE.md + milestones/ ~200 디렉토리)가 development/ 로 이동, git history 보존(rename 추적). projects/ 하위엔 upbit 만 잔존."},
    {"id": "sc_2", "criterion": "살아있는 배선 전부 development/ 경로로 갱신 — .claude-plugin/plugin.json paths, 9개 stage skill, claude/commands/*, statusline.sh, hooks, 루트 CLAUDE.md/ROADMAP.md, agents/*, .claude/settings.json + rules, tests 안 경로 의존 스크립트. 작동(non-historical) 파일 안 projects/meta 잔존 참조 0."},
    {"id": "sc_3", "criterion": "smoke 전체 PASS — 특히 tests/_era_detect.py + smoke-spec-verification + smoke-cross-ref + smoke-projects-scope-discipline + cascade-sync --check + pre-commit hook 전체. FAIL=0."},
    {"id": "sc_4", "criterion": "plugin manifest 경로 정합 — development/ 신 경로가 plugin.json + 관련 discovery 에 인식 (환경 audit read-only 확인 또는 경로 존재 검증)."},
    {"id": "sc_5", "criterion": "out_of_scope 준수 — 9단계 stage 정의/skill 로직/smoke 판정 로직 의미 불변(경로 문자열만 변경), 반창고 미은퇴, 검증철학 미변경, upbit 구조 미변경. 1단계 = 순수 위치 재분류."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "2단계 — meta 전용 가벼운 흐름(문제→결정→적용→기록) 설계·도입. 별 milestone(v8.1+) 자연 분기."},
    {"id": "oos_2", "item": "동결 정책 + lightweight 1-phase 모드 두 반창고 은퇴 — 2단계에서 가벼운 흐름 도입과 함께 처리."},
    {"id": "oos_3", "item": "검증철학 재정의(dogfooding 은퇴, 외부 적용을 검증 vector 로) — 별도 후속, 천천히."},
    {"id": "oos_4", "item": "9단계 stage 단어 정의/MILESTONE.md schema/smoke 판정 로직 자체 변경 — 본 milestone 은 경로 재배치만, 워크플로우 의미는 불변."},
    {"id": "oos_5", "item": "upbit 등 projects/ 하위 외부 적용 구조 변경 — projects/ 는 그대로 외부 적용 전용으로 남김."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "사용자 pre-PLAN 대화 결정 (2026-05-26) + memory project-meta-as-development-not-project", "purpose": "본 milestone 방향·단계 분할·새 집 이름(development/) 결정 origin. 진단(B 근본 + A 파생) + 단계적 재구성 + 검증철학 별도 합의."},
    {"id": "dep_2", "ref": "projects/meta/milestones/v6.23/MILESTONE.md", "purpose": "자기참조 루프 표본 evidence — 9단계 산출이 자기 장부정리 문단 1개(5중복 버전). 분류 오류가 생성한 일감 본질 1차 source."},
    {"id": "dep_3", "ref": "projects/meta/ROADMAP.md deferred_note + v1.4/v1.5 deferred entry (동결 정책)", "purpose": "반창고 #1(동결 정책) 1차 source — '자기참조 사이클 동결' 정책이 분류 오류의 임시 봉합임. oos_2 후속 은퇴 대상."},
    {"id": "dep_4", "ref": "projects/meta/ARCHITECTURE.md § 3.1 정체성 (project harness composer + ecosystem integrator + agent fleet maintainer)", "purpose": "meta = '제품 개발 이력' 재구성이 § 3.1 정체성과 부합 검증 source — repo 자체가 제품, meta 진화 = 제품 개발."},
    {"id": "dep_5", "ref": "살아있는 배선 인벤토리 (grep projects/meta 250 파일 중 ~200 역사 기록 + ~30-40 작동 파일)", "purpose": "sc_2 배선 갱신 대상 enumerate source. RESEARCH 에서 작동/역사 분리 정밀화."}
  ]
}
```

### Narrative

본 milestone(v8.0) 은 **"meta 는 프로젝트가 아니라 repo 제품 자체의 개발 이력"** 재구성의 1단계다. 핵심 진단(사용자 대화 도출): 프레임워크 진화와 외부 적용을 같은 `projects/` 서랍에 욱여넣은 **분류 오류(B)** 가 모든 부작용의 뿌리이고, 9단계가 무겁다는 증상(A)은 그 파생이다. 두 반창고(동결 정책 + lightweight 모드)는 뿌리를 덮은 임시 봉합이다.

**1단계 = 순수 위치 재분류** — `projects/meta/` → `development/` git mv + 배선 갱신. 의미는 하나도 안 바꾸고 경로만 옮긴다. 위험을 낮추고 이웃 혼동(meta ≡ upbit peer)을 즉시 끊는 것이 목적. 가벼운 흐름 도입·반창고 은퇴·검증철학 재정의는 모두 후속(oos_1~3)으로 분리 — 잘 돌아가는 시스템을 한 번에 흔들지 않는다.

**부트스트랩 정합** — 본 milestone 은 아직 새 흐름이 없으므로 현 9단계(lightweight)로 기록되는 마지막 milestone이며, milestone 디렉토리는 현재 위치(`projects/meta/milestones/v8.0/`)에 태어나 1단계 EXECUTE 의 폴더 이동 때 `development/milestones/v8.0/` 로 자기 이사를 스스로 기록한다. 구조 breaking change → major bump(v8.0).

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": ".claude-plugin/plugin.json (실 읽기)", "finding": "plugin manifest 는 commands=./claude/commands/ + hooks=./claude/hooks/hooks.json + skills=./skills/ 만 가리킨다. **projects/meta(또는 milestones)를 일절 참조 안 함** → milestone 이력은 plugin 배포물이 아니라 순수 repo-내부 콘텐츠. ∴ 디렉토리 이동이 plugin install/discovery 에 영향 0 (sc_4 위험 minimal). '제품 개발 이력 ≠ 배포 제품' 논지 확증 evidence."},
    {"id": "ext_2", "source": "git mv history 보존 spec", "finding": "git mv (또는 rename detection) 로 디렉토리 통째 이동 시 follow 히스토리 보존. ~200 milestone 디렉토리 + 내부 상대 cross-ref 동시 이동 → 내부 참조 유효 유지."}
  ],
  "codebase": [
    {"id": "cb_1", "ref": "grep projects/meta — 250 파일 중 ~200 = projects/meta/milestones/** 자기 기록", "finding": "대다수가 milestone 산출물 자체. 폴더째 이동하면 같이 움직이고 내부 상대 참조는 유효. 작동(non-historical) 파일은 49 - (CHANGELOG + _archive + upbit audit + fixtures 등 historical) ≈ ~30 갱신 대상."},
    {"id": "cb_2", "ref": "scripts/propose_next.py:24,112", "finding": "**경로 로직 하드코딩** — 'projects/meta/milestones/v*/ semver desc 최근 N' enumerate. development/ 로 갱신 의무 (behavior-critical)."},
    {"id": "cb_3", "ref": "claude/statusline/statusline.sh:30 + claude/hooks/session-start-version-track.sh:20,36", "finding": "**경로 로직 하드코딩** — version-log MARKER/LOG_FILE = $PROJECT_DIR/projects/meta/claude-code-version-log.md (T1.6 version-track). development/ 로 갱신 의무 (behavior-critical). version-log 파일 자체는 폴더 이동에 같이 따라감."},
    {"id": "cb_4", "ref": "tests/smoke-projects-scope-discipline.sh:36,101 (실 읽기)", "finding": "PROJECTS_DIR=REPO/projects 만 iterate + root ROADMAP projects[].roadmap_path regex `^projects/[a-z0-9_-]+/ROADMAP\\.md$` 강제. meta 가 projects/ 떠나면: (a) 본 smoke 는 development/ 를 검사 안 함(정상 — development 는 project 아님) (b) root ROADMAP projects[] 안 meta entry 는 **제거 의무**(regex 가 development/ROADMAP 거부 + meta 는 더 이상 project). → DESIGN 결정: development/ROADMAP 포인터를 root 에 별도 필드/섹션으로."},
    {"id": "cb_5", "ref": "milestone 검증 smoke 군 (spec-verification / scope-contract / bundle-trigger / open-stage-discipline / entry-title / candidate-draft) + .pre-commit-config.yaml files: 패턴", "finding": "이들은 `projects/*/milestones/...` 또는 `projects/*/ROADMAP.md` 를 enumerate/scope. meta 가 development/ 로 가면 **이 검증들이 development/ 를 놓침**. → 각 smoke 내부 enumerate glob + pre-commit files: 패턴에 development/ 추가 의무 (의미 불변, 경로만 확장). 단 smoke-projects-scope-discipline 은 projects-only 유지(cb_4). candidate-draft schema_note hardcode = projects/meta/ROADMAP.md 참조도 갱신."},
    {"id": "cb_6", "ref": "tests/_era_detect.py:24 (실 읽기)", "finding": "projects/meta 는 **docstring 예시 주석에만** 등장 (logic 은 mdir.name regex 기반). 로직 영향 0 — 주석만 선택적 갱신."},
    {"id": "cb_7", "ref": "narrative/instruction 파일 ~25 (9 stage skill + claude/commands/* + agents/* + 루트 CLAUDE.md + claude/CLAUDE.md + tests/CLAUDE.md + bootstrap/*/CLAUDE.md + AGENTS.md + README.md + GUARDRAILS.md + docs/adr/ADR-006)", "finding": "instruction 텍스트 안 projects/meta 경로 거명. find/replace 성격 (development/ 로) 이나 case-by-case 검토 — 일부는 '예시 경로', 일부는 활성 지시. historical 기록(CHANGELOG/_archive/upbit audit/fixtures)은 보존(역사)."}
  ],
  "options": [
    {"id": "opt_1", "label": "smoke 확장 = projects/* + development/ 양쪽 enumerate (의미 보존)", "rationale": "1단계 = '경로만 이동, 의미 불변' 정합. milestone 검증 smoke 가 두 경로를 동일 로직으로 훑게 확장. projects-scope-discipline 만 projects-only 유지(development 는 project 아님)."},
    {"id": "opt_2", "label": "root ROADMAP — meta entry 제거 + development 포인터 별도 필드 신설", "rationale": "thin-index projects[] regex(projects-only) 불변 유지 + development/ROADMAP 를 root 에 `development_roadmap` 또는 별도 섹션으로 가리킴. smoke-projects-scope-discipline 무수정."},
    {"id": "opt_3", "label": "git mv 단일 호출 (projects/meta → development)", "rationale": "~200 milestone + ARCHITECTURE/ROADMAP/CLAUDE + version-log 동시 이동 + history 보존. 자기 이사 atomic."},
    {"id": "opt_4 (rejected)", "label": "development 도 projects[] regex 에 포함하도록 regex 완화", "rationale": "REJECT — meta=project 라는 잘못된 분류를 smoke 레벨에서 재고착. 재구성 본질(meta≠project) 역행."}
  ],
  "risks_identified": [
    {"id": "risk_1", "description": "smoke enumerate glob 또는 pre-commit files: 패턴 중 1곳 누락 → development/ milestone 검증 silent gap (회귀 차단 무력화)", "mitigation": "EXECUTE 에서 smoke 군 전수 grep('projects/' + 'milestones') + pre-commit-config files: 패턴 전수 확인 + 이동 후 development/v8.0 자체가 검증되는지 E2E 확인 (PASS 입증)."},
    {"id": "risk_2", "description": "git mv 후 milestone 내부 상대/절대 cross-ref 깨짐 (특히 ../../ 상대경로 또는 projects/meta 절대 거명)", "mitigation": "내부 상대(../../CLAUDE.md 등)는 development/ 안에서도 같은 깊이라 유효. 절대 거명(projects/meta/...)은 historical 기록이라 보존 허용. smoke-cross-ref 로 broken ref 0 확인."},
    {"id": "risk_3", "description": "버전-log 경로(statusline/hook) 또는 propose_next 경로 갱신 누락 → version-track/propose-next 기능 무음 고장", "mitigation": "cb_2/cb_3 2개 파일 3개 지점 명시 갱신 + 이동 후 propose_next.py --scan 실행 + statusline 수동 확인."},
    {"id": "risk_4", "description": "narrative 파일 ~25 일괄 치환 중 historical 기록까지 잘못 변경 (audit trail 훼손)", "mitigation": "활성 instruction(skill/command/agent/CLAUDE.md) vs historical(CHANGELOG/_archive/upbit audit/fixtures) 분리 — 후자는 보존. cb_7 분류 따라 case-by-case."},
    {"id": "risk_5", "description": "본 milestone 디렉토리(projects/meta/milestones/v8.0) 자체가 EXECUTE 도중 이동 → 작업 중 경로 변경 혼란", "mitigation": "git mv 를 phase 안에서 먼저 수행 → 이후 작업은 development/milestones/v8.0/ 기준. 새 세션 EXECUTE 라 혼란 최소(처음부터 development/ 인지)."}
  ]
}
```

### Narrative

본 RESEARCH 핵심: 디렉토리 이동의 *진짜 비용*은 "경로를 로직/검증에 쓰는" 소수 지점에 집중돼 있고, plugin 배포·대다수 historical 기록은 영향이 없다.

**3대 behavior-critical 배선** (반드시 갱신): (1) `propose_next.py` milestones enumerate (cb_2), (2) `statusline.sh` + `session-start-version-track.sh` version-log 경로 (cb_3), (3) milestone 검증 smoke 군 + pre-commit `files:` 패턴의 `projects/*` scope (cb_5). 이 셋을 놓치면 기능이 *조용히* 고장 나거나 검증 gap 이 생긴다 (risk_1/risk_3).

**root ROADMAP thin index** (cb_4): meta 가 더 이상 project 가 아니므로 projects[] 에서 meta entry 제거 + development/ROADMAP 는 별도 포인터로 (opt_2). thin-index regex(projects-only)는 그대로 두고 smoke-projects-scope-discipline 무수정 — 이게 "meta≠project" 재분류를 smoke 레벨에서도 정직하게 반영하는 방식 (opt_4 regex 완화는 거부 — 잘못된 분류 재고착이라).

**보존 원칙**: 대다수 참조(~200 milestone 기록 + CHANGELOG + _archive + upbit audit + fixtures)는 historical 이라 폴더째 이동되거나 그대로 보존된다 (risk_2/risk_4). 활성 instruction(~25 narrative 파일)만 development/ 로 갱신 — case-by-case (cb_7).

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "d_1", "decision": "smoke 확장 = opt_1 — milestone 검증 smoke 군(spec-verification/scope-contract/bundle-trigger/open-stage-discipline/entry-title/candidate-draft)의 enumerate scope 와 .pre-commit-config.yaml files: 패턴에 development/ 추가 (projects/* 와 동일 로직). smoke-projects-scope-discipline 만 projects-only 유지.", "rationale": "1단계 = 경로만 이동·의미 불변. development 를 project 로 재고착하는 opt_4(regex 완화)는 거부 (cb_4/risk_1)."},
    {"id": "d_2", "decision": "root ROADMAP = opt_2 — projects[] 에서 meta entry 제거(projects[]=[upbit]만), development/ROADMAP 는 sibling 포인터(예: top-level `development` 필드 또는 §섹션)로. thin-index projects[] regex(projects-only) 불변 + smoke-projects-scope-discipline 무수정.", "rationale": "meta≠project 재분류를 thin-index 에서도 정직 반영 (cb_4)."},
    {"id": "d_3", "decision": "git mv 단일 호출 — `git mv projects/meta development` (~200 milestone + ARCHITECTURE/ROADMAP/CLAUDE + claude-code-version-log.md 동시 이동, history 보존).", "rationale": "atomic 이동 + 내부 상대 cross-ref 유효 유지 (ext_2/risk_2/opt_3). 본 milestone(v8.0) 자체도 같이 이동."},
    {"id": "d_4", "decision": "historical 보존 — CHANGELOG.md + milestones/_archive/** + projects/upbit/audit-* + tests/fixtures/** 안 projects/meta 절대 거명은 갱신 안 함(역사적 record).", "rationale": "audit trail 훼손 회피 (risk_4). 활성 instruction 만 갱신 (cb_7)."},
    {"id": "d_5", "decision": "5 관점 review = inline self-review (lightweight).", "rationale": "토큰 효율 (memory feedback-token-efficiency-priority) + 최근 meta cycle inline 패턴 정합. decisive 시 subagent escalate."},
    {"id": "d_6", "decision": "2-phase 구성 — phase-1(이동 + behavior-critical 배선) / phase-2(thin-index 재구성 + 활성 narrative sweep).", "rationale": "behavior-critical(기능 고장 위험)을 먼저 묶어 E2E 검증, narrative(저위험 텍스트)를 분리. risk_5 — git mv 를 phase-1 맨 앞에 두어 이후 작업이 development/ 기준."}
  ],
  "approach": "본 milestone = 2-phase. **phase-1 = 디렉토리 이동 + 3대 behavior-critical 배선**: (a) `git mv projects/meta development` (b) scripts/propose_next.py 안 'projects/meta/milestones' → 'development/milestones' (line 24 주석 + 112 로직) (c) claude/statusline/statusline.sh:30 + claude/hooks/session-start-version-track.sh:20,36 안 'projects/meta/claude-code-version-log.md' → 'development/...' (d) milestone 검증 smoke 군 내부 enumerate glob(`projects/*` → `projects/*` + `development`) + .pre-commit-config.yaml files: 패턴(`projects/[^/]+/milestones`·`projects/.*/ROADMAP` 에 development/ alternative 추가) (e) smoke-candidate-draft-schema 안 schema_note hardcode 'projects/meta/ROADMAP.md' → 'development/ROADMAP.md'. **phase-2 = thin-index + narrative**: (f) root ROADMAP.md projects[] 에서 meta 제거 + development 포인터 추가 (g) 활성 instruction ~25 파일(9 stage skill + claude/commands/* + agents/* + 루트·claude·tests·bootstrap CLAUDE.md + AGENTS.md + README.md + GUARDRAILS.md + docs/adr/ADR-006) 안 'projects/meta' → 'development' (historical 제외, d_4). 각 phase 끝 smoke 검증.",
  "phases": [
    {"phase": "phase-1", "scope": "git mv projects/meta→development + behavior-critical 배선 (propose_next.py / statusline.sh / session-start-version-track.sh / 검증 smoke 군 enumerate glob + pre-commit files: 패턴 / candidate-draft schema_note)", "deliverable": "development/ (이동 완료) + 위 스크립트·smoke·pre-commit 갱신. 별책 development/milestones/v8.0/execute/phase-1.md", "verification": "(1) git status 로 rename 추적 확인 (2) bash tests/smoke-spec-verification.sh PASS + development/v8.0 stage 가 enumerate 됨 확인 (3) bash tests/smoke-open-stage-discipline.sh PASS (4) python scripts/propose_next.py --scan 정상 (5) grep 'projects/meta' scripts/ claude/statusline claude/hooks = 잔존 0"},
    {"phase": "phase-2", "scope": "root ROADMAP thin-index 재구성(meta 제거 + development 포인터) + 활성 narrative ~25 파일 development/ 갱신 (historical 제외)", "deliverable": "ROADMAP.md(root) + 활성 instruction 파일군. 별책 execute/phase-2.md", "verification": "(1) bash tests/smoke-projects-scope-discipline.sh PASS (2) bash tests/smoke-cross-ref.sh PASS (broken ref 0) (3) bash tests/smoke-claude-md-drift.sh PASS (4) python scripts/cascade_sync.py --check no drift (5) pre-commit run --all-files 전체 PASS (6) grep 'projects/meta' = 활성 파일 잔존 0 (historical 만 잔존)"}
  ],
  "risk_mitigation": [
    {"risk_ref": "risk_1", "decision_ref": "d_1", "method": "smoke 군 전수 + pre-commit files: 전수 확장 + phase-1 검증에서 development/v8.0 自 검증 E2E 입증."},
    {"risk_ref": "risk_2", "decision_ref": "d_3", "method": "git mv 단일 이동 + 내부 상대경로 동일 깊이 유지 + smoke-cross-ref broken ref 0 확인 (phase-2 검증)."},
    {"risk_ref": "risk_3", "decision_ref": "d_6", "method": "3대 배선 phase-1 명시 갱신 + propose_next --scan 실행 + grep 잔존 0 확인."},
    {"risk_ref": "risk_4", "decision_ref": "d_4", "method": "historical(CHANGELOG/_archive/upbit/fixtures) 보존 — 활성 instruction 만 갱신."},
    {"risk_ref": "risk_5", "decision_ref": "d_6", "method": "git mv 를 phase-1 첫 step 으로 → 이후 모든 작업 development/ 기준. 새 세션 EXECUTE 라 처음부터 development/ 인지."}
  ],
  "five_perspective_review": {
    "method": "inline self-review (lightweight)",
    "perspectives": [
      {"perspective": "architecture", "verdict": "PASS", "comments": "meta≠project 재분류가 § 3.1 정체성(repo=제품, meta진화=제품개발)과 정합. projects/=외부 적용 전용 정리. thin-index regex 불변 + development sibling 포인터 = 분류 정직 반영 (d_2). 단 development/ 도입은 ARCHITECTURE.md 안 디렉토리 구조 narrative 갱신을 phase-2 에서 동반해야 — EXECUTE 시 ARCHITECTURE 구조 단락 점검 (pass-with-comments 수준이나 phase-2 scope 안 포함됨)."},
      {"perspective": "spec-drift", "verdict": "PASS", "comments": "plugin.json 무영향(ext_1) + Anthropic Claude Code spec 안 'milestone 디렉토리 위치' 규약 부재(자체 컨벤션) → 외부 drift 위험 0. git mv 표준 (ext_2)."},
      {"perspective": "security", "verdict": "PASS", "comments": "순수 파일 이동 + 경로 문자열 갱신, 실행 권한·외부 노출 변화 0. thin-index regex(path traversal-safe single-segment) 불변 유지."},
      {"perspective": "performance", "verdict": "PASS", "comments": "1회성 구조 작업. inline review 로 토큰 최적. git mv 단일 호출 = O(1) 이동."},
      {"perspective": "dx", "verdict": "pass-with-comments", "comments": "이후 meta 작업 경로가 development/ 로 바뀜 — 근육기억 전환 비용 소량. 단 '제품 개발'이라는 명명이 더 직관적 (인테리어 vs 운영규정 비유). 2단계(가벼운 흐름)에서 carry-over 가 풍부한 결정 맥락을 담지 못한 v7.0 교훈 반영 candidate (PROPOSE 거명 자연)."}
    ]
  }
}
```

### Narrative

본 DESIGN: 6 decisions + 2-phase approach + 5 risk_mitigation + 5 관점 inline review (decisive 0 / PASS 4 / pass-with-comments 1 / FAIL 0).

**전략** — behavior-critical(기능 고장·검증 gap 위험)을 phase-1 에 묶어 먼저 E2E 검증하고, 저위험 narrative 텍스트를 phase-2 로 분리. git mv 는 phase-1 첫 step (이후 모든 작업 development/ 기준, risk_5). historical 기록은 보존(d_4) — 활성 instruction 만 갱신.

**EXECUTE 자족성** (새 세션 대비) — phase-1/phase-2 의 (a)~(g) step 과 각 검증 명령이 approach 안에 구체 명시돼 있어, /clear 후 새 세션이 본 DESIGN 만 읽고 따라 실행 가능. RESEARCH cb_2~cb_7 이 정확한 파일·라인 좌표 제공.

**architecture review nuance** — development/ 도입 시 ARCHITECTURE.md 안 "projects/<name>/ 고정 구조" narrative + 디렉토리 구조 설명 단락도 phase-2 활성 narrative sweep 에 포함해 development/ 를 반영해야 한다 (CLAUDE.md 구조 규칙 § 도 동반 갱신 대상).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-26",
    "approval_method": "다라운드 pre-PLAN 대화(진단 합의 → A/B 층위 분리 → 깊이 결정 '단계적 재구성' → 새 집 이름 development/ → 부트스트랩/세션 분할 합의) 후 AskUserQuestion 'v8.0 1단계 DESIGN 확정 + EXECUTE 진입 승인?' 에 '승인 — APPROVE 박고 종료' 응답 (DESIGN 평이 walkthrough 재검토 1회 포함).",
    "scope_confirmed": [
      "R1: 진단 = 분류 오류(B)가 뿌리 / 9단계 무거움(A)은 파생 / 동결·lightweight 2 반창고는 봉합 (사용자 '맞아' 확인)",
      "R2: 재구성 = meta 는 repo 제품 자체의 개발 이력 → projects/ 밖 최상위로, projects/ 는 외부 적용 전용",
      "R3: 깊이 = 단계적 재구성 (1단계 위치 이동만 / 2단계 가벼운 흐름+반창고 은퇴 / 검증철학 별도)",
      "R4: 새 집 이름 = development/",
      "R5: 세션 분할 = OPEN~APPROVE 는 맥락 살아있는 이 세션에서 디스크에 박고, EXECUTE~PROPOSE 는 /clear 후 새 세션 (v7.0 carry-over 증발 교훈 — 풍부한 결정 맥락은 carry-over 아닌 milestone 아티팩트에)",
      "R6: DESIGN 확정 — 2-phase (phase-1 이동+behavior-critical 배선 / phase-2 thin-index+활성 narrative), historical 보존, inline review, EXECUTE 진입 승인"
    ]
  }
}
```

### Narrative

사용자 명시 승인 완료 (2026-05-26). 본 APPROVE 가 EXECUTE 진입 게이트 — CLAUDE.md § 개발 프로세스('~/harness-meta/ repo 변경은 커밋 전 사용자 확인 필수') 정합.

**세션 경계** (R5) — 본 milestone 은 OPEN → INTENT → RESEARCH → DESIGN → APPROVE 까지 *맥락이 살아있는 본 세션*에서 디스크에 박혔다. EXECUTE 부터는 /clear 후 새 세션이 본 MILESTONE.md(특히 ## DESIGN approach 의 (a)~(g) step + 각 phase verification + ## RESEARCH cb_2~cb_7 파일·라인 좌표)를 읽고 자족적으로 진행한다. 이로써 v7.0 의 'carry-over 가 얕아 의도 증발' 문제를 원천 차단 — 결정 맥락이 thin carry-over 가 아니라 on-disk 아티팩트에 보존된다.

**부트스트랩** — 본 milestone(현 9단계 lightweight)이 projects/meta era 의 마지막 milestone. phase-1 git mv 시 자기 자신(projects/meta/milestones/v8.0/)이 development/milestones/v8.0/ 로 같이 이동해 자기 이사를 스스로 기록한다.

## EXECUTE

### Spec

```json
{
  "phases_executed": [
    {"phase": 1, "title": "디렉토리 이동 + behavior-critical 배선", "status": "complete", "detail": "execute/phase-1.md"},
    {"phase": 2, "title": "cross-ref 보정 + thin-index + 활성 narrative sweep", "status": "complete", "detail": "execute/phase-2.md"}
  ],
  "commit_structure": "phase-1+2 통합 1 commit — pre-commit cross-ref/scope-discipline 가 git mv 와 narrative 보정을 불가분 결합 (phase-1 단독 커밋 FAIL). 논리 분리는 execute/ 별책 2건 보존.",
  "design_deviations": [
    "RESEARCH risk_2 가정 오류 — projects/meta(2 세그먼트) → development(1 세그먼트) 깊이 -1 변경으로 이동 ~200 파일의 repo-root 거슬러가는 상대 ref 363건 어긋남 (risk_2 는 '같은 깊이 유지' 로 가정).",
    "올바른 해법 = cross-ref _VER_MILE 제외 패턴에 development/milestones 확장 (immutable milestone history 검사 대상 외 유지) → _archive 134 broken ref 무수정 보존 (d_4 + settings.json hard_deny 정합). 깊이 보정은 development/ 루트 active 파일 + 비이동 narrative 만.",
    "DESIGN 미열거 배선 3건 EXECUTE 발견 — post-report-write.sh (generic projects/[^/]+ 패턴이라 literal grep 미포착) + .github/workflows/release-publish.yml + tests/fixtures/audit-fact-verify (live 경로 검증 fixture)."
  ]
}
```

### Narrative

2-phase 실행 (논리 분리), pre-commit 결합으로 1 commit. EXECUTE 중 RESEARCH 깊이-보존 가정 오류 발견 → 사용자 게이트('development/ 원안 + 보정' 선택) → 더 깊은 발견(cross-ref 가 milestone history 를 path 패턴으로 제외) 후 _archive 무수정 + 제외 패턴 확장이라는 더 깨끗한 해법 도달. 상세 = execute/phase-1.md + phase-2.md.

## VERIFY

### Spec

```json
{
  "smoke_tests": [
    {"name": "pre-commit run --all-files", "result": "PASS", "output": "18 hook 전부 Passed (shellcheck/markdownlint + active smoke 12 + 기본 5)"},
    {"name": "smoke-cross-ref", "result": "PASS", "output": "broken ref 0건 (363 → 0)"},
    {"name": "smoke-spec-verification", "result": "PASS", "output": "PASS=452 FAIL=0 SKIP=240 + development/v8.0 enumerate"},
    {"name": "smoke-projects-scope-discipline", "result": "PASS", "output": "projects[]=upbit only, development_roadmap 별도 필드"},
    {"name": "smoke-claude-md-drift", "result": "PASS", "output": "13/13"},
    {"name": "smoke-cascade-drift", "result": "PASS", "output": "all 1 host in sync"},
    {"name": "smoke-audit-fact-verify", "result": "PASS", "output": "PASS=9 (table-normal exit0 복원)"},
    {"name": "propose_next.py --scan", "result": "PASS", "output": "directory_names=[v8.0,v7.1,v7.0,v6.23,v6.22] (development enumerate)"}
  ],
  "criteria_check": [
    {"id": "sc_1", "verdict": "PASS", "evidence": "git mv 681 rename (history 보존), development/ = ARCHITECTURE+ROADMAP+CLAUDE+claude-code-version-log+milestones(~200). projects/ = upbit only."},
    {"id": "sc_2", "verdict": "PASS", "evidence": "active 파일 projects/meta 잔존 = tests/smoke-cross-ref.sh 주석 1건('(구) projects/meta...' 이동 설명, 의도적 historical 거명)만. 기능 ref 0."},
    {"id": "sc_3", "verdict": "PASS", "evidence": "pre-commit 18 hook + 핵심 smoke 전부 PASS, FAIL=0."},
    {"id": "sc_4", "verdict": "PASS", "evidence": ".claude-plugin/plugin.json projects/meta 참조 0 (ext_1 정합) — plugin discovery 무영향."},
    {"id": "sc_5", "verdict": "PASS", "evidence": "9-stage stage 정의/skill 로직/smoke 판정 로직 의미 불변 (경로 문자열 + enumerate scope만 확장). 반창고(동결 정책/lightweight) 미은퇴, 검증철학 미변경, upbit 구조 미변경."}
  ],
  "verdict": "pass",
  "regressions": []
}
```

### Narrative

sc 5/5 PASS, verdict pass, 회귀 0. 검증 핵심 = pre-commit 18 hook 전부 PASS (특히 cross-ref 363→0, projects-scope-discipline, audit-fact-verify fixture). development/v8.0 자체가 spec-verification 에 enumerate 됨을 E2E 확인 (risk_1 mitigation 입증).

## REPORT

### Spec

```json
{
  "summary": "meta = repo 제품 자체의 개발 이력 재구성 1단계 — projects/meta/ 전체를 최상위 development/ 로 git mv (681 rename, history 보존) + 살아있는 배선 갱신. projects/ 에는 외부 적용(upbit)만 잔존. 순수 위치 재분류 (의미 불변) 로 기획됐으나, EXECUTE 중 projects/meta(2 세그먼트)→development(1 세그먼트) 깊이 -1 변경이 이동 파일의 상대 cross-ref 363건을 어긋나게 함을 발견. 사용자 게이트 후 더 깊은 발견 = cross-ref 가 milestone history 를 path 패턴으로 제외 → 제외 패턴을 development/milestones 까지 확장하여 _archive 134건 무수정 보존 (hard_deny 정합) + 깊이 보정은 development/ 루트 active 파일 + 비이동 narrative 만. behavior-critical 배선(propose_next/statusline/hook×2/6 smoke/pre-commit/settings.json/release workflow) + root ROADMAP thin-index 재구성(projects[]=upbit + development_roadmap 별도 필드) + 활성 narrative sweep(41 파일/186 occ) 완료. pre-commit 18 hook + sc 5/5 PASS.",
  "delta": {
    "files_changed": "git mv 681 rename + 배선/narrative ~50 파일 수정 + execute 별책 2 + MILESTONE.md",
    "added": ["development/milestones/v8.0/execute/phase-1.md", "development/milestones/v8.0/execute/phase-2.md", "ROADMAP.md development_roadmap 필드"],
    "deleted": [],
    "modules_affected": ["development/ (구 projects/meta, 전체 이동)", "scripts/propose_next.py", "claude/statusline + hooks×2", "tests/smoke-×6 + fixtures×2", ".pre-commit-config.yaml", ".claude/settings.json", ".github/workflows/release-publish.yml", "활성 narrative 41 파일", "ROADMAP.md(root)"]
  },
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "디렉토리 깊이 변경(세그먼트 수 변화)은 이동 파일 안 모든 repo-root-거슬러가는 상대 ref 를 깨뜨린다. RESEARCH risk_2 의 '같은 깊이 유지' 가정이 틀렸다 — projects/meta(2)→development(1). 향후 디렉토리 재배치 발의 시 RESEARCH 단계에서 '세그먼트 깊이 변화 여부 + 영향 상대 ref 수' 를 필수 측정."},
    {"id": "L2", "priority": "P1", "lesson": "smoke 의 path-scope 제외 패턴(cross-ref _VER_MILE)이 디렉토리 이동으로 silently 무력화될 수 있다. milestone history(immutable) 가 projects/meta→development 이동 시 제외 패턴이 안 맞아 ~200 history 파일이 새로 검사 대상이 됨. 올바른 해법 = 제외 패턴 scope 확장 (history 무수정 보존), history 파일 직접 수정 아님 (hard_deny/d_4 정합)."},
    {"id": "L3", "priority": "P2", "lesson": "behavior-critical 배선 검색은 literal grep('projects/meta')만으로 불충분 — generic 패턴(post-report-write.sh 의 projects/[^/]+/milestones) 사용 배선은 누락된다. 경로 재분류 RESEARCH 는 literal + generic('projects/' + 'milestones' regex) 양쪽 grep 필요."},
    {"id": "L4", "priority": "P2", "lesson": "pre-commit cross-ref 가 git mv(ROADMAP/cross-ref 트리거 파일 포함)와 narrative 보정을 불가분 결합 → 위치 이동 milestone 의 '이동 / 배선 / narrative' phase 분리는 논리적일 뿐 commit 분리 불가. 단일 commit + execute 별책 논리 분리가 현실적."},
    {"id": "L5", "priority": "P3", "lesson": "live-경로를 검증하는 test fixture(audit-fact-verify)는 historical 보존 대상이 아니라 현 repo 경로와 동기 필요 — 'tests/fixtures 보존'(d_4) 의 예외."}
  ]
}
```

### Narrative

본 milestone 은 '순수 위치 재분류' 의도였으나 EXECUTE 가 RESEARCH 의 핵심 가정(깊이 보존)을 반증하며 scope 가 커졌다. 그러나 cross-ref 제외 패턴 확장이라는 더 깨끗한 해법(immutable history 무수정 보존)에 도달해 결과적으로 hard_deny/d_4 와 정합. lessons L1/L2 가 핵심 — 디렉토리 깊이 변경의 상대-ref 파급 + smoke path-scope 제외 패턴의 이동 취약성.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {"id": "meta-lightweight-flow-design", "title": "meta 전용 가벼운 흐름 설계·도입 (2단계)", "trigger": "A_user", "trigger_type": "사용자 명시 발의 (v8.0 oos_1)", "description": "v8.0 oos_1 origin — 위치 재분류(1단계) 완료 후, development/ 거주 meta-work 에 맞는 가벼운 흐름(문제→결정→적용→기록) 설계 + 동결 정책·lightweight 1-phase 두 반창고 은퇴(oos_2). 사용자 명시 발의 후 진행."},
    {"id": "verification-philosophy-redefine", "title": "검증철학 재정의 (dogfooding 은퇴, 외부 적용을 검증 vector)", "trigger": "A_user", "trigger_type": "사용자 명시 발의 (v8.0 oos_3)", "description": "v8.0 oos_3 origin — meta≠project 재분류 후, dogfooding 착시를 은퇴하고 외부 적용(upbit 등)을 1차 검증 vector 로 재정의. 별도 후속, 천천히."}
  ],
  "propose_summary": "v8.0 oos_1~3 의 후속 2단계(가벼운 흐름+반창고 은퇴) + 검증철학 재정의를 next_candidates 등재. lessons L1~L5 는 자동 candidate 화 부재 — 본 2 candidate 는 v8.0 INTENT.out_of_scope 의 명시 후속(사용자 결정 origin)."
}
```

### Narrative

v8.0 은 재구성의 1단계(위치 이동). 후속 = 2단계(가벼운 흐름 + 반창고 은퇴, oos_1+oos_2) + 검증철학 재정의(oos_3). 두 candidate 는 ROADMAP next_candidates[] 등재 — 사용자 명시 결정 게이트 후 milestone 화 (v7.0 T1.2 절제 정합).

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
