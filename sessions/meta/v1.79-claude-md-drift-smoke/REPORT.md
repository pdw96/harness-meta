# REPORT — v1.79-claude-md-drift-smoke

## 최종 결과

- **smoke 신설**: `tests/smoke-claude-md-drift.sh` (4 Stage, 16/16 PASS)
- **변경 파일**: 3 (smoke-claude-md-drift.sh + tests/CLAUDE.md + CLAUDE.md)
- **회귀**: spec-verification 567/567 + scope-contract 180/180 + cross-ref 1/1 PASS

## 구현 요약

| 목표 | 구현 | 결과 |
|------|------|------|
| `tests/smoke-claude-md-drift.sh` 신설 (4 Stage) | S1 존재 5건 + S2 back-ref 5건 + S3 중복 블록 5건 + S4 count 정합 1건 | 16/16 PASS |
| `tests/CLAUDE.md` count 26→27 + row 추가 | "현 26 파일"→"현 27 파일" + `smoke-claude-md-drift.sh` row 삽입 | 완료 |
| `CLAUDE.md` "smoke 26 매트릭스"→"smoke 27 매트릭스" | root 모듈 표 tests/ 행 갱신 | 완료 (S4 PASS 검증) |

## 판정

- [x] D1/D2: `tests/smoke-claude-md-drift.sh` 신설 (4 Stage) — 16/16 PASS
- [x] `tests/CLAUDE.md` smoke 매트릭스 1 row 추가 + count 26→27
- [x] `CLAUDE.md` root 모듈 표 "smoke 26 매트릭스" → "smoke 27 매트릭스"
- [x] 기존 smoke 회귀 0 (scope-contract 180/180 + spec-verification 567/567 + cross-ref 1/1)

**전원 PASS. PLAN 체크박스 완수.**

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `claude-code` |
| **topic** | Subdirectory CLAUDE.md hierarchical on-demand loading |
| **findings** | Claude Code는 **Read tool로 해당 디렉토리 내 파일을 읽을 때** on-demand 로드 (세션 시작·파일 쓰기/생성 시 트리거 안 됨). /compact 후 재주입 없음. 계층 구조 권장. (context7 `/anthropic/claude-code` docs/memory.md 확인) |
| **drift** | no — 본 smoke는 파일 내용 정합성 검증이며 spec 변화와 무관 |
| **re-verify** | drift=no → 재검증 불필요 |

**Citations**: context7 `/anthropic/claude-code` — Memory and CLAUDE.md files, subdirectory loading behavior.

## Lessons Learned

- **L1 — Spec verification 볼드 형식 필수**: smoke-spec-verification.sh Stage 2는 `| **library** |` 볼드 형식을 요구. `| library |` 평문 → FAIL. PLAN 초안 작성 시 반드시 볼드 사용.
- **L2 — S3 구조적 행 필터 효과 확인**: 5-line sliding window에서 60% 이상 `#`/`|`/`-`/`>` 행인 경우 skip. root CLAUDE.md의 모듈 표(5행 all `|`)가 자동 필터링 — false positive 0.
- **L3 — bootstrap/skills/ back-ref 계층 의도적 설계**: `bootstrap/skills/CLAUDE.md`의 `../CLAUDE.md`는 `bootstrap/CLAUDE.md`(부모)를 가리킴. skills→bootstrap→root 계층. S2는 경로 depth 무관 "상위 링크 존재 여부"만 검사하면 충분.
- **L4 — S4 단일 원자적 커밋**: smoke 파일 추가 시 count가 즉시 변하므로 smoke 파일 + CLAUDE.md + tests/CLAUDE.md 3개를 단일 커밋으로 묶어야 S4 PASS.

## 다음 후보 (보류)

| 후속 세션 | trigger | 분류 |
|---------|---------|------|
| `v1.79b-claude-md-drift-precommit` | pre-commit hook 등록 — smoke-cross-ref 패턴 답습. broken evidence 재발 시 | B |
