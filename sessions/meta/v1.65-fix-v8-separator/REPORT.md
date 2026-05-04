# meta v1.65-fix-v8-separator — REPORT

세션 완료: 2026-05-04

## 최종 결과

- 변경 파일: 1 (`tests/smoke-bash-permission-pattern.sh`)
- default 호출: 6/6 PASS (회귀 0)
- `--fix --dry-run`: plan 출력 정상 (0건 시 "no violations found")
- `--help`: V8 명시 포함 + exit 0
- E2E 시나리오 검증: V8 violation 주입 → `--fix` → YAML list 정합 + 6/6 PASS

## 구현 요약

### Stage A — V8 fix block + 헤더/help 갱신 (`tests/smoke-bash-permission-pattern.sh`)

v1.60 `--fix` block에 V8 처리 추가:

1. **헤더 주석**: `# v1.65 — --fix V8 추가: 콤마 separator → YAML list 구조 변환 (parenthesis-aware)` 1줄 추가
2. **`--fix mode` echo**: `(V1/V5/V7)` → `(V1/V5/V7/V8)` 갱신
3. **`--help` 텍스트**: V8 fixable 명시 + V9 연계 해소 설명 추가
4. **V8 fix block** (V7 fix 직후):
   - 감지: `grep -qE '^(allowed-tools|tools):.+,'`
   - dry-run: `grep -nE` + `[would fix V8]` 라벨 출력
   - fix: `python3 - "$f" <<'PYEOF'` heredoc — parenthesis-aware split + `re.sub` MULTILINE
   - `newline='\n'` write — Windows CRLF 방지 (LF 유지)
   - backup: `cp "$f" "$f.bak"` / Python 성공 시 `rm -f "$f.bak"` (v1.60 패턴 답습)

### parenthesis-aware split 알고리즘

3 검증 케이스:

- `Read, Glob, Grep, Bash(mkdir *)` → YAML 4 items ✓
- `Bash(git *, npm *)` → no-op (괄호 내부 콤마 무시) ✓
- `Read, Bash(git *), Bash(npm *)` → YAML 3 items ✓

### Line ending 보호 (newline='\n')

Python 기본 text write는 Windows에서 CRLF 출력. `open(p, 'w', encoding='utf-8', newline='\n')` 명시로 LF 보존.

E2E 후 `git diff --stat` → "no changes (LF preserved)" 확인.

## 판정

| 성공 기준 | 결과 |
|---------|------|
| V8 violation 주입 → --fix → YAML list 정합 | ✅ |
| Bash(git *, npm*) no-op (parenthesis-aware 보호) | ✅ |
| default 6/6 PASS (회귀 0) | ✅ |
| --fix --dry-run plan 출력 정상 | ✅ |
| --help V8 언급 포함 | ✅ |
| LF line ending 유지 (git diff no-op) | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 외부 spec 의존 무 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — Python heredoc은 `python3 - "$f" <<'PYEOF'` 패턴으로 깔끔** — `sys.argv[1]`으로 파일 경로 수신, single-quote heredoc으로 Python 내 `$` 등 변수 expansion 방지. 기존 sed 방식 대비 multi-line 변환에 적합
- **L2 — Windows text write는 CRLF 생산** — `open(..., newline='\n')` 명시 없으면 LF 파일을 CRLF로 오염. E2E 후 `git diff --stat` 확인 필수. 모든 smoke/hook Python write는 `newline='\n'` 의무화 권장
- **L3 — parenthesis-aware split은 Bash(cmd *, cmd2 *) false-positive 방지** — 단순 `split(',')` 대비 안전. 실 발생 케이스 0이지만 defensive coding 가치

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.65b-v9-count-threshold` | E | V9 count ≥ 3 → ≥ 1 threshold 조정. evidence 3+ 케이스 |
| `v1.65c-agent-v8-fix` | E | smoke FILES에 agent 파일 추가 evidence. 현재 0건 |
| `v1.65d-python-newline-audit` | B | 다른 smoke/hook Python write에서 CRLF 오염 발생 시. `newline='\n'` 일괄 적용 |
