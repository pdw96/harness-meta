---
id: audit-fact-verify-numeric-lookup-cycle-7-extension
title: audit-fact-verify NUMERIC_LOOKUP cycle 7 evidence 자연 확장
version: v6.14
status: in_progress
---

# v6.14 — audit-fact-verify NUMERIC_LOOKUP cycle 7 evidence 자연 확장

## INTENT

### Spec

```json
{
  "id": "audit-fact-verify-numeric-lookup-cycle-7-extension",
  "title": "audit-fact-verify NUMERIC_LOOKUP cycle 7 evidence 자연 확장",
  "goal": "v6.6 mechanism 안 NUMERIC_LOOKUP empty {} no-op fallback 의 cycle 7 v5.17 evidence (scanner-output cycle 5 line 130 JSON 형식 `claude_md_lines: 148` + `claude_md_bytes: 9158` wc -l/-c 실측) 자연 도달 시점 = 2 entry (`claude_md_lines` + `claude_md_bytes`) 자연 추가 + v6.6 mechanism context scope narrative 정전화 (round 9 finding 흡수 = 'harness-meta context 한정 cover, target project (외부 repo) context 검증 oos'). lookup callable signature 변경 부재 (v6.6 mechanism 본질 보존, round 5 결정 폐기 round 9 (Y) 회귀). round 9 finding 본질 = (a) target project (예: upbit) = harness-meta 외부 별 git repo + (b) v6.6 D10 path traversal 차단 narrative 안 REPO_ROOT prefix 검증 → 외부 path 접근 불허 = target project context 검증 자체 mechanism 불가능 → (c) v6.6 mechanism scope 본질 = 'harness-meta repo 안 fact 만 검증' 자연 한정 narrative 의무. AI Native § 7.1 '다중 AI 협업' 면 cycle 3 (v6.4 cycle 1 / v6.6 cycle 2 / v6.14 cycle 3) + v3.21 narrative 정전화 3 단계 패턴 cycle 36 self-host + v5.7 spec-drift spike 패턴 (c) 자연 발현 11번째 (context7 query 안 동치 패턴 부재 finding).",
  "success_criteria": [
    {"id": "sc_1", "description": "NUMERIC_LOOKUP 2 entry 자연 추가 (harness-meta context) — `claude_md_lines` callable = `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').splitlines())` + `claude_md_bytes` callable = `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').encode('utf-8'))`. wc -l/-c 실측 동치 cross-platform safe (Python read_text universal newlines + utf-8 encoding 명시). v6.6 BOOLEAN_LOOKUP callable signature (`Callable[[], int]`, 인자 부재) 정합 보존 (round 5 lookup signature 변경 결정 폐기 / round 9 (Y) 회귀). evidence-base 정확 매핑 (cycle 7 v5.17 scanner-output cycle 5 line 130 JSON 형식 인용 cover만, line 190-191 표 + line 203 narrative oos)."},
    {"id": "sc_2", "description": "v6.6 mechanism context scope narrative 정전화 (round 9 finding 흡수) — agents/project-harness-audit-team/CLAUDE.md Note v6.14 + projects/meta/ARCHITECTURE.md § 4 끝 #10 paragraph 본문 보강 안 'BOOLEAN/NUMERIC lookup callable scope = harness-meta repo context 한정 (REPO_ROOT 기준), target project (외부 repo 예 upbit) context 검증 oos (v6.6 D10 path traversal 차단 narrative 정합 = REPO_ROOT prefix 외부 path access 불허)' narrative 명시. v6.6/v6.9 보강 누적 3번째 (mechanism scope 본질 정전화 cycle 3)."},
    {"id": "sc_3", "description": "smoke fixture 신규 numeric-mismatch sub-dir 추가 — tests/fixtures/audit-fact-verify/numeric-mismatch/{audit-output}.md 신규 (stated value = unlikely large value 예 999999 cross-platform stable, lookup actual = harness-meta CLAUDE.md lines/bytes 실측 ≠ 999999 100% mismatch detect 보장). 기존 6 sub-dir (boolean-normal/mismatch + table-normal/mismatch + numeric-normal + empty-targets) content 보존 (lookup signature 변경 부재 정합). smoke .sh Stage 1~5 sequence 보존 + Stage 6 신규 numeric-mismatch 매핑 (expected exit 1)."},
    {"id": "sc_4", "description": "narrative cascade — agents/project-harness-audit-team/CLAUDE.md Note v6.14 추가 (NUMERIC_LOOKUP cycle 7 evidence 통합 + context scope narrative 명시) + projects/meta/ARCHITECTURE.md § 4 끝 #10 row + paragraph 본문 보강 (v6.6/v6.9 보강 누적 3번째) + CLAUDE.md root + tests/CLAUDE.md cascade marker hash 자동 갱신 (v6.4 cascade-sync mechanism 작동, cycle ≥ 2번째). CHANGELOG.md [v6.14] entry 추가 + ROADMAP archival (v6.10 OPEN stage 안 cover 완)."},
    {"id": "sc_5", "description": "회귀 0 — 기존 smoke 14 hook (pre-commit) + 신규 smoke-audit-fact-verify Stage 6 (numeric-mismatch) 모두 PASS. v6.6 mechanism signature 변경 부재 (round 9 (Y) 회귀) → consumer 일관 갱신 작업 부재 = backward compat 완전 보존. v6.4 cascade-sync mechanism 자동 동기 작동 검증."},
    {"id": "sc_6", "description": "도그푸드 — 본 milestone 산출물 (MILESTONE.md) 자체 검증 시 PASS (audit-fact-verify cycle 33 self-host). 본 milestone 안 MILESTONE.md 자체 안 BOOLEAN/NUMERIC key 인용 부재 (JSON 형식 안 `claude_md_lines` 등 key 미사용) → empty pass 자연 (audit chain context X). v6.6 도그푸드 (cycle 32 v6.6 self-host PASS evidence) 동일 본질."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "v6.6 lookup callable signature 변경 (round 5 결정 폐기)", "reason": "round 5 finding (BOOLEAN_LOOKUP REPO_ROOT vs target project context mismatch) → round 6 audit_dir parent traversal resolution → round 9 finding (target project = harness-meta 외부 repo + v6.6 D10 path traversal 차단 narrative 안 외부 path access 불허 = mechanism 자체 작동 불가능) → round 10 회귀 (Y). v6.6 mechanism 본질 변경 = scope 매우 큼 + 보안 narrative 변경 위험 + 본 mechanism 실 작동 cycle 5+ 외부 호출 0건 = evidence 부재 우선 = scope 외 결정. mechanism context scope 본질 narrative 명시 (sc_2) 으로 약점 차단."},
    {"id": "oos_2", "item": "target project (외부 repo) context 검증", "reason": "v6.6 D10 path traversal 차단 narrative 정합 = REPO_ROOT prefix 검증 → 외부 path 접근 불허. target project (예: upbit) = harness-meta 외부 별 git repo → context 검증 자체 mechanism 외 부재. 본 milestone scope = harness-meta context 만 cover narrative 명시 (sc_2) = 자기 한계 인정 자연. 외부 context 검증 mechanism 필요 시 별 milestone (scope = scanner agent.md target_project_root field 명시 + path traversal narrative 갱신)."},
    {"id": "oos_3", "item": "표/narrative 인용 형식 cover (현재 NUMERIC_PATTERN regex = JSON 형식만 매칭)", "reason": "round 2 finding F2 — cycle 7 v5.17 evidence 안 3 인용 형식 (JSON line 130 / 표 line 190-191 / backtick narrative line 203) 중 regex cover = JSON 만. 표/narrative 인용 cover 의무 = 별 mechanism (parser + cross-cell mapping logic + lookbehind/lookahead regex). cycle 8 evidence 4건 (mapper S1/S3/S4 본질 + F4 apply_path) 도 동질 후속 candidate."},
    {"id": "oos_4", "item": "cycle 9 v5.17 proposer narrative hallucination (Fleet 현황 / Fact 검증 노트)", "reason": "cycle 9 evidence = proposer 가 harness-meta repo agents/skills 명단 = upbit project fleet 잘못 표기 + mapper 본질 임의 표기. 본질 = narrative content 정확성 매핑 = LLM 추론 필요 (v6.6 oos_2 인용 method 동질). script-only 불가능 + 재귀 hallucination 위험. v6.6 oos_2 정합 후속 candidate."},
    {"id": "oos_5", "item": "PostToolUse hook 자동 trigger (Agent 호출 직후 자동 검증)", "reason": "v6.6 oos_6 정합 — 토큰 비용 폭증 + 사용자 모르는 사이 작동. `--audit` opt-in 통제 (v6.6 R2) 보존 의무. 별 milestone 안 재발의 시 mitigation narrative + opt-in 통제 본질 결정 필요."},
    {"id": "oos_6", "item": "외부 산출물 (5 관점 subagent / 외부 vector agent) hallucination 자동 detect 확장", "reason": "v6.6 oos_4 정합 — 본 milestone scope = audit chain 4 agent 산출물 한정 (smoke fixture 매핑도 audit chain 산출물 디렉토리 구조 정합). 외부 evidence 도달 시 별 milestone 자연."},
    {"id": "oos_7", "item": "NUMERIC_LOOKUP 자연 확장 5+ entry (BOOLEAN 5 host 정합 — agents_md_lines / roadmap_lines / license_lines / pre_commit_config_lines 등)", "reason": "v6.6 risk_2 narrative 'evidence-base + 확장 자연 항목만 사전 정의' 직접 정합 — 본 milestone scope = cycle 7 evidence 2 entry (claude_md_lines + claude_md_bytes) 만, BOOLEAN 5 host 정합 자연 확장은 evidence 도달 시 별 milestone (v6.6 risk_2 narrative 안 cover, 미래 cycle 안 agents_md/roadmap 등 numeric mismatch 발견 시 자연 발의)."}
  ],
  "dependencies": [
    {"id": "dep_1", "source": "pre-PLAN dialog 10 round 누적 (2026-05-21)", "purpose": "사용자 결정 source — round 1 (3)단계 본질 (literal MVP) / round 2 MVP scope (옵션 1 path:line 정확성) / round 3 evidence sample 분석 / round 4 redirect (citation method evidence cover 0% → NUMERIC_LOOKUP cycle 7 자연 확장) / round 5 finding (v6.6 BOOLEAN_LOOKUP REPO_ROOT vs target project context mismatch) / round 6 (identity 갱신 + audit_dir parent traversal) / round 7 INTENT sketch 검토 / round 8 INTENT 검토 / round 9 finding (target project = 외부 repo + path traversal 차단 narrative 안 외부 path 불허 → mechanism 자체 작동 불가능) / round 10 (Y) 회귀 + (P1) 전면 재작성. round trace = lessons_learned 안 보존 의무."},
    {"id": "dep_2", "source": "v6.6 architecture P2#1 + risk_3 mitigation narrative + ROADMAP next_candidates `audit-fact-verify-numeric-lookup-auto-trigger` entry", "purpose": "본 milestone origin — v6.6 P2#1 자동 trigger mechanism 본질은 mechanism 차원 (PostToolUse hook 또는 별 trigger), 본 milestone (v6.14) = lookup table evidence-base 자연 확장 본질. ROADMAP entry 보존 (자동 trigger 별 후속 candidate)."},
    {"id": "dep_3", "source": "cycle 7 v5.17 evidence — projects/upbit/audit-2026-05-18-cycle5/scanner-output.md line 130 (JSON) + line 190-191 (표) + line 203 (narrative)", "purpose": "evidence-base trigger 1차 source — wc -l 실측 148 (off-by-one 정정) + wc -c 실측 9158 (미측정 → 실측 가능 정정). NUMERIC_LOOKUP 2 entry (claude_md_lines + claude_md_bytes) 매핑 본질. JSON 형식 line 130 만 본 milestone cover (oos_3 정합)."},
    {"id": "dep_4", "source": "round 5 + round 9 finding audit trail — round 5 (v6.6 BOOLEAN_LOOKUP REPO_ROOT context 약점 발견) → scope 확장 결정 → round 9 (target project 외부 repo + path traversal 차단 narrative 안 외부 path 불허 → mechanism 자체 작동 불가능) → round 10 회귀 (Y)", "purpose": "본 milestone scope 결정 audit trail — pre-PLAN round 5/9 finding 가 mechanism context scope 본질 (harness-meta 한정) 정전화 origin. v6.6 mechanism 본질 변경 회피 + scope narrative 명시 자연. lessons_learned 안 round trace 흡수."},
    {"id": "dep_5", "source": "v6.6 mechanism 3 컴포넌트 hybrid (scripts/audit_fact_verify.py + agents/project-harness-audit-team/CLAUDE.md Note + tests/smoke-audit-fact-verify.sh + tests/fixtures/audit-fact-verify/ 6 sub-dir)", "purpose": "본 milestone 안 cover 컴포넌트 = (a) script NUMERIC_LOOKUP entry 추가 만 (signature 변경 부재) + (b) audit-team Note v6.14 추가 (context scope narrative) + (c) smoke fixture numeric-mismatch sub-dir 신규. 3 컴포넌트 hybrid 패턴 정합 보존."},
    {"id": "dep_6", "source": "v6.9 mismatch dict 5-step schema (capture/identify/isolate/fix/verify 6 필드)", "purpose": "보존 의무 — NUMERIC_LOOKUP 안 lookup callable raise / value mismatch 시 numeric mismatch dict 본질 보존 (`{method, capture, identify, isolate: {key, stated, actual}, fix: None, verify: None}` v6.9 schema 정합). v6.6 detect_numeric_mismatches 함수 안 NUMERIC_LOOKUP empty fallback skip logic 보존 (오직 lookup entry 존재 시만 detect 진입)."},
    {"id": "dep_7", "source": "round 9 finding — target project (예: upbit) = harness-meta 외부 별 git repo + v6.6 D10 path traversal 차단 narrative 안 REPO_ROOT prefix 검증 → 외부 path 접근 불허", "purpose": "mechanism context scope narrative 정전화 origin (sc_2) — v6.6 mechanism scope 본질 = 'harness-meta repo 안 fact 만 검증' 자연 한정 narrative 의무. ARCHITECTURE § 4 끝 #10 paragraph 안 본 narrative 흡수 + audit-team CLAUDE.md Note v6.14 안 명시."},
    {"id": "dep_8", "source": "context7 query `/websites/code_claude` 안 'subagent fact verification target project context callable lookup signature pattern' 4 source 검색 결과 — 동치 패턴 부재 (debugger subagent 5-step + subagent chain + $CLAUDE_PROJECT_DIR hook + parent_tool_use_id SDK 4 source 모두 직교)", "purpose": "v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 자연 발현 11번째 evidence — 본 milestone mechanism context scope narrative 본질이 외부 spec first-class 패턴 부재 = 자기 정전화 자연 (v6.6 D12 정합)."}
  ]
}
```

### Motivation

v6.6 mechanism (audit chain hallucination 자동 검출) 도입 후 6 cycle (v6.6~v6.13) self-host 도그푸드 진행, 실 audit chain 외부 호출 0건 (cycle 5+ stability cycle 정합). v6.6 NUMERIC_LOOKUP empty {} no-op fallback narrative 안 'evidence 도달 시 lookup 추가 PROPOSE candidate 자연' (risk_2/risk_3) → cycle 7 v5.17 scanner-output cycle 5 line 130 JSON 형식 인용 (`claude_md_lines: 148` + `claude_md_bytes: 9158` wc -l/-c 실측 정정 evidence) 자연 도달 = 본 milestone trigger.

**pre-PLAN 10 round 누적 결정 trace** (lessons_learned 흡수 의무):

1. **round 1~3** = citation method literal MVP scope precision (옵션 1 path:line 정확성) + evidence sample 분석 결정
2. **round 4** = evidence sample 분석 결과 citation method (audit chain 4 멤버) evidence cover **0/8 = 0%** → (B) NUMERIC_LOOKUP cycle 7 evidence 자연 확장 redirect. cycle 8 evidence 4건 = 표 method 후속 candidate (oos_3 정합).
3. **round 5 finding** — v6.6 BOOLEAN_LOOKUP callable `(REPO_ROOT / 'CLAUDE.md').exists()` 는 harness-meta repo context 가정. audit chain 산출물 안 인용 `claude_md_in_repo: false` (예: upbit context) 와 본질 mismatch. 우연히 본 repo 안 5 host 모두 존재 = BOOLEAN_LOOKUP actual 항상 True → scanner false hallucination 정확 detect (cycle 2 v5.11 evidence, 우연 outcome). NUMERIC_LOOKUP 추가 시 lookup actual = harness-meta CLAUDE.md lines/bytes ≠ target project 100% 발생 위험 → scope 확장 (S1) 결정 = lookup signature 변경 + target_root resolution.
4. **round 6** = scope 확장 정합 identity 갱신 (`audit-fact-verify-lookup-target-context-resolution`) + target_root resolution = `audit_dir.parent.parent` (b option).
5. **round 7~8** = INTENT sketch 검토 + RESEARCH 진입.
6. **round 9 finding** — RESEARCH 단계 안 risk_2 본질 정밀화 도중 발견: target project (예: upbit) = harness-meta **외부 별 git repo**. audit 산출물 host (`projects/upbit/`) 안 CLAUDE.md **부재** (audit 산출물 host only). `audit_dir.parent.parent` = `projects/` = CLAUDE.md **부재** → lookup actual 항상 False → scanner stated `true` = **100% false mismatch**. + v6.6 D10 path traversal 차단 narrative 안 REPO_ROOT prefix 검증 → 외부 path (`~/upbit/`) reject 의무 = **target project context 검증 자체 mechanism 불가능**.
7. **round 10 (Y) 회귀** = lookup signature 변경 폐기 (mechanism 본질 변경 + 보안 narrative 변경 위험 + evidence 부재) → mechanism context scope 본질 narrative 명시 (harness-meta context 한정, target project context oos) + NUMERIC_LOOKUP 2 entry 추가 (round 4 결정 회귀, lightweight 1-phase). (P1) 전면 재작성 = INTENT/RESEARCH 본문 round 10 정합 재구성. round 5~9 finding = lessons_learned 흡수 (audit trail 보존).

**v6.6 mechanism context scope 자기 한계 인정 의무** — round 9 finding 안 mechanism 본질 = 'harness-meta repo 안 fact 만 검증, target project (외부 repo) context oos' 자연. 본 narrative 정전화 = ARCHITECTURE § 4 끝 #10 paragraph + audit-team CLAUDE.md Note v6.14. evidence base 0 (cycle 5+ 외부 audit 호출 0건) = 자기 한계 narrative 우선 자연.

**v5.7 spec-drift spike (c) 자연 발현 11번째** — context7 query `/websites/code_claude` 안 'subagent fact verification target project context callable lookup signature' first-class 패턴 부재 (4 source 모두 직교 — debugger 5-step / subagent chain / `$CLAUDE_PROJECT_DIR` / `parent_tool_use_id`). 본 mechanism 본질이 외부 spec first-class 패턴 부재 = 자기 정전화 자연. v6.6 D12 narrative 정합 cycle 11.

**AI Native § 7.1 '다중 AI 협업' 면 cycle 3 + v3.21 narrative 정전화 cycle 36 self-host** — v6.4 (cascade-sync) cycle 1 / v6.6 (audit-fact-verify) cycle 2 / v6.14 (audit-fact-verify scope narrative 정전화) cycle 3. 본 milestone 도그푸드 = audit-fact-verify cycle 33 self-host.

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "context7 /websites/code_claude — subagent fact verification target project context callable lookup signature pattern",
      "topic": "Claude Code agent prompt spec + subagent target project context resolution + callable lookup signature 패턴",
      "findings": "Claude Code agent prompt spec 안 'subagent fact verification target project context root path callable lookup signature pattern for audit chain hallucination detection' first-class 패턴 부재. context7 query 결과 = (1) debugger subagent example (Capture/Identify/Isolate/Fix/Verify 5-step, v6.9 정합 본 mechanism 이미 흡수) + (2) subagent chain example (sequential workflow, v4.0 audit-team 정합 본 mechanism 이미 흡수) + (3) `$CLAUDE_PROJECT_DIR` env var hook context (project root reference, hook 본질 = 본 milestone oos_5 PostToolUse hook scope 외) + (4) `parent_tool_use_id` SDK 검출 patterns (본 mechanism scope 외, subagent invocation tracing) — 4 source 모두 본 milestone 'NUMERIC_LOOKUP 자연 확장 + mechanism context scope narrative 정전화' 본질과 직교.",
      "drift": "본 milestone mechanism context scope narrative (harness-meta repo 한정 cover, target project 외부 repo context oos) 가 외부 spec first-class 패턴 부재 → 자기 정전화 자연. v5.7 spec-drift spike 패턴 (c) DESIGN 즉시 정정 분기 11번째 자연 발현 (v4.2 + v5.6 + v6.2 + v6.3 + v6.4 + v6.5 + v6.6 + v6.8 + v6.9 + v6.13 + v6.14). v6.6 D12 narrative (자기 정전화 자연) 직접 정합. ARCHITECTURE § 4 끝 #10 paragraph 안 본 milestone 정합 narrative 보강 의무 (v6.6/v6.9 보강 누적 3번째)."
    }
  ],
  "codebase": {
    "affected_files": [
      "scripts/audit_fact_verify.py (edit — NUMERIC_LOOKUP 2 entry 추가 만, lookup callable signature 변경 부재 round 9 (Y) 회귀 정합, 기존 BOOLEAN_LOOKUP 5 entry signature `Callable[[], bool]` + 새 NUMERIC_LOOKUP 2 entry signature `Callable[[], int]` 동일 패턴 보존)",
      "tests/smoke-audit-fact-verify.sh (edit — Stage 6 신규 추가 numeric-mismatch fixture 매핑 + 기존 5 stage 보존)",
      "tests/fixtures/audit-fact-verify/numeric-mismatch/ (신규 sub-dir — stated value 999999 unlikely value cross-platform stable, lookup actual = harness-meta repo CLAUDE.md lines/bytes 실측 ≠ 999999 100% mismatch detect 보장 + .md 파일 1건)",
      "agents/project-harness-audit-team/CLAUDE.md (edit — Note v6.14 추가, NUMERIC_LOOKUP cycle 7 evidence 통합 narrative + mechanism context scope 본질 narrative 명시 (harness-meta repo 한정, target project 외부 repo context oos))",
      "projects/meta/ARCHITECTURE.md (edit — § 4 끝 #10 row + paragraph 본문 보강, v6.6/v6.9 보강 누적 3번째 — 'v6.14 NUMERIC_LOOKUP cycle 7 evidence + mechanism context scope narrative' enhancement)",
      "CLAUDE.md (edit, root — cascade marker hash 자동 갱신, v6.4 cascade-sync mechanism 작동)",
      "tests/CLAUDE.md (edit — cascade marker hash 자동 갱신)",
      "CHANGELOG.md (edit — [v6.14] entry 추가)",
      "projects/meta/ROADMAP.md (edit — milestones[] v6.14 status: completed + REPORT 단계 안 갱신 + entry id/title/summary round 9/10 정합 갱신)",
      "projects/meta/milestones/v6.14/MILESTONE.md (edit — VERIFY/REPORT/PROPOSE 섹션 + SUB_MILESTONES 갱신)",
      "projects/meta/milestones/v6.14/execute/phase-1.md (신규)"
    ],
    "untouched_files_explicit": [
      "scripts/cascade_sync.py / scripts/propose_next.py (v6.4/v6.5 mechanism, 독립)",
      "agents/{project-scanner,harness-gap-analyzer,claude-docs-mapper,component-proposer}.md (agent prompt 자체 = v5.18 정전화 narrative 유지, agent 내부 로직 미수정 — v6.6 oos_5 정합)",
      "agents/component-installer.md (Step 5, fact 인용 부재 = scope 외)",
      "projects/upbit/audit-*/ 7 cycle (evidence 참조 source 만, 본 milestone 안 수정 0)",
      "claude/commands/harness-meta.md (`--audit` 분기 narrative 보존 — Stage 6 sequence 안 NUMERIC_LOOKUP entry 추가는 script internal 안 absorbed, narrative 변경 부재)",
      ".pre-commit-config.yaml (smoke-audit-fact-verify hook 등재 본 milestone 안 그대로 유지 — Stage 6 신규 추가는 smoke .sh internal 안 absorbed)",
      "tests/fixtures/audit-fact-verify/boolean-normal/ + boolean-mismatch/ + table-normal/ + table-mismatch/ + numeric-normal/ + empty-targets/ 6 기존 sub-dir (lookup signature 변경 부재 = fixture content 보존 정합, round 9 (Y) 회귀 정합)"
    ],
    "current_state": "v6.6 + v6.9 mechanism 도입 후 self-host 도그푸드 6 cycle (v6.6~v6.13) 누적, 실 audit chain 외부 호출 0건 (cycle 5+ stability cycle, evidence 부재). v6.6 BOOLEAN_LOOKUP callable signature = `Callable[[], bool]` (인자 부재) + `(REPO_ROOT / '...').exists()` = harness-meta repo context 가정. NUMERIC_LOOKUP empty {} no-op fallback (cycle 0). v5.17 cycle 7 evidence (scanner-output cycle 5 line 130 JSON 형식 `claude_md_lines: 148` + `claude_md_bytes: 9158`) 자연 도달 = 매핑 부재 = 미작동.",
    "target_state": "NUMERIC_LOOKUP 안 `claude_md_lines` callable = `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').splitlines())` + `claude_md_bytes` callable = `lambda: len((REPO_ROOT / 'CLAUDE.md').read_text(encoding='utf-8').encode('utf-8'))` 2 entry 추가 (BOOLEAN_LOOKUP signature 정합 보존). smoke fixture 안 numeric-mismatch sub-dir 신규 (stated value 999999 cross-platform stable). audit-team CLAUDE.md Note v6.14 + ARCHITECTURE § 4 끝 #10 paragraph 보강 cascade (mechanism context scope narrative 정전화 = harness-meta 한정 cover + target project 외부 repo context oos). CHANGELOG [v6.14] entry."
  },
  "options": [
    {
      "id": "opt_1",
      "name": "lookup callable encoding 본질 — Python read_text(encoding='utf-8') universal newlines (CRLF→LF) vs Path.read_bytes() raw count",
      "pros_cons": "(a) read_text(encoding='utf-8') = universal newlines 자동 변환 (CRLF→LF), splitlines() len = trailing newline 무관 line list 반환, .encode('utf-8') len = LF 기준 byte count. wc -l Linux 동치 (대부분 case), wc -c Linux 동치 (LF 기준). (b) read_bytes() raw count = OS native (Windows CRLF 포함). wc -l/-c Linux 와 Windows raw 다른 값. (a) cross-platform safe 자연. evidence value (148 lines, 9158 bytes) = Linux wc 측정. (a) 정합 자연."
    },
    {
      "id": "opt_2",
      "name": "numeric-mismatch fixture stated value 본질 — unlikely large value (예: 999999) vs cycle 7 evidence value (예: 149) vs random value",
      "pros_cons": "(a) unlikely large value 999999 = cross-platform stable (어떤 actual 값과도 다를 가능 99.9%+) + 의도 명료 (test fixture 본질). (b) cycle 7 evidence value (149 stated, 148 actual) = evidence 정확 재현 but actual 측정 cross-platform 변동 위험 (Windows 안 다른 값 가능, fixture test deterministic 위배). (c) random = test deterministic 위배. (a) 정합 자연."
    },
    {
      "id": "opt_3",
      "name": "phase 분할 본질 — lightweight 1-phase vs 2-phase (mechanism + narrative)",
      "pros_cons": "(a) lightweight 1-phase = scope ~10 파일 (audit_fact_verify.py edit 1 + smoke .sh edit 1 + fixture 신규 1 + 5 narrative cascade host + REPORT 본 file) = 1 commit 자연. v6.10~v6.13 lightweight 4 cycle 누적 50% 패턴 정합. (b) 2-phase = phase-1 (script + smoke + fixture) + phase-2 (narrative cascade) = v6.6 패턴 정합. scope ~10 파일 = 1-phase 부담 적당 = (a) 자연. round 4 결정 회귀 정합."
    },
    {
      "id": "opt_4",
      "name": "5 관점 subagent 병렬 검토 적용 본질 — v6.6 정합 5 관점 (architecture/spec-drift/회귀 risk/보안/scope contract) vs lightweight inline self-review",
      "pros_cons": "(a) 5 관점 병렬 = scope 중대 본질 (v6.6 15 파일) 적용. (b) inline self-review = lightweight 정합 (v6.10~v6.13 5 파일). 본 milestone scope ~10 파일 = (a)와 (b) 사이 경계. round 9 (Y) 회귀 정합 + scope NUMERIC_LOOKUP entry 추가 + mechanism narrative 정전화 본질 = lightweight 본질 정합 자연. (b) inline self-review 자연."
    },
    {
      "id": "opt_5",
      "name": "context scope narrative 정확 표기 본질 — 'harness-meta 한정 cover' vs 'REPO_ROOT 기준 cover' vs '본 repo 안 path 만 cover'",
      "pros_cons": "(a) 'harness-meta 한정' = 본 repo 이름 명시 (직관). (b) 'REPO_ROOT 기준' = script 안 변수 명시 (기술 본질). (c) '본 repo 안 path 만' = generic 본질. v6.6 D10 path traversal narrative 안 `REPO_ROOT` 변수 인용 = (b) cross-ref 자연. mechanism context scope narrative = (a)+(b) 혼합 자연 ('harness-meta repo (REPO_ROOT 기준) context 한정')."
    },
    {
      "id": "opt_6",
      "name": "도그푸드 narrative 본질 — 본 milestone 산출물 안 자체 호출 시 작동 본질",
      "pros_cons": "본 milestone scope = script edit (NUMERIC_LOOKUP entry 추가 만) + smoke fixture 신규. 도그푸드 = (a) `python scripts/audit_fact_verify.py --dir projects/meta/milestones/v6.14/` 호출 — auto_detect_dir 안 projects/*/audit-* glob 부재 시 (audit_dir 안 audit-* 패턴 부재 = `v6.14/` 디렉토리 자체) → manual `--dir` 명시 필요. (b) MILESTONE.md 안 BOOLEAN/NUMERIC key 인용 부재 (예: JSON 형식 `claude_md_lines: 148` 등 미사용) → detect 모두 empty pass. (a)+(b) PASS 자연 (v6.6 도그푸드 cycle 32 동일 본질)."
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "risk": "cross-platform encoding — Python `Path.read_text(encoding='utf-8')` default newline=None = universal newlines (CRLF → LF 자동 변환). `splitlines()` len = trailing newline 무관 line list 반환. `.encode('utf-8')` len = LF 기준 byte count. wc -l (Linux) = `\\n` count (trailing newline 없을 시 line 누락). wc -c = byte count (raw, OS 의존 newline). 본 mechanism Python implementation = wc 동치 일부만 (cross-platform deterministic 우선).",
      "mitigation": "본 milestone 안 도그푸드 = harness-meta repo 안 CLAUDE.md 측정 만 (audit chain context X). evidence value (148 lines, 9158 bytes) 와 본 implementation 결과 정확 동치 검증은 audit chain 외부 호출 cycle 도달 시 자연 검증 (본 milestone scope 외, mechanism scope 본질 narrative 정합)."
    },
    {
      "id": "risk_2",
      "risk": "context scope narrative 명시 cascade host 검증 — audit-team CLAUDE.md Note v6.14 + ARCHITECTURE § 4 끝 #10 paragraph 보강 만으로 충분한가? root CLAUDE.md / tests/CLAUDE.md / harness-meta.md slash command 안 추가 cross-ref 필요?",
      "mitigation": "cascade host = 2 (audit-team CLAUDE.md + ARCHITECTURE § 4 끝 #10 paragraph). v6.10 단일 host 패턴 정합 (cascade host ≤ 2 = lightweight 정합). root CLAUDE.md / tests/CLAUDE.md = cascade marker hash 자동 갱신 만 (v6.4 cascade-sync mechanism 작동). slash command harness-meta.md = `--audit` 분기 narrative 변경 부재 (NUMERIC_LOOKUP entry 추가는 script internal). 2 host narrative cascade 자연."
    },
    {
      "id": "risk_3",
      "risk": "도그푸드 false mismatch 위험 — 본 milestone 산출물 (MILESTONE.md) 검증 시 audit_dir = `projects/meta/milestones/v6.14/`, NUMERIC_LOOKUP lookup actual = harness-meta CLAUDE.md (= REPO_ROOT / 'CLAUDE.md') = 본 repo 안 CLAUDE.md 측정. MILESTONE.md 안 BOOLEAN/NUMERIC key 인용 부재 = detect empty pass.",
      "mitigation": "MILESTONE.md 안 numeric/boolean key 인용 부재 검증 = `phase: 1` 등 정수 인용은 NUMERIC_LOOKUP key 매핑 부재 = skip. BOOLEAN key 인용 부재. 도그푸드 PASS 자연 (v6.6 cycle 32 동일 본질)."
    },
    {
      "id": "risk_4",
      "risk": "smoke fixture numeric-mismatch sub-dir 안 stated value 999999 보장 cross-platform stable — 만약 미래 harness-meta CLAUDE.md lines 가 999999 까지 도달 시 false negative 위험 (stated == actual). 실 가능성 매우 낮음 (현재 ~73 lines).",
      "mitigation": "stated value = 999999 (현재 lines 의 ~13000배). 미래 evidence 도달 시 fixture value 갱신 자연 (별 milestone 안 cover)."
    },
    {
      "id": "risk_5",
      "risk": "v6.9 mismatch dict 5-step schema (capture/identify/isolate/fix/verify 6 필드) 보존 — NUMERIC_LOOKUP entry 추가 후 lookup callable raise / value mismatch 시 numeric mismatch dict 본질 보존 의무.",
      "mitigation": "본 milestone 안 detect_numeric_mismatches 함수 변경 부재 (lookup table content 만 추가). v6.6 D9 + v6.9 D 안 mismatch dict schema 자동 정합 보존 (lookup entry 추가는 function logic 영향 없음)."
    }
  ]
}
```

### Findings

**핵심 source**:

1. `scripts/audit_fact_verify.py` (line 43-54) — BOOLEAN_LOOKUP 5 entry + NUMERIC_LOOKUP empty {} 현 정의. 본 milestone NUMERIC_LOOKUP 2 entry 추가 1차 source (signature 변경 부재 round 9 (Y) 회귀).
2. `projects/upbit/audit-2026-05-18-cycle5/scanner-output.md` (line 130 + 190-191 + 203) — cycle 7 v5.17 evidence 1차 source. JSON line 130 = `"claude_md_lines": 148` + `"claude_md_bytes": 9158` 인용 + 표 line 190-191 wc -l/-c 실측 narrative + line 203 backtick narrative. JSON 만 본 milestone cover (oos_3 정합).
3. `projects/meta/ARCHITECTURE.md` § 4 끝 #10 row + paragraph (line 146 + 171) — v6.6/v6.9 정전화 cascade host 1차 source. 본 milestone narrative 보강 의무 (mechanism context scope narrative 정전화, v6.6/v6.9 enhancement 누적 3번째).
4. `agents/project-harness-audit-team/CLAUDE.md` Note v6.6 narrative — 본 milestone Note v6.14 추가 위치.
5. **context7 source 안 동치 패턴 부재** — Claude Code agent spec 안 'subagent fact verification target project context callable lookup signature' first-class 패턴 0건. v5.7 spec-drift spike (c) 자연 발현 11번째.

**pre-PLAN 10 round 누적 trace** (lessons_learned 흡수 의무):

- round 1~4 = scope precision 결정 (citation method literal MVP → evidence cover 0% → NUMERIC_LOOKUP redirect)
- round 5~6 = v6.6 mechanism logical 약점 발견 (BOOLEAN_LOOKUP REPO_ROOT context) → scope 확장 (S1) → identity 갱신 + target_root resolution
- round 7~8 = INTENT sketch + INTENT 작성
- **round 9 finding** = target project 외부 repo + v6.6 D10 path traversal 차단 narrative 안 외부 path 불허 = mechanism 자체 작동 불가능 → round 10 (Y) 회귀
- round 10 = (P1) 전면 재작성 (본 RESEARCH 안 round 10 정합 재구성)

**lessons_learned candidate (RESEARCH 단계 발현)**:

- L_candidate_1: pre-PLAN round 누적 시 결정적 finding (round 5 → round 9) 가 본질 변경 trigger 가능 — round 9 finding (target project = 외부 repo) 가 round 5 scope 확장 (logical fix) 결정 자체를 폐기. (P1) 전면 재작성 패턴 lightweight 1-phase 회귀 = round 4 결정 회귀 정합. round trace 모두 보존 (audit trail).
- L_candidate_2: context7 query 안 spec-drift spike (c) 11번째 자연 발현 = v5.7 패턴 cycle 11 = ARCHITECTURE § 6 끝 spec-drift paragraph 안 cycle counter 갱신 의무 (v6.13 milestone 도그푸드 정합).
- L_candidate_3: v6.6 mechanism context scope 본질 인정 narrative 의무 = 자기 한계 인정 + 'target project 외부 repo context oos' 명시. 외부 context 검증 mechanism 필요 시 별 milestone scope (scanner agent.md target_project_root field 명시 + path traversal narrative 갱신).

## DESIGN

(Stage D 진입 시 작성)

## APPROVE

(Stage E 진입 시 작성)

## EXECUTE

phase 별 진행은 `execute/phase-{n}.md` 별책.

## VERIFY

(Stage G 진입 시 작성)

## REPORT

(Stage H 진입 시 작성)

## PROPOSE

(Stage I 진입 시 작성)

## SUB_MILESTONES

```json
{
  "version": "v6.14",
  "title": "audit-fact-verify lookup target context resolution",
  "status": "in_progress",
  "sub_milestones": []
}
```
