# meta v1.60-fix-bash-permission-pattern — REPORT

세션 완료: 2026-05-04

## 최종 결과

- 변경 파일: 1 (`tests/smoke-bash-permission-pattern.sh`)
- default 호출: 6/6 PASS (회귀 0)
- `--fix --dry-run`: usage + plan 출력 정상
- `--help`: usage 출력 + exit 0
- E2E 시나리오 검증: violation 주입 → `--fix` → 0 violation + 6/6 PASS

## 구현 요약

### Stage A+B — argv + --fix block (`tests/smoke-bash-permission-pattern.sh`)

v1.10d β scope smoke에 v1.33 패턴 답습한 `--fix` mode 추가:

1. **argv 파싱**: `--fix` / `--dry-run` / `--help|-h` + Unknown option/Unexpected arg → exit 2
2. **`--fix` block** (Stage 1 진입 전 실행):
   - **V1**: `Bash\(([a-z][a-z\-]*)\*\)` → `Bash(\1 *)` (공백 추가)
   - **V5**: YAML list line 자동 허용 set 줄 삭제 (markdown body 보호 — `^[[:space:]]*-[[:space:]]*Bash\(...\)[[:space:]]*$` anchor)
   - **V7**: slash command (`harness-meta.md`) `^tools:` → `^allowed-tools:`
3. **`--dry-run`**: `[would fix V#]` plan 출력 + Stage 검증 skip + exit 0
4. **백업**: 모든 sed `-i.bak` 후 `rm -f $f.bak` (실패 시 .bak 잔존 → 복구 가능)

### Out of scope 유지

V8 (single-line 콤마 separator) / V9 (YAML list 항목 수) / V4 (PERMISSION_PATTERN.md keyword) — 구조적/문서성 변경 어려움. 후속 미정.

### 검증 시나리오 (E2E)

```bash
# 1. 임시 violation 주입
sed -E -i.bak 's/Bash\(mkdir \*\)/Bash(mkdir*)/' claude/commands/harness-meta.md
# → V1 위반 1건

# 2. --fix 실행
bash tests/smoke-bash-permission-pattern.sh --fix
# → "[fix V1] claude/commands/harness-meta.md"
# → 자동 정정 후 Stage 1~6 진행 → 6/6 PASS

# 3. 검증
grep -cE 'Bash\([a-z][a-z\-]*\*\)' claude/commands/harness-meta.md
# → 0 (정정 완료)
```

## 판정

| 성공 기준 | 결과 |
|---------|------|
| default 호출 6/6 PASS (회귀 0) | ✅ |
| --help usage 출력 + exit 0 | ✅ |
| --fix --dry-run plan + Stage skip | ✅ (현재 0건이므로 "no violations found") |
| E2E 시나리오: violation 주입 → --fix → 정정 + PASS | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — sed 안전성은 anchor 정밀도가 결정**: V5 자동 허용 set 삭제는 YAML list anchor (`^[[:space:]]*-[[:space:]]*...`)로 markdown body 보호. body inline code (`` `Bash(ls *)` ``)는 backtick 외 위치이므로 매치 안 됨. anchor 정의가 false positive 차단의 핵심
- **L2 — --fix mode는 forward-looking 가치**: 현재 위반 0건이지만 향후 신규 SKILL/command 작성 시 자동 정정 mechanism 확보. v1.33 패턴 답습 → 유지보수 일관성 확보
- **L3 — pipeline + head -N 조합 시 SIGPIPE 주의**: 검증 단계에서 `bash smoke ... | head -3` 후 후속 명령 chain 시 `set -e` propagation으로 exit 1 발생 가능. 검증 스크립트 작성 시 `> /tmp/file.txt` 파일 redirect 후 `tail -N`이 안전

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.60b-fix-thinking-effort` | E | `smoke-thinking-effort.sh` `thinking:` field auto-remove |
| `v1.60c-fix-broad-bash-fine-grain` | E | `smoke-broad-bash-fine-grain.sh` `--fix` 패턴 |
| `v1.60d-v8-v9-structural-fix` | A | V8 콤마 separator + V9 YAML list 항목 수 auto-fix (구조적 변환 검증 evidence 필요) |
