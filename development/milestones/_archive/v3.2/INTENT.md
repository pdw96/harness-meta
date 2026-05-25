# INTENT — v3.2_workflow-narrative-strengthening

```json
{
  "id": "v3.2_workflow-narrative-strengthening",
  "title": "workflow narrative 강화 — Stage F 절차 / smoke skeleton 책임 분리 / controlled 비교 cp949 narrative",
  "goal": "v3.1 lessons_learned L2/L3/L5/L6/L9 에서 식별된 4건 narrative 공백을 claude/commands/harness-meta.md + tests/CLAUDE.md 에 명문화한다. 각 공백은 미래 Claude 세션에서 반복 실수를 유발할 수 있는 비명시 정책 / 정상 작동 오해 / 책임 혼재다.",
  "motivation": "v3.1 REPORT lessons 4건 (L2 milestones.md 선결 의무 CRITICAL / L3 smoke 책임 분리 / L5 controlled 비교 cp949 정상 작동 / L6 INTENT~APPROVE commit 시점 / L9 status 기반 검증 분기) 은 모두 '이번 milestone 에서 발견·결정했으나 공식 운용 가이드에 미기록'인 상태. 미기록 정책은 다음 세션에서 재발견 비용 발생 + 일관성 손실 원인. v3.1 bundling 정책 (claude/commands/ + tests/ 의미 단위 grouping) 에 따라 1 milestone 으로 통합.",
  "success_criteria": [
    "SC1: claude/commands/harness-meta.md Stage F 절차에 milestones.md 선결 의무 (EXECUTE phase-1 첫 항목) + INTENT~APPROVE commit 시점 (a/b/c 패턴) 명문화",
    "SC2: tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 에 책임 분리 row (era 분류 검사 vs entry schema 검증) 추가",
    "SC3: tests/CLAUDE.md § '회귀 검증 절차' 또는 관련 섹션에 controlled 비교 4-step 에서 cp949 mojibake 출력이 정상 작동임을 명문화",
    "SC4: tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 에 status 기반 검증 분기 row (pending 시 milestones_path 부재 허용 / in_progress·completed 시 의무) 추가",
    "SC5: pre-commit smoke 전체 PASS (13 hook, 회귀 0)",
    "SC6: INTENT.success_criteria 4건 1:1 VERIFY.criteria_check 대응"
  ],
  "out_of_scope": [
    "v3.1 lessons L4 (scope 분류 관점 적정성) — actionable 은 계수 가이드, 이미 harness-meta.md Stage D 에 scope 표 존재. 추가 narrative 필요성 낮음",
    "v3.1 lessons L7 (5 관점 검토 자동 흡수 효율) — v3.0 L8 actionable 이미 반영, 중복 명문화 회피",
    "v3.1 lessons L8 (13 hook 시간 영향 미미) — trade-off 이미 충분히 이해됨, 추가 명문화 불필요",
    "tests/smoke-bundle-trigger.sh 로직 변경 또는 신규 smoke 추가 — narrative 강화만, 코드 변경 부재",
    "CI workflow (.github/workflows/ci.yml) 변경 — v3.3 scope"
  ],
  "dependencies": {
    "predecessors": ["v3.1_workflow-policy-fine-tuning (completed, 2026-05-10) — lessons source"],
    "successors": ["v3.3_ci-inactive-smoke-cleanup (pending)"]
  }
}
```
