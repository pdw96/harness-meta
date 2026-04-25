<!-- BOOTSTRAP: replaced at v0.1-bootstrap. {{var}} 마커는 Claude가 인터뷰 답변으로 치환 -->

# {{name}} v0.1-bootstrap — PLAN

세션 시작: {{date}}
선행 세션: [`sessions/meta/v1.10-bootstrap-interview/`](../../meta/v1.10-bootstrap-interview/REPORT.md) — Bootstrap 10-stage 흐름 스펙

목적: {{name}} 프로젝트의 신규 부트스트랩. `bootstrap/interview.md` 흐름에 따라 매니페스트·CLAUDE.md·GUARDRAILS·`.claude/` 배포·`projects/{{name}}/` 4종·세션 기록·README 등록을 한 사이클로 완결.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/{{name}}/`

**근거**:
- 변경 파일: `<{{name}}>/.harness.toml` (S6) + `<{{name}}>/CLAUDE.md` (S6) + `<{{name}}>/docs/GUARDRAILS.md` (S6) + `<{{name}}>/{{phases_dir}}/.gitkeep` (S6) + `<{{name}}>/.claude/**` (S6) + `~/harness-meta/projects/{{name}}/{4종}` (S4) + `~/harness-meta/README.md` (S3 — 프로젝트 등록 1줄) → S6 다수 + S4 + S3.
- **T1 경로 다수결** — S4+S6 (project scope) 다수 → `sessions/{{name}}/`.
- **T4 분할** — meta v1.10이 흐름 스펙 정의 (meta), 본 세션이 {{name}} 적용 (project).

## 목표 (Bootstrap 10-stage)

- [ ] S0 모드 진입 — `.harness.toml` 부재 + `projects/{{name}}/` 부재 확인
- [ ] S1 detect-project.sh 실행 → 언어/PM 힌트 캡처
- [ ] S2 인터뷰 12 질문 (코어 7 + 옵션 manifest 3 + 자유 2)
- [ ] S3 render-manifest.sh로 .harness.toml 미리보기 + 사용자 확정
- [ ] S4 매니페스트 작성 + round-trip 검증 (name + code_dir + phases_dir 3 필드)
- [ ] S5 부수 자산: CLAUDE.md baseline, GUARDRAILS.md placeholder, {{phases_dir}}/.gitkeep
- [ ] S6 install-project-claude.{ps1|sh} 실행 → .claude/ 14 파일 배포
- [ ] S7 projects/{{name}}/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md 작성
- [ ] S8 본 PLAN/REPORT 작성
- [ ] S9 ~/harness-meta/README.md 프로젝트 섹션 등록
- [ ] S10 후속 안내 — `/config` Output style "Harness Engineer" 선택 + GUARDRAILS 작성 + `{{code_dir}}` 골격 (v1.11+ overlay 또는 직접)

## 변경 대상

### 신규 (프로젝트 측)

- `<{{name}}>/.harness.toml` — schema 1.1 v1.10 흐름 산출
- `<{{name}}>/CLAUDE.md` — `skeletons/CLAUDE.md.tmpl` 기반
- `<{{name}}>/docs/GUARDRAILS.md` — `skeletons/GUARDRAILS.md.tmpl` 기반 placeholder
- `<{{name}}>/{{phases_dir}}/.gitkeep` — 빈 디렉토리 유지
- `<{{name}}>/.claude/**` — install-project-claude 14 파일

### 신규 (harness-meta 측)

- `~/harness-meta/projects/{{name}}/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md` — `skeletons/projects/` 기반
- `~/harness-meta/sessions/{{name}}/v0.1-bootstrap/{PLAN,REPORT}.md` — 본 파일들

### 수정 (harness-meta 측)

- `~/harness-meta/README.md` — 프로젝트 섹션에 {{name}} 링크 추가

## 성공 기준

- [ ] 10-stage 모두 통과
- [ ] `.harness.toml` round-trip 3 필드 (name/code_dir/phases_dir) 검증
- [ ] `<{{name}}>/.claude/`에 14 파일 배포
- [ ] `projects/{{name}}/` 4종 작성 (INTERVIEW.md = 답변 원본 보존)
- [ ] 사용자 확인 후 커밋

## 커밋 전략

```
feat({{name}}): sessions/{{name}}/v0.1-bootstrap — 신규 프로젝트 부트스트랩

(상세 내용은 REPORT 작성 시 확정)
```
