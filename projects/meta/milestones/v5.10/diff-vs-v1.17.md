# diff-vs-v1.17 — v5.10 second call vs v1.17 first call

> **생성**: harness-meta v5.10 Stage F phase-2 (synthesizer)
> **input A**: `projects/upbit/audit-2026-05-14/proposal-draft.md` (v1.17, 511 LOC)
> **input B**: `projects/upbit/audit-2026-05-18/proposal-draft.md` (v5.10, ~210 LOC + 3 보조 산출물)

---

## 1. 1:1 매핑 표 (v1.17 12 항목 + KEEP)

| # | v1.17 ID | v1.17 권고 | v5.10 status | drift 여부 |
|---|---|---|---|---|
| 1 | G1 plugin.json 신규 | ACCEPT | CONFIRMED APPLIED (축소 = agents+skills 2 필드, hooks/mcpServers 미포함 N4 gap) | minor — 축소 적용 |
| 2 | G2/F5 backup 2건 삭제 | ACCEPT | CONFIRMED REMOVED (추정, glob 부재) | none |
| 3 | G3 CLAUDE.md narrative 교체 | ACCEPT | PARTIAL — 단락 교체 vs 파일 자체 부재 가능성 (A4 gap) | minor — 파일 부재 의심 |
| 4 | G4 PostToolUse mypy hook | SPIKE | HELD 유지 | none |
| 5 | G5/F1 trading-safety-checker | ACCEPT | CONFIRMED APPLIED | none |
| 6 | G6 paper-trading-gate | ACCEPT | CONFIRMED APPLIED | none |
| 7 | G7 harness MCP tool 위치 | SPIKE | HELD 유지 | none |
| 8 | G8 quality.yml ruff S + pip-audit | ACCEPT | CONFIRMED APPLIED | none |
| 9 | F2 harness-verifier CI scope | ACCEPT | CONFIRMED APPLIED | none |
| 10 | F4 harness-cost-tracker (CONDITIONAL) | CONDITIONAL | HELD (S2 미완) | none |
| 11 | F6 harness-grey-area ADR-021 | ACCEPT | CONFIRMED APPLIED | none |
| 12 | C1 harness-review description 분리 | ACCEPT | CONFIRMED APPLIED | none |
| KEEP | C2~C6 5 SKILL 유지 | KEEP | CONFIRMED KEPT | none |

**diff summary**:

- 8 CONFIRMED APPLIED (66.7%)
- 1 PARTIAL (G3) — 단락 교체 ≠ 파일 존재 보장
- 3 HELD (G4/G7/F4 SPIKE 미수행)
- 1 CONFIRMED REMOVED (G2/F5)
- 5 CONFIRMED KEPT (C2~C6)

**회귀 0** — v1.17 안 적용 완료 항목 중 후속 회귀 발견 없음.

## 2. v1.17 이후 신규 변화 (added)

### N1 — harness-explore agent 신규

- v1.17 proposal 안 부재
- v5.10 scanner 발견 — `.claude-plugin/agents/harness-explore.md` 적용 완료 (model=opus, Read/Glob/Grep)
- 분류: fleet evolution / 사용자 자율 추가

### N2 — harness-review SKILL 신규

- v1.17 proposal-draft 안 C1 = description 분리 권고만
- v5.10 scanner 발견 — `.claude-plugin/skills/harness-review/SKILL.md` 전체 신규 생성 + description 분리 적용
- 분류: fleet evolution / C1 적용 확장

### N3 — harness-python SKILL 신규

- v1.17 proposal 안 부재
- v5.10 scanner 발견 — `.claude-plugin/skills/harness-python/SKILL.md` (argument-hint, disable-model-invocation)
- 분류: fleet evolution / 사용자 자율 추가

### N4 — plugin.json 축소 적용 (hooks/mcpServers 미포함)

- v1.17 proposal-draft G1 초안 = hooks + mcpServers 필드 포함 예정
- v5.10 scanner 발견 — 실제 적용 시 agents + skills 2 필드만 (mechanical apply 시 축소)
- 분류: gap MEDIUM / S2/S3 SPIKE 해소 후 통합 결정

### N5 — settings.local.json stale cp 명령 (cascade drift)

- v1.17 안 git mv 후 cascade 갱신 누락 = settings.local.json allow 목록 cp 명령 3건 구 경로 (`.claude/commands/` → `.claude-plugin/`)
- v5.10 scanner 발견
- 분류: gap LOW / cascade drift 유형 (v5.7 spec-drift spike 패턴 정합)

## 3. v1.17 이후 신규 변화 (removed)

발견된 항목 없음. v1.17 안 적용된 12 항목 모두 보존 + 추가 component 누적만.

## 4. v1.17 이후 narrative drift (correction needed)

### D1 — v5.8 → v5.9 cascade ('audit-team 호출 0건' 재 misclassification)

- **v1.17 evidence**: audit chain 5 멤버 sequence 완전 실행 + 12 항목 ACCEPT ALL apply (commit `16722fd`, 2026-05-14)
- **v5.8 RESEARCH (R2 + L172) 1차 정정**: 'audit-team 호출 0건' → '1건 (v1.17)' + 부합도 60% → 65% upgrade
- **v5.9 cascade 누락**: PROPOSE.next_candidates#5 = 'external-audit-team-first-call' / INTENT.out_of_scope = 'first 시도' / PROPOSE rationale = 'v4.0 도입 후 호출 0건' 재 misclassification
- **v5.10 정정**: ARCHITECTURE § 4 끝 cascade drift paragraph 정전화 (phase-2 commit) + v5.10 milestone id 'external-audit-team-second-call-with-diff' 정전화 (Stage A OPEN)

### D2 — v5.9 'first-call' 명칭 자체 drift

- **origin**: v5.9 PROPOSE.next_candidates#5 id 'first-call'
- **v5.10 정정**: 본 milestone id = 'second-call-with-diff' (이미 Stage A OPEN 시 정전화)

### D3 — `/review` 분류 minor drift ('built-in command' → 'bundled skill')

- **origin**: v1.17 mapper narrative 안 '/review built-in' 표현
- **mapper correction**: context7 `code.claude.com/docs/en/skills` §Bundled skills 명시
- **v5.10 정정**: v1.17 narrative 자체는 historical 보존, 별 milestone 거명만 (본 milestone scope 외)

> **[v5.12 정정]** (audit chain hallucination cycle 3): 본 § D3 narrative 안 'mapper correction' = v5.10 audit chain claude-docs-mapper agent 의 spec 잘못된 해석 = drift cascade. context7 5 source (glossary + skills + slash-commands + whats-new + changelog) 재검증 결과 spec 정합 narrative = `/review`·`/security-review`·`/init` 는 Skill tool 안 discover + execute 가능 built-in command (fixed-logic, `code.claude.com/docs/en/skills` 명시). Bundled skill (prompt-based playbook, e.g., `/simplify`·`/batch`·`/debug`·`/loop`·`/claude-api`) 범주 아님 — 별 sub-classification, 직교. v1.17 narrative 안 '/review built-in' 표현은 spec 정합 (built-in command, fixed-logic). v5.10 mapper-output.md '/review = bundled skill' 분류가 drift origin. 정확 narrative 는 `projects/meta/milestones/v5.12/INTENT.md` + `DESIGN.md` D2.exact_text 참조.

## 5. 정량 비교 표

| 항목 | v1.17 (2026-05-14) | v5.10 (2026-05-18) | delta |
|---|---|---|---|
| audit chain 호출 멤버 | 5 (installer 포함) | 4 (installer 미호출) | -1 |
| ACCEPT 적용 항목 | 12 | 0 (전체 APPLY_DEFER) | -12 |
| SPIKE 보류 | 4 + 1 조건부 | 5 (모두 보류 유지) | 0 |
| 신규 발견 항목 | 12 + 5 SPIKE | 5 (N1~N5) + 6 구조 이상 + 3 drift | +9 |
| audit 산출물 (디렉토리 내 파일 수) | 1 (proposal-draft.md) | 4 (scanner + analyzer + mapper + proposal-draft) | +3 |
| audit 산출물 LOC | 511 | scanner 9406 B + analyzer 8778 B + mapper 13452 B + proposal-draft ~210 line | ~3.5x |
| 결정 모드 | A_user ACCEPT ALL | second call REJECT 강제 (read-only) | 정반대 |
| immediate_decisions_required | 12 → 12 apply | 0 (analyzer + proposer 일치) | -12 |

## 6. 본 diff 의 핵심 발견

1. **v1.17 적용 정합성 = 우수** (회귀 0 + 8/12 CONFIRMED + 3 SPIKE 유지)
2. **v1.17 이후 fleet 자연 진화** = 3 신규 component (harness-explore + harness-review SKILL + harness-python SKILL) 사용자 자율 추가
3. **잔존 gap 4건 = 모두 LOW/MEDIUM** (immediate action 부재)
4. **narrative cascade drift 정전화** = v5.8 → v5.9 cascade 1 cycle 사실 확정 + ARCHITECTURE § 4 끝 paragraph 정전화 (본 phase-2)
5. **proposer agent hallucination 1건 발견** (v1.17 12 항목 표 misnaming) → synthesizer 정정 (L1 lesson origin)

## 7. 후속 milestone 거명 (PROPOSE 거명만 — ROADMAP 등재 별 결정)

1. `upbit-plugin-json-hooks-mcpservers-extension` (N4)
2. `upbit-settings-local-stale-cp-cleanup` (N5)
3. `upbit-session-init-hook-implementation` (A3)
4. `upbit-claude-md-repo-root-creation` (A4)
5. `meta-review-bundled-skill-narrative-cleanup` (D3)
6. `external-audit-team-cycle-3-call` (본 milestone 후속 누적)
