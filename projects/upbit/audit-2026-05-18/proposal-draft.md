# Proposal Draft — upbit audit-2026-05-18 (v5.10 second call)

**생성일**: 2026-05-18
**Milestone**: harness-meta v5.10 (second call + diff + narrative drift 정정)
**대상 프로젝트**: `C:\Users\qkreh\upbit`
**audit chain**: scanner → analyzer → mapper → **proposer** (본 파일, synthesizer 정정 통합)
**정책**: READ-ONLY — 본 proposal 안 모든 항목 `status = APPLY_DEFER`. component-installer 미호출 강제 (INTENT.sc_8).

> **사용자 결정 게이트 (e3): 본 milestone 전체 REJECT 강제**
> second call 정책에 의해 즉각 apply 없음. 모든 항목은 이미 v1.17 (2026-05-14) 에서 ACCEPT ALL 완료된 상태 또는 신규 drift 정정 candidate. installer 호출 없음.

> **synthesizer 정정 note (L1 lesson origin)**: 본 파일 첫 작성 시 component-proposer agent 산출 안 v1.17 12 항목 표가 hallucination (django-migration-reviewer / ai-ready-scorer / sequential-thinking MCP 등 upbit 실제 v1.17 항목과 무관). v1.17 actual proposal-draft.md (`C:\Users\qkreh\harness-meta\projects\upbit\audit-2026-05-14\proposal-draft.md`, 511 LOC) 와 scanner-output 의 'v1.17 적용 8건 확인' fact 기반 synthesizer 정정 통합. proposer agent fact 추정 한계는 본 milestone REPORT.lessons L1 흡수.

---

## 0. Executive summary

본 second call audit (2026-05-18) 결과 **즉시 결정 필요 항목 0건**. v1.17 first call (2026-05-14) 안 12 항목 ACCEPT ALL apply 가 모두 정상 적용 확인됨 (8 CONFIRMED + 1 PARTIAL + 3 SPIKE HELD). v1.17 이후 fleet 신규 추가 3건 (harness-explore / harness-review SKILL / harness-python SKILL) 정상 적용 + 잔존 gap 4건 모두 LOW/MEDIUM 심각도 + SPIKE 5건 (S1~S4 + F4) 보류 유지. 본 milestone = read-only second call (INTENT.sc_8) → **본 proposal 전체 APPLY_DEFER + 사용자 결정 게이트 REJECT 강제**.

본 audit 의 차별점 3축:

1. **v1.17 12 항목 diff 1:1 표** (Step 1 scanner 안 1차 표 + 본 proposal 안 종합)
2. **신규 감지 5건 분류** (N1~N5: 3 fleet 완료 + 2 gap LOW)
3. **narrative drift 정정 후보 3건** (D1~D3) — v5.8 → v5.9 cascade drift + minor spec drift (`/review` bundled skill 분류)

---

## 1. v1.17 first call (2026-05-14) 12 항목 1:1 diff 표 (정확 fact)

| # | v1.17 item | 권고 결정 | 2026-05-18 status | 비고 |
|---|---|---|---|---|
| 1 | G1 `.claude-plugin/plugin.json` 신규 생성 | ACCEPT | **CONFIRMED APPLIED** | `.claude-plugin/plugin.json` v1.0.0, agents+skills 2 필드 (hooks/mcpServers 미포함 = 축소 적용, N4 gap 등재) |
| 2 | G2/F5 백업 디렉토리 2건 삭제 | ACCEPT | **CONFIRMED REMOVED** (추정) | glob 결과 부재 |
| 3 | G3 CLAUDE.md v5.0+ narrative 교체 | ACCEPT | **PARTIAL** | scanner: `claude_md_in_repo: false` — 단락 교체 적용했으나 파일 자체 부재 가능성 (A4 gap) **[v5.11 정정: HALLUCINATION cascade — scanner false 가 hallucination, 실 상태 CLAUDE.md 거주. row 3 status = CONFIRMED APPLIED (단락 교체 정상 적용 검증). A4 gap entry 무효]** |
| 4 | G4 PostToolUse mypy strict hook | SPIKE (S1+S3) | **HELD** | hook 미추가 — SPIKE 보류 유지 |
| 5 | G5/F1 `trading-safety-checker` subagent 신규 | ACCEPT | **CONFIRMED APPLIED** | `.claude-plugin/agents/trading-safety-checker.md` (sonnet, Read/Grep/Glob) |
| 6 | G6 `paper-trading-gate` subagent 신규 | ACCEPT | **CONFIRMED APPLIED** | `.claude-plugin/agents/paper-trading-gate.md` (haiku, Read/Grep) |
| 7 | G7 harness MCP tool 위치 | SPIKE (S2) | **HELD** | `.mcp.json` 운용 유지, plugin.json mcpServers 미통합 |
| 8 | G8 `quality.yml` ruff S + pip-audit 2 step | ACCEPT | **CONFIRMED APPLIED** | `quality.yml` 두 step 확인 |
| 9 | F2 `harness-verifier` CI Workflow scope | ACCEPT | **CONFIRMED APPLIED** | `harness-verifier.md` 안 "CI Workflow Verification" 단락 |
| 10 | F4 `harness-cost-tracker` (CONDITIONAL S2) | CONDITIONAL | **HELD** | S2 SPIKE 미완 → 조건부 보류 |
| 11 | F6 `harness-grey-area` ADR-021 scope | ACCEPT | **CONFIRMED APPLIED** | `harness-grey-area.md` 안 "Docker Memory Limit (ADR-021)" 단락 |
| 12 | C1 `harness-review` SKILL description 분리 | ACCEPT | **CONFIRMED APPLIED** | description = "built-in /review 보완 (upbit 특화 ADR/GUARDRAILS compliance)" |
| KEEP | C2~C6 5 SKILL 유지 | KEEP | **CONFIRMED KEPT** | 모두 `.claude-plugin/skills/` 안 존재 |

**diff 결과 요약**: 8 CONFIRMED APPLIED + 1 PARTIAL (G3) + 3 HELD (G4/G7/F4 SPIKE) = v1.17 의도대로 mechanical apply 정상 완료. **회귀 0**.

---

## 2. v1.17 이후 신규 감지 5건 (N1~N5)

### N1 — harness-explore agent 신규 (fleet evolution APPLIED)

`.claude-plugin/agents/harness-explore.md` (model=opus, Read/Glob/Grep). `/harness-plan` 전용 read-only 탐색 subagent. 기존 fleet 미커버 책임 (plan 단계 탐색). 권장 결정: **STABLE**. **APPLY_DEFER**.

### N2 — harness-review SKILL 신규 (v1.17 C1 적용 cascade APPLIED)

`.claude-plugin/skills/harness-review/SKILL.md`. bundled skill `/review` 와 보완 관계. mapper minor drift correction = `/review` 는 'built-in command' 가 아닌 **bundled skill** (`code.claude.com/docs/en/skills` §Bundled skills 명시). 권장 결정: **STABLE**. **APPLY_DEFER**.

### N3 — harness-python SKILL 신규 (fleet evolution APPLIED)

`.claude-plugin/skills/harness-python/SKILL.md`. `/doctor` 와 대상 레이어 상이 (Claude Code 인프라 vs Python 스택). 권장 결정: **STABLE**. **APPLY_DEFER**.

### N4 — plugin.json hooks/mcpServers 필드 부재 (gap, MEDIUM)

`.claude-plugin/plugin.json` 안 hooks/mcpServers 키 없음. v1.17 G1 초안 보다 축소 적용 = 글로벌 `.claude/settings.json` 의존. spec ref: `code.claude.com/docs/en/plugins-reference`. 권장 결정: **MONITOR** (S2/S3 SPIKE 해소 후 통합 결정). **APPLY_DEFER**.

### N5 — settings.local.json stale cp 명령 (gap, LOW)

`.claude/settings.local.json` allow 목록 cp 명령 3건 구 경로 (`.claude/commands/` → `.claude-plugin/`). cascade drift 유형 (v5.7 spec-drift spike 패턴 정합). 권장 결정: **CLEANUP** (별 milestone 권고). **APPLY_DEFER**.

---

## 3. 구조 이상 6건 (A1~A6)

| ID | name | severity | category | 본 milestone 결정 |
|---|---|---|---|---|
| A1 | plugin.json 필드 불완전 (= N4) | medium | plugin_manifest | APPLY_DEFER |
| A2 | settings.local.json stale cp (= N5) | low | stale_ref | APPLY_DEFER |
| A3 | session-init hook 부재 | low | hook | APPLY_DEFER (S1/S3 SPIKE 연동) |
| A4 | upbit CLAUDE.md repo root 부재 | medium | documentation | APPLY_DEFER (별 milestone 권고) **[v5.11 정정: entry 무효 — CLAUDE.md 거주 사실. scanner-output.md L77 hallucination cascade. 별 milestone 발의 = 무효]** |
| A5 | harness-meta v1.18+ milestones 미등재 | info | roadmap | 정상 상태 사실 진술 (A_user trigger 대기) |
| A6 | upbit phases v1.5 정체 | info | roadmap | 정상 상태 사실 진술 (A_user trigger 대기) |

---

## 4. SPIKE 5건 보류 유지

| ID | name | 2026-05-18 상태 |
|---|---|---|
| S1 | mypy cold-start latency | HELD 유지 |
| S2 | harness MCP server tool 위치 | HELD 유지 |
| S3 | PostToolUse stdin JSON schema | HELD 유지 |
| S4 | dispatcher 통합 중복 skill 위치 | HELD 유지 |
| F4 | harness-cost-tracker (S2 의존) | CONDITIONAL HELD 유지 |

전원 이전 상태 동일. SPIKE 수행 자체가 본 second call (read-only) scope 외.

---

## 5. Narrative drift 정정 후보 3건 (D1~D3, harness-meta scope)

### Drift #D1 — v5.8 RESEARCH (R2 + L172) 'audit-team 호출 0건' → '1건 (v1.17)' 정정 사실

- **origin**: v5.8 RESEARCH 안 1차 정정 narrative
- **v5.9 cascade drift**: PROPOSE.next_candidates#5 안 'v4.0 도입 후 호출 0건' / INTENT.out_of_scope 안 'first 시도' 재 misclassification
- **v5.10 evidence**: 본 second call = 정확히 2번째 호출 (v1.17 first + v5.10 second)
- **권장 정정 위치**: harness-meta `projects/meta/ARCHITECTURE.md` § 4 끝 (drift 수용 cluster, v5.10 DESIGN.D6 정확 문구 1차 source)
- **APPLY_DEFER**: v5.10 Stage F phase-2 안 ARCHITECTURE Edit 적용 예정 (본 proposal scope 외 — meta scope)

### Drift #D2 — v5.9 PROPOSE.next_candidates#5 'external-audit-team-first-call' 명칭 자체 drift

- **origin**: v5.9 PROPOSE 안 후속 candidate id 'first-call'
- **v5.10 evidence**: 본 second call 사실 (v1.17 first 후 두 번째)
- **권장 정정**: v5.10 milestone id = 'external-audit-team-second-call-with-diff' (이미 정전화)
- **APPLY_DEFER**: ROADMAP entry 이미 정전화 완료 (Stage A OPEN 안 v5.10 신규 entry id)

### Drift #D3 — `/review` 분류 정확화 ('built-in' → 'bundled skill')

- **origin**: v1.17 proposal-draft narrative 안 '/review built-in' 표현
- **mapper minor drift correction**: context7 `code.claude.com/docs/en/skills` §Bundled skills 명시 — `/review`, `/security-review`, `/init` 는 "A few built-in commands available through the Skill tool" 으로 분류
- **권장 정정**: v1.17 narrative 자체는 historical fact 보존 (INTENT.OOS#2). 후속 외부 적용 milestone narrative 에서 정확화.
- **APPLY_DEFER**: 별 milestone 거명만 (본 v5.10 scope 외)

---

## 6. 사용자 결정 게이트 (e3 정책 + read-only 강제)

본 proposal 전체 **APPLY_DEFER + REJECT 강제** (v5.10 INTENT.sc_8 + INTENT.OOS#1 + DESIGN.D8 정합):

- 모든 proposal 항목 (N1~N5 + A1~A6 + S1~S4 + F4 + D1~D3) = **APPLY_DEFER**
- component-installer (Step 5) **미호출** (read-only second call 강제)
- upbit repo 실 파일 변경 **0건** 강제

### 후속 milestone 거명 (PROPOSE 거명만, ROADMAP 등재 별 사용자 결정)

1. `upbit-plugin-json-hooks-mcpservers-extension` (N4/A1, S2/S3 SPIKE 해소 후)
2. `upbit-settings-local-stale-cp-cleanup` (N5/A2, cascade drift 정합)
3. `upbit-session-init-hook-implementation` (A3, S1/S3 SPIKE 해소 후)
4. ~~`upbit-claude-md-repo-root-creation` (A4, `/init` 명령 활용)~~ **[v5.11 정정: HALLUCINATION cascade — 무효 후보 (CLAUDE.md 거주). v5.11 정정 milestone 으로 흡수]**
5. `meta-review-bundled-skill-narrative-cleanup` (D3, harness-meta narrative 정확화)
6. `external-audit-team-cycle-3-call` (본 milestone 후속 evidence 누적)

---

## 7. 본 proposal vs v1.17 proposal 통계 비교

| 항목 | v1.17 (2026-05-14, first) | v5.10 (2026-05-18, second) |
|---|---|---|
| 호출 chain | 5 멤버 (installer 포함) | 4 멤버 (installer 미호출) |
| ACCEPT 적용 | 12 항목 (mechanical apply) | 0 항목 (전체 APPLY_DEFER) |
| SPIKE 보류 | 4건 (S1~S4) + 1건 조건부 (F4) | 5건 모두 보류 유지 |
| 신규 발견 | 12 항목 + 5 SPIKE | 5건 (N1~N5) + 6 구조 이상 + 3 narrative drift |
| 결정 모드 | A_user ACCEPT ALL | second call 강제 REJECT |
| LOC | 511 line | ~210 line |
| audit-2026-05-XX 디렉토리 | upbit/audit-2026-05-14/ (1 파일) | upbit/audit-2026-05-18/ (4 파일: scanner/analyzer/mapper/proposal-draft) |

본 second call 의 핵심 가치 = **v1.17 적용 사실 검증 + cascade drift 정정 + ecosystem integrator vector 운용 evidence 2 누적** (v1.17 first + v5.10 second).

---

## Summary 표

| # | Category | Name | Source case | 권장 결정 | status |
|---|---|---|---|---|---|
| 1 | fleet evolution | harness-explore APPLIED | N1 | STABLE | APPLY_DEFER |
| 2 | fleet evolution | harness-review APPLIED | N2 | STABLE | APPLY_DEFER |
| 3 | fleet evolution | harness-python APPLIED | N3 | STABLE | APPLY_DEFER |
| 4 | gap MEDIUM | plugin.json hooks/mcpServers | N4/A1 | MONITOR | APPLY_DEFER |
| 5 | gap LOW | settings.local.json stale cp | N5/A2 | CLEANUP | APPLY_DEFER |
| 6 | gap LOW | session-init hook 부재 | A3 | DEFER (SPIKE) | APPLY_DEFER |
| 7 | gap MEDIUM | upbit CLAUDE.md 부재 | A4 | PROPOSE (별 milestone) | APPLY_DEFER **[v5.11 정정: HALLUCINATION cascade — A4 entry 무효]** |
| 8 | drift fix | v5.8→v5.9 cascade narrative | D1 | APPLY in meta v5.10 phase-2 | APPLY_DEFER (upbit scope 외) |
| 9 | drift fix | v5.9 first-call 명칭 drift | D2 | 이미 정정 (v5.10 id) | APPLY_DEFER |
| 10 | minor drift | `/review` bundled skill | D3 | PROPOSE (별 milestone) | APPLY_DEFER |

**immediate_decisions_required**: 0
**전체 status**: APPLY_DEFER (second call 정책 — component-installer 미호출)

---

*component-proposer (read-only) + synthesizer 정정 통합 — apply 는 component-installer 책임. 본 milestone 은 REJECT 강제 (second call 정책, INTENT.sc_8). proposer agent fact 추정 한계 lesson = REPORT.lessons L1.*
