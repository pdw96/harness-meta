# meta v1.36e-install-sessionstart-idempotent — PLAN

세션 시작: 2026-04-30
직접 선행 세션:
- [`sessions/meta/v1.36b2-install-ps1-force-docs/`](../v1.36b2-install-ps1-force-docs/PLAN.md) — L1 trigger 원천
- [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/PLAN.md) — L3 PostToolUse idempotent 패턴 참조원

목적: `install.ps1`의 `hooks.SessionStart` 등록 분기에 idempotent no-op 추가 — 현재 SessionStart가 이미 존재하면 `-Force` 없이 항상 throw함. `statusLine`도 기존 값과 동일하면 write skip. `PostToolUse` line 370-371 패턴 답습.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S3(1) `install.ps1` + S3(1) `CLAUDE.md` = 2/2 meta
- **T1 경로 다수결** — 2/2 S3 (repo 정책·설치)
- **T2 스펙 vs 값** — hook 등록 로직 변경 = 모든 사용자에게 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/ROADMAP.md` §3-B 표** (verbatim):

> `v1.36e-install-sessionstart-idempotent` | install.ps1 SessionStart / statusLine 분기 idempotent no-op 추가 (PostToolUse line 370-371 패턴 답습). 사용자 -Force 부담 또는 자동화 환경 abort evidence | `v1.36b2 REPORT L1`, `v1.36b L3`

**Source 2 — `CLAUDE.md` L55 (verbatim)**:

> `**정기 재실행 시 `-Force` 필수** — settings.json `hooks.SessionStart` / `statusLine` / `PostToolUse[Edit|Write]` 충돌 시 idempotent no-op 분기 부재 (`v1.36e-install-sessionstart-idempotent` 후속 검토).`

**Parsed sub-items (3)**:

1. **SessionStart idempotent** — matcher 'startup' + command 동일 시 no-op (no-throw). PostToolUse line 369-384 구조 답습 (matcher-level lookup → same cmd = no-op / diff cmd = -Force required / not found = append)
2. **statusLine idempotent** — command 동일 시 write skip (no-op). 현재는 command 동일해도 `$settings.statusLine = @{...}` 재할당 발생
3. **CLAUDE.md 주석 갱신** — L47 comment + L55 `-Force 필수` / `분기 부재` 문구 → idempotent 완료 반영

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| verify.ps1/sh Stage J (PostToolUse 등록 여부 체크) | `v1.36b5-posttooluse-verify-stage-j` — 별 세션 |
| install.ps1 SessionStart 구조 유효성 smoke 신설 | evidence-driven 후속 |
| macOS/Linux install.sh 동일 패턴 적용 | `install.sh` 미존재 (bash hook은 `session-init.sh` 직접 등록 — settings.json 경유 아님) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/ericbuess/claude-code-docs` (Anthropic 공식 docs mirror, benchmark 83.92) |
| **topic** | hooks.SessionStart / matcher 유효값 / hooks 배열 구조 / type·shell·timeout 필드 |
| **findings** | see citations below |
| **drift** | no — PLAN R2의 `$ourSSEntry` 구조(`matcher`, `hooks[]`, `type='command'`, `shell='bash'`, `timeout`) 모두 현행 spec 정합. `hooks.SessionStart`는 배열(`[]`) 형식, `matcher='startup'`은 유효한 source 값 |
| **re-verify** | Claude Code hooks spec 변경 시 (SessionStart source 타입 또는 hook command 필드 추가·제거 시) |

**Citations**:
- C1 — `hooks.SessionStart`는 배열 형식(`[]`), 각 항목에 `matcher` + `hooks[]` 구조. 공식 예시: `"matcher": "startup|resume"` (Source: `https://github.com/ericbuess/claude-code-docs/blob/main/docs/claude-code-on-the-web.md`)
- C2 — `SessionStartHookInput.source` 타입 정의: `"startup" | "resume" | "clear" | "compact"` — `startup`은 유효한 matcher 값 (Source: `https://github.com/ericbuess/claude-code-docs/blob/main/docs/agent-sdk__typescript.md`)
- C3 — command hook 필드: `type='command'`(필수), `command`(필수), `shell`(`'bash'|'powershell'` 선택), `timeout`(초 단위 선택), `async`(선택) — `shell='bash'`와 `timeout=10` 모두 유효 (Source: `https://github.com/ericbuess/claude-code-docs/blob/main/docs/hooks.md`)

## 배경

### 문제

`install.ps1` 재실행 시 `settings.json`에 이미 `hooks.SessionStart`가 있으면:

```powershell
# 현재 (install.ps1 L322-329)
if ($settings.hooks.ContainsKey('SessionStart')) {
    if (-not $Force) {
        throw "settings.json hooks.SessionStart conflict"  ← -Force 없으면 항상 throw
    }
    Write-Warn "hooks.SessionStart 덮어쓰기"
}
```

→ 초기 설치 후 `install.ps1`을 재실행할 때마다 `-Force` 필수. 자동화 환경(CI, 새 기기 셋업)에서 abort 발생.

반면 **PostToolUse** (v1.36b 신설, L345-384)는 matcher-level lookup으로 already-registered = no-op:
```powershell
if ($existingCmd -eq $ourCommand) {
    Write-Info "PostToolUse[Edit|Write] 이미 등록됨 (no-op)"   ← 이미 있으면 그냥 통과
}
```

`statusLine` (L302-314)은 command 다를 때만 throw하지만, 동일해도 `$settings.statusLine = @{...}` 재할당은 여전히 발생 (write trigger).

### 목표 동작 (fix 후)

| 상황 | SessionStart | statusLine | PostToolUse |
|------|:---:|:---:|:---:|
| 신규 설치 | append | write | append |
| 재설치 (값 동일) | **no-op** | **no-op** | no-op (already) |
| 재설치 (값 다름, -Force 없음) | throw | throw | throw |
| 재설치 (값 다름, -Force) | overwrite | overwrite | overwrite |

## 변경 대상

| 파일 | scope | 변경 내용 |
|------|------|---------|
| `install.ps1` | S3 | L302-343: SessionStart + statusLine idempotent 분기 |
| `CLAUDE.md` | S3 | L47 comment + L55 `-Force 필수` / `분기 부재` 문구 갱신 |
| `sessions/meta/v1.36e-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.36e-.../REPORT.md` | meta | 완료 후 |

## 구현 상세

### R1 — install.ps1 statusLine idempotent (L302-319)

```powershell
# Before (L302-319):
if ($settings.ContainsKey('statusLine')) {
    $existing = $settings.statusLine
    $desired = '$HOME/.claude/statusline/statusline.sh'
    if ($existing.command -ne $desired) {
        if (-not $Force) { throw "statusLine conflict" }
        Write-Warn "덮어쓰기..."
    }
}
$settings.statusLine = @{ type='command'; command='$HOME/.claude/statusline/statusline.sh' }

# After (idempotent no-op):
$ourSLCommand = '$HOME/.claude/statusline/statusline.sh'
$skipStatusLine = $false
if ($settings.ContainsKey('statusLine')) {
    $existingSL = $settings.statusLine
    if ($existingSL.command -eq $ourSLCommand) {
        Write-Info "statusLine 이미 등록됨 (no-op)"
        $skipStatusLine = $true
    } elseif (-not $Force) {
        Write-Err "settings.json에 이미 statusLine.command 존재: $($existingSL.command)"
        Write-Err "글로벌 값으로 교체하려면 -Force"
        throw "settings.json statusLine conflict"
    } else {
        Write-Warn "statusLine.command 덮어쓰기 (기존: $($existingSL.command))"
    }
}
if (-not $skipStatusLine) {
    $settings.statusLine = @{ type = 'command'; command = $ourSLCommand }
}
```

### R2 — install.ps1 SessionStart idempotent (L321-343) — 핵심 변경

PostToolUse (L345-384) 구조 답습. 변수명: `$ourSSMatcher`, `$ourSSCommand`, `$ourSSEntry`, `$existingSSIdx`.

```powershell
# After (matcher-level lookup, PostToolUse 패턴):
$ourSSMatcher = 'startup'
$ourSSCommand = '$HOME/.claude/hooks/session-init.sh'
$ourSSEntry = @{
    matcher = $ourSSMatcher
    hooks   = @(@{ type='command'; command=$ourSSCommand; shell='bash'; timeout=10 })
}
$existingSSIdx = -1
if ($settings.hooks.ContainsKey('SessionStart')) {
    for ($i = 0; $i -lt $settings.hooks.SessionStart.Count; $i++) {
        if ($settings.hooks.SessionStart[$i].matcher -eq $ourSSMatcher) {
            $existingSSIdx = $i; break
        }
    }
}
if ($existingSSIdx -ge 0) {
    $existingSSCmd = $settings.hooks.SessionStart[$existingSSIdx].hooks[0].command
    if ($existingSSCmd -eq $ourSSCommand) {
        Write-Info "hooks.SessionStart[startup] 이미 등록됨 (no-op)"
    } elseif (-not $Force) {
        Write-Err "hooks.SessionStart[startup]에 이미 다른 command: $existingSSCmd. -Force로만 덮어쓰기"
        throw "settings.json hooks.SessionStart conflict"
    } else {
        Write-Warn "hooks.SessionStart[startup] 덮어쓰기 (-Force)"
        $settings.hooks.SessionStart[$existingSSIdx] = $ourSSEntry
    }
} elseif ($settings.hooks.ContainsKey('SessionStart')) {
    $settings.hooks.SessionStart += $ourSSEntry
    Write-Ok "hooks.SessionStart[startup] 추가 (기존 entry 보존)"
} else {
    $settings.hooks.SessionStart = @($ourSSEntry)
    Write-Ok "hooks.SessionStart[startup] 추가"
}
```

### R3 — CLAUDE.md 주석 갱신 (L47 + L55)

```diff
- # 레이어 변경 후 재설치 (글로벌) — settings.json hooks.SessionStart 이미 등록 → -Force 필수
+ # 레이어 변경 후 재설치 (글로벌) — settings.json 설정 idempotent (v1.36e). 파일 충돌 시만 -Force

- - `install.ps1`이 ... **정기 재실행 시 `-Force` 필수** — settings.json `hooks.SessionStart` / `statusLine` / `PostToolUse[Edit|Write]` 충돌 시 idempotent no-op 분기 부재 (`v1.36e-install-sessionstart-idempotent` 후속 검토).
+ - `install.ps1`이 ... **정기 재실행 시 `-Force` 불필요** — settings.json `hooks.SessionStart` / `statusLine` / `PostToolUse[Edit|Write]` 모두 idempotent no-op (v1.36e). 파일 symlink 충돌 시에만 `-Force` 필요.
```

## 목표 체크박스

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] 병렬 검토 (3 관점: architecture / spec-drift / scope contract)
- [ ] Plan-verify (context7 SessionStart spec)
- [ ] 사용자 PLAN 확정
- [ ] R1 — statusLine idempotent 구현
- [ ] R2 — SessionStart idempotent 구현 (핵심)
- [ ] R3 — CLAUDE.md 주석 갱신
- [ ] 검증: install.ps1 `-Force` 없이 재실행 → no-op 출력 확인
- [ ] REPORT.md 작성
- [ ] ROADMAP §8 갱신

## 성공 기준

- [ ] `install.ps1` 재실행 (이미 설치된 환경, -Force 없음) → exit 0 + "no-op" 출력 3종 (statusLine/SessionStart/PostToolUse)
- [ ] `install.ps1` 재실행 (다른 command 존재, -Force 없음) → exit 1 + error 메시지
- [ ] `install.ps1 -Force` 재실행 (다른 command 존재) → overwrite 정상
- [ ] 기존 `smoke-posttooluse-hook.sh` 회귀 0 (PostToolUse 로직 건드리지 않음)
- [ ] CLAUDE.md L47, L55 갱신 내용 반영

## 커밋 전략

단일 커밋:
```
fix(meta): install.ps1 — SessionStart/statusLine idempotent no-op (v1.36e)

- SessionStart: matcher-level lookup (PostToolUse 패턴 답습)
  startup + session-init.sh 동일 시 no-op, 다를 시 -Force required
- statusLine: 동일 command 시 write skip (no-op)
- CLAUDE.md: L47/L55 -Force 필수→불필요 주석 갱신
```

## 후속 세션

| 후속 세션 | 조건 |
|---------|------|
| `v1.36b5-posttooluse-verify-stage-j` | verify.ps1/sh Stage J 추가 (PostToolUse 등록 여부 체크) |
