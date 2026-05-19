# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-19",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v6.0",
      "id": "ai-native-operation-reframe-and-entry-title-guideline",
      "title": "AI Native 운영 reframe + entry title 가이드 정전화",
      "status": "in_progress",
      "trigger": "A_user",
      "milestones_path": "milestones/v6.0/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-19 스무고개 round) — '워크플로우/산출물 지저분/복잡' 답답함 + 'AI Native 운영' 본질 reframe. 첫 원안 (9-stage 자동 전환 + PoLP) Stage E 직전 취소 후 사용자 비개발자 명시 + 스무고개 방식 선호 round 진행 (memory user_non_developer_role + feedback_iterative_dialog 신규 정전화). 본 milestone = AI Native 시리즈 첫 milestone (정의 + entry title 가이드 + 7 retitle). ARCHITECTURE § 7 신규 (§§ 7.1 정의 + 3 면 매트릭스 + §§ 7.2 4 원칙) + ROADMAP/CHANGELOG 4+3 retitle (self-dogfood 포함) + cascade 6 host + v5.19 archival + § 7 → § 8 shift. lightweight 1 phase / ~95 line / 12 파일. v3.21 cycle 25 도그푸드. 3 관점 검토 pass-with-comments (decisive 2건 D1/D4 흡수 + P1 13건 D9~D12 흡수). v6.x 후속 시리즈 = JSON 필드 감축 / cascade 자동 동기 / 자율 발의 / hallucination 자동 정정 / v7.0 통합."
    },
    {
      "version": "v5.21",
      "id": "roadmap-forward-looking-redesign-and-changelog-archival",
      "title": "ROADMAP forward-looking 재정의 + CHANGELOG archival",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.21/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-19) — 'ROADMAP 사전적 의미 = 이정표 미래지향, 최근 완료 + PROPOSE 제안만 보존'. § 4 끝 #3 narrative (ROADMAP 단어 drift 수용, v5.9 정전화, ~30~40% 부합) drift 해소 첫 evidence-base trigger 사례. Schema A2 채택 (milestones[] recent 3 + in_progress + deferred / next_candidates[] 별도). 5요소 매핑 = Trace (b) mechanism cross-ref 갱신 (sub-mechanism 분리). v5.21 minor (additive). 3-phase + 5 관점 검토 (5/5 pass-with-comments + decisive 0 + P1 6건 + P2 4건 흡수). 3 commit (phase-1 270dfc2 + phase-2 3def306 + phase-3 a0ff9c5). pre-commit 14 hook 모두 PASS, 회귀 0. v3.21 narrative 정전화 3 단계 패턴 cycle 24 도그푸드 완성. v6.0_workflow-automation-and-least-privilege 별 milestone 예약 (next_candidates#1). archival cycle 첫 적용 = v5.18 entry 자체 archival 이전 (CHANGELOG [v5.18] entry 보유)."
    },
    {
      "version": "v5.20",
      "id": "audit-cycle-7-and-section-4-matrix-and-namespace-prefix-cascade",
      "title": "audit cycle 7 + § 4 매트릭스화 + namespace cascade",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v5.20/milestones.md",
      "summary": "사용자 명시 발의 (A_user, 2026-05-19). scenario B (3-phase bundling) — v5.19 PROPOSE#4+#8 + spec-drift D1 동시 흡수. audit chain 4 멤버 upbit cycle 7 + diff-vs-cycle6 + § 4 끝 stability paragraph + L135 vector 6→7 + 7 paragraph 매트릭스화 + namespace cascade 7 위치. stability cycle 두 번째 (cycle 5+6+7 동일 baseline). hallucination 2건 inline 정정. narrative effect isolation 한계 첫 확인. v3.21 21+22 cycle. bundling 정당화. 4 commit + 7 lessons."
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
  "next_candidates": []
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
- 활성 milestone: [`milestones/v6.0/`](milestones/v6.0/) (in_progress, 2026-05-19 — 9-stage 자동 전환 + per-stage PoLP)
- 과거 completed milestone (v1.0 ~ v5.20) 종합: [`../../CHANGELOG.md`](../../CHANGELOG.md) — entry 별 REPORT.md cross-ref
- Archive (v4.0 phase-2 분리): `milestones/_archive/v1.0_*` ~ `v3.21/` (역사적 디렉토리 보존)

## 비고

본 ROADMAP 은 v5.21_roadmap-forward-looking-redesign-and-changelog-archival (2026-05-19) 에서 schema A2 재설계. 이전 schema (v3.0+ 9-stage-bundled era, v3.0_milestones-restructure 도입) 는 `milestones[]` 단일 array 안 forward + past 혼재 = ~30~40% 부합 drift (v3.19/v5.9 정전화). v5.21 schema A2 는 `milestones[]` + `next_candidates[]` 명료 이원 분리 + CHANGELOG.md archival 흡수 = ~95%+ 부합 도달. 본 파일이 meta 진행/완료/후보 trace 의 단일 source — 단 past trace 본질은 CHANGELOG.md 위임.
