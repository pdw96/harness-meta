# Phase Report: {phase-name} ({version})

## Goal-backward 검증

| 요구사항 | Truth | Artifact (경로) | Wired | Tested | 판정 |
|----------|-------|----------------|-------|--------|------|
| R1 | ... | `{src}/module_a.{ext}` | ✓ | `{tests}/test_module_a.{ext}` | VERIFIED |
| R2 | ... | `{src}/module_b.{ext}` | ✓ | `{tests}/test_module_b.{ext}` | VERIFIED |

**판정 요약**: VERIFIED N건 / ORPHANED N건 / STUB N건 / MISSING N건

## 실행 결과

| Step | Name | 시간 | 비용 | Turns | 재시도 |
|------|------|------|------|-------|--------|
| 0 | ... | 120s | $0.45 | 12 | 0 |
| 1 | ... | ... | ... | ... | ... |

**총합**: {total_time}s / ${total_cost} / {total_turns} turns / {total_retries} retries

## /harness-review 결과

| 항목 | 결과 | 근거 |
|------|------|------|
| 아키텍처 준수 | PASS | 프로젝트 ARCHITECTURE 규칙 준수 (예: 지정 디렉토리에 금지 코드 없음) |
| 기술 스택 준수 | PASS | 프로젝트 DECISIONS/ADR 금지 항목 0건 |
| 테스트 존재 | PASS | 프로젝트 테스트 커맨드 `{test_cmd}` — N passed |
| CRITICAL 규칙 | PASS | 프로젝트 CLAUDE.md CRITICAL 섹션의 각 rule 체크 |
| 빌드 가능 | PASS | 프로젝트 타입체크·린트 무오류 |

## 산출물 요약

- `{src}/module_a.{ext}` — ... (N줄)
- `{tests}/test_module_a.{ext}` — ... (N건)
- `.env.example` — 신규 필드 {X, Y}
- `docs/scope/{version}/ADR.md` — ADR-NN 추가 (프로젝트 문서 구조 따름)

## Lessons Learned

- 성공 패턴: ...
- 실패 / 우회: ...
- 다음 phase 개선점: ...

## 테스트 변화

| | Before | After | Delta |
|---|--------|-------|-------|
| 전체 테스트 | N | M | +X |
| 신규 파일 | - | {tests}/test_xxx.{ext} | +L files |

---

> 이 템플릿은 `.claude/skills/harness-ship/report-template.md`에 있음.
> 편집 시 skill 파일을 single source of truth로 유지.
