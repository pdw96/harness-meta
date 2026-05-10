# REPORT — v3.1_workflow-policy-fine-tuning

```json
{
  "summary": "v3.1_workflow-policy-fine-tuning (2026-05-10) — v3.0_milestones-restructure 직접 후속 (PROPOSE next_candidates 3건 + lessons L10) 의 통합 milestone 사례. v3.0+ 9-stage-bundled era 의 첫 후속 통합 milestone 사례 (도그푸드 누적). 3 sub-milestone 통합 (markdownlint trap narrative / milestones.md historical 적용 결정 / bundling trigger smoke) — 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) 의미 단위 grouping (ARCHITECTURE.md § 6.1 bundling trigger 조건 (a) + (b)). 3 phase 통합 milestone (sub-milestone 1:1 매핑) — phase-1 markdownlint 함정 narrative + milestones.md 신규 (R1 CRITICAL mitigation) / phase-2 forward-only 강제 결정 narrative + v3.0 milestones.md unchanged (D12, 사용자 결정 P1 수용) / phase-3 신규 smoke + pre-commit 12 → 13 hook (자동 강제 누적). 4 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 1건 (architecture P1) 사용자 결정 해소. 권고 19건 자동 흡수 + 1건 사용자 결정. 3 phase 3 commit (0a86598 / 4bd4ec6 / d136b2f), pre-commit 13 hook 모두 PASS, 회귀 0. INTENT.success_criteria 8건 모두 PASS. minor bump (v3.0 → v3.1, semver 정합 backward-compatible feature 추가). v3.0 통합 (8 phase, 정책 4 + 흡수 4) 대비 v3.1 통합 (3 phase) = bundling 정책 일상 운용 패턴 첫 적용 사례 (소규모). 2026-05-10.",
  "delta": {
    "files_changed": 13,
    "files_added": 9,
    "files_modified": 4,
    "files_deleted": 0,
    "insertions": 426,
    "deletions": 10,
    "modules_affected": [
      "projects/meta/ROADMAP.md (v3.1 entry status: pending → in_progress, milestones_path 필드 추가, Stage A — 별 commit 부재, phase-1 commit 시점 modified 보존)",
      "projects/meta/ARCHITECTURE.md (§ 6.1 'milestones.md spec historical era 적용 결정' 1단락 추가 — phase-2)",
      "projects/meta/milestones/v3.1/ 신규 (INTENT/RESEARCH/DESIGN/APPROVE/milestones.md/VERIFY/REPORT/PROPOSE 8 + execute/phase-{1,2,3}.md 3 — 단, INTENT/RESEARCH/DESIGN/APPROVE 4건 본 milestone 종결 시 별 commit 필요)",
      "tests/CLAUDE.md (§ '흔한 함정' 7번째 row + 헤더 갱신 — phase-1, § smoke 매트릭스 27 → 28 + 1 row + § Pre-commit 통합 5 → 6 — phase-3)",
      "tests/smoke-bundle-trigger.sh (신규, 단일 책임 — bundling validation, phase-3)",
      ".pre-commit-config.yaml (smoke-bundle-trigger hook 등록 — phase-3, 12 → 13 hook)"
    ],
    "phase_count": 3,
    "commit_count": 3,
    "absorbed_milestones": 3,
    "review_perspectives": 4,
    "review_recommendations_absorbed": 19,
    "review_user_decisions": 1
  },
  "lessons_learned": [
    {
      "id": "L1",
      "topic": "v3.0+ 9-stage-bundled era 첫 후속 통합 milestone 사례 - bundling 정책 일상 운용 패턴",
      "narrative": "v3.0 자체는 자기참조 부합 (도그푸드, 신 era 도입 milestone) 으로 신 구조 첫 적용. v3.0 종결 후 첫 후속 통합 milestone (v3.1) 가 bundling 정책의 일상 운용 패턴 첫 사례. v3.0 통합 (8 phase, 정책 4 + 흡수 4) 대비 v3.1 통합 (3 phase) = 소규모 사례. PROPOSE next_candidates 3건 모두 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) 의미 단위 grouping (ARCHITECTURE.md § 6.1 bundling trigger 조건 (a) + (b)) 만족 → 분리 시 토큰 비효율 (3× INTENT~PROPOSE = 24 산출물 vs 통합 8 산출물 = 67% 감소) + 의존 관계 표현 어려움.",
      "actionable": "PROPOSE next_candidates 3건+ 시 의미 단위 grouping 검사 의무 (같은 모듈/주제/lessons_learned 매칭). 만족 시 통합 milestone (sub-milestone 매핑) — bundling 정책 자연스러운 운용. 미만족 시 별 milestone (release train 모델 부적합 case)."
    },
    {
      "id": "L2",
      "topic": "milestones.md 선결 의무 — detect_era 9-stage-bundled 인식 보장 (회귀 risk R1 CRITICAL)",
      "narrative": "회귀 risk Explore agent 권고 R1 (CRITICAL): milestones/v{X.Y}/ 디렉토리 구조에서 milestones.md 부재 시 detect_era (tests/_era_detect.py) 가 7-stage 또는 9-stage 오인 가능. v3.0+ 9-stage-bundled era 표지 = 디렉토리 명 `^v\\d+\\.\\d+$` (sub-id 부재) + milestones.md 존재. 따라서 INTENT/RESEARCH/DESIGN/APPROVE.md 작성 후 EXECUTE phase-1 시작 시 milestones.md 즉시 작성 의무 (R1 mitigation). 본 milestone 에서 phase-1 첫 항목으로 milestones.md 마운트 — smoke-spec-verification PASS=126 + smoke-scope-contract PASS=21 보장.",
      "actionable": "v3.0+ 신규 milestone 작성 시 EXECUTE phase-1 첫 항목 = milestones.md 즉시 작성 (skeleton + spec cross-ref + sub_milestones[] phase-1 status: in_progress). v3.0 D7 패턴 일관 + R1 mitigation 의무 — claude/commands/harness-meta.md Stage F 절차 narrative 강화 후속 candidate."
    },
    {
      "id": "L3",
      "topic": "smoke 책임 분리 - detect_era 미호출 (D16) 의 책임 분리 효과",
      "narrative": "신규 smoke (smoke-bundle-trigger.sh) 가 detect_era (tests/_era_detect.py) 호출 시 era 분류 책임과 schema 검증 책임 혼재. architecture 권고 P3 흡수 → D16 신규 (detect_era 미호출, ROADMAP entry schema 직접 검사). v3.0+ 신 schema entry 표지 = `version` 필드 존재 (forward-only 조건 + 신 schema 식별 동치). 책임 분리: era 분류 = milestone 디렉토리 책임 / entry schema = ROADMAP `milestones[]` 책임. 두 책임이 섞이면 향후 era 추가 시 smoke 코드 복잡도 누적 + 책임 추적 어려움.",
      "actionable": "신규 smoke 작성 시 책임 분리 명시 — 'era 분류 검사' (detect_era 호출) vs 'entry schema 검증' (직접 검사) 명료화. 같은 smoke 안 두 책임 혼재 회피. tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 후속 candidate (책임 분리 row 추가)."
    },
    {
      "id": "L4",
      "topic": "scope 분류와 검토 관점 — 4 관점 (중간 scope, 7 파일) 의 적정성",
      "narrative": "harness-meta.md Stage D 검토 관점 분류 — 작음 (≤5 파일) 3 관점 / 중간 (6~15) 4 관점 / 큼 (16+) 5 관점. 본 milestone 7 파일 = 중간 scope → 4 관점 (architecture / spec-drift / 회귀 risk / scope contract). 보안 5번째 관점 부담 부재 (narrative + 결정 + 1 smoke, side effect / 권한 / path traversal 부재). 결과: 4 관점 모두 pass-with-comments + 의견 충돌 1건 사용자 결정 해소. 19 권고 자동 흡수.",
      "actionable": "scope 분류 narrative 일관 — 산출물 변경 (milestone 7 산출 + execute/) 은 scope 카운트 제외 (자체 운용), 실 코드/문서 변경만 카운트. 본 milestone 6 변경 (tests/CLAUDE.md / ARCHITECTURE.md / smoke 신규 / pre-commit 등록 / milestones.md / ROADMAP.md) → 중간 분류 정합."
    },
    {
      "id": "L5",
      "topic": "controlled 비교 4-step 신규 smoke 패턴 - violation 주입 검증의 cp949 mojibake 정상 작동",
      "narrative": "phase-3 신규 smoke 의 controlled 비교 4-step 적용 시 violation 주입 (중복 v3.0 entry) 검증 단계에서 cp949 콘솔 mojibake 출력 발생 (한글 narrative 깨짐). 단, sys.stdout.reconfigure(errors='replace') 보일러플레이트 정상 작동 — crash 부재, exit=1 정상 반환. mojibake 는 errors='replace' 의 의도된 동작 (encode 불가 문자 ?로 대체). 실 사용 시 한글 출력 깨지지만 자동화 파이프라인 영향 부재 (exit code + 에러 트리거 정상). v3.0 phase-6 흡수 cp949 패턴 확장 검증 사례.",
      "actionable": "controlled 비교 4-step 시 cp949 mojibake 출력은 정상 작동 — narrative 가독성 손실은 trade-off 수용 (자동화 정상 동작 우선). 한글 가독성 우선 시 출력 인코딩 강제 (utf-8 redirect: bash tests/smoke.sh 2>&1 | iconv -f utf-8 -t cp949) 가능 — 후속 옵션. tests/CLAUDE.md § '회귀 검증 절차' controlled 비교 narrative 후속 강화 candidate."
    },
    {
      "id": "L6",
      "topic": "INTENT~APPROVE.md commit 시점 - phase 별 commit 운용의 부수 효과",
      "narrative": "v3.1 phase 별 commit (0a86598 / 4bd4ec6 / d136b2f) 시 INTENT/RESEARCH/DESIGN/APPROVE.md 4건 untracked 보존 (사용자 결정 — phase-1 commit 안 phase-1 affected_files 만 포함). v3.0 phase-3 패턴 ('정책 명문화 + INTENT~APPROVE 자기참조 commit') 과 다른 운용 — v3.0 8 phase 안 명료한 'policy codification' phase 존재 / v3.1 3 phase 모두 narrative + smoke (정책 codification phase 부재). 본 milestone 종결 시 Stage G/H/I commit 또는 별 commit 으로 INTENT~APPROVE 산출 보존 의무.",
      "actionable": "v3.0+ 9-stage-bundled era milestone 운용 시 INTENT~APPROVE commit 시점 명문화 의무 — (a) phase-1 commit 안 포함 (사용자 결정 가능) / (b) Stage G commit 안 포함 (VERIFY 전 산출 영구 보존) / (c) 별 'Stage B-E' commit (산출물 명시 commit). 본 milestone 은 (b) 패턴 — 후속 candidate (claude/commands/harness-meta.md Stage F 절차 narrative 강화)."
    },
    {
      "id": "L7",
      "topic": "사용자 결정 trigger 의 자동 흡수 vs 사용자 결정 분기 — 4 관점 검토 19 권고 효율",
      "narrative": "5 관점 검토 결과 19 권고 (architecture 4 + spec-drift 3 + 회귀 risk 7 + scope contract 5) 중 18 자동 흡수 (DESIGN.decisions 갱신/신규) + 1 사용자 결정 (architecture P1 vs spec-drift D7 정신 충돌). v3.0 lessons L8 (5 관점 검토 자동 흡수 vs 사용자 결정 명확화) 직접 적용 사례 — AskUserQuestion 1회 (의견 충돌 분기점만), 사용자 부담 최소화. 자동 흡수 권고 모두 DESIGN.decisions 명시 (D13~D18 신규).",
      "actionable": "5 관점 검토 후 의견 충돌 식별 → AskUserQuestion 1회 (의견 충돌 분기점만, 자동 흡수 권고는 DESIGN.decisions 명시). 사용자 부담 최소화 + 자동 흡수 추적성 보존. v3.0 L8 actionable 일관 적용."
    },
    {
      "id": "L8",
      "topic": "pre-commit hook 등록 단순성 - 13 hook 조차 시간 영향 미미",
      "narrative": "pre-commit run --all-files 13 hook (built-in 5 + shellcheck + markdownlint + smoke 6) 모두 PASS 시간 ~ baseline 와 동등 (smoke-bundle-trigger 추가 ~0.6s). v2.1 batched python3 spawn 패턴 (smoke-spec-verification 0.63s + smoke-scope-contract 0.65s) 의 영향 — 신규 smoke 도 batched python3 단일 호출로 spawn 비용 부담 작음. v2.0 pre-commit 1m33s → v2.1 15.4s → v3.1 13 hook + ~0.6s 누적. 자동 강제 누적 (5요소 매트릭스 'Constraint' 정전) 의 trade-off 작음.",
      "actionable": "신규 smoke 작성 시 batched python3 spawn 패턴 의무 (v2.1 lessons L1 + tests/CLAUDE.md § smoke 작성 5-step Step 3 boilerplate). 자동 강제 누적 정신 일관 — narrative-only 정책의 자동 차단 누적 권장."
    },
    {
      "id": "L9",
      "topic": "신규 smoke의 status 기반 검증 분기 — pending entry 의 milestones_path 부재 허용 (post-EXECUTE discovery)",
      "narrative": "Stage I PROPOSE 직후 ROADMAP 갱신 (v3.1 completed + v3.2 pending entry 신규) 시 smoke-bundle-trigger 가 v3.2 pending entry 의 milestones_path 부재로 FAIL. 본질: pending status entry 는 OPEN (Stage A) 시점 디렉토리 마운트 후에 milestones_path 추가 — 즉 pending = milestones_path 부재 정상. smoke logic 에 status 기반 분기 추가: status: 'pending' 시 milestones_path 검증 skip, in_progress/completed 시만 의무. Stage G+H+I commit 에 포함 (별 fix commit 분리 부재 — 같은 의미 단위 grouping 정신 일관, smoke 수정 + REPORT.md L9 narrative + commit 메시지 명시).",
      "actionable": "신규 smoke 작성 시 'status 기반 검증 분기' 의무화 검토 — pending (= 시작 전 / 디렉토리 부재 가능) vs in_progress/completed (= 디렉토리 + 파일 존재 의무). tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 후속 candidate (status 기반 분기 row 추가, v3.2 sub-milestone 후보)."
    }
  ]
}
```

## summary narrative

본 milestone 은 v3.0_milestones-restructure 의 자연스러운 후속 — v3.0 도입 정책 (ARCHITECTURE.md § 6.1 bundling) 의 첫 후속 통합 milestone 사례. v3.0 종결 직후 발생한 PROPOSE 3건 + lessons L10 모두 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) 의미 단위 grouping 만족 → bundling trigger 조건 자체가 만족 → 통합 milestone 운용 의무.

기술적 핵심:

1. **markdownlint MD032/MD049 함정 narrative** (phase-1) — v3.0 lessons L10 직접 흡수. tests/CLAUDE.md § '흔한 함정' 7번째 row + MD049 spec 직접 인용 (D18). 자동 강제 부재 (markdownlint hook 자체 차단), narrative 만 사용자 안내.
2. **historical era 적용 결정** (phase-2) — milestones.md spec picture-frame 의 v2.x/v1.x 적용 정책. 옵션 (a) forward-only 강제 채택 (D1) — v2.x 9-stage flat 구조 본질 부적합 + forward-only 정책 일관. v3.0 milestones.md unchanged (D12, 사용자 결정 P1 수용).
3. **bundling trigger smoke** (phase-3) — ARCHITECTURE.md § 6.1 bundling 정책 자동 강제. tests/smoke-bundle-trigger.sh 신규 (단일 책임 D2 + detect_era 미호출 D16). pre-commit 12 → 13 hook (D3 자동 강제 누적). 자동 강제 누적 (5요소 매트릭스 'Constraint' 정전).

3 phase 통합 milestone (sub-milestone 1:1) — v3.0 통합 (8 phase, 정책 4 + 흡수 4) 대비 v3.1 통합 (3 phase) = bundling 정책 일상 운용 패턴 첫 적용 사례 (소규모). 4 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 1건 사용자 결정 해소 + 19 권고 자동 흡수.

회귀 0, pre-commit 13 hook 모두 PASS, INTENT.success_criteria 8건 모두 PASS. minor bump (v3.0 → v3.1, semver 정합).

## delta

- 13 파일 changed (9 신규 + 4 modified)
- 426 insertions / 10 deletions
- 3 commit (phase-1 ~ phase-3)
- 흡수 PROPOSE candidates 3건 (v3.0 → v3.1 sub-milestone 매핑)

## lessons_learned 종합

9 lessons (L1~L9) — bundling 정책 일상 운용 패턴 / milestones.md 선결 의무 (CRITICAL) / smoke 책임 분리 / scope 분류 / controlled 비교 cp949 / INTENT~APPROVE commit 시점 / 사용자 결정 trigger 효율 / pre-commit hook 등록 단순성 / smoke status 기반 검증 분기 (post-EXECUTE discovery). 후속 milestone 후보 5건 (L2 / L3 / L5 / L6 / L9 actionable — PROPOSE 검토).

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- INTENT: [`INTENT.md`](INTENT.md)
- VERIFY: [`VERIFY.md`](VERIFY.md) (verdict: pass)
- milestones.md: [`milestones.md`](milestones.md) (sub-milestone 3건 status: completed)
- 후속 (forward): [`PROPOSE.md`](PROPOSE.md) (next_candidates ROADMAP 등록)
