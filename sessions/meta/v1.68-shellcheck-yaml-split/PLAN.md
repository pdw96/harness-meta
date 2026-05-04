# meta v1.68-shellcheck-yaml-split — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.66-precommit-cleanup/`](../v1.66-precommit-cleanup/REPORT.md) — shellcheck "openBinaryFile" exit 2 미해소 (v1.66e 후속 등록)

목적: pre-commit `shellcheck` hook이 매 호출마다 `SC2034: SC2034: openBinaryFile: does not exist` 출력 + exit 2 내는 root cause 진단 + 1-line fix.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `.pre-commit-config.yaml` (S3 — repo 정책)
- **T1 경로 다수결** — 1/1 meta scope

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-B (verbatim)**:

> | `v1.66e-shellcheck-openbinaryfile-diagnose` | shellcheck-py "openBinaryFile" 출력 root cause 진단. exit 2 → exit 0 | `v1.66 REPORT` |

**Parsed sub-items (1)**:

1. **shellcheck "openBinaryFile" root cause 진단 + 해소** — exit 2 → exit 0 목표.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 다른 hook 추가 | scope 외 |
| shellcheck 규칙 추가/제거 | 본 fix는 형식 정합화만 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 lint 정합화. 외부 spec 의존 무 |
| **re-verify** | N/A |

## 1. Root cause 진단

### 증상

```
$ py -m pre_commit run shellcheck --all-files
shellcheck...............................................................Failed
- exit code: 2

SC2034: SC2034: openBinaryFile: does not exist (No such file or directory)
```

직접 실행 (`shellcheck.exe ... | xargs ...`) 시 exit 0. pre-commit 통해서만 fail.

### 진단

`shellcheck.exe SC2034` (SC2034를 파일명 인자로) 실행 시 동일 에러 재현:

```bash
$ shellcheck.exe --severity=warning SC2034
SC2034: SC2034: openBinaryFile: does not exist (No such file or directory)
exit: 2
```

→ pre-commit이 args에 `SC2034`를 파일명으로 전달하고 있다.

### YAML inline list 콤마 split

`.pre-commit-config.yaml` 기존:

```yaml
args: [--severity=warning, --exclude=SC1091,SC2034]
```

YAML inline flow style `[a, b, c]`에서 **콤마는 element separator**. `--exclude=SC1091,SC2034` 단일 문자열이 아닌 두 개 element로 split:

| 의도 | 실제 (YAML 파싱 결과) |
|------|------|
| `--severity=warning` | `--severity=warning` |
| `--exclude=SC1091,SC2034` | `--exclude=SC1091` |
| | `SC2034` ← 파일명으로 오인 |

shellcheck가 `SC2034`를 파일로 열려다 binary mode 실패 → `openBinaryFile: does not exist` + exit 2.

## 2. 결정 (R1)

### R1 — block style YAML 사용

`.pre-commit-config.yaml`:

```yaml
args:
  - --severity=warning
  - --exclude=SC1091,SC2034
```

block style (`-` 항목당 한 줄)은 콤마를 element separator로 처리하지 않으므로 `--exclude=SC1091,SC2034`가 단일 문자열로 보존됨.

대안:

- `args: [--severity=warning, --exclude=SC1091, --exclude=SC2034]` (다중 `--exclude`)
- `args: [--severity=warning, "--exclude=SC1091,SC2034"]` (quote)

block style 채택 — 가독성 + 향후 항목 추가 용이성.

## 3. 변경 대상 (1 파일)

| 경로 | scope | 변경 |
|------|------|------|
| `.pre-commit-config.yaml` | S3 | inline list → block style + 주석 (root cause 기록) |

## 4. 목표

- [x] PLAN
- [ ] Stage A — `.pre-commit-config.yaml` block style 변경
- [ ] Stage B — `pre-commit run --all-files` 검증 (전체 PASS)
- [ ] REPORT + ROADMAP + 커밋

## 5. 성공 기준

- [ ] `pre-commit run --all-files` 모든 hook PASS (exit 0)
- [ ] shellcheck "openBinaryFile" 출력 0건
