# plan-1-milestone-exclusion — PLAN

**목표**: `tests/smoke-cross-ref.sh`에 `milestones/v*/` 제외 추가 + `_VER_SESS` depth 완화

## 목표 체크박스

- [ ] `_VER_MILE` regex 신규 (`^milestones/v\d+\.\d+[^/]*/.*\.md$`)
- [ ] `_VER_SESS` `[^/]+\.md$` → `.*\.md$`
- [ ] `should_exclude()` — `_VER_MILE` 분기 추가
- [ ] smoke comment (헤더) 제외 목록 갱신
- [ ] E2E: milestone fixture broken ref → PASS (제외 동작 확인)
- [ ] E2E: living doc broken ref → FAIL (기존 동작 유지)
- [ ] smoke 회귀 0 (cross-ref PASS=1 + scope-contract + spec-verification)

## Phase 매트릭스

| phase | 변경 파일 | commit 메시지 |
|:-----:|---------|--------------|
| 1 | `tests/smoke-cross-ref.sh` | `fix(meta): v1.86 plan-1 phase-1 — smoke-cross-ref milestones/ 제외 추가` |
| 2 | (milestone REPORT 작성만, 파일 수정 없음) | — |

## 변경 파일

| 파일 | 변경 내용 |
|------|---------|
| `tests/smoke-cross-ref.sh` | `_VER_MILE` 신규 regex + `_VER_SESS` depth 완화 + `should_exclude` 분기 + comment 갱신 |

## 성공 기준

- smoke-cross-ref PASS=1 (기존 clean 유지)
- E2E fixture 검증 통과 (exclude=yes + exclude=no 양쪽)
- scope-contract / spec-verification 회귀 0

## 의존성

- 선행: 없음
- 후행: milestone REPORT.md → ROADMAP 갱신 (Stage E)
