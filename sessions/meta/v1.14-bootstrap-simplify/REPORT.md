# meta v1.14-bootstrap-simplify — REPORT

세션 완료: 2026-04-28
선행 세션: [`sessions/meta/v1.13-opensource-entry/`](../v1.13-opensource-entry/REPORT.md)

## 최종 결과

- 수정 파일 6건 (세션 문서 제외)
- Bootstrap 흐름: 10 stages → 8 stages
- Interview: 13Q → 7 유효 질문 (Q7/Q8/Q9 자동, Q11/Q12 이연)
- Smoke 회귀 0: render 7/7 + agents-md 6/6 + language-overlay 11/11 + scope-contract 22/22

## 구현 요약

| Stage | 파일 | 변경 내용 |
|-------|------|---------|
| A — harness-meta.md | `claude/commands/harness-meta.md` | Bootstrap 표 10→8행 (S9 제거, S3+S4→S3, S5-S8→S4-S6, S10→S7), S2 설명 "13 질문" → "7 유효 질문" |
| B — interview.md | `bootstrap/interview.md` | 코어 Q7 제거, 옵션 Q8/Q9 제거, 자유 Q11/Q12 제거, 자동 적용 7→10건, Stage S3~S7 흐름 갱신 |
| C — INTERVIEW_FLOW.md | `bootstrap/docs/INTERVIEW_FLOW.md` | 제목 + §2 표 10→8행, §3.2 env 매핑 Q7/Q8/Q9 "자동 설정" 표기 + Q11/Q12 "이연" 표기, §4 실패 정책 S3+S4→S3 통합 + S9→S7 재번호 |
| D — INTERVIEW.md skeleton | `bootstrap/skeletons/projects/INTERVIEW.md` | 143L → 55L (Q7/Q8/Q9/Q11/Q12/Q13 블록 제거, 자동 적용 10건으로 갱신) |
| E — CLAUDE.md | `CLAUDE.md` | Bootstrap 참조 "10-stage" → "8-stage", "자동 적용 7건 manifest 4" → "10건 manifest 7" |
| F — smoke-scope-contract.sh | `tests/smoke-scope-contract.sh` | glob 패턴 v1.12*/v1.13*/v1.14* 추가 (v1.14 PLAN.md 자동 검사) |

### 핵심 설계 결정

**Q7 auto-drop 방법** (render-manifest.sh `:?` 제약 해결):

- `render-manifest.sh:31` `: "${HM_META_REF:?required}"` — 스크립트 수정 없이, Claude가 S2 완료 후 `export HM_META_REF="projects/${HM_NAME}/ARCHITECTURE.md"` 자동 설정

**S3+S4 통합**:

- render stdout → 인라인 미리보기 표시 → 사용자 "확정?" → 파일 write → round-trip 검증을 단일 S3으로 통합
- 기존 literal template (`=== .harness.toml preview ===` 블록)은 유지

**Q11/Q12 이연**:

- 인터뷰 제거 대신 S7 후속 안내에 "ARCHITECTURE.md의 observability·CI 항목 후속 작성" 안내 추가
- INTERVIEW.md 스켈레톤에서도 블록 제거 (post-bootstrap 자유 기록으로 이연)

## PLAN 체크박스 판정

- [x] Bootstrap 흐름: 10 stages → 8 stages (`harness-meta.md` Bootstrap 표)
- [x] Interview: 13Q → 7 effective (Q7/Q8/Q9 auto, Q11/Q12 post-bootstrap 이연)
- [x] S3+S4 통합: `harness-meta.md` + `INTERVIEW_FLOW.md`에서 단일 S3으로 표기
- [x] S9 제거: 3개 문서에서 S9(README 등록) 행/단락 삭제
- [x] `INTERVIEW.md` 스켈레톤: Q7/Q8/Q9/Q11/Q12/Q13 블록 제거 → 55L (목표 ~50L)
- [x] `CLAUDE.md` Bootstrap 표: `harness-meta.md`와 동기 (8-stage, 10 auto)
- [x] 기존 smoke 회귀 0 (`tests/smoke-bootstrap-*.sh`, `smoke-language-overlay.sh`, `smoke-scope-contract.sh`)

## Lessons Learned

- **L1 — render-manifest.sh `:?` 제약은 스크립트 수정 없이 해결** — Claude가 render 호출 전 env var 자동 설정으로 충분. "스크립트 수정 필요" 오판 방지: `render-manifest.sh` out-of-scope 결정이 맞았음
- **L2 — smoke glob 패턴은 신규 세션 추가 시 함께 확장** — v1.12/v1.13/v1.14가 scope contract를 준수하고 있었지만 glob 미포함. `smoke-scope-contract.sh` 갱신을 신규 세션과 함께 하는 것이 자연스러운 패턴
- **L3 — Q11/Q12 이연은 삭제가 아님** — 스켈레톤에서 블록 제거 = bootstrap 완료 후 ARCHITECTURE.md에 직접 작성하는 방식으로 전환. "질문 줄이기"가 아니라 "수집 시점 변경"

## 후속

- v1.15: AGENTS.md.tmpl Q11/Q12 observability/CI 섹션 skeleton 갱신 (bootstrap S7 안내와 정합)
- v1.21: `install.sh` macOS/Linux Stage 1 지원
- v1.14~v1.20 (adapter): Cursor, Codex, Gemini 각 overlay 도입
