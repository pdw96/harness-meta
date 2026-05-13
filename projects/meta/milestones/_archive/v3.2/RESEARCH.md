# RESEARCH — v3.2_workflow-narrative-strengthening

```json
{
  "external": [
    {
      "source": "v3.1 REPORT.md — lessons_learned",
      "topic": "4건 narrative 공백 식별",
      "findings": "L2 milestones.md 선결 의무 CRITICAL (R1 mitigation), L3 smoke 책임 분리 (detect_era 미호출 D16 효과), L5 controlled 비교 cp949 mojibake 정상 작동, L6 INTENT~APPROVE commit 시점 3 패턴 (a/b/c), L9 status 기반 검증 분기 (pending 시 milestones_path 부재 허용)",
      "drift": "none — lessons 자체가 spec 원천"
    },
    {
      "source": "v3.1 DESIGN.md — D16 결정",
      "topic": "smoke-bundle-trigger.sh 책임 분리 원칙",
      "findings": "신규 smoke 가 detect_era 호출 시 era 분류 책임 + schema 검증 책임 혼재 → D16 결정: detect_era 미호출, ROADMAP entry schema 직접 검사. 책임 분리 원칙 = era 분류 (milestone 디렉토리 책임) vs entry schema (ROADMAP milestones[] 책임)",
      "drift": "none — D16 이미 구현, narrative 공백만"
    }
  ],
  "codebase": {
    "affected_files": [
      "claude/commands/harness-meta.md (Stage F 절차 섹션, lines 163-175) — milestones.md 선결 의무 + INTENT~APPROVE commit 시점 추가",
      "tests/CLAUDE.md (§ 'Skeleton 선택 매트릭스' lines 177-186, § '회귀 검증 절차' lines 202-233) — 3 changes"
    ],
    "untouched_files": [
      "projects/meta/ARCHITECTURE.md — structural/policy 변경 없음",
      "tests/smoke-bundle-trigger.sh — 코드 변경 없음, narrative만",
      "tests/_era_detect.py — 변경 없음",
      ".pre-commit-config.yaml — 신규 hook 없음",
      "projects/meta/ROADMAP.md — Stage A 갱신 완료 (별도 추가 불필요)"
    ],
    "current_state": {
      "harness-meta.md Stage F": "5 step 절차 — execute/phase-{n}.md 작성 → 구현 → smoke → commit → status 갱신. milestones.md 선결 의무 언급 없음. INTENT~APPROVE commit 시점 언급 없음",
      "tests/CLAUDE.md Skeleton 선택 매트릭스": "6 row (정적 grep / 정적+동적 / Cross-OS / --fix / LEGACY skip / --include-legacy). era 분류 vs schema 검증 책임 분리 row 없음. status 기반 검증 분기 row 없음",
      "tests/CLAUDE.md 회귀 검증 절차 controlled 비교": "4-step controlled 비교 패턴 (git show HEAD + diff) 설명 존재. cp949 mojibake 정상 작동 언급 없음"
    },
    "target_state": {
      "harness-meta.md Stage F": "step 1 이전 또는 step 1 내에 milestones.md 선결 의무 CRITICAL 명시 (v3.0+ era 한정). step 4 또는 보조 항목에 INTENT~APPROVE commit 시점 3 패턴 (a/b/c) 명문화",
      "tests/CLAUDE.md Skeleton 선택 매트릭스": "+2 row — (1) era 분류 검사 (detect_era 호출) vs entry schema 검증 (직접 검사, 책임 분리 D16), (2) status 기반 검증 분기 (pending vs in_progress/completed, L9 post-EXECUTE discovery)",
      "tests/CLAUDE.md 회귀 검증 절차": "controlled 비교 섹션 내 또는 근방에 cp949 mojibake = errors='replace' 의도된 동작 명문화 (한글 가독성 손실은 trade-off, 자동화 정상)"
    }
  },
  "options": [
    {
      "id": "A",
      "name": "2 phase — 파일 기준 분리",
      "description": "phase-1: harness-meta.md Stage F (L2+L6 — SC1) / phase-2: tests/CLAUDE.md 3 changes (L3+L5+L9 — SC2+SC3+SC4)",
      "pros": ["파일 단위 commit 명료성", "tests/CLAUDE.md 3 changes 한 번에 심사 — context 연속"],
      "cons": ["phase-2 단일 commit 에 3 변경 혼재 — commit 메시지 복잡"]
    },
    {
      "id": "B",
      "name": "4 phase — sub-milestone 1:1",
      "description": "phase-1: harness-meta.md milestones.md 선결 의무 / phase-2: harness-meta.md INTENT~APPROVE commit 시점 / phase-3: tests/CLAUDE.md 책임 분리 row + status 분기 row / phase-4: tests/CLAUDE.md cp949 narrative",
      "pros": ["sub-milestone 1:1 매핑 명료"],
      "cons": ["harness-meta.md 2 회 열기 비효율", "3+4 phase 모두 같은 tests/CLAUDE.md — merge 가능"]
    },
    {
      "id": "C",
      "name": "3 phase — 의미 단위 재그룹",
      "description": "phase-1: harness-meta.md 2 changes (milestones.md 선결 + INTENT~APPROVE commit 시점) / phase-2: tests/CLAUDE.md Skeleton 매트릭스 2 row 추가 / phase-3: tests/CLAUDE.md controlled 비교 cp949 narrative",
      "pros": ["파일 단위 + Skeleton 매트릭스 vs 절차 section 분리", "각 commit 명료"],
      "cons": ["tests/CLAUDE.md 2회 열기"]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "description": "harness-meta.md Stage F milestones.md 선결 의무를 v3.0+ 한정 또는 전 era 범용으로 쓸지 모호",
      "mitigation": "v3.0+ 9-stage-bundled era 한정 명시 (7-stage/9-stage era 에는 milestones.md 개념 부재)"
    },
    {
      "id": "R2",
      "description": "tests/CLAUDE.md Skeleton 선택 매트릭스에 row 추가 시 기존 6 row 와 중복 또는 혼동 가능",
      "mitigation": "추가 row 는 'ROADMAP entry schema 검증' 시나리오로 카테고리 명확히 분리"
    },
    {
      "id": "R3",
      "description": "smoke 코드 변경 없는 narrative-only PR 의 smoke 회귀",
      "mitigation": "smoke-claude-md-drift.sh 가 tests/CLAUDE.md 변경 후 자동 차단 (CLAUDE.md smoke count drift 감지). VERIFY 에서 사전 검증"
    },
    {
      "id": "R4",
      "description": "markdownlint MD032/MD049 함정 — Skeleton 매트릭스 새 row 에 backtick 미처리 underscore",
      "mitigation": "새 row identifier (예: v{X.Y}_{slug}) 모두 백틱 escape 의무 + pre-commit markdownlint 자동 차단"
    }
  ]
}
```
