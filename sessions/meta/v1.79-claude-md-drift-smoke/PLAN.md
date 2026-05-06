---
milestone: M2-drift-detection-infra
milestone-id: M2
phase: 1
---

<!-- milestone wrap: v1.83 retro classify (ADR-006) -->

# PLAN — v1.79-claude-md-drift-smoke

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `tests/smoke-claude-md-drift.sh` (신규, T5 meta) + `tests/CLAUDE.md` (S1a 모듈 가이드 갱신) + `CLAUDE.md` (S3 repo 정책 — smoke 카운트 갱신)
- T1 다수결: 3파일 모두 harness-meta repo 글로벌 인프라 → S1–S3 = meta 소유

## Scope inheritance (verbatim from 선행 세션 v1.73 + v1.75)

**Source — `sessions/meta/v1.73-nested-claude-md/REPORT.md` Out of scope 표** (verbatim):

> `v1.73c-claude-md-drift-smoke` | B | root ↔ 모듈 CLAUDE.md 내용 중복/drift 실 발생 시 자동 검증 smoke 도입

**Source — `sessions/meta/v1.75-module-context-injection/REPORT.md` Out of scope 표** (verbatim):

> `v1.75d-module-claude-md-drift-smoke` | 모듈 CLAUDE.md 변경 빈도 + drift evidence 1+ 발생 시 자동 감지 smoke 추가

**Parsed sub-items (2)**:

1. **D1 — root ↔ 모듈 CLAUDE.md drift** — 중복/drift 실 발생 시 자동 검증 smoke 도입 (v1.73c)
2. **D2 — 모듈 CLAUDE.md 변경 감지** — 변경 빈도 + drift evidence 1+ 시 자동 감지 smoke 추가 (v1.75d)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `--fix` mode 구현 | content drift는 사람 판단 필요 — 자동 수정 대상 아님 |
| pre-commit hook 등록 | smoke-cross-ref 패턴 답습 여부 evidence-driven — 별도 `v1.79b` |
| `projects/<name>/CLAUDE.md` 모듈 drift | Bootstrap S6 scope, meta 세션 대상 아님 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `claude-code` |
| **topic** | Subdirectory CLAUDE.md hierarchical on-demand loading |
| **findings** | Claude Code는 **Read tool로 해당 디렉토리 내 파일을 읽을 때** on-demand 로드 (세션 시작·파일 쓰기/생성 시 트리거 안 됨). /compact 후 재주입 없음. 계층 구조 권장. (context7 `/anthropic/claude-code` docs/memory.md 확인) |
| **drift** | no — 본 smoke는 파일 내용 정합성 검증이며 로딩 트리거 방식과 무관 |
| **re-verify** | drift=no → 재검증 불필요 |

Citations: context7 `/anthropic/claude-code` — Memory and CLAUDE.md files, subdirectory loading behavior.

## 배경

- **선행 세션**: [`v1.73-nested-claude-md`](../v1.73-nested-claude-md/) — root CLAUDE.md(146줄)를 5개 모듈로 분할 (108줄 축소)
- **동기**: 모듈 분할 이후 drift 방지 인프라 부재. root가 "smoke 26 매트릭스"라고 기술하는 동안 실제 count가 달라지거나, root 내용이 모듈과 중복되어도 감지 불가.
- **본 세션**: `tests/smoke-claude-md-drift.sh` 신설 — 4-stage 정적 검증

## 목표

- [ ] D1/D2: `tests/smoke-claude-md-drift.sh` 신설 (4 Stage)
  - S1: 모듈 CLAUDE.md 존재 확인 (root 표 ↔ 실제 파일)
  - S2: 모듈 → root back-reference 링크 확인
  - S3: root ↔ 모듈 대형 중복 블록 감지 (≥5 연속 동일 행)
  - S4: root "smoke N 매트릭스" 기술 정합 (실제 파일 수 일치)
- [ ] `tests/CLAUDE.md` smoke 매트릭스 1 row 추가 + count 26→27
- [ ] `CLAUDE.md` root 모듈 표 "smoke 26 매트릭스" → "smoke 27 매트릭스"

## 변경 대상

| 파일 | 변경 유형 |
|------|---------|
| `tests/smoke-claude-md-drift.sh` | 신규 |
| `tests/CLAUDE.md` | 수정 (count + row) |
| `CLAUDE.md` | 수정 (smoke count 기술) |

## 구현 설계 — smoke-claude-md-drift.sh

```bash
# Stage S1: 모듈 존재
MODULE_PATHS=(
  "bootstrap/CLAUDE.md"
  "bootstrap/skills/CLAUDE.md"
  "claude/CLAUDE.md"
  "tests/CLAUDE.md"
  "sessions/CLAUDE.md"
)
# → 각 파일 존재 확인

# Stage S2: back-reference (계층 인식)
# 각 모듈 CLAUDE.md에 "상위 진입" + CLAUDE.md 링크 존재 여부 grep
# bootstrap/skills/CLAUDE.md는 ../CLAUDE.md(=bootstrap/CLAUDE.md)로 연결 — 의도적 계층 (skills→bootstrap→root)
# 단순 "../CLAUDE.md" 또는 "../../CLAUDE.md" 문자열 포함 여부 검사

# Stage S3: 중복 블록 검출 (Python 위임)
# python3 -c "..." — root vs 모듈 sliding window 5-line fingerprint 비교
# 필터: 구조적 행(^#, ^|, ^-, ^---) ≥ 3개인 window skip (Markdown 관용 패턴 제외)
# 일치 fingerprint ≥ 1 → FAIL (drift 경고)

# Stage S4: root 기술 count 정합
# smoke_count=$(ls tests/smoke-*.sh | wc -l)
# root_count=$(grep -oE 'smoke [0-9]+ 매트릭스' CLAUDE.md | grep -oE '[0-9]+')
# [ "$smoke_count" == "$root_count" ] || FAIL
```

**총 검증 건수 예상**: S1 5건 + S2 5건 + S3 5건 + S4 1건 = **16건**

## 성공 기준

- [ ] `bash tests/smoke-claude-md-drift.sh` — 16/16 PASS
- [ ] root CLAUDE.md "smoke 27 매트릭스" — 실제 파일 수 일치 (S4 PASS 검증)
- [ ] tests/CLAUDE.md count 27 갱신 확인
- [ ] 기존 smoke 회귀 0 (scope-contract + spec-verification)

## 커밋 전략

3개 파일 **단일 원자적 커밋** 필수 (S4 순환 의존 회피 — 세 파일 동시 갱신해야 S4 PASS):

```
feat(meta): sessions/meta/v1.79-claude-md-drift-smoke — root ↔ 모듈 CLAUDE.md drift smoke 신설
```

## 후속 세션 연결

- `v1.79b-claude-md-drift-precommit`: pre-commit hook 등록 (§3-B, evidence 발생 시)
- 선행: v1.73c + v1.75d ROADMAP §3-B → 본 세션 이행
