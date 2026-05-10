# REPORT — v2.1_smoke-spawn-batching

```json
{
  "summary": "사용자 발의 (2026-05-10 'commit test 가 소요하는 시간이 너무 많은거 같은데, 정합성 검토해봐') 후 사전 RESEARCH 에서 5 active smoke 시간 측정 → smoke-spec-verification 66.4s + smoke-scope-contract 12.4s 가 전체 pre-commit 1m33s 의 84% 점유 + 17 milestones × 8 stage = ~150 회 python3 spawn (Windows MSYS2 spawn cost 0.376s × N) 패턴이 압도적 병목. 5 active smoke 의 책임은 모두 정합 (중복 0 / 누락 0) — 시간 비효율은 책임이 아니라 구현 패턴. 사용자 채택 Approach A (단일 batched python3 호출) 로 spec-verification 66.4s → 0.63s (99.05% 감소) + scope-contract 12.4s → 0.65s (94.76% 감소) + 전체 pre-commit 93.3s → 15.4s (83.49% 감소) 달성. INTENT.success_criteria 7건 모두 임계 대비 2~16x 여유로 PASS, 회귀 0. 9-stage workflow (v2.0+ 신규 워크플로우) 의 두 번째 적용 사례 — INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 흐름 정전 검증.\n\n3 관점 병렬 검토 (architecture / 회귀 risk / scope contract — D11 spec-drift 자리 회귀 risk 대체) 모두 pass-with-comments, 의견 충돌 0. 검토 권고 11건 모두 흡수 — D5 (detect_era 일원화 옵션 e), D12 (Python 함수 분리), D13 (heredoc quoting), D14 (flush=True), D15 (spec-verification era 통합), D16 (VERIFY 자동 검증 의무), D17 (REPORT 시간 측정 의무) 7 decision 추가 + R11~R13 3 risk 추가. v1.4_infra-minimization (인프라 최소화 정신) 와 정합 — smoke 갯수 / 책임 / narrative 변경 0, 오직 spawn 비용만 감소.\n\n구현 중 신규 발견 1건 — Windows cp949 콘솔에서 em dash (U+2014) UnicodeEncodeError. smoke-python-entry-boilerplate § P2 v1.87 패턴 (sys.stdout.reconfigure(encoding='utf-8')) 차용으로 즉시 정정. DESIGN 산출 시 spec-drift 관점 생략의 trade-off — Windows 콘솔 인코딩 같은 환경 spec drift 가 미발견. 후속 lessons (스크립트 단계의 인코딩 spec 의무 검토). 2 phase commit (e4cffd6 + de1421e), pre-commit 5 hook 모두 PASS, 회귀 0. 2026-05-10.",
  "delta": {
    "files_changed": [
      "tests/smoke-spec-verification.sh — 196 라인 → 188 라인 (per-call PYEOF heredoc 2개 → 단일 batched python heredoc + def 함수 6개)",
      "tests/smoke-scope-contract.sh — 236 라인 → 198 라인 (check_out_of_scope/check_approval/detect_era bash 함수 → Python 일원화 + Stage 3 bash 유지)",
      "projects/meta/ROADMAP.md — milestone entry 추가 (status: in_progress → completed via PROPOSE)"
    ],
    "files_added": [
      "projects/meta/milestones/v2.1_smoke-spawn-batching/INTENT.md",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/RESEARCH.md",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/DESIGN.md",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/APPROVE.md",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/VERIFY.md",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/REPORT.md",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/execute/phase-1.md",
      "projects/meta/milestones/v2.1_smoke-spawn-batching/execute/phase-2.md"
    ],
    "files_deleted": [],
    "modules_affected": ["tests/", "projects/meta/milestones/", "projects/meta/ROADMAP.md"],
    "commits": [
      {"hash": "e4cffd6", "title": "feat(meta): v2.1 phase-1 — smoke-spec-verification python3 spawn batching (66s→0.63s, 99% 감소)"},
      {"hash": "de1421e", "title": "feat(meta): v2.1 phase-2 — smoke-scope-contract python3 spawn batching (12s→0.65s, 95% 감소)"}
    ]
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "Windows MSYS2 콘솔 인코딩 (cp949) 호환성은 smoke 작성 표준 의무로 박을 가치",
      "context": "phase-1 첫 실행 시 em dash (U+2014) UnicodeEncodeError 'cp949 codec can't encode' 발생. smoke-python-entry-boilerplate § P2 (v1.87) 가 이미 sys.stdout.reconfigure 패턴 표준화했으나 신규 smoke 작성 시 자동 적용되지 않음. tests/CLAUDE.md § '흔한 함정' 5건 (CRLF/MSYS2 path/pipefail/grep -c/shellcheck) 외 6번째 함정으로 추가 가치 있음.",
      "actionable": "후속 milestone candidate — tests/CLAUDE.md § '흔한 함정' 에 cp949 콘솔 인코딩 항목 추가 + smoke 작성 5-step 흐름 Step 3 (Generate) 에 stdout.reconfigure 의무 명시"
    },
    {
      "id": "L2",
      "lesson": "spec-drift 관점 생략의 trade-off — 환경 spec (OS/콘솔 인코딩) 누락",
      "context": "DESIGN.D11 에서 scope=작음 + 외부 spec 의존 거의 없음 사유로 spec-drift 관점 생략 + 회귀 risk 대체. 그러나 Python sys.stdout 의 OS 별 default encoding 같은 '환경 spec' 은 spec-drift 관점에서 잡혔을 가능성. 회귀 risk 관점 검토 시 R11/R12 외 cp949 케이스 미발견.",
      "actionable": "후속 milestone (review_perspectives 필드 도입) 에서 'spec-drift' 의 범위에 환경 spec (OS/콘솔/locale) 도 포함 명시. 또는 scope=작음 milestone 도 spec-drift 항상 invoke."
    },
    {
      "id": "L3",
      "lesson": "controlled 비교 (HEAD 시점 구 코드 vs 신 코드 + 동일 milestone 상태) 가 baseline 동치 검증의 강력한 도구",
      "context": "phase-2 검증 시 단순 baseline 와 post 비교는 milestone 상태 변화 (v2.1_smoke-spawn-batching 자체 진행) 로 PASS/SKIP 분포 다름. git show HEAD:tests/smoke-scope-contract.sh > /tmp/old.sh 후 동일 시점 milestone 상태에서 구 smoke 실행하여 비교 → 라인 단위 zero diff. baseline 시점 controlled 가 어려운 경우 'old code + new state' 또는 'old code + saved state snapshot' 패턴.",
      "actionable": "tests/CLAUDE.md § '회귀 검증 절차' 의 '기존 smoke 수정 시' 항목에 controlled 비교 패턴 추가 권고 — git show HEAD~N + diff (CRLF 정규화) 패턴."
    },
    {
      "id": "L4",
      "lesson": "Python heredoc batching 패턴이 검증 스크립트 시간 단축에 매우 효과적 (Windows MSYS2 환경)",
      "context": "Windows GitBash spawn cost 0.376s × N 회 패턴은 Linux 의 ~50ms × N 보다 7~8x 비대. N×M spawn 패턴 발견 시 batching 으로 ~95~99% 감소 가능. spec-verification 66s → 0.63s (105x 빠름).",
      "actionable": "다른 smoke (특히 inactive 22 중 milestone enumerate × stage 패턴 가진 것) 에 동일 패턴 적용 검토. 단 본 milestone 의 패턴 (2 smoke 모두 동일 def detect_era 본문) drift 위험 → tests/_era_detect.py 분리 (architecture A2 권고) 가 후속 candidate."
    },
    {
      "id": "L5",
      "lesson": "bash + python 혼재 smoke 의 카운트 합산 패턴 (COUNT_FILE)",
      "context": "phase-2 에서 Stage 1+2 Python + Stage 3 bash 혼재. 카운트 합산 위해 COUNT_FILE=$(mktemp) + export 후 Python 안 os.environ['COUNT_FILE'] 으로 record. bash 가 read $PASS $FAIL $SKIP 후 Stage 3 합산. 깔끔한 패턴.",
      "actionable": "tests/CLAUDE.md § 'Skeleton 선택 매트릭스' 에 'bash + python 혼재 (Python 부분 검증 + bash 부분 검증)' 시나리오 추가."
    },
    {
      "id": "L6",
      "lesson": "INTENT.md only historical migrate 의 Stage 1 검증 누락은 잠재적 잘못된 동작일 수 있음",
      "context": "v2.0 hotfix 43472b7 가 detect_era 에 INTENT.md only 케이스 추가했으나, smoke-scope-contract Stage 1 (out_of_scope) 코드는 era='7-stage' 일 때 fp=PLAN.md 만 체크 — historical 7-stage migrate (PLAN→INTENT) milestone 의 Stage 1 검증은 SKIP 처리. 의도된 동작인지 hotfix 의 범위 밖이었는지 불명.",
      "actionable": "후속 milestone candidate — historical 7-stage migrate milestone 의 Stage 1 검증 활성화 여부 결정 (era 분류 vs 검증 fp 일관성)"
    },
    {
      "id": "L7",
      "lesson": "9-stage workflow (v2.0+) 의 두 번째 실 적용 — 워크플로우 정전 검증",
      "context": "v2.0_workflow-word-fidelity 가 메타 정의를 정전 + 자기참조 표지로 7-stage 포맷 작성. 본 v2.1 이 9-stage 흐름 (OPEN→INTENT→RESEARCH→DESIGN→APPROVE→EXECUTE→VERIFY→REPORT→PROPOSE) 의 첫 자연 적용. APPROVE.md 게이트 + PROPOSE.md 분리 + INTENT.out_of_scope 7건 → DESIGN scope contract 검증 모두 정상 동작.",
      "actionable": "PROPOSE.md 작성 후 9-stage workflow 정전 검증 사례로 ARCHITECTURE.md § 6 era 정책 또는 § 4 9-stage 섹션에 cross-ref 1건 추가 검토."
    }
  ]
}
```

## 요약 narrative

본 milestone 의 trigger 는 사용자 의문 round 1건 ("commit test 가 소요하는 시간이 너무 많은거 같은데, 정합성 검토해봐", 2026-05-10). 사전 RESEARCH 에서 5 active smoke 시간 측정 + 정합성 평가 결과:

- **시간 측정**: 전체 pre-commit 1m33s 중 smoke-spec-verification 66.4s + smoke-scope-contract 12.4s = 84% 점유. python3 spawn 패턴 (17 milestones × 8 stage = ~150 회) × Windows MSYS2 spawn cost 0.376s ≈ 57s 가 spawn overhead 만으로 소비.
- **정합성 평가**: 5 active smoke 의 책임은 모두 정합 (중복 0 / 누락 0). 시간 비효율은 책임이 아니라 구현 패턴 (per-call PYEOF heredoc).

채택 Approach A (단일 batched python3 호출) 로:

- spec-verification: **66.4s → 0.63s (99.05% 감소)**
- scope-contract: **12.4s → 0.65s (94.76% 감소)**
- 전체 pre-commit: **93.3s → 15.4s (83.49% 감소)**

INTENT.success_criteria 7건 모두 임계 대비 2~16x 여유로 PASS. 회귀 0.

3 관점 병렬 검토 (architecture / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 0. 검토 권고 11건 모두 흡수 (D5/D12~D17 + R11~R13). v1.4_infra-minimization 정신 (인프라 최소화) 정합 — smoke 갯수/책임/narrative 변경 0.

구현 중 신규 발견 1건 (Windows cp949 콘솔 em dash UnicodeEncodeError) → smoke-python-entry-boilerplate § P2 v1.87 패턴 차용. DESIGN spec-drift 관점 생략의 trade-off (lessons L2 기록).

9-stage workflow (v2.0+) 의 두 번째 실 적용 — APPROVE.md 게이트 + PROPOSE.md 분리 정상 동작 (lessons L7).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- APPROVE: [`APPROVE.md`](APPROVE.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- execute/phase-1: [`execute/phase-1.md`](execute/phase-1.md)
- execute/phase-2: [`execute/phase-2.md`](execute/phase-2.md)
- PROPOSE (forward): [`PROPOSE.md`](PROPOSE.md) (Stage I 작성 예정)
