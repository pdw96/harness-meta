<!-- BOOTSTRAP: replaced at v0.1-bootstrap. 본 파일은 인터뷰 답변 원본. 향후 ARCHITECTURE/STACK 업데이트의 근거 -->

# {{name}} — Bootstrap Interview

{{name}} 프로젝트의 v0.1-bootstrap 인터뷰 답변 원본. `bootstrap/interview.md` v1.14 표준 (코어 6 + 옵션 1 + 자유 1 optional = 7 유효 질문 + 자동 10).

본 파일은 **수정 금지** — 이력 보존. 후속 결정은 `DECISIONS.md`에 H-ADR로 추가.

---

## Q1. 프로젝트 이름?

**답**: {{name}}

---

## Q2. 주 언어?

**답**: {{language}}

**근거**: (detect 결과 또는 사용자 선택 이유)

---

## Q3. 패키지 매니저?

**답**: {{package_manager}}

**근거**: (lockfile 존재 / 팀 관례)

---

## Q4. 런타임 버전?

**답**: {{runtime_version}}

---

## Q5. 하네스 코드 디렉토리?

**답**: {{code_dir}}

---

## Q6. Phases 디렉토리?

**답**: {{phases_dir}}

---

## Q10. 테스트·린트·포맷·타입체크 명령?

**답**:
- `test_cmd`: {{test_cmd}}
- `lint_cmd`: {{lint_cmd}}
- `format_cmd`: {{format_cmd}}
- `type_check_cmd`: {{type_check_cmd}}

**근거**: (detect default 채택 / 사용자 override 이유)

---

## 도출된 첫 `.harness.toml`

`{{name}}/.harness.toml` 참조. 본 인터뷰 답변에서 직접 생성.

## 자동 적용 (질문 없음, 10건 — manifest 7 + 콘텐츠 3)

- `schema_version = "1.1"` (manifest)
- `[harness].mcp_server = "harness"` (manifest)
- `[agents].primary = "claude-code"` (manifest)
- 컴파일 언어({{language}})면 `[build]` 섹션 자동 포함 (manifest)
- `[architecture].meta_ref = "projects/{{name}}/ARCHITECTURE.md"` (manifest, v1.14 자동화)
- `[harness].guardrails = "docs/GUARDRAILS.md"` (manifest, v1.14 자동화)
- `[project].locale` = 미설정 → render default `en` (v1.14 자동화)
- `{{bootstrap_version}} → "1.10e3"` (AGENTS.md stamp, v1.10b)
- `{{install_cmd}} → "<Q3 PM 매핑>"` (AGENTS.md, v1.10c — 17 PM 매트릭스)
- `{{license}} → "<4-tier 결과>"` (AGENTS.md, v1.10e/e2/e3 — T1 SPDX → T2-Multi → T2 boilerplate → T2.5 Cargo → T3 메타. 미식별 시 `see LICENSE.`)

## 명시적 omit (생성 안 함, 9건)

- `[harness].executor` / `statusline_cmd` / `statusline_timeout_ms` / `state_file`
- `[testing].harness_test_cmd`
- `[notifications]` 섹션
- `[agents].secondary`
- AGENTS.md adapter 7종 매핑 파일 — v1.14~v1.20 각 adapter 세션
- `AGENTS.{locale}.md` 다언어 번역본
