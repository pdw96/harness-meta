# development/ — Subdirectory Guide

**하네스 엔지니어링 정의** (정전 single source): [`ARCHITECTURE.md`](ARCHITECTURE.md) § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace) + § 3.1 끝 `harness-meta repo 정체성` paragraph (**project harness composer + Claude Code ecosystem integrator + agent fleet maintainer**, v4.0 도입). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑.

**AI Native 운영** (운영 원칙 보완, v6.0 도입): [`OPERATIONS.md`](OPERATIONS.md) § 3 — 3 면 매트릭스 (컨텍스트 효율 + 자율성 + 다중 AI 협업) + entry title 가이드 4 원칙. v4.0 정체성 (책임/결과물) ↔ AI Native 운영 (원칙/운영 방식) 두 차원 직교 보완.

@ROADMAP.md

본 디렉토리에서 작업 시 (e.g., milestone 산출물 작성 / ARCHITECTURE 갱신 / ROADMAP 항목 추가) `development/ROADMAP.md` 자동 로드.

## 의도

meta repo 자체 milestone trace 컨테이너. `projects/<name>/` 동형 구조의 일부 (meta + upbit + 향후 N개) — meta 도 일반 project 처럼 다뤄지도록 디렉토리 위치로 scope 강제.

## 모듈 가이드

- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- ROADMAP: [`ROADMAP.md`](ROADMAP.md)
- milestone 산출물 (v6.2+ 9-stage-flattened, **큰 건** 트랙): `milestones/v{X.Y}/MILESTONE.md` (단일 본책, H2 9 섹션 = ## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES + 조건부 ## SCOPE_OUT_NOTES, v7.0 T1.3 — 거명 있을 때만) + `execute/phase-{n}.md` (별책). v3.0~v6.1 9-stage-bundled (참조용 보존, 신규 금지): `milestones/v{X.Y}/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `milestones.md` (sub-milestone listing per version) + `execute/phase-{n}.md`. 9-stage era (v2.0~v2.1): `milestones/v{X.Y}_{slug}/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `execute/`. 7-stage era (v1.0~v1.4): `{PLAN,RESEARCH,DESIGN,VERIFY,REPORT}.md` + `execute/`. era 정책 + bundling 정책: [`OPERATIONS.md`](OPERATIONS.md) § 2.1.
- milestone 산출물 (v8.1+ 4-section-lightweight, **작은 건** 트랙): `milestones/v{X.Y}/LIGHTWEIGHT.md` (단일 본책, H2 4 섹션 = ## 문제 / ## 결정 / ## 적용 / ## 기록). 가벼운 흐름 = 내부·작은 조정 전용 (컨설팅 자산 영향 큰 건은 9-stage). skill = [`../skills/lightweight-flow/`](../skills/lightweight-flow/SKILL.md). 정의 + 승격 기준 1차 source: [`WORKFLOW.md`](WORKFLOW.md) § 3.

## 관련

- 운영 가이드 (root, primary): [`../../CLAUDE.md`](../CLAUDE.md)
- 워크플로우 진입점: [`../../claude/commands/harness-meta.md`](../claude/commands/harness-meta.md)
