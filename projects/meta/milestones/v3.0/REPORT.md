# REPORT — v3.0_milestones-restructure

```json
{
  "summary": "v3.0_milestones-restructure (2026-05-10) — 사용자 발의 'milestone에서 같은 버전인데 다 따로 실행해야하는 이유를 모르겠어' 통찰에서 시작, 4 round 의문 검토 (분리 이유 → 통합 한 건 → 명명 root cause → ROADMAP+milestones.md schema 분리) 거쳐 milestone hierarchy 재구성 도출. 명명 구조 v{X.Y}_{slug} 가 grouping 한계의 root cause임을 인정 → ROADMAP `milestones[]` schema (version + id 분리, version 단위 1 entry) + 디렉토리 milestones/v{X.Y}/ (sub-id 부재) + milestones.md (sub-milestone listing per version) 신규 도입 + smoke era 4 era 분기 (4-tier / 7-stage / 9-stage / 9-stage-bundled) + tests/_era_detect.py 단일 source. 자기참조 부합 (도그푸드) 채택 — v3.0 자체가 신 구조 (milestones/v3.0/ + milestones.md) 첫 적용 사례. 5 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 모두 pass-with-comments + 의견 충돌 2건 사용자 결정 완료 (phase 분할/순서 + bundling trigger 명문화 위치). 8 phase 통합 milestone (정책 4 + 흡수 4) — D6 swap 으로 era-detect 분리 phase-2 적용 (drift 잠재 1 phase 단축). v2.2_* 4건 (era-detect / cp949 / controlled-comparison / historical-decision) 모두 phase 2/6/7/8 흡수 + 책임 보존 (commit ref + dependencies.absorbed_from). 8 phase 8 commit (b70431a / 2c75f02 / 55e5cce / a94d4a3 / 53fa077 / 0a80280 / 6888a0c / fec7894), pre-commit 12 hook 모두 PASS, 회귀 0. INTENT.success_criteria 8건 모두 PASS (manual 5 + smoke 3). breaking change → major bump (v2 → v3, semver 정합). forward-only — historical 디렉토리 (v1.84~v2.1) unchanged. 2026-05-10.",
  "delta": {
    "files_changed": 31,
    "files_added": 12,
    "files_modified": 19,
    "files_deleted": 0,
    "insertions": 1894,
    "deletions": 93,
    "modules_affected": [
      "projects/meta/ROADMAP.md (schema_note + v3.0 entry 신 schema + v2.2_* 4건 제거)",
      "projects/meta/ARCHITECTURE.md (§ 1 디렉토리 + § 3.3 매트릭스 + § 4 + § 6.1 4 era 정책 + bundling)",
      "projects/meta/CLAUDE.md (모듈 가이드 milestone 산출물 narrative)",
      "projects/meta/milestones/v3.0/ (신규: INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 7 + milestones.md + execute/phase-{1..8}.md 8)",
      "tests/smoke-spec-verification.sh (detect_era 정의 제거 + glob v[0-9]* + reconfigure errors='replace')",
      "tests/smoke-scope-contract.sh (detect_era import + Stage 1/2 era 분기 9-stage-bundled 추가 + reconfigure errors='replace' + Stage 1 (a) 보존 narrative)",
      "tests/_era_detect.py (신규 모듈, detect_era 단일 source)",
      "tests/CLAUDE.md (smoke 매트릭스 헤더 + 두 smoke narrative + § 흔한 함정 6번째 + Step 3 boilerplate + § 회귀 검증 controlled 비교 4-step)",
      "claude/commands/harness-meta.md (9-stage workflow 헤더 + bundling 1단락 + 대상 구분 표 + Stage A mkdir + ROADMAP schema)",
      "claude/hooks/post-report-write.sh (milestones.md 매치 제외 NOOP)",
      "CLAUDE.md (root) (모듈별 가이드 + 워크플로우 표 + CRITICAL 규칙 milestone 번호 정책)",
      "AGENTS.md (영문 cascade 3건)",
      "README.md (영문 cascade 2건)",
      "GUARDRAILS.md (H1 / C4 / § 4 헤더)",
      "docs/adr/ADR-006-workflow-revamp.md (후속 ADR 발전 narrative)"
    ],
    "phase_count": 8,
    "commit_count": 8,
    "absorbed_milestones": 4
  },
  "lessons_learned": [
    {
      "id": "L1",
      "topic": "사용자 통찰 round 가 root cause 도출",
      "narrative": "사용자 발의 '같은 v2.2 인데 따로 실행 이유?' → 4 round 검토 (분리 이유 → 통합 한 건 → 명명 root cause → schema 분리) 거쳐 v{X.Y}_{slug} 명명 구조 자체가 root cause임을 도출. round 누적이 단순 v2.2_* 4건 통합 → milestone hierarchy 재구성으로 scope 발전. 사용자 메모리 '반복적 pre-PLAN 검토 선호' 정신 직접 적용 사례.",
      "actionable": "사용자 통찰 round 의 매 단계마다 결정적 이슈 trigger 의무. round 결과를 INTENT.md narrative 에 명시 (검토 round 추적)."
    },
    {
      "id": "L2",
      "topic": "자기참조 부합 (도그푸드) vs 회피 표지 (chicken-and-egg) trade-off",
      "narrative": "v2.0_workflow-word-fidelity 자기참조 회피 (7-stage 포맷) 와 v3.0_milestones-restructure 자기참조 부합 (신 구조) 의 정책 발전. v2.0 시점 신뢰 부족 + 7→9 정의 변경, v3.0 시점 v2.0+v2.1 누적 신뢰로 부합 채택. R2 (자기참조 inconsistency) mitigation 으로 phase-1 smoke era branching 선결 commit + APPROVE go/no-go gate (D13).",
      "actionable": "새 era 도입 milestone 시 자기참조 부합 default. chicken-and-egg risk 시 phase 순서 (선결 commit) 로 mitigate. v2.0 회피 표지 사례는 historical 보존."
    },
    {
      "id": "L3",
      "topic": "bundling 정책의 ROADMAP/디렉토리 구조 효과",
      "narrative": "milestone naming v{X.Y}_{slug} flat 구조가 같은 X.Y 후속 candidates 를 별 milestone 으로 분리 강제 → v3.0+ 9-stage-bundled era 도입 후 같은 의미 단위 후속을 version 단위 1 milestone (sub-milestone phase 매핑) 으로 통합. 토큰 비용 ~75% 감소 (4× INTENT~PROPOSE 산출물 → 1× 통합) + merge conflict 회피 + 의존 관계 명료. version 단위 ROADMAP entry + milestones.md per version sub-milestone listing 의 정보 계층화.",
      "actionable": "후속 candidates 발의 시 bundling trigger 조건 (같은 모듈 / 주제 / lessons_learned) 적용 — 의미 단위 grouping 가능하면 통합 milestone, 부적합하면 별 milestone."
    },
    {
      "id": "L4",
      "topic": "forward-only era 영구화 trade-off",
      "narrative": "forward-only 정책 (historical 디렉토리 unchanged) = era N 추가 = smoke 분기 N+1 코드 복잡도 누적. detect_era 함수 단일 source (tests/_era_detect.py, v2.2_era-detect-shared-module 흡수 phase-2) 로 mitigate. era N+1 추가 시 ARCHITECTURE.md § 6.1 표 + tests/_era_detect.py 갱신 의무.",
      "actionable": "era 도입 시 forward-only 비용 명시 (ARCHITECTURE.md § 6.1 narrative). 향후 v4.0+ 추가 시 era 분기 N+1 누적 trade-off 재검토."
    },
    {
      "id": "L5",
      "topic": "controlled 비교 패턴의 milestone 검증 강력 도구",
      "narrative": "v2.1 lessons L3 (단순 baseline vs post 비교는 milestone 상태 변화로 PASS/SKIP 분포 차이) → v3.0 phase-7 흡수 (tests/CLAUDE.md § 회귀 검증 절차 4-step controlled 비교 패턴 명문화). 본 milestone 자체에서도 phase 별 PASS 변동 (109→116, 17→19) 의 의도 vs 회귀 분기에 적용 — 의도된 변경 (신규 산출물 + era 분류 변환) 모두 narrative 기록.",
      "actionable": "신규 smoke 작성 또는 기존 smoke 수정 시 controlled 비교 4-step 패턴 표준 절차. 의도된 변경은 REPORT.lessons_learned narrative."
    },
    {
      "id": "L6",
      "topic": "spec-drift 검토에서 picture-frame 의무 도출",
      "narrative": "spec-drift 검토 권고 #2 — 신 schema 의 정식 키 매핑 (picture-frame) 을 milestones.md 상단에 박음 의무. 본 milestone 에서 milestones.md spec 섹션 + Instance 섹션 분리. 향후 9-stage-bundled era 신규 milestone 작성 시 spec reference.",
      "actionable": "신 schema 도입 시 picture-frame 섹션 + Instance 섹션 분리 의무. spec-drift 검토 의무 (Stage D 5 관점 검토)."
    },
    {
      "id": "L7",
      "topic": "v2.2_* 4건 흡수 시 책임 보존 (commit ref + absorbed_from 필드)",
      "narrative": "흡수 milestone (v2.2_* 4건) 의 ROADMAP entry 제거 + v3.0 sub-milestone (phase 2/6/7/8) 책임 완료 + 정보 추적성 보존 (D14): commit 메시지에 원 milestone id reference + milestones.md sub-milestone entry absorbed_from 필드 + 흡수 추적성 표 (milestones.md § 흡수 추적성). 보안 S6 (MEDIUM) 요구사항.",
      "actionable": "후속 milestone 흡수 시 D14 패턴 적용 — commit ref + absorbed_from + 추적성 표 의무."
    },
    {
      "id": "L8",
      "topic": "5 관점 검토의 의견 충돌 2건 사용자 결정 효과",
      "narrative": "5 관점 검토 결과 의견 충돌 2건 (phase 분할/순서 + bundling trigger 명문화 위치) 사용자 결정 완료. 자동 흡수 11건 (DESIGN.decisions D7/D9/D10/D14/D15/D16/D17/D18/D19) — 5 관점 권고가 DESIGN.decisions 로 자동 흡수되어 사용자 부담 최소화. 의견 충돌 결정만 AskUserQuestion 으로 사용자 trigger.",
      "actionable": "5 관점 검토 결과 종합 시 자동 흡수 vs 사용자 결정 명확화. 자동 흡수는 DESIGN.decisions 명시 + 사용자 결정만 AskUserQuestion."
    },
    {
      "id": "L9",
      "topic": "transition state 명시의 검증자 혼란 회피",
      "narrative": "ROADMAP transition state (v3.0 entry 임시 기존 schema → phase-4 신 schema 변환) 와 era 분류 transient (v3.0 7-stage fallback → phase-5 9-stage-bundled 변환) 모두 DESIGN.decisions D11 + D6 narrative 로 사전 명시. 검증자 (5 관점 subagent + smoke + 향후 reader) 혼란 회피.",
      "actionable": "신 era 도입 milestone 시 transition state 사전 명시 의무 (DESIGN.decisions). transient 비용 narrative 기록."
    },
    {
      "id": "L10",
      "topic": "markdownlint 자동 차단 함정 — 빈 줄 + escape (강조 vs 백틱)",
      "narrative": "phase-3 commit 시 markdownlint MD032 (blanks-around-lists) + MD049 (emphasis-style underscore) 위반 발견. INTENT.md 안 `v{X.Y}_{slug}` underscore → emphasis 오인 → 백틱 escape 의무. APPROVE.md / DESIGN.md list 앞뒤 빈 줄 의무.",
      "actionable": "milestone 산출물 작성 시 (a) underscore 포함 단어 백틱 escape, (b) 강조 (**...**) 직후 list 시 빈 줄 의무. tests/CLAUDE.md § 흔한 함정 7번째 항목 후보 — 별 milestone 검토."
    }
  ]
}
```

## summary narrative

본 milestone 은 사용자의 단순 의문 ("같은 v2.2 인데 따로 실행 이유?") 에서 시작해 milestone naming 구조 자체의 재구성으로 scope 가 발전한 사례. 4 round 의문 검토 누적이 단순 v2.2_* 4건 통합 (~75% 토큰 절감) → milestone hierarchy 재구성 (version > sub-milestone > phase 계층) → 자기참조 부합 (도그푸드) 의 큰 결정으로 이어짐.

기술적 핵심:

1. **ROADMAP schema 변경** (version + id 분리, version 단위 1 entry) — 정보 계층화 (high-level ROADMAP / detailed milestones.md per version)
2. **디렉토리 구조 변경** (milestones/v{X.Y}/ + milestones.md) — sub-id 부재, version 통합
3. **smoke era 4 era 분기** (4-tier / 7-stage / 9-stage / 9-stage-bundled) + tests/_era_detect.py 단일 source
4. **자기참조 부합** (도그푸드) — v3.0 자체가 신 구조 첫 적용 사례, v2.0 회피 표지 선례와 대조
5. **forward-only** — historical 디렉토리 (v1.84~v2.1) unchanged, era N+1 누적 trade-off 명시

8 phase 통합 milestone — 정책 4 (smoke era / _era_detect.py / 정책 명문화 / ROADMAP schema) + 흡수 4 (cp949 / controlled-comparison / historical-decision + era-detect = phase-2 swap). 5 관점 병렬 검토 모두 pass-with-comments + 의견 충돌 2건 사용자 결정 완료 + 자동 흡수 11건. R2 (자기참조 inconsistency) mitigation 완성 — phase-1 smoke 선결 + APPROVE go/no-go gate.

회귀 0, pre-commit 12 hook 모두 PASS, INTENT.success_criteria 8건 모두 PASS. breaking change → major bump (v2 → v3, semver 정합).

## delta

- 31 파일 changed (12 신규 + 19 modified)
- 1894 insertions / 93 deletions
- 8 commit (phase-1 ~ phase-8)
- 흡수 milestone 4건 (v2.2_*)

## lessons_learned 종합

10 lessons (L1~L10) — 사용자 통찰 round / 자기참조 부합 / bundling 정책 / forward-only era 영구화 / controlled 비교 / picture-frame / 흡수 책임 보존 / 5 관점 검토 자동 흡수 / transition state 명시 / markdownlint 함정. 후속 milestone 후보 1건 (L10 markdownlint 함정 — tests/CLAUDE.md § 흔한 함정 7번째 항목 가능, PROPOSE 검토).

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- INTENT: [`INTENT.md`](INTENT.md)
- VERIFY: [`VERIFY.md`](VERIFY.md) (verdict: pass)
- milestones.md: [`milestones.md`](milestones.md) (sub-milestone 8건 status: completed)
- 후속 (forward): [`PROPOSE.md`](PROPOSE.md) (next_candidates ROADMAP 등록)
