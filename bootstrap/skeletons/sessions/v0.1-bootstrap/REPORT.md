<!-- BOOTSTRAP: replaced at v0.1-bootstrap. {{var}} 마커는 Claude가 인터뷰 답변으로 치환 -->

# {{name}} v0.1-bootstrap — REPORT

세션 기간: {{date}} (단일 세션)
세션 범위: 신규 프로젝트 {{name}}의 v1.10 흐름 적용
판정: **PASS** / **FAIL** (Claude가 결과에 따라 채움)

**세션 소속 (self-apply)**: `sessions/{{name}}/`. S4+S6 다수 → project.

## 최종 결과

- **신규 프로젝트 자산**: `<{{name}}>/{.harness.toml, CLAUDE.md, docs/GUARDRAILS.md, {{phases_dir}}/.gitkeep, .claude/**}` — 매니페스트 + baseline + placeholder + 14 파일
- **harness-meta 측 신규**: `projects/{{name}}/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md` (4종)
- **README 등록**: `~/harness-meta/README.md` 프로젝트 섹션에 {{name}} 링크

## 10-stage 통과 체크박스

| Stage | 통과 | 비고 |
|---|---|---|
| S0 모드 진입 | ☐ | |
| S1 detect | ☐ | 감지: lang={{language}} / pm={{package_manager}} |
| S2 인터뷰 12 질문 | ☐ | INTERVIEW.md 답변 원본 보존 |
| S3 render | ☐ | bash 4+ gate / escaping 5종 통과 |
| S4 manifest 작성+검증 | ☐ | round-trip 3 필드 (name/code_dir/phases_dir) |
| S5 부수 자산 | ☐ | CLAUDE.md baseline / GUARDRAILS placeholder / {{phases_dir}}/.gitkeep |
| S6 install-project-claude | ☐ | 14 파일 배포 |
| S7 projects/{{name}}/4종 | ☐ | placeholder 치환 + 답변 반영 |
| S8 sessions/{{name}}/v0.1-bootstrap/{PLAN,REPORT} | ☐ | 본 파일들 |
| S9 README 등록 | ☐ | `~/harness-meta/README.md` 프로젝트 섹션 |
| S10 후속 안내 | ☐ | output style + GUARDRAILS 작성 + code_dir 골격 |

## 인터뷰 답변 요약

상세는 `~/harness-meta/projects/{{name}}/INTERVIEW.md` 참조.

| 항목 | 답변 |
|---|---|
| name | {{name}} |
| language | {{language}} |
| package_manager | {{package_manager}} |
| runtime_version | {{runtime_version}} |
| code_dir | {{code_dir}} |
| phases_dir | {{phases_dir}} |
| meta_ref | {{meta_ref}} |
| guardrails | {{guardrails_path}} |
| locale | {{locale}} |
| testing | test={{test_cmd}} / lint={{lint_cmd}} / format={{format_cmd}} / type_check={{type_check_cmd}} |

## Lessons Learned

(Claude가 적용 중 발견한 사항을 기록)

## 후속 작업

- [ ] **`/config → Output style → "Harness Engineer"`** 선택 (수동, S6 install 후)
- [ ] `<{{name}}>/docs/GUARDRAILS.md` 도메인 규칙 채움 (5120 byte 상한)
- [ ] `<{{name}}>/{{code_dir}}/` 하네스 실행기 작성 — v1.11+ language overlay 적용 또는 직접
- [ ] `.harness.toml`에 후속 필드 추가 (executor, statusline_cmd, harness_test_cmd 등)
- [ ] 첫 phase 작성 후 `<{{name}}>/{{phases_dir}}/.gitkeep` 삭제
- [ ] AGENTS.md baseline (v1.10b 후속 세션 적용 시)

## 커밋 계획

```
feat({{name}}): sessions/{{name}}/v0.1-bootstrap — 신규 프로젝트 부트스트랩

- add(<{{name}}>): .harness.toml (schema 1.1, v1.10 흐름)
- add(<{{name}}>): CLAUDE.md baseline + docs/GUARDRAILS.md placeholder
- add(<{{name}}>): {{phases_dir}}/.gitkeep
- add(<{{name}}>): .claude/** (14 파일, install-project-claude 배포)
- add(harness-meta): projects/{{name}}/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md
- add(harness-meta): sessions/{{name}}/v0.1-bootstrap/{PLAN,REPORT}.md
- update(harness-meta): README.md 프로젝트 섹션 등록

v1.10 Bootstrap 흐름 첫 적용. 인터뷰 답변은 INTERVIEW.md 영구 보존.
10-stage 통과. round-trip 3 필드 (name/code_dir/phases_dir) 검증.
```
