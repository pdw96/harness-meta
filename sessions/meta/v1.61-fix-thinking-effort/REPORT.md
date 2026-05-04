# meta v1.61-fix-thinking-effort — REPORT

세션 완료: 2026-05-04

## 최종 결과

- 변경 파일: 1 (`tests/smoke-thinking-effort.sh`)
- default: 5/5 PASS (회귀 0)
- `--fix --dry-run`: plan + Stage skip 정상
- `--help`: usage 출력 + exit 0
- E2E 시나리오: violation 주입 → `--fix` → 0 violation + 5/5 PASS

## 구현 요약

### Stage A+B — argv + V10 --fix block (`tests/smoke-thinking-effort.sh`)

v1.60 패턴 답습한 `--fix` mode 추가:

1. **argv 파싱**: `--fix` / `--dry-run` / `--help|-h` + Unknown option/Unexpected arg → exit 2
2. **V10 --fix block** (Stage 1 진입 전):
   - regex `^thinking:` (line-anchor)
   - `sed -E -i.bak '/^thinking:/d'` → 행 삭제
   - 4 파일 (slash + 3 opus SKILL) 대상
3. **`--dry-run`**: `[would fix V10]` plan 출력 + Stage 검증 skip
4. **백업**: `-i.bak` + `rm -f $f.bak` (실패 시 .bak 잔존 → 복구 가능)

### Out of scope 유지

- R1 (`^model: sonnet$`) / R2/R3/R4 (`^effort: xhigh$` / `^model: opus$`) — frontmatter 구조 삽입 위치 결정 필요 (--- 사이) → v1.61b 후속
- Stage 5 V1/V5 — v1.60 smoke-bash-permission-pattern과 중복 회피
- Stage 5 V8/V9 — 구조적 변환 어려움

### 검증 시나리오 (E2E)

```bash
# 1. 임시 violation 주입
sed -E -i.bak 's/^model: opus$/&\nthinking: high/' \
    bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md

# 2. --fix 실행
bash tests/smoke-thinking-effort.sh --fix
# → "[fix V10] bootstrap/.../harness-design/SKILL.md"
# → 자동 정정 후 Stage 1~5 진행 → 5/5 PASS

# 3. 복원 + 검증
# → V10 violations: 0
```

## 판정

| 성공 기준 | 결과 |
|---------|------|
| default 5/5 PASS (회귀 0) | ✅ |
| --help usage 출력 + exit 0 | ✅ |
| --fix --dry-run plan + Stage skip | ✅ ("no violations found") |
| E2E: violation 주입 → --fix → 정정 + PASS | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — line-anchor sed의 강건함**: `^thinking:`는 frontmatter 구조 (---사이) 와 markdown body 들여쓰기 또는 backtick 표현을 자연 분리. body 평문 "thinking:" (들여쓰기 없는)도 매칭 가능하지만 본 4 파일에서는 발생 0 — 수동 검토는 maintain 가능
- **L2 — v1.60 패턴 답습 효율**: argv parsing + --fix block + dry-run + .bak 백업 = 거의 동일 구조. 코드 ~50라인. v1.33 → v1.60 → v1.61 패턴 정착 → 향후 다른 smoke (`smoke-broad-bash-fine-grain` 등) 답습 시 부담 최소
- **L3 — frontmatter 구조 변경 vs 단순 line-delete의 분리**: V10 (line-delete)은 단일 sed로 안전하나 R1/R2 (model/effort 강제 set)는 frontmatter 구조 삽입 위치 결정 필요. 복잡도 차이 → 별 세션(v1.61b)으로 분리 정당

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.61b-fix-model-effort-insert` | E | R1/R2/R3/R4 model+effort frontmatter 구조 삽입 auto-fix evidence (구조적 변환) |
| `v1.60c-fix-broad-bash-fine-grain` | E | smoke-broad-bash-fine-grain.sh `--fix` 패턴 (별도 세션) |
