# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-19",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v5.21",
      "id": "roadmap-forward-looking-redesign-and-changelog-archival",
      "title": "ROADMAP forward-looking 재정의 (recent 3건 + next_candidates only) + CHANGELOG.md v5.7~v5.20 14 entry backfill + completed 41건 archival + cascade 7 host narrative",
      "status": "in_progress",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.21/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-19) — 'ROADMAP 사전적 의미 = 이정표 미래지향, 최근 완료 + PROPOSE 제안만 보존'. § 4 끝 #3 narrative (ROADMAP 단어 drift 수용, v5.9 정전화, ~30~40% 부합) drift 해소 첫 evidence-base trigger 사례. Schema A2 채택 (milestones[] recent 3 + in_progress + deferred / next_candidates[] 별도). 5요소 매핑 = Trace (b) mechanism cross-ref 갱신 (sub-mechanism 분리). v5.21 minor (additive). 3-phase + 5 관점 검토 (5/5 pass-with-comments + decisive 0 + P1 6건 + P2 4건 흡수). v6.0_workflow-automation-and-least-privilege 별 milestone 예약 (next_candidates#1)."
    },
    {
      "version": "v5.20",
      "id": "audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade",
      "title": "audit-team 외부 호출 cycle 7 + ARCHITECTURE § 4 끝 7 paragraph 매트릭스화 + agent namespace prefix cascade — stability 3 cycle 연속 (5+6+7) + v5.19 PROPOSE#4+#8 동시 흡수 + Plugin spec v5.0+ namespace 정합",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.20/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-19). scenario B (3-phase bundling) — v5.19 PROPOSE#4+#8 + spec-drift D1 동시 흡수. audit chain 4 멤버 upbit cycle 7 + diff-vs-cycle6 + § 4 끝 stability paragraph + L135 vector 6→7 + 7 paragraph 매트릭스화 + namespace cascade 7 위치. stability cycle 두 번째 (cycle 5+6+7 동일 baseline). hallucination 2건 inline 정정. narrative effect isolation 한계 첫 확인. v3.21 21+22 cycle. bundling 정당화. 4 commit + 7 lessons."
    },
    {
      "version": "v5.19",
      "id": "external-audit-team-cycle-6-call",
      "title": "audit-team 외부 호출 cycle 6 — upbit 대상 + v5.17 cycle 5 diff + v5.18 Input Verification + 검증 method 분리 효과 검증 + ecosystem integrator vector 6건 누적 + stability cycle 첫 완성",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.19/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-19). v5.18 PROPOSE.next_candidates#3 carry-over. project-harness-audit-team 4 멤버 upbit 대상 여섯 번째 read-only 실 호출 + v5.17 cycle 5 산출물 diff + v5.13 fact 검증 절차 네 번째 실전 + v5.16 lint precheck 절차 두 번째 실전 + v5.18 Input Verification + 검증 method 분리 narrative 첫 실전. ecosystem integrator vector 6건 누적. stability cycle 첫 완성 (cycle 5+6 0 commit + R1+R2 2 cycle 연속 APPLIED). self-loop 76% (19/25). v5.18 narrative 첫 실전 = hallucination 0건. MD034 11건 inline 정정. v3.21 19+20 cycle. lightweight 14/32 = 43.75%. 2 commit + 7 lessons."
    },
    {
      "version": "v5.18",
      "id": "audit-chain-direct-read-and-verification-depth",
      "title": "audit chain agent prompt 'input 산출물 직접 Read 의무' 명시 + v5.13 fact 검증 절차 깊이 강화 (검증 method 분리) — v5.17 PROPOSE #1+#4 통합, cycle 9 evidence 도달 trigger",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.18/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-18). v5.17 PROPOSE.next_candidates#1+#4 통합 (audit chain hallucination cycle 9 누적). 변경 = (a) audit chain 4 read-only 멤버 agent .md 안 `## Input Verification` H2 sub-section 추가 + (b) v5.13 절차 정전화 2 위치 안 '검증 method 분리 (boolean/표/수치 별 매핑)' sub-narrative 추가 + (c) ARCHITECTURE § 4 끝 v5.18 cross-ref 흡수 + (d) memory feedback cycle 누적 narrative. 3-layer 정전화 패턴 (v5.13/v5.16 baseline) 정합. 1 phase 통합 commit (2e44260, 8 파일 72+/2-). 4 관점 검토 PASS/pass_with_comments + decisive 0 + spec-drift P1+P2+P3 흡수. lightweight 13/31 = 41.9%. v3.21 19 cycle. 7 lessons."
    },
    {
      "version": "v1.4_hook-narrative-separation",
      "title": "hook hard-code 메시지 narrative 분리 (post-report-write.sh)",
      "status": "deferred",
      "trigger": "D_design",
      "summary": "v1.3 § 3.1 명료화 단락 거명 자동화 #2 'hook hard-code'. post-report-write.sh inject 메시지를 shell 안에 박지 않고 MD 파일에 분리, hook 은 단순 reader.",
      "deferred_reason": "workflow self-improvement 본질, v3.13/v3.14 동결 결정 정합. v4.0 § 6.2 폐지 후 재발의 trigger 조건 = 외부 적용 5건+ ∧ 사용자 명시 발의 AND."
    },
    {
      "version": "v1.4_design-review-trace",
      "title": "Stage E 5 관점 검토 raw 출력 보존 (milestones/.../design-review/)",
      "status": "deferred",
      "trigger": "D_design",
      "summary": "v1.3 § 3.3 매트릭스 'Trace' = 정전 + 메타 고유 차별화이나 현재 Stage E subagent 5 관점 검토 결과는 DESIGN.md 통합 후 raw 출력 소실. milestones/v{X.Y}_*/design-review/{architecture,spec-drift,...}.md 로 보존.",
      "deferred_reason": "workflow self-improvement 본질, v3.13/v3.14 동결 결정 정합. v4.0 § 6.2 폐지 후 재발의 trigger 조건 = 외부 적용 5건+ ∧ 사용자 명시 발의 AND."
    },
    {
      "version": "v1.5_research-cascade-grep-discipline",
      "title": "RESEARCH 단계 cascade grep 패턴 강화 (relative + 절대 + symlink)",
      "status": "deferred",
      "trigger": "B_regression",
      "summary": "v1.4 lessons_learned #1 — RESEARCH 단계 cascade list grep 이 relative path (`../ARCHITECTURE.md`) 누락 (1건). claude/commands/harness-meta.md 또는 RESEARCH 템플릿 보강 — cascade RESEARCH 시 relative + 절대 + symlink 모두 grep 패턴 강화 의무 명시.",
      "deferred_reason": "workflow self-improvement 본질, v3.13/v3.14 동결 결정 정합. v4.0 § 6.2 폐지 후 재발의 trigger 조건 = 외부 적용 5건+ ∧ 사용자 명시 발의 AND."
    }
  ],
  "next_candidates": [
    {
      "id": "workflow-automation-and-least-privilege",
      "title": "9-stage 자동 전환 + per-stage 최소 권한 원칙 (PoLP) 적용 + 사전적 정의 1:1 매핑 강화",
      "trigger": "A_user",
      "origin_milestone": "v5.21",
      "target_version": "v6.0",
      "description": "사용자 명시 발의 (A_user, 2026-05-19) — 'MD+JSON 자동 전환 구현 + 각 stage 사전적 정의에 따른 최소 권한 원칙 적용'. 9 stage 별 도구 권한 매트릭스 정의 (OPEN: Bash+Write+Edit / INTENT: Write / RESEARCH: Read+Grep+Glob+Write / DESIGN: Read+Write+Agent / APPROVE: AskUserQuestion+Write / EXECUTE: 전체 / VERIFY: Bash+Read / REPORT: Read+Write / PROPOSE: Write+Edit). 구현 메커니즘 후보 = (1) 9 stage slash command 분리 + frontmatter allowed-tools 명시 / (2) 9 stage agent 신규 + tools 매트릭스 + orchestrator sequential 호출 (agent-fleet-maintainer 정체성 직접 부합) / (3) Hook 확장 + 자동 skeleton 생성 + Claude 안내 / (4) 단일 slash command 인자 분기. v6.0 major bump (Workflow 본질 재정의 = breaking, v4.0 정체성 / v5.0 Plugin 선례 정합). breaking change cascade — claude/commands/ + bootstrap/agents/ + claude/hooks/hooks.json + smoke + cascade host 영향 폭. 5요소 매핑 = Workflow (b) mechanism cross-ref 갱신 + (c) 정전 강화 (단어-책임-도구 1:1 매핑). v5.21 PROPOSE.next_candidates#1 origin."
    }
  ]
}
```

## 의도 (v5.21+ schema A2)

본 ROADMAP 은 **forward-looking 이정표** — 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 정합. `milestones[]` = 현재 진행 (in_progress) + 최근 완료 (recent 3건, carry-over context) + deferred (재발의 trigger 조건 보유) + `next_candidates[]` = PROPOSE 발의 후보 (forward-looking 본질).

**과거 completed entry archival** = [`../../CHANGELOG.md`](../../CHANGELOG.md) (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). trace 3중 보존:

1. **CHANGELOG.md entry** — 외부 visible artifact (release note 동치)
2. **milestones/v{X.Y}/REPORT.md** — milestone 종합 backward (lessons + delta)
3. **git log** — 원자 commit history + diff

## v5.21 정전화 1차 source

본 schema redesign 정전화 = [`milestones/v5.21/`](milestones/v5.21/) (RESEARCH + DESIGN + REPORT). [`ARCHITECTURE.md`](ARCHITECTURE.md) § 4 끝 #3 narrative 본질 변경 (drift 수용 → drift 해소 사례 정전화).

## 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../../CLAUDE.md)
- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- subdirectory CLAUDE.md (lazy load): [`CLAUDE.md`](CLAUDE.md)
- 활성 milestone: [`milestones/v5.21/`](milestones/v5.21/) (in_progress, 2026-05-19 — ROADMAP forward-looking 재정의)
- 과거 completed milestone (v1.0 ~ v5.20) 종합: [`../../CHANGELOG.md`](../../CHANGELOG.md) — entry 별 REPORT.md cross-ref
- Archive (v4.0 phase-2 분리): `milestones/_archive/v1.0_*` ~ `v3.21/` (역사적 디렉토리 보존)

## 비고

본 ROADMAP 은 v5.21_roadmap-forward-looking-redesign-and-changelog-archival (2026-05-19) 에서 schema A2 재설계. 이전 schema (v3.0+ 9-stage-bundled era, v3.0_milestones-restructure 도입) 는 `milestones[]` 단일 array 안 forward + past 혼재 = ~30~40% 부합 drift (v3.19/v5.9 정전화). v5.21 schema A2 는 `milestones[]` + `next_candidates[]` 명료 이원 분리 + CHANGELOG.md archival 흡수 = ~95%+ 부합 도달. 본 파일이 meta 진행/완료/후보 trace 의 단일 source — 단 past trace 본질은 CHANGELOG.md 위임.
