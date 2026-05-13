# DESIGN — v3.15 changelog-v3-backfill

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Option A 채택 — 전체 13 entry 풀 backfill (milestone 1:1 entry 매핑)",
      "rationale": "외부 visible artifact 정전 + milestone trace 1:1 매핑 원칙 부합. Option B (3 entry + 묶음) 는 11 milestone trace 불투명 → 외부 사용자 시점 정보 손실. Option C (단일 era entry) 는 SemVer + Keep a Changelog 규약 위반.",
      "alternatives_rejected": ["B (주요 3 entry + 묶음)", "C (단일 era entry)"]
    },
    {
      "id": "D2",
      "decision": "[Unreleased] 섹션 현 위치 (L37, v2.0 아래) 보존 — 본 milestone scope 외 narrative",
      "rationale": "[Unreleased] 위치 권장 위반 (Keep a Changelog) 은 본 milestone 도입 부재, 기존 drift 보존. INTENT.out_of_scope `[Unreleased] 처리는 현행 보존 또는 v3 안 흡수` 명시 — 본 결정으로 '현행 보존' 확정. [Unreleased] 안 5 항목 (CI / pre-commit / GUARDRAILS / .env.example / CHANGELOG.md 자체) 은 v1.x~v2.0 사이 인프라 → v1.x / v2.x entry 재작성 scope 외.",
      "alternatives_rejected": ["[Unreleased] 최상단 이동", "[Unreleased] 항목을 v1.x entry 안 흡수"]
    },
    {
      "id": "D3",
      "decision": "v3.x entry 삽입 위치 — v2.1 (L9) 위, 헤더 (L1-7) 직후",
      "rationale": "Keep a Changelog 역순 (최신 위) 권장 부합. v3.14 (2026-05-13 최신) 가 가장 위, v3.0 (2026-05-10 BREAKING) 가 v2.1 직전. [Unreleased] (L37) 는 v2.0 아래 그대로 — D2 정합.",
      "alternatives_rejected": ["[Unreleased] 위, v2.1 위", "v2.1 아래"]
    },
    {
      "id": "D4",
      "decision": "v3.0 헤더 `## [v3.0]! - 2026-05-10` (BREAKING `!` 마커 의무)",
      "rationale": "v3.0 milestone hierarchy 재구성 = v2 → v3 major bump (ROADMAP L149 narrative). v2.0 선례 (L21 `## [v2.0]! - 2026-05-10`) 패턴 정합. CHANGELOG.md L7 narrative `! after a version marker denotes a breaking change` 정합.",
      "alternatives_rejected": ["`!` 마커 생략 (BREAKING 미표시)"]
    },
    {
      "id": "D5",
      "decision": "각 entry 카테고리 매핑 — Keep a Changelog 표준 + Performance (v2.1 선례 보존)",
      "rationale": "표준: Added / Changed / Deprecated / Removed / Fixed / Security + Performance (v2.1 L11 추가 카테고리). v3.x milestone 별 카테고리: v3.0 (Changed BREAKING) / v3.1~v3.5 (Added 주로) / v3.6 (Added § 6.2 + Changed inactive archive) / v3.7 (Added smoke tests) / v3.8 (Fixed inactive cd 버그) / v3.9 (Added 체크리스트) / v3.10 (Changed Stage B/C/D 부산물 narrative) / v3.11~v3.12 (Changed narrative cleanup) / v3.13~v3.14 (Changed deferred 정책 결정).",
      "alternatives_rejected": ["단일 'Notes' 카테고리 통합"]
    },
    {
      "id": "D6",
      "decision": "각 entry LOC cap — ~5~10 bullet (commit hash 인용 + 정량 결과 우선)",
      "rationale": "§ 6.2 narrative cap 정책 정합. ROADMAP summary 평균 ~300 chars × 14 entry = ~4200 chars 풀 인용 회피. 각 entry 핵심 narrative (commit hash / 영향 파일 / 정량 결과 smoke·회귀·hook count / lessons 거명만) ~5~10 bullet 압축. 총 LOC 추가 ~130~170 → CHANGELOG.md 최종 ~290~320 lines.",
      "alternatives_rejected": ["풀 ROADMAP summary 인용 (~4200 chars)"]
    },
    {
      "id": "D7",
      "decision": "Source 인용 — ROADMAP entry summary 단일 1차 source (REPORT.md 보조)",
      "rationale": "lightweight 모드 정합 — REPORT 재해석 회피. ROADMAP summary 가 이미 milestone-final narrative 정전화. CHANGELOG entry 는 ROADMAP summary 의 외부 visible 핵심만 압축. REPORT.md 는 'For detailed change records' L3 cross-ref 로 외부 사용자 안내 (현행 보존).",
      "alternatives_rejected": ["REPORT.md 풀 인용", "ROADMAP + REPORT dual source"]
    },
    {
      "id": "D8",
      "decision": "lightweight 모드 적용 — 5 관점 subagent 검토 생략",
      "rationale": "§ 6.2 trigger 3건 충족: (a) narrative cleanup 본질 (실 코드 변경 부재 — workflow / smoke / hook 미영향) / (b) 단일 파일 (CHANGELOG.md) / (c) 5 관점 의견 충돌 부재 예상 (사실 진술 정리). v3.11_legacy-narrative-cleanup + v3.12_deprecated-skill-narrative-cleanup + v3.13_pending-milestone-renumber-policy + v3.14_deferred-revaluation-cycle-2 선례 패턴 정합 (lightweight 모드 누적 4건 → 본 milestone 5번째).",
      "alternatives_rejected": ["full 5 관점 subagent (v3.6 cap 위반)", "3 관점 (architecture / spec-drift / scope contract)"]
    },
    {
      "id": "D9",
      "decision": "단일 phase 1 commit — `feat(meta): v3.15 phase-1 — CHANGELOG.md v3.0~v3.14 backfill (13 entry + v3.0 BREAKING)`",
      "rationale": "단일 파일 + 단일 의미 (backfill) = 1 phase 1 commit 자명. lightweight 모드 정합. INTENT~APPROVE commit 시점 (b) Stage G commit 안 포함 (권장 default — VERIFY 전 산출물 영구 보존).",
      "alternatives_rejected": ["2 phase (v3.0 BREAKING separately)", "3 phase (BREAKING / minor backfill / [Unreleased] 정합화)"]
    }
  ],
  "approach": "CHANGELOG.md 헤더 (L1-7) 직후, v2.1 entry (L9) 위에 v3.0~v3.14 14 entry 역순 삽입 — v3.14 최신 → v3.0 BREAKING `!`. 각 entry 는 ROADMAP entry summary 1차 source 기반 ~5~10 bullet 압축. [Unreleased] (L37) + v2.0~v1.x 전체 보존. 단일 phase 1 commit + Stage G commit 안 INTENT/RESEARCH/DESIGN/APPROVE.md 동시 포함 (default 패턴 b). lightweight 모드 — 5 관점 subagent 검토 생략, § 6.2 cap 정합.",
  "phases": [
    {
      "n": 1,
      "title": "CHANGELOG.md v3.0~v3.14 14 entry backfill",
      "scope": "v2.1 entry (L9) 위, 헤더 (L1-7) 직후에 14 entry (v3.14 → v3.0 역순) 삽입. v3.0 `!` BREAKING 마커. 각 entry ~5~10 bullet 압축 (ROADMAP summary 1차 source). [Unreleased] + v2.0~v1.x entry 현행 보존.",
      "affected_files": [
        "CHANGELOG.md",
        "projects/meta/milestones/v3.15/execute/phase-1.md"
      ],
      "rationale": "단일 파일 + 단일 의미 (backfill) = 1 phase 1 commit. lightweight 모드 정합.",
      "risks": ["§ 6.2 cap 위반", "[Unreleased] 위치 권장 위반 잔존", "v3.0 `!` 누락"]
    }
  ],
  "risk_mitigation": [
    {
      "risk_id": "R1",
      "risk": "pre-commit markdownlint MD040 (fenced code lang) 위반",
      "mitigation": "N/A — CHANGELOG.md 현 패턴 fenced code 부재, bullet list 만. 추가 entry 도 bullet 패턴 정합 의무.",
      "verification": "phase-1 commit 시 pre-commit 14 hook 자동 검증"
    },
    {
      "risk_id": "R2",
      "risk": "entry LOC cap 위반 (§ 6.2)",
      "mitigation": "D6 — 각 entry ~5~10 bullet, commit hash + 정량 결과 우선, ROADMAP summary 풀 인용 회피",
      "verification": "phase-1 종료 후 CHANGELOG.md 최종 LOC 측정 (예상 ~290~320, cap 위반 없음)"
    },
    {
      "risk_id": "R3",
      "risk": "[Unreleased] 위치 권장 위반 잔존",
      "mitigation": "D2 — out_of_scope 명시. 본 milestone 도입 부재 → 기존 drift 보존, 향후 별 milestone 처리 가능 (PROPOSE candidate 거명만)",
      "verification": "phase-1 commit diff 안 L37 [Unreleased] 헤더 unchanged 확인"
    },
    {
      "risk_id": "R4",
      "risk": "Source narrative drift (ROADMAP summary ↔ REPORT 1차 source)",
      "mitigation": "D7 — ROADMAP summary 단일 인용 + commit hash 정량 검증. REPORT 재해석 회피.",
      "verification": "phase-1 commit 시 각 entry commit hash 가 git log -- 매핑 PASS 검증"
    },
    {
      "risk_id": "R5",
      "risk": "§ 6.2 동결 정책 narrative drift (v3.6 entry)",
      "mitigation": "D5 — v3.6 entry 카테고리 'Added: ARCHITECTURE § 6.2 동결 정책 narrative' 한정 표현. '동결 정책 시행' 같은 강제 명령형 회피.",
      "verification": "phase-1 entry narrative review (사실 진술만 — '동결 정책 narrative 신설' 표기)"
    },
    {
      "risk_id": "R6",
      "risk": "v3.0 `!` BREAKING 마커 누락",
      "mitigation": "D4 — 헤더 `## [v3.0]! - 2026-05-10` 명시. v2.0 선례 (L21) 패턴 grep 검증.",
      "verification": "phase-1 commit 후 `grep '\\[v3.0\\]!' CHANGELOG.md` 1 hit 확인"
    }
  ]
}
```

## 부가 narrative

- **자기참조 부합 (도그푸드)**: 본 milestone 은 narrative cleanup 본질 → workflow self-improvement 미해당 → § 6.2 동결 정책 위반 없음. ARCHITECTURE.md § 6.1 (era 정책) / § 6.2 (동결 정책) 보존. CHANGELOG entry 안 § 6.2 narrative 는 '정책 신설' 사실 진술만 (강제 명령형 회피).

- **lightweight 모드 누적 5건** (v3.11 / v3.12 / v3.13 / v3.14 / v3.15) — § 6.2 trigger 3건 충족 패턴 정합.

- **decisions / phases 부산물 정책** (v3.10): `decisions[i].rationale` + `phases[1].scope` 는 본 milestone 의 결정 / 단계 범위 사실 진술만 — 'PROPOSE.md next_candidates 발의 narrative' 같은 forward propose 책임 직접 거명 부재. 후속 candidates 발의는 Stage I (PROPOSE) 단일 책임.

## 관련

- 상위 컨테이너: [`milestones.md`](milestones.md)
- 선행 stage: [`INTENT.md`](INTENT.md), [`RESEARCH.md`](RESEARCH.md)
- 후행 stage: [`APPROVE.md`](APPROVE.md), [`execute/phase-1.md`](execute/phase-1.md)
- 단일 source: [`../../../../CHANGELOG.md`](../../../../CHANGELOG.md)
