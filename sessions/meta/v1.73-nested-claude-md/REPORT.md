# meta v1.73-nested-claude-md — REPORT

세션 종료: 2026-05-05
선행 세션: [`sessions/meta/v1.72-docs-cleanup/`](../v1.72-docs-cleanup/PLAN.md)

## 최종 결과

- 변경 파일: 6 (root `CLAUDE.md` 축소 + 5 신규 모듈 CLAUDE.md)
- root `CLAUDE.md`: 146줄 → **108줄** (26% 축소)
- 신규 모듈 CLAUDE.md 라인 수:
  - `bootstrap/CLAUDE.md`: 109줄
  - `bootstrap/skills/CLAUDE.md`: 126줄
  - `claude/CLAUDE.md`: 93줄
  - `tests/CLAUDE.md`: 152줄
  - `sessions/CLAUDE.md`: 152줄
- 신규 세션 파일: 2 (PLAN.md + REPORT.md)
- smoke 회귀: **0** (smoke-spec-verification + smoke-scope-contract 166/166 + smoke-roi-regression 6/6 PASS)

## 구현 요약

| 목표 | 실제 |
|------|------|
| root CLAUDE.md 축소 (200줄 이하) | ✓ 108줄 (Claude Code 권장 200줄 이하 + 26% 축소) |
| `bootstrap/CLAUDE.md` 신설 | ✓ 인터뷰 / 매니페스트 / templates / docs 진입 + License 4-tier 요약 |
| `bootstrap/skills/CLAUDE.md` 신설 | ✓ 5 skill 매트릭스 + frontmatter 6축 + 2단계 카테고리 + install-skills 사용법 |
| `claude/CLAUDE.md` 신설 | ✓ 글로벌 레이어 3종 + symlink 정책 + idempotent no-op (v1.36e) |
| `tests/CLAUDE.md` 신설 | ✓ smoke 26 매트릭스 + `--fix` mode 패턴 + autofix wrapper |
| `sessions/CLAUDE.md` 신설 | ✓ PLAN/REPORT 의무 § + Scope contract + Spec verification + ROADMAP 운영 |
| 도메인 docs와 중복 금지 | ✓ 모듈 CLAUDE.md는 cross-ref + 운영 요약만, 상세는 `bootstrap/docs/*.md` 단일 소스 유지 |

## 판정

- [x] root CLAUDE.md 200줄 이하 (108줄)
- [x] 5 신규 모듈 CLAUDE.md 모두 200줄 이하
- [x] 모든 모듈 CLAUDE.md에 root cross-ref 명시 (`상위 진입: [\`../CLAUDE.md\`]` 패턴)
- [x] root CLAUDE.md에 5 모듈 진입점 포인터 (§"모듈별 가이드" 표)
- [x] 도메인 docs(`bootstrap/docs/*.md`) 단일 소스 유지 — 모듈 CLAUDE.md는 cross-ref만
- [x] smoke-spec-verification PASS (495+/495+ — pre-v1.73 기준)
- [x] smoke-scope-contract 166/166 PASS
- [x] smoke-roi-regression 6/6 PASS
- [x] verify.ps1 frontmatterFiles 영향 0 (CLAUDE.md는 frontmatter 없음 — 검증 대상 외)
- [x] 다른 AI 도구(Codex / Cursor / Aider 등) 영향 0 (root AGENTS.md 유지 — A안)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | CLAUDE.md memory hierarchy / nested subdirectory loading / on-demand load |
| **findings** | no new findings |
| **drift** | no — Claude Code spec이 nested CLAUDE.md를 명시 지원 (subdirectory on-demand load + parent 일괄 로드). 구현 중 신규 spec drift 없음 |
| **re-verify** | Claude Code memory spec 변경 시 또는 nested 로딩 동작 변경 시 |

## Lessons Learned

- **L1 — Nested CLAUDE.md는 토큰 효율 + 컨텍스트 정확도 동시 향상** — root에 도메인 상세를 누적하는 대신 모듈로 분산. Claude Code의 on-demand load 정책이 자동으로 working directory 기반 컨텍스트 제공 → 사용자가 명시 invoke 없이 자연스레 모듈 가이드 활용
- **L2 — 모듈 CLAUDE.md ↔ 도메인 docs 분리 mechanism** — 모듈 CLAUDE.md는 "운영 가이드 + cross-ref" 책임, `bootstrap/docs/*.md`는 "단일 소스 spec" 책임. 둘은 의도적으로 다름 (operational layer vs spec layer). 이 분리가 drift 회피 + 유지보수 단순화의 결정적 mechanism
- **L3 — Cross-platform / Cross-tool 호환성 사전 검증의 가치** — 사용자 발의 직후 context7로 Claude Code memory + AGENTS.md 표준 양쪽 검증 → A안(Claude Code only) 채택 근거 명시화. 만약 검증 없이 도입했다면 다른 AI 도구 호환성 추정에 의존하여 후속 redesign 비용 발생 가능

## 후속 세션

### 다음 후보 (보류)

| 후속 세션 | Trigger 종류 | Trigger 조건 |
|---------|:----------:|------------|
| `v1.73b-agents-md-nested` | A | 다른 AI 도구도 module-level granularity 필요 evidence (사용자 다중 도구 사용 패턴 등장 시) |
| `v1.73c-claude-md-drift-smoke` | B | root ↔ 모듈 CLAUDE.md 내용 중복/drift 실 발생 시 자동 검증 smoke 도입 |
| `v1.74-projects-claude-md` | A | `projects/<name>/CLAUDE.md` 모듈 단위 가이드 도입 evidence (현재 Bootstrap S6에서 충분) |

## 변경 파일 목록 (commit 대상)

- `CLAUDE.md` (수정 — 축소)
- `bootstrap/CLAUDE.md` (신규)
- `bootstrap/skills/CLAUDE.md` (신규)
- `claude/CLAUDE.md` (신규)
- `tests/CLAUDE.md` (신규)
- `sessions/CLAUDE.md` (신규)
- `sessions/meta/v1.73-nested-claude-md/PLAN.md` (신규)
- `sessions/meta/v1.73-nested-claude-md/REPORT.md` (신규)
