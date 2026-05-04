# meta v1.68-shellcheck-yaml-split — REPORT

세션 완료: 2026-05-04

## 최종 결과

- **shellcheck**: exit 2 → **exit 0** (`pre-commit run --all-files` 모든 hook PASS)
- 변경 파일: 1 (`.pre-commit-config.yaml`)
- 변경 라인: 4 (inline list → block style + 주석 2줄)

## 구현 요약

### Root cause

YAML inline flow style `[a, b, c]`의 콤마는 element separator. `.pre-commit-config.yaml`의 `args: [--severity=warning, --exclude=SC1091,SC2034]`가 YAML 파서에 의해:

1. `--severity=warning`
2. `--exclude=SC1091`
3. `SC2034` ← 파일명으로 오인

3개 인자로 split되어 shellcheck가 `SC2034`를 파일로 열려다 실패.

### 진단 방법

```bash
$ shellcheck.exe SC2034
SC2034: SC2034: openBinaryFile: does not exist (No such file or directory)
exit: 2
```

직접 SC2034를 파일명으로 전달 시 동일 에러 재현 → 가설 확정.

### Fix (Stage A)

`.pre-commit-config.yaml` block style 변경:

```yaml
# Before
args: [--severity=warning, --exclude=SC1091,SC2034]

# After
args:
  - --severity=warning
  - --exclude=SC1091,SC2034
```

block style은 `-` 항목 단위로 element 구분하므로 콤마가 separator 아님. `--exclude=SC1091,SC2034` 단일 문자열로 보존.

### 검증 (Stage B)

```text
fix end of files............................................................Passed
trim trailing whitespace....................................................Passed
check for merge conflicts...................................................Passed
check yaml..................................................................Passed
check for added large files.................................................Passed
shellcheck..................................................................Passed
markdownlint................................................................Passed
Smoke — Spec verification § 검사 (실패 시 --fix 자동).......................Passed
Smoke — Scope contract § 검사 (실패 시 --fix 자동)..........................Passed
```

모든 hook PASS.

## 판정

| 성공 기준 | 결과 |
|---------|------|
| pre-commit 모든 hook PASS | ✅ |
| shellcheck "openBinaryFile" 0건 | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — YAML 파서 동작 + pre-commit 표준. 외부 spec 의존 무 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — YAML inline flow `[a, b]` 콤마는 항상 element separator**: `[a,b,c]`에서 어떤 element 내부에도 unquoted 콤마 사용 불가. 콤마 포함 값은 quote (`"a,b"`) 또는 block style (`- a,b`) 필수
- **L2 — `--exclude=SC1091,SC2034` 패턴**: shellcheck CLI는 다중 코드를 콤마로 받지만, YAML inline list와 충돌. block style이 해결책
- **L3 — pre-commit hook 디버깅**: 직접 실행 vs hook 실행 결과 차이는 args 전달 차이 의심. `shellcheck SC2034`처럼 가능한 잘못된 args를 직접 재현해서 root cause 빠른 확정 가능

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.68b-precommit-args-audit` | E | 다른 hook의 args에도 콤마 포함 패턴 사용 시 동일 함정 — 잠재 issue evidence 발견 시 일괄 점검 |
