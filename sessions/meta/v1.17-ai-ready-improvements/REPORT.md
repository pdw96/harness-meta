# meta v1.17-ai-ready-improvements — REPORT

세션 종료: 2026-04-29
선행 세션: [`sessions/meta/v1.16-adr-docs/`](../v1.16-adr-docs/)

## 최종 결과

| 항목 | 결과 |
|------|------|
| session-init.sh 버그 수정 | ✅ 완료 |
| tests/integration/ 신설 | ✅ 3개 smoke, 15/15 PASS |
| Makefile `test-integration` 타겟 | ✅ 완료 |
| 기존 smoke 회귀 | 0 (13개 ALL PASS) |
| AI-Ready 재스코어 | **86/100** (84 → +2) |

## 구현 요약

### A — session-init.sh 버그 수정

**파일**: `claude/hooks/session-init.sh`

**버그**: state_file에 제어문자(0x00~0x08, 0x0B, 0x0C, 0x0E~0x1F, 0x7F) 포함 시 sed 파이프라인이 이를 통과시켜 `json.loads`가 JSONDecodeError: Invalid control character 발생.

**수정**: `LC_ALL=C tr -d '\000-\010\013\014\016-\037\177'`를 sed 파이프라인 앞에 추가.

```bash
escaped=$(printf '%s' "$context" \
    | LC_ALL=C tr -d '\000-\010\013\014\016-\037\177' \
    | sed -e 's/\\/\\\\/g' \
          -e 's/"/\\"/g' \
          -e 's/\t/\\t/g' \
          -e 's/\r/\\r/g' \
    | awk 'BEGIN{ORS=""} NR>1{print "\\n"} {print}')
```

**검증**: B5 (제어문자 포함 state_file → valid JSON) PASS.

### B — tests/integration/ 3개 smoke 신설

**`tests/integration/test-session-init-branches.sh`** (B1~B5, 5 checks)

- B1: manifest 없음 → `{}`
- B2: phases 없음 → "not initialized" + valid JSON
- B3: phases 있음 → "phases directory exists" + valid JSON
- B4: state_file 있음 → 파일 내용 주입 + valid JSON
- B5: 제어문자(0x08) 포함 → valid JSON (버그 회귀 방지)

**`tests/integration/test-statusline-timeout.sh`** (T1~T4, 5 checks)

- T1: statusline_cmd 없음 → `[harness] <name>` fallback
- T2: 정상 cmd → 명령 출력 반환
- T3: `sleep 10` → 3초 timeout 후 fallback + 경과시간 ≤5s
- T4: manifest 없음 → 빈 출력 + exit 0

**`tests/integration/test-install-guards.sh`** (G1~G5, 5 checks)

- G1: manifest 없음 → exit 1
- G2: 잘못된 HARNESS_META_ROOT → exit 1
- G3: 정상 install → exit 0 + .claude/ (16 파일)
- G4: 충돌 + --force 없음 → exit 1
- G5: --force → exit 0 + backup 디렉토리 생성

### C — Makefile `test-integration` 타겟

```makefile
test-integration:
 @failed=0; \
 for f in tests/integration/*.sh; do \
  echo "--- $$f ---"; \
  bash "$$f" || failed=$$((failed+1)); \
 done; \
 if [ $$failed -gt 0 ]; then echo "FAIL: $$failed test(s) failed"; exit 1; fi; \
 echo "ALL PASS"
```

## 판정 (PLAN 체크박스)

| 목표 | 결과 |
|------|------|
| A: session-init.sh 백슬래시 JSON 버그 수정 | ✅ |
| B-1: test-session-init-branches.sh (4분기 + JSON valid + 버그 회귀) | ✅ |
| B-2: test-statusline-timeout.sh (timeout fallback) | ✅ |
| B-3: test-install-guards.sh (manifest 가드 + --force backup) | ✅ |
| Makefile `test-integration` 타겟 추가 | ✅ |
| 기존 smoke 13개 회귀 0 확인 | ✅ |
| AI-Ready 재스코어 ≥ 86 확인 | ✅ (86/100) |

## Lessons Learned

- **L1 — `|| true` 패턴은 exit code를 삼킨다**: `set -euo pipefail` 환경에서 exit code 캡처는 `set +e` / cmd / `EXIT_CODE=$?` / `set -e` 패턴만 안전. `cmd || true; EXIT_CODE=$?`는 항상 0.
- **L2 — bash `printf '\b'`는 0x08을 생성한다**: shell spec에서 `\b`는 backspace (0x08). 제어문자는 sed가 아닌 `tr -d`로 스트립해야 한다.
- **L3 — 통합 테스트 픽스처 재활용**: `tests/fixtures/sample-project`와 `statusline-cmd`, `statusline-timeout` 기존 픽스처를 그대로 활용 → 새 픽스처 0건 추가로 3개 smoke 완성.
- **L4 — AI-Ready 스코어러가 오감지하는 항목은 명시적으로 제외**: lock 파일(의존성 없음), src/ 분리(shell repo 구조 불일치), test/source 비율(소스 파일 0으로 계산)은 Out of scope 확정 후 구현 집중.

## 다음 후보 (보류)

| 항목 | 조건 |
|------|------|
| Docker / docker-compose.yml | 현재 meta repo 성격상 불필요. v1.18+ 필요 증거 누적 시 |
| test/source 비율 (스코어러 오감지) | 스코어러 자체 .sh 인식 개선 필요 (v1.18+ 스코어러 개선) |
| src/ 분리 | shell/Markdown repo 특성상 부적합. 변경 없음 |
