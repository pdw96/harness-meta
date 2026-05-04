# meta v1.36b-postoolse-roadmap-hook — PLAN

세션 시작: 2026-04-30
직접 선행 세션: [`sessions/meta/v1.36-roadmap-unification-and-flow/`](../v1.36-roadmap-unification-and-flow/PLAN.md) — harness-roadmap-update SKILL 신설 + 8단계 흐름 형식화

목적: PostToolUse hook으로 `sessions/**/REPORT.md` Write 이벤트 감지 → Claude에게 `/harness-roadmap-update` invoke 안내 (단계 9 deterministic 강화). v1.36 Out of scope에서 분리된 후속.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1a(1) `claude/hooks/post-report-write.sh` (신규) + S3(1) `install.ps1` (PostToolUse 등록 추가) = **2/2 meta**
- **T1 경로 다수결** — S1a + S3 전부 meta scope
- **T2 스펙 vs 값** — 글로벌 hook 규약 변경 = 모든 세션에 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.36-roadmap-unification-and-flow/PLAN.md` Out of scope 표** (verbatim):

> PostToolUse hook으로 ROADMAP 자동 갱신 (REPORT.md Write 감지) | `v1.36b-postoolse-roadmap-hook` (smoke 안정 후 evidence-driven)

**Parsed sub-items (1)**:

1. **PostToolUse hook** — REPORT.md Write 이벤트 감지 → Claude에게 `/harness-roadmap-update` invoke 안내. 단계 9의 deterministic 강화.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| install.sh (macOS/Linux) PostToolUse 등록 | 현재 install.sh 부재 (install.ps1 only). macOS 사용자 발생 시 별 후속 (v1.36b2) |
| verify.sh/ps1 Stage J — PostToolUse 등록 검증 | v1.36b 완료 + smoke 안정화 후 evidence-driven |
| pre-commit hook으로 smoke-roadmap-sync 강제 | `v1.31d-precommit-roadmap-sync` (기존 후속 그대로) |
| jq 의존성 추가 | python3 fallback + grep fallback으로 충분 — 의존성 최소화 원칙 |
| **ROADMAP 강제 갱신 보장** | hook은 안내(`additionalContext`)만 — Claude가 호출 무시하면 갱신 안 됨. description trigger와 동일 한계 (deterministic ≠ 강제). 강제 보장 필요 시 PostToolUse `decision: "block"` 또는 별 mechanism (별 도메인) |
| **MultiEdit으로 REPORT.md 갱신** | matcher `Edit\|Write`로 Edit은 커버하나 MultiEdit 별 tool. v1.36b3 후속 (현 시점 evidence 0) |
| **hook 실패 silent no-op 로그 기록** | python3 + grep 양쪽 실패 시 `{}` 출력 + exit 0 (세션 흐름 보호 우선). 디버깅용 stderr 로그는 별 후속 (`v1.36b4-hook-debug-log`, evidence-driven) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | PostToolUse hook stdin JSON format / additionalContext 출력 / matcher Edit\|Write / timeout 단위 / exit code 정책 / tool_response.success 가드 |
| **findings** | see citations below |
| **drift** | no — 1차 PLAN에 4건 drift (matcher `"Write"` only / timeout 단위 / exit code 정책 / `tool_response.success` 가드) 발견 후 본 PLAN R1~R3에 정정 완료. 현 시점 spec 정합 (post-fix) |
| **re-verify** | Anthropic hook spec 변경 또는 additionalContext 동작 변경 시 |

**Citations**:

- C1 — PostToolUse hook은 stdin으로 JSON 수신. 필드 (공식 example verbatim): `session_id`, `transcript_path`, `cwd`, `permission_mode`, `hook_event_name`, `tool_name`, `tool_input` (Write/Edit 모두 `file_path` 보유), `tool_response` (Write의 경우 `{"filePath":"...", "success":true}` 형식 — `success` 필드로 실패 가드 정합), `tool_use_id`, `duration_ms` (Source: `https://code.claude.com/docs/en/hooks` PostToolUse Hook Input Example)
- C2 — hook stdout JSON `{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"..."}}` — Claude context에 문자열 추가, **without truncation** (concise 권장) (Source: `https://code.claude.com/docs/en/hooks` + `/docs/en/context-window`)
- C3 — settings.json matcher 공식 예시 4건 모두 `"Edit|Write"` regex 사용 — Edit/Write 양쪽 trigger 권장. `"Write"` only는 Edit으로 갱신하는 케이스 누락 (Source: `https://code.claude.com/docs/en/hooks` PostToolUse Configure example)
- C4 — hook timeout default **10분** (config 단위는 초). `timeout: 10`은 10초 의미 — 단순 grep+JSON echo에는 충분하나 의도 주석 권장. exit code 2는 stderr를 Claude error로 surface하지만 tool 실행은 이미 끝나서 block 못 함 → 본 hook은 exit 0 only (non-zero는 세션 흐름 노이즈) (Source: `https://code.claude.com/docs/en/hooks` + `/docs/en/hooks-guide` + `/docs/en/context-window`)

## 1. 배경

v1.36에서 `harness-roadmap-update` SKILL과 8단계 흐름을 형식화했으나, 단계 9 ("REPORT 작성 → ROADMAP 갱신") 자동 호출은 **description trigger에 의존 (opportunistic)**. Claude가 REPORT.md를 쓴 직후 SKILL 호출을 잊을 수 있음.

v1.36 SKILL 한계 §4 verbatim:
> "deterministic 자동 호출은 PostToolUse hook (v1.36b 후속)"

본 세션은 이 deterministic gap을 닫는다.

## 2. 결정

### R1 — PostToolUse hook 스크립트

**파일**: `claude/hooks/post-report-write.sh` (신규)

**동작**:

1. stdin JSON 파싱 → `tool_name` + `tool_input.file_path` + `tool_response.success` 추출
2. **가드**: `tool_response.success == true` 아니면 즉시 `{}` no-op (실패한 Write/Edit에 hook trigger 회피 — C1)
3. `tool_name in ("Write", "Edit")` && `file_path` pattern `sessions/[^/]+/[^/]+/REPORT\.md$` 매치 시
4. stdout으로 `{"hookSpecificOutput":{"hookEventName":"PostToolUse","additionalContext":"..."}}` 출력
5. `additionalContext` = Claude에게 `/harness-roadmap-update` invoke 안내 메시지 (concise — C2 "without truncation but concise" 권장 정합)
6. 나머지 경우: `{}` 출력 후 exit 0 (no-op)

**Exit code 정책 (C4)**:

- **exit 0 only** — non-zero는 stderr를 Claude error로 surface 발생 + 세션 흐름 노이즈
- python3/grep 양쪽 실패 / JSON 파싱 실패 / 매치 실패 모두 `{}` + exit 0
- exit 2는 본 hook 사용 안 함 (PostToolUse는 tool 실행 후이므로 block 효과 없음)

**JSON 파싱 전략**:

- 1순위: `python3` (신뢰성 우선 — harness-meta Python 의존 기존 존재)
- 2순위: `grep + sed` fallback (python3 미설치 환경 대비)
- 실패 시: `{}` 출력 + exit 0 (no-op, 훅 오류가 세션 흐름 블록 안 함)

**REPORT.md 패턴 설계**:

- `sessions/meta/vX.Y-{name}/REPORT.md` — meta 세션
- `sessions/<project>/vX.Y-{name}/REPORT.md` — 프로젝트 세션
- 공통 regex: `sessions/[^/]+/[^/]+/REPORT\.md$`
- Windows 경로 (`C:\...`) 대비: `/` + `\\` 양쪽 패턴 처리 (스크립트 내 path 정규화 — `tr '\\' '/'` 또는 dual regex)

**Matcher (C3)**: settings.json registration matcher = `"Edit|Write"` regex — Edit으로 REPORT.md 갱신하는 케이스도 trigger. tool 본문 분기는 hook 스크립트가 처리.

**Timeout (C4)**: `timeout: 10` (초). 공식 default는 10분이나 본 hook은 grep+JSON echo만 수행 — 10초 충분. settings.json registration에 `# 10s — single grep + JSON echo` 주석 명시.

**security**: REPORT.md path는 read-only (감지만). 메타 문자 주입 없음. additionalContext는 고정 템플릿 문자열 (사용자 입력 미포함).

### R2 — install.ps1 PostToolUse 등록 추가 (matcher-level merge)

**위치**: 기존 `hooks.SessionStart` 등록 블록 직후

**충돌 정책 (matcher-level merge — architecture WARN 반영)**:

- SessionStart는 단일 entry — 단순 abort/덮어쓰기 OK
- PostToolUse는 사용자 IDE/lint hook 사전 등록 빈도 高 — **matcher-level 병합**:
  - `matcher == "Edit|Write"` (또는 동일 정규화 형태) **and** command가 본 repo `post-report-write.sh` → 이미 등록됨, no-op
  - `matcher == "Edit|Write"` **and** 다른 command → 충돌, `-Force` 없으면 abort
  - **다른 matcher** (`"Bash"`, `"Read"` 등) → array에 append (사용자 hook 보존)

**추가 코드 (의미)**:

```powershell
# hooks.PostToolUse 필드 처리 (matcher-level merge)
if (-not $settings.hooks.ContainsKey('PostToolUse')) {
    $settings.hooks.PostToolUse = @()
}

$ourMatcher = "Edit|Write"
$ourCommand = '$HOME/.claude/hooks/post-report-write.sh'
$existingIdx = -1
for ($i = 0; $i -lt $settings.hooks.PostToolUse.Count; $i++) {
    if ($settings.hooks.PostToolUse[$i].matcher -eq $ourMatcher) {
        $existingIdx = $i
        break
    }
}

$ourEntry = @{
    matcher = $ourMatcher
    hooks   = @(
        @{
            type    = "command"
            command = $ourCommand
            shell   = "bash"
            timeout = 10
        }
    )
}

if ($existingIdx -ge 0) {
    $existingCmd = $settings.hooks.PostToolUse[$existingIdx].hooks[0].command
    if ($existingCmd -eq $ourCommand) {
        Write-Info "PostToolUse[Edit|Write] 이미 등록됨 (no-op)"
    } elseif (-not $Force) {
        Write-Err "PostToolUse[Edit|Write]에 이미 다른 command 등록: $existingCmd. -Force로만 덮어쓰기"
        throw "settings.json hooks.PostToolUse[Edit|Write] conflict"
    } else {
        Write-Warn "PostToolUse[Edit|Write] 덮어쓰기"
        $settings.hooks.PostToolUse[$existingIdx] = $ourEntry
    }
} else {
    # 다른 matcher entry는 보존, 본 entry는 array에 append
    $settings.hooks.PostToolUse += $ourEntry
    Write-Ok "PostToolUse[Edit|Write] 추가 (기존 matcher entry 보존)"
}
```

**효과**:

- 사용자가 이미 `matcher: "Bash"` PostToolUse hook 등록 시 → 그대로 보존 + 본 entry append
- 동일 matcher 충돌 시만 abort/`-Force` 분기 (사용자 hook 무차별 파괴 회피)
- idempotent — 재실행 시 본 entry 이미 등록 감지 후 no-op

### R3 — Smoke (정적 3 + dynamic 5 = 8 checks)

**`tests/smoke-posttooluse-hook.sh` 신규**:

```
Stage 1 — 정적 (3)
  ✓ claude/hooks/post-report-write.sh 존재 + executable
  ✓ install.ps1에 PostToolUse matcher-level merge 코드 존재 (grep "PostToolUse" + "Edit|Write" + "matcher-level")
  ✓ 스크립트에 python3 fallback + grep fallback 양쪽 존재

Stage 2 — Dynamic (5)
  Setup: mock JSON stdin (tool_response.success: true 포함)

  Test A — Write + REPORT.md (forward slash)
    INPUT='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/sessions/meta/v1.36b-test/REPORT.md"},"tool_response":{"success":true}}'
    ✓ OUTPUT contains "additionalContext"
    ✓ OUTPUT contains "harness-roadmap-update"

  Test B — Write + non-REPORT.md no-op
    INPUT='{"tool_name":"Write","tool_input":{"file_path":"/home/user/some/other/file.md"},"tool_response":{"success":true}}'
    ✓ OUTPUT == '{}'

  Test C — Write + REPORT.md (Windows backslash)
    INPUT='{"tool_name":"Write","tool_input":{"file_path":"C:\\\\Users\\\\qkreh\\\\harness-meta\\\\sessions\\\\meta\\\\v1.36b-test\\\\REPORT.md"},"tool_response":{"success":true}}'
    ✓ OUTPUT contains "additionalContext" (path 정규화 후 매치)

  Test D — Edit + REPORT.md (matcher Edit|Write 정합)
    INPUT='{"tool_name":"Edit","tool_input":{"file_path":"/home/user/harness-meta/sessions/meta/v1.36b-test/REPORT.md"},"tool_response":{"success":true}}'
    ✓ OUTPUT contains "additionalContext"

  Test E — Write + REPORT.md but tool_response.success: false (실패 가드)
    INPUT='{"tool_name":"Write","tool_input":{"file_path":"/home/user/harness-meta/sessions/meta/v1.36b-test/REPORT.md"},"tool_response":{"success":false}}'
    ✓ OUTPUT == '{}'  (실패한 Write에 hook trigger 안 함)
```

## 3. 변경 대상

| 경로 | 구분 | 역할 |
|------|------|------|
| `claude/hooks/post-report-write.sh` | 신규 | R1 — PostToolUse hook 스크립트 |
| `install.ps1` | 수정 | R2 — PostToolUse 등록 추가 |
| `tests/smoke-posttooluse-hook.sh` | 신규 | R3 — 정적 3 + dynamic 2 smoke |
| `sessions/meta/v1.36b-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.36b-.../REPORT.md` | meta | Stage E |

## 4. 목표

- [ ] 세션 디렉토리 생성 + PLAN.md 작성
- [ ] **사용자 진입 확인**
- [ ] Stage A — `post-report-write.sh` 신규
- [ ] Stage B — `install.ps1` PostToolUse 등록 추가
- [ ] Stage C — `smoke-posttooluse-hook.sh` (5 checks)
- [ ] Stage D — `install.ps1` 재실행 + settings.json 갱신 확인
- [ ] Stage E — REPORT.md

## 5. 성공 기준

- [ ] `claude/hooks/post-report-write.sh` 존재 + REPORT.md 감지 정합
- [ ] `install.ps1` PostToolUse 등록 코드 포함
- [ ] `smoke-posttooluse-hook.sh` 5/5 PASS
- [ ] `install.ps1` 재실행 → `~/.claude/settings.json`에 `hooks.PostToolUse` 추가됨
- [ ] 기존 smoke 회귀 0

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.36b — PostToolUse hook: REPORT.md Write → harness-roadmap-update invoke 안내

- add: claude/hooks/post-report-write.sh (R1 — Write 감지 + additionalContext JSON 출력)
- update: install.ps1 (R2 — hooks.PostToolUse 등록 + 충돌 정책)
- add: tests/smoke-posttooluse-hook.sh (R3 — 정적 3 + dynamic 2 = 5/5 PASS)
- add: sessions/meta/v1.36b-postoolse-roadmap-hook/{PLAN,REPORT}.md

단계 9 deterministic 강화: description trigger (opportunistic) → PostToolUse hook (deterministic).
python3 fallback + grep fallback 이중 JSON 파싱. Windows 경로 (/ + \\) 양쪽 처리.
회귀 0 — 기존 SessionStart + mindvault hook 영향 없음.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `v1.36b2-install-sh-posttooluse` | macOS/Linux install.sh 신설 시 PostToolUse 등록 추가 |
| `v1.36b3-multiedit-trigger` | MultiEdit으로 REPORT.md 갱신 evidence 발생 시. matcher 확장 또는 별 hook |
| `v1.36b4-hook-debug-log` | 디버깅 시 python3/grep 양쪽 실패 silent no-op이 문제 evidence 발생 시. stderr 로그 추가 |
| `v1.36b5-multi-posttooluse-merge` | 다중 PostToolUse hook (lint + REPORT 등) 동시 사용 시 matcher 충돌 패턴 정형화 |
| `v1.31d-precommit-roadmap-sync` | pre-commit hook으로 smoke-roadmap-sync 강제 |
| Stage J verify — PostToolUse 등록 검증 | verify.ps1/sh에 PostToolUse hook 등록 여부 체크 추가 (evidence-driven) |

## 8. Status

**State**: 🔄 in-progress @ 2026-04-30
**Blocked-by**: ~~`v1.36d-skill-resync`~~ ✅ 해결됨 (5 skill 모두 2단계 symlink 정상)
**Current**: 단계 8 구현 진행 중 — Stage A/B/C 완료, Stage D(install.ps1 재실행) 대기
