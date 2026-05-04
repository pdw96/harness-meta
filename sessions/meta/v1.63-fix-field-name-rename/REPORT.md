# meta v1.63-fix-field-name-rename — REPORT

세션 완료: 2026-05-04

## 최종 결과

- 변경 파일: 1 (`tests/smoke-broad-bash-fine-grain.sh`)
- default: 6/6 PASS (회귀 0)
- E2E 3 시나리오 통과: SKILL rename + agent rename + 양쪽 동시 skip

## 구현 요약

### Stage A+B — Stage 6 rename + skip + --help 갱신

v1.62 `--fix` block에 Stage 6 field name bidirectional rename 추가:

1. **Stage 6 SKILL rename** (3 파일 — harness/harness-run/harness-ship SKILL.md):
   - `has_tools=0; has_allowed=0; grep -qE '^tools:' && has_tools=1; ...`
   - 양쪽 존재 → skip 메시지 + 수동 정정 안내
   - `tools:`만 → `sed 's/^tools:/allowed-tools:/'`
2. **Stage 6 agent rename** (4 파일 — harness-verifier/dispatcher/explore/grey-area):
   - 동일 boolean 패턴
   - 양쪽 존재 → skip 메시지
   - `allowed-tools:`만 → `sed 's/^allowed-tools:/tools:/'`
3. **--help 텍스트 갱신**: Stage 6 rename 추가 안내 + 양쪽 동시 skip 정책 명시
4. **header v1.63 변경 라인 추가**

### Bug fix — `grep -c || echo 0` 이중 출력

초기 시도에서 `grep -c` (no match 시 "0" 출력 + exit 1) + `|| echo 0` 조합이 "0\n0" 이중 출력 → integer 비교 실패 (`integer expression expected`). boolean 분리(`grep -qE && has_X=1`)로 해결.

### Out of scope 유지

- 양쪽 필드 동시 존재 시 자동 정정 — 어느 필드 보존할지 결정 분기 (사용자 판단 영역)
- V8 (Stage 1 콤마) / V9 (Stage 2 항목 수) / Stage 4 (positive existence) — v1.62 동일 정책

### 검증 시나리오 (E2E 3건)

```bash
# 시나리오 1: SKILL ^allowed-tools: → ^tools: 주입 → --fix → 정정 + PASS
sed -E -i.bak 's/^allowed-tools:/tools:/' \
    bootstrap/templates/_base/.claude/skills/harness/SKILL.md
bash tests/smoke-broad-bash-fine-grain.sh --fix
# → [fix Stage 6 SKILL] ... ^tools: → ^allowed-tools:
# → ALL 6 STAGES PASS

# 시나리오 2: agent ^tools: → ^allowed-tools: 주입 → --fix → 정정 + PASS
sed -E -i.bak 's/^tools:/allowed-tools:/' \
    bootstrap/templates/_base/.claude/agents/harness-verifier.md
bash tests/smoke-broad-bash-fine-grain.sh --fix
# → [fix Stage 6 agent] ... ^allowed-tools: → ^tools:

# 시나리오 3: 양쪽 동시 존재 → --fix --dry-run → skip + 변경 없음
sed -E -i.bak '0,/^allowed-tools:/{s|^allowed-tools:|tools: dummy\nallowed-tools:|}' \
    bootstrap/templates/_base/.claude/skills/harness/SKILL.md
bash tests/smoke-broad-bash-fine-grain.sh --fix --dry-run
# → [skip Stage 6 SKILL] ... 양쪽 존재 — 수동 정정 필요
# → 변경 없음 (tools: 1, allowed-tools: 1 유지)
```

## 판정

| 성공 기준 | 결과 |
|---------|------|
| default 6/6 PASS (회귀 0) | ✅ |
| --help Stage 6 안내 포함 | ✅ |
| --fix --dry-run plan + Stage skip | ✅ |
| E2E SKILL rename | ✅ |
| E2E agent rename | ✅ |
| E2E both 동시 존재 skip | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 smoke tooling 추가만. 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — `grep -c || echo X` 이중 출력 함정**: `grep -c` 자체가 no-match 시 "0"을 stdout에 출력 + exit 1 → `|| echo 0`이 추가 "0" 추가 → "0\n0" 이중 출력 → `[ "$var" -gt 0 ]`이 "integer expression expected" 에러. 해결: boolean 분리 (`grep -qE && var=1`)
- **L2 — 양쪽 필드 동시 존재 분기 정당**: rename 단방향 sed로 자동 정정 시 duplicate field 발생 가능 → YAML parser 동작 모호 → 본 정책(skip + 수동 정정 안내)이 안전. 자동 처리는 v1.63b로 분리
- **L3 — v1.62 --fix block 확장 패턴**: 기존 V5 + R2/R6 block을 보존하면서 Stage 6 rename 추가만으로 안정 확장. 추후 다른 stage auto-fix도 동일 패턴 가능

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| `v1.63b-fix-field-name-both-merge` | E | 양쪽 필드 동시 존재 시 자동 merge/delete 정책 evidence (3+ case) |
| `v1.61b-fix-model-effort-insert` | E | model+effort frontmatter 구조 삽입 (이연) |
| `v1.62c-fix-other-smokes` | E | 다른 smoke (smoke-language-overlay 등) `--fix` evidence |
