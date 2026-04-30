# meta v1.36b-postoolse-roadmap-hook — REPORT

세션 종료: 2026-04-30
직접 선행 세션: [`sessions/meta/v1.36-roadmap-unification-and-flow/`](../v1.36-roadmap-unification-and-flow/)

## 최종 결과

| 항목 | 값 |
|------|---|
| 신규 파일 | 3 (`post-report-write.sh`, `smoke-posttooluse-hook.sh`, REPORT.md) |
| 수정 파일 | 2 (`install.ps1`, PLAN.md 상태 갱신) |
| smoke 결과 | 8/8 PASS (신규) + 88/88 + 149/149 회귀 0 |
| settings.json | `hooks.PostToolUse[Edit|Write]` 추가 확인 |

## 구현 요약

### Stage A — `claude/hooks/post-report-write.sh` 신규

- python3 1순위 + grep+sed fallback 2순위 이중 JSON 파싱
- `tool_response.success == true` 가드 (C1 정합)
- `Write|Edit` × `sessions/[^/]+/[^/]+/REPORT\.md$` 패턴 매치
- Windows 경로(`\`) → forward slash 정규화 후 매치
- 모든 exit path = exit 0 (세션 흐름 보호)
- `additionalContext`: `/harness-roadmap-update` invoke 안내 concise 메시지 (C2 정합)

### Stage B — `install.ps1` PostToolUse 등록

- SessionStart 섹션 직후에 matcher-level merge 코드 추가
- 동일 matcher(`Edit|Write`) 이미 등록 시 idempotent no-op
- 다른 matcher entry 보존 (사용자 hook 무차별 파괴 회피)
- `-Force` 없이 충돌 시 abort + 명시 에러

### Stage C — `tests/smoke-posttooluse-hook.sh` 신규

정적 3 + dynamic 5 = **8/8 PASS**:
- Static S1: hook 파일 존재 + executable
- Static S2: install.ps1 PostToolUse 코드 grep
- Static S3: python3 fallback + grep fallback 양쪽 존재
- Dynamic A: Write + REPORT.md (forward slash) → `additionalContext` 포함
- Dynamic B: Write + non-REPORT.md → `{}`
- Dynamic C: Write + REPORT.md (Windows backslash) → `additionalContext`
- Dynamic D: Edit + REPORT.md → `additionalContext`
- Dynamic E: Write + REPORT.md + success:false → `{}` (실패 가드)

### Stage D — install.ps1 재실행 + 검증

`pwsh install.ps1 -Force` 실행 결과:
- `PostToolUse[Edit|Write] 추가 (기존 matcher entry 보존)`
- `settings.json 저장 (statusLine + hooks.SessionStart + hooks.PostToolUse)`
- symlink 무결성 0건 PASS

settings.json 확인: `matcher: "Edit|Write"`, `command: "$HOME/.claude/hooks/post-report-write.sh"`, `timeout: 10`

## 판정

- [x] `claude/hooks/post-report-write.sh` 존재 + REPORT.md 감지 정합
- [x] `install.ps1` PostToolUse 등록 코드 포함
- [x] `smoke-posttooluse-hook.sh` 8/8 PASS
- [x] `install.ps1` 재실행 → `~/.claude/settings.json`에 `hooks.PostToolUse` 추가됨
- [x] 기존 smoke 회귀 0 (88/88 + 149/149 + 11/11 PASS)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | PostToolUse hook stdin JSON format / additionalContext 출력 / matcher Edit\|Write / timeout 단위 / exit code 정책 / tool_response.success 가드 |
| **findings** | no new findings |
| **drift** | no — PLAN spec 정합 유지. 구현 중 신규 drift 없음 |
| **re-verify** | Anthropic hook spec 변경 또는 additionalContext 동작 변경 시 |

## Lessons Learned

- **L1 — `((PASS++))` set -e 함정** — PASS=0일 때 `((PASS++))` 포스트 인크리먼트는 0(falsy) 평가 → `set -e` 하에서 즉시 종료. `PASS=$((PASS+1))`로 수정. bash arithmetic evaluation 주의점.
- **L2 — matcher-level merge의 중요성** — PostToolUse는 사용자 IDE hook 선등록 빈도가 SessionStart보다 높음. append 전략 없이 덮어쓰기하면 사용자 lint/test hook 파괴. matcher key로 중복 감지 + 다른 matcher는 보존.
- **L3 — install.ps1 -Force 필요성** — 이미 올바른 SessionStart가 등록돼도 `-Force` 없으면 abort. 정기 재실행 용도로 `-Force` 단독 플래그 문서화 필요 (v1.36b2 후속 검토).

## 다음 후보 (보류)

| 후속 세션 | 조건 |
|-----------|------|
| `v1.36b2-install-sh-posttooluse` | macOS/Linux install.sh 신설 시 PostToolUse 등록 추가 |
| `v1.36b3-multiedit-trigger` | MultiEdit으로 REPORT.md 갱신 evidence 발생 시 |
| `v1.36b4-hook-debug-log` | silent no-op 문제 evidence 발생 시 stderr 로그 추가 |
| Stage J verify — PostToolUse 등록 검증 | verify.ps1/sh에 PostToolUse hook 등록 여부 체크 |
