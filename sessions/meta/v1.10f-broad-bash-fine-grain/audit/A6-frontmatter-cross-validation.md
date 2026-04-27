# A6 — Frontmatter cross-validation

본 audit는 v1.10f scope 4 파일의 **frontmatter 전체 필드** + **추가 발견 (3 agent 콤마 위반)** + **install-project-claude 배포 동작** + **사용자 settings.json 상호작용** + **4 형식 separator 매트릭스**를 cross-validation한다. A1-A5의 단일 필드 (`allowed-tools`/`tools`) 분석을 다른 필드 + 배포 시점 + runtime 영향으로 확장.

## 1. 4 파일 frontmatter 전체 필드 inventory

| 파일 | name | description | disable-model-invocation | argument-hint | model | thinking | (allowed-)tools |
|------|------|------|:---:|:---:|:---:|:---:|:---:|
| `harness/SKILL.md` | `harness` | 디스패처 | true | `""` | sonnet | — | A1 §1 |
| `harness-run/SKILL.md` | `harness-run` | 8~9단계 | true | — | sonnet | — | A1 §2 |
| `harness-ship/SKILL.md` | `harness-ship` | 10단계 | true | — | opus | high | A1 §3 |
| `harness-verifier.md` | `harness-verifier` | Goal-backward 검증 | — | — | sonnet | — | A1 §4 |

**관찰**:
- 3 SKILL 모두 `disable-model-invocation: true` — slash UX 유지 + auto-invocation 방지 (v1.8b commands → skills 마이그레이션 결정)
- 3 SKILL `model: sonnet|opus` 명시 — 비용/품질 분리 (디스패처/run = sonnet, ship/design/plan = opus)
- 1 SKILL `thinking: high` (harness-ship만) — 10단계는 Goal-backward 검증 + REPORT + commit/push 복잡
- agent 1 (verifier) `disable-model-invocation` 부재 — agent는 description-based triggering이 정상 (slash UX 아님)
- 1 SKILL (`harness/`) `argument-hint: ""` — 빈 문자열 유지 (디스패처는 args 없음 의도)

### 인용 17 (5 필드 동시 사용 spec)

> **Source**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/command-development/README.md
> "Quick reference table of common YAML frontmatter fields used in slash commands. Each field controls specific aspects of command behavior including tool access restrictions, model selection, argument documentation, and execution mode."
> ```yaml
> description: "Review code for issues"
> allowed-tools: "Read, Bash(git:*)"
> model: "sonnet"
> argument-hint: "[pr-number] [priority]"
> disable-model-invocation: true
> ```

→ 5 필드 동시 사용은 spec 표준. 본 4 파일 모두 정합.

### 인용 18 (model 값 spec)

> **Source**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/command-development/SKILL.md
> "The `model` field allows you to specify which Claude model should be used for executing the command. It accepts a string value, typically `sonnet`, `opus`, or `haiku`."

→ 본 4 파일 model 값 (sonnet/opus) 모두 spec 정합.

### `thinking: high` 필드 (PERMISSION_PATTERN.md §11 후속 v1.10g)

- context7 docs 검색 결과 `thinking:` 필드 명시 인용 **부재** (인용 19 결정 — A6.6 §6.1)
- 추정: `thinking: high` ≡ deprecated `effort:` alias 또는 신규 필드
- 본 v1.10f scope 외 — 별도 후속 v1.10g (`v1.10g-skill-thinking-effort`) 검증 예정
- v1.10f는 `thinking: high` 필드 무변경 보존 (lint/break risk 회피)

## 2. 추가 발견 — 3 agent 콤마 separator 위반 (Layer 1B "별건" 재평가)

### v1.10d audit/A2 line 33-35 인용 (Layer 1B Layer)

```
| `_base/.claude/agents/harness-dispatcher.md:4` (subagent) | `tools: Read, Glob, Grep` | — | A1 정합 (subagent), A2 콤마 (subagent도 동일?) |
| `_base/.claude/agents/harness-explore.md:4` | 동상 | — | 동상 |
| `_base/.claude/agents/harness-grey-area.md:4` | 동상 | — | 동상 |
```

### v1.10d audit/A2 line 40 (별건 결정)

> "agent 파일 4종의 subagent `tools:` 콤마 separator는 spec 미확인 (subagent docs 별도). 본 audit 범위 외 — 별건."

### 본 v1.10f 재평가 — 인용 11 신규 (A2 §1 인용)

> **인용 11 (A2)**: github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/agent-development/SKILL.md
> ```yaml
> tools: ["Read", "Write", "Grep", "Bash"]
> ```

→ **subagent `tools:` 필드도 array 형식 권장** — v1.10d "spec 미확인" 상태 해소. 본 v1.10f가 plugin-dev docs 인용 확보 (A2 인용 11).

### 3 agent 콤마 위반 현재 상태

| 파일 | 현재 | 위반 | 본 v1.10f 처리 가능성 |
|------|------|------|------|
| `harness-dispatcher.md:4` | `tools: Read, Glob, Grep` | A2 콤마 | ✅ 가능 (Bash 없음 — 단순 콤마 → YAML list) |
| `harness-explore.md:4` | `tools: Read, Glob, Grep` | A2 콤마 | ✅ 가능 |
| `harness-grey-area.md:4` | `tools: Read, Glob, Grep` | A2 콤마 | ✅ 가능 |

→ **본 v1.10f scope 확장 검토 필요** — 사용자 결정 (Q4 추가).

### 확장 시 영향

- 변경 추가: 3 파일 frontmatter (`tools:` 콤마 → YAML list, broad Bash 없음 — 단순 형식 변환)
- audit 추가: 0 (A1-A6에 이미 설명됨)
- smoke 확장: Stage 1 (V8) + Stage 6 (Field name) 검증 파일 4 → 7
- 회귀 영향: 0 (기존 v1.10d β scope 무변경)

### 확장 거부 시

- 별도 v1.10f-2 또는 v1.10g 후속 세션 필요
- 단점: 6 agent 중 3개만 처리 → 일관성 분기 (verifier만 v1.10f, 나머지 3개 미처리)
- 장점: 본 v1.10f scope 단일 책임 유지 (broad Bash 정정만)

**권장**: 확장 (Q4 추가). 동상 동시 처리 = templates baseline 일관성 + 단일 커밋 효율 + scope creep 미발생 (audit 0 추가, smoke 1 라인 추가)

## 3. subagent isolated context safety 영향

### subagent 본질 (Anthropic docs)

- subagent = **autonomous subprocess** (A2 인용 11 출처 README): "Agents are autonomous subprocesses that handle complex, multi-step tasks **independently**"
- isolated context = main thread context 오염 안 함 + 결과만 main으로 반환
- → broad `Bash` declare가 main thread보다 안전 (isolated에서 prompt 발생 시 main UX 미간섭)

### `harness-verifier` broad Bash 안전성 분석

| 시나리오 | main thread broad Bash | subagent broad Bash | 비고 |
|---------|---|---|---|
| 우연한 destructive 명령 | 사용자 prompt 노출 | isolated context — main 미영향 | subagent가 더 안전 |
| 의도된 호출 | 정상 작동 | 정상 작동 | 동일 |
| 실패 시 영향 | main context 오염 가능 | isolated 종료 — main 미영향 | subagent 격리 |

**결론**: subagent의 broad Bash declare는 main thread보다 안전 — R4 결정 (`harness-verifier` broad 유지) 추가 정당화.

### `harness-dispatcher` (별도 subagent — main agent와 독립)

- 본문 (line 4): `tools: Read, Glob, Grep` — Bash 없음
- 디스패처 본질 (라우팅) — Bash 미사용 정합
- 본 v1.10f Q4 확장 시 콤마 → YAML list만 정정 (Bash declare 무변경)

### `harness-explore` / `harness-grey-area`

- 둘 다 read-only analytical (A1 §4와 동일 패턴 — explore는 grep 기반, grey-area는 edge case 분석)
- 본문 Bash 호출 0건 추정 (A1 §4 verifier와 동일 — read-only)
- 본 v1.10f Q4 확장 시 콤마 → YAML list만 정정

## 4. install-project-claude 배포 동작 분석

### 동작 흐름 (`bootstrap/install-project-claude.sh`)

```
1. .harness.toml 검증 (line 42)
2. _base/ template 검증 (line 47)
3. 충돌 스캔 — categories=("commands" "agents" "skills" "output-styles") (line 60)
4. Legacy cleanup --force 모드 (line 75) — harness-* 잔존 backup
5. 충돌 처리 — backup 후 덮어쓰기 (line 108)
6. 재귀 복사 — `cp -r "$item" "$DEST/$cat/"` (line 130)
```

### 본 v1.10f 변경 후 신규 프로젝트 bootstrap 시나리오

| 단계 | 동작 | 본 v1.10f 영향 |
|------|------|---|
| 1. 충돌 스캔 | `<proj>/.claude/{cat}/` 기존 파일 detect | 0 (신규 프로젝트는 `.claude/` 부재) |
| 2. cp 복사 | `cp -r _base/.claude/skills/harness/ <proj>/.claude/skills/` | **개선된 frontmatter 자동 배포** |
| 3. 결과 | 4 파일 모두 v1.10f 정정 버전 | 미래 새 프로젝트 baseline 정합 |

### 기존 deployed projects 시나리오 (T4 후행 — 본 v1.10f scope 외)

| 시나리오 | 동작 | 영향 |
|---------|------|------|
| install 미재실행 | 기존 `.claude/` 그대로 (v1.8b 시점 frontmatter) | 0 — A5 §1 시나리오 2 |
| install 재실행 (`-f`) | 충돌 backup → 덮어쓰기 | 자동 마이그레이션 ✓ — 단 사용자 custom (`harness-` 외) 보존 |
| install 재실행 (no `-f`) | 충돌 ERR + 중단 | 사용자 수동 해결 필요 |

→ T4 후행 정책: 사용자가 install 재실행으로 흡수 OR 자기 세션에서 직접 정정.

### force 모드 legacy cleanup (line 75)

```bash
# v1.9b+ — _base 카테고리 변경 시 dest에 잔존한 harness-* 파일 backup
if [ "$FORCE" -eq 1 ]; then
    for d in "$dst"/harness*; do
        [ ! -e "$src/$name" ] && mv "$d" "$backup_root/$cat/$name"
    done
fi
```

→ 본 v1.10f는 신규 카테고리 추가 0 + 신규 파일 추가 0 → legacy cleanup 무관.

## 5. 사용자 settings.json 상호작용 매트릭스

본 v1.10f 변경 후 사용자 settings.json (`<proj>/.claude/settings.json` 또는 `~/.claude/settings.json`)과의 상호작용:

### precedence 규칙 (PERMISSION_PATTERN.md §5 인용 9)

> "The `allowed-tools` field grants permission for the listed tools while the skill is active... It does not restrict which tools are available."

→ frontmatter는 **pre-approval 추가**. settings.json deny rule이 우선.

### 매트릭스 (4 가지 조합)

| frontmatter (skill) | settings.json | 결과 |
|---|---|---|
| `Bash` declare | `permissions.allow: ["Bash(git *)"]` | git auto-allow + 그 외 prompt |
| `Bash` declare | `permissions.deny: ["Bash(git push --force *)"]` | push --force 차단 + 그 외 frontmatter pre-approval |
| 없음 | `permissions.allow: ["Bash(git *)"]` | git auto-allow + 그 외 prompt |
| 없음 | `permissions.deny: ["Bash(*)"]` | 모든 Bash 차단 (frontmatter 무관) |

### 본 v1.10f 변경 영향

| 파일 | frontmatter Bash | 사용자 settings.json 영향 |
|------|---|---|
| `harness/SKILL.md` (v1.10f: 제거) | 없음 | 자동 허용 set + settings.json `allow` 의존 |
| `harness-run/SKILL.md` (v1.10f: broad 유지) | `Bash` (전체) | settings.json `deny` rule만 작동 (allow 0 필요) |
| `harness-ship/SKILL.md` (v1.10f: broad 유지) | `Bash` (전체) | 동일 |
| `harness-verifier.md` (v1.10f: broad 유지) | `Bash` (전체) | 동일 + isolated context |

→ **사용자 권한 모델**:
- 보수적 사용자: settings.json `permissions.deny: ["Bash(rm *)", "Bash(git push --force *)"]` 등 destructive 차단 권장 (PERMISSION_PATTERN.md §9 마이그레이션 가이드)
- 신뢰 사용자: settings.json 무설정 — broad `Bash` 그대로 작동

### 본 v1.10f 사용자 가이드 (PERMISSION_PATTERN.md §9 추가)

```
# 권장 사용자 settings.json (보수적 — destructive 차단)
{
  "permissions": {
    "deny": [
      "Bash(rm -rf *)",
      "Bash(git push --force *)",
      "Bash(git push -f *)",
      "Bash(git reset --hard *)",
      "Bash(git branch -D *)"
    ]
  }
}
```

→ frontmatter broad `Bash`와 settings.json `deny`의 **분담**. broad Bash = workflow 마찰 0 + deny = destructive 차단. 본 v1.10f scope 외 (사용자 환경 — PERMISSION_PATTERN.md §9 가이드 후속).

## 6. 4 형식 separator 매트릭스 (인용 7, 14, 16, 17 종합)

본 v1.10f 결정 (YAML list 채택)의 추가 evidence — 4 형식의 spec 우선순위.

### 형식 매트릭스

| # | 형식 | 예시 | spec 출처 | 권장 등급 |
|---|------|------|---|:---:|
| 1 | **YAML list** | `- Read\n  - Bash(git:*)` | 인용 7 (skills) + 인용 14 (plugin-dev) | ★★★★★ |
| 2 | **JSON-style array** | `["Read", "Bash(git:*)"]` | 인용 16 (MCP integration) + 인용 11 (agents) | ★★★★ |
| 3 | **공백 inline** | `Read Bash(git:*)` | 인용 7 (skills "space-separated") | ★★★ |
| 4 | **콤마 inline** | `Read, Bash(git:*)` | 인용 14 (plugin-dev "comma-separated") | ★★ |

### 각 형식의 trade-off

| 형식 | 가독성 | 확장성 | 모호성 | spec verbatim |
|------|:---:|:---:|:---:|:---:|
| YAML list | ★★★★★ | ★★★★★ | 0 | skills + plugin-dev |
| JSON array | ★★★ (대괄호 noise) | ★★★★ | 0 | MCP + agents |
| 공백 inline | ★★ (long line) | ★★ (entry 추가 시 line 늘어남) | 0 | skills only |
| 콤마 inline | ★★★ | ★★ | **콜론 패턴 (`Bash(git:*)`)과 충돌 가능성** | plugin-dev only |

### 콤마 separator 모호성 사례

```yaml
# 콤마 + 콜론 패턴 충돌
allowed-tools: Read, Bash(git:*), Bash(npm:*)
# 단순 split(',')는 "Bash(git" + " *)" + " Bash(npm" + " *)"로 깨질 가능성
# (lenient parser는 trim 후 처리 — 결과 영향 없을 수 있음. 그러나 spec verbatim 미보장)
```

→ YAML list가 **콜론 패턴 안전**. 본 v1.10f의 4 파일은 콜론 패턴 미사용 (broad `Bash` 또는 단순 tool 이름)이지만, **미래 확장 시 안전 default**.

### subagent의 array 형식 (인용 11)

```yaml
tools: ["Read", "Write", "Grep", "Bash"]
```

→ subagent docs는 **JSON-style array** (대괄호) 명시. 본 v1.10f의 `harness-verifier.md` 정정에서 (a) JSON array vs (b) YAML list 선택 가능.

| 형식 | `harness-verifier.md` 정정안 | 평가 |
|------|------|---|
| (a) JSON array | `tools: ["Read", "Glob", "Grep", "Bash"]` | docs verbatim |
| (b) YAML list | `tools:\n  - Read\n  - Glob\n  - Grep\n  - Bash` | 다른 3 SKILL과 일관성 |

**채택 (b)** — 일관성 우선. `tools:` 필드의 YAML list는 인용 11 docs 위반 아님 (array 형식의 alternative — YAML 표준에서 동등).

### 본 v1.10f 4 파일 정정 형식

| 파일 | 필드 | 채택 형식 | 근거 |
|------|------|---|------|
| `harness/SKILL.md` | `allowed-tools:` | YAML list | 인용 7 |
| `harness-run/SKILL.md` | `allowed-tools:` | YAML list | 인용 7 |
| `harness-ship/SKILL.md` | `allowed-tools:` | YAML list | 인용 7 |
| `harness-verifier.md` | `tools:` | YAML list | 인용 11 alternative + 일관성 |

## 7. 종합 — 추가 발견 + 결정 포인트

### 추가 발견 5건

| # | 발견 | 본 v1.10f 처리 |
|---|------|------|
| 1 | 3 agent (dispatcher/explore/grey-area) `tools:` 콤마 위반 | **Q4 사용자 결정 — 권장 확장** |
| 2 | subagent `tools:` array 형식 인용 (인용 11) | A2/A6 audit 반영 완료 |
| 3 | JSON-style array (인용 16) — MCP tool 형식 | A6 §6 매트릭스 반영 |
| 4 | subagent isolated context broad Bash safety | A6 §3 R4 추가 정당화 |
| 5 | install-project-claude `cp -r` (symlink 아님) | A5 §1 + A6 §4 정합 확인 |

### 본 v1.10f 결정 포인트 (사용자 추가 확정 필요)

**Q4 — 3 agent 콤마 separator 정정 확장 여부**:
- (a) **확장** — `harness-dispatcher.md` + `harness-explore.md` + `harness-grey-area.md` 3 agent도 `tools:` 콤마 → YAML list (Bash declare 무변경)
- (b) 본 v1.10f 4 파일 한정 — 별도 v1.10f-2 또는 v1.10g 후속

**권장 (a)**:
- 동상 동시 처리 → templates baseline 일관성 ✓
- 단일 커밋 효율 ✓
- audit 추가 0 (A6 §2 이미 분석)
- smoke 확장 미미 (Stage 1/6에 3 파일 추가)
- v1.10d Layer 1B "별건" 결정의 재평가 — A2 인용 11 spec 확보로 해소
- scope creep 미발생 (broad Bash 영역과 직교 — 단순 형식 정정만)

## 8. 관련 문서

- 본 세션 PLAN: [`../PLAN.md`](../PLAN.md)
- A1 본문 inventory: [`A1-bash-usage.md`](A1-bash-usage.md)
- A2 권위 인용: [`A2-anthropic-docs.md`](A2-anthropic-docs.md)
- A3 동적 변수: [`A3-dynamic-vars.md`](A3-dynamic-vars.md)
- A4 정책 결정: [`A4-policy-decisions.md`](A4-policy-decisions.md)
- A5 회귀 위험: [`A5-regression-risk.md`](A5-regression-risk.md)
- 5축 spec: [`../../../../bootstrap/docs/PERMISSION_PATTERN.md`](../../../../bootstrap/docs/PERMISSION_PATTERN.md)
- v1.10d Layer 1B "별건" 결정: [`../../v1.10d-bash-permission-pattern-audit/audit/A2-pattern-inventory.md`](../../v1.10d-bash-permission-pattern-audit/audit/A2-pattern-inventory.md) line 33-40
- install-project-claude.sh: [`../../../../bootstrap/install-project-claude.sh`](../../../../bootstrap/install-project-claude.sh)
- v1.10g (thinking 후속): `sessions/meta/v1.10g-skill-thinking-effort/` (예정)
