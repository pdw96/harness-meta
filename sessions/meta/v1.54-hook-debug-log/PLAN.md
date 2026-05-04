# meta v1.54-hook-debug-log — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/REPORT.md) — PostToolUse hook 신설 (본 세션이 다음 후보 v1.36b4 이행)

목적: `claude/hooks/post-report-write.sh`에서 python3·grep **양쪽** JSON 파싱 실패 시 `TOOL_NAME`이 빈 값으로 침묵 NOOP 되는 구간에 stderr WARN 로그를 추가. `python3` 미설치 환경 경고도 추가. smoke 2건 추가.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1a(1) `claude/hooks/post-report-write.sh` + S3(1) `tests/smoke-posttooluse-hook.sh` = 2/2 meta scope
- **T1 경로 다수결** — S1a + S3 모두 meta (2/2)

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.36b-postoolse-roadmap-hook/REPORT.md` 다음 후보 표** (verbatim):

> `| v1.36b4-hook-debug-log | silent no-op 문제 evidence 발생 시 stderr 로그 추가 |`

**Parsed sub-items (1)**:

1. **stderr 로그 추가** — python3·grep 양쪽 파서 실패 → TOOL_NAME 빈 값 → silent NOOP 구간에 stderr WARN 출력

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Hook 매처 확장 (Delete·NotebookEdit 등) | v1.39b/v1.40c/v1.40d — 별 세션 |
| PLAN.md 감지 패턴 확장 | v1.40d — 별 세션 |
| stderr 로그를 additionalContext로 승격 | 별 후속 (evidence-driven) |
| HARNESS_HOOK_DEBUG env var opt-in verbose 모드 | 별 후속 (evidence-driven) |
| install.sh PostToolUse 등록 (macOS/Linux) | v1.36b2 — 별 세션 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 bash 내부 로직 변경 + 테스트 추가. 외부 spec 의존 없음 (hook stderr 출력은 Claude Code hook 공식 spec 무관, OS-level stderr) |
| **re-verify** | N/A |

## 1. 문제 (침묵 NOOP)

### 현재 코드 흐름

```
INPUT → python3 파싱 → TOOL_NAME 추출 (실패 시 공백)
      → grep 폴백   → TOOL_NAME 추출 (실패 시 공백)
      → case "$TOOL_NAME" in Write|Edit|MultiEdit) ... *) NOOP; exit 0  ← 침묵
```

**침묵 NOOP 시나리오**:

1. python3 미설치 → grep 폴백만 실행 → 정상 (single parser)
2. python3 있으나 JSON 파싱 exception → except 분기 출력 → TOOL_NAME="" → grep 폴백 → 정상 시
3. **INPUT이 완전히 비정상 (malformed JSON 등) → python3 except → TOOL_NAME="" → grep도 실패 → TOOL_NAME="" → case `*)` NOOP (WARN 없음) ← 문제**

### 진단 어려움

hook이 "왜 발동 안 했는지" 알 수 없음:

- (a) REPORT.md 패턴 미매칭 (정상 NOOP)
- (b) JSON 파싱 양쪽 실패 (비정상 NOOP)
- (c) hook 미등록 (settings.json 문제)

(b)를 (a)와 구별할 수단 없음 → stderr WARN이 유일한 진단 수단.

## 2. 결정 (R1 ~ R2)

### R1 — python3 미설치 시 WARN

```bash
# command -v python3 >/dev/null 2>&1; 분기 앞
if ! command -v python3 >/dev/null 2>&1; then
    printf '[post-report-write] WARN: python3 not found, using grep fallback only\n' >&2
fi
```

**위치**: 현재 `if command -v python3` 블록 전. 정보성 경고 (grep 폴백으로 계속 진행).

### R2 — TOOL_NAME 빈 값 (양쪽 실패) WARN + 조기 종료

```bash
# grep 폴백 블록 직후 (현재 "── 가드: tool_response.success" 앞)
if [ -z "$TOOL_NAME" ]; then
    printf '[post-report-write] WARN: both python3 and grep parsers failed to extract tool_name\n' >&2
    printf '%s\n' "$NOOP"
    exit 0
fi
```

**위치**: grep 폴백 `fi` 직후. 기존 success 가드·case 문보다 앞에 배치 — "양쪽 실패" 의미를 명확히 격리.

**장점**:

- case `*)` NOOP은 정상 경로 (tool_name이 Write|Edit|MultiEdit 아닌 경우 — 정상 NOOP)
- WARN 경로는 비정상 (파싱 자체 실패) → 분리가 의미 명확

### R3 — 헤더 주석 갱신

```
# v1.54  — TOOL_NAME 빈 값 (양쪽 파서 실패) + python3 미설치 시 stderr WARN.
```

## 3. 변경 대상 (2 수정)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/hooks/post-report-write.sh` | S1a | R1(python3 미설치 WARN) + R2(양쪽 실패 WARN) + R3(헤더) |
| `tests/smoke-posttooluse-hook.sh` | S3 | Test F2(malformed JSON → stderr WARN) + Test F3(python3 없음 시뮬레이션 — 가능 시) |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [x] **3 관점 병렬 검토 (architecture / spec-drift / scope contract)**
- [x] **사용자 PLAN 확정**
- [x] Stage A — `post-report-write.sh` R1+R2+R3
- [x] Stage B — `smoke-posttooluse-hook.sh` Test L(malformed JSON → stderr WARN)
- [ ] REPORT.md

## 5. 성공 기준

- [x] `post-report-write.sh`: python3 미설치 시 stderr WARN 포함
- [x] `post-report-write.sh`: malformed JSON → TOOL_NAME 빈 값 → stderr WARN + NOOP 조기 종료
- [x] 기존 동작 (정상 REPORT.md 감지) 회귀 0
- [x] `smoke-posttooluse-hook.sh` Test L PASS (malformed JSON → stderr WARN) — 15/15 PASS
- [x] 기존 smoke 전체 회귀 0

## 6. 커밋 전략

```
fix(meta): v1.54-hook-debug-log — PostToolUse hook 양쪽 파서 실패 시 stderr WARN 추가

- update: claude/hooks/post-report-write.sh (R1 python3 미설치 WARN + R2 TOOL_NAME 빈값 WARN)
- update: tests/smoke-posttooluse-hook.sh (Test F2 malformed JSON → stderr WARN 검증)
- add: sessions/meta/v1.54-hook-debug-log/{PLAN,REPORT}.md

ROADMAP §3-B v1.36b4 trigger 이행.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `v1.36b2-install-sh-posttooluse` | macOS install.sh PostToolUse 등록 evidence |
| `vX-hook-debug-verbose-mode` | HARNESS_HOOK_DEBUG env var opt-in 상세 로그 evidence |
