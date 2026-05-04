# meta v1.38-verify-posttooluse-stage-j — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/) — PostToolUse hook `post-report-write.sh` 신설 + install.ps1 등록
- [`sessions/meta/v1.37-install-docs-ssot/`](../v1.37-install-docs-ssot/) — install.ps1 / README.md 충돌 정책 SSOT 수렴

목적: verify.ps1/sh에 Stage J 추가 — PostToolUse[Edit|Write] 등록 여부 검증 (J1~J5). 부수 버그: install.ps1 hooks pattern = `session-init.sh` (exact) → `post-report-write.sh` symlink 미배포. pattern을 `*.sh`로 수정하고 Stage B도 동일 수정.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(3) `verify.ps1` + `verify.sh` + `install.ps1` = meta 100%
- **T1 경로 다수결** — S3 × 3 = meta 100%

## Scope inheritance (verbatim from ROADMAP §3-B)

**Source — `sessions/meta/ROADMAP.md` §"Out of scope (trigger 대기)" §3-B 표** (verbatim):

> `v1.36b5-posttooluse-verify-stage-j` | verify.ps1/sh Stage J — PostToolUse 등록 여부 체크 추가 | `v1.36b REPORT`

**Parsed sub-items (2)**:

1. **verify.ps1 Stage J 추가** — PostToolUse[Edit|Write] hook J1~J5 검증 (Stage I 직후, Stage G 직전)
2. **verify.sh Stage J 추가** — 동일 J1~J5 검증 (bash 구현)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| PostToolUse hook 실 실행 smoke (post-report-write.sh 동작 검증) | v1.36b에서 이미 구현 (smoke-bash-permission-pattern 8/8) |
| timeout 값(10초) 검증 | J1~J5 핵심 필드만 — timeout은 UX 유연성 허용 |
| PostToolUse dynamic invocation 테스트 | v1.36b smoke 커버 범위 |
| verify Stage K 이후 | 미정 (evidence-driven) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | PostToolUse hook configuration, settings.json hooks structure, hook matcher field |
| **findings** | see citations below |
| **drift** | no — PostToolUse hooks 구조 (matcher/type/command/shell) 정합 확인 |
| **re-verify** | PostToolUse hook spec 변경 시 (Anthropic changelog) |

**Citations**:

- C1 — settings.json `hooks.PostToolUse` 배열 구조: `[{matcher, hooks:[{type,command,shell,timeout}]}]` — 본 세션 Stage J의 J1~J5 체크 구조 근거 (Source: `code.claude.com/docs`)
- C2 — install.ps1 categories 배포 패턴이 `*.sh` glob으로 hooks 디렉토리 전체 배포해야 `post-report-write.sh`도 포함됨 — Stage B 수정 근거

## 배경

v1.36b에서 `claude/hooks/post-report-write.sh` 신설 + install.ps1에 `settings.json` PostToolUse 등록 구현.
그러나 두 가지 미완 항목 발견:

1. **install.ps1 hooks pattern 버그**: `$categories` 배열에서 hooks pattern = `'session-init.sh'` (exact match) → `post-report-write.sh`는 `claude/hooks/`에 존재하지만 `~/.claude/hooks/`로 **symlink되지 않음**. settings.json PostToolUse command가 존재하지 않는 파일을 참조하는 상태.

2. **verify Stage J 부재**: verify.ps1/sh가 PostToolUse[Edit|Write] 등록 여부를 검증하지 않음. install 후 Stage J를 통해 등록 정합성을 자동 감지해야 함.

| 파일 | 현재 상태 | 수정 |
|------|---------|-----|
| `install.ps1` hooks pattern | `'session-init.sh'` (exact — `post-report-write.sh` symlink 미배포) | `'*.sh'` |
| `verify.ps1` Stage B hooks pattern | `'session-init.sh'` (동일 문제) | `'*.sh'` |
| `verify.sh` Stage B hooks pattern | `"hooks:session-init.sh"` (동일 문제) | `"hooks:*.sh"` |
| `verify.ps1` Stage J | 없음 | J1~J5 추가 |
| `verify.sh` Stage J | 없음 | J1~J5 추가 |

## 목표

- [ ] install.ps1 hooks pattern `'session-init.sh'` → `'*.sh'`
- [ ] verify.ps1 Stage B hooks pattern 동일 수정
- [ ] verify.sh Stage B hooks pattern 동일 수정
- [ ] verify.ps1 Stage J (J1~J5) 추가 (Stage I 직후)
- [ ] verify.sh Stage J (J1~J5) 추가 (Stage I 직후)
- [ ] verify.ps1/sh header `.DESCRIPTION` / comment에 Stage J 항목 추가
- [ ] 사용자가 `pwsh ./install.ps1` 재실행 후 Stage J J1~J5 PASS 확인
- [ ] smoke 회귀 0

## 변경 대상

| 파일 | scope | 변경 내용 |
|------|------|---------|
| `install.ps1` | S3 | hooks pattern `'session-init.sh'` → `'*.sh'` (1줄) |
| `verify.ps1` | S3 | Stage B hooks pattern 수정 + `.DESCRIPTION` Stage J 항목 + Stage J J1~J5 구현 |
| `verify.sh` | S3 | Stage B hooks pattern 수정 + 헤더 Stage J 항목 + Stage J J1~J5 구현 |

## Stage J 설계 (J1~J5)

PostToolUse 구조 (settings.json 실제 값):

```json
"PostToolUse": [{
  "matcher": "Edit|Write",
  "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/post-report-write.sh", "shell": "bash", "timeout": 10}]
}]
```

| 체크 | 검증 내용 | PASS 조건 |
|------|---------|---------|
| J1 | `hooks.PostToolUse` 존재 + 비어있지 않음 | 배열 length ≥ 1 |
| J2 | `matcher = 'Edit|Write'` 항목 발견 | 배열 내 해당 entry 존재 |
| J3 | `hooks[0].command` 정확 일치 | `$HOME/.claude/hooks/post-report-write.sh` |
| J4 | `hooks[0].type == 'command'` | 정확 일치 |
| J5 | `hooks[0].shell == 'bash'` | 정확 일치 |

timeout(10) 검증 제외 — UX 유연성 허용 (Out of scope).

## 성공 기준

- [ ] `install.ps1` hooks pattern `*.sh` — `ls ~/.claude/hooks/` 에 `post-report-write.sh` 심볼릭 존재
- [ ] `verify.ps1` Stage B: `post-report-write.sh` 심볼릭 PASS
- [ ] `verify.sh` Stage B: `post-report-write.sh` 심볼릭 PASS
- [ ] `verify.ps1` Stage J J1~J5 모두 PASS (install 재실행 후)
- [ ] `verify.sh` Stage J J1~J5 모두 PASS
- [ ] 기존 smoke 회귀 0 (`bash tests/smoke-bash-permission-pattern.sh` 8/8 PASS)
- [ ] verify.ps1 기존 Stage Z/A/B/C/D/E/F/H/I PASS 유지

## 커밋 전략

```
feat(meta): verify Stage J — PostToolUse[Edit|Write] 등록 검증 + install.ps1 hooks *.sh 수정

- install.ps1: hooks pattern 'session-init.sh' → '*.sh' (post-report-write.sh symlink 배포 fix)
- verify.ps1: Stage B hooks pattern 수정 + Stage J (J1~J5) 추가 + .DESCRIPTION 갱신
- verify.sh: Stage B hooks pattern 수정 + Stage J (J1~J5) 추가 + 헤더 갱신
- 회귀 0 (smoke 8/8 PASS)
```

## 후속 분기

본 세션 완료 후 ROADMAP §3-B `v1.36b5-posttooluse-verify-stage-j` → §8 최근 완료로 이동.
