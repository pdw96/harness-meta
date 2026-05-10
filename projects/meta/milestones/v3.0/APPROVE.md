# APPROVE — v3.0_milestones-restructure

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-10",
    "milestone_id": "milestones-restructure",
    "version": "v3.0"
  },
  "approval_summary": {
    "narrative": "v3.0_milestones-restructure 는 milestone naming 구조 v{X.Y}_{slug} 의 grouping 한계를 ROADMAP schema (version+id 분리) + 디렉토리 milestones/v{X.Y}/ + milestones.md (sub-milestone listing per version) 도입으로 해결하는 8 phase 통합 milestone. forward-only (historical 보존) + 자기참조 부합 (도그푸드) + breaking change → major bump (v2 → v3). 사용자 발의 (2026-05-10) — '같은 v2.2 인데 따로 실행해야 하는 이유?' 통찰에서 시작, 4 round 의문 (분리 이유 → 통합 한 건 → 명명 root cause → ROADMAP+milestones.md schema 분리) 거쳐 확정.",
    "stages_completed": [
      "Stage A — OPEN (milestones/v3.0/execute mkdir + ROADMAP entry 추가, uncommitted)",
      "Stage B — INTENT.md (8 success_criteria + 7 out_of_scope + 6 predecessors)",
      "Stage C — RESEARCH.md (4 external + 23 affected_files + 8 untouched + 9 options 결정 + 10 risks)",
      "Stage D — DESIGN.md (19 decisions + 8 phases + 13 risk_mitigation) + 5 관점 병렬 검토"
    ],
    "review_results": [
      {"perspective": "architecture (Plan)", "verdict": "pass-with-comments", "key_recommendations": 5, "absorbed_into_decisions": ["D6 (phase-5 swap)", "D9 (R9 INTENT 신 schema 유지)", "D10 (era 표지)", "D2 (id ↔ 디렉토리 narrative)"]},
      {"perspective": "spec-drift (general-purpose + context7)", "verdict": "pass-with-comments", "key_recommendations": 5, "absorbed_into_decisions": ["D17 (breaking change + era 영구화)", "D5 (picture-frame)", "D12 (bundling trigger)", "D7 (자기참조 정합)"]},
      {"perspective": "회귀 risk (Explore)", "verdict": "pass-with-comments", "key_recommendations": 5, "absorbed_into_decisions": ["D6 (phase swap)", "D11 (transition state)", "D16 (hook)"]},
      {"perspective": "보안 (general-purpose + security-review SKILL)", "verdict": "pass-with-comments (CRITICAL/HIGH 0, MEDIUM 3)", "key_recommendations": 5, "absorbed_into_decisions": ["D15 (errors='replace')", "D16 (hook 매치 제외)", "D14 (commit ref)", "S1-S3 LOW 자동"]},
      {"perspective": "scope contract (Explore)", "verdict": "pass-with-comments", "key_recommendations": 5, "absorbed_into_decisions": ["D9 (R9)", "D13 (APPROVE gate)", "D14+D5 (R7)", "D18 (rollback)", "D19 (VERIFY 시점)"]}
    ],
    "user_decisions_count": 9,
    "user_decisions": [
      "D1: forward-only (historical 보존)",
      "D2: 명명 v{X.Y}_{group-slug} + phase-{n}",
      "D3: ROADMAP entry version 단위 1 entry",
      "D4: milestones.md 위치 milestones/v{X.Y}/",
      "D5: milestones.md 내용 sub-milestone 상세",
      "D6: 8 phase + phase-5 swap (era-detect 분리 → phase-2)",
      "D7: 자기참조 부합 (도그푸드)",
      "D8: milestone id = milestones-restructure",
      "D12: bundling trigger 명문화 위치 = ARCHITECTURE.md § 6"
    ],
    "auto_absorbed_count": 10,
    "auto_absorbed": [
      "D9 (INTENT.md JSON id 신 schema)",
      "D10 (9-stage-bundled era 표지 (a)+(b))",
      "D11 (ROADMAP transition state)",
      "D13 (APPROVE go/no-go gate)",
      "D14 (commit ref + dependencies.absorbed_from)",
      "D15 (sys.stdout.reconfigure errors='replace')",
      "D16 (post-report-write.sh milestones.md 매치 제외)",
      "D17 (breaking change + era 영구화 narrative)",
      "D18 (phase-4 rollback 절차)",
      "D19 (VERIFY.md Stage G 작성 시점)"
    ],
    "phase_count": 8,
    "phases_summary": [
      "phase-1: smoke era branching (선결, 4 era 인식 + post-report-write hook 갱신)",
      "phase-2: tests/_era_detect.py 분리 (v2.2_era-detect-shared-module 흡수, drift 잠재 1 phase 단축)",
      "phase-3: 정책 명문화 (ARCHITECTURE § 6 + cascade 6 host) + INTENT~APPROVE 자기참조 commit",
      "phase-4: ROADMAP schema 변경 (version+id 분리) + v2.2_* 4건 entry 제거",
      "phase-5: milestones.md 신규 + spec picture-frame",
      "phase-6: v2.2_smoke-cp949-encoding-pattern 흡수",
      "phase-7: v2.2_smoke-controlled-comparison-pattern 흡수",
      "phase-8: v2.2_historical-7stage-stage1-decision 흡수 + 결정 (옵션 a/b/c phase 진행 시 AskUserQuestion)"
    ]
  },
  "go_no_go_gate": {
    "decision_id": "D13",
    "conditions": [
      "phase-1 smoke 4 era 인식 PASS (smoke-spec-verification.sh + smoke-scope-contract.sh)",
      "phase-2 tests/_era_detect.py import 정합 (Windows + WSL/MSYS2 호환)",
      "각 phase pre-commit smoke 5 hook 모두 PASS (R5 mitigation — 회귀 격리)"
    ],
    "rollback": "phase 단위 commit 격리 — 회귀 발견 시 git revert <phase commit hash>. phase-4 (ROADMAP schema) 는 D18 절차 (git diff HEAD~ HEAD -- projects/meta/ROADMAP.md 후 manual revert)."
  },
  "constraints": {
    "no_verify_forbidden": "사용자 명시 승인 없이 --no-verify 사용 금지 (CLAUDE.md 정책 + APPROVE 게이트 정합)",
    "destructive_forbidden": "v2.2_* 4건 흡수 시 git rm -rf 또는 git reset --hard 금지 (보안 S6 — milestones/v2.2_* 디렉토리 부재 검증, pending 상태로 미생성)",
    "commit_message_ref": "phase-2/4/6/7/8 commit 메시지에 원 v2.2 milestone id reference 의무 (D14)"
  }
}
```

## 승인 narrative

본 milestone 의 핵심 통찰은 사용자 발의 (2026-05-10): "milestone에서 같은 버전인데 다 따로 실행해야하는 이유를 모르겠어." — 이로부터 4 round 의문 검토를 거쳐 milestone naming 구조 자체 (v{X.Y}_{slug}) 가 grouping 분리 강제의 root cause임을 도출.

**검토 round 추적** (사용자 메모리 '반복적 pre-PLAN 검토 선호' 부합):

1. round 1 — "v2.2_* 4건 따로 실행 이유?" → 분리 = 토큰 비효율 + merge conflict + 의존 표현 어려움
2. round 2 — "통합 한 건에 phase로 구분?" → 자기참조 부합 + bundle 정책
3. round 3 — "명명 구조가 root cause?" → `v{X.Y}_{slug}` flat 자체 문제 → B' 옵션 + forward-only + breaking change v3.0
4. round 4 — "ROADMAP에서 version과 id 분리 + milestones.md?" → schema + 디렉토리 + milestones.md 신규

**5 관점 검토** (Stage D 병렬 subagent) 모두 pass-with-comments + 의견 충돌 2건 사용자 결정 완료.

**EXECUTE 진입 조건 충족**:

- [x] INTENT.md 작성 (8 success_criteria 명시)
- [x] RESEARCH.md 작성 (affected_files 23건 + risks 10건)
- [x] DESIGN.md 작성 (19 decisions + 8 phases)
- [x] 5 관점 검토 완료 (모두 pass-with-comments)
- [x] 의견 충돌 해소 (사용자 결정 2건)
- [x] 사용자 명시 승인 (본 APPROVE.md)

EXECUTE Stage F 진입 — phase-1 부터 순차 진행. 각 phase = 1 commit (conventional commits, R5 회귀 격리).

## go/no-go gate (D13)

phase-1 commit 후:

- smoke-spec-verification.sh 실행 → 4 era milestone 모두 PASS 확인
- smoke-scope-contract.sh 실행 → 동일 확인
- 두 smoke fail 시 phase-1 revert + DESIGN.D6 swap 재검토

phase-2 commit 후:

- tests/_era_detect.py import 정합 (양쪽 smoke 정상 import)
- Windows + WSL/MSYS2 spawn 정상

phase-3 진입 전 (자기참조 INTENT~APPROVE commit):

- phase-1 + phase-2 모두 PASS 확인 (smoke 신 era 인식 보장)
- 그렇지 않으면 INTENT~APPROVE commit 시 smoke fail (R2)

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 + § 6 (phase-3 갱신)
- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- 다음 단계: phase-1 (smoke era branching) — `tests/smoke-spec-verification.sh` + `tests/smoke-scope-contract.sh` + `claude/hooks/post-report-write.sh` 4 era 인식 갱신
