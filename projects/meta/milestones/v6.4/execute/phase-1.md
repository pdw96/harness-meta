---
phase: 1
status: in_progress
---

# v6.4 EXECUTE phase-1 — cascade sync mechanism (slash + script + smoke) + § 4 끝 매트릭스 #8

## Spec

```json
{
  "phase": 1,
  "name": "cascade sync mechanism 도입 (slash command + script + smoke) + ARCHITECTURE § 4 끝 매트릭스 #8 row + paragraph 본문 정전화 + tests/CLAUDE.md cascade (smoke 매트릭스 row + L7 8→9 + 현행 hook 표 9 row) + controlled self-check 4-step",
  "status": "in_progress",
  "changes": [
    {"file": "scripts/cascade_sync.py", "action": "created", "loc": "~220 lines", "purpose": "deterministic core — argparse --check/--apply + enumerate (grep cascade-source marker, rglob *.md, skip .git/_archive/_inactive) + parse marker (length-bounded regex, ReDoS 차단 D12) + path traversal 차단 (is_relative_to REPO_ROOT D12) + external URL skip (^https?://, r_6 흡수) + HTML escape 차단 (--> literal, P2_sec_3 흡수) + find_anchor_paragraph (explicit HTML id priority 1, markdown heading slug priority 2, D11) + compute_hash (whitespace normalize + SHA-256 16-hex, D6) + diff text + apply (host marker expected-hash 갱신). Edge case (a)~(f) 모두 처리 (D11)."},
    {"file": "claude/commands/cascade-sync.md", "action": "created", "loc": "~70 lines", "purpose": "slash command UX orchestrator — frontmatter (description / allowed-tools: Bash, Read / argument-hint: [apply], P2_spec_3 흡수) + LLM prompt (Step 1 check default → Step 2 report → Step 3 user approval → Step 4 apply → Step 5 final report). Bash tool 으로 `python scripts/cascade_sync.py --check|--apply` fixed argument 호출 (D13). apply 명시 호출이라도 LLM diff 출력 후 confirmation (P2_sec_2 흡수). Plugin spec commands paths 자동 인식 (plugin.json 무변경)."},
    {"file": "tests/smoke-cascade-drift.sh", "action": "created", "loc": "~40 lines", "purpose": "read-only drift detect — `exec python3 scripts/cascade_sync.py --check` delegate 패턴 (D10 단일 source). script 부재 시 SKIP exit 0 (환경 가드). cp949 reconfigure boilerplate 부재 (script 안 처리 위임, smoke 는 bash entry+exec)."},
    {"file": ".pre-commit-config.yaml", "action": "updated", "loc": "+12 lines (신규 hook entry block)", "purpose": "신규 local hook smoke-cascade-drift 추가 (id / name / language: system / entry: bash tests/smoke-cascade-drift.sh / pass_filenames: false / files: \\.md$, P2_spec_4 schema 명시 흡수). 총 hook count 15 → 16 (upstream 7 + local 8 → 9, INTENT sc_4 inline 정정)."},
    {"file": "projects/meta/ARCHITECTURE.md", "action": "updated", "loc": "§ 4 끝 매트릭스 row #8 추가 + paragraph 본문 #8 추가", "purpose": "narrative 정전화 위치 D4 — 매트릭스 row 8 (v6.4 / cascade 자동 동기 mechanism / [milestones/v6.4/MILESTONE.md] D1~D13 / boolean exit code 0/1/2 + smoke 자동 차단). paragraph 본문 #8 explicit `<a id=\"section-4-end-row-8\"></a>` anchor + 5 줄 (P2_reg_5 길이 가이드) + '자동' 두 의미 분리 첫 줄 (P2_dict_2 흡수) + 책임 분리 명시 + marker format 자체 컨벤션 + v5.7 spike (c) 5번째 자연 발현."},
    {"file": "projects/meta/milestones/v6.4/MILESTONE.md", "action": "updated", "loc": "INTENT sc_4 narrative inline 정정 (fact = 15→16) + MD012 2건 정정 (line 95+154 blank line)", "purpose": "INTENT sc_4 v6.3 narrative cascade fact mismatch (11→12 부정확) 인지 + 본 milestone 안 hook count 실 측정 fact 정정 (15 baseline + 1 신규 = 16). v5.11 fact 검증 패턴 자연 적용. MD012 markdownlint 차단 해소."},
    {"file": "tests/CLAUDE.md", "action": "updated", "loc": "L7 8→9 + 핵심 정책 검증 표 smoke-cascade-drift row 추가 + 현행 hook 현황 표 9 row (v6.4) 추가", "purpose": "cascade host #1 — smoke 매트릭스 row + L7 'active 8→9' / 핵심 정책 검증 표 안 cascade-drift 1 row 추가 / 현행 hook 표 안 v6.4 cascade-drift 9 row 추가 + narrative caption '+ 1 hook (v6.4 smoke-cascade-drift). 총 9 hook active' 갱신."}
  ],
  "self_check": {
    "method": "controlled 비교 4-step (D5 fixture, scripts/_selfcheck_v6_4_fixture.md tmpfile)",
    "step_1": "baseline (0 host, fixture 부재) → smoke exit 0 PASS ✓",
    "step_2": "의도 drift 주입 (fixture 안 fake hash 0000000000000000) → smoke exit 1 PASS ✓ (drift detect = expected 0000... vs actual 18b81d6adfd7e60a)",
    "step_3": "`python scripts/cascade_sync.py --apply` → marker updated 1 / drift 1 / host 1 ✓",
    "step_4": "smoke 재실행 → exit 0 PASS ✓ (all 1 host(s) in sync)",
    "cleanup": "rm scripts/_selfcheck_v6_4_fixture.md ✓"
  },
  "acceptance_gates": [
    {"id": "a", "gate": "scripts/cascade_sync.py 도입 + Edge case (a)~(f) + path traversal + HTML escape 차단", "status": "PASS"},
    {"id": "b", "gate": "claude/commands/cascade-sync.md slash command 도입 + frontmatter 4 필드 + LLM prompt 5-step", "status": "PASS"},
    {"id": "c", "gate": "tests/smoke-cascade-drift.sh delegate 패턴 도입 + pre-commit 등재", "status": "PASS"},
    {"id": "d", "gate": "ARCHITECTURE § 4 끝 매트릭스 #8 row + paragraph 본문 #8 (explicit anchor + 5 줄 + 자동 두 의미 분리)", "status": "PASS"},
    {"id": "e", "gate": "tests/CLAUDE.md cascade (L7 + 매트릭스 row + 현행 hook 표 row)", "status": "PASS"},
    {"id": "f", "gate": "controlled self-check 4-step PASS (fixture drift 주입 → detect → apply → resync)", "status": "PASS"},
    {"id": "g", "gate": "pre-commit 16 hook 모두 PASS (회귀 0, markdownlint MD012 inline 정정 후)", "status": "PASS"}
  ]
}
```

## Phase-1 narrative

### EXECUTE inline 발견 — pre-commit hook count fact mismatch (lesson L1)

v6.3 narrative + 본 milestone INTENT 초안 모두 hook count 부정확 (v6.3 "11→12" + INTENT 초안 "12→13"). EXECUTE 단계 안 실 `.pre-commit-config.yaml` 측정 = upstream 7 (pre-commit-hooks 5 + shellcheck 1 + markdownlint 1) + local 8 = 15 baseline → 16 (v6.4 cascade-drift 추가). INTENT sc_4 narrative inline 정정 + EXECUTE lesson 으로 흡수. v5.11 fact 검증 의무 패턴 자연 적용 (audit chain 외 = self 검증 첫 명시 사례).

### Markdownlint MD012 inline 정정 (lesson L2)

phase-1 첫 commit 직전 pre-commit 실행 시 MILESTONE.md line 95 + 154 안 blank line 2개 = MD012 (no-multiple-blanks) 차단. JSON 코드 블록 directly after ```...``` close 안 blank line 1개 의무. inline 정정 후 PASS. tests/CLAUDE.md § 흔한 함정 7번째 항목 (markdownlint MD032/MD049) 정합 — MD012 도 추가 함정 candidate 거명만 (P2 lightweight).

### Controlled self-check 4-step PASS evidence

| Step | 의도 | 결과 |
|:-:|---|:-:|
| 1 | baseline (0 host) | exit 0 PASS ✓ |
| 2 | drift 주입 (fake hash) | exit 1 PASS ✓ (detect expected `0000...` vs actual `18b81d6adfd7e60a`) |
| 3 | `--apply` 호출 | marker updated 1/1, exit 0 ✓ |
| 4 | smoke 재실행 | exit 0 PASS ✓ (sync 1 host) |

mechanism 동작 검증 완료. fixture cleanup 후 baseline 복귀 (0 host).

## Commit message draft

```
feat(meta): v6.4 phase-1 — cascade sync mechanism (slash + script + smoke) + § 4 끝 매트릭스 #8

- scripts/cascade_sync.py 신규 (~220 LOC, argparse --check/--apply + enumerate + hash compare + edge case a-f + path traversal + HTML escape 차단 + external URL skip + anchor → paragraph 매핑)
- claude/commands/cascade-sync.md 신규 (slash command frontmatter + LLM prompt 5-step + fixed argument 호출)
- tests/smoke-cascade-drift.sh 신규 (delegate to script --check, read-only drift detect)
- .pre-commit-config.yaml +1 hook (smoke-cascade-drift) — 15 → 16 hook
- projects/meta/ARCHITECTURE.md § 4 끝 매트릭스 row #8 + paragraph 본문 #8 (explicit anchor + 5 줄 + '자동' 두 의미 분리)
- tests/CLAUDE.md cascade (L7 8→9 + 핵심 정책 검증 표 row + 현행 hook 표 v6.4 row)
- INTENT sc_4 narrative inline 정정 (hook count 12→13 부정확 → 실 15→16)
- MD012 markdownlint inline 정정 (MILESTONE.md line 95+154)

Controlled self-check 4-step PASS (fixture drift 주입 → detect → apply → resync → cleanup).
pre-commit 16 hook 모두 PASS, 회귀 0.
v3.21 narrative 정전화 3 단계 패턴 cycle 29 (mechanism 도입 = 자체 사이드 effect).
v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 자연 발현 5번째 (marker format 자체 컨벤션).
5 관점 subagent 병렬 검토 cycle 4 (cycle 누적 증가 패턴 정합, P1 11건 흡수 + P2 27건 PROPOSE 거명만).

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
```
