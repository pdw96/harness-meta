# INTENT — v3.11 legacy-narrative-cleanup

```json
{
  "id": "v3.11_legacy-narrative-cleanup",
  "version": "v3.11",
  "title": "stale sessions/ + 4-tier narrative 일괄 정리 — claude/CLAUDE.md + upbit ARCHITECTURE.md + CHANGELOG.md",
  "goal": "v1.4_cross-ref-propagation RESEARCH untouched_files_explicit 6건 묶음 origin 안 실재 stale 위치 3건 (claude/CLAUDE.md L41~42 / projects/upbit/ARCHITECTURE.md L106 / CHANGELOG.md L3) 을 현행 v3.0+ 9-stage-bundled era 정합 narrative 로 일괄 정리. 거명 6건 중 1건은 이미 fix (post-report-write.sh L2), 2건은 historical 보존 (upbit ROADMAP L11~13 v1.4 entry / ARCHITECTURE L133 historical).",
  "motivation": "v1.5_legacy-narrative-cleanup (v1.x era pending) 의 v3.0+ era renumber 처리 (forward-only § 6.1 의무). 5요소 매트릭스 'Context' 정합 — sub-agent / 사용자 작업 시 흡수 narrative 안 4-tier era 잔존 표현이 현행 9-stage-bundled era 정합 narrative 와 drift, agent 가 stale narrative 따라 잘못 추론할 risk (정전 narrative 1차 source 원칙 § 3.1 흔들림). v3.6 § 6.2 lightweight 모드 trigger 3건 모두 충족 (narrative 정리 중심 + ≤5 파일 + 5 관점 충돌 부재 예상).",
  "success_criteria": [
    "claude/CLAUDE.md PostToolUse 섹션 narrative 가 v3.0+ 9-stage-bundled era 패턴 명시 + '4-tier era 잔존 narrative (v1.5_legacy-narrative-cleanup 후속 milestone 에서 정리 예정)' 표현 제거",
    "projects/upbit/ARCHITECTURE.md L106 현행 안내 stale path '/harness-meta → harness-meta/sessions/upbit/' 가 현행 projects/meta/milestones/v{X.Y}/ 경로로 갱신 (L133 historical 이력은 보존)",
    "CHANGELOG.md L3 narrative 에 v3.0+ 9-stage-bundled era 카테고리 추가 (기존 'v2.0+ 9-stage era 또는 v1.0~v1.4 7-stage era' 누락 보완)",
    "ROADMAP entry v1.5_legacy-narrative-cleanup 제거 + v3.11 신규 entry status: completed 갱신 (Stage I PROPOSE 시점)",
    "milestones.md `self_reference_policy: avoid` + `self_reference_rationale` 유지 + sub_milestones[] phase 1:1 동기 (Stage D DESIGN phases[] 확정 후)",
    "pre-commit 14 hook 모두 PASS, 회귀 0"
  ],
  "out_of_scope": [
    "post-report-write.sh L2 주석 (이미 'PostToolUse hook: 9-stage milestone 산출물 Write/Edit 감지' 갱신 완료, 거명 자체 stale)",
    "projects/upbit/ROADMAP.md L11~L13 (v1.4_upbit-cross-ref-cleanup completion entry summary, 본 milestone 은 historical entry 보존)",
    "projects/upbit/ROADMAP.md L74 '완료 항목들은 4-tier 워크플로우 시대 (sessions/upbit/...)' (historical completion narrative, 본 milestone 은 보존)",
    "projects/upbit/ARCHITECTURE.md L133 '레거시 이력: harness-meta/sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/' (historical 이력 보존)",
    "v1.5_research-cascade-grep-discipline / v1.4_hook-narrative-separation / v1.4_design-review-trace (pending 별 milestone, 본 milestone 은 stale narrative 정리만)",
    "5 관점 subagent 병렬 검토 (Lightweight 모드 § 6.2 적용 — 생략)"
  ],
  "dependencies": {
    "predecessors": [
      "v1.4_cross-ref-propagation (RESEARCH untouched_files_explicit 6건 묶음 origin)",
      "v3.0_milestones-restructure (9-stage-bundled era 도입 — renumber 정합 기반)",
      "v3.6_overengineering-audit (§ 6.2 Lightweight 모드 정책 도입)"
    ],
    "successors": []
  }
}
```

## 거명 6건 grep 결과 (Stage A 사전 검증)

| 거명 위치 | 실재 상태 | 처리 |
|---|---|---|
| claude/hooks/post-report-write.sh L2 | 이미 fix ("9-stage milestone 산출물 Write/Edit 감지") | 정리 대상 아님 |
| claude/CLAUDE.md L41~42 PostToolUse 섹션 | stale ("기존 패턴은 sessions/.../REPORT + PLAN.md$ 기반 (4-tier era 잔존 narrative)") | ✅ cleanup |
| projects/upbit/ROADMAP.md L11/L13 v1.4 entry summary | historical completion (v1.4_upbit-cross-ref-cleanup) | 보존 |
| projects/upbit/ROADMAP.md L74 completion narrative | historical | 보존 |
| projects/upbit/ARCHITECTURE.md L106 현행 안내 | stale path | ✅ cleanup |
| projects/upbit/ARCHITECTURE.md L133 historical 이력 | historical | 보존 |
| CHANGELOG.md L3 era 카테고리 | v3.0+ 누락 (sessions/ 거명 부재) | ✅ cleanup (v3.0+ era 카테고리 추가) |

총 정리 대상 = **3위치** (claude/CLAUDE.md / upbit ARCHITECTURE.md L106 / CHANGELOG.md L3).
