# REPORT — v3.2_workflow-narrative-strengthening

```json
{
  "summary": "v3.2_workflow-narrative-strengthening (2026-05-11) — v3.1_workflow-policy-fine-tuning lessons_learned L2/L3/L5/L6/L9 5건 중 4건 (L2+L6=SC1, L3=SC2, L5=SC3, L9=SC4) 의 narrative 공백을 2 파일 3 phase 로 채운 milestone. v3.1 bundling 정책 일상 운용 2번째 사례 (v3.2 역시 같은 모듈 claude/commands/ + tests/ + 같은 주제 workflow narrative 강화 의미 단위 grouping). 변경: claude/commands/harness-meta.md Stage F 에 v3.0+ era 선결 조건 독립 게이트 블록 신규 (milestones.md 즉시 작성 의무 CRITICAL + INTENT~APPROVE commit 시점 3 패턴) + tests/CLAUDE.md controlled 비교 cp949 mojibake 정상 작동 narrative + Skeleton 선택 매트릭스 2 row (era 분류 vs schema 책임 분리 + status 기반 검증 분기). 코드 변경 0, narrative-only. 3 phase 3 commit (1220a2d / 6483d1b / de7f62a), pre-commit 13 hook 모두 PASS, 회귀 0. INTENT.success_criteria 6건 모두 PASS. Architecture P2 권고 Option C (3 phase, 단일 책임) 수용, 7 결정 자동 흡수. 2026-05-11.",
  "delta": {
    "files_changed": 2,
    "files_added": 8,
    "files_modified": 2,
    "files_deleted": 0,
    "modules_affected": [
      "claude/commands/harness-meta.md (Stage F 선결 조건 블록 신규 + INTENT~APPROVE commit 시점 3 패턴)",
      "tests/CLAUDE.md (§ 회귀 검증 절차 cp949 narrative + § Skeleton 선택 매트릭스 2 row)",
      "projects/meta/ROADMAP.md (v3.2 status: pending → in_progress, milestones_path 추가)",
      "projects/meta/milestones/v3.2/ 신규 (INTENT/RESEARCH/DESIGN/APPROVE/milestones.md/VERIFY/REPORT + execute/phase-{1,2,3}.md)"
    ],
    "phase_count": 3,
    "commit_count": 3,
    "absorbed_sub_milestones": 4,
    "review_perspectives": 3,
    "review_recommendations_absorbed": 7,
    "review_user_decisions": 0
  },
  "lessons_learned": [
    {
      "id": "L1",
      "topic": "v3.2 bundling 정책 2번째 일상 사례 — narrative-only milestone 의 효율",
      "narrative": "v3.1 4건 lessons 중 4건 (L2/L3/L5/L6/L9 중 L4/L7/L8 제외) 이 같은 모듈 + 같은 주제 → 1 milestone 통합. v3.1 bundling 3 phase 대비 v3.2 3 phase = 소규모 패턴 일관. narrative-only milestone 의 특성: 코드 변경 0 → smoke 위험 낮음, commit 빠름, review 간단. smoke-claude-md-drift.sh S4 '현 N 파일' false positive 우려 (scope P3 HIGH) 는 실제 smoke 파일 수 변화 없음으로 무효 확인.",
      "actionable": "lessons_learned 중 같은 모듈/주제 묶을 수 있는 것은 다음 PROPOSE 에서 1 milestone 통합. narrative-only milestone 은 scope 작음 (3 관점) + 빠른 실행 패턴 — bundling 효율 높음."
    },
    {
      "id": "L2",
      "topic": "Architecture 관점 P1 권고 독립 게이트 블록 — Stage E 패턴 재확인",
      "narrative": "milestones.md 선결 의무를 step 1 내에 넣는 것 vs 독립 블록 차이. Architecture 관점 P1 이 명확히 '진입 전 게이트' 패턴 권고 → Stage E '미승인 시 EXECUTE 진입 금지' 경고 블록 패턴과 동일 서식 적용. EXECUTE 재진입 시 가시성 확보. v3.0 DESIGN.decisions 선례 확인 불필요 — Architecture P1 1 sentence 로 충분.",
      "actionable": "향후 신규 '진입 게이트' 조건 추가 시 독립 블록 패턴 (stage 절차 step 바깥, 경고 서식) 의무. step 안 포함은 visibility 손실."
    },
    {
      "id": "L3",
      "topic": "scope contract P3 HIGH 우려 검증 절차 — smoke 파일 수 vs 매트릭스 row 구분",
      "narrative": "scope agent 가 smoke-claude-md-drift.sh S4 '현 N 파일' 를 Skeleton 매트릭스 row 수 변화로 혼동. 실제: S4 는 `grep -oE '현 ([0-9]+) 파일' tests/CLAUDE.md` + 실제 tests/smoke-*.sh 파일 수 비교. Skeleton 매트릭스 row 추가 ≠ smoke 파일 추가 → count 변화 없음. P3 HIGH 무효. 이런 false alarm 은 설계 시 'RESEARCH.untouched_files 명시 + D4 결정 패턴' 으로 무효화.",
      "actionable": "DESIGN.decisions D4 패턴 활용: smoke count 관련 우려는 'smoke 파일 수 변화 없음' 1줄 확인으로 조기 해소. VERIFY 전 `ls tests/smoke-*.sh | wc -l` 카운트 확인 습관."
    },
    {
      "id": "L4",
      "topic": "v3.0+ era 한정 표기 필요성 재확인 — 선결 조건 era 분기",
      "narrative": "milestones.md 선결 의무를 Stage F 에 추가할 때 'v3.0+ 9-stage-bundled era' 한정 표기 필수 (D7). 7-stage/9-stage era 에는 milestones.md 개념 자체 없음. era 분기 없이 작성 시 구 era milestone 작업 시 혼란. Stage 표 era 분기 narrative 일관 패턴.",
      "actionable": "신규 v3.0+ 전용 절차 추가 시 항상 era 한정 표기 의무 — '(v3.0+ 9-stage-bundled era)' bracket. era 분기 누락은 구 era 작업자 오해 유발."
    }
  ]
}
```
