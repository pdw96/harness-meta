# meta v1.54-hook-debug-log — REPORT

세션 종료: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/REPORT.md)

## 최종 결과

| 항목 | 값 |
|------|---|
| 수정 파일 | 2 (`post-report-write.sh`, `smoke-posttooluse-hook.sh`) |
| smoke 결과 | 15/15 PASS (신규 Test L 포함) + 전체 smoke 회귀 0 |
| 신규 WARN 경로 | 2건 (python3 미설치 + 양쪽 파서 실패) |

## 구현 요약

### Stage A — `claude/hooks/post-report-write.sh`

**R1 — python3 미설치 시 WARN** (L19-21 신규):

```bash
if ! command -v python3 >/dev/null 2>&1; then
    printf '[post-report-write] WARN: python3 not found, using grep fallback only\n' >&2
fi
```

기존 `if command -v python3` 블록 **앞**에 삽입. 정보성 경고만 출력, 제어 흐름 불변.

**R2 — 양쪽 파서 실패 시 WARN + 조기 종료** (L88-93 신규):

```bash
if [ -z "$TOOL_NAME" ]; then
    printf '[post-report-write] WARN: both python3 and grep parsers failed to extract tool_name\n' >&2
    printf '%s\n' "$NOOP"
    exit 0
fi
```

grep 폴백 `fi` 직후, success 가드 앞에 삽입. 기존 `case *) NOOP` 경로에서 **파싱 실패** 의미를 분리.

**R3 — 헤더 주석 갱신** (L6):

```
# v1.54  — python3 미설치 + 양쪽 파서 실패(TOOL_NAME 빈값) 시 stderr WARN 추가.
```

### Stage B — `tests/smoke-posttooluse-hook.sh`

**Test L 신규** — malformed JSON → 양쪽 파서 실패 → NOOP {} + stderr WARN:

```bash
_L_STDERR_FILE=$(mktemp)
L_STDOUT=$(printf '%s' 'not valid json at all' | bash "$HOOK" 2>"$_L_STDERR_FILE")
L_STDERR=$(cat "$_L_STDERR_FILE")
rm -f "$_L_STDERR_FILE"
if [ "$L_STDOUT" = '{}' ] && printf '%s' "$L_STDERR" | grep -q '\[post-report-write\] WARN'; then
    ok "L: ..."
```

`mktemp` + stderr redirect로 stdout/stderr 분리 캡처. 헤더 + 총 카운트 14/14 → 15/15 갱신.

## 판정

- [x] `post-report-write.sh`: python3 미설치 시 stderr WARN (R1)
- [x] `post-report-write.sh`: malformed JSON → TOOL_NAME='' → stderr WARN + NOOP (R2)
- [x] 기존 A~K 11개 dynamic 테스트 회귀 0
- [x] `smoke-posttooluse-hook.sh` 15/15 PASS (Test L 신규)
- [x] 전체 smoke 회귀 0 (20개 smoke 파일 전수 확인)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 외부 spec 의존 없음. bash 내부 로직 + stderr 출력 (OS-level, hook spec 무관) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — stderr/stdout 분리 캡처는 `mktemp` 패턴이 가장 안전** — 프로세스 치환(`<(...)`)은 zsh/bash 버전 의존 + `set -euo pipefail` 하에서 오동작 가능. `mktemp` + redirect는 POSIX 호환 + 예외 안전.
- **L2 — TOOL_NAME='' 조기 종료 vs case `*)` 분리가 진단 명확화** — 기존 `case *)`는 정상 NOOP (tool이 Write/Edit/MultiEdit이 아닌 경우)과 비정상 NOOP (파싱 자체 실패)을 같은 경로로 처리. R2로 분리하면 비정상 NOOP 고유 WARN 경로 획득.
- **L3 — WARN은 exit 0과 양립** — Claude Code hook에서 stderr는 세션 노이즈 없음. exit 0만 보장하면 됨. WARN 추가가 기존 정책(exit 0 only)을 위반하지 않음.

## 다음 후보 (보류)

| 후속 세션 | 조건 |
|-----------|------|
| `vX-hook-debug-verbose-mode` | HARNESS_HOOK_DEBUG=1 opt-in 상세 로그 (모든 NOOP exit 경로) evidence-driven |
| `v1.39b-hooks-expand` | 다른 smoke hook 포함 evidence 누적 시 |
| `v1.40c-hook-more-tools` | Delete·NotebookEdit 미발화 evidence 시 |
