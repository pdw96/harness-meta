# A2 — Bash() 패턴 + frontmatter 5축 전수 inventory

본 audit 시점(2026-04-27) 기준 5축 (필드명 / separator / pattern / redundant / argument-fine-grain) 통합 조사.

조사 명령:

```bash
grep -rn "Bash(\|^tools:\|^allowed-tools:" ~/harness-meta --include="*.md" --include="*.json"
grep -rn "Bash(" ~/upbit/.claude/
grep -n "Bash(" ~/.claude/settings.json ~/.claude/settings.local.json
grep -n "Bash(" ~/dowon_trading/.claude/settings.json ~/price-compare/.claude/settings.json
```

## Layer 1 — harness-meta source-of-truth (S1a + S1b, 본 v1.10d 정정 대상)

### Layer 1A — frontmatter 5축 통합표 (5 파일)

| 파일 | A1 필드명 | A2 separator | A3 pattern | A4 redundant | 최종 정정 |
|------|:---------:|:------------:|:----------:|:------------:|----------|
| `claude/commands/harness-meta.md:5` (slash command) | ❌ `tools:` | ❌ 콤마 | ❌ `cmd*` (11) | ❌ ls/grep (2) | A1+A2+A3+A4 모두 |
| `_base/.claude/skills/harness-design/SKILL.md:5` | ✓ `allowed-tools:` | ❌ 콤마 | ❌ `cmd*` (1) | ❌ ls (1) | A2+A3+A4 |
| `_base/.claude/skills/harness-plan/SKILL.md:6` | ✓ `allowed-tools:` | ❌ 콤마 | ❌ `cmd*` (3) | ❌ ls/wc (2) | A2+A3+A4 |
| `_base/.claude/skills/harness-review/SKILL.md:5` | ✓ `allowed-tools:` | ❌ 콤마 | ❌ `cmd*` (1) | ❌ git read-only (1) | A2+A3+A4 |

→ **5 파일 모두 A2 separator 위반** (콤마). 1 파일 A1 필드명 추가 위반. 본 audit β scope.

### Layer 1B — 본 audit 미포함 frontmatter (참조용)

| 파일 | 필드 | 패턴 | 관찰 |
|------|------|------|------|
| `_base/.claude/skills/harness/SKILL.md:6` | `allowed-tools: Read, Glob, Grep, Bash, Edit` | `Bash` 통째 | A2 콤마 위반 + A4 broad |
| `_base/.claude/skills/harness-run/SKILL.md:5` | 동상 | 동상 | 동상 |
| `_base/.claude/skills/harness-ship/SKILL.md:5` | `allowed-tools: Read, Glob, Grep, Bash, Edit(phases/**), Write(phases/**)` | 동상 | 동상 |
| `_base/.claude/agents/harness-dispatcher.md:4` (subagent) | `tools: Read, Glob, Grep` | — | A1 정합 (subagent), A2 콤마 (subagent도 동일?) |
| `_base/.claude/agents/harness-explore.md:4` | 동상 | — | 동상 |
| `_base/.claude/agents/harness-grey-area.md:4` | 동상 | — | 동상 |
| `_base/.claude/agents/harness-verifier.md:4` | `tools: Read, Glob, Grep, Bash` | `Bash` 통째 | 동상 + Bash broad |

**Layer 1B 처리**: 발견 6 (3 SKILL의 broad `Bash`) 정정은 본 v1.10d 범위 외. **별도 후속 세션 `v1.10f-broad-bash-fine-grain` 권장** (사용자 D3-b 결정).

agent 파일 4종의 subagent `tools:` 콤마 separator는 spec 미확인 (subagent docs 별도). 본 audit 범위 외 — 별건.

### Layer 1C — 16 Bash 패턴 분류 (Layer 1A 4 파일)

| # | 파일 | 라인 | 패턴 | 자동 허용? | 정정 |
|---|------|------|------|:---------:|------|
| 1 | `harness-meta.md` | 5 | `Bash(ls*)` | ✓ ls | **제거** |
| 2 | 동일 | 5 | `Bash(mkdir*)` | ❌ | `Bash(mkdir *)` |
| 3 | 동일 | 5 | `Bash(git*)` | 부분 | `Bash(git *)` (write 명령 필요) |
| 4 | 동일 | 5 | `Bash(bash*)` | ❌ | `Bash(bash *)` |
| 5 | 동일 | 5 | `Bash(pwsh*)` | ❌ | `Bash(pwsh *)` |
| 6 | 동일 | 5 | `Bash(grep*)` | ✓ grep | **제거** |
| 7 | 동일 | 5 | `Bash(sed*)` | ❌ (write `-i`) | `Bash(sed *)` |
| 8 | 동일 | 5 | `Bash(uname*)` | ❌ | `Bash(uname *)` |
| 9 | 동일 | 5 | `Bash(mv*)` | ❌ | `Bash(mv *)` |
| 10 | 동일 | 5 | `Bash(cp*)` | ❌ | `Bash(cp *)` |
| 11 | 동일 | 5 | `Bash(rm*)` | ❌ | `Bash(rm *)` |
| 12 | `harness-design/SKILL.md` | 5 | `Bash(ls*)` | ✓ | **제거 (Bash 통째)** |
| 13 | `harness-plan/SKILL.md` | 6 | `Bash(ls*)` | ✓ | **제거** |
| 14 | 동일 | 6 | `Bash(mkdir*)` | ❌ | `Bash(mkdir *)` |
| 15 | 동일 | 6 | `Bash(wc*)` | ✓ | **제거** |
| 16 | `harness-review/SKILL.md` | 5 | `Bash(git*)` | 부분 | **제거** (review = read-only) |

→ 16 → 9 패턴 (44% 감소). `harness-meta.md`는 9건 유지 + Bash 외 5종(Read/Glob/Grep/Write/Edit) = 14 항목. design/review는 Bash 0. plan은 mkdir 1.

## Layer 2 — upbit deployed (S6, T4 후행 별도 세션 대상)

`~/upbit/.claude/skills/*/SKILL.md` (4 + 3 unmodified):

| 파일 | A1 | A2 | A3 | A4 | T4 후행 |
|------|:---:|:---:|:---:|:---:|:------:|
| `harness/SKILL.md:6` | ✓ | ❌ 콤마 | — | — Bash 통째 | install 재실행 |
| `harness-design/SKILL.md:5` | ✓ | ❌ | ❌ | ❌ ls | install 재실행 |
| `harness-plan/SKILL.md:6` | ✓ | ❌ | ❌ | ❌ ls/wc | install 재실행 |
| `harness-review/SKILL.md:5` | ✓ | ❌ | ❌ | ❌ git ro | install 재실행 |
| `harness-run/SKILL.md:5` | ✓ | ❌ | — | — | install 재실행 |
| `harness-ship/SKILL.md:5` | ✓ | ❌ | — | — | install 재실행 |
| `agents/harness-verifier.md:4` (subagent) | ✓ tools | ❌ | — | — | (subagent 별건) |

**소계**: 6 SKILL — Layer 1 정정을 install-project-claude 재실행으로 자동 마이그레이션 가능.

## Layer 3 — upbit settings.json (S6, T4 후행)

`~/upbit/.claude/settings.json` 패턴 (29 allow + 7 deny):

| # | 라인 | 패턴 | 자동허용? | 정정 후보 |
|---|-----|------|:---------:|----------|
| 1-7 | 17-23 | `Bash(git status*)`, `Bash(git diff*)`, `Bash(git log*)`, `Bash(git branch*)`, `Bash(git show*)`, `Bash(git ls-files*)`, `Bash(git rev-parse*)` | ✓ (read-only) | **제거** (redundant 7건) |
| 8-9 | 24-25 | `Bash(git add*)`, `Bash(git commit*)` | ❌ (write) | `Bash(git add *)`, `Bash(git commit *)` |
| 10 | 26 | `Bash(poetry run*)` | ❌ | `Bash(poetry run *)` |
| 11-12 | 27-28 | `Bash(python3 scripts/execute.py*)`, `Bash(python scripts/execute.py*)` | ❌ | `Bash(python3 scripts/execute.py *)`, ... |
| 13-14 | 29-30 | `Bash(python3 -m pytest*)`, `Bash(python -m pytest*)` | ❌ | `Bash(... -m pytest *)` |
| 15-18 | 31-34 | `Bash(ls*)`, `Bash(cat*)`, `Bash(pwd)`, `Bash(wc*)` | ls/cat/wc ✓ — pwd 미정의 | **제거 ls/cat/wc**, pwd 유지 (exact) |
| 19 | 35 | `Bash(mkdir*)` | ❌ | `Bash(mkdir *)` |
| 20-25 | 56-61 | `Bash(git push*)`, `Bash(git merge*)`, `Bash(git reset*)`, `Bash(git checkout main)`, `Bash(git worktree*)`, `Bash(docker*)` | ❌ | 콜론없음 → 공백. `git checkout main`은 exact 유지 |
| 26-30 | 62-66 | `Bash(poetry add*)`, `Bash(poetry remove*)`, `Bash(poetry update*)`, `Bash(npm*)`, `Bash(pip*)` | ❌ | 공백 형식 |
| (deny) | 71-77 | `Bash(rm -rf*)`, `Bash(rm -fr*)`, `Bash(git push --force*)`, `Bash(git push -f*)`, `Bash(git reset --hard*)`, `Bash(git clean -f*)`, `Bash(git branch -D*)` | argument 제약 | **fragile** — PreToolUse hook 권장 (인용 4) |

**소계**: 36 → 약 22 (38% 감소) + deny 재설계. T4 후행 `sessions/upbit/v1.2-bash-permission-update/`.

## Layer 4 — 사용자 글로벌 settings (참조 only — 변경 없음)

`~/.claude/settings.json:15-20`:

```json
"Bash(git -C:*)", "Bash(git remote:*)", "Bash(claude --version)",
"Bash(claude mcp:*)", "Bash(where gh:*)", "Bash(tasklist)"
```

`~/.claude/settings.local.json:4-10`:

```json
"Bash(npx create-next-app@latest:*)", "Bash(curl:*)", "Bash(gh:*)",
"Bash(export:*)", "Bash(git:*)", "Bash(minikube:*)", "Bash(sg docker:*)"
```

**관찰**: 이미 콜론 형식 (= 공백 형식과 등가, 정합).

## Layer 5 — 기타 프로젝트 (참조 only — 변경 없음)

`~/dowon_trading/.claude/settings.json` + `~/price-compare/.claude/settings.json`: 콜론 형식 일관 사용. 정합.

## 변화량 요약 (β scope)

| Layer | 5축 위반 | β 정정 후 | 감소 | 처리 시점 |
|-------|:-------:|:--------:|:----:|----------|
| 1 (4 파일) | 5축 모두 | 5축 모두 정정 | 패턴 16→9 | **본 v1.10d** |
| 1B (3 SKILL broad Bash) | A2 only | (별도 후속) | — | v1.10f 후속 |
| 2 (upbit deployed SKILL) | 5축 (Layer 1 미러) | install 재실행 | 자동 | T4 후행 |
| 3 (upbit settings allow) | A3 + A4 | 22 패턴 | 38% | T4 후행 |
| 3 (upbit settings deny) | A5 fragile | hook 재설계 | 정책 변경 | T4 후행 |
| 4 (글로벌 settings) | 0 | — | — | 변경 없음 |
| 5 (기타 프로젝트) | 0 | — | — | 변경 없음 |

본 v1.10d β 직접 정정: **4 파일 5축 통합** (필드명 1건 + separator 4건 + pattern 16건 + redundant 6건 + argument-fine-grain 0건).
