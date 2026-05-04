# meta v1.62-fix-broad-bash-fine-grain — REPORT

세션 완료: 2026-05-04

## 최종 결과

- 변경 파일: 1 (`tests/smoke-broad-bash-fine-grain.sh`)
- default: 6/6 PASS (회귀 0)
- `--fix --dry-run`: plan + Stage skip 정상
- `--help`: usage 출력 + exit 0
- E2E 시나리오: V5 + R2/R6 두 종류 violation 주입 → `--fix` → 정정 + 6/6 PASS

## 구현 요약

### Stage A+B — argv + V5 + R2/R6 --fix block

v1.60/v1.61 패턴 답습한 `--fix` mode 추가:

1. **argv 파싱**: `--fix` / `--dry-run` / `--help|-h` + Unknown/Unexpected → exit 2
2. **V5 --fix block** (7 파일):
   - regex `^[[:space:]]*-[[:space:]]*Bash\((ls|cat|head|tail|grep|find|wc|diff|stat|du|cd)([: ]\*?)?\)[[:space:]]*$`
   - YAML list anchor로 markdown body 보호
   - `sed -E -i.bak "/$V5_PAT/d"` → 행 삭제
3. **R2/R6 --fix block** (4 NO_BASH_FILES):
   - `harness/SKILL.md` + `harness-dispatcher.md` + `harness-explore.md` + `harness-grey-area.md`
   - regex `^[[:space:]]*-[[:space:]]*Bash([[:space:]]*\(.*\))?[[:space:]]*$`
   - broad Bash + parenthesized 모두 cover
4. **순서**: V5 먼저 (7 파일) → R2/R6 (4 파일). 중복 매칭 시 V5가 먼저 삭제 → R2/R6 idempotent
5. **`--dry-run`**: `[would fix V5/R2/R6]` plan 출력 + Stage 검증 skip
6. **백업**: 모든 sed `-i.bak` + `rm -f $f.bak`

### Out of scope 유지

- V8 (Stage 1 콤마 separator) — 구조적 변환
- V9 (Stage 2 YAML list 항목 수) — 구조적 검증
- Stage 4 R3/R4 (broad Bash positive existence) — 본질
- Stage 6 field name (3 SKILL ↔ 4 agent bidirectional rename) — 양방향 안전성 검증 필요

### 검증 시나리오 (E2E)

```bash
# 주입: V5 (harness-run에 auto-allow) + R6 (dispatcher에 broad Bash)
sed -E -i.bak '0,/^  - Bash$/{s|^  - Bash$|  - Bash\n  - Bash(ls *)|}' \
    bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md
sed -E -i.bak '0,/^tools:$/{s|^tools:$|tools:\n  - Bash|}' \
    bootstrap/templates/_base/.claude/agents/harness-dispatcher.md

# --fix
bash tests/smoke-broad-bash-fine-grain.sh --fix
# → [fix V5] bootstrap/.../harness-run/SKILL.md
# → [fix R2/R6] bootstrap/.../harness-dispatcher.md
# → ALL 6 STAGES PASS
```

## 판정

| 성공 기준 | 결과 |
|---------|------|
| default 6/6 PASS (회귀 0) | ✅ |
| --help usage 출력 + exit 0 | ✅ |
| --fix --dry-run plan + Stage skip | ✅ |
| E2E V5 violation → --fix → 정정 + PASS | ✅ |
| E2E R2/R6 violation → --fix → 정정 + PASS | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — V5/R2/R6 동일 anchor 패턴 재사용**: 모두 `^[[:space:]]*-[[:space:]]*Bash...` YAML list anchor 기반. v1.60에서 정착한 패턴 → v1.61(V10) → v1.62(V5+R2/R6)로 자연 확장
- **L2 — Windows cp949 default encoding 회피**: Python `open()`이 default cp949로 UTF-8 한국어 파일 read 실패. E2E 시나리오 검증 시 sed `0,/.../{s|...|...|}` 패턴(첫 매치만 치환)이 sed 단독 + locale-agnostic이라 안전
- **L3 — 같은 파일에 여러 violation 종류 검증 가능**: V5와 R6은 anchor가 다르지만 일부 파일(harness/SKILL.md)은 둘 다 적용. 같은 sed `/d` operation이라 idempotent — 안전 보장

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.62b-fix-field-name-rename` | E | Stage 6 field name (3 SKILL `tools:` → `allowed-tools:` + 4 agent 역방향) bidirectional auto-fix evidence |
| `v1.61b-fix-model-effort-insert` | E | R1/R2/R3/R4 model+effort frontmatter 구조 삽입 (앞 세션 후속 이연) |
| `v1.62c-fix-other-smokes` | E | 다른 smoke (smoke-language-overlay 등) `--fix` 패턴 evidence |
