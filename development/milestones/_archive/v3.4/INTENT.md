# INTENT — v3.4 open-stage-milestones-md-protocol

```json
{
  "id": "v3.4_open-stage-milestones-md-protocol",
  "title": "OPEN stage 절차에 milestones.md 스켈레톤 동시 생성 명문화",
  "goal": "harness-meta.md Stage A OPEN 절차 (현재 step 1~6) 에 'milestones.md 스켈레톤 동시 생성' 단계를 명시 추가하여, v3.0+ 9-stage-bundled era 의 모든 신규 milestone 이 in_progress 전환과 동시에 milestones.md 를 보유하도록 단일 source 절차로 강제한다.",
  "motivation": "v3.3 L1 발견 — tests/smoke-bundle-trigger.sh 는 ROADMAP 의 v3.0+ entry 가 in_progress 전환되는 순간 milestones_path 필드 존재 + 실 파일 존재 를 동시에 요구한다 (v3.1 phase-3 도입). 그러나 현행 claude/commands/harness-meta.md Stage A OPEN 절차 (root CLAUDE.md L19 / projects/meta/CLAUDE.md L21~23 cascade) 에는 컨테이너 mkdir + ROADMAP entry 갱신 만 단계화되어 있고 'milestones.md 동시 생성' 은 Stage F (EXECUTE) 선결 조건 게이트 블록 으로만 명시 (v3.2 phase-1 도입). 결과적으로 Claude 가 OPEN 단계 종료 시 ROADMAP entry 만 in_progress 로 바꾸고 milestones.md 작성을 Stage F 직전 으로 미루면, OPEN 직후 Claude 가 stop 하거나 사용자가 별도 verify 를 돌리는 순간 smoke 가 'milestones_path 부재 또는 실 파일 부재' 로 FAIL. v3.3 자체는 phase-1 첫 commit 직전 milestones.md 를 inline 생성하여 회피했으나 절차로 박혀있지 않아 재발 가능. 본 milestone 은 OPEN 절차에 한 단계 (mkdir + ROADMAP + milestones.md 스켈레톤 = 동시 commit/write) 로 박아 재발 봉쇄.",
  "success_criteria": [
    "claude/commands/harness-meta.md Stage A OPEN 절차 (현재 step 1~6) 에 'milestones.md 스켈레톤 동시 생성' step 명시 (적정 위치 = mkdir 직후 또는 ROADMAP entry 갱신 직후)",
    "스켈레톤 최소 필드 명시 — version + sub_milestones[] (phase-1 status: in_progress) 의무, sub_milestones 정확한 분할은 Stage D DESIGN 에서 확정 가능 narrative",
    "v3.1 L2 CRITICAL mitigation 와 cross-ref — 'milestones.md 부재 시 tests/_era_detect.py 가 era 오인 → smoke-spec-verification/smoke-scope-contract FAIL' 인용 (이미 Stage F 선결 조건 블록 패턴 차용)",
    "단일 source 정합 — root CLAUDE.md L19 워크플로우 표 cascade 점검 (필요시 1줄 갱신), projects/meta/CLAUDE.md '모듈 가이드' 행 cascade 점검",
    "smoke 회귀 0 — pre-commit 13 hook 모두 PASS, 특히 smoke-bundle-trigger / smoke-spec-verification / smoke-scope-contract 회귀 0",
    "자기참조 부합 (도그푸드) — v3.4 OPEN 단계 자체가 본 절차를 수행 (milestones.md 스켈레톤 이미 OPEN 단계 commit 전 작성 완료, 본 INTENT 작성 시점에서 충족)"
  ],
  "out_of_scope": [
    "milestones.md JSON 스키마 변경 (v3.1 phase-2 historical 적용 결정 + sub_milestones 필드 합의 완료, forward-only 유지)",
    "smoke-bundle-trigger.sh 신규 검증 추가 (v3.1 phase-3 에서 in_progress + milestones_path 검증 도입 완료, 본 milestone 은 절차 명문화 한정)",
    "ARCHITECTURE.md § 6.1 bundling 정책 본문 갱신 (참조용 cross-ref 외 변경 없음 — 정책은 v3.0/v3.1 에서 확정)",
    "Stage F 선결 조건 게이트 블록 (v3.2 phase-1 도입) 의 변경 — OPEN 단계로 강제 시점을 앞당기는 것 외 게이트 자체는 보존",
    "v2.0~v2.1 9-stage era 보존 milestone 의 절차 (slug 디렉토리 / milestones.md 부재) — forward-only"
  ],
  "dependencies": [
    "선행 v3.1_workflow-policy-fine-tuning — milestones.md 의무화 + tests/smoke-bundle-trigger.sh 도입 (L2 CRITICAL mitigation 의 위 절차 명문화 단계)",
    "선행 v3.2_workflow-narrative-strengthening — Stage F 선결 조건 게이트 블록 (milestones.md 선결 의무 narrative) 도입",
    "선행 v3.3_ci-inactive-smoke-cleanup — L1 직접 발견 (OPEN 단계 milestones.md 동시 생성 gap 발견 → v3.4 후속 등재)",
    "후행 없음 (절차 명문화 1회 후 v3.x+ 모든 신규 milestone 자동 적용)"
  ]
}
```

## narrative

본 milestone 은 v3.3 PROPOSE next_candidates 단독 후속 (v3.3 L1 직접 트리거). 의도 자체가 'OPEN 단계 milestones.md 동시 생성 절차 명문화' 1건 — out_of_scope 5건 으로 모든 인접 영역 (스키마 / smoke / 정책 본문 / Stage F 게이트 / 보존 era) 을 명시 제외하여 scope 협소 유지. 본 milestone 의 OPEN 단계 자체가 본 절차를 도그푸드 수행 → 자기참조 부합. 성공 기준 6 건 중 5 건은 산출물 (절차 step / cross-ref / smoke / 스키마 / 자기참조), 1 건은 회귀 보장 (pre-commit 13 hook).
