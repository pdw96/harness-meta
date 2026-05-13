# DESIGN — v3.2_workflow-narrative-strengthening

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Phase 분리: Option C (3 phase) 채택 — 파일 × 섹션 기준 단일 책임",
      "rationale": "Architecture 관점 P2 권고 수용. RESEARCH Option A (2 phase, 파일 기준) 는 phase-2 단일 commit 에 SC2+SC3+SC4 3 변경 혼재 — v3.1 D5 단일 책임 원칙 위반. Option C: phase-1 harness-meta.md (SC1) / phase-2 tests/CLAUDE.md § 회귀 검증 절차 (SC3) / phase-3 tests/CLAUDE.md § Skeleton 선택 매트릭스 (SC2+SC4) — 각 phase = 파일 + 섹션 단일 책임.",
      "alternatives_rejected": ["Option A (2 phase): SC2+SC3+SC4 혼재, commit 메시지 복잡", "Option B (4 phase): harness-meta.md 2회 열기 비효율, SC2+SC4 같은 매트릭스 분리 과잉"]
    },
    {
      "id": "D2",
      "decision": "milestones.md 선결 의무: Stage F step 1 이전 독립 게이트 블록 배치",
      "rationale": "Architecture 관점 P1 권고 수용. 선결 조건은 절차 step 과 의미 계층 다름 — step 1 안에 묻으면 EXECUTE 재진입 시 누락 위험. Stage E '미승인 시 EXECUTE 진입 금지' 경고 블록 패턴 참조 — 동일 '게이트' 서식으로 가시성 확보. 표제: '선결 조건 (v3.0+ 9-stage-bundled era, EXECUTE 진입 전 의무)'.",
      "alternatives_rejected": ["step 1 내 포함: 게이트 가시성 낮음, 절차 + 전제조건 책임 혼재"]
    },
    {
      "id": "D3",
      "decision": "ARCHITECTURE.md cross-ref 갱신 — out_of_scope 유지",
      "rationale": "spec-drift 관점 P2 선택 권장 (§ 3.3 'Workflow' 셀에 harness-meta.md Stage F cross-ref 1줄 추가). 단, INTENT.out_of_scope 에 'ARCHITECTURE.md 갱신 불필요' 명시 + scope creep 위험 (ARCHITECTURE.md § 3.3 변경 시 smoke-cross-ref 연쇄 검사 추가). out_of_scope 유지 결정 — P2 선택 사항이므로 DESIGN 에서 기각.",
      "alternatives_rejected": ["ARCHITECTURE.md § 3.3 1줄 추가: 선택 사항, scope 누수"]
    },
    {
      "id": "D4",
      "decision": "scope contract P3 HIGH (smoke-claude-md-drift.sh '현 N 파일' drift) — 실제 위험 아님",
      "rationale": "smoke-claude-md-drift.sh S4 는 tests/CLAUDE.md '현 N 파일' 패턴을 grep 해 실제 tests/smoke-*.sh 파일 수 비교. Skeleton 매트릭스 row 추가는 smoke 파일 추가가 아님 → 파일 수 변화 없음 → S4 FAIL 없음. scope P3 HIGH 우려 무효.",
      "alternatives_rejected": ["'현 28 파일' → '현 30 파일' 갱신: 불필요 (smoke 신규 파일 없음)"]
    },
    {
      "id": "D5",
      "decision": "INTENT~APPROVE commit 시점 3 패턴 — Stage F 절차 내 보조 항목으로 명문화",
      "rationale": "v3.1 L6 actionable 3 패턴 (a/b/c) 을 harness-meta.md Stage F 선결 조건 블록 또는 절차 내 보조 항목으로 배치. (b) 패턴 (Stage G commit 포함) 권장 기본값으로 명시 — VERIFY 전 산출물 영구 보존 보장.",
      "alternatives_rejected": []
    },
    {
      "id": "D6",
      "decision": "SC2 (책임 분리 row) + SC4 (status 분기 row) — Skeleton 매트릭스 같은 테이블 phase-3 단일 commit",
      "rationale": "두 row 모두 Skeleton 선택 매트릭스 테이블 내 추가 — 같은 위치, 같은 서식. phase-3 단일 commit 으로 context 연속성 보장. scope P2 권고 (카테고리 경계 명료화) → 두 row 를 '시나리오' 컬럼 설명에서 명확히 구분.",
      "alternatives_rejected": ["SC2 / SC4 별 phase: 같은 매트릭스 2회 열기 비효율"]
    },
    {
      "id": "D7",
      "decision": "v3.0+ era 한정 표기 — milestones.md 선결 의무",
      "rationale": "RESEARCH R1 mitigation — 7-stage/9-stage era 에는 milestones.md 개념 부재. 선결 의무는 v3.0+ 9-stage-bundled era 한정 명시. stage 표 era 분기 컨텍스트 일관.",
      "alternatives_rejected": []
    }
  ],
  "approach": "v3.1 lessons 4건 narrative 공백을 3 phase 로 채운다. phase-1: harness-meta.md Stage F 에 v3.0+ EXECUTE 선결 조건 독립 게이트 블록 + INTENT~APPROVE commit 시점 3 패턴 추가 (SC1). phase-2: tests/CLAUDE.md § 회귀 검증 절차 controlled 비교 섹션에 cp949 mojibake 정상 작동 명문화 (SC3). phase-3: tests/CLAUDE.md § Skeleton 선택 매트릭스에 책임 분리 row (SC2) + status 기반 분기 row (SC4) 추가. 코드 변경 없음, narrative-only.",
  "phases": [
    {
      "n": 1,
      "title": "harness-meta.md Stage F — 선결 조건 게이트 블록 + INTENT~APPROVE commit 시점",
      "scope": "Stage F '각 phase 진행:' 리스트 이전에 '선결 조건 (v3.0+ 9-stage-bundled era)' 독립 블록 추가: milestones.md 즉시 작성 의무 (R1 CRITICAL mitigation) + INTENT~APPROVE commit 시점 3 패턴 (a/b/c, b 권장)",
      "affected_files": [
        "claude/commands/harness-meta.md",
        "projects/meta/milestones/v3.2/execute/phase-1.md"
      ],
      "rationale": "D1 + D2 + D5 + D7. 선결 조건 게이트 가시성 확보 (독립 블록). INTENT~APPROVE commit 시점 명문화 (b 패턴 = Stage G commit 포함, 영구 보존).",
      "risks": ["markdownlint MD032/MD049 함정 — 새 블록 내 list 앞 blank line 의무, identifier backtick escape"]
    },
    {
      "n": 2,
      "title": "tests/CLAUDE.md § 회귀 검증 절차 — controlled 비교 cp949 narrative",
      "scope": "§ '회귀 검증 절차 > 기존 smoke 수정 시 > Controlled 비교 패턴' 섹션 코드블록 이후 또는 내부에 cp949 mojibake 정상 작동 narrative 1 단락 추가: errors='replace' 의도된 동작, 가독성 손실 trade-off 수용, 자동화 정상 동작 우선",
      "affected_files": [
        "tests/CLAUDE.md",
        "projects/meta/milestones/v3.2/execute/phase-2.md"
      ],
      "rationale": "D1 SC3. controlled 비교 4-step violation 주입 단계에서 cp949 mojibake 는 정상 — 미기록 시 재발견 비용 발생.",
      "risks": ["markdownlint MD032 — narrative 단락 앞 blank line"]
    },
    {
      "n": 3,
      "title": "tests/CLAUDE.md § Skeleton 선택 매트릭스 — 책임 분리 row + status 기반 분기 row",
      "scope": "§ 'Skeleton 선택 매트릭스' 테이블에 2 row 추가: (1) 'era 분류 검사 vs ROADMAP entry schema 검증 (책임 분리)' — detect_era 미호출, ROADMAP milestones[] 직접 검사 (D16 효과) / (2) 'ROADMAP entry status 기반 검증 분기' — pending 시 milestones_path 부재 허용, in_progress·completed 시 의무 (L9 post-EXECUTE discovery)",
      "affected_files": [
        "tests/CLAUDE.md",
        "projects/meta/milestones/v3.2/execute/phase-3.md"
      ],
      "rationale": "D1 + D6. SC2+SC4 같은 매트릭스 테이블 단일 phase. 카테고리 경계: 두 row 모두 'ROADMAP entry 검증 시나리오' — 기존 6 row 와 섹션 내 구분 명료.",
      "risks": ["SC2/SC4 row 순서 — tests/CLAUDE.md 기존 row 논리 순서 유지 (현재 6 row 마지막에 추가)", "identifier `v{X.Y}_{slug}` 백틱 escape 의무 (MD049)"]
    }
  ],
  "risk_mitigation": [
    {"risk": "markdownlint MD032/MD049 함정 (DESIGN.phases 전체)", "mitigation": "각 phase commit 전 `markdownlint --fix tests/CLAUDE.md` 또는 `markdownlint --fix claude/commands/harness-meta.md` 수동 self-check. pre-commit markdownlint 자동 차단 2차 보조."},
    {"risk": "smoke-claude-md-drift.sh S4 '현 N 파일' false positive (D4)", "mitigation": "D4 결정: smoke 파일 추가 없음 → 파일 수 변화 없음 → drift 없음. VERIFY 에서 사전 검증."},
    {"risk": "harness-meta.md Stage F 선결 조건 블록의 scope contract smoke 영향 (smoke-scope-contract.sh)", "mitigation": "smoke-scope-contract.sh 는 APPROVE.md approval gate + INTENT.out_of_scope 검증 — Stage F 텍스트 변경 미영향. VERIFY 에서 확인."},
    {"risk": "tests/CLAUDE.md 2 phase (phase-2, phase-3) 순서로 파일 두 번 편집 시 충돌", "mitigation": "phase-2 = § 회귀 검증 절차 (lines 202-233 근방) / phase-3 = § Skeleton 선택 매트릭스 (lines 177-186 근방) — 다른 섹션, merge conflict 없음."}
  ]
}
```

## 5 관점 검토 결과 요약 (3 관점 — scope 작음 ≤5 파일)

| # | 관점 | 결과 | 주요 권고 | 반영 |
|:-:|------|------|---------|-----|
| 1 | architecture | pass-with-comments | P1: 선결 의무 독립 블록 (D2) / P2: Option C 3 phase (D1) | ✅ D1+D2 수용 |
| 2 | spec-drift | pass-with-comments | P2: ARCHITECTURE.md cross-ref 선택 (D3 기각) | ✅ D3 기각 결정 |
| 3 | scope contract | pass-with-comments | P1: SC1 양쪽 커버 명시 (D5) / P3: smoke drift 우려 (D4 무효) | ✅ D4+D5 수용 |

의견 충돌 0건 — 3 관점 모두 자동 흡수 (사용자 결정 게이트 불필요).
