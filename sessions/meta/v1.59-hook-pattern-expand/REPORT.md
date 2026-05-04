# meta v1.59-hook-pattern-expand — REPORT

세션 완료: 2026-05-04

## 최종 결과

- 변경 파일: 2 (`claude/hooks/post-report-write.sh`, `tests/smoke-posttooluse-hook.sh`)
- smoke: 20/20 PASS (기존 18 회귀 0 + 신규 P + Q 2건)
- 회귀: 0

## 구현 요약

### Stage A — hook 수정 (`claude/hooks/post-report-write.sh`)

v1.59 헤더 추가 + 3개소 변경:

1. **path 정규화 블록**: `REPORT.(md|ipynb)` 단일 체크 → `FILE_TYPE` 분기 (`REPORT` | `PLAN`)

   ```bash
   FILE_TYPE=''
   if ...REPORT\.(md|ipynb)$; then FILE_TYPE='REPORT'
   elif ...PLAN\.md$; then FILE_TYPE='PLAN'
   else NOOP
   ```

2. **변수명 변경**: `REPORT_BASENAME` → `FILE_BASENAME` (PLAN.md 포함 범용 표현)

3. **MSG 라우팅**: `FILE_TYPE=PLAN` → `/harness-plan-verify` 안내, `REPORT` → 기존 `/harness-roadmap-update` 안내

### Stage B — smoke 수정 (`tests/smoke-posttooluse-hook.sh`)

헤더 갱신 (v1.59 1줄, 총 20/20) + Stage 2 카운트 14→17 + Test P + Q 신규:

- **Test P**: `sessions/meta/v1.59-test/PLAN.md` Write → `harness-plan-verify` 포함 additionalContext → ✓
- **Test Q**: `docs/PLAN.md` (non-sessions 경로) Write → `{}` NOOP → ✓

## 판정

| 성공 기준 | 결과 |
|---------|------|
| hook: sessions/**/PLAN.md Write → harness-plan-verify 안내 | ✅ |
| hook: sessions/**/PLAN.md 외 → NOOP 유지 | ✅ |
| hook: sessions/**/REPORT.md → 기존 동작 유지 (회귀 0) | ✅ |
| smoke 20/20 PASS | ✅ |
| FILE_BASENAME 치환 (MSG 내용 동일) | ✅ |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 regex 확장 + MSG 라우팅만. 구현 중 신규 spec drift 없음 |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — FILE_TYPE 분기 패턴**: 감지 대상이 늘어날 때 `elif` 체인으로 확장 가능. 향후 ARCHITECTURE.md 등 추가 시 동일 패턴 재사용
- **L2 — MSG 라우팅과 파일명 독립**: REPORT_BASENAME → FILE_BASENAME 변수명 정리로 PLAN.md MSG에서도 basename 재사용 가능해짐 (PLAN MSG에서는 현재 미사용이지만 확장 시 활용 가능)

## 다음 후보 (보류)

| 항목 | trigger 분류 | 조건 |
|------|:---:|------|
| hook 파일명 변경 (`post-report-write.sh` → `post-harness-write.sh` 등) | E | PLAN.md 외 추가 파일 패턴 등장 시 의미 불명확 심화 evidence 3+ |
| PLAN.md 섹션명 추출 | A | PLAN MSG에 섹션 포함 유용성 evidence |
| 추가 파일 패턴 (ARCHITECTURE.md 등) | A | 사용자 요청 evidence |
