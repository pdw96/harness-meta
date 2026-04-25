<!-- BOOTSTRAP: replaced at v0.1-bootstrap. {{var}} 마커는 Claude가 인터뷰 답변으로 치환 -->

# {{name}} — Harness Decisions (H-ADR)

{{name}} 프로젝트의 **하네스 설계 결정** 이력. 도메인 결정과 구분 (도메인 결정은 프로젝트 repo `docs/core/ADR.md` 또는 유사 위치).

각 결정은 (a) 배경, (b) 대안, (c) 결정, (d) 트레이드오프, (e) 필요 시 롤백 경로를 포함한다.

---

## H-ADR-001: 디렉토리 `{{code_dir}}` 채택

**배경**: 하네스 코드를 어디 둘지 — `tools/`, `harness/` (루트), `src/harness/`, `{{code_dir}}` 후보

**결정**: `{{code_dir}}` — Bootstrap 인터뷰에서 사용자 지정. 이유는 `INTERVIEW.md` Q5 답변 참조

**트레이드오프**: (사용자가 후속 추가 — 예: 프로젝트 레이아웃 관례, mypy/tsconfig path 영향 등)

**롤백**: `.harness.toml`의 `[harness].code_dir` 변경 + 디렉토리 이동

---

<!-- 후속 H-ADR은 사용자가 추가. 예시:

## H-ADR-002: 패키지 매니저 {{package_manager}} 채택

**배경**: ...

**결정**: ...

**트레이드오프**: ...

-->
