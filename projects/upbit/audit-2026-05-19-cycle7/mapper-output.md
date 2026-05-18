# mapper-output — upbit audit cycle 7

**생성일**: 2026-05-19
**대상**: upbit project
**milestone**: v5.20 Stage F phase-1 Step 3/4

## Input Verification (v5.18 의무)

### (a) inline 첨부 본문 직접 인용 evidence (D10 우회 패턴)

orchestrator 가 inline 첨부한 analyzer-output.md 본문에서 직접 인용:

- `"id": "cycle7"` / `"audit_date": "2026-05-19"` / `"project": "upbit"`
- `"axis_1_harness_gap": []` — gap 0건
- `"axis_2_builtin_conflict"`: C1 `resolved (cycle 2)`, C2 `resolved (cycle 2)`, C3 `확인 유지`
- `"axis_3_fleet_evolution"`: `"agents_total": 7`, `"skills_total": 7`, `"new_in_cycle7": []`, `"evolution_candidates": []`
- `"stability_evidence"`: `"cycles_consecutive": 3`, cycles `["cycle5","cycle6","cycle7"]`, `"commits_since_cycle6": 0`
- `"summary"`: "stability cycle 두 번째 확인. R1+R2 cycle 5+6+7 연속 APPLIED. 신규 gap 0건. fleet 7+7 변동 없음. 즉시 결정 필요 0건."

### (b) cycle 6 mapper-output 매핑 정합 비교

stability cycle 본질 = gap_mappings 0건 / conflict_mappings C1·C2 resolved carry-forward / C3 keep carry-forward / evolution_mappings 0건 — cycle 6 매핑과 동일. 변동 없음 확인.

```json
{
  "cycle": "cycle7",
  "baseline_cycle": "cycle6",
  "delta": {
    "gap_mappings_delta": 0,
    "conflict_mappings_delta": 0,
    "evolution_mappings_delta": 0
  },
  "verdict": "매핑 동일 — stability cycle 정합"
}
```

## 매핑 산출

```json
{
  "meta": {
    "cycle": "cycle7",
    "generated": "2026-05-19",
    "source_library": "/websites/code_claude",
    "input_gap_count": 0,
    "input_conflict_count": 3,
    "input_evolution_candidate_count": 0
  },
  "gap_mappings": [],
  "conflict_mappings": [
    {
      "conflict": {
        "id": "C1",
        "status": "resolved (cycle 2)",
        "custom": "harness-review SKILL",
        "builtin": "/review"
      },
      "builtin_classification": "Skill tool invocable built-in command (fixed-logic) — NOT bundled skill",
      "builtin_doc_ref": "<https://code.claude.com/docs/en/skills>",
      "builtin_responsibility": "/review: 현재 브랜치 pending changes PR 단위 리뷰 (fixed-logic, Skill tool via discover+execute). bundled skill(/simplify·/batch·/debug 등) 범주 아님 — 직교.",
      "custom_responsibility": "harness-review SKILL: upbit 프로젝트 특화 코드 품질 + ruff/pytest 연동 harness 맥락 리뷰 (prompt-based, project-scoped)",
      "equivalence": "부분 — /review 는 PR 단위 fixed-logic / harness-review 는 harness 맥락 + tool-chain 특화. mix 권장 유지.",
      "resolution": "resolved (cycle 2) — 현행 유지",
      "apply_path": ".claude/skills/harness-review/SKILL.md",
      "code_snippet_summary": "SKILL.md frontmatter: name/description/allowed-tools. /review 는 Skill tool 통해 built-in discover+execute — 커스텀 SKILL 과 독립 공존."
    },
    {
      "conflict": {
        "id": "C2",
        "status": "resolved (cycle 2)",
        "custom": "harness-python SKILL",
        "builtin": "built-in env check"
      },
      "builtin_classification": "built-in env check — Skill tool invocable built-in (environment-auditor 영역, /init 연관)",
      "builtin_doc_ref": "<https://code.claude.com/docs/en/skills>",
      "builtin_responsibility": "Python 런타임 환경 존재 여부 binary 확인 (AUTO). 실 harness 효과(ruff gate, pytest batch) 는 built-in 범위 외.",
      "custom_responsibility": "harness-python SKILL: ruff format/lint + pytest batch + Poetry env — upbit 특화 tool-chain 전체 커버",
      "equivalence": "부분 cover — built-in 은 존재 확인, harness-python 은 전체 workflow. mix 권장 유지.",
      "resolution": "resolved (cycle 2) — 현행 유지",
      "apply_path": ".claude/skills/harness-python/SKILL.md",
      "code_snippet_summary": "SKILL.md: allowed-tools: Bash. dynamic context injection !`poetry run ruff check .` 패턴 활용 가능."
    },
    {
      "conflict": {
        "id": "C3",
        "status": "확인 유지",
        "custom": "spike-investigator agent",
        "builtin": "N/A"
      },
      "builtin_classification": "N/A — 충돌 없음",
      "builtin_doc_ref": "<https://code.claude.com/docs/en/sub-agents>",
      "builtin_responsibility": "N/A",
      "custom_responsibility": "spike-investigator: 보류 spike(S1/S3/S4/F4) 독립 조사 전담 subagent. 무관 책임 — built-in 충돌 없음.",
      "equivalence": "무관 — keep 확인 유지",
      "resolution": "확인 유지 — 변동 없음",
      "apply_path": "agents/spike-investigator.md",
      "code_snippet_summary": "---\nname: spike-investigator\ndescription: 보류 spike 독립 재평가 전담\ntools: Read, Grep, Glob\n---"
    }
  ],
  "evolution_mappings": [],
  "stability_summary": {
    "consecutive_stable_cycles": 3,
    "cycles": ["cycle5", "cycle6", "cycle7"],
    "gap_delta": 0,
    "conflict_delta": 0,
    "evolution_delta": 0,
    "fleet_agents": 7,
    "fleet_skills": 7,
    "verdict": "매핑 고정 — stability 3 cycle 연속 확인. component-proposer 입력 변동 없음."
  },
  "pending_notes": {
    "F4": {
      "status": "독립 재평가 권고 유지 (cycle 4→5→6→7 연속 미결, cycle 6 사용자 결정 Accept (a) /usage built-in carry-over)",
      "priority": "P2 (cycle 6 사용자 결정 후 P3 전환 가능 — pain point evidence 미달 유지)",
      "apply_path_if_resolved": ".claude-plugin/skills/harness-cost-tracker/SKILL.md (옵션 b, pain point evidence 누적 시) — [v5.20 정정] cycle 6 mapper L80~L103 매핑 정합 (origin = harness-cost-tracker vs /usage built-in, NOT spike-investigator)",
      "doc_ref": "<https://code.claude.com/docs/en/skills>",
      "_v5_20_correction": "1차 산출 안 apply_path_if_resolved = 'agents/spike-investigator.md 위임 또는 별도 one-off phase' → hallucination (F4 본질 = cost tracker, cycle 6 mapper-output.md L80~L103 origin). cycle 6 baseline 직접 매핑 검증 후 [v5.20 정정] 적용 (audit trail 보존). v5.13 fact 검증 절차 다섯 번째 실전 evidence — cycle 7 hallucination cycle 1건 (mapper origin)."
    },
    "S1_S3_S4": {
      "status": "보류 유지",
      "priority": "P3",
      "note": "spike-investigator agent 위임 대상 유지"
    }
  }
}
```

## lint precheck 결과 (v5.16 절차 세 번째 실전)

| Rule | 점검 항목 | 결과 |
|------|-----------|------|
| MD022 | H2 앞뒤 빈 줄 | PASS |
| MD031 | 코드블록 앞뒤 빈 줄 | PASS |
| MD032 | 목록 앞뒤 빈 줄 | PASS |
| MD034 | bare URL — doc_ref 전체 `<...>` angle 감싸기 | PASS (**4건** 적용 — C1/C2/C3 builtin_doc_ref 3건 + F4 pending_notes.doc_ref 1건) |

MD034 적용 위치: 4건 angle bracket 감싸기 적용. **mapper agent 1차 산출 안 "6건" 보고 → orchestrator fact 검증 (v5.13 다섯 번째 실전) 결과 실제 4건 inline 정정 (cycle 7 hallucination 2건 누적 발견 — (1) MD034 카운트 6→4 + (2) F4 본질 cost-tracker→spike-investigator, v5.18 narrative 두 번째 실전 안 D10 우회 패턴 한계 사례 추가 evidence)**.
