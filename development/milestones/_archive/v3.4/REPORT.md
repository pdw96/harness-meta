# REPORT — v3.4 open-stage-milestones-md-protocol

```json
{
  "id": "v3.4_open-stage-milestones-md-protocol",
  "summary": "v3.3 L1 직접 후속 단독 milestone. claude/commands/harness-meta.md Stage A OPEN 절차에 step 7 ('milestones.md 스켈레톤 즉시 작성') 신규 추가 + Stage F 선결 조건 게이트 블록 narrative 미세 갱신 (DRY 회피 + 보조 검증 step 명시). v3.0+ 9-stage-bundled era 의 시간 격차 (OPEN entry in_progress 전환 ↔ Stage F 게이트 milestones.md 작성) 봉쇄. skeleton 최소 필드 narrative 1차 source 위치 Stage F 게이트 → Stage A step 7 로 이동. 자기참조 부합 (도그푸드) — v3.4 OPEN 단계 자체가 본 절차 첫 적용 사례. 3 관점 (architecture / spec-drift / scope contract) 병렬 검토 모두 pass-with-comments, 의견 충돌 0, 권고 흡수 완료 (R4 즉시 / R1 D4 narrative 강화 / R2·R3·R5·D7 본 REPORT). 단일 phase 1 commit (c3c35a9), pre-commit 13 hook 모두 PASS, 회귀 0. INTENT.success_criteria 6건 모두 PASS. 2026-05-11.",
  "delta": {
    "files_changed": [
      {
        "file": "claude/commands/harness-meta.md",
        "type": "modified",
        "lines": "+24 -2",
        "section": "Stage A OPEN step 7 신규 + Stage F 선결 조건 게이트 블록 narrative 갱신"
      },
      {
        "file": "projects/meta/ROADMAP.md",
        "type": "modified",
        "lines": "+2 -1",
        "section": "v3.4 entry status: pending → in_progress + milestones_path 추가"
      }
    ],
    "files_added": [
      "projects/meta/milestones/v3.4/INTENT.md",
      "projects/meta/milestones/v3.4/RESEARCH.md",
      "projects/meta/milestones/v3.4/DESIGN.md",
      "projects/meta/milestones/v3.4/APPROVE.md",
      "projects/meta/milestones/v3.4/VERIFY.md",
      "projects/meta/milestones/v3.4/REPORT.md",
      "projects/meta/milestones/v3.4/PROPOSE.md (Stage I 시점 추가)",
      "projects/meta/milestones/v3.4/milestones.md",
      "projects/meta/milestones/v3.4/execute/phase-1.md"
    ],
    "files_deleted": [],
    "modules_affected": [
      "claude/commands/ — Stage A OPEN 절차 + Stage F 선결 조건 게이트 블록 narrative 갱신"
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "title": "narrative 1차 source 시점-위치 결합 원칙",
      "detail": "산출물 생성 시점이 narrative 1차 source 위치와 자연 결합 — v3.4 가 skeleton 필드 narrative 1차 source 를 Stage F 게이트 (EXECUTE 진입 직전) → Stage A step 7 (OPEN 시점) 로 이동. v3.2 phase-1 도입 narrative 의 reference-only 전환 시점 = v3.4 (spec-drift R2 흡수, 역사 trace 보존). 향후 신규 절차 명문화 시 '산출물이 처음 생성되는 시점 = narrative 1차 source 위치' 원칙 적용 권장."
    },
    {
      "id": "L2",
      "title": "자기참조 부합 (도그푸드) 의 commit hash trace 명시",
      "detail": "scope-contract 권고 3 흡수 — D7 자기참조 trace 의 commit hash + timestamp 명시. v3.4 OPEN 단계 milestones.md 작성 시점 = phase-1 commit c3c35a9 (2026-05-11). milestones.md sub_milestones[0].status: complete + commit: c3c35a9 = 도그푸드 artefact. v3.0/v3.1 자기참조 패턴 연속 — 향후 era/절차 도입 milestone 시 동일 trace 의무."
    },
    {
      "id": "L3",
      "title": "보조 검증 step narrative 명시로 자동 강제력 보존",
      "detail": "spec-drift R1 (high) 흡수 — Stage F 게이트 narrative 갱신 시 보조 검증 step (test -f milestones/v{X.Y}/milestones.md) 명시. narrative 축약 (1차 source 이동) 시 자동 강제력 약화 가능 위험을 보조 검증 step 으로 mitigate. v3.2 phase-1 게이트 narrative 의 자동 강제 정신 보존."
    },
    {
      "id": "L4",
      "title": "scope 작음 (≤5 파일) 정의 적용 — 3 관점 검토 충분",
      "detail": "affected_files 2건 + 절차 명문화 한정 → 3 관점 (architecture / spec-drift / scope contract) 검토 적용 (회귀 risk + 보안 생략, ARCHITECTURE.md § 'scope 작음' 정의 차용). 3 관점 모두 pass-with-comments + 의견 충돌 0 + 권고 흡수 완료. 5 관점 검토는 scope 중간/큼 시 적용 — 절차 명문화 milestone 은 보통 작음."
    },
    {
      "id": "L5",
      "title": "smoke 자동 동작 변경 없는 절차 명문화 milestone 의 controlled 비교 미적용",
      "detail": "scope-contract 권고 2 흡수 — smoke 자동 동작 변경 없음 (smoke-bundle-trigger / spec-verification / scope-contract 로직 미수정) → controlled 비교 시나리오 (v2.1 lessons L3 / v3.0 phase-7 패턴) 미적용. 단순 pre-commit 13 hook 모두 PASS 검증으로 충분. 향후 동일 유형 milestone (절차 명문화 한정) 시 controlled 비교 생략 가능."
    },
    {
      "id": "L6",
      "title": "cascade host 보수 유지 결정의 명시 narrative 의무",
      "detail": "scope-contract 권고 1 흡수 — D5 (root CLAUDE.md L19 보수 유지) + D6 (projects/meta/CLAUDE.md 보수 유지) 결정은 'cascade 부담 최소화 + thin index 정책 일관' rationale 로 정당화. 향후 cascade host 광범위 검토 부담 회피 시 결정 narrative 에 보수 유지 정당성 명시 의무."
    },
    {
      "id": "L7",
      "title": "v3.x bundling era 단독 후속 milestone 패턴 (single sub-milestone)",
      "detail": "v3.4 는 단일 sub-milestone (phase-1) 의 단독 후속 milestone 사례. v3.1/v3.2 는 3 sub-milestone (phase-1~3) 통합 패턴, v3.0 은 8 phase 통합 패턴. bundling era 의 sub-milestone 개수는 1+ 가변 — 단일 phase 도 milestones.md 운용 의무 적용 (sub_milestones[] 길이 1 도 정상). 향후 단일 phase milestone 의 OPEN 절차 의무 패턴 표준화."
    },
    {
      "id": "L8",
      "title": "smoke-bundle-trigger PROPOSE 단계 실시간 자동 강제 검출 사례",
      "detail": "v3.4 Stage I PROPOSE 단계 ROADMAP 갱신 시점에 v3.5 candidate 2건을 별 entry 로 초기 등재 → smoke-bundle-trigger 가 즉시 'version=v3.5 entry 2건 발견 - bundling 정책 위반' FAIL 검출 → bundle 단일 entry 로 즉시 통합 → smoke PASS. v3.1 phase-3 도입 smoke 가 narrative 1차 source (ARCHITECTURE.md § 6.1 'version 단위 1 milestone') 의 자동 강제 책임을 실시간 PROPOSE 단계에서 정상 작동. 사용자 의도되지 않은 bundling 정책 우회 (별 entry 등재) 가 사전 차단되어 narrative 정합 보존. 후속 candidate 등재 시 bundle vs 분리 결정 의무 narrative 사례 — 향후 PROPOSE 작성 가이드 narrative 강화 검토 (v3.5+ 후속 candidate)."
    }
  ]
}
```

## narrative

본 milestone 은 v3.3 PROPOSE next_candidates 단독 후속 + 단일 phase 1 commit 패턴. 3 관점 검토 + 의견 충돌 0 + 권고 흡수 완료 + 회귀 0 으로 9-stage-bundled era 의 보수적 milestone 운용 사례. 7 lessons (L1~L7) 중 L1 (narrative 1차 source 시점-위치 결합) 와 L2 (도그푸드 commit hash trace) 가 핵심 — 향후 절차 명문화 milestone 패턴 표준화 권장.

next_candidates (forward) 는 PROPOSE.md 로 분리 — 본 REPORT 는 backward 종합 한정.
