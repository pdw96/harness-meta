---
id: ai-native-mechanism-installation
title: AI Native 6 mechanism 설치 (외부 vector 운영)
version: v7.0
status: completed
---

# v7.0 — AI Native 6 mechanism 설치 (외부 vector 운영)

## INTENT

### Spec

```json
{
  "id": "ai-native-mechanism-installation",
  "title": "AI Native 6 mechanism 설치 (외부 vector 운영)",
  "goal": "Claude Code 2026-w13+ 외부 vector (Auto-Mode / .claude/rules/ / SessionStart hook) 와 본 repo workflow 정합 6 mechanism 을 설치한다 — T1.6 버전추적 + T1.1 .claude/rules 3-way 직교 + T1.5 Auto-Mode 최소권한 + T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬 + T1.2 next_candidates 절제 (T1.6b 자연 흡수). v7.0 = 설치만, 첫 실사용 v7.1.",
  "motivation": "v6.x 시리즈 (AI Native § 7 3 면 정의 → 컨텍스트 효율 / 자율성 / 다중 AI 협업) 누적 후, Claude Code 2026-w13+ 외부 vector spec (Auto-Mode + .claude/rules/ path-scoped rule + SessionStart hook) 가 본 repo 의 자기 정전화 mechanism 들과 정합점 도달. root v7-redesign.md (의존 관계 결정) + v7-design.md (design 본문 1339 line, 13 정정 확정) 가 1차 source. 자기참조 회피 본질 (v7 작업 자체를 9-stage 안 진행 시 self-referential 충돌) 로 design 은 root gitignored→추적 전환 파일에 거주, 최종 audit trail = 본 v7.0 milestone INTENT·DESIGN (git tracked).",
  "success_criteria": [
    {"id": "sc_1", "criterion": "T1.6 버전추적 mechanism 설치 — SessionStart hook (claude --version 주입, 출력 전용) + version-tracker subagent + claude-code-version-log.md"},
    {"id": "sc_2", "criterion": "T1.1 .claude/rules/ 3-way 직교 설치 — 2 rule file (schema-discipline + candidate-draft-schema) + README + ARCHITECTURE § 9 + MEMORY 4 entry archival (audit fact 1건은 MEMORY 유지)"},
    {"id": "sc_3", "criterion": "T1.5 Auto-Mode 최소권한 mechanism 설치 — .claude/settings.json (autoMode 4 분류, repo-local) + ARCHITECTURE § 10. defaultMode:auto 미포함 (활성 v7.1 보류)"},
    {"id": "sc_4", "criterion": "T1.3 design-review N+가변 설치 — agents/design-review.md + Stage D narrative + 조건부 ## SCOPE_OUT_NOTES skeleton + ARCHITECTURE § 11"},
    {"id": "sc_5", "criterion": "T2.3 RESEARCH Explore 병렬 설치 — Stage C narrative + 작업 본질 type 매트릭스 (ARCHITECTURE § 11) + Explore prompt template"},
    {"id": "sc_6", "criterion": "T1.2 next_candidates 절제 + lessons P2 자동 enumerate 폐지 — propose_next.py + ROADMAP next_candidates wipe + SKILL/command/Stage I narrative. T1.6b version-tracker 권한 정전화 자연 흡수"},
    {"id": "sc_7", "criterion": "설치만 본질 — 자기적용/도그푸드 폐기 (정정 #7, 첫 실사용 v7.1) + smoke 전체 PASS"}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "v7.0 자체 자기적용 (도그푸드 cycle 1차) — 정정 #7 폐기. v7.0 = 6 mechanism 설치만, 첫 사용 = v7.1 (과거 commit 57a01ed v7 full rollback 위험 격리)."},
    {"id": "oos_2", "item": "T2.1 (milestone 산출물 GitHub Releases migration + 디스크 제거) — 정정 #1 완전 폐기. milestone 디스크 거주는 컨텍스트 부하 아님 (on-demand Read), git rm 은 /propose-next propose_next.py:109 와 충돌. milestone 디스크 유지."},
    {"id": "oos_3", "item": "Auto-Mode 활성 (permissions.defaultMode: \"auto\") — v7.0 mechanism 설치만, 활성 v7.1 보류 (정정 #7 + 사용자 '커밋·배포 전 확인' 협업 본질)."},
    {"id": "oos_4", "item": "Plugin 배포 (settings/rules) — plugin manifest 에 settings/rules 필드 부재 (context7 verify) → .claude/settings.json + .claude/rules/ = repo-local (harness-meta repo 전용, 배포 안 됨)."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "root v7-redesign.md (의존 관계 결정 진행 본질 + carry-over) + v7-design.md (design 본문 1339 line, 13 정정 확정)", "purpose": "본 milestone 1차 source — 진입 순서 (Tier 0 → 1 → 2 → 3 → 1.5) + 6 mechanism 결정 본질 + 13 정정 권위 source."},
    {"id": "dep_2", "ref": "Claude Code 2026-w13+ 외부 vector spec (Auto-Mode + .claude/rules/ + SessionStart hook, context7 /websites/code_claude verify 2026-05-25)", "purpose": "T1.5 / T1.1 / T1.6 mechanism 의 외부 spec source — 실재 verify 완료 (단 plugin 배포 불가 = repo-local 거주)."},
    {"id": "dep_3", "ref": "v6.0 AI Native § 7 3 면 정의 (컨텍스트 효율 / 자율성 / 다중 AI 협업)", "purpose": "6 mechanism ↔ 3 면 매핑 source — T1.1/T1.2 (컨텍스트 효율) + T1.5/T1.6/T1.3/T2.3 (자율성) + T2.3/T1.3/T1.6 (다중 AI 협업)."},
    {"id": "dep_4", "ref": "commit 57a01ed (v7.0/v7.1 폐기 — host 5 full rollback)", "purpose": "정정 #7 origin — v7 첫 시도 full rollback 위험 → v7.0 = 설치만 + 첫 사용 v7.1 격리 결정 source."}
  ]
}
```

### Narrative

본 milestone (v7.0) 은 **Claude Code 2026-w13+ 외부 vector 정합 6 mechanism 설치** — AI Native § 7 3 면 (컨텍스트 효율 / 자율성 / 다중 AI 협업) 누적 후 외부 vector spec (Auto-Mode + `.claude/rules/` + SessionStart hook) 와 본 repo workflow 정합점 도달. root `v7-redesign.md` (의존 관계 결정) + `v7-design.md` (design 본문 1339 line, **13 정정 확정**) 가 권위 1차 source — 본 MILESTONE.md 는 그 결과를 git-tracked audit trail 로 흡수.

**6 mechanism** (진입 순서 = 의존 관계 정합): Tier 0 (T1.6 버전추적 + T1.1 .claude/rules 3-way 직교) → Tier 1 (T1.5 Auto-Mode 최소권한) → Tier 2 (T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬) → Tier 3 (T1.2 next_candidates 절제) → Tier 1.5 (T1.6b version-tracker 권한 정전화, T1.5 자연 흡수).

**설치만 본질** (정정 #7, oos_1) — v7.0 자기적용 (도그푸드 cycle 1차) 폐기. 6 mechanism 은 파일로 설치되되 첫 실사용 = v7.1 (과거 commit `57a01ed` v7 full rollback 위험 격리). Auto-Mode 활성 (`defaultMode: "auto"`) 도 v7.1 보류 (oos_3).

**자기참조 회피** — v7 작업 자체를 9-stage 안 진행 시 self-referential 충돌 → design 본문은 root gitignored→추적 전환 파일 (`v7-redesign.md` + `v7-design.md`) 거주, 최종 audit trail = 본 milestone INTENT·DESIGN (정정 round 2026-05-25 정정 — "file 거주 자체가 audit trail" 주장 폐기, gitignored = 삭제 시 흔적 0 모순).

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "Claude Code Auto-Mode spec (context7 /websites/code_claude, 2026-05-25 verify)", "finding": "Auto-Mode 실재 ✓ — permissions.defaultMode:auto + autoMode 4 분류 (environment/allow/soft_deny/hard_deny) + $defaults inherit + PermissionRequest hook. 버전 표기 = 주차 '2026-w13' (정정 #2 — 'v2.1.33+' 표기 정정). 단 plugin manifest 에 settings 필드 부재 → 배포 불가 = repo-local."},
    {"id": "ext_2", "source": "Claude Code .claude/rules/ spec (context7, 2026-05-25)", "finding": ".claude/rules/ path-scoped rule 실재 ✓ — frontmatter paths: glob 매칭 시 자동 inject. plugin manifest 에 rules 필드 부재 → harness-meta repo 전용 (배포 안 됨, 정정 #3)."},
    {"id": "ext_3", "source": "Claude Code SessionStart/SubagentStop hook spec", "finding": "hook event 실재 ✓. 단 hook = 출력 전용 (system reminder 파싱 불가) — SessionStart hook 은 claude --version stdout 주입만, log 기록 = Claude/version-tracker 단일 writer (정정 #4 — 경합 + churn 제거)."}
  ],
  "codebase": [
    {"id": "cb_1", "ref": ".claude/settings.json (T1.5 생성) + .claude/rules/ (T1.1 생성)", "finding": "repo-local 거주 — plugin 배포 불가 (ext_1/ext_2). autoMode 4 분류 array + 2 rule file (schema-discipline + candidate-draft-schema)."},
    {"id": "cb_2", "ref": "claude/hooks/hooks.json + session-start-version-track.sh", "finding": "SessionStart hook 등록 = hooks.json (plugin.json 불변, 정정 #9). gate = claude-code-version-log.md 존재 (harness-meta repo marker)."},
    {"id": "cb_3", "ref": "agents/ (version-tracker.md + design-review.md) — plugin_root ./agents/ default discovery", "finding": "agents 자동 discovery (plugin.json 불변, 정정 #9). version-tracker (T1.6) + design-review (T1.3) read-only/minimal tools."},
    {"id": "cb_4", "ref": "claude/commands/harness-meta.md Stage C/D/I + propose-next.md", "finding": "현 Stage D '5 관점 subagent (가변 min 3)' 표 (L194~210) = T1.3 정정 대상 (정정 #5 — smoke 아님). Stage C codebase 필드 = T2.3 확장 대상. Stage I = T1.2 정정 대상."},
    {"id": "cb_5", "ref": "scripts/propose_next.py grep_lessons_p2() = len() count-only", "finding": "정정 #6 — script 에 lessons enumerate logic 부재 (count only). 폐지 대상 = narrative (propose-next.md + harness-meta.md Stage I + ARCHITECTURE § 4 #9). skills/propose-next 부재 (실 등가물 = claude/commands/propose-next.md)."},
    {"id": "cb_6", "ref": "tests/smoke-spec-verification.sh:307-326 H2_STAGE_MAP", "finding": "flattened era 안 필수 8 stage H2 섹션 존재만 검사 (닫힌 집합 아님) → 조건부 ## SCOPE_OUT_NOTES 추가 무해 (정정 #8 정합). smoke 5관점 검증 logic 부재 (정정 #5 — smoke 정정 = 헛작업)."},
    {"id": "cb_7", "ref": "CLAUDE.md:131 cascade marker → ARCHITECTURE#section-4-end-row-9", "finding": "ARCHITECTURE § 4 #9 = cascade source, CLAUDE.md blockquote = host. T1.2 § 4 #9 편집 시 host blockquote 수동 동기 + cascade_sync.py --apply hash 재동기 의무."},
    {"id": "cb_8", "ref": "ROADMAP next_candidates 33건 + deferred 3 + candidate_draft 1", "finding": "33 next_candidates = 부산물 cycle 누적 임시 후보 (중복 id 1건). T1.2 일괄 폐기 대상 (사용자 명시 게이트). deferred 3 + candidate_draft 1 = 별개 보존."}
  ],
  "options": [
    {"id": "opt_1", "label": "T1.5/T1.1 plugin 배포 (claude/settings.json + plugin.json settings paths)", "rationale": "design 초안 본질. 단 plugin manifest 에 settings/rules 필드 부재 (ext_1/ext_2) → 배포 불가. rejected → repo-local .claude/ 거주 (정정 #2/#3)."},
    {"id": "opt_2", "label": "T1.6 hook 이 system reminder 파싱 + log overwrite/append", "rationale": "design 초안 본질. 단 hook = 출력 전용 (ext_3) → 파싱 불가. rejected → hook = stdout 주입만 + 단일 writer Claude/subagent (정정 #4)."},
    {"id": "opt_3", "label": "T1.3 5 관점 → N+ 가변 + scope 안/외 분리 (design-review subagent perspectives parameterized)", "rationale": "현 고정 5 관점 = 작은 작업 과잉 / 큰 작업 부족. N+ 가변 = 작업 본질 + scope 크기 자연 발현 (3~10). 채택 (Tier 2)."},
    {"id": "opt_4", "label": "T1.2 33 next_candidates 일괄 폐기 vs 선별", "rationale": "33건 = 부산물 cycle 누적 임시 후보. 일괄 폐기 (git history 보존) 우선 — T1.2 = 자동 누적 cycle 폐지 본질. 사용자 명시 게이트 (선별 옵션 제공)."},
    {"id": "opt_5", "label": "작업 본질 type 매트릭스 거주 = ARCHITECTURE 새 § vs commands narrative", "rationale": "T1.3 ↔ T2.3 양쪽 공유 mechanism → long-lived 1차 source 적합. ARCHITECTURE § 11 채택 (사용자 결정), commands 는 pointer."}
  ],
  "risks_identified": [
    {"id": "risk_1", "description": "v7 첫 시도 full rollback (commit 57a01ed) 재발 위험 — 자기적용 도그푸드 cycle 안 unstable mechanism 즉시 사용", "mitigation": "정정 #7 — v7.0 = 설치만, 첫 사용 v7.1 격리 (oos_1). Auto-Mode 활성도 v7.1 보류 (oos_3)."},
    {"id": "risk_2", "description": "조건부 ## SCOPE_OUT_NOTES 추가가 smoke-spec-verification H2 검사 깨뜨림", "mitigation": "cb_6 — smoke 는 필수 8 stage 섹션 존재만 검사 (닫힌 집합 아님). 추가 섹션 무해 검증 완료."},
    {"id": "risk_3", "description": "T1.2 § 4 #9 편집 (cascade source) 시 CLAUDE.md host drift", "mitigation": "cb_7 — host blockquote 수동 동기 + cascade_sync.py --apply hash 재동기 + smoke-cascade-drift 검증 (3 단계 패턴)."},
    {"id": "risk_4", "description": "design 초안 5 정정 (#5 smoke 헛작업 / #6 skills/propose-next 부재 등) 미반영 시 헛작업", "mitigation": "13 정정 권위 source (v7-design.md L12-27) 우선 + 적용점 EXECUTE-time 실 검증 (cb_5/cb_6 grep)."},
    {"id": "risk_5", "description": "T1.6b ↔ T1.5 순환 의존 (권한 정전화가 mechanism source 의존)", "mitigation": "2 단계 분리 — T1.6a (Tier 0 mechanism 도입) → T1.5 (Tier 1 mechanism source) → T1.6b (Tier 1.5 권한 정전화). 순차 의존 해소."}
  ]
}
```

### Narrative

본 RESEARCH 안 4 본질 (external 3 + codebase 8 + options 5 + risks 5) — 외부 vector spec 실재 verify (context7) + design 13 정정의 codebase 적용점 직접 검증 1차 source 인용 본위. 상세 = `v7-design.md` § 검토 round 정정 결과 (13 건).

**핵심 finding 1: 외부 vector 실재하되 plugin 배포 불가** — Auto-Mode (ext_1) + `.claude/rules/` (ext_2) spec 은 실재하나 plugin manifest 에 settings/rules 필드 부재 → `.claude/settings.json` + `.claude/rules/` = **repo-local** (harness-meta repo 전용, 정정 #2/#3). SessionStart hook (ext_3) 은 출력 전용 = system reminder 파싱 불가 → hook = `claude --version` stdout 주입만, log 단일 writer (정정 #4).

**핵심 finding 2: design 초안 5 정정의 실 적용점** — (정정 #5) smoke 에 5관점 logic 부재 = smoke 정정 헛작업 / (정정 #6) propose_next.py 는 lessons count-only + skills/propose-next 부재 → 실 등가물 = claude/commands/propose-next.md / (정정 #8) ## SCOPE_OUT_NOTES 조건부 = smoke 닫힌 집합 아님 무해 / (정정 #9) hooks.json + agents default discovery = plugin.json 불변. EXECUTE-time grep 직접 검증 (cb_5/cb_6).

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "d_1", "decision": "T1.5/T1.1 = repo-local .claude/ 거주 (plugin 배포 폐기)", "rationale": "ext_1/ext_2 — plugin manifest 에 settings/rules 필드 부재. opt_1 rejected. .claude/settings.json + .claude/rules/ = harness-meta repo 전용. 정정 #2/#3."},
    {"id": "d_2", "decision": "T1.6 hook = stdout 주입만 + 단일 writer (Claude/version-tracker)", "rationale": "ext_3 — hook 출력 전용. opt_2 rejected. SessionStart hook = claude --version 주입, log 기록 = subagent/Claude 단독 (경합 + churn 제거). 정정 #4."},
    {"id": "d_3", "decision": "T1.3 = N+ 가변 + scope 안/외 분리 + design-review subagent (perspectives parameterized, read-only)", "rationale": "opt_3 — 고정 5 관점 폐기, 작업 본질 + scope 크기 자연 발현 (3~10). subagent 중첩 불가 → 1 invoke 안 N 관점 순차 통합 (정정 #5). scope 외 = ## SCOPE_OUT_NOTES 조건부 (정정 #8)."},
    {"id": "d_4", "decision": "작업 본질 type 매트릭스 + 발현 mechanism 거주 = ARCHITECTURE § 11 (단일 source)", "rationale": "opt_5 — T1.3 ↔ T2.3 양쪽 공유 → long-lived 1차 source. commands Stage C/D = pointer. 사용자 결정 (2026-05-25)."},
    {"id": "d_5", "decision": "T1.2 = lessons P2 자동 종합 폐지 (script + narrative) + next_candidates 자동 append 폐지 + 33건 일괄 폐기", "rationale": "cb_5/cb_8 — 부산물 cycle 폐지. script lessons grep/count 제거 + narrative 정정 + ROADMAP next_candidates wipe (사용자 명시 게이트, opt_4). 정정 #6."},
    {"id": "d_6", "decision": "v7.0 = 설치만 (자기적용 폐기) + T2.1 완전 폐기", "rationale": "정정 #7 — full rollback 위험 격리 (risk_1, oos_1). 정정 #1 — T2.1 milestone 디스크 거주 부하 전제 거짓 + git rm propose_next 충돌 (oos_2)."},
    {"id": "d_7", "decision": "EXECUTE = 5 phase (Tier 단위 1 commit) — phase-1 Tier0 / phase-2 Tier1 / phase-3 Tier2 / phase-4 Tier3 / phase-5 Tier1.5", "rationale": "진입 순서 (Tier 0 → 1 → 2 → 3 → 1.5) = 의존 관계 정합. per-phase 1 commit (conventional commits). T1.6b = Tier 1.5 (T1.5 자연 흡수)."}
  ],
  "approach": "본 milestone = 5-phase (Tier 단위) mechanism 설치 — root v7-design.md 13 정정 권위 source 흡수 + 각 Tier 진입 시 사용자 명시 게이트 (3 AskUserQuestion + 5 commit 확인). 자기적용 폐기 (설치만, d_6) + 외부 vector repo-local 거주 (d_1) + 작업 본질 발현 mechanism ARCHITECTURE § 11 단일 source (d_4). 산출물 정식화 (본 MILESTONE.md) = 설치 완료 후 git-tracked audit trail.",
  "phases": [
    {"phase": "phase-1", "scope": "Tier 0 — T1.6 버전추적 (hook + version-tracker + version-log) + T1.1 .claude/rules 3-way 직교 (2 rule file + README + ARCHITECTURE § 9 + MEMORY 4 archival)", "deliverable": "execute/phase-1.md", "verification": "pre-commit 전체 PASS + MEMORY.md index 17→13"},
    {"phase": "phase-2", "scope": "Tier 1 — T1.5 Auto-Mode 최소권한 (.claude/settings.json autoMode 4 분류 + ARCHITECTURE § 10, defaultMode 미포함)", "deliverable": "execute/phase-2.md", "verification": "settings.json JSON valid + pre-commit PASS"},
    {"phase": "phase-3", "scope": "Tier 2 — T1.3 design-review (agents/design-review.md + Stage D + 조건부 SCOPE_OUT_NOTES + § 11) + T2.3 RESEARCH Explore 병렬 (Stage C + type 매트릭스)", "deliverable": "execute/phase-3.md", "verification": "smoke-agent-frontmatter + spec-verification + cross-ref PASS"},
    {"phase": "phase-4", "scope": "Tier 3 — T1.2 next_candidates 절제 (propose_next.py lessons 제거 + ROADMAP wipe 33→0 + narrative + § 4 #9 cascade 동기)", "deliverable": "execute/phase-4.md", "verification": "candidate-draft-schema + cascade-drift + entry-title PASS"},
    {"phase": "phase-5", "scope": "Tier 1.5 — T1.6b version-tracker 권한 정전화 (.claude/settings.json allow + soft_deny 각 1줄, T1.5 자연 흡수)", "deliverable": "execute/phase-5.md", "verification": "settings.json JSON valid + pre-commit PASS"}
  ],
  "risk_mitigation": [
    {"risk_ref": "risk_1", "decision_ref": "d_6", "method": "v7.0 = 설치만 + 첫 사용 v7.1 격리 (oos_1) + Auto-Mode 활성 v7.1 보류 (oos_3). full rollback 위험 회피."},
    {"risk_ref": "risk_2", "decision_ref": "d_3", "method": "cb_6 — smoke 필수 8 stage 섹션 존재만 검사. 조건부 SCOPE_OUT_NOTES 무해 검증 완료 (phase-3)."},
    {"risk_ref": "risk_3", "decision_ref": "d_5", "method": "cb_7 — host blockquote 수동 동기 + cascade_sync.py --apply hash 재동기 + smoke-cascade-drift 'all 1 host in sync' (phase-4)."},
    {"risk_ref": "risk_4", "decision_ref": "d_5", "method": "13 정정 권위 source 우선 + EXECUTE-time grep 직접 검증 (정정 #5 smoke 헛작업 회피 / 정정 #6 skills/propose-next 부재 실 등가물 적용)."},
    {"risk_ref": "risk_5", "decision_ref": "d_7", "method": "T1.6 2 단계 분리 (T1.6a Tier0 → T1.5 Tier1 → T1.6b Tier1.5) — 순차 의존 해소."}
  ],
  "five_perspective_review": {
    "method": "inline self-review (lightweight, v6.17~v6.23 7 cycle 누적 패턴 정합) + 진행 중 3 AskUserQuestion 사용자 게이트",
    "perspectives": [
      {"perspective": "architecture", "verdict": "PASS", "comments": "5-phase Tier 단위 = 진입 순서 의존 관계 정합 (d_7). 외부 vector repo-local 거주 (d_1) = plugin manifest 제약 정합. § 11 단일 source = T1.3/T2.3 공유 mechanism 적합 (d_4). § 9/§ 10/§ 11 = v7.0 신규 3 섹션."},
      {"perspective": "spec-drift", "verdict": "PASS", "comments": "Auto-Mode + .claude/rules/ + hook spec context7 verify 완료 (ext_1/2/3). 정정 #2 버전 표기 '2026-w13' (주차) + plugin 배포 불가 정정 반영. v5.7 spike (c) 자체 정전화 분기 (외부 spec 부분 부재 → repo-local 컨벤션)."},
      {"perspective": "security", "verdict": "pass-with-comments", "comments": "Auto-Mode 활성 v7.1 보류 (oos_3) = 권한 baseline 변경 없음 (안전). soft_deny/hard_deny 안 _archive 무결성 + commit 게이트 보존. T1.6b version-tracker 단일 file write 제한 (soft_deny 명시)."},
      {"perspective": "scope-contract", "verdict": "pass-with-comments", "comments": "설치만 (oos_1) + T2.1 폐기 (oos_2) + 활성 보류 (oos_3) + plugin 배포 폐기 (oos_4) 4 scope 외 명확. 첫 실사용 v7.1 = scope 외 (PROPOSE narrative). 6 mechanism = SUB_MILESTONES."},
      {"perspective": "regression", "verdict": "PASS", "comments": "5 commit 모두 pre-commit 전체 PASS (smoke 18 hook). 조건부 SCOPE_OUT_NOTES smoke 무해 (risk_2) + cascade #9 재동기 (risk_3) + MEMORY 4 archival (audit fact 1건 유지). 회귀 0."}
    ]
  }
}
```

### Narrative

본 DESIGN 안 7 decisions + 5-phase approach + 5 risk_mitigation + 5 관점 inline review (decisive 0 + PASS 3 + pass-with-comments 2 + FAIL 0) — root `v7-design.md` 13 정정 권위 source 흡수. 상세 design 본문 = `v7-design.md` (1339 line, Tier 0~1.5 + 통합 § + adoption mechanism).

**Decisions 핵심**: d_1 (repo-local 거주, 정정 #2/#3) + d_2 (hook stdout-only, 정정 #4) + d_3 (N+가변 + scope 분리, 정정 #5/#8) + d_4 (§ 11 단일 source, 사용자 결정) + d_5 (lessons/next_candidates 폐지 + 33 wipe, 정정 #6) + d_6 (설치만 + T2.1 폐기, 정정 #1/#7) + d_7 (5-phase Tier 단위).

**3 면 매핑** (AI Native § 7): 컨텍스트 효율 = T1.1 (.claude/rules lazy load) + T1.2 (next_candidates 절제) / 자율성 = T1.5 (Auto-Mode) + T1.6 (자동 버전추적) + T1.3/T2.3 (Claude 자동 분야 발현 + 사용자 게이트) / 다중 AI 협업 = T2.3 (Explore parallel) + T1.3 (design-review) + T1.6 (hook ↔ subagent 책임 분리).

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-25",
    "approval_method": "per-Tier 사용자 명시 게이트 — 5 commit 확인 ('응' × 5) + 3 AskUserQuestion 결정 게이트 (Tier 2 § 11 거주 + commit 단위 / Tier 3 33 entry 처리). design 13 정정 round (사용자 + Claude, 2026-05-25) 누적.",
    "scope_confirmed": [
      "G1 (Tier 0): T1.6 + T1.1 설치 commit 034f0e8 확인",
      "G2 (Tier 1): T1.5 설치 commit 7e83ce7 확인",
      "G3 (Tier 2 AskUserQuestion): 작업 본질 type 매트릭스 거주 = ARCHITECTURE § 11 + commit 단위 = 한 commit (T1.3+T2.3)",
      "G4 (Tier 2): T1.3+T2.3 설치 commit f28375b 확인",
      "G5 (Tier 3 AskUserQuestion): next_candidates 33건 = 전체 비우기 (git history 보존)",
      "G6 (Tier 3): T1.2 설치 commit 857a85b 확인",
      "G7 (Tier 1.5): T1.6b 설치 commit fb3e057 확인",
      "G8 (정식화): v7.0 milestone 산출물 정식화 진행 확인"
    ]
  }
}
```

### Narrative

본 APPROVE 안 사용자 명시 승인 = **per-Tier 게이트** (CLAUDE.md '~/harness-meta/ repo 변경은 커밋 전 사용자 확인 필수' 본질 정합). 5 commit 각각 '응' 확인 + 3 AskUserQuestion 결정 게이트 (§ 11 거주 / commit 단위 / 33 entry 처리). design 13 정정 round (2026-05-25) 가 사전 승인 trace.

본 milestone 은 retroactive 정식화 — 실 EXECUTE (5 commit) 는 per-Tier 사용자 승인 후 진행 완료, 본 APPROVE 는 그 승인 trail 을 git-tracked audit 로 capture. 자기참조 회피 본질 (design root 거주) 정합.

## EXECUTE

### Spec

```json
{
  "phases_executed": [
    {"phase": "phase-1", "status": "completed", "deliverable_path": "execute/phase-1.md", "commits": [{"sha": "034f0e8", "message": "feat(meta): v7.0 T1.6 버전추적 + T1.1 .claude/rules 3-way 직교"}], "summary": "Tier 0 — SessionStart hook (claude --version 주입) + version-tracker subagent + claude-code-version-log.md + .claude/rules 2 file + README + ARCHITECTURE § 9 + MEMORY 4 entry archival (17→13)."},
    {"phase": "phase-2", "status": "completed", "deliverable_path": "execute/phase-2.md", "commits": [{"sha": "7e83ce7", "message": "feat(meta): v7.0 T1.5 Auto-Mode 최소권한 mechanism (설치만, 활성 v7.1 보류)"}], "summary": "Tier 1 — .claude/settings.json autoMode 4 분류 (environment/allow/soft_deny/hard_deny) repo-local + ARCHITECTURE § 10. defaultMode:auto 미포함 (활성 v7.1 보류)."},
    {"phase": "phase-3", "status": "completed", "deliverable_path": "execute/phase-3.md", "commits": [{"sha": "f28375b", "message": "feat(meta): v7.0 Tier 2 — T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬 (설치만)"}], "summary": "Tier 2 — agents/design-review.md + Stage D N+가변 narrative + 조건부 ## SCOPE_OUT_NOTES skeleton 3곳 + Stage C RESEARCH Explore 병렬 + ARCHITECTURE § 11 (작업 본질 type 매트릭스) + § 10.2 갱신."},
    {"phase": "phase-4", "status": "completed", "deliverable_path": "execute/phase-4.md", "commits": [{"sha": "857a85b", "message": "feat(meta): v7.0 Tier 3 — T1.2 next_candidates 절제 + lessons P2 자동 enumerate 폐지"}], "summary": "Tier 3 — propose_next.py lessons P2 grep/count 제거 + ROADMAP next_candidates 33→0 + schema_note + propose-next.md/Stage I/stage-propose narrative + ARCHITECTURE § 4 #9 cascade source + CLAUDE.md host 동기 (hash 재동기)."},
    {"phase": "phase-5", "status": "completed", "deliverable_path": "execute/phase-5.md", "commits": [{"sha": "fb3e057", "message": "feat(meta): v7.0 Tier 1.5 — T1.6b version-tracker 권한 정전화 (T1.5 자연 흡수)"}], "summary": "Tier 1.5 — .claude/settings.json autoMode.allow (version-log write 허용) + soft_deny (log 외 write 금지) 각 1줄 + version-tracker.md 권한 note 완료. frontmatter 정정 부재 (이미 minimal)."}
  ]
}
```

### Narrative

본 EXECUTE 안 5-phase (Tier 단위) 진행 — 5 commit (034f0e8 / 7e83ce7 / f28375b / 857a85b / fb3e057), 진입 순서 Tier 0 → 1 → 2 → 3 → 1.5 (의존 관계 정합, d_7). 각 phase 별책 = `execute/phase-{n}.md` (changes / verification / commit trace).

phase 별 사용자 명시 게이트 통과 (APPROVE G1~G7) — 각 commit 전 '응' 확인 + Tier 2/3 안 AskUserQuestion 결정 게이트 (§ 11 거주 / commit 단위 / 33 entry 처리). T1.6b (phase-5) = T1.5 mechanism 직접 inherit (Tier 1.5 자연 흡수, 순환 의존 해소).

EXECUTE 도중 처리 본질 — phase-4 안 cascade #9 source 편집 → CLAUDE.md host blockquote 수동 동기 + cascade_sync.py --apply hash 재동기 (2313949d → dbc51f0). phase-1 안 MEMORY 4 entry archival (audit fact 1건 = cross-project 일반 원칙 → MEMORY 유지, 3-way 직교 정합).

## VERIFY

### Spec

```json
{
  "smoke": {
    "method": "각 phase commit 시 pre-commit 18 hook 전체 + 정식화 commit 시 smoke-spec-verification + scope-contract + open-stage-discipline + bundle-trigger + cross-ref + roadmap-sync",
    "result": "전 phase commit pre-commit PASS + 정식화 smoke 전체 PASS",
    "detail": "5 phase commit (034f0e8/7e83ce7/f28375b/857a85b/fb3e057) 모두 pre-commit 18 hook 전체 PASS. phase-3 조건부 SCOPE_OUT_NOTES smoke 무해 (smoke-spec-verification PASS=426 FAIL=0). phase-4 cascade-drift 'all 1 host in sync' (hash 재동기) + candidate-draft-schema PASS (propose_next.py 실행, lessons_p2_count 제거 후). phase-5 settings.json JSON valid + pre-commit PASS."
  },
  "criteria_check": [
    {"sc_ref": "sc_1", "verdict": "PASS", "evidence": "T1.6 — claude/hooks/session-start-version-track.sh + agents/version-tracker.md + projects/meta/claude-code-version-log.md 생성 (commit 034f0e8). hook = stdout 주입만 (정정 #4)."},
    {"sc_ref": "sc_2", "verdict": "PASS", "evidence": "T1.1 — .claude/rules/{schema-discipline,candidate-draft-schema}.md + README + ARCHITECTURE § 9 (commit 034f0e8). MEMORY 17→13 (4 archival, audit fact 1건 유지 정정 #3)."},
    {"sc_ref": "sc_3", "verdict": "PASS", "evidence": "T1.5 — .claude/settings.json autoMode 4 분류 + ARCHITECTURE § 10 (commit 7e83ce7). defaultMode:auto 미포함 (oos_3)."},
    {"sc_ref": "sc_4", "verdict": "PASS", "evidence": "T1.3 — agents/design-review.md + Stage D N+가변 + 조건부 ## SCOPE_OUT_NOTES skeleton 3곳 + ARCHITECTURE § 11 (commit f28375b)."},
    {"sc_ref": "sc_5", "verdict": "PASS", "evidence": "T2.3 — Stage C RESEARCH Explore 병렬 + 작업 본질 type 매트릭스 § 11.3 + Explore prompt template (commit f28375b)."},
    {"sc_ref": "sc_6", "verdict": "PASS", "evidence": "T1.2 — propose_next.py lessons 제거 + ROADMAP next_candidates 33→0 + narrative (commit 857a85b). T1.6b version-tracker 권한 정전화 (commit fb3e057, sc 자연 흡수)."},
    {"sc_ref": "sc_7", "verdict": "PASS", "evidence": "설치만 — 자기적용 폐기 (oos_1) + 첫 사용 v7.1. 전 phase commit pre-commit PASS + 정식화 smoke 전체 PASS."}
  ],
  "risk_check": [
    {"risk_ref": "risk_1", "mitigation_verdict": "MITIGATED", "evidence": "설치만 (d_6) — 자기적용/Auto-Mode 활성 v7.1 보류 (oos_1/oos_3). full rollback 위험 회피."},
    {"risk_ref": "risk_2", "mitigation_verdict": "MITIGATED", "evidence": "조건부 SCOPE_OUT_NOTES — smoke-spec-verification PASS=426 FAIL=0 (필수 8 stage 섹션 존재만 검사, cb_6)."},
    {"risk_ref": "risk_3", "mitigation_verdict": "MITIGATED", "evidence": "cascade #9 — host 수동 동기 + cascade_sync.py --apply (2313949d → dbc51f0) + smoke-cascade-drift 'all 1 host in sync'."},
    {"risk_ref": "risk_4", "mitigation_verdict": "MITIGATED", "evidence": "13 정정 반영 — smoke 5관점 정정 헛작업 회피 (정정 #5) + skills/propose-next 부재 실 등가물 적용 (정정 #6) EXECUTE-time grep 검증."},
    {"risk_ref": "risk_5", "mitigation_verdict": "MITIGATED", "evidence": "T1.6 2 단계 분리 (T1.6a phase-1 → T1.5 phase-2 → T1.6b phase-5) — 순차 의존 해소."}
  ],
  "verdict": "RESOLVED"
}
```

### Narrative

본 VERIFY 안 sc 7/7 PASS + risk 5/5 MITIGATED + 전 phase commit + 정식화 smoke 전체 PASS → verdict = **RESOLVED**.

**Smoke 검증**: 5 phase commit 모두 pre-commit 18 hook 전체 PASS. phase-3 조건부 SCOPE_OUT_NOTES = smoke-spec-verification PASS=426 FAIL=0 (필수 8 stage 섹션 존재만 검사 무해). phase-4 cascade-drift 'all 1 host in sync' (hash 재동기) + candidate-draft-schema PASS (propose_next.py lessons 제거 후 정상). phase-5 settings.json JSON valid.

**Criteria check**: sc_1~sc_7 모두 PASS — 6 mechanism (T1.6/T1.1/T1.5/T1.3/T2.3/T1.2+T1.6b) 설치 완료 + 설치만 본질 (oos_1). evidence = commit SHA + 생성 파일 path 직접 인용.

**Risk mitigation**: 5 risks 모두 MITIGATED — full rollback 회피 (설치만) + SCOPE_OUT_NOTES smoke 무해 + cascade #9 재동기 + 13 정정 반영 + 2 단계 분리 순환 의존 해소.

## REPORT

### Spec

```json
{
  "summary": "Claude Code 2026-w13+ 외부 vector 정합 6 mechanism 설치 milestone — Tier 0 (T1.6 버전추적 + T1.1 .claude/rules 3-way 직교) → Tier 1 (T1.5 Auto-Mode 최소권한) → Tier 2 (T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬) → Tier 3 (T1.2 next_candidates 절제) → Tier 1.5 (T1.6b 권한 정전화). 설치만 (정정 #7, 첫 사용 v7.1) + T2.1 완전 폐기 (정정 #1). root v7-design.md 13 정정 권위 source. 5 commit + 5-phase + sc 7/7 PASS + risk 5/5 MITIGATED + verdict RESOLVED.",
  "delta": {
    "files_created": 9,
    "files_created_list": ["agents/version-tracker.md", "agents/design-review.md", "claude/hooks/session-start-version-track.sh", ".claude/settings.json", "projects/meta/claude-code-version-log.md", ".claude/rules/schema-discipline.md", ".claude/rules/candidate-draft-schema.md", ".claude/rules/README.md", "projects/meta/milestones/v7.0/ (MILESTONE.md + execute/phase-1~5.md)"],
    "files_edited_list": ["CLAUDE.md", "projects/meta/ARCHITECTURE.md (§ 9/§ 10/§ 11 신규 + § 4 #9 정정 + § 6.1)", "projects/meta/CLAUDE.md", "claude/CLAUDE.md", "claude/hooks/hooks.json", "claude/commands/harness-meta.md (Stage C/D/I)", "claude/commands/propose-next.md", "skills/stage-open/SKILL.md", "skills/stage-propose/SKILL.md", "scripts/propose_next.py", "projects/meta/ROADMAP.md"],
    "memory_archival": "MEMORY.md index 17→13 (4 entry → .claude/rules/, audit fact 1건 MEMORY 유지)",
    "commits": "6 (mechanism 5: 034f0e8 + 7e83ce7 + f28375b + 857a85b + fb3e057 + 정식화 본 commit) + design 추적 commit (49aac63 등)",
    "smoke": "전 phase commit pre-commit 18 hook PASS + 정식화 smoke 전체 PASS"
  },
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "description": "외부 spec 실재 ≠ plugin 배포 가능 — Auto-Mode/.claude/rules spec 실재하나 plugin manifest 에 settings/rules 필드 부재 → repo-local 거주 강제 (정정 #2/#3).", "context": "design 초안은 plugin 배포 가정 → context7 verify 안 manifest 필드 부재 발견 → .claude/settings.json + .claude/rules/ = harness-meta repo 전용. v5.7 spec-drift spike (c) 분기 (외부 spec 부분 부재 → repo-local 컨벤션) 자연 발현.", "next_action_candidate": "신규 외부 vector mechanism 도입 시 plugin manifest 필드 지원 여부 사전 verify 의무. 별 milestone 발의 부재 (본 cycle 흡수)."},
    {"id": "L2", "priority": "P1", "description": "design 초안 13 정정 = pre-PLAN 검토 round 가치 evidence direct — 정정 #1 (T2.1 전제 거짓) + #5 (smoke 헛작업) + #6 (skills/propose-next 부재) 등 헛작업 5+ 회피.", "context": "v7-design.md L12-27 13 정정 — milestone 디스크 부하 전제 거짓 / hook 출력 전용 / smoke 5관점 logic 부재 / propose_next count-only 등 EXECUTE-time grep 검증으로 확정. MEMORY feedback_iterative_pre_plan_review 직접 정합.", "next_action_candidate": "design 본문 작성 후 적용점 grep 검증 의무 (헛작업 회피). 본 cycle 흡수."},
    {"id": "L3", "priority": "P2", "description": "설치 ≠ 사용 분리 본질 (정정 #7) — v7.0 = 6 mechanism 설치만, 첫 사용 v7.1. full rollback (57a01ed) 위험 격리 evidence.", "context": "과거 v7 첫 시도 = 자기적용 도그푸드 안 unstable mechanism 즉시 사용 → full rollback. v7.0 = 설치/사용 분리 + Auto-Mode 활성 v7.1 보류. risk_1 mitigation 직접.", "next_action_candidate": "v7.1 = 설치된 6 mechanism 첫 실사용 cycle + Auto-Mode 활성 결정. 별 milestone 자연 (사용자 명시 발의)."},
    {"id": "L4", "priority": "P2", "description": "## SUB_MILESTONES 첫 multi-sub 실 활용 cycle 2 — v6.23 (2 sub) 후 v7.0 (6 mechanism sub). bundling cycle ≥2 sub 자연 발현 정합 (cb_3 정전 본질).", "context": "v7.0 = 6 mechanism 통합 milestone → ## SUB_MILESTONES 6 entry. v6.23 첫 실 활용 (2 sub) 후 cycle 2. bundling 본질 = 후속 candidates ≥2 자연 활용 도구 (ARCHITECTURE § 6.1 정합).", "next_action_candidate": "bundling cycle ≥2 sub 자연 발현 정합 (강제 부재). 본 cycle 흡수."},
    {"id": "L5", "priority": "P2", "description": "자기참조 회피 본질 (design root 거주) — v7 작업 자체를 9-stage 안 진행 시 self-referential 충돌 → design root gitignored→추적 전환 + 최종 audit trail = git-tracked MILESTONE.md.", "context": "v7-design.md L9 — 'file 거주 자체가 audit trail' 주장 폐기 (gitignored = 삭제 시 흔적 0 모순, 정정 round). 최종 = v7.0 milestone INTENT·DESIGN (본 정식화 cycle).", "next_action_candidate": "workflow 자체 재설계 milestone = root 자유 형식 design → git-tracked milestone 정식화 패턴. 본 cycle 흡수."}
  ]
}
```

### Narrative

본 REPORT 안 v7.0 종합 backward — 외부 vector 정합 6 mechanism 설치 milestone, sc 7/7 PASS + risk 5/5 MITIGATED + verdict RESOLVED. 6 commit (mechanism 5 + 정식화) + 5-phase (Tier 단위) + 9 file 생성 + 11 file 편집 + MEMORY 17→13.

**Outcome 본질**: 6 mechanism (T1.6/T1.1/T1.5/T1.3/T2.3/T1.2 + T1.6b 자연 흡수) 설치 완료 — 외부 vector (Auto-Mode + .claude/rules + SessionStart hook) repo-local 거주 (정정 #2/#3) + hook 출력 전용 (정정 #4) + N+가변 review (정정 #5/#8) + lessons/next_candidates 절제 (정정 #6) + 설치만 (정정 #7) + T2.1 폐기 (정정 #1). root v7-design.md 13 정정 권위 source.

**Lessons**: 5 lessons (P1 × 2 + P2 × 3) — L1 (외부 spec 실재 ≠ plugin 배포, repo-local 강제) + L2 (13 정정 = pre-PLAN 검토 가치, 헛작업 5+ 회피) + L3 (설치 ≠ 사용 분리, full rollback 격리) + L4 (SUB_MILESTONES cycle 2, 6 sub) + L5 (자기참조 회피 design root 거주). 모두 본 cycle 흡수 (별 milestone 발의 부재) — 자율 발의 폐지 (T1.2 정합, next_candidates 자동 append 부재).

**Archival**: ROADMAP milestones[] = v7.0 (completed) + v6.23 + v6.22 (recent 3). v6.21 entry 제거 (v6.19+ GitHub Releases 단일 source, CHANGELOG 추가 부재 자연, v6.23 선례 정합).

## PROPOSE

### Spec

```json
{
  "next_candidates": [],
  "next_candidates_named_only": [
    "v7.1 = 설치된 6 mechanism 첫 실사용 cycle + Auto-Mode 활성 (permissions.defaultMode:auto) 결정 (L3 origin, oos_1/oos_3) — 사용자 명시 발의 자연. T1.2 정합 (자동 등재 부재, 본 PROPOSE next_candidates=[] 본질)."
  ]
}
```

### Narrative

본 PROPOSE 안 **next_candidates = []** — T1.2 정전화 직접 적용 (lessons P2/P3 자동 enumerate 폐지 + next_candidates 자동 append 폐지). 본 milestone lessons (L1~L5) 는 모두 본 cycle 흡수 (별 milestone 자동 발의 부재).

**v7.1 첫 실사용** (next_candidates_named_only 거명만) — 설치된 6 mechanism 의 첫 실사용 cycle + Auto-Mode 활성 (`permissions.defaultMode: "auto"`) 결정 (L3 origin). 단 **자동 등재 부재** — 사용자 명시 발의 게이트 후만 ROADMAP next_candidates 등재 (T1.2 본질 정합, 본 PROPOSE next_candidates=[] 자체가 evidence direct).

본 PROPOSE = v7.0 설치 완료 + T1.2 자동 append 폐지 첫 적용 cycle (next_candidates=[] = 부산물 cycle 차단 본질 직접 evidence).

## SUB_MILESTONES

본 milestone = **6 mechanism 통합 본질** (v6.2+ flattened era ## SUB_MILESTONES 2번째 실 활용 cycle, v6.23 첫 활용 후). 6 mechanism = Claude Code 2026-w13+ 외부 vector 정합 + AI Native § 7 3 면 매핑 — 진입 순서 (Tier 0 → 1 → 2 → 3 → 1.5) = 의존 관계 정합.

### v7.0.1 — T1.6 버전추적 mechanism (Tier 0, phase-1)

- **본질**: SessionStart hook (`claude --version` stdout 주입, 출력 전용 정정 #4) + version-tracker subagent (context7 query, 사용자 명시 trigger) + `claude-code-version-log.md` (단일 writer). AI Native § 7.2 자율성 면.
- **commit**: 034f0e8

### v7.0.2 — T1.1 .claude/rules 3-way 직교 (Tier 0, phase-1)

- **본질**: `.claude/rules/` 2 file (schema-discipline + candidate-draft-schema, repo-local) + README + ARCHITECTURE § 9. CLAUDE.md (always-loaded) ↔ .claude/rules/ (path-scoped) ↔ MEMORY (cross-session) 3-way 직교. MEMORY 4 archival (audit fact 1건 유지). AI Native § 7.1 컨텍스트 효율 면.
- **commit**: 034f0e8

### v7.0.3 — T1.5 Auto-Mode 최소권한 (Tier 1, phase-2)

- **본질**: `.claude/settings.json` autoMode 4 분류 (environment/allow/soft_deny/hard_deny, repo-local 정정 #2) + ARCHITECTURE § 10. defaultMode:auto 미포함 (활성 v7.1 보류). AI Native § 7.2 자율성 면.
- **commit**: 7e83ce7

### v7.0.4 — T1.3 design-review N+가변 (Tier 2, phase-3)

- **본질**: `agents/design-review.md` (read-only, perspectives parameterized) + Stage D 고정 5관점 → N+가변 + scope 안/외 분리 + 조건부 `## SCOPE_OUT_NOTES` (정정 #8) + ARCHITECTURE § 11. AI Native § 7.3 다중 AI 협업 면.
- **commit**: f28375b

### v7.0.5 — T2.3 RESEARCH Explore 병렬 (Tier 2, phase-3)

- **본질**: Stage C RESEARCH cb 분야 Explore parallel 매핑 + 작업 본질 type 매트릭스 (ARCHITECTURE § 11, T1.3 공유) + Explore prompt template. AI Native § 7.3 다중 AI 협업 면.
- **commit**: f28375b

### v7.0.6 — T1.2 next_candidates 절제 + T1.6b 권한 정전화 (Tier 3 + 1.5, phase-4/5)

- **본질**: lessons P2 자동 enumerate 폐지 (propose_next.py + narrative) + next_candidates 자동 append 폐지 + 33건 일괄 폐기 (사용자 게이트). T1.6b = version-tracker 권한 정전화 (.claude/settings.json allow + soft_deny, T1.5 자연 흡수). AI Native § 7.1 컨텍스트 효율 면.
- **commit**: 857a85b (T1.2) + fb3e057 (T1.6b)

**자기참조 회피 본질** — 본 milestone 은 외부 vector 운영 mode 전환 (commit 20b2873 'mechanism-cleanup-external-pivot' 정합) 후 첫 실 설치 cycle. design 본문 root 거주 (`v7-redesign.md` + `v7-design.md`) → 최종 audit trail = 본 git-tracked MILESTONE.md (L5 정합).
