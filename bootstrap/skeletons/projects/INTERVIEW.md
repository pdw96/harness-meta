<!-- BOOTSTRAP: replaced at v0.1-bootstrap. 본 파일은 인터뷰 답변 원본. 향후 ARCHITECTURE/STACK 업데이트의 근거 -->

# {{name}} — Bootstrap Interview

{{name}} 프로젝트의 v0.1-bootstrap 인터뷰 답변 원본. `bootstrap/interview.md` 표준 템플릿(코어 7 + 옵션 manifest 3 + 자유 2 = 12 질문)에 대응.

본 파일은 **수정 금지** — 이력 보존. 후속 결정은 `DECISIONS.md`에 H-ADR로 추가.

---

## Q1. 프로젝트 이름?

**답**: {{name}}

**근거**: (디렉토리명 / 매니페스트 식별자 / 세션 디렉토리명 일치)

---

## Q2. 주 언어?

**답**: {{language}}

**근거**: (detect 결과 또는 사용자 선택 이유)

---

## Q3. 패키지 매니저?

**답**: {{package_manager}}

**근거**: (lockfile 존재 / 팀 관례 / 의존성 관리 정책)

---

## Q4. 런타임 버전?

**답**: {{runtime_version}}

**근거**: (버전 pin 이유 — 호환성 / 라이브러리 / 팀 정책)

---

## Q5. 하네스 코드 디렉토리?

**답**: {{code_dir}}

**근거**: (디렉토리 명명 관례 / mypy_path / tsconfig 영향 등)

---

## Q6. Phases 디렉토리?

**답**: {{phases_dir}}

**근거**: (default `phases` 채택 또는 별도 사유)

---

## Q7. harness-meta 내부 경로 (meta_ref)?

**답**: {{meta_ref}}

**근거**: (CLAUDE.md @import 대상 위치)

---

## Q8. GUARDRAILS.md 경로?

**답**: {{guardrails_path}}

**근거**: (default `docs/GUARDRAILS.md` 또는 별도)

---

## Q9. 작업 언어 (locale)?

**답**: {{locale}}

**근거**: (팀 working language. 영문 = "en" / 한국어 = "ko" 등)

---

## Q10. 테스트·린트·포맷·타입체크 명령?

**답**:
- `test_cmd`: {{test_cmd}}
- `lint_cmd`: {{lint_cmd}}
- `format_cmd`: {{format_cmd}}
- `type_check_cmd`: {{type_check_cmd}}

**근거**: (detect default 채택 / 사용자 override 이유)

---

## Q11. 관측·트레이싱 스택?

**답**:
{{q11_observability}}

**근거**: (메트릭/로그/트레이스 도구 선택 이유)

---

## Q12. CI/CD 인프라?

**답**:
{{q12_ci}}

**근거**: (GitHub Actions / GitLab / Jenkins / 없음 — 선택 이유)

---

## 도출된 첫 `.harness.toml`

`{{name}}/.harness.toml` 참조. 본 인터뷰 답변에서 직접 생성.

## 자동 적용 (질문 없음, 4건)

- `schema_version = "1.1"`
- `[harness].mcp_server = "harness"`
- `[agents].primary = "claude-code"`
- 컴파일 언어({{language}})면 `[build]` 섹션 자동 포함

## 명시적 omit (생성 안 함, 7건 — v1.11+ overlay 또는 사용자 후속)

- `[harness].executor` / `statusline_cmd` / `statusline_timeout_ms` / `state_file`
- `[testing].harness_test_cmd`
- `[notifications]` 섹션
- `[agents].secondary`
