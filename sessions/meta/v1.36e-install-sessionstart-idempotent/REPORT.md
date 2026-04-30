# meta v1.36e-install-sessionstart-idempotent — REPORT

세션 완료: 2026-04-30
직접 선행 세션:
- [`sessions/meta/v1.36b2-install-ps1-force-docs/`](../v1.36b2-install-ps1-force-docs/REPORT.md) — L1 trigger 원천
- [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/REPORT.md) — L3 PostToolUse idempotent 패턴 참조원

## 최종 결과

- 변경 파일 3종: `install.ps1` / `CLAUDE.md` / `PLAN.md+REPORT.md`
- 신규 모듈: 없음 (기존 블록 수정)
- 단위 테스트: 5/5 PASS (R1 2 + R2 3 시나리오)
- PostToolUse 회귀 smoke: 8/8 PASS

## 구현 요약

### R1 — install.ps1 statusLine idempotent

**변경 전**: `$settings.ContainsKey('statusLine')` 시 command 다를 때만 throw, 같아도 `$settings.statusLine = @{...}` 재할당 발생.

**변경 후**: `$skipStatusLine` 플래그 도입. command 동일 시 `Write-Info "statusLine 이미 등록됨 (no-op)"` + 할당 skip.

```powershell
$ourSLCommand = '$HOME/.claude/statusline/statusline.sh'
$skipStatusLine = $false
if ($settings.ContainsKey('statusLine')) {
    $existingSL = $settings.statusLine
    if ($existingSL.command -eq $ourSLCommand) {
        Write-Info "statusLine 이미 등록됨 (no-op)"; $skipStatusLine = $true
    } elseif (-not $Force) { throw "statusLine conflict" }
    else { Write-Warn "덮어쓰기" }
}
if (-not $skipStatusLine) { $settings.statusLine = @{ type='command'; command=$ourSLCommand } }
```

### R2 — install.ps1 SessionStart idempotent (핵심)

**변경 전**: `ContainsKey('SessionStart')` 시 `-Force` 없으면 무조건 throw. matcher 무관 전체 교체.

**변경 후**: PostToolUse L345-384 패턴 그대로 답습. matcher `'startup'` 단위 lookup → 동일 command = no-op / 다른 command + no-Force = throw / -Force = overwrite / 없으면 append.

3분기 완전 구현:
- `$existingSSIdx -ge 0` → command 비교 후 no-op / throw / overwrite
- `ContainsKey('SessionStart')` but startup 없음 → append (기존 entry 보존)
- key 자체 없음 → 신규 배열 생성

D3 아키텍처 주의사항 (`hooks` 초기화 라인 L326 `if (-not $settings.ContainsKey('hooks')) { $settings.hooks = @{} }`) 유지 확인.

### R3 — CLAUDE.md 주석 갱신

| 위치 | 변경 전 | 변경 후 |
|------|--------|--------|
| L47 comment | `settings.json hooks.SessionStart 이미 등록 → -Force 필수` | `settings.json 설정 idempotent (v1.36e). 파일 충돌 시만 -Force` |
| L48 command | `pwsh $HOME/harness-meta/install.ps1 -Force` | `pwsh $HOME/harness-meta/install.ps1` |
| L55 bullet | `정기 재실행 시 \`-Force\` 필수 — ... 분기 부재 (v1.36e 후속 검토)` | `정기 재실행 시 \`-Force\` 불필요 — ... 모두 idempotent no-op (v1.36e). 파일 symlink 충돌 시에만 \`-Force\` 필요` |

## 판정

| 성공 기준 | 결과 |
|---------|:----:|
| `install.ps1` 재실행 (이미 설치, -Force 없음) → "no-op" 출력 3종 | ✅ (단위 테스트 5/5) |
| `install.ps1` 재실행 (다른 command, -Force 없음) → throw | ✅ (throw 시나리오 PASS) |
| 기존 `smoke-posttooluse-hook.sh` 회귀 0 | ✅ (8/8 PASS) |
| CLAUDE.md L47, L55 갱신 | ✅ |
| install.ps1 문법 오류 0 | ✅ (SYNTAX OK) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/ericbuess/claude-code-docs` (benchmark 83.92) |
| **topic** | hooks.SessionStart / matcher 유효값 / hooks 배열 구조 / type·shell·timeout 필드 |
| **findings** | no new findings — PLAN spec verification 결과 그대로 유지 |
| **drift** | no — 구현 중 신규 spec drift 없음. R2 구조 모두 spec 정합 확인 |
| **re-verify** | Claude Code hooks spec 변경 시 (SessionStart source 타입 또는 hook command 필드 추가·제거 시) |

**Citations**:
- C1 — `hooks.SessionStart`는 배열 형식, 각 항목에 `matcher` + `hooks[]` 구조 (Source: `https://github.com/ericbuess/claude-code-docs/blob/main/docs/claude-code-on-the-web.md`)
- C2 — `matcher='startup'`은 유효한 SessionStartHookInput.source 값 (Source: `https://github.com/ericbuess/claude-code-docs/blob/main/docs/agent-sdk__typescript.md`)
- C3 — command hook 필드 `type/command/shell/timeout` 모두 유효 (Source: `https://github.com/ericbuess/claude-code-docs/blob/main/docs/hooks.md`)

## Lessons Learned

- **L1 — PostToolUse 패턴이 SessionStart에 직접 이식됨**: 변수명만 `ourMatcher`→`ourSSMatcher` 등으로 rename, 3분기 구조 그대로. 패턴 재사용성이 높아 구현이 예상보다 단순했음
- **L2 — `$skipStatusLine` 플래그는 `$skipPostToolUse`와 다른 구조**: PostToolUse는 matcher-level로 이미 분기하므로 flag 불필요. statusLine은 단일 값이라 flag 패턴이 적합 (구조 차이 인식)
- **L3 — D3 아키텍처 주의사항 유효**: `if (-not $settings.ContainsKey('hooks'))` 초기화 라인이 R2 위에 있어 NullReferenceException 방지. 신규 설치 시 반드시 필요

## 다음 후보 (보류)

| 후속 세션 | 조건 |
|---------|------|
| `v1.36b5-posttooluse-verify-stage-j` | verify.ps1/sh Stage J — PostToolUse 등록 여부 체크 추가 |
