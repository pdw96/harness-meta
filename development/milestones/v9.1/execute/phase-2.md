---
phase: phase-2
milestone: v9.1
status: completed
---

# v9.1 phase-2 — active smoke 15 전체 PASS + drift 정합 finalize (검증 only)

## Spec

```json
{
  "phase": "phase-2",
  "status": "completed",
  "scope": "active smoke 15 전체 실행 + drift grep 3 형식 (relative / 절대 / anchor) 잔존 0 확인 + historical milestone 변경 0 확인 (risk_3) + sc_6 통과 evidence. phase-1 cascade 안 잔존 issue 1건 (README.md:5 crossed-target 오변환) 발견 → phase-2 안 정정 (phase-1 회귀 trace 보존, DESIGN phase-2 scope '잔존 issue 발견 시 phase-2 안 정정' 정합).",
  "changes": [
    {
      "type": "edit",
      "path": "README.md",
      "description": "L5 banner cross-ref 2 link crossed-target 정정 (phase-1 cascade script over-conversion). (1) 'Canonical definition § 3.1 end' 타깃 = development/OPERATIONS.md → development/ARCHITECTURE.md 복원 (정체성 § 3.1 = ARCHITECTURE 잔류, AGENTS.md:3 정합). (2) 'AI Native operation § 3' 타깃 = development/ARCHITECTURE.md → development/OPERATIONS.md 정정 (AI Native 정의 = 구 § 7.1 → OPERATIONS § 3 이동, AGENTS.md:5 정합). link text '§ 3' 은 phase-1 안 이미 올바르게 변환됨 (§ 7 → § 3) — 타깃만 crossed."
    },
    {
      "type": "edit",
      "path": "development/ROADMAP.md",
      "description": "updated 필드 bookkeeping 갱신 = '2026-05-28-v9.1-execute-phase-1' → '2026-05-29-v9.1-execute-phase-2' (단일 source 진행 trace freshness 마커). milestone entry status 는 in_progress 유지 (VERIFY/REPORT/PROPOSE 미완). smoke-roadmap-archival PASS 재확인."
    }
  ],
  "verification": [
    {
      "method": "active smoke 15 전체 PASS (Makefile smoke target = CI/pre-commit 정합 set)",
      "result": "PASS",
      "detail": "smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref (broken ref 0) / smoke-claude-md-drift / smoke-bundle-trigger / smoke-open-stage-discipline / smoke-entry-title-guideline / smoke-cascade-drift / smoke-candidate-draft-schema / smoke-audit-fact-verify / smoke-agent-frontmatter-schema / smoke-roadmap-archival / smoke-workflow-registration / smoke-plugin-manifest = 15/15 PASS (failed=0). README.md L5 정정 후 재실행도 15/15 PASS (회귀 0)."
    },
    {
      "method": "drift grep 3 형식 (risk_1 mitigation, v8.2 규율) — relative path / 절대 path / anchor·§",
      "result": "PASS",
      "detail": "FORM 1 (`\\.\\./[^ ]*ARCHITECTURE\\.md`) + FORM 2 (`development/ARCHITECTURE\\.md`) + FORM 3 (`ARCHITECTURE[^)]*§ (4|5|6|7|11)`), exclude = milestones/** + projects/*/audit-* + docs/adr/* + _archive + CHANGELOG. 진짜 stale = 1 (README.md:5 crossed-target) → 정정 후 0. 잔존 매치 전부 분류 완료: (a) VALID 신 § 4=3-way (rules/README.md:16, CLAUDE.md:65) + 신 § 5=Auto-Mode (CLAUDE.md:66, version-tracker.md:45, design-review.md:68 §5.2) — 재번호 후 유효 / (b) by-design provenance intro (development/WORKFLOW.md:7 '구 § 4/7.3/7.4/11', development/OPERATIONS.md:7 '구 § 5/6/7.1/7.2', d_9 정합) / (c) historical milestone summary prose (development/ROADMAP.md:18 v9.1 summary) / (d) SCOPE_OUT 거명 (skills/stage-design/SKILL.md:111 § 6.2, d_8). crossed-target 재확인 (OPERATIONS|WORKFLOW + § 3.1 / AI Native→ARCHITECTURE) = 0."
    },
    {
      "method": "historical milestone 변경 0 (risk_3 mitigation)",
      "result": "PASS",
      "detail": "phase-1 commit (HEAD~1..HEAD) 안 milestone 변경 = development/milestones/v9.1/{MILESTONE.md, execute/phase-1.md} 만 — v9.1 외 milestone (development/milestones/v{X.Y≠9.1} + projects/upbit/milestones/** + projects/upbit/audit-*) 변경 0. phase-2 working tree 변경 = README.md (active host) + development/ROADMAP.md (updated 필드 bookkeeping) + v9.1 산출물 (phase-2.md 신설 + MILESTONE.md ## EXECUTE 갱신) 만 — v9.1 외 milestone 변경 0. oos_1 (historical trace 보존) 준수."
    },
    {
      "method": "sc_6 (검증 통과) evidence",
      "result": "PASS",
      "detail": "sc_6 = 최소 smoke-open-stage-discipline / smoke-scope-contract / smoke-spec-verification / smoke-workflow-registration / smoke-roadmap-archival / smoke-cross-ref PASS (+ 가능하면 active smoke 전체) 요구 → active smoke 15 전체 PASS 로 상회 충족."
    }
  ],
  "commit": "<phase-2 commit SHA 후속>"
}
```

## Narrative

본 phase-2 는 v9.1 의 검증 only 본질 (DESIGN d_2 — phase-1 atomic mechanical / phase-2 검증 finalize). 세 검증 축 모두 통과:

1. **active smoke 15 전체 PASS** — Makefile `smoke` target (CI/pre-commit 정합 set) 15 건 failed=0. smoke-cross-ref 안 broken ref 0건 (분리 후 신규 cross-ref 정합 확인).

2. **drift grep 3 형식 잔존 0** — phase-1 verification 은 5 smoke + 약식 grep 으로 false positive 4 만 확인했으나, phase-2 안 3 형식 (relative / 절대 / anchor·§) 전수 + crossed-target 정밀 검증으로 **phase-1 cascade 안 잠복한 진짜 drift 1건 발견** — `README.md:5` banner 의 2 link 가 cascade script over-conversion 으로 crossed-target 됨. (a) 'Canonical definition § 3.1 end' 가 ARCHITECTURE → OPERATIONS 로 잘못 변환 (정체성 § 3.1 은 ARCHITECTURE 잔류) + (b) 'AI Native operation § 3' 가 ARCHITECTURE 타깃 유지 (OPERATIONS § 3 로 이동해야 함). DESIGN phase-2 scope ('잔존 issue 발견 시 phase-2 안 정정, phase-1 회귀 trace 보존') 정합으로 phase-2 안 정정. 정정 후 AGENTS.md:3 (Canonical definition → ARCHITECTURE § 3.1 end) + AGENTS.md:5 (AI Native operation → OPERATIONS § 3) 와 정합. 정정 후 재검증 = 진짜 stale 0, crossed-target 0.

3. **historical milestone 변경 0** — phase-1 commit + phase-2 working tree 양쪽에서 v9.1 외 milestone 디렉토리 변경 부재 (oos_1 준수, exclude 5 path 정합).

phase-1 의 약식 drift 검증이 README.md:5 crossed-target 을 놓친 이유 = phase-1 grep 이 `§ (4|5|6|7|11)` 패턴 중심이었으나 README.md:5 는 § 3.1 / § 3 (범위 내 § 번호) 라 패턴 외 — crossed-target 은 § 번호가 아니라 **link 타깃 파일 mis-routing** 본질이었다. phase-2 의 SUSPECT A/B (OPERATIONS·WORKFLOW + § 3.1 / AI Native → ARCHITECTURE) 정밀 query 가 이를 포착. → lessons 후보 (drift 검증 = § 번호 패턴 + 타깃 파일 라우팅 양축 필요).

sc_6 충족 (active smoke 15 PASS 로 최소 요구 smoke 상회). VERIFY stage (criteria_check vs INTENT sc_1~sc_6 + verdict) 진입 가능.

## delta 통계

- 정정 file 2: README.md (L5 banner 2 link crossed-target → 정정, 1 line 내용 변경) + development/ROADMAP.md (updated 필드 → '2026-05-29-v9.1-execute-phase-2', 1 line)
- milestone 산출물 2: development/milestones/v9.1/execute/phase-2.md (본 별책 신설) + development/milestones/v9.1/MILESTONE.md (## EXECUTE phase-2 완료 기록 갱신)
- smoke result: active smoke 15/15 PASS (회귀 0)
- drift: 진짜 stale 1 발견·정정 → 0 / crossed-target 0 / historical milestone 변경 0

## VERIFY 진입 게이트

phase-2 완료 — EXECUTE stage 전체 종료 (phase-1 atomic mechanical + phase-2 검증 finalize). 다음 = VERIFY stage (Stage G) — criteria_check vs INTENT sc_1~sc_6 + smoke/drift evidence 종합 + verdict 판정. 다음 commit = `docs(meta): [v9.1 EXECUTE phase-2]` 형식 (README crossed-target 정정 + phase-2.md 별책 + MILESTONE.md ## EXECUTE 갱신).
