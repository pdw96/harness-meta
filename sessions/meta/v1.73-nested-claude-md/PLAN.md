# meta v1.73-nested-claude-md — PLAN

세션 시작: 2026-05-05
직접 선행 세션: [`sessions/meta/v1.72-docs-cleanup/`](../v1.72-docs-cleanup/PLAN.md)

목적: root CLAUDE.md 1 파일에 누적된 운영 가이드를 모듈 디렉토리별로 분할하여 Claude Code의 on-demand subdirectory 로딩을 활용. 토큰 효율 + 컨텍스트 정확도 향상.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(1) `CLAUDE.md` 축소 + S1a(1) `claude/CLAUDE.md` + S2(2) `bootstrap/CLAUDE.md` + `bootstrap/skills/CLAUDE.md` + S2/S3(1) `tests/CLAUDE.md` + S3(1) `sessions/CLAUDE.md` = 6/6 meta
- **T1 경로 다수결** — meta scope 6/6
- **T2 스펙 vs 값** — 모듈별 CLAUDE.md 분할 정책 = 모든 프로젝트 영향 → meta

## Scope inheritance (verbatim from 선행 세션 + 사용자 발의)

**Source 1 — `sessions/meta/v1.72-docs-cleanup/REPORT.md` 후속 세션 §** (verbatim):

> "**`v1.73-nested-claude-md`** | 사용자 발의 (2026-05-05 확정) | 모듈별 CLAUDE.md 분할 — root CLAUDE.md 축소 + `bootstrap/CLAUDE.md` / `bootstrap/skills/CLAUDE.md` / `claude/CLAUDE.md` / `tests/CLAUDE.md` / `sessions/CLAUDE.md` 5개 신설. A안 (Claude Code only, AGENTS.md root 유지) 채택. context7 검증 완료"

**Source 2 — context7 spec 인용** (Claude Code memory.md):

> "Claude can discover these files in subdirectories, loading them when those specific subdirectories are accessed. ... Files in subdirectories are loaded on demand when Claude accesses files within those directories."

**Source 3 — 사용자 발의 (2026-05-05) verbatim**:

> "정리하는김에 claude.md를 각 모듈마다 작성해서 효율적으로 운영하게 만들고 싶은데" → "A안으로 진행" → "X2안으로 진행"

**Parsed sub-items (6)**:

1. **root `CLAUDE.md` 축소** — 진입점 + 핵심 규칙(CRITICAL) + 하위 모듈 포인터만 유지. 도메인별 상세는 모듈로 이관
2. **`bootstrap/CLAUDE.md` 신설** — 인터뷰 / 매니페스트 / templates / docs 운영 가이드
3. **`bootstrap/skills/CLAUDE.md` 신설** — 글로벌 user-skill 작성 규약 (SKILLS.md cross-ref + 작성 패턴)
4. **`claude/CLAUDE.md` 신설** — 글로벌 레이어 (hook / statusline / slash command) 운영 가이드
5. **`tests/CLAUDE.md` 신설** — smoke 작성 패턴 + `--fix` mode 규약 + pre-commit 통합
6. **`sessions/CLAUDE.md` 신설** — PLAN/REPORT 작성 패턴 + Scope contract + Spec verification §

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| AGENTS.md 모듈별 분할 (다른 AI 도구 nested 지원) | 별 후속 (B안 / C안 — evidence-driven) |
| `projects/CLAUDE.md` 신설 | 미적용 (`projects/<name>/`은 Bootstrap S6에서 별도 처리, 모듈 단위 가이드 불필요) |
| `docs/CLAUDE.md` 신설 | 미적용 (ADR만 있어 모듈화 가치 낮음) |
| 모듈별 CLAUDE.md 자동 검증 smoke | 별 후속 (evidence-driven, drift 발생 시) |
| 기존 도메인 docs(`bootstrap/docs/*.md`) 내용 변경 | 본 세션 scope 외 — 모듈 CLAUDE.md는 cross-ref만 |
| 외부 도구(Cursor / Codex CLI 등)에 대한 nested AGENTS.md 도입 | A안 채택으로 의도적 제외 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | CLAUDE.md memory hierarchy / nested subdirectory loading / on-demand load |
| **findings** | see citations below |
| **drift** | no — Claude Code 공식 spec이 nested CLAUDE.md를 명시 지원 (subdirectory on-demand load + parent 디렉토리 일괄 로드) |
| **re-verify** | Claude Code memory spec 변경 시 또는 nested 로딩 동작 변경 시 |

**Citations**:

- C1 — Subdirectory CLAUDE.md는 해당 디렉토리 파일 접근 시 on-demand 로드 (Source: `https://code.claude.com/docs/en/memory`)
- C2 — Parent 디렉토리 CLAUDE.md는 세션 시작 시 일괄 로드 (Source: `https://code.claude.com/docs/en/features-overview`)
- C3 — 권장: CLAUDE.md 200 lines 이하 유지 + 참고 자료는 skills로 이관 (Source: `https://code.claude.com/docs/en/features-overview`)
- C4 — 사용자 직접 검증 가능: `/memory` 명령어로 로드된 메모리 확인 (Source: `https://code.claude.com/docs/en/debug-your-config`)

## 1. 분할 매트릭스

| 파일 | 적재 시점 | 핵심 내용 | 출처 (현 root CLAUDE.md) |
|------|----------|---------|---------------------|
| **root `CLAUDE.md`** (축소) | 항상 | 진입점 + 기술 스택 + 구조 규칙(CRITICAL) + 명령어 entry + 하위 모듈 포인터 | §1~7 (보존) + §관련 문서 (간소화) |
| **`bootstrap/CLAUDE.md`** | bootstrap/ 작업 시 | 인터뷰 흐름 / 매니페스트 / templates / 도메인 docs 진입 | §명령어(설치) + §디렉토리 구조 bootstrap/ + 관련 문서 bootstrap/* |
| **`bootstrap/skills/CLAUDE.md`** | skills/ 작업 시 | 글로벌 user-skill 5건 매트릭스 + 작성 규약 | SKILLS.md cross-ref 압축 |
| **`claude/CLAUDE.md`** | claude/ 작업 시 | 글로벌 레이어 3종(commands/hooks/statusline) + symlink 정책 | §디렉토리 구조 claude/ + install 정책 |
| **`tests/CLAUDE.md`** | tests/ 작업 시 | smoke 작성 패턴 + `--fix` mode 규약 + pre-commit 통합 | §명령어(pre-commit) + 관련 smoke 파일 |
| **`sessions/CLAUDE.md`** | sessions/ 작업 시 | PLAN/REPORT 작성 패턴 + Scope contract + Spec verification § + ROADMAP 운영 | §개발 프로세스 + Scope contract + SPEC_VERIFICATION |

## 2. root CLAUDE.md 축소 전략

**유지 (CRITICAL)**:

- 헤더 + License + AGENTS.md 관계 (필수, 다른 AI 도구도 봐야 할 진입점)
- §기술 스택 (간단)
- §구조 규칙 (CRITICAL) — 5종 / no-op / index.json 금지 등
- §개발 프로세스 (간단 핵심)
- §명령어 §세션 시작 (간단 — 모듈 포인터)
- §환경변수
- §관련 문서 (간소화 — 핵심 5개만)

**이관 (모듈로)**:

- §명령어 §설치 / 재설치 → `bootstrap/CLAUDE.md` + `claude/CLAUDE.md`
- §명령어 §pre-commit → `tests/CLAUDE.md`
- §디렉토리 구조 상세 → 각 모듈 CLAUDE.md
- 관련 문서 cross-ref 상세 (interview / overlay / skills / spec verification) → 각 모듈 CLAUDE.md

**목표**: root 200줄 이하 (현 146줄, 축소 후 80~100줄 예상)

## 3. 변경 대상 (1 수정 + 5 신규)

### 수정 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `CLAUDE.md` (root) | S3 | 축소 — 모듈 포인터 + CRITICAL 규칙만 |

### 신규 (5)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/CLAUDE.md` | S2 | bootstrap/ 모듈 진입점 (인터뷰 / 매니페스트 / templates / docs) |
| `bootstrap/skills/CLAUDE.md` | S1c/S2 | 글로벌 user-skill 작성 규약 (SKILLS.md cross-ref) |
| `claude/CLAUDE.md` | S1a | 글로벌 레이어 (hook / statusline / slash command) |
| `tests/CLAUDE.md` | S2/S3 | smoke 작성 패턴 + `--fix` mode |
| `sessions/CLAUDE.md` | S3 | PLAN/REPORT 작성 + Scope contract + Spec verification |

### 신규 세션 파일 (2)

| 경로 | 역할 |
|------|------|
| `sessions/meta/v1.73-.../PLAN.md` | 본 파일 |
| `sessions/meta/v1.73-.../REPORT.md` | 종료 시 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 PLAN 확인**
- [ ] Stage A — `bootstrap/CLAUDE.md` 신규
- [ ] Stage B — `bootstrap/skills/CLAUDE.md` 신규
- [ ] Stage C — `claude/CLAUDE.md` 신규
- [ ] Stage D — `tests/CLAUDE.md` 신규
- [ ] Stage E — `sessions/CLAUDE.md` 신규
- [ ] Stage F — root `CLAUDE.md` 축소
- [ ] Stage G — smoke 회귀 검증 + REPORT.md
- [ ] 커밋 (사용자 확인 후)

## 5. 성공 기준

- [ ] root CLAUDE.md 축소 후 200 lines 이하
- [ ] 5 모듈 CLAUDE.md 모두 신규 + 각각 100 lines 이하 (작은 모듈은 50 미만)
- [ ] 모든 모듈 CLAUDE.md에 root로 돌아가는 cross-ref 명시
- [ ] root CLAUDE.md에 5 모듈 진입점 포인터 명시
- [ ] 모듈 분할 후에도 기존 도메인 docs(`bootstrap/docs/*.md`) 단일 소스 유지 (CLAUDE.md는 cross-ref만)
- [ ] smoke 회귀 0 (smoke-spec-verification + smoke-scope-contract + smoke-roi-regression)
- [ ] verify.ps1 / verify.sh 영향 0 (모듈 CLAUDE.md는 verify 대상 외)

## 6. 위험과 회피

| 위험 | 회피 |
|------|------|
| 모듈 CLAUDE.md ↔ root CLAUDE.md 내용 중복 | 모듈은 본문, root는 포인터 한 줄 — 중복 금지 |
| 모듈 CLAUDE.md ↔ `bootstrap/docs/*.md` 내용 중복 | 모듈 CLAUDE.md는 cross-ref + 운영 요약만, 상세는 docs/ 단일 소스 유지 |
| 다른 AI 도구가 nested CLAUDE.md 못 읽음 | A안 채택 — 의도적. AGENTS.md root 유지로 baseline 보장 (Out of scope 명시) |
| Subdirectory CLAUDE.md @import 깊이 | Claude Code @import max depth 5 — 본 세션 도입 모듈 CLAUDE.md는 root 1 hop, docs/* 2 hop. 여유 |
| 기존 사용자 워크플로 영향 | 없음 — Claude Code 자동 로드 정책. 명시 invoke 불필요 |

## 7. 커밋 전략

```
feat(meta): sessions/meta/v1.73-nested-claude-md — 모듈별 CLAUDE.md 분할 (A안)

- add: bootstrap/CLAUDE.md (Bootstrap 운영 가이드)
- add: bootstrap/skills/CLAUDE.md (글로벌 user-skill 작성 규약)
- add: claude/CLAUDE.md (글로벌 레이어 — hook/statusline/slash command)
- add: tests/CLAUDE.md (smoke 작성 패턴 + --fix mode)
- add: sessions/CLAUDE.md (PLAN/REPORT + Scope contract + Spec verification)
- update: CLAUDE.md (root) — 축소, 모듈 포인터로 전환

Scope: A안 채택 (Claude Code primary, root AGENTS.md 유지).
context7 검증: code.claude.com memory + features-overview spec 정합 (subdirectory on-demand load).
회귀 0 — smoke 3종 PASS.
```

## 8. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.73b-agents-md-nested` | 다른 AI 도구도 module-level granularity 필요 evidence 등장 시 (B안) |
| `v1.73c-claude-md-drift-smoke` | root ↔ 모듈 CLAUDE.md 내용 중복/drift 발생 evidence 시 자동 검증 smoke 도입 |
| `v1.74-projects-claude-md` | `projects/<name>/CLAUDE.md` 모듈 단위 가이드 도입 evidence (현재 Bootstrap S6에서 처리, 별도 도입 불필요) |
