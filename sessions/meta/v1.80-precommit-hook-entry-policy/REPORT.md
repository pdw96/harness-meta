# REPORT — v1.80-precommit-hook-entry-policy

## 최종 결과

- 신규 smoke: 0건 (docs-only)
- 변경 파일: 3건 (`tests/CLAUDE.md` + `sessions/meta/ROADMAP.md` + `sessions/meta/v1.80-*/REPORT.md`)
- 회귀 검증: `smoke-claude-md-drift.sh` 16/16 PASS

## 구현 요약

### H1 — `tests/CLAUDE.md` 정책 섹션 추가 ✅

`§"Pre-commit hook entry 정책" (v1.80+)` 신규 섹션을 `§"Pre-commit 통합"` 직후에 추가:

- **결정 표**: smoke `--fix` 지원 여부 → `entry` 형식 (wrapper vs direct) 2행 매트릭스
- **wrapper 설명**: `--fix` 시도 → 정정 파일 생성 → exit 1 안내 흐름
- **직접 호출 설명**: 사람 판단 필요(콘텐츠 drift 등) → wrapper 불경유 명시
- **현행 4 hook 현황표**: spec-verification/scope-contract/cross-ref (✅ wrapper) + claude-md-drift (❌ direct)

### H2 — ROADMAP §3-E v1.79c trigger 이행 완료 ✅

- §3-E `v1.79c-precommit-hook-direct-vs-wrapper-doc` row 삭제
- §1 audit 일자 갱신 (v1.80 기준)
- §8 최근 완료 entry + §9 확정 세션 entry 추가

## 판정

- [x] `tests/CLAUDE.md`에 wrapper vs direct 기준 섹션 존재
- [x] 현행 4 hook 현황표 포함
- [x] `smoke-claude-md-drift.sh` 16/16 PASS (회귀 0)
- [x] smoke count 27 유지 (신규 smoke 없음)

## Spec verification (context7)

| sub-field | 값 |
|-----------|----|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A |
| **re-verify** | N/A |

외부 라이브러리 spec 검증 없음 (harness-meta 내부 정책 문서화 전용).

## Lessons Learned

- **L1**: §3-E trigger 조건 미달 (2건, 3+ 필요) 상태에서 사용자 발의로 진입 — 정책 명확화 시점이라 ROI 충분. trigger 수 자체보다 "패턴 재현 방지 가치"를 판단 기준으로 삼은 결정.
- **L2**: docs-only trivial scope → 5관점 skip + Plan-verify N/A가 v1.76/v1.78b 패턴으로 안정. 이 패턴 자체도 본 docs(tests/CLAUDE.md)에 추후 언급 가능 (현재는 sessions/CLAUDE.md에 묵시적으로 존재).

## 다음 후보 (보류)

없음 — 본 세션은 §3-E 항목 1건 이행 전용. 신규 evidence-driven 후속 없음.

## 선행 세션

[`../v1.79b-claude-md-drift-precommit/`](../v1.79b-claude-md-drift-precommit/) — §3-E v1.79c 등록 세션.
