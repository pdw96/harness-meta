# meta v1.11b-overlay-python-skill — PLAN

세션 시작: 2026-04-28
직접 선행 세션: [`sessions/meta/v1.11-language-overlay-infra/`](../v1.11-language-overlay-infra/PLAN.md) — overlay 인프라 확정 + `python/.claude/.gitkeep` placeholder

목적: Python overlay의 **실 콘텐츠 1호** 도입. `harness-python` skill — Python 프로젝트 환경 확인 + 품질 게이트(mypy → ruff → pytest) 통합 점검. "전체적으로" — PM 감지, 환경, 품질 게이트, 진단, 자동 수정을 단일 진입점으로 커버.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1b(2) `python/.claude/skills/harness-python/{SKILL,python-quality}.md` + S2(1) `OVERLAY.md` §3 갱신 + S3(1) `smoke-language-overlay.sh` 갱신 = **4/4 meta**
- **T1 경로 다수결** — S1b/S2/S3 전체 meta scope
- **T2 스펙 vs 값** — overlay 실 콘텐츠 패턴 수립 = 향후 모든 언어 overlay의 첫 인스턴스 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.11-language-overlay-infra/PLAN.md` Out of scope 표** (verbatim):

> `| 실 overlay 콘텐츠 (Python harness-python/SKILL.md 등) | v1.11b+ (evidence 누적 후) |`

**Parsed sub-items (1)**:

1. **`python/.claude/skills/harness-python/SKILL.md`** — Python overlay 실 콘텐츠 1호 (harness-* prefix 준수)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| TypeScript / Go / Rust 등 다언어 overlay | v1.11c+ (언어별 별 세션) |
| `harness-python-check` / `harness-python-env` 등 분리 skill | 후속 evidence-driven (현 단일 skill로 커버) |
| upbit `.claude/skills/` 실 배포 (재install) | `sessions/upbit/v1.x-python-overlay-apply/` (T4 후행) |
| `install-project-claude` 14→N 파일 수 갱신 | 설명문 아님 — INTERVIEW_FLOW.md S6 표기는 v1.11b 이후 audit |
| S10 Bootstrap 후속 안내 갱신 | overlay 실 콘텐츠 안정화 후 |

## 1. Evidence

사용자(Python/uv 프로젝트 `upbit` 운영자)가 "전체적으로" 커버를 요구 — 환경 · 품질 게이트 · 진단을 단일 진입점으로. `_base` skill로는:

- `.harness.toml` `[testing]` 필드를 Python PM 컨텍스트로 묶어 실행하는 통합점 없음
- mypy / ruff / pytest 를 순서 있게 체이닝하고 결과를 요약하는 레이어 없음
- PM 감지(uv/poetry/pip) → 명령 prefix 자동 선택 없음

## 2. 결정 (R1 ~ R4)

### R1 — skill 구조: `harness-python/` 디렉토리 2파일

```
python/.claude/skills/
└── harness-python/
    ├── SKILL.md           # 메인 skill (frontmatter + 로직)
    └── python-quality.md  # PM 매핑 표 + 품질 게이트 단계 참조
```

패턴: `harness-plan/{SKILL,plan-template}.md` / `harness-design/{SKILL,7d-checklist}.md` 동일 구조.

### R2 — SKILL.md 설계

**frontmatter**:
```yaml
---
name: harness-python
description: Python 프로젝트 통합 점검 — 환경 확인 + mypy → ruff → pytest 품질 게이트. .harness.toml PM 자동 감지.
disable-model-invocation: true
argument-hint: "[env|check|fix|all]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
model: sonnet
---
```

**Bash broad 채택 이유** (PERMISSION_PATTERN.md A5 Conservative 예외):
- PM이 동적 (`uv` / `poetry` / `pip`) — prefix 고정 불가
- `uv run mypy` / `poetry run mypy` / `mypy` 모두 가능 → `Bash(uv *)` + `Bash(poetry *)` + `Bash(mypy *)` 열거 시 조합 폭발
- `harness-run/SKILL.md` 동일 사유로 broad `Bash` 채택 → 정합

**skill 본문 4-section**:

| 섹션 | 내용 |
|------|------|
| **§0 전제 읽기** | `.harness.toml` → PM / test_cmd / lint_cmd / format_cmd / type_check_cmd 추출. 없으면 PM default 명령 사용. `python-quality.md` 참조 |
| **§1 Argument dispatch** | `env` → §2만. `check` → §3만. `fix` → ruff format + ruff --fix 실행. `all` / 없음 → §2 → §3 순서 |
| **§2 환경 확인 (env)** | Python 버전 / `.venv/` 존재 / lock file(uv.lock\|poetry.lock) 존재 + sync 상태. 결과 ✓/✗ 3줄 |
| **§3 품질 게이트 (check)** | 순서: type_check → lint → format_check → test. 단계별 PASS/FAIL + 요약. FAIL 시 → "계속할까요?" 사용자 확인 후 진행 또는 중단. 최종 결과 표 |
| **§4 진단 힌트** | 빈번한 오류 패턴 → 원인 + 해결 명령 (ModuleNotFoundError / stub 미설치 / line-length / src/ 구조 등). 별도 `python-quality.md` §4에서 참조 |

### R3 — python-quality.md

PM 매핑 표 + 품질 게이트 단계 표 + 진단 패턴 표 (3 섹션). SKILL.md 본문에 직접 쓰면 길어지는 부분을 분리.

### R4 — 문서 + Smoke 갱신

- **OVERLAY.md §3 표**: `python/` 행 `현 시점 실재` 열 `✓ (placeholder)` → `✓ (harness-python/ 2파일)`
- **smoke-language-overlay.sh**: Stage 1에 static check 2건 추가:
  - `python/.claude/skills/harness-python/SKILL.md` 존재
  - `name: harness-python` frontmatter 포함 → `harness-*` prefix 준수 확인

## 3. 변경 대상 (2 신규 + 2 수정)

| 경로 | 분류 | 변경 |
|------|------|------|
| `bootstrap/templates/python/.claude/skills/harness-python/SKILL.md` | **신규** | R2 — 메인 skill |
| `bootstrap/templates/python/.claude/skills/harness-python/python-quality.md` | **신규** | R3 — PM 매핑 + 진단 참조 |
| `bootstrap/docs/OVERLAY.md` | 수정 | R4 — §3 표 python/ 행 갱신 |
| `tests/smoke-language-overlay.sh` | 수정 | R4 — Stage 1 static check 2건 추가 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 확인**
- [ ] Stage A — `harness-python/SKILL.md` 신규
- [ ] Stage B — `python-quality.md` 신규
- [ ] Stage C — OVERLAY.md §3 갱신
- [ ] Stage D — smoke-language-overlay.sh 갱신 + 실행 PASS 확인
- [ ] Stage E — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `harness-python/SKILL.md` 존재 + `harness-*` prefix 준수
- [ ] 4-section 구조 완비 (§0 전제 / §1 dispatch / §2 env / §3 quality gate + §4 진단)
- [ ] PM 감지 로직 (uv / poetry / pip) SKILL.md 내 명시
- [ ] `python-quality.md` PM 매핑 표 + 진단 패턴 표
- [ ] OVERLAY.md §3 python/ 행 갱신
- [ ] smoke-language-overlay.sh 추가 2 check PASS (기존 8 + 신규 2 = 10/10)
- [ ] 회귀 0 (기존 static 4 + dynamic 4 PASS 유지)

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.11b-overlay-python-skill — harness-python overlay 실 콘텐츠 도입

- add: bootstrap/templates/python/.claude/skills/harness-python/SKILL.md
- add: bootstrap/templates/python/.claude/skills/harness-python/python-quality.md
- update: bootstrap/docs/OVERLAY.md §3 python/ 행 갱신
- update: tests/smoke-language-overlay.sh (+2 static checks → 10/10)
- add: sessions/meta/v1.11b-.../{PLAN,REPORT}.md

harness-python: 환경(env) + 품질 게이트(mypy→ruff→pytest) + 자동수정(fix) + 진단.
PM 자동 감지(uv/poetry/pip), .harness.toml [testing] 필드 통합.
Broad Bash 채택 — PM dynamic prefix 조합 폭발 회피 (harness-run 동일 사유).
smoke 10/10 PASS, 회귀 0.
```

## 7. 후속 분기

| 후속 | 조건 |
|------|------|
| `sessions/upbit/v1.x-python-overlay-apply/` | upbit에 `install-project-claude --force` 재실행 → `harness-python` 실배포 |
| `v1.11c-overlay-typescript` | TS 사용자 발생 시 |
| `v1.11b-ext-hooks` | pre-commit hook 자동 연동 등 Python overlay 확장 |
