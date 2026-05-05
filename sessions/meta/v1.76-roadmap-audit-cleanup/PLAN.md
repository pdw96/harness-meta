# PLAN — v1.76 ROADMAP audit + cleanup

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: `sessions/meta/ROADMAP.md` 1 파일 (운영 docs, S2 정책 인접)
- T5 (애매하면 meta) 적용 — 메타 정책 통합 view 단일 소스 (CLAUDE.md "구조 규칙 (CRITICAL)" 운영 docs 예외 1 파일)
- v1.72 docs-cleanup 패턴 답습 — 동일 ROADMAP 정정 작업

## Scope inheritance (verbatim from 사용자 발의)

**Source — 사용자 발의 (v1.76 `/harness-meta` `재진행` + AskUserQuestion 응답)** (verbatim):

> ROADMAP audit + cleanup: ROADMAP.md §3 trigger 대기 항목 재점검 — 완료된 trigger 누락 정리, 분류 재평가, evidence 도달 항목 promote 후보 식별. v1.72 docs-cleanup 패턴 답습.

**Parsed sub-items (4 — pre-PLAN audit round 확정)**:

1. **§2 stale 안내문 갱신** — `현재 진행 가능 활성 항목 0건 — v1.73 완료 후` → 시점 generic 또는 v1.75 기준 갱신
2. **§3-F 빈 섹션 제거** — v1.36 신규 카테고리 0건 + 운영 가치 소진 (실 콘텐츠 §3-A 이전 완료)
3. **v1.75d 분류 정정** — §3-A → §3-B 이동 (trigger "drift evidence 1+ 발생" = 회귀/장애 evidence 정합)
4. **§1 audit 일자 갱신** — `(v1.75-module-context-injection 기준)` → `(v1.76-roadmap-audit-cleanup 기준)`

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| ROADMAP §1 trigger 분류 (5종) 자체 재설계 | 후속 미정 (T2 spec 변경 — 별도 메타 세션) |
| §8 최근 완료 row 형식 재구조화 | 후속 미정 (`harness-roadmap-update` SKILL 형식 변경 동반 필요) |
| ROADMAP의 cross-ref(`OVERLAY.md` / `SKILLS.md` 등) drift 검증 | v1.75d (재분류 후 §3-B) 또는 v1.73c trigger |
| `projects/<name>/ROADMAP.md` 점검 | 프로젝트 세션별로 분리 (S4 scope) |
| §3-A v1.75b(누락 evidence 5+) 재분류 | 사용자 행동 패턴 trigger = §3-A 정합 (audit에서 재확인 완료) |
| §3-A 다른 row 일괄 재분류 | 본 audit에서 검증 완료 — 정합 확인 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 ROADMAP 1 파일 정정, 외부 spec 의존 없음 |
| **re-verify** | N/A |

**Citations**: N/A (Anthropic / TOML / shell / Claude Code spec 모두 무관)

## 배경

- 선행: [`sessions/meta/v1.72-docs-cleanup/`](../v1.72-docs-cleanup/) (2026-05-05) — ROADMAP §3 ✅ 완료 21건 행 삭제 + CLAUDE.md/README.md 오기 수정
- 이후 v1.73~v1.75 진행 중 §3-A 신규 등록 6건 (v1.73b + v1.74b/c + v1.75b/c/d) + §3-B 신규 1건 (v1.73c) 누적
- v1.75 REPORT 후속 §3-A 3건 등록 시 분류 1건(v1.75d) drift evidence 의존 → §3-A보다 §3-B 적합
- §3-F는 v1.36에서 신규 카테고리로 도입했으나 v1.37 인프라 완료 후 0건 — 운영 가치 소진
- §2 활성 후보 0건 안내문 "v1.73 완료 후" stale (v1.74/v1.75 추가 완료)

## 목표

- [ ] §2 stale 안내문 갱신 (시점 generic 권장)
- [ ] §3-F 빈 섹션 + 설명문 제거
- [ ] v1.75d row §3-A → §3-B 이동, count 라벨 갱신 (16→15, 11→12)
- [ ] §1 audit 일자 갱신 (v1.76 기준)
- [ ] smoke-roadmap-sync 회귀 0 (default + `--include-legacy`)
- [ ] smoke-spec-verification + smoke-scope-contract 회귀 0
- [ ] PLAN/REPORT 한 쌍 + 단일 commit

## 변경 대상

- `sessions/meta/ROADMAP.md` (단일 파일)
- `sessions/meta/v1.76-roadmap-audit-cleanup/{PLAN.md, REPORT.md}` (세션 기록)

## 성공 기준

- [ ] §2 안내문 갱신 — "v1.73 완료 후" 표현 제거
- [ ] §3-F 헤더 + 설명문 완전 제거 (검색 0 hit)
- [ ] §3-A에서 v1.75d row 제거, §3-B에 추가, count 라벨 정합 (15+12=27, 합계 35→35 유지)
- [ ] §1 last audit 일자 v1.76 반영
- [ ] smoke 3종 (roadmap-sync default + spec-verification + scope-contract) PASS
- [ ] git diff `sessions/meta/ROADMAP.md` 변경 4 hunk 이내 (의도 외 회귀 0)
- [ ] PLAN.md `Scope inheritance` 4 sub-item ↔ REPORT.md 구현 4건 1:1 매핑 가능

## 커밋 전략

단일 커밋:

```text
docs(meta): sessions/meta/v1.76-roadmap-audit-cleanup — ROADMAP §3 분류 정정 + §2 안내문 갱신
```

- 변경 4 영역(§1 audit 일자 / §2 안내문 / §3-F 제거 / §3-A→B v1.75d 이동) + PLAN/REPORT 2 파일

## 후속 세션 연결

- **선행**: [`v1.72-docs-cleanup/`](../v1.72-docs-cleanup/) — cleanup 패턴 source
- **후속 (잠재)**:
  - §3 row evidence 도달 시 §2 promote — 세션별 발의
  - ROADMAP §1 trigger 분류 재설계 시 별도 메타 세션
