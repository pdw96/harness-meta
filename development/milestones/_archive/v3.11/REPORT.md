# REPORT — v3.11 legacy-narrative-cleanup

```json
{
  "id": "v3.11_legacy-narrative-cleanup",
  "summary": "v1.4_cross-ref-propagation RESEARCH untouched_files_explicit 6건 묶음 origin (v1.5_legacy-narrative-cleanup v1.x era pending) 의 v3.0+ 9-stage-bundled era renumber 진행 (forward-only § 6.1). 실재 stale 3위치 cleanup — claude/CLAUDE.md L39 PostToolUse 섹션 narrative (현행 패턴 + 진화 이력 4단계) + projects/upbit/ARCHITECTURE.md L106 stale path (v3.0+ era + v2.0~v2.1/v1.x 보존 era 동시 거명) + CHANGELOG.md L3 era 카테고리 정합화 (3 era). 거명 6건 중 1건 (post-report-write.sh L2) 이미 fix 확인 + 2건 (upbit ROADMAP L11~13 v1.4 entry / ARCHITECTURE L133 historical) 사용자 historical 보존 결정. Lightweight 모드 적용 (§ 6.2 trigger 3건 모두 충족) — 5 관점 subagent 병렬 검토 생략, self_reference_policy: 'avoid' 표지 (workflow self-improvement 부재, 4-tier 잔존 narrative 정리 본질). 1 phase 1 commit (40faa23), pre-commit 14 hook 모두 PASS, 회귀 0. INTENT.success_criteria 6건 모두 PASS (5/6 phase-1 직후, 1/6 PARTIAL Stage I PROPOSE 후 완전 PASS).",
  "delta": {
    "files_changed": 4,
    "files_added": 7,
    "files_deleted": 0,
    "modules_affected": ["claude/", "projects/upbit/", "CHANGELOG.md", "projects/meta/milestones/v3.11/"],
    "phase_1_commit": "40faa23 feat(meta): v3.11 phase-1 — stale 3위치 narrative 일괄 갱신",
    "stage_g_h_i_commit": "(pending Stage I PROPOSE 종료 후)"
  },
  "lessons_learned": [
    {
      "id": "L1",
      "title": "ROADMAP entry summary 거명 vs 실 코드 상태 drift 검출 패턴",
      "narrative": "v1.5_legacy-narrative-cleanup entry summary 안 'claude/hooks/post-report-write.sh L2 stale 주석' 거명이 실재 코드 (이미 9-stage 갱신, fix 완료) 와 drift. Stage A OPEN 단계 거명 6건 사전 grep 검증으로 1건 (post-report-write.sh L2) 이미 fix 확인 + 1건 (CHANGELOG L3) sessions/ 거명 부재 but era 카테고리 누락 발견 등 narrative 정확도 향상. ROADMAP entry summary 자체 정기 검증 메커니즘 부재 — 후속 candidate 가치."
    },
    {
      "id": "L2",
      "title": "ROADMAP entry renumber 패턴 (v1.x era → v3.0+ era forward-only)",
      "narrative": "v1.5_legacy-narrative-cleanup → v3.11_legacy-narrative-cleanup renumber 시 신 schema (`{version: v3.11, id: legacy-narrative-cleanup}`) + `renumbered_from` 필드 신규 도입으로 origin 이력 보존. 기존 v1.4_cross-ref-propagation `absorbed_milestones` 필드 (v3.0/v3.1/v3.7 선례) 동등 패턴. v2.1_pending-milestone-renumber-policy 의 v1.x pending 4건 처리 시 본 패턴 직접 차용 가능."
    },
    {
      "id": "L3",
      "title": "Lightweight 모드 narrative 정리 milestone 첫 적용 사례",
      "narrative": "§ 6.2 trigger 3건 모두 충족 시 5 관점 subagent 생략 + LOC cap 정합. 본 milestone 산출물 LOC: milestones.md (35) + INTENT (54) + RESEARCH (64) + DESIGN (44) + APPROVE (10) + VERIFY (44) + REPORT (작성중) + PROPOSE (작성중) + execute/phase-1.md (33). Lightweight cap (각 <150줄, 총 <850줄) 정합. v3.6 / v3.10 선례 (workflow self-improvement / 부산물 정의) 와 본 milestone (narrative 정리 본질) 차이 — § 6.2 동결 정책 적용 분기 명확화."
    },
    {
      "id": "L4",
      "title": "거명 6건 grep 사전 검증 → INTENT out_of_scope / RESEARCH untouched_files_explicit narrative 정확도",
      "narrative": "Stage A OPEN 시점 거명 6건 grep 사전 검증 패턴으로 (a) 실 cleanup 대상 3건 (b) 이미 fix 1건 (c) historical 보존 2건 분류 정확도 100%. INTENT out_of_scope 6건 + RESEARCH untouched_files_explicit 5건 narrative 가 grep 결과와 1:1 매핑. v3.10 Stage B/C/D 부산물 정책 (사실 진술 only, forward propose 명령형 금지) 정합 — 본 milestone 모든 narrative 후속 발의 표현 0."
    }
  ]
}
```
