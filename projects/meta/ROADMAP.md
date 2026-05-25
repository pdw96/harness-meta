# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-25-v7.1-open",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE 종합, v7.0 T1.2 후 lessons P2 자동 종합 제외) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제. next_candidates[] append = 사용자 명시 결정 게이트 후만 (자동 append 폐지, v7.0 T1.2 정전화). lessons P2/P3 자동 enumerate 폐지 — PROPOSE stage 안 사용자 명시 결정만 candidate 본질 source (scripts/propose_next.py lessons P2 grep/count 제거 정합). 기존 33 next_candidates (부산물 cycle 누적 임시 후보) 일괄 폐기 — git history 보존.",
  "deferred_note": "v1.4_hook-narrative-separation + v1.4_design-review-trace + v1.5_research-cascade-grep-discipline = workflow self-improvement 본질, v3.13_pending-milestone-renumber-policy 결정 (2026-05-12) + v3.14_deferred-revaluation-cycle-2 (2026-05-13 동결 유지) 정합. v4.0 § 6.2 폐지 narrative 후 (memory feedback_section_6_2_abolished) 재발의 trigger 조건 = 외부 projects/<name> (name ≠ meta) 실 적용 milestone 누적 5건+ ∧ 사용자 명시 발의 AND. 자기참조 사이클 동결 정책 보존.",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v7.1",
      "id": "context-gauge-and-stage-carryover",
      "title": "컨텍스트 효율 게이지·stage carry-over 권고",
      "status": "in_progress",
      "trigger": "A_user",
      "milestones_path": "milestones/v7.1/MILESTONE.md#sub-milestones",
      "summary": "candidate_draft 'stage-completion-context-clear-recommendation' 채택 + 검증 후 재설계. 컨텍스트 % 실시간 신호는 statusline stdin JSON context_window.used_percentage 에만 존재 (hook ❌ / 세션 안 모델 직접 ❌, claude-code-guide verify v2.1.132+) → 2 반쪽 분리: (1) 계기판 = statusline.sh 가 stdin used_percentage 표시 + 임계 마커 / (2) carry-over = stage 완료 결정적 trigger 에 carry-over 블록 + /clear 권고. v7.0 6 mechanism 첫 dogfood (design-review N+가변 / RESEARCH Explore 병렬 / next_candidates 절제). AI Native § 7.1 컨텍스트 효율 면."
    },
    {
      "version": "v7.0",
      "id": "ai-native-mechanism-installation",
      "title": "AI Native 6 mechanism 설치 (외부 vector 운영)",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v7.0/MILESTONE.md#sub-milestones",
      "summary": "Claude Code 2026-w13+ 외부 vector (Auto-Mode / .claude/rules/ / SessionStart hook) 정합 6 mechanism 설치 — Tier 0 (T1.6 버전추적 + T1.1 .claude/rules 3-way 직교) → Tier 1 (T1.5 Auto-Mode 최소권한) → Tier 2 (T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬) → Tier 3 (T1.2 next_candidates 절제) → Tier 1.5 (T1.6b 권한 정전화). 설치만 (정정 #7, 첫 사용 v7.1) + T2.1 완전 폐기 (정정 #1). root v7-design.md 13 정정 권위 source. 5-phase (Tier 단위 1 commit: 034f0e8/7e83ce7/f28375b/857a85b/fb3e057) + 정식화 + sc 7/7 PASS + risk 5/5 MITIGATED + verdict RESOLVED. ## SUB_MILESTONES 6 mechanism (cycle 2, v6.23 첫 활용 후). 외부 spec 실재 ≠ plugin 배포 (settings/rules repo-local) + 설치≠사용 분리 (L3 full rollback 격리) lessons."
    },
    {
      "version": "v6.23",
      "id": "version-mechanism-integration-rethink",
      "title": "version mechanism 통합 재고",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v6.23/MILESTONE.md#sub-milestones",
      "summary": "milestone version mechanism 통합 재고 lightweight 1-phase milestone — 2 sub-milestone (v6.23.1 bundling cycle 자연 발현 평가 + v6.23.2 git tag 단일 source 평가) 자연 통합. 평가 outcome 두 결정 = v6.23.1 opt_2 자연 발현 (R6, 현행 본질 명문화) + v6.23.2 opt_4 N=5 유지 + 5 source 우선순위 narrative 정전화 (R7). ARCHITECTURE § 4 끝 매트릭스 #16 row + paragraph 본문 추가 (단일 host, v3.21 cycle 43 single host cycle 3 누적). 'forward-only forsake' misnomer evidence 흡수 (R5 historical 보존) + ## SUB_MILESTONES 첫 실 활용 cycle dogfood (v6.2~v6.22 21 milestone 부재 후 첫, cb_8). 9 round 누적 결정 + 7 commit (lightweight 1-phase v6.6~v6.22 14 consec → v6.23 15 consec) + 7 lessons (L1~L7 P1 × 3 + P2 × 3 + P3 × 1) + verdict RESOLVED."
    },
    {
      "version": "v6.22",
      "id": "stage-skill-dogfood-cycle-2-evaluation",
      "title": "stage skill 도그푸드 cycle 2 평가",
      "status": "completed",
      "trigger": "B_byproduct",
      "milestones_path": "milestones/v6.22/MILESTONE.md#sub-milestones",
      "summary": "v6.18 7 stage skill 확장 후 첫 milestone 진행 자체 = cycle 2 evidence stream. Method A (자연 trigger only + 사후 회고, v6.17 cycle 1 패턴 정확 반복) + scope 4.5배 자연 확장 (cycle 1 = 2 skill / cycle 2 = 9 stage 전체) + 9 stage 자연 trigger evidence direct capture 9/9 = 100%. sc 7/7 PASS + risk 4/4 MITIGATED + verdict RESOLVED. cycle 2 첫 발견 본질 2건 = APPROVE 본질 분기 (자연 trigger vs 명시 승인 합집합 evidence direct, cycle 1 안 부재) + smoke schema-strict cycle 3 누적 (v6.17 L4 + v6.18 L1 + 본 cycle phase-1.md status). cascade host 부재 자연 (evidence-only) = v3.21 패턴 적용 대상 부재 (host 0). lightweight 1-phase v6.6~v6.22 13 consecutive + inline 5 관점 (cycle 9 도달, review-cycle-cost-marginal-default-decision next_candidate trigger 누적). 7 lessons (L1~L3 P1 + L4~L6 P2 + L7 P3)."
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
      "title": "RESEARCH cascade grep 패턴 강화 (relative/절대/symlink)",
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
- 최근 완료 milestone: [`milestones/v6.2/`](milestones/v6.2/) (completed, 2026-05-19 — milestone 산출물 디렉토리 평탄화 / 9-stage-flattened era)
- 과거 completed milestone (v1.0 ~ v5.20) 종합: [`../../CHANGELOG.md`](../../CHANGELOG.md) — entry 별 REPORT.md cross-ref
- Archive (v4.0 phase-2 분리): `milestones/_archive/v1.0_*` ~ `v3.21/` (역사적 디렉토리 보존)

## 비고

본 ROADMAP 은 v5.21_roadmap-forward-looking-redesign-and-changelog-archival (2026-05-19) 에서 schema A2 재설계. 이전 schema (v3.0+ 9-stage-bundled era, v3.0_milestones-restructure 도입) 는 `milestones[]` 단일 array 안 forward + past 혼재 = ~30~40% 부합 drift (v3.19/v5.9 정전화). v5.21 schema A2 는 `milestones[]` + `next_candidates[]` 명료 이원 분리 + CHANGELOG.md archival 흡수 = ~95%+ 부합 도달. 본 파일이 meta 진행/완료/후보 trace 의 단일 source — 단 past trace 본질은 CHANGELOG.md 위임.
