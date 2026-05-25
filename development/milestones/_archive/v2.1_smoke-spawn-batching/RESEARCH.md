# RESEARCH — v2.1_smoke-spawn-batching

```json
{
  "external": [
    {
      "source": "사용자 발의 (2026-05-10 conversation)",
      "topic": "commit test 시간 정합성 검토",
      "findings": "사용자 1차 의문 — '하네스 개선하는데 왜 script 파일이 필요해?' 답변 후 2차 의문 'commit test 가 소요하는 시간이 너무 많은거 같은데, 정합성 검토해봐'. 즉 의도는 (a) 시간 측정, (b) 시간 vs 책임 적합성 평가, (c) 개선 가능성 제시.",
      "drift": "없음 — 사용자 의도와 본 milestone scope (시간 단축 + 책임 보존) 일치."
    },
    {
      "source": "Bash + Python 인터프리터 spawn cost (Windows MSYS2 / Git Bash)",
      "topic": "Python heredoc 패턴 spawn overhead",
      "findings": "`time python3 -c \"pass\"` ≈ 0.376s (실측). MSYS2 fork 비용 + Python startup 포함. Linux 네이티브에서 ≈ 50ms 수준이나 Windows Git Bash 는 fork emulation overhead 로 약 7~8배. 따라서 N×M spawn 패턴에서 Windows commit 시간이 Linux 보다 훨씬 비대.",
      "drift": "없음 — Linux/CI 에서도 효과는 있으나 비율은 작음. Windows 데스크톱 사용자가 1차 수혜."
    },
    {
      "source": "tests/CLAUDE.md (v1.75+ smoke 작성 5-step 흐름)",
      "topic": "smoke 작성 규약 — bash 호환성, --fix 패턴, 출력 패턴",
      "findings": "출력 패턴 표준 (`echo \"  ✓ $1\"; PASS=$((PASS+1))`) + `=== 결과: PASS=$PASS FAIL=$FAIL SKIP=$SKIP ===` 종결. 본 milestone 은 출력 형식 보존 의무.",
      "drift": "없음 — Approach A 의 batched python3 도 동일 stdout 형식 모방 가능."
    },
    {
      "source": "tests/CLAUDE.md § '흔한 함정' (5 evidence-base, v1.75+)",
      "topic": "Bash 함정 — pipefail / grep -c / MSYS2 path translation / shellcheck / CRLF",
      "findings": "MSYS2 path translation (v1.70 사례): bash 인자 전달 대신 sys.argv 경유 + Path 정규화 권고. 본 milestone batching 시 Python 안에서 milestone enumerate 하므로 path translation 노출 면이 적음.",
      "drift": "없음 — Path / pathlib 사용으로 안전."
    },
    {
      "source": "ARCHITECTURE.md § 3.3 5요소 매트릭스 'Verification' 행",
      "topic": "Verification = 정전 (smoke 27 + pre-commit 5 active)",
      "findings": "v1.4_infra-minimization (2026-05-10) 에서 '인프라 자동화 의존 최소화' 정신 명문화. 본 milestone 은 smoke 자체를 줄이지 않고 spawn 비용만 줄여 정신과 부합 (실행 비용 최소화).",
      "drift": "없음 — 인프라 카운트 (smoke 27 / hook 5) 변경 없음."
    },
    {
      "source": "v1.1_smoke-precommit-rewrite (2026-05-08) REPORT.md",
      "topic": "현 5 active smoke 의 검증 책임 정전",
      "findings": "smoke-spec-verification (JSON schema) + smoke-scope-contract (out_of_scope + approval gate) 의 책임은 v1.1 에서 정전. 본 milestone 은 책임 / 출력 / exit code contract 변경 금지.",
      "drift": "없음 — Approach A 는 구현만 변경."
    },
    {
      "source": "v2.0_workflow-word-fidelity (2026-05-10) phase-4 + hotfix 43472b7",
      "topic": "smoke-spec-verification + smoke-scope-contract 의 era 자동 식별 (9-stage / 7-stage / 4-tier)",
      "findings": "spec-verification: 산출 파일명 자체로 era 분기 (INTENT.md 존재 → 9-stage stage 검증 추가, PLAN.md 존재 → 7-stage 검증). scope-contract: detect_era() bash 함수가 분기 (9-stage=INTENT/APPROVE, 7-stage=PLAN/DESIGN.approval). hotfix 43472b7 은 INTENT.md only (APPROVE/PROPOSE 부재) 케이스 추가. 본 milestone batched python 도 동일 분기 보존 의무.",
      "drift": "없음 — Python 안에서 detect_era 동치 구현 가능."
    }
  ],
  "codebase": {
    "affected_files": [
      {
        "path": "tests/smoke-spec-verification.sh",
        "current": "check_json_fields() heredoc + check_execute_phase() heredoc — milestone × stage 마다 python3 spawn (~150회). main loop 가 milestone enumerate × 8 stage 호출.",
        "target": "단일 python3 heredoc — milestone enumerate + 모든 stage 검증 + execute/phase 검증을 Python 안에서 일괄. stdout: line-per-result format (label\\tstage\\tstatus\\tmessage). bash 는 결과 파싱 + 표준 출력 패턴 출력 + PASS/FAIL/SKIP 카운트."
      },
      {
        "path": "tests/smoke-scope-contract.sh",
        "current": "check_out_of_scope() heredoc + check_approval() heredoc + detect_era() bash 함수. milestone × 2 stage 마다 spawn (~34회).",
        "target": "단일 python3 heredoc — milestone enumerate + detect_era + Stage 1/2 검증을 Python 안에서. Stage 3 (harness-meta.md grep) 은 bash 유지 (이미 빠름). stdout 형식 동일."
      }
    ],
    "untouched_files": [
      "tests/smoke-cross-ref.sh — 0.9s, 변경 없음",
      "tests/smoke-claude-md-drift.sh — 2.4s, 변경 없음",
      "tests/smoke-projects-scope-discipline.sh — 0.9s, 변경 없음",
      "tests/precommit-autofix-or-fail.sh — wrapper, 두 smoke 모두 --fix 미지원이라 미경유",
      ".pre-commit-config.yaml — entry / files 패턴 변경 없음",
      "shellcheck / markdownlint / 내장 pre-commit-hooks — 외부 의존, 본 milestone scope 외",
      "tests/CLAUDE.md — 매트릭스 narrative 책임/카운트 변경 없음 (본 milestone 은 구현만, 책임 그대로). 시간 정보 추가는 옵션 (DESIGN 결정)."
    ],
    "current_state": "milestone 17개 × spec-verification 8 stage = ~150 python3 spawn × 0.376s ≈ 57s. + scope-contract 17×2 = 34 × 0.376 ≈ 13s. 합 ~70s 이 spawn overhead 만으로 소비.",
    "target_state": "단일 spawn × 2 smoke = 2 × 0.376s ≈ 0.75s overhead + 실제 검증 로직 수 초. 예상 spec-verification 5~8s, scope-contract 1~2s. 전체 pre-commit 1m33s → ~25s."
  },
  "options": [
    {
      "name": "Approach A — 단일 batched python3 호출 (사용자 채택)",
      "pros": [
        "spawn 비용을 N×M회 → 1회로 감축 (66s → ~5s, 92% 감소)",
        "bash 측 변경 최소 (heredoc 영역 1개 + main loop 만)",
        "milestone enumerate 를 Python 의 glob.glob + sorted 로 일관 처리",
        "era 자동 식별을 Python 함수 1개로 일관 (detect_era 동치)",
        "결과 출력은 Python 안에서 ✓/✗/- prefix 직접 print → bash 가 PASS/FAIL/SKIP grep 카운트"
      ],
      "cons": [
        "python heredoc 길이 증가 (≈ 100~150 라인)",
        "검증 로직 수정 시 Python 영역 갱신 부담 (단 단일 source 가 되므로 산만함은 줄어듦)",
        "Python 안에서 부분 실패 시 traceback 누출 가능 — try/except 격리 필수"
      ]
    },
    {
      "name": "Approach A2 — stage 별 batching (8 stage = 8 spawn)",
      "pros": [
        "기존 check_stage() 흐름 유지 — bash 코드 변경 더 적음",
        "stage 별 격리 — 한 stage 실패가 다른 stage 영향 없음"
      ],
      "cons": [
        "spawn 8 + 1 (execute) + 2 (scope-contract) = ~11회 — 절감 효과 작음 (4s + 1s ≈ 5s 절감)",
        "여전히 milestone × stage = N × 1 회/stage 가 N 만큼 줄어드는 것 뿐"
      ]
    },
    {
      "name": "Approach B — smoke 5종 전체를 .sh → .py 재작성",
      "pros": [
        "Python 통일 — bash 함정 (CRLF/MSYS2/shellcheck) 회피"
      ],
      "cons": [
        "변경 범위 과대 — 5 smoke + .pre-commit-config.yaml entry 모두 갱신",
        "회귀 risk 큼 — 출력/exit/--fix 모두 재구현",
        "shellcheck 인프라 (pre-commit hook) 와 일부 충돌"
      ]
    },
    {
      "name": "Approach C — jq 사용 (Python 제거)",
      "pros": [
        "spawn cost 더 작음 (jq < python)",
        "외부 의존 1개로 단일화 (기존에도 jq 가 일부 smoke 에서 선택 의존)"
      ],
      "cons": [
        "jq 외부 의존 추가 — Windows 사용자는 별도 설치 필요",
        "JSON 외 텍스트 검증 (정규식) 어려움 — 일부 검증 (execute/phase-N.md regex) 이 어려워짐",
        "tests/CLAUDE.md 외부 의존 § 갱신 필요"
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "출력 형식 변경으로 사용자 또는 다른 smoke parser 가 깨짐",
      "likelihood": "low",
      "impact": "med"
    },
    {
      "id": "R2",
      "risk": "Python 부분 실패 시 traceback 누출 → bash errexit 가 일부 milestone 에서 전체 abort",
      "likelihood": "med",
      "impact": "high"
    },
    {
      "id": "R3",
      "risk": "MSYS2 path translation 로 Python pathlib 가 잘못된 경로 받음 (tests/CLAUDE.md § 함정 v1.70 사례)",
      "likelihood": "low",
      "impact": "med"
    },
    {
      "id": "R4",
      "risk": "era 자동 식별 (9/7/4-tier) 분기 동치 깨짐 — historical 7-stage era + INTENT.md only 케이스 (hotfix 43472b7) 누락",
      "likelihood": "med",
      "impact": "high"
    },
    {
      "id": "R5",
      "risk": "execute/phase-N.md 파일명 regex (`^phase-[0-9]+\\.md$`) 검증 동치 깨짐 — Python re.match 패턴 차이",
      "likelihood": "low",
      "impact": "med"
    },
    {
      "id": "R6",
      "risk": "단일 python heredoc 안에서 SyntaxError 시 ALL smoke milestone 검증 실패 — 부분 milestone 만 fail 보다 영향 큼",
      "likelihood": "low",
      "impact": "high"
    },
    {
      "id": "R7",
      "risk": "shellcheck 가 bash 출력 라인 패턴 변경 시 SC2086 등 경고 — pre-commit shellcheck 차단",
      "likelihood": "low",
      "impact": "low"
    },
    {
      "id": "R8",
      "risk": "결과 PASS/FAIL/SKIP 카운트 동치가 일부 케이스에서 어긋남 (e.g., empty milestone dir 처리, JSON parse error 시 status 분기)",
      "likelihood": "med",
      "impact": "med"
    },
    {
      "id": "R9",
      "risk": "smoke-scope-contract Stage 3 (harness-meta.md grep) 만 bash 유지 → 단일 smoke 안에 bash + python 혼재 → 가독성 저하",
      "likelihood": "low",
      "impact": "low"
    },
    {
      "id": "R10",
      "risk": "Stage F 변경 commit 시 pre-commit 자체가 failed (자기 변경이 자기 검증을 통과해야 함) — 회귀 즉시 노출",
      "likelihood": "low",
      "impact": "low (기능)"
    }
  ]
}
```

## 조사 narrative

### 사용자 의도 검증

본 milestone 의 trigger 는 사용자 의문 round (2회):

1. "하네스 개선하는데 왜 script 파일이 필요해?" — 답변 (스크립트는 실행 경계, MD 가 내용)
2. "commit test 가 소요하는 시간이 너무 많은거 같은데, 정합성 검토해봐" — 본 milestone 발의

사용자 표현 "정합성" 의 해석:

- **시간 vs. 책임 적합성** — 각 smoke 가 자기 책임 대비 적절한 시간을 쓰는가
- 사전 조사 결과: smoke 5건 책임은 모두 정합 ✅, 시간은 spec-verification + scope-contract 만 비효율 ⚠️

따라서 milestone scope 는 **"책임 변경 없이 시간만 단축"**.

### Spawn cost 정량 분석

```
실측 baseline:
  smoke-spec-verification.sh: 66.4s
  smoke-scope-contract.sh:    12.4s
  pre-commit run --all-files: 93.3s

python3 spawn cost (Windows MSYS2):
  time python3 -c "pass" → real 0.376s

spawn 횟수 (코드 분석):
  spec-verification:
    - check_json_fields: 17 milestones × 8 stages = 136 회
    - check_execute_phase: ~17 phase 파일 × 1 = ~17 회
    - 합: ~150 회 × 0.376s ≈ 57s (실측 66s 와 부합 — 차 9s = 실제 검증 로직)
  scope-contract:
    - check_out_of_scope: 17 × 1 = 17 회
    - check_approval: 17 × 1 = 17 회
    - 합: 34 회 × 0.376s ≈ 12.8s (실측 12.4s 와 부합 — 차 ≈ 0)
```

**결론**: 실측이 이론치와 ±10% 이내로 부합 → spawn cost 가 압도적 병목. 검증 로직 자체는 매우 빠름.

### 각 smoke 의 책임 정합성 (사전 조사)

5 active smoke 모두 책임 정합 — 본 milestone scope 외이나 RESEARCH 결과 기록:

| smoke | 책임 | 다른 smoke 와 중복 | 정합성 |
|---|---|---|---|
| smoke-projects-scope-discipline | root ROADMAP thin index 강제 | 없음 (유일) | ✅ |
| smoke-spec-verification | milestone JSON schema (필수 필드) | scope-contract 의 out_of_scope 와 일부 중복 (단 spec 은 schema 광범위, scope 는 semantic gate) | ✅ 책임 분리 명확 |
| smoke-scope-contract | out_of_scope 비어있지 않음 + APPROVE.md.approval gate | spec-verification 와 대상 동일하나 검증 관점 다름 | ✅ |
| smoke-cross-ref | living docs broken ref | 없음 | ✅ |
| smoke-claude-md-drift | root ↔ 모듈 CLAUDE.md drift | 없음 | ✅ |

### 본 milestone 의 Approach A 채택 근거

- Approach A2 (stage 별 batching): 절감 효과 ~5s 로 작음
- Approach B (Python 재작성): 변경 범위 과대 + shellcheck 인프라와 충돌
- Approach C (jq): 외부 의존 추가 + 텍스트 검증 어려움
- **Approach A**: spawn 1회로 단일화, bash 측 변경 최소, 책임/출력/exit 동치 — 사용자 채택

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.3 5요소 매트릭스
- tests/ 모듈 가이드: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md)
- 선행 milestone: [`../v1.1_smoke-precommit-rewrite/REPORT.md`](../v1.1_smoke-precommit-rewrite/REPORT.md), [`../v2.0_workflow-word-fidelity/REPORT.md`](../v2.0_workflow-word-fidelity/REPORT.md)
