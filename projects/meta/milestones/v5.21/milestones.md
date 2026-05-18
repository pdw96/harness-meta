# v5.21 — sub-milestone listing

## Spec

```json
{
  "version": "v5.21",
  "title": "ROADMAP forward-looking 재정의 + CHANGELOG.md v5.7~v5.20 backfill + completed 41건 archival + cascade 7 host narrative",
  "status": "in_progress",
  "trigger": "A_user",
  "sub_milestones": [
    {
      "id": "phase-1-changelog-backfill",
      "title": "CHANGELOG.md v5.7~v5.20 14 entry backfill (역순 삽입, Keep a Changelog v1.1.0 정합)",
      "status": "pending",
      "phase": 1
    },
    {
      "id": "phase-2-roadmap-schema-redesign",
      "title": "ROADMAP schema A2 (milestones[] + next_candidates[] 별도 필드) + completed 41건 CHANGELOG 이전 + recent 3 + deferred 3 보존",
      "status": "pending",
      "phase": 2
    },
    {
      "id": "phase-3-cascade-narrative",
      "title": "cascade 7 host narrative + § 4 끝 #3 drift 해소 정전화 + [v5.21] CHANGELOG entry + post-report-write.sh hook 메시지 갱신",
      "status": "pending",
      "phase": 3
    }
  ]
}
```

## sub-milestone listing

### phase-1: CHANGELOG.md v5.7~v5.20 14 entry backfill

- **scope**: CHANGELOG.md 안 [v5.7] ~ [v5.20] 14 entry 역순 삽입 ([Unreleased] 직후, [v5.6] 위)
- **affected_files**: `CHANGELOG.md`
- **entry 분류 가이드 (DESIGN.D9.category_mapping_rule)**: Changed 우선 (narrative canonicalization / cleanup / audit cycle 본질) + Added 한정 (신규 산출물) + Fixed 한정 (fact 정정)
- **dedupe 검증**: CHANGELOG 안 [vX.Y] 헤더 grep — 동일 헤더 부재 확인
- **commit**: `feat(meta): v5.21 phase-1 — CHANGELOG.md v5.7~v5.20 14 entry backfill (역순 삽입, Keep a Changelog v1.1.0 정합)`

### phase-2: ROADMAP.md schema A2 + completed 41건 archival + next_candidates[] 신규

- **scope**: projects/meta/ROADMAP.md schema 재구성 — milestones[] = recent 3 (v5.20/v5.19/v5.18) + in_progress 1 (v5.21) + deferred 3 (v1.4_hook / v1.4_design-review / v1.5_research) / next_candidates[] 신규 필드 (v6.0_workflow-automation-and-least-privilege 거명 + 기타 PROPOSE 후보)
- **affected_files**: `projects/meta/ROADMAP.md`
- **schema validation**: next_candidates[].id regex (`^[a-z0-9-]+$`) + target_version regex (`^v[0-9]+\.[0-9]+$`) (D2.schema_validation_pattern_source)
- **deferred 3건 entry 보존**: deferred_note narrative 보존 + status `deferred` 유지
- **commit**: `feat(meta): v5.21 phase-2 — ROADMAP schema A2 + completed 41건 CHANGELOG 이전 + next_candidates[] 신규 필드`

### phase-3: cascade 7 host narrative + § 4 끝 drift 해소 정전화

- **scope**: cascade 7 host narrative 동기 갱신 — (1) root CLAUDE.md L33 + L60 / (2) claude/hooks/post-report-write.sh L173 hook 메시지 / (3) claude/commands/harness-meta.md Stage A step 6 + Stage I 절차 (archival cycle 추가) / (4) bootstrap/agents/CLAUDE.md L198 micro / (5) projects/meta/ARCHITECTURE.md L91 Trace mechanism + L151 § 4 끝 #3 drift 해소 + L165 bundling schema entry + § 4 끝 매트릭스 row #3 row replace + § 4 끝 #2 paragraph cross-ref / (6) CHANGELOG.md [v5.21] entry / (7) projects/meta/ROADMAP.md L7 deferred_note 보존 + L8 schema_note 갱신 + L589 비고 갱신
- **affected_files**: `CLAUDE.md`, `claude/hooks/post-report-write.sh`, `claude/commands/harness-meta.md`, `bootstrap/agents/CLAUDE.md`, `projects/meta/ARCHITECTURE.md`, `CHANGELOG.md`, `projects/meta/ROADMAP.md`
- **markdownlint self-check 의무** (D13): `markdownlint --all-files` (MD022/MD031/MD032/MD028 회귀 차단, v5.16 narrative 정합)
- **수동 검증** (D12): `bash tests/_inactive/smoke-posttooluse-hook.sh` 25/25 PASS evidence
- **commit**: `feat(meta): v5.21 phase-3 — cascade 7 host narrative + § 4 끝 drift 해소 정전화 + [v5.21] CHANGELOG entry + hook 메시지 갱신`

## Notes

- **사용자 명시 trigger**: A_user, 2026-05-19 round 안 "ROADMAP 사전적 의미 = 이정표 (미래지향), 최근 완료 + PROPOSE 제안만 보존" 명시 발의
- **5요소 매핑**: Trace 요소 (b) mechanism cross-ref 갱신 — sub-mechanism 분리 (forward-looking + past trace). (c) 정전 status 보존 (변경 아님). (INTENT.harness_engineering_mapping 정정, 5 관점 architecture P1 흡수)
- **버전 bump**: v5.21 minor (schema additive + content reduce, breaking 측면 narrative 흡수). v6.0 = workflow-automation-and-least-privilege 별 milestone 예약 (PROPOSE next_candidates#1)
- **5 관점 검토 결과**: 5/5 pass-with-comments, decisive 부재, P1 6건 + P2 4건 모두 DESIGN 안 흡수 (DESIGN § "5 관점 결과")
- **v3.21 narrative 정전화 3 단계 패턴**: cycle 23 누적 도그푸드 (DESIGN.D13 + D16)
