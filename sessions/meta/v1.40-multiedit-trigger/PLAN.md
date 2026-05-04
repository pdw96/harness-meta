# meta v1.40-multiedit-trigger — PLAN

세션 시작: 2026-05-01
선행 세션: [`sessions/meta/v1.36b-postoolse-roadmap-hook/`](../v1.36b-postoolse-roadmap-hook/) — PostToolUse hook 신설 (Edit|Write 매처)

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1a(1) `claude/hooks/post-report-write.sh` + S3(2) `install.ps1`, `verify.ps1`, `verify.sh`, `tests/smoke-posttooluse-hook.sh` = **5/5 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — 전원 S1a+S3, meta scope 5/5

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/ROADMAP.md` §3-B Out of scope 표** (verbatim):

> `v1.36b3-multiedit-trigger | MultiEdit으로 REPORT.md 갱신 evidence 발생 — matcher 확장 또는 별 hook | v1.36b REPORT`

**Parsed sub-items (2)**:

1. **matcher 확장** — `Edit|Write` → `Edit|Write|MultiEdit` (settings.json / install.ps1 / verify / smoke)
2. **hook 내부 case 확장** — `post-report-write.sh` 의 case 분기에 `MultiEdit` 추가

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| MultiEdit `edits` 배열 내 콘텐츠 검사 (old_string/new_string 필터링) | 별 후속 evidence-driven |
| Delete / NotebookEdit 등 다른 파일 수정 도구 추가 | 별 후속 evidence-driven |
| REPORT.md 외 파일 패턴 확장 (PLAN.md 등 감지) | 별 후속 |
| hook debug log 추가 (v1.36b4) | 별 후속 세션 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | MultiEdit tool_name, PostToolUse hook matcher, tool_input.file_path |
| **findings** | see citations below |
| **drift** | no — MultiEdit 공식 도구 확인, `tool_input.file_path` 동일 구조 |
| **re-verify** | Claude Code tool 이름 변경 또는 MultiEdit tool_input 구조 변경 시 |

**Citations**:

- C1 — `MultiEdit` is listed alongside `Edit`, `Write` in hook security example: `if tool_name not in ["Edit", "Write", "MultiEdit"]: sys.exit(0)` + `file_path = tool_input.get("file_path", "")` (Source: `https://context7.com/anthropics/claude-code/llms.txt`)
- C2 — PostToolUse hook matcher format: `"Edit|Write"` pipe-separated regex, `tool_name` field in JSON input (Source: `https://code.claude.com/docs/en/hooks`)

## 배경

`v1.36b-postoolse-roadmap-hook`에서 신설한 PostToolUse hook은 matcher `Edit|Write`로 등록. REPORT.md를 **MultiEdit**(단일 파일 다중 편집 도구)으로 갱신할 경우 hook이 발화하지 않는 문제가 존재.

Context7 확인 결과 `MultiEdit`은 공식 Claude Code 도구로, `tool_input.file_path` 필드가 `Edit`과 동일. 따라서 hook 로직 추가 없이 matcher 확장 + case 분기 추가만으로 수정 가능.

## 목표

- [ ] `post-report-write.sh` case 분기에 `MultiEdit` 추가 + 주석 갱신
- [ ] `install.ps1` matcher `Edit|Write` → `Edit|Write|MultiEdit` + legacy 자동 migration (3단계: 신규 탐색 → 구 탐색+교체 → append)
- [ ] `verify.ps1` Stage J 헤더 + J2 `matcher -eq 'Edit|Write|MultiEdit'`
- [ ] `verify.sh` Stage J 헤더 + J2 python path + jq fallback path 갱신
- [ ] `smoke-posttooluse-hook.sh` S2 grep(`Edit|Write|MultiEdit`) + Test F (MultiEdit → additionalContext) + Test G (MultiEdit + success:false → `{}`) 추가

## 변경 대상 (5 파일)

| 경로 | 변경 내용 |
|------|---------|
| `claude/hooks/post-report-write.sh` | case `Write|Edit)` → `Write|Edit|MultiEdit)` + 주석 갱신 |
| `install.ps1` | `$ourMatcher` + `$legacyMatcher` migration 3단계 + 로그 메시지 |
| `verify.ps1` | Stage J 헤더/설명 + J2 `matcher -eq 'Edit|Write|MultiEdit'` |
| `verify.sh` | 동상 + jq fallback path L667 갱신 |
| `tests/smoke-posttooluse-hook.sh` | S2 grep 강화 + Test F + Test G (8→10 checks) + 헤더 카운트 |

## 성공 기준

- [ ] `bash tests/smoke-posttooluse-hook.sh` 10/10 PASS (기존 8 + 신규 F+G)
- [ ] MultiEdit + REPORT.md 입력 시 `additionalContext` 포함 출력
- [ ] MultiEdit + success:false 입력 시 `{}` 출력
- [ ] install.ps1 재실행 시 legacy `Edit|Write` entry → `Edit|Write|MultiEdit`로 in-place 교체 (중복 entry 없음)
- [ ] verify.ps1/sh Stage J PASS
- [ ] **회귀 0** — 기존 Test A~E PASS 유지

## 커밋 전략

```
feat(meta): v1.40-multiedit-trigger — PostToolUse hook MultiEdit 매처 확장

- update: claude/hooks/post-report-write.sh (case Write|Edit|MultiEdit)
- update: install.ps1 (matcher Edit|Write|MultiEdit + legacy migration)
- update: verify.ps1 (Stage J Edit|Write|MultiEdit)
- update: verify.sh (동상 + jq fallback path)
- update: tests/smoke-posttooluse-hook.sh (S2 강화 + Test F+G, 8→10)
```
