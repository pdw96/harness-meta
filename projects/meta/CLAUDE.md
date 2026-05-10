# projects/meta/ — Subdirectory Guide

**하네스 엔지니어링 정의** (정전 single source): [`ARCHITECTURE.md`](ARCHITECTURE.md) § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑.

@ROADMAP.md

본 디렉토리에서 작업 시 (e.g., milestone 산출물 작성 / ARCHITECTURE 갱신 / ROADMAP 항목 추가) `projects/meta/ROADMAP.md` 자동 로드.

## 의도

meta repo 자체 milestone trace 컨테이너. `projects/<name>/` 동형 구조의 일부 (meta + upbit + 향후 N개) — meta 도 일반 project 처럼 다뤄지도록 디렉토리 위치로 scope 강제.

## 모듈 가이드

- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- ROADMAP: [`ROADMAP.md`](ROADMAP.md)
- milestone 산출물 (v2.0+ 9-stage): `milestones/v{X.Y}_{slug}/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `execute/phase-{n}.md`. 7-stage era (v1.0~v1.4): `{PLAN,RESEARCH,DESIGN,VERIFY,REPORT}.md` + `execute/`. era 정책: [`ARCHITECTURE.md`](ARCHITECTURE.md) § 6.

## 관련

- 운영 가이드 (root, primary): [`../../CLAUDE.md`](../../CLAUDE.md)
- 워크플로우 진입점: [`../../claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
