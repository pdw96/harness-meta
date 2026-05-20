---
id: cascade-auto-sync-mechanism
title: cascade 자동 동기 mechanism 도입
version: v6.4
status: completed
---

# v6.4 — cascade 자동 동기 mechanism 도입

## INTENT

### Spec

```json
{
  "goal": "cascade 자동 동기 mechanism 도입 — v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 source 정전화 → (b) EXECUTE Edit cascade → (c) VERIFY grep 의 (b) 단계 안 수동 host enumerate + 일괄 Edit cycle (v3.18~v6.3 누적 28 cycle, 평균 cascade host ~5~12) 의 cost 자동 단축. mechanism = EXECUTE phase 안 'cascade sync' 명령 도입 (slash command 또는 script 형태 = DESIGN 안 결정). source → host 매핑 enumerate 방식 (marker / manifest / hybrid) = RESEARCH 후 DESIGN 안 결정. AI Native 운영 § 7.1 '다중 AI 협업' 면 첫 실 적용 milestone.",
  "success_criteria": [
    {"id": "sc_1", "description": "'cascade sync' 명령 도입 — 단일 entry point (slash command 또는 script). 입력 = SOURCE 정전 위치 (예: ARCHITECTURE.md § 안 paragraph anchor). 동작 = cascade host enumerate → 현 source content 와 host 인용 diff → 자동 Edit 적용 + dry-run/apply 분리. 구체 구현 형태 + invocation interface 는 DESIGN 안 결정."},
    {"id": "sc_2", "description": "cascade host enumerate 방식 도입 — DESIGN 안 옵션 결정 (marker comment 삽입 / 중앙 manifest 파일 / hybrid). 도입 후 host 목록 자동 enumerate 가능 + 신규 host 추가 declaration 단일 위치 명시. RESEARCH 안 v3.21 cycle 28 실측 cascade host 분포 + context7 PostToolUse hook + dependency tracking 패턴 cross-validate."},
    {"id": "sc_3", "description": "도그푸드 self-check — 의도 cascade drift 주입 (1 source paragraph edit + N host 안 stale 인용 유지) → 'cascade sync' 명령 호출 → drift detect + apply → controlled 비교 PASS. tests/CLAUDE.md § 회귀 검증 절차 정합 (4-step before/after diff)."},
    {"id": "sc_4", "description": "회귀 0 — 기존 smoke 8종 (projects-scope-discipline / spec-verification / scope-contract / cross-ref / claude-md-drift / bundle-trigger / open-stage-discipline / entry-title-guideline) + 신규 sc_6 cascade-drift smoke 1종 = 9종 PASS, pre-commit 현 15 hook (local 8 + upstream 7 = pre-commit-hooks 5 + shellcheck 1 + markdownlint 1) + 신규 1 hook = 16 hook 모두 PASS. cascade sync 명령 자체는 사용자 명시 호출 mechanism (pre-commit 자동 호출 oos) — drift detect 만 smoke 가 담당. **fact 정정 (EXECUTE inline)**: v6.3 narrative (11→12) + 본 INTENT 초안 (12→13) 모두 mismatch — `.pre-commit-config.yaml` 실 count 검증 (v5.11 fact 검증 패턴 정합) 결과 = upstream 7 + local 8 = 15 baseline → 16 (v6.4 추가)."},
    {"id": "sc_5", "description": "도그푸드 cycle — 본 milestone mechanism 자체의 narrative (cascade sync 사용법 정전화 paragraph, DESIGN 안 위치 결정) 가 cascade source 로 등록 + 최소 1-2 host (round 3 사용자 결정 = root CLAUDE.md 단독 또는 + AGENTS.md, DESIGN 안 host 목록 결정) 안 인용 → v6.4 mechanism 의 첫 sync 호출 = 본 milestone narrative cascade. v3.21 narrative 정전화 3 단계 패턴 cycle 29 자기참조 부합 (mechanism 도입 milestone 안 mechanism 자체 적용 = self-host). 5+ host 확장은 v6.x 후속 candidate 거명만 (oos_2 정합)."},
    {"id": "sc_6", "description": "cascade drift smoke 도입 (round 3 사용자 결정 = in_scope) — 신규 tests/smoke-cascade-drift.sh 단일 책임 (tests/CLAUDE.md v3.1 L3 D16 정합). 동작 = cascade source content 의 해시 (hash) 를 host 안 marker comment 의 expected hash 와 비교 → 불일치 시 FAIL + 사용자 'cascade sync' 호출 trigger. pre-commit hook 등재 (entry 직접 호출, --fix 미지원). self-check (의도 drift 주입 → FAIL → sync → PASS 4-step controlled)."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "PostToolUse hook 안 cascade trigger 자동화", "reason": "round 2 사용자 결정 mechanism = '명시 명령 호출' (EXECUTE phase 안 'cascade sync'). hook 안 자동 trigger 는 토큰 비용 + false-positive risk + 즉시성 trade-off — v6.x 후속 candidate 거명만."},
    {"id": "oos_2", "item": "mechanism 외 다른 narrative cascade 정전화", "reason": "본 milestone = mechanism 도입 단독. mechanism 자체의 narrative (예: ARCHITECTURE § 4 끝 cascade sync 사용법 paragraph 정전화) 는 in_scope (sc_5 도그푸드 첫 적용 대상). 단 mechanism 외 다른 narrative (예: AI Native § 7.1 다중 AI 협업 면 narrative 갱신 / ecosystem integrator 추가 narrative / 등) cascade 정전화는 별 milestone candidate."},
    {"id": "oos_3", "item": "cascade host AST/parser 기반 자동 발견", "reason": "marker comment 또는 manifest 안 명시 declaration 만 enumerate scope. 자동 발견 (예: 의미 분석 기반 source 인용 detect) 은 false-positive 위험 + 구현 cost — v6.x 후속 candidate."},
    {"id": "oos_4", "item": "외부 projects/<name> (예: upbit) cascade 자동화", "reason": "meta scope 한정 (round 1 사용자 결정). 외부 projects/<name> cascade mechanism 확장은 v6.4 안정화 후 vector 누적 evidence 도달 시 별 milestone (외부 적용 패턴 v5.10/v5.14/v5.15/v5.17/v5.19 정합)."},
    {"id": "oos_5", "item": "cascade scope 안 외부 source (예: Anthropic Claude Code docs URL) 동기화", "reason": "외부 URL 은 immutable + access 보장 부재. context7 query 패턴 = RESEARCH 단계 단발 호출, cascade host 인용은 frozen-in-time snapshot. 본 milestone scope = repo 내부 source → 내부 host 단방향."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "pre-PLAN dialog 2 round (2026-05-20)", "purpose": "사용자 결정 source — scope 단독 / mechanism EXECUTE 명령 / host enumerate DESIGN 보류 / 5 관점 검토 적용"},
    {"id": "dep_2", "source": "v6.0 INTENT.oos_3 + ROADMAP next_candidates[] target_version v6.4", "purpose": "본 milestone origin 정전 source"},
    {"id": "dep_3", "source": "v3.21 narrative 정전화 3 단계 패턴 + cycle 28 실측 분포", "purpose": "RESEARCH 안 cascade host 분포 통계 source + mechanism 자동화 필요성 evidence"},
    {"id": "dep_4", "source": "v6.2 5 관점 subagent 병렬 검토 패턴 (Plan + general-purpose × 4)", "purpose": "DESIGN stage 적용 (feedback_subagent_parallel_review_evidence cycle 3)"},
    {"id": "dep_5", "source": "feedback_anthropic_yaml_frontmatter_pattern + v6.1 hybrid schema + v6.2 flattened era", "purpose": "MILESTONE.md 단일 본책 + INTENT/RESEARCH/DESIGN H2 안 `### Spec` + ```json``` body 적용"},
    {"id": "dep_6", "source": "memory feedback (iterative_dialog / non_developer_role / iterative_pre_plan_review / token_efficiency_priority)", "purpose": "작업 톤 가이드 + 매 round 결정적 이슈 trigger 의무"},
    {"id": "dep_7", "source": "context7 — PostToolUse hook spec + Claude Code Plugin 안 dependency tracking 패턴", "purpose": "RESEARCH ext_* source — mechanism 옵션 (slash command vs script vs hook) 외부 spec cross-validate"}
  ]
}
```

### Motivation

v6.0 INTENT.oos_3 origin (AI Native § 7.1 '다중 AI 협업' 면 시리즈 후보 #2). v6.2 OPEN 안 v6.3 (entry-title) 우선 결정 후 v6.4 shift.

**cascade 자동화 필요성 evidence** (v3.18~v6.3 누적):

- v3.21 narrative 정전화 3 단계 패턴 cycle 누적 = **28 cycle** (v3.18/v3.20/v3.21/v4.2/v5.7/v5.9/v5.10/v5.11/v5.12/v5.13/v5.16/v5.17/v5.18/v5.19/v5.21/v6.1/v6.2/v6.3 등). 각 cycle 평균 cascade host = **~5~12** (v6.2 = 12 host, v6.3 = 5 host).
- 수동 cycle cost: cycle 당 (a) DESIGN 안 1차 source 정전화 + (b) EXECUTE Edit N host 일괄 cascade + (c) VERIFY grep 검증. 인간 시간 + 토큰 cost (Edit N회 + grep 검증).
- drift evidence: v6.3 PROPOSE P2 14건 중 절반 가까이가 cascade narrative 보강 관련 (entry title 가이드 narrative 갱신 / smoke narrative 명료화 / 등). cascade 수동 cycle 안 host 누락 회귀 가능.

pre-PLAN 2 round 누적 결정 (2026-05-20):

1. **Scope** — cascade-auto-sync 단독 (v6.3 PROPOSE P2 14건은 v6.x 자연 흡수)
2. **Mechanism 1차 발의** — EXECUTE phase 안 'cascade sync' 명령 도입 (slash command 또는 script, DESIGN 안 결정)
3. **Host enumerate 방식** — OPEN 보류, RESEARCH 후 DESIGN 안 결정 (marker / manifest / hybrid)
4. **5 관점 subagent 병렬 검토** — 적용 (feedback_subagent_parallel_review_evidence cycle 1+2 누적 증가 evidence)

### Harness engineering mapping

- **element**: Workflow (1차) + Verification (보조)
- **target**: (c) cycle 단축 — v3.21 narrative 정전화 3 단계 패턴 (b) 단계 수동 cycle 28 → 'cascade sync' 단일 명령
- **rationale**: AI Native § 7.1 3 면 안 **다중 AI 협업 면 첫 실 적용** (v6.3 Verification 면 → v6.4 다중 AI 협업 면). cascade = 사람 + AI 가 협업해 1 source narrative 변경 시 N host 자동 동기 = 협업 cycle 자동화 본질 부합.

### 명료화

#### 본 milestone 의 위치 — AI Native 시리즈 v6.4

| Version | 본질 | AI Native 면 |
|:-:|------|------|
| v6.0 (완료) | 정의 + entry title 가이드 | 정의 정전화 |
| v6.1 (완료) | JSON 필드 감축 (Anthropic 하이브리드) | 컨텍스트 효율 (cycle 1) |
| v6.2 (완료) | 디렉토리 평탄화 (b) 하이브리드 | 컨텍스트 효율 (cycle 2) |
| v6.3 (완료) | entry title 가이드 smoke 자동 검증 | Verification (첫 실 적용) |
| **v6.4 (본)** | cascade 자동 동기 mechanism | **다중 AI 협업 (첫 실 적용)** |
| v6.5 (예약) | Claude 자율 발의 mechanism | 자율성 |
| v6.6 (예약) | hallucination 자동 정정 mechanism | 다중 AI 협업 (cycle 2) |
| v7.0 (예약, major) | 3 면 통합 | — |

#### Mechanism 1차 발의 = '명령 호출' 결정 정당

- **자동 hook 분기 (oos_1)** = PostToolUse hook 안 cascade trigger = 즉시성 우수 / 단 토큰 비용 (모든 Edit 마다 hook 호출) + false-positive risk (cascade source 외 Edit 도 trigger) + 사용자 의도 분리 어려움.
- **명시 명령 호출 (in_scope)** = 사용자 (또는 milestone 안 EXECUTE phase) 가 명시적으로 'cascade sync' 호출. 즉시성은 약함이나 의도 명확 + 토큰 비용 통제 + dry-run/apply 분리 가능.
- 1차 발의 = 명시 명령. hook 자동 trigger 는 v6.x 후속 candidate 거명만 (oos_1).

#### Cascade source vs host 정의 (명료화)

- **Cascade source** = 정전 narrative 의 1차 위치 (예: ARCHITECTURE.md § 4 끝 cascade drift paragraph). 변경 발생 origin.
- **Cascade host** = source narrative 를 인용/요약/cross-ref 하는 외부 위치 (예: CLAUDE.md, ROADMAP.md, AGENTS.md, README.md 안 동일 paragraph 의 줄임 인용). source 변경 시 stale 회피 의무.
- v3.21 패턴 = (a) DESIGN 1차 source 결정 → (b) EXECUTE Edit source + 모든 host → (c) VERIFY grep stale 인용 0건.
- 본 milestone mechanism = (b) 단계 자동화 = 'cascade sync' 호출 시 source 의 현 content 와 host 의 인용 diff → 자동 적용.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "context7 /websites/code_claude — Configure PostToolUse Hook in Plugin", "fact": "Plugin spec 표준 PostToolUse hook = `hooks.PostToolUse[].matcher: \"Write|Edit\"` + `hooks[].command: ${CLAUDE_PLUGIN_ROOT}/scripts/X.sh` — Plugin 안 자연 통합. Edit/Write 마다 자동 trigger 가능.", "implication": "(I) hook 자동 trigger 옵션 = 기술적 가능. 단 INTENT oos_1 = 사용자 결정 mechanism = '명시 명령 호출', hook 자동 trigger 는 v6.x 후속 candidate. (II) 만약 후속 hook 도입 시 mechanism 자체는 그대로 (script 또는 slash command) 두고 hook 분기만 추가 가능 = mechanism 옵션 (A/B/C) 모두 hook 분기 호환."},
    {"id": "ext_2", "source": "context7 /websites/code_claude — Filter PostToolUse Hook with Matcher + Sub-agent Frontmatter Hooks", "fact": "matcher field 로 특정 tool name 만 trigger 가능 (Edit|Write). sub-agent .md frontmatter 안 hooks PostToolUse 도 정의 가능 (해당 sub-agent active 시만).", "implication": "sub-agent frontmatter hook 은 sub-agent active 시만 작동 = 일반 cascade 자동화 불적합 (cascade 는 main session Edit 도 trigger 필요). plugin entry hooks 가 적합 옵션."},
    {"id": "ext_3", "source": "context7 /websites/code_claude — Advanced Plugin Entry Configuration", "fact": "Plugin entry 안 commands (`./commands/`) + agents (`./agents/X.md`) + hooks + mcpServers 모두 standard fields. `${CLAUDE_PLUGIN_ROOT}` variable = plugin source 안 file reference. slash command 자동 인식.", "implication": "(A) slash command 옵션 (claude/commands/cascade-sync.md) = Plugin spec 자연 통합. (B) script 옵션 = scripts/cascade_sync.py + plugin.json 안 별도 entry 부재 (직접 호출). (C) hybrid = slash command 안에서 script bash 호출."}
  ],
  "codebase": [
    {"id": "cb_1", "source": "ARCHITECTURE.md § 4 끝 narrative 정전화 누적 매트릭스 (v5.20 무넘버)", "fact": "현 7 rows (v3.10/v3.20/v5.21/v5.10/v5.11+v5.18/v5.16/v5.20) + paragraph 본문 7건 정전 위치. 신규 정전화 시 row append + 본문 동시 추가 의무 명시 (line 145, v3.21 narrative 정전화 3 단계 패턴 정합).", "implication": "v6.4 cascade sync mechanism narrative 정전화 = 매트릭스 #8 row + paragraph 본문 추가가 자연 위치. 신규 § 또는 위치는 oos."},
    {"id": "cb_2", "source": "MEMORY.md + v6.3 MILESTONE.md cycle 카운트", "fact": "v3.21 narrative 정전화 3 단계 패턴 cycle 누적 = 28 (v3.18/v3.20/v3.21/v4.2/v5.7/v5.9/v5.10/v5.11/v5.12/v5.13/v5.16/v5.17/v5.18/v5.19/v5.21/v6.1/v6.2/v6.3 등 18+ entry 안 다층 cascade). 평균 host 분포 ~5~12 (v6.2 = 12 host, v6.3 = 5 host).", "implication": "본 milestone = cycle 29. mechanism 도입 후 향후 cycle 30+ 가 자동 적용 대상 = mechanism 의 본질 trigger source."},
    {"id": "cb_3", "source": "Grep cascade — root CLAUDE.md / AGENTS.md / README.md / claude/CLAUDE.md / tests/CLAUDE.md", "fact": "(a) ARCHITECTURE.md = 40+ 위치 cascade narrative 본진. (b) root CLAUDE.md = 0건. (c) AGENTS.md = 0건. (d) README.md = 0건. (e) claude/CLAUDE.md = 1건 (statusline narrative). (f) tests/CLAUDE.md = 2건 (line 22 + 298).", "implication": "본 milestone 안 sc_5 도그푸드 host 후보 = (b) root CLAUDE.md 단독 (현재 cascade narrative 0건 → 첫 host 신규 추가) 또는 + (c) AGENTS.md (영문 요약 추가). round 3 결정 = 1-2 host 정합. DESIGN 안 정확 host 결정."},
    {"id": "cb_4", "source": "Grep cascade-source", "fact": "현 repo 안 marker comment `<!-- cascade-source: ... -->` 패턴 사용 0건.", "implication": "marker comment 옵션 (X) = 신규 도입. 기존 패턴 부재 = bootstrap 작업 필요. manifest 옵션 (Y) 도 0건 (tests/cascade_manifest.json 부재). 둘 다 신규 도입."},
    {"id": "cb_5", "source": "tests/ 안 기존 smoke 8종 + pre-commit 12 hook", "fact": "기존 smoke (entry 직접 호출) = projects-scope-discipline / spec-verification / scope-contract / cross-ref / claude-md-drift / bundle-trigger / open-stage-discipline / entry-title-guideline. pre-commit 12 hook = local 8 (위 8 smoke) + upstream 4 (end-of-file-fixer / trailing-whitespace / check-merge-conflict + 추가).", "implication": "신규 sc_6 cascade-drift smoke 추가 = tests/smoke-cascade-drift.sh + .pre-commit-config.yaml 안 entry 등재. 패턴 = v6.3 entry-title smoke 정합."}
  ],
  "options": [
    {"id": "opt_1", "axis": "mechanism 형태", "choices": [
      {"name": "A. Slash command (claude/commands/cascade-sync.md)", "pro": "Plugin spec 자연 통합 (ext_3) / LLM 자연어 prompt-based / dry-run + apply 단계 LLM 가 사용자 승인 받기 자연 / 도그푸드 = 본 milestone 안 첫 호출 가능", "con": "토큰 비용 cycle 당 ~5K-15K / deterministic 부재 (LLM 가 host 누락 가능) / CI 자동화 불가"},
      {"name": "B. Python script (scripts/cascade_sync.py)", "pro": "deterministic / 토큰 0 / CI 호환 / fast / dry-run/apply 분리 자연 (CLI flag)", "con": "Plugin spec 안 별도 entry 부재 (직접 호출) / 사용자 호출 = `python scripts/cascade_sync.py [--check|--apply]` 자연어보다 길음 / LLM orchestrator vs script 협업 부재"},
      {"name": "C. Hybrid (slash command + script)", "pro": "slash command (LLM orchestrator) + script (mechanical work) = 두 장점 통합 / 사용자 자연어 `/cascade-sync` 호출 → LLM 가 script bash 호출 + diff 사용자 표시 + 승인 받기", "con": "두 구성요소 모두 도입 = 작업 cost 약간 증가 / orchestrator-script 경계 명료화 필요"}
    ]},
    {"id": "opt_2", "axis": "cascade host enumerate", "choices": [
      {"name": "X. Marker comment (host 자기진술)", "pro": "각 host 안 marker = source 정전 위치 + expected hash 자기진술 / enumerate = grep / host 안에서 자기 검증 가능", "con": "marker 관리 cost (신규 host 추가 시 marker 삽입 의무) / markdown 안 HTML comment 다수 = 가독성 약간 저하 / source 변경 시 host 안 expected hash 수동 갱신"},
      {"name": "Y. 중앙 manifest (tests/cascade_manifest.json)", "pro": "중앙 제어 / source ↔ host 매핑 명료 / source content hash 자동 계산 / manifest 1 파일만 갱신", "con": "source ↔ host 이원화 (manifest 안 entry + host 안 인용 두 곳 동기 의무) / host 안 자기진술 부재 = host 만 보면 cascade 여부 불명료"},
      {"name": "Z. Hybrid (marker + manifest)", "pro": "host 안 marker (자기진술) + manifest (중앙 정의 + hash) 두 장점 통합", "con": "두 구성요소 모두 도입 = 작업 cost / 동기화 누락 가능"}
    ]},
    {"id": "opt_3", "axis": "phase 분할", "choices": [
      {"name": "P1. 1 phase 통합 (mechanism + 도그푸드 + smoke 동시)", "pro": "lightweight 정신 / 1 commit / scope 일관", "con": "mechanism 도입 commit 안 도그푸드 + smoke 가 같이 = 회귀 시 분리 어려움"},
      {"name": "P2. 2 phase 분리 (phase-1 mechanism + smoke 도입 / phase-2 도그푸드 첫 적용)", "pro": "v6.3 entry-title 패턴 정합 / mechanism + smoke 동작 검증 후 도그푸드 = 안전 / 회귀 분리 용이", "con": "2 commit / scope 약간 큼"}
    ]}
  ],
  "risks_identified": [
    {"id": "r_1", "risk": "cascade host marker 관리 cost — 신규 host 추가 시 marker 삽입 의무 누락", "mitigation": "sc_6 cascade-drift smoke 가 자동 차단 (host 안 marker 없으면 enumerate 안 됨 + 인용 cascade 의도 시 사용자 명시 marker 삽입). DESIGN 안 옵션 X/Y/Z 결정 시 marker vs manifest trade-off 명시"},
    {"id": "r_2", "risk": "dry-run 부재 시 Edit 회귀 — mechanism 자동 sync 가 의도 외 위치 overwrite", "mitigation": "옵션 A/C = LLM 가 diff 사용자 표시 후 승인 받기 자연. 옵션 B = `--check` flag (dry-run) + `--apply` flag (실 Edit) 분리 의무"},
    {"id": "r_3", "risk": "smoke hash mismatch false-positive — source 안 무관 공백 변경에 의한 hash 변경", "mitigation": "hash 알고리즘 = source paragraph 본문 (whitespace normalize 후) 또는 specific text snippet. DESIGN 안 hash scope 결정 (전체 paragraph vs 특정 sentence)"},
    {"id": "r_4", "risk": "도그푸드 chicken-and-egg — mechanism 도입 phase-1 안 도그푸드 적용 불가 (mechanism 자체 미존재)", "mitigation": "opt_3 P2 (2 phase 분리) 채택 시 자연 해소 — phase-1 mechanism 도입 → phase-2 도그푸드 첫 적용 (mechanism 자체 호출). P1 통합 시 mechanism 구현 직후 같은 phase 안 즉시 호출 = 가능하나 sequence 명료성 약함"},
    {"id": "r_5", "risk": "본 milestone 안 mechanism narrative 정전화 위치 결정 — ARCHITECTURE § 4 끝 매트릭스 #8 row vs 별 § 7 AI Native 안 § 7.4 신설", "mitigation": "cb_1 cf — § 4 끝 매트릭스 = narrative 정전화 home (line 145 신규 정전화 시 row append 의무 명시). § 4 끝 매트릭스 #8 row 추가가 자연. DESIGN 안 확정"},
    {"id": "r_6", "risk": "외부 URL host (예: AGENTS.md 안 Anthropic Claude Code docs URL 인용) 의 cascade 자동화 가능 여부", "mitigation": "INTENT oos_5 = 본 milestone scope 외 (외부 URL = immutable + access 보장 부재). enumerate scope = repo 내부 source → 내부 host 단방향. mechanism 안 외부 URL marker 발견 시 skip 또는 warn"}
  ]
}
```

### Notes

#### context7 query 누적

- 본 milestone RESEARCH 안 context7 query = 1회 (`/websites/code_claude` — PostToolUse hook + slash command + plugin entry). 결과 = ext_1+ext_2+ext_3. 추가 query 필요 시 DESIGN 안 호출.

#### codebase 조사 누적

- Grep "cascade" = ARCHITECTURE.md (40+) + root CLAUDE.md (0) + AGENTS.md (0) + README.md (0) + claude/CLAUDE.md (1) + tests/CLAUDE.md (2)
- Grep "cascade-source" marker = 0건 (신규 도입)
- Glob v3.21 REPORT.md = `milestones/_archive/v3.21/REPORT.md` (3 단계 패턴 1차 source)
- ARCHITECTURE § 4 끝 line 131-161 = 7 rows + 본문 7건 (정전 위치)

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "D1", "decision": "mechanism = C. Hybrid (slash command + script)", "rationale": "round 4 (RESEARCH 후) 사용자 결정. slash command `/cascade-sync` = LLM orchestrator + script `scripts/cascade_sync.py` = deterministic mechanical work. 사용자 호출 자연어 + 토큰 통제 + dry-run/apply 명료. opt_1 trade-off 정합."},
    {"id": "D2", "decision": "cascade host enumerate = X. Marker comment 단독", "rationale": "round 4 사용자 결정. host 안 marker (`<!-- cascade-source: ARCHITECTURE.md#anchor expected-hash:abc123 -->`) = host 자기진술 + grep enumerate. manifest 이원화 회피. opt_2 trade-off 정합."},
    {"id": "D3", "decision": "phase 분할 = P2. 2 phase 분리", "rationale": "round 4 사용자 결정. phase-1 mechanism + smoke 도입 + 회귀 검증 / phase-2 도그푸드 첫 적용 (sc_5 cycle 29 self-host). r_4 chicken-and-egg 자연 해소. v6.3 entry-title 패턴 정합."},
    {"id": "D4", "decision": "mechanism narrative 정전화 위치 = ARCHITECTURE § 4 끝 누적 매트릭스 #8 row + paragraph 본문 추가", "rationale": "r_5 + cb_1 cf. § 4 끝 매트릭스 (line 145) 안 'v3.21 narrative 정전화 3 단계 패턴 정합 — (b) EXECUTE Edit 단계에서 매트릭스 row append 동기 수행' 의무 명시. 매트릭스 = narrative 정전화 home. 별 § 신설 회피 (oos_2 정합)."},
    {"id": "D5", "decision": "sc_5 도그푸드 cascade host = root CLAUDE.md 단독 (1 host)", "rationale": "round 3 사용자 결정 = 1-2 host. 최소 1 host (root CLAUDE.md, 현재 cascade narrative 0건) = 가장 작은 scope + mechanism 자체 적용 첫 검증 충분. + AGENTS.md (영문 요약) 추가는 v6.x 후속 candidate (oos_2 정합 — 다른 narrative cascade)."},
    {"id": "D6", "decision": "hash 알고리즘 = source paragraph 본문 (whitespace normalize 후 SHA-256 16자 hex)", "rationale": "r_3 mitigation. paragraph 전체 (heading + body) hash → whitespace normalize (`\\s+` → single space, trim) 후 SHA-256 → 16자 hex (8 byte) prefix. anchor = ARCHITECTURE.md#section-anchor 또는 line range. hash scope = whole paragraph (특정 sentence 보다 안정 + drift 회피)."},
    {"id": "D7", "decision": "marker comment 형식 = `<!-- cascade-source: <path>#<anchor> expected-hash:<16-hex> -->` (HTML comment, markdown 호환)", "rationale": "markdown 안 HTML comment = invisible 표시 + grep 가능. <path> = repo-relative (예: `projects/meta/ARCHITECTURE.md`). <anchor> = heading anchor (heading slug 자동 매칭) 또는 explicit HTML id (`<a id=\"X\">`). expected-hash = D6 hash. **외부 cascade marker 표준 부재** (context7 query 안 Anthropic Claude Code spec / Plugin spec / hook spec 모두 cascade marker / dependency tracking / link checking 패턴 0건 — spec-drift 검토 P1_spec_1 흡수) → 본 repo 자체 컨벤션 정전화 (v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 자연 발현 5번째). **markdownlint MD033 호환성 fact 검증** (P1_spec_2 흡수): `.markdownlint.json` 안 `MD033: false` (disabled) 직접 확인 = HTML comment silent break 부재 (markdownlint hook 안전 통과 보장). **HTML comment escape 차단** (P2_sec_3 보강): <path>/<anchor> 안 `-->` literal 차단 의무 — script + smoke 양쪽 validator."},
    {"id": "D8", "decision": "dry-run UX = slash command 기본 = check (diff 표시 + 사용자 승인 받기), `apply` 명시 시 Edit 실행", "rationale": "r_2 mitigation. `/cascade-sync` (단독) = dry-run (check + diff 표시). `/cascade-sync apply` = check + 자동 Edit. script flag = `--check` (default) / `--apply`. 사용자 의도 명료 + Edit 회귀 회피."},
    {"id": "D9", "decision": "pre-commit 등재 = tests/smoke-cascade-drift.sh 신규 hook (entry 직접 호출, --fix 미지원)", "rationale": "sc_6 정합. .pre-commit-config.yaml 안 새 local hook entry (id: smoke-cascade-drift / entry: tests/smoke-cascade-drift.sh / language: script / pass_filenames: false). 12 hook → 13 hook. cascade sync 명령 자체는 pre-commit 미등재 (사용자 명시 호출 mechanism 정합, oos)."},
    {"id": "D10", "decision": "slash command vs script 책임 경계 — script = enumerate + diff text 생성 + apply / slash command = script 호출 + diff 사용자 표시 + 승인 받기 + 결과 보고", "rationale": "C hybrid 의 책임 분리. script = mechanical 의 단일 source. slash command = UX 의 단일 source. script 단독 (`python ... --check|--apply`) CI 자동화도 가능 (sc_4 회귀 0 + 미래 CI 확장 호환). **Tool 호출 mechanism** (P2_reg_4 흡수): slash command 안 Bash tool 으로 `python scripts/cascade_sync.py --check|--apply` 호출 (fixed argument list). claude/commands/cascade-sync.md frontmatter 안 `allowed-tools: Bash, Read` 명시 의무."},
    {"id": "D11", "decision": "script edge case 명세 (P1_reg_3 + P1_reg_4 흡수)", "rationale": "**enumerate edge case**: (a) 0 host = OK exit 0 silent (cascade 의도 부재 자연) / (b) 동일 source 가리키는 N host = 정상 (multi-host 자연 cascade) / (c) source 파일 부재 = ERROR exit 2 (typo/이름 변경) / (d) source 안 anchor 부재 = ERROR exit 2 (anchor stale) / (e) 호스트 SIZE_LIMIT 100KB 초과 = WARN skip (v6.3 smoke 패턴 정합) / (f) code fence 안 marker = false-positive 회피 (smoke-cross-ref.sh L99 `in_code` toggle 패턴 정합). **anchor → paragraph 매핑 logic**: anchor 가 markdown heading slug (auto-generated) 매칭 시 = 매트릭스 row case 한 줄 또는 그 다음 paragraph 까지 (다음 동급/상위 heading 직전까지) / anchor 가 explicit HTML id (`<a id=\"X\">`) 매칭 시 = 같은 paragraph 단일 block (anchor 직후 paragraph 또는 직전 paragraph 우선 명시). 본 milestone D4 § 4 끝 매트릭스 #8 paragraph = explicit `<a id=\"section-4-end-row-8\">` 명시 + 같은 paragraph 단일 block 매핑 (P1_reg_2 anchor 보강 흡수)."},
    {"id": "D12", "decision": "security 가드레일 통합 (P1_sec_1 + P1_sec_2 흡수)", "rationale": "**Path traversal 차단** (P1_sec_1): script + smoke 양쪽 안 marker `<path>` resolve 후 `is_relative_to(REPO_ROOT)` 검증 의무 — 위반 시 FAIL exit 1 (silent SKIP 폐기, v6.3 smoke SIZE_LIMIT FAIL 패턴 정합). `../../../etc/passwd`, `/etc/shadow` 등 repo 외부 path 차단. **ReDoS 차단** (P1_sec_2): smoke 안 marker regex = length-bounded — `<path>` `[^\\s]{1,200}` + `<anchor>` `[^\\s]{1,100}` + `expected-hash` `[0-9a-f]{16}` (정확 16자 hex 강제). 호스트 파일 SIZE_LIMIT 100KB FAIL exit 1 + 단일 line cap 4096 (v6.3 entry-title smoke 패턴 정합). **외부 URL skip** (r_6 + P2_sec_5): script 안 `<path>` regex `^https?://` 매칭 시 stderr warn + skip (FAIL 아님, oos_5 정합). marker 안 `external: true` 명시 시 warn 도 suppress (의도 표현, v6.x 후속)."},
    {"id": "D13", "decision": "subprocess injection 차단 (P1_sec_3 흡수)", "rationale": "slash command 안 script 호출 시 사용자 입력은 CLI flag (`--check`/`--apply`) 만 허용. 임의 argument (예: source filter, host filter) = 본 milestone scope oos (v6.x 후속). LLM 가 script 호출 시 fixed argument list 만 사용 (shell metacharacter `;`, `&&`, `$(...)` injection 차단). claude/commands/cascade-sync.md prompt 안 `bash python scripts/cascade_sync.py --check` 또는 `bash python scripts/cascade_sync.py --apply` 두 형태 만 허용 hardcode."}
  ],
  "approach": "phase-1 (mechanism + smoke 도입 + 본 milestone 안 narrative 정전화 paragraph 추가) / phase-2 (도그푸드 = root CLAUDE.md 안 marker comment + 본 milestone 안 mechanism 자체 호출로 첫 cascade sync 시연). mechanism 의 본 milestone 안 narrative source = ARCHITECTURE § 4 끝 매트릭스 #8 row + paragraph 본문 (D4). phase-1 안 source paragraph 본문 추가 시점 = phase-1 끝 (smoke 도입 후 narrative 정전화 = v3.21 패턴 (a) 단계). phase-2 안 root CLAUDE.md 안 marker 삽입 + 인용 추가 후 `/cascade-sync` 호출 = 도그푸드.",
  "phases": [
    {
      "id": "phase-1",
      "scope": "mechanism (slash command + script) 도입 + sc_6 cascade-drift smoke 도입 + ARCHITECTURE § 4 끝 매트릭스 #8 row + paragraph 본문 추가 (narrative 정전화 (a) 단계)",
      "changes": [
        "신규 scripts/cascade_sync.py — enumerate (grep cascade-source marker) + hash compare + diff text + --check/--apply flag + D11 edge case (a~f) + D12 path traversal 차단 + D13 fixed argument list",
        "신규 claude/commands/cascade-sync.md — slash command frontmatter (description / allowed-tools: Bash, Read / argument-hint: `[apply]`) + LLM prompt (Bash tool 으로 fixed `python scripts/cascade_sync.py --check|--apply` 호출 + diff 사용자 표시 + 명시 응답 (y/n) 승인 받기 + apply, P2_spec_3 + P2_sec_2 흡수)",
        "신규 tests/smoke-cascade-drift.sh — entry 직접 호출 (marker hash compare 후 mismatch 시 FAIL) + D12 length-bounded regex + SIZE_LIMIT 100KB FAIL exit 1 + path traversal 차단 + read-only (host file modify 금지, P2_sec_4 흡수)",
        ".pre-commit-config.yaml — 신규 hook entry 추가 (id: smoke-cascade-drift / name / entry: tests/smoke-cascade-drift.sh / language: script / pass_filenames: false / files: \\.md$, P2_spec_4 schema 명시 흡수) — 12 → 13 hook",
        "ARCHITECTURE.md § 4 끝 매트릭스 #8 row 추가 + paragraph 본문 #8 추가 (cascade sync mechanism 사용법 정전화, 3-5 줄 길이 가이드 P2_reg_5 흡수, explicit `<a id=\"section-4-end-row-8\">` anchor 명시 P1_reg_2 흡수, 첫 줄 안 '자동' 두 의미 분리 명시 P2_dict_2 흡수)",
        "tests/CLAUDE.md — § smoke 매트릭스 안 신규 cascade-drift cascade row + L7 '현 N 파일' 텍스트 8→9 갱신 (P2_reg_2 흡수) + § 회귀 검증 절차 안 `--fix` mode 패턴 ReDoS 차단 row 갱신 (P1_sec_2 cascade)",
        "신규 smoke controlled 비교 4-step self-check (tests/CLAUDE.md L210 정합, P1_reg_5 흡수) — 의도 drift 주입 host marker hash 1-byte tamper → smoke FAIL → cascade sync apply → smoke PASS, .bak 백업 cleanup"
      ],
      "commit": "feat(meta): v6.4 phase-1 — cascade sync mechanism (slash + script + smoke) + § 4 끝 매트릭스 #8"
    },
    {
      "id": "phase-2",
      "scope": "도그푸드 첫 적용 = root CLAUDE.md 안 marker comment + cascade source 인용 추가 + `/cascade-sync` 호출 시연 + ROADMAP archival (v6.1 → CHANGELOG)",
      "changes": [
        "root CLAUDE.md 안 marker comment 추가 (`<!-- cascade-source: projects/meta/ARCHITECTURE.md#section-4-end-row-8 expected-hash:<computed> -->`) + cascade narrative 인용 (mechanism 사용법 1-2 줄 bullet 또는 prose 1 문단, 5 연속 prose 줄 회피, claude-md-drift S3 회피 P1_reg_1 흡수)",
        "`/cascade-sync` 또는 `python scripts/cascade_sync.py --check` 호출 → root CLAUDE.md 안 marker 발견 + source hash match 확인 → PASS (cycle 29 self-host)",
        "ROADMAP archival cycle = recent 3 (v6.4/v6.3/v6.2) → v6.1 entry CHANGELOG.md 등재 + ROADMAP milestones[] 제거",
        "CHANGELOG.md 안 [v6.4] entry 추가 (Keep a Changelog 정합) — bullet bold header 형식 `**cascade 자동 동기 mechanism**` + ' + ' 부재 + ≤ 60자 자동 검증 통과 명시 (P1_reg_6 흡수)"
      ],
      "commit": "feat(meta): v6.4 phase-2 — 도그푸드 (root CLAUDE.md 안 marker + cascade) + archival v6.1"
    }
  ],
  "risk_mitigation": [
    {"risk_id": "r_1", "mitigation": "D2 marker 단독 + D9 smoke 자동 차단 + DESIGN narrative 안 marker 관리 의무 명시"},
    {"risk_id": "r_2", "mitigation": "D8 dry-run UX (slash command 기본 check + apply 명시 의무) + D10 script `--check` default + claude/commands/cascade-sync.md prompt 안 'apply 명시 호출이라도 LLM 는 diff 출력 후 사용자 명시 응답 (y/n) 받기' 강제 의무 (P2_sec_2 흡수)"},
    {"risk_id": "r_3", "mitigation": "D6 hash 알고리즘 (whitespace normalize 후 SHA-256 16자 prefix) — 무관 공백 변경 회피. **16자 rationale 보강** (P2_spec_2 흡수): git short SHA (7자) 와 SDK UUID (32자) 사이 중간 + collision 확률 ~10^-19 충분 + grep keyword visual scan 가능 (32자보다 짧음). 외부 표준 부재, 본 repo 자체 결정."},
    {"risk_id": "r_4", "mitigation": "D3 phase P2 분리 (phase-1 mechanism + smoke / phase-2 도그푸드) — chicken-and-egg 자연 해소"},
    {"risk_id": "r_5", "mitigation": "D4 narrative 정전화 위치 = § 4 끝 매트릭스 #8 row + paragraph 본문 추가 — cb_1 cf line 145 의무 정합"},
    {"risk_id": "r_6", "mitigation": "INTENT oos_5 + D12 script enumerate 안 외부 URL marker 발견 시 stderr warn + skip (FAIL 아님). marker 안 `external: true` 명시 시 warn suppress (v6.x 후속)"}
  ]
}
```

### 5 관점 subagent 병렬 검토

#### 검토 매트릭스 (cycle 4, 누적 cycle 1: 6 → cycle 2: 20 → cycle 3: 35 → cycle 4: 38 = feedback_subagent_parallel_review_evidence 누적 증가 패턴 정합)

| 관점 | agent | verdict | P1 (decisive) | P2 (lightweight) | PASS |
|------|------|------|------|------|------|
| architecture | Plan | pass-with-comments | 0 | 7 | 7 |
| spec-drift | general-purpose | pass-with-comments | 2 (spec_1 marker format 자체 컨벤션 / spec_2 markdownlint MD033 호환성) | 4 | 6 |
| regression | general-purpose | pass-with-comments | 6 (reg_1 S3 회피 / reg_2 anchor / reg_3 edge case / reg_4 매핑 logic / reg_5 self-check / reg_6 entry-title) | 5 | 7 |
| security | general-purpose | pass-with-comments | 3 (sec_1 path traversal / sec_2 ReDoS / sec_3 subprocess injection) | 5 | 6 |
| dictionary-semantics | general-purpose | pass-with-comments | 0 | 6 | 7 |
| **합계** | — | **5/5 pass-with-comments** | **11** | **27** | **33** |

#### P1 11 건 흡수 매핑 (DESIGN edit 즉시)

- **spec_1 + spec_2 + sec_3 (sec_3 HTML escape 부분)** → D7 rationale 보강 (외부 spec 부재 + .markdownlint.json MD033:false fact + `-->` literal 차단)
- **reg_3 + reg_4** → D11 신규 (script edge case (a~f) + anchor → paragraph 매핑 logic)
- **sec_1 + sec_2 + r_6** → D12 신규 (path traversal 차단 + ReDoS 차단 + 외부 URL skip)
- **sec_3** → D13 신규 (subprocess injection 차단, fixed argument list)
- **reg_1** → phase-2.changes 보강 (root CLAUDE.md 인용 ≤ 4줄 또는 structural 우세)
- **reg_2** → D11 + phase-1.changes 보강 (anchor explicit HTML id 명시)
- **reg_5** → phase-1.changes 보강 (controlled self-check 4-step)
- **reg_6** → phase-2.changes 보강 (CHANGELOG entry 가이드 준수)

#### P2 27 건 (lightweight, PROPOSE 안 candidate 거명만)

- **architecture P2 (7)**: Trace 영향 element 보강 / anchor scheme 명료화 / scripts/ 디렉토리 + ${CLAUDE_PLUGIN_ROOT} path narrative / 다중 AI 협업 정의 stretch 명료화 / dep_8 cross-ref / phase-2 archival sub-scope / 1 host 도그푸드 robustness (multi-host v6.x 확장)
- **spec-drift P2 (4)**: plugin.json paths 자동 인식 검증 / hash 16자 rationale 보강 (이미 r_3 흡수) / slash command frontmatter 4 필드 명시 (이미 phase-1 흡수) / pre-commit hook schema 5 필드 명시 (이미 phase-1 흡수)
- **regression P2 (5)**: pre-commit latency batched (cycle 5+ 미적용) / smoke count 8→9 갱신 (이미 phase-1 흡수) / markdownlint pre-commit self-check (commit 전) / slash command Bash tool 명시 (이미 D10 흡수) / source paragraph 길이 가이드 (이미 phase-1 흡수)
- **security P2 (5)**: hash collision 외부 PR 안 (oos_4 와 함께) / apply prompt 안 사용자 응답 강제 (이미 r_2 흡수) / marker HTML escape (이미 D7 흡수) / smoke read-only 명시 (이미 phase-1 흡수) / external: true marker (이미 D12 흡수)
- **dictionary-semantics P2 (6)**: title active form 약 P3 retitle 거명만 / '자동' 두 의미 명료화 (이미 phase-1 narrative 흡수) / 'cascade' 사전 ~70% (de-facto 정착) / 'sync' on-demand (CLI convention) / phase-1 통합 본질 (drift 수용 정합) / 'register' word-smith

PROPOSE 안 신규 candidate 등재 = 위 P2 중 흡수 미실 = 9건 (architecture 4 + regression 1 + security 1 + dictionary 3) — Stage I 안 정전화.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-20",
    "approval_summary": "INTENT 4 round 누적 결정 (Scope 단독 / Mechanism EXECUTE 명령 / Host enumerate DESIGN 보류 / 5 관점 검토 적용 / sc_5 host 1-2 / sc_6 smoke in_scope) + RESEARCH (context7 1 query + codebase 5 grep + 옵션 3 축 + risks 6건) + DESIGN (D1~D13 결정 + 5 관점 cycle 4 = pass-with-comments 5/5 + P1 11건 흡수 + P2 27건 PROPOSE 거명만) 검토 후 EXECUTE 진입 승인. phase-1 = mechanism (slash + script + smoke) + § 4 끝 매트릭스 #8 + controlled self-check 4-step / phase-2 = 도그푸드 (root CLAUDE.md marker + cascade) + ROADMAP archival v6.1 + CHANGELOG [v6.4] entry.",
    "round_log": [
      {"round": 1, "decision": "scope cascade-auto-sync 단독 (Recommended) / mechanism EXECUTE phase 안 'cascade sync' 명령 도입"},
      {"round": 2, "decision": "host enumerate OPEN 보류 RESEARCH 후 DESIGN / 5 관점 검토 적용"},
      {"round": 3, "decision": "sc_5 도그푸드 host 최소 1-2 (DESIGN 안 결정) / sc_6 cascade drift smoke 도입 in_scope (Recommended)"},
      {"round": 4, "decision": "mechanism C Hybrid (slash + script) / enumerate X Marker 단독 / phase P2 분리 (Recommended)"},
      {"round": 5, "decision": "EXECUTE 진입 승인"}
    ]
  }
}
```

## EXECUTE

per-phase 별책 = [`execute/phase-1.md`](execute/phase-1.md) (mechanism + smoke + § 4 끝 #8 + cascade) + [`execute/phase-2.md`](execute/phase-2.md) (도그푸드 + archival + VERIFY/REPORT/PROPOSE 통합).

| Phase | Commit | Scope |
|:-:|---|---|
| phase-1 | `2176be9` | scripts/cascade_sync.py + claude/commands/cascade-sync.md + tests/smoke-cascade-drift.sh + .pre-commit-config.yaml +1 hook + ARCHITECTURE § 4 끝 #8 + tests/CLAUDE.md cascade + INTENT sc_4 fact 정정 + MD012 정정 (9 files / +836 / -12) |
| phase-2 | (본 commit) | root CLAUDE.md cascade marker 도그푸드 + CHANGELOG [v6.4] + ROADMAP archival v6.1 + v6.4 status completed + MILESTONE.md ## VERIFY/REPORT/PROPOSE 통합 |

## VERIFY

### Spec

```json
{
  "smoke": {
    "active_count": 9,
    "pre_commit_hook_count": 16,
    "all_passed": true,
    "evidence": "phase-1 commit 직전 + phase-2 commit 직전 `pre-commit run --all-files` 16 hook 모두 PASS (upstream 7 = pre-commit-hooks 5 + shellcheck 1 + markdownlint 1 + local 9 = projects-scope / spec-verification / scope-contract / cross-ref / claude-md-drift / bundle-trigger / open-stage-discipline / entry-title-guideline / cascade-drift)"
  },
  "dogfood": {
    "cycle": 29,
    "host_count": 1,
    "host_path": "CLAUDE.md (root)",
    "source_path": "projects/meta/ARCHITECTURE.md#section-4-end-row-8",
    "expected_hash": "18b81d6adfd7e60a",
    "actual_hash": "18b81d6adfd7e60a",
    "sync_verdict": "PASS (1 host in sync)"
  },
  "controlled_self_check_phase_1": {
    "method": "fixture drift 주입 → smoke FAIL → --apply → smoke PASS (4-step)",
    "step_1_baseline": "exit 0 (0 host) PASS",
    "step_2_drift_inject": "exit 1 (1 drift, expected 0000... vs actual 18b81d6adfd7e60a) PASS",
    "step_3_apply": "marker updated 1 / drift 1 / host 1 PASS",
    "step_4_resync": "exit 0 (1 host in sync) PASS",
    "cleanup": "fixture 제거 PASS"
  },
  "criteria_check": [
    {"sc_id": "sc_1", "description": "'cascade sync' 명령 도입 — slash command + script + smoke 3 컴포넌트 hybrid (D1)", "verdict": "PASS"},
    {"sc_id": "sc_2", "description": "cascade host enumerate marker 단독 (D2) + grep + parse + length-bounded regex", "verdict": "PASS"},
    {"sc_id": "sc_3", "description": "도그푸드 self-check controlled 4-step (drift 주입 → detect → apply → resync)", "verdict": "PASS — phase-1 controlled self-check evidence"},
    {"sc_id": "sc_4", "description": "회귀 0 — 기존 smoke 8 + 신규 1 = 9 + pre-commit 15→16 hook 모두 PASS", "verdict": "PASS — phase-1+phase-2 commit 전 `pre-commit run --all-files` 모두 PASS"},
    {"sc_id": "sc_5", "description": "도그푸드 cycle — mechanism narrative self-host (root CLAUDE.md 단독 host = 1 host)", "verdict": "PASS — cycle 29 self-host 완성"},
    {"sc_id": "sc_6", "description": "cascade drift smoke 도입 + pre-commit 등재 + self-check 4-step", "verdict": "PASS — tests/smoke-cascade-drift.sh + `.pre-commit-config.yaml` 등재 + controlled self-check"}
  ],
  "verdict": "PASS",
  "summary": "모든 success_criteria (sc_1~sc_6) PASS. 회귀 0. mechanism 도입 + 적용 + 검증 cycle 완성. v3.21 narrative 정전화 3 단계 패턴 cycle 29 self-host = mechanism 도입 milestone 안 mechanism 자체 적용 도그푸드 첫 자동화 cycle."
}
```

## REPORT

### Spec

```json
{
  "summary": "AI Native § 7.1 '다중 AI 협업' 면 첫 실 적용 milestone. v3.21 narrative 정전화 3 단계 패턴 (b) EXECUTE Edit cascade 단계 수동 cycle (v3.18~v6.3 누적 28+) 자동화 mechanism 도입 — `scripts/cascade_sync.py` (deterministic core) + `claude/commands/cascade-sync.md` (slash command UX orchestrator) + `tests/smoke-cascade-drift.sh` (read-only drift detect, pre-commit 자동 차단). marker format `<!-- cascade-source: <path>#<anchor> expected-hash:<16-hex> -->` = 본 repo 자체 컨벤션 (Anthropic spec 부재, v5.7 spike (c) 5번째). 2 phase 2 commit / 9+5 files / +1000+ LOC / pre-commit 15→16 hook. 도그푸드 cycle 29 self-host 완성. 5 관점 subagent 병렬 검토 cycle 4 = pass-with-comments × 5 + decisive 0 + P1 11 흡수 + P2 27 PROPOSE 거명만 (cycle 누적 증가 패턴 정합). archival cycle 4번째 (v6.1 → CHANGELOG).",
  "delta": [
    {"item": "mechanism 형태", "planned": "C Hybrid (slash + script)", "actual": "C Hybrid + smoke 3 컴포넌트 분리 (script = mechanical / slash = UX / smoke = drift detect)", "note": "DESIGN.D10 정합 + smoke 책임 분리 자연 (sc_6 in_scope)"},
    {"item": "host enumerate", "planned": "X Marker comment 단독", "actual": "Marker comment + length-bounded regex + path traversal 차단 + HTML escape 차단 + external URL skip", "note": "D7+D12 보강 안 통합. 5 관점 P1 sec_1+sec_2+sec_3 흡수"},
    {"item": "phase 분할", "planned": "P2 2 phase", "actual": "phase-1 mechanism + smoke + § 4 끝 #8 + cascade + 자체 self-check / phase-2 도그푸드 + archival + VERIFY/REPORT/PROPOSE 통합", "note": "정합"},
    {"item": "도그푸드 host 개수", "planned": "1-2 host (sc_5)", "actual": "1 host (root CLAUDE.md 단독)", "note": "최소 검증 + scope 작음 정합. + AGENTS.md (host #2) 확장은 v6.x 후속 candidate (P2 arch_7)"},
    {"item": "narrative 정전화 위치", "planned": "ARCHITECTURE § 4 끝 매트릭스 #8 row + paragraph (D4)", "actual": "정합 + explicit `<a id=\"section-4-end-row-8\">` anchor + 5 줄 + '자동' 두 의미 분리 첫 줄 (P1_reg_2 + P2_reg_5 + P2_dict_2 통합)", "note": "정합"},
    {"item": "pre-commit hook count", "planned": "12→13 (INTENT 초안)", "actual": "15→16 (실 측정 fact 정정)", "note": "EXECUTE inline fact 발견 + 정정. v6.3 narrative cascade fact mismatch 인지 — L1"},
    {"item": "markdownlint MD012", "planned": "(부재)", "actual": "phase-1 commit 직전 MILESTONE.md line 95+154 blank line 2개 차단 → inline 정정", "note": "tests/CLAUDE.md § 흔한 함정 추가 candidate (L2)"}
  ],
  "lessons_learned": [
    {"id": "L1", "lesson": "pre-commit hook count narrative 는 INTENT 작성 시 `.pre-commit-config.yaml` 실 측정 의무 (v5.11 fact 검증 패턴 self 적용)", "evidence": "v6.3 narrative '11→12' + 본 milestone INTENT 초안 '12→13' 모두 mismatch. EXECUTE 단계 실 측정 = upstream 7 + local 8 = 15 → 16. inline 정정 후 narrative 정합", "cascade_candidate": "v6.x 후속 candidate — 기존 v6.0~v6.3 narrative 안 hook count cascade 정정 (lightweight, 거명만)"},
    {"id": "L2", "lesson": "markdownlint MD012 (multiple consecutive blank lines) 차단 — JSON 코드 블록 직후 ```...``` close + blank 1개 의무 (2개 차단)", "evidence": "phase-1 commit 직전 MILESTONE.md line 95+154 차단 → inline 정정 후 PASS. tests/CLAUDE.md § 흔한 함정 7건 중 MD032/MD049 만 명시 — MD012 추가 candidate", "cascade_candidate": "tests/CLAUDE.md § 흔한 함정 표 안 MD012 row 추가 (P3, v6.x 후속)"},
    {"id": "L3", "lesson": "5 관점 subagent 병렬 검토 cycle 누적 증가 패턴 유지 (cycle 1: 6 → cycle 2: 20 → cycle 3: 35 → cycle 4: 38)", "evidence": "P1 11 + P2 27 = 38건. cycle 3 (35) 대비 1.09배 안정 (cycle 1→2 2.4배 / cycle 2→3 1.75배 / cycle 3→4 1.09배 = converged 추세). 객관 검토자 가치 재확인 — decisive 0 + 모든 5 관점 pass-with-comments", "cascade_candidate": "feedback_subagent_parallel_review_evidence cycle 4 evidence 갱신 (memory update)"},
    {"id": "L4", "lesson": "v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 5번째 자연 발현 — 외부 Anthropic spec 부재 인지 + DESIGN.D7 rationale 안 본 repo 자체 컨벤션 정전화 즉시", "evidence": "context7 query 안 cascade marker / dependency tracking / link checking 패턴 0건 → DESIGN.D7 안 '본 repo 자체 컨벤션' 명시 + ARCHITECTURE § 4 끝 #8 paragraph 안 동일 narrative. v4.2 + v5.6 + v6.2 + v6.3 + v6.4 = 5번째 자연 발현 cycle", "cascade_candidate": "ARCHITECTURE § 6 끝 spike paragraph 안 cycle 5 evidence row 추가 (v6.x 후속 PROPOSE)"},
    {"id": "L5", "lesson": "도그푸드 cycle 29 self-host = mechanism 도입 milestone 안 mechanism 자체 적용 = 자기참조 cycle 첫 자동화 적용", "evidence": "root CLAUDE.md 안 marker `expected-hash:18b81d6adfd7e60a` = ARCHITECTURE § 4 끝 #8 paragraph actual hash 정합. `python3 scripts/cascade_sync.py --check` exit 0 (1 host in sync) + smoke-cascade-drift.sh exit 0", "cascade_candidate": "향후 cycle 30+ 자동 cascade 시 사용자 명시 `/cascade-sync apply` 호출 + diff 검토 + 승인 cycle 자연 정착"},
    {"id": "L6", "lesson": "anchor → paragraph 매핑 logic 명시 의무 — explicit HTML id 우선 + markdown heading slug 보조 (D11 P1_reg_4 흡수)", "evidence": "scripts/cascade_sync.py 안 find_anchor_paragraph 함수 = 두 priority logic 구현 + ARCHITECTURE § 4 끝 #8 paragraph 안 explicit `<a id=\"section-4-end-row-8\">` 명시. cycle 29 actual hash 정확 추출", "cascade_candidate": "신규 cascade source 추가 시 explicit anchor 의무 narrative 보강 (PROPOSE)"},
    {"id": "L7", "lesson": "phase 분할 P2 (mechanism + smoke + narrative 정전화 / 도그푸드 + archival) = chicken-and-egg 자연 해소 + 회귀 격리", "evidence": "phase-1 commit 후 pre-commit 16 hook PASS 검증 → phase-2 도그푸드 안전. phase-1 회귀 시 commit revert 만으로 phase-2 영향 차단. v6.3 entry-title 패턴 정합", "cascade_candidate": "v6.x 후속 mechanism 도입 milestone 안 phase P2 분할 default 패턴 거명 (PROPOSE)"}
  ],
  "metric": {
    "phase_count": 2,
    "commit_count": 2,
    "file_count_total": 13,
    "loc_added": "+1000+ (phase-1: +836 / phase-2: +200~)",
    "loc_removed": "-26+ (phase-1: -12 / phase-2: -14 archival)",
    "smoke_count_before": 8,
    "smoke_count_after": 9,
    "pre_commit_hook_before": 15,
    "pre_commit_hook_after": 16,
    "regression": 0,
    "subagent_review_p1_absorbed": 11,
    "subagent_review_p2_propose_only": 27,
    "v3_21_cycle_number": 29,
    "v5_7_spike_pattern_c_cycle": 5,
    "archival_cycle_number": 4
  }
}
```

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {"id": "trace-element-affected-narrative-boost", "title": "5요소 매핑 안 Trace 영향 element 보강", "trigger": "D_design", "origin_milestone": "v6.4", "origin": "architecture p2_1", "target_version": "v6.x", "description": "v6.4 INTENT.harness_engineering_mapping = Workflow (1차) + Verification (보조) 명시되나 cascade source 자체 = § 4 끝 narrative 정전화 매트릭스 (Trace 5요소) 의 자동 동기. Workflow 본질 + Trace 영향 요소 보강 narrative."},
    {"id": "scripts-plugin-root-path-narrative", "title": "scripts/ 디렉토리 + ${CLAUDE_PLUGIN_ROOT} path narrative 보강", "trigger": "B_byproduct", "origin_milestone": "v6.4", "origin": "architecture p2_3", "target_version": "v6.x", "description": "Plugin install 환경 (~/.claude/plugins/cache/harness-meta/scripts/) 안 사용자 호출 시 path 안내 narrative 부재. claude/commands/cascade-sync.md prompt 안 ${CLAUDE_PLUGIN_ROOT} variable 활용 보강."},
    {"id": "multi-ai-collaboration-definition-stretch", "title": "다중 AI 협업 면 정의 stretch 명료화", "trigger": "D_design", "origin_milestone": "v6.4", "origin": "architecture p2_4", "target_version": "v6.x", "description": "AI Native § 7.1 '다중 AI 협업' 정의 = '여러 AI 사이' vs cascade sync 본질 = '1 AI + 1 deterministic mechanism' stretch. § 7.1 정의 자체 보강 또는 본 milestone narrative 안 explicit 보강."},
    {"id": "phase-2-archival-sub-scope-separation", "title": "phase-2 archival sub-commit 분리 candidate", "trigger": "B_byproduct", "origin_milestone": "v6.4", "origin": "architecture p2_6", "target_version": "v6.x", "description": "phase-2 안 도그푸드 + archival + VERIFY/REPORT/PROPOSE 3 본질 통합. archival 분리 sub-commit 또는 별 phase candidate. cost vs 명료성 trade-off."},
    {"id": "cascade-host-multi-expansion", "title": "cascade host multi-host 확장 (5+ host robustness)", "trigger": "B_byproduct", "origin_milestone": "v6.4", "origin": "architecture p2_7", "target_version": "v6.x", "description": "v6.4 = 1 host (root CLAUDE.md). v3.21 패턴 평균 host 분포 ~5~12 대비 최소 검증 — multi-host edge case (enumerate N + 동기 apply) 미검증. AGENTS.md + README.md + claude/CLAUDE.md 등 확장 candidate."},
    {"id": "pre-commit-latency-batched-cascade-smoke", "title": "smoke-cascade-drift.sh batched python heredoc 패턴", "trigger": "B_byproduct", "origin_milestone": "v6.4", "origin": "regression p2_1", "target_version": "v6.x", "description": "v2.1 batched python smoke 패턴 (1m33s→15.4s) 정합. cascade host 누적 5+ 시 적용 검토 — 현 1 host = 불필요."},
    {"id": "hash-collision-external-pr-extension", "title": "hash prefix 32자 확장 (외부 PR + oos_4 와 함께)", "trigger": "B_byproduct", "origin_milestone": "v6.4", "origin": "security p2_1", "target_version": "v6.x", "description": "외부 projects/<name> 확장 (oos_4) 시 의도 collision (사용자가 source 변경 + stale 인용 가린 채) 가능. hash prefix 16자 → 32자 (128 bit) 확장 candidate."},
    {"id": "active-form-korean-verb-title-retitle-v6-4", "title": "v6.4 title 'cascade 자동 동기 mechanism' Active form retitle candidate", "trigger": "D_design", "origin_milestone": "v6.4", "origin": "dictionary p2_1", "target_version": "v6.x", "description": "(3) Active form 약 — 'mechanism' 명사 종결. 대안: 'cascade 자동 동기 mechanism 도입' (22자, 동사 종결). v6.3 self P3 retitle 패턴 정합, AI 판단 위임 oos_1 정합."},
    {"id": "cascade-vs-fan-out-terminology-major-bump-candidate", "title": "'cascade' → 'fan-out' / 'broadcast' 용어 변경 (v7.0 major bump)", "trigger": "D_design", "origin_milestone": "v6.4", "origin": "dictionary p2_3", "target_version": "v7.0", "description": "'cascade' 사전 의미 ~70% (waterfall 순차 흐름 약, fan-out 본질). v3.21 패턴부터 28+ cycle 정착 = de-facto convention cost > 이득. v7.0 major bump 시 동시 검토."},
    {"id": "v6-3-narrative-cascade-hook-count-fact-correction", "title": "v6.0~v6.3 narrative 안 hook count cascade 정정 (L1 후속)", "trigger": "B_regression", "origin_milestone": "v6.4", "origin": "execute lesson l1", "target_version": "v6.x", "description": "L1 evidence — v6.3 narrative '11→12' fact mismatch. 기존 v6.0~v6.3 milestone narrative 안 hook count 정정 candidate. lightweight cascade."},
    {"id": "markdownlint-md012-pitfall-row", "title": "tests/CLAUDE.md § 흔한 함정 안 MD012 row 추가 (L2 후속)", "trigger": "B_regression", "origin_milestone": "v6.4", "origin": "execute lesson l2", "target_version": "v6.x", "description": "L2 evidence — MD012 (multiple consecutive blank lines) 회피 의무. tests/CLAUDE.md § 흔한 함정 표 안 MD032/MD049 row 와 함께 MD012 row 추가."},
    {"id": "section-6-end-spike-paragraph-cycle-5-update", "title": "ARCHITECTURE § 6 끝 spike paragraph cycle 5 evidence row 추가 (L4 후속)", "trigger": "D_design", "origin_milestone": "v6.4", "origin": "execute lesson l4", "target_version": "v6.x", "description": "L4 evidence — v5.7 spike (c) 분기 5번째 자연 발현 cycle. § 6 끝 spike paragraph 안 v6.4 evidence row 추가 narrative 정전화 (v3.21 cycle 30 candidate)."}
  ]
}
```

### PROPOSE narrative

5 관점 P2 27건 중 흡수 미실 9건 + EXECUTE lessons L1+L2+L4 후속 3건 = 12 candidate ROADMAP next_candidates[] 등재. 본 milestone scope 외 사이드 effect + 후속 candidate 명시. lightweight 모드 정책 정합 — v6.x 후속 series (v6.5 자율 발의 / v6.6 hallucination 자동 정정 / v7.0 통합) 와 직교 P2 candidate.

## SUB_MILESTONES

> 본 milestone = 단일 sub-milestone (cascade 자동 동기 mechanism 도입). 2 phase 분할 (phase-1 mechanism + smoke + cascade / phase-2 도그푸드 + archival + VERIFY/REPORT/PROPOSE 통합). 추가 sub-milestone 부재.

## 관련

- 상위 ROADMAP: [`../../ROADMAP.md`](../../ROADMAP.md)
- ARCHITECTURE § 4 cascade narrative paragraph: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- AI Native 운영 § 7.1 다중 AI 협업 면: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md)
- 직전 milestone (참조): [`../v6.3/MILESTONE.md`](../v6.3/MILESTONE.md)
- v6.0 origin (INTENT.oos_3): [`../_archive/v6.0/`](../_archive/v6.0/)
