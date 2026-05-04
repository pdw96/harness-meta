# meta v1.72-docs-cleanup — PLAN

세션 시작: 2026-05-05
직접 선행 세션: [`sessions/meta/v1.71-fix-model-effort-insert/`](../v1.71-fix-model-effort-insert/PLAN.md)

목적: ROADMAP §3 ✅ 완료 행 정리 + CLAUDE.md / README.md 누적 오기 수정 (문서 전용, 기능 변경 0).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(2) `CLAUDE.md` + `README.md` + S1-운영예외(1) `sessions/meta/ROADMAP.md` = 3/3 meta
- **T1 경로 다수결** — S3 × 2 + meta 운영예외 × 1 = meta 소유

## Scope inheritance (verbatim from 사용자 발의)

**Source — 사용자 발의 (2026-05-05) verbatim**:

> "ROADMAP 정리 / 문서 개선" → 세부: "✅ archived 정리, CLAUDE.md 업데이트, README.md 개선"

**Parsed sub-items (3)**:

1. **ROADMAP §3 ✅ 완료 행 삭제** — §3-A/B/D/E에 잔류 중인 21건 행 제거 (이미 §8에 있음)
2. **CLAUDE.md 오기 수정** — "17 파일" 오기 2곳, `projects/<name>/` 4→5종, 구 v1.11 세션 링크
3. **README.md 개선** — install.sh 구 주석 제거, `projects/<name>/` 4→5 docs 수정

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| SKILLS.md / PERMISSION_PATTERN.md 등 bootstrap/docs 내용 변경 | 별도 세션 (evidence-driven) |
| 실 기능 변경 (smoke 추가/수정, install 스크립트 수정) | 별도 세션 |
| 프로젝트별 ROADMAP.md (`projects/<name>/ROADMAP.md`) 변경 | 해당 프로젝트 세션 |
| §8 최근 완료 내용 수정/보강 | 별도 세션 (현재 그대로 유지) |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (내부 문서 정리만) |
| **re-verify** | N/A |

## 배경

v1.36 이후 매 세션마다 `harness-roadmap-update` SKILL이 §3 항목을 ✅ 완료 표기로 갱신해왔으나, 이미 §8(최근 완료)에 동일 내용이 기록됨에도 §3 표에서 행을 삭제하지 않아 누적된 상태.
동시에 CLAUDE.md의 파일 수 참조("17 파일")와 디렉토리 구조 설명이 v1.8b(commands→skills 이관) 이후 업데이트되지 않았고, README.md에도 완료된 v1.21 관련 임시 주석이 잔류 중.

## 변경 대상

| 파일 | Scope | 변경 내용 |
|------|------|---------|
| `sessions/meta/ROADMAP.md` | S1-운영예외 | §3-A 1건 / §3-B 7건 / §3-D 1건 / §3-E 12건 행 삭제 (총 21행) |
| `CLAUDE.md` | S3 | "17 파일" → "14 파일" (2곳) + `projects/<name>/` 4→5종 + ROADMAP.md 행 추가 + 구 v1.11 링크 제거 |
| `README.md` | S3 | install.sh 구 주석 제거 + `projects/<name>/` 4→5 docs + ROADMAP.md 행 추가 |

### ROADMAP §3 삭제 대상 상세

| 섹션 | 삭제 항목 | 완료 세션 |
|------|---------|---------|
| §3-A | `v1.39c-fix-autofix` | v1.64 |
| §3-B | `v1.18g3-helper-redesign` | v1.50 |
| §3-B | `v1.51b-roi-smoke` | v1.52 |
| §3-B | `v1.36b4-hook-debug-log` | v1.54 |
| §3-B | `v1.40c-hook-more-tools` | v1.57 |
| §3-B | `v1.40d-hook-pattern-expand` | v1.59 |
| §3-B | `v1.66e-shellcheck-openbinaryfile-diagnose` | v1.68 |
| §3-B | `v1.56-quality-file-split` | v1.56 |
| §3-D | `v1.36d-detect-language-refactor` | v1.53 |
| §3-E | `v1.46b-scorer-config-separation-na` | v1.47 |
| §3-E | `v1.46c-scorer-linter-na` | v1.48 |
| §3-E | `v1.18e-scorer-html-na-ui` | v1.49 |
| §3-E | `v1.57d-hook-msg-dynamic-filename` | v1.58 |
| §3-E | `v1.60b-fix-thinking-effort` | v1.61 |
| §3-E | `v1.61b-fix-model-effort-insert` | v1.71 |
| §3-E | `v1.60c-fix-broad-bash-fine-grain` | v1.62 |
| §3-E | `v1.62b-fix-field-name-rename` | v1.63 |
| §3-E | `v1.60d-v8-v9-structural-fix` | v1.65 |
| §3-E | `v1.65d-python-newline-audit` | v1.69 |
| §3-E | `v1.69d-scorer-newline-smoke` | v1.70 |
| §3-E | `v1.66c-markdownlint-residual` | v1.67 |

### CLAUDE.md 수정 상세

1. `install-project-claude.{ps1,sh}`가 `bootstrap/templates/_base/.claude/` **17 파일을 프로젝트에 복사** → **14 파일**
2. 디렉토리 구조 `_base/.claude/ # 언어 불문 baseline (17 파일: commands/agents/skills/output-styles)` → `(14 파일: agents/skills/output-styles)`
3. `projects/<name>/` 섹션에 `ROADMAP.md` 행 추가 + "4종" → "5종"
4. `관련 문서` 섹션 `- 최신 meta 세션: @sessions/meta/v1.11-...` 줄 → ROADMAP.md 링크로 대체

### README.md 수정 상세

1. `bash ./install.sh   # coming in v1.21; for now use pwsh if available` → `bash ./install.sh`
2. `projects/<name>/` 섹션: "4 fixed docs" → "5 fixed docs (v1.36+)" + ROADMAP.md 행 추가

## 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 PLAN 확인**
- [ ] Stage A — ROADMAP.md §3 21건 행 삭제
- [ ] Stage B — CLAUDE.md 4항목 수정
- [ ] Stage C — README.md 2항목 수정
- [ ] Stage D — REPORT.md 작성
- [ ] 커밋 (사용자 확인 후)

## 성공 기준

- [ ] ROADMAP §3에 ✅ 완료 행 0건 (~~strikethrough~~ 포함)
- [ ] CLAUDE.md: "14 파일" 정상 × 2, `projects/<name>/` 5종, v1.11 링크 제거
- [ ] README.md: install.sh 주석 없음, `projects/<name>/` 5 docs
- [ ] 기존 smoke 회귀 0 (문서 전용 변경 — smoke 미영향)

## 커밋 전략

```
docs(meta): sessions/meta/v1.72-docs-cleanup — ROADMAP §3 cleanup + CLAUDE/README 오기 수정

- ROADMAP §3: ✅ 완료 21건 행 삭제 (§3-A/B/D/E — 이미 §8에 기록됨)
- CLAUDE.md: "17 파일" → "14 파일" (2곳), projects 4→5종, v1.11 구 링크 제거
- README.md: install.sh 구 주석 제거, projects 4→5 docs
```
