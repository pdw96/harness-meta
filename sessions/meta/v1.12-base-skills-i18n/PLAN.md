# meta v1.12-base-skills-i18n — PLAN

세션 시작: 2026-04-28
선행 세션: [`sessions/meta/v1.11b-overlay-python-skill/`](../v1.11b-overlay-python-skill/PLAN.md) — harness-python overlay 실 콘텐츠 확정

목적: `bootstrap/templates/_base/.claude/` 전체 파일을 **영문화**. 오픈소스 기여자(비한국어 사용자 + 타 AI 도구)가 skill/agent/output-style 본문을 이해할 수 있도록.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1b(14) `bootstrap/templates/_base/.claude/**` 전체 + S2(2) `bootstrap/templates/python/.claude/skills/harness-python/{SKILL.md,python-quality.md}` = **16/16 meta**
- **T1 경로 다수결** — S1b/S2 全건 meta scope
- **T2 스펙 vs 값** — _base 파일은 모든 프로젝트에 배포되는 메타 소유 템플릿 → meta

## Scope inheritance (verbatim from 사용자 발의)

**Source — 사용자 발의 (2026-04-28) verbatim**:

> "다 해야할거같은데" (오픈소스 multi-language 호환 맥락)
> "오케이" (v1.12 _base 영문화 먼저 진행 확인)

**Parsed sub-items (1)**:

1. **`bootstrap/templates/_base/.claude/` 전체 영문화** — skill body + agent body + output-style body + 참조 파일(templates)을 영문으로 전환. 파일명·frontmatter 키·기술용어·파일경로·명령어는 유지.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| `harness-meta/` repo 자체 문서(CLAUDE.md, README.md, bootstrap/docs/*.md) 영문화 | 별도 세션 (관리자 문서 — evidence-driven) |
| 세션 문서(sessions/**/*.md) 소급 영문화 | 소급 불필요 (OWNERSHIP.md history) |
| v1.13 README + AGENTS.md 오픈소스 진입점 작성 | 후속 세션 |
| v1.14 Bootstrap 흐름 단순화 | 후속 세션 |
| upbit `.claude/` 재설치 (영문화 반영) | upbit에서 `install-project-claude --force` 재실행 (사용자) |

## 1. 번역 원칙

1. **파일명 유지** — `harness/SKILL.md`, `harness-plan/SKILL.md` 등 그대로
2. **frontmatter 키 유지** — `name:`, `description:`, `allowed-tools:`, `model:`, `effort:` 등 field 이름 그대로
3. **기술 용어 유지** — 파일 경로, 명령어, TOML 키, PM 이름(uv/poetry/ruff/mypy 등)
4. **name/description 값 번역** — frontmatter의 `description:` 값은 영문으로
5. **본문 전체 영문화** — 섹션 헤더, 표, 지시문, 예시 설명 등
6. **기존 영어 구절 유지** — 이미 영어로 된 부분은 그대로
7. **한국어 코멘트 삭제** — 코드 블록 안 `# 한국어 주석`도 영문 또는 삭제

## 2. 번역 대상 (14 files + 2 python overlay)

### _base (14 files)

| 파일 | 현재 언어 | 번역 난이도 |
|------|----------|-----------|
| `skills/harness/SKILL.md` | 한국어 body | 중 |
| `skills/harness-plan/SKILL.md` | 한국어 body | 높음 |
| `skills/harness-plan/plan-template.md` | 한국어 template | 중 |
| `skills/harness-design/SKILL.md` | 한국어 body | 높음 |
| `skills/harness-design/7d-checklist.md` | 한국어 | 중 |
| `skills/harness-run/SKILL.md` | 한국어 body | 중 |
| `skills/harness-ship/SKILL.md` | 한국어 body | 높음 |
| `skills/harness-ship/report-template.md` | 한국어 template | 중 |
| `skills/harness-review/SKILL.md` | 한국어 body | 낮음 |
| `agents/harness-dispatcher.md` | 혼합 (영문 body, 한국어 헤더 일부) | 낮음 |
| `agents/harness-explore.md` | 혼합 | 낮음 |
| `agents/harness-grey-area.md` | 혼합 | 낮음 |
| `agents/harness-verifier.md` | 혼합 | 낮음 |
| `output-styles/harness-engineer.md` | 한국어 | 중 |

### python overlay (2 files)

| 파일 | 현재 언어 | 번역 난이도 |
|------|----------|-----------|
| `templates/python/.claude/skills/harness-python/SKILL.md` | 한국어 body | 중 |
| `templates/python/.claude/skills/harness-python/python-quality.md` | 한국어 | 중 |

**총 16 files**

## 3. 실행 순서

1. Stage A — skills (7 files): harness → harness-review → harness-plan → harness-design → harness-run → harness-ship + templates
2. Stage B — agents (4 files): dispatcher → explore → grey-area → verifier
3. Stage C — output-styles (1 file): harness-engineer
4. Stage D — python overlay (2 files): SKILL.md + python-quality.md
5. Stage E — smoke 확인 (`tests/smoke-language-overlay.sh`)
6. Stage F — REPORT.md

## 4. 성공 기준

- [ ] `_base/.claude/` 14 파일 body 영문화 완료
- [ ] `python/.claude/skills/harness-python/` 2 파일 영문화 완료
- [ ] frontmatter `name:` / `description:` 값 영문
- [ ] 파일명 · 기술용어 · 명령어 · 경로 불변
- [ ] `tests/smoke-language-overlay.sh` 11/11 PASS (회귀 0)
- [ ] 한국어 잔존 체크: `grep -r '이다\|합니다\|하는\|이후\|단계\|확인' bootstrap/templates/_base/` → 0건 (관용어 한국어 없음)
