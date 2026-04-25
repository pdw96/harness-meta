<!-- BOOTSTRAP: replaced at v0.1-bootstrap. {{var}} 마커는 Claude가 인터뷰 답변으로 치환 -->

# {{name}} — Harness Architecture

{{name}} 프로젝트의 **하네스** 아키텍처 스냅샷. 비즈니스 코드는 대상 외 — 본 문서는 `{{code_dir}}` 및 관련 통합 레이어만 다룬다.

> 비즈니스 측면은 프로젝트 repo의 `docs/core/ARCHITECTURE.md` (있을 시) 참조.

## 1. 디렉토리 구조

```
{{name}}/
├── .harness.toml              # 매니페스트 (schema 1.1)
├── .claude/                   # install-project-claude.{ps1,sh}로 배포된 14 파일
│   ├── agents/                # subagent 4 (dispatcher/explore/grey-area/verifier)
│   ├── skills/                # slash command 6 (harness/-plan/-design/-run/-ship/-review)
│   └── output-styles/         # harness-engineer.md
├── CLAUDE.md                  # 프로젝트 컨텍스트 (ARCHITECTURE include)
├── docs/
│   └── GUARDRAILS.md          # step-level 압축 규칙 (5120 byte 상한)
├── {{code_dir}}/              # 하네스 코어 (v0.1 시점 빈 디렉토리. v1.11+ overlay 또는 사용자 작성)
└── {{phases_dir}}/            # 실행 산출물 루트 (.gitkeep만 있는 빈 디렉토리)
```

## 2. 통합 지점

- **매니페스트**: `.harness.toml`이 글로벌 hook(`session-init.sh`, `statusline.sh`)에 프로젝트 메타 공급
- **코드 디렉토리**: `{{code_dir}}` — 하네스 실행기 (Python/TS/Go/Rust 등 v1.11+ language overlay에서 골격 공급)
- **Phases**: `{{phases_dir}}` — 각 phase의 PLAN/REPORT/index.json/step{N}.md
- **MCP 서버**: `harness` (수정 시 사용자 직접 작성, v1.11+ overlay)

## 3. 관측·트레이싱

{{q11_observability}}

## 4. CI/CD

{{q12_ci}}

## 5. 후속 작업 (Bootstrap v0.1 이후)

- [ ] `{{code_dir}}/` 하네스 실행기 작성 (v1.11+ language overlay 적용 또는 직접 작성)
- [ ] `docs/GUARDRAILS.md` 도메인 규칙 채움
- [ ] `.harness.toml`에 `[harness].executor`, `statusline_cmd`, `[testing].harness_test_cmd` 추가
- [ ] 첫 phase 작성 → `{{phases_dir}}/.gitkeep` 삭제
