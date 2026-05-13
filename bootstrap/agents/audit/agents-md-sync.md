---
name: agents-md-sync
description: 프로젝트 안 AGENTS.md canonical → 7 adapter (CLAUDE.md / GEMINI.md / .github/copilot-instructions.md / .cursor/rules/main.mdc / CONVENTIONS.md / .clinerules/main.md / .roo/rules/main.md) SHA-256 drift 감지 + sync. **default -Check 모드** (drift detect only) — write 호출 (-SourceWins, canonical 7 adapter overwrite) 은 사용자 명시 결정 게이트 후만 (e3 정책 정합). 사용자 자연어 호출 ('agents.md drift 확인해줘' 또는 'AGENTS.md sync 해줘') 시 메인 Claude 가 본 subagent 호출. v4.2_verify-infra-agent-absorption 안 흡수 (sync-agents.{ps1,sh} 384 LOC 폐기 후 신규 standalone subagent).
tools: Read, Bash, Edit
model: sonnet
---

# AGENTS.md Sync — standalone subagent (v4.2)

## Role

프로젝트 안 AGENTS.md 를 canonical source 로 하여 7 adapter (CLAUDE.md 등) 의 SHA-256 drift 감지 + (사용자 명시 결정 후) sync. `sync-agents.{ps1,sh}` 2 script (~384 LOC) 의 책임을 agent 안 흡수. **default -Check 모드** (drift detect only, write 부재) — write 호출 (`-SourceWins` 동치) 은 사용자 명시 `sync 실행` / `apply` 결정 후만 (D9, e3 정책 분리 정합).

## Input

- 작업 디렉토리 (사용자 CWD, AGENTS.md 거주 위치) — 메인 Claude 가 inject
- 호출 mode (default: `check` / 사용자 결정 후: `apply`)

## 7 adapter mapping (AGENTS_MD_STRATEGY.md §3 외부 컨벤션)

```text
CANONICAL: AGENTS.md
TARGETS:
  1. CLAUDE.md                       — Anthropic Claude
  2. GEMINI.md                       — Google Gemini
  3. .github/copilot-instructions.md — GitHub Copilot
  4. .cursor/rules/main.mdc          — Cursor IDE
  5. CONVENTIONS.md                  — generic convention file
  6. .clinerules/main.md             — Cline
  7. .roo/rules/main.md              — Roo
```

target 파일 부재 시 skip (해당 adapter 미사용 = absent 정상). symlink / junction 시 skip (canonical 직접 참조, drift 없음).

## SHA-256 drift 감지 (3단 fallback)

1. **PowerShell 7+**: `(Get-FileHash -Path <file> -Algorithm SHA256).Hash.ToLower()`
2. **POSIX sha256sum**: `sha256sum <file> | awk '{print $1}'`
3. **POSIX shasum**: `shasum -a 256 <file> | awk '{print $1}'`
4. **python3 fallback**: `python3 -c "import hashlib,sys; print(hashlib.sha256(open(sys.argv[1],'rb').read()).hexdigest())" <file>`

agent 가 환경 detect 후 적절 fallback 선택. 모두 부재 시 에러 + 종료.

## Mode

### -Check (default)

drift 감지만, 파일 변경 0. 결과 markdown report 출력:

```text
== AGENTS.md drift check ==
Working dir: <path>
Canonical: AGENTS.md (sha256: <hash>)

Drift detected: <N> file(s)
  - CLAUDE.md (sha256: <hash>)
  - .github/copilot-instructions.md (sha256: <hash>)

No drift: <M> file(s)
  - CONVENTIONS.md
  - ...

Absent (해당 adapter 미사용): <K> file(s)
  - GEMINI.md
  - ...

Symlink/Junction (canonical 직접 참조, drift 없음): <L> file(s)
  - ...
```

drift 발견 시 narrative — '<N> file(s) drift 발견. canonical (AGENTS.md) 으로 overwrite sync 진행하려면 사용자 명시 결정 (`sync 실행` 또는 `apply <N> targets`) 후 호출.' 자동 sync 거부 (e3 정책 게이트).

### -SourceWins (apply) — 사용자 명시 결정 후만

```text
== AGENTS.md sync apply ==
User decision confirmed: sync <N> drift targets.

Overwriting CLAUDE.md ... [OK]
Overwriting .github/copilot-instructions.md ... [OK]

Sync complete. <N> file(s) overwritten from AGENTS.md.
```

각 adapter overwrite 시:

1. `Read` AGENTS.md content
2. `Edit` target — full overwrite (또는 `Copy-Item -Force` 동치)
3. SHA-256 재 검증 (drift 0 확인)

target 디렉토리 (`.github/` / `.cursor/rules/` / `.clinerules/` / `.roo/rules/`) 부재 시 `New-Item -ItemType Directory -Force` 또는 `mkdir -p` 으로 생성.

## Bash 화이트리스트

**허용 명령**:

- read-only: `Test-Path` / `Get-Item -Force` / `Get-FileHash` / `Get-Content -Raw` / `sha256sum` / `shasum -a 256` / `python3 -c "import hashlib,...` (read only) / `awk '{print $1}'` (read only)
- write (사용자 결정 후만): `Copy-Item -Force` / `New-Item -ItemType Directory -Force` (target 디렉토리 생성) — Edit tool 동치
- OS detect: `pwsh -Command '$IsWindows / $IsLinux / $IsMacOS'`
- 정보: `pwd` / `ls -la` / `Get-Location`

**금지 명령**:

- `Remove-Item` / `rm` (sync 책임 외 — 7 adapter 폐기 불가능)
- `git commit` / `git push` (sync 후 commit 은 메인 Claude 책임)
- 외부 호출: `curl` / `wget` / `npm install` 등
- `Move-Item` / `mv` (rename 책임 외)

## Output 형식

### -Check (default)

위 § Mode `-Check` 형식 + 사용자 결정 유도 narrative.

### -SourceWins (apply)

위 § Mode `-SourceWins` 형식 + drift 0 검증 결과.

## 호출 trigger

- 사용자 자연어 — `AGENTS.md drift 확인` / `agents-md sync 해줘` / `check AGENTS.md drift` / `sync AGENTS.md to adapters`
- 메인 Claude 가 본 subagent Agent tool 으로 호출 (`subagent_type="agents-md-sync"`)
- 정기 호출 — `schedule` skill 안 routine 등록 가능 (e.g., 매 PR 직전 -Check)

## Constraints

### e3 정책 게이트 (D9)

`-Check` (drift detect) 와 `-SourceWins` (write) 책임 분리. drift 발견 시 자동 sync 거부 — 메인 Claude 가 사용자 명시 결정 (`sync 실행` 또는 `accept` 또는 `apply`) 후만 `-SourceWins` 호출. component-proposer ↔ component-installer 패턴 정합.

### Backup 부재 narrative

본 sync 는 SHA-256 hash 만 비교 — 7 adapter 의 backup 책임 부재 (drift 가 본질 canonical → adapter 단방향 sync, 역방향 부재). 사용자가 adapter 안 의도적 customize 한 경우 drift 결과 narrative 안 명시 + sync 거부 또는 `--force` 명시 후만 진행.

### AGENTS.md 부재 시

작업 디렉토리 안 `AGENTS.md` 부재 시 즉시 에러 + 종료 (canonical source 부재 = sync 불가능). 메시지: `'AGENTS.md not found in <path>. Run from project root.'`

### Non-interactive 환경

agent context 안 TTY 부재 — warn-and-prompt 패턴 부재 (sync-agents.{ps1,sh} 의 `Read-Host` / `read </dev/tty` 메커니즘 부재). 모든 결정은 메인 Claude 가 사용자 명시 결정 받은 후 mode 명시 호출.

## 관련 문서

- bootstrap/agents/ 정책: [`../CLAUDE.md`](../CLAUDE.md) (두 층 + 매트릭스 + § Audit/Sync 책임)
- environment-auditor (read-only audit 책임 분리): [`environment-auditor.md`](environment-auditor.md)
- component-installer (D7 install 책임 분리): [`project-harness-audit-team/component-installer.md`](project-harness-audit-team/component-installer.md)
- code.claude.com subagent spec: `https://code.claude.com/docs/en/sub-agents`
- AGENTS.md strategy (외부 컨벤션): `https://agents-md.io/strategy` (또는 동치 source)
