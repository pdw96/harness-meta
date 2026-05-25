# ROADMAP — harness-meta (thin index)

본 파일은 **thin index** — `harness-meta` repo가 인지하는 ROADMAP 의 단일 진입점. milestone 등재는 `projects/<name>/ROADMAP.md` (외부 적용) 또는 `development/ROADMAP.md` (harness-meta 자체 개발 이력) 에만 (root 에 milestone 직접 기재 금지 — `tests/smoke-projects-scope-discipline.sh` 가 차단).

```json
{
  "project": "harness-meta-projects-index",
  "updated": "2026-05-26",
  "development_roadmap": "development/ROADMAP.md",
  "projects": [
    {
      "name": "upbit",
      "roadmap_path": "projects/upbit/ROADMAP.md"
    }
  ]
}
```

## 의도

v1.1_meta-as-project (2026-05-08) 에서 thin index 도입. **v8.0_reclassify-meta-as-development (2026-05-26) 에서 meta 재분류** — meta 는 외부 적용(upbit)과 같은 `projects/` 서랍의 peer project 가 아니라 **harness-meta repo 제품 자체의 개발 이력**이므로 최상위 `development/` 로 승격. `projects/` 는 외부 적용 인스턴스(upbit 등) 전용으로 정리. 따라서 `projects[]` 배열엔 외부 적용만, harness-meta 자체 개발 이력 포인터는 별도 `development_roadmap` 필드로 분리 (thin-index `projects[]` regex `^projects/[a-z0-9_-]+/ROADMAP\.md$` 불변 유지 — meta≠project 재분류를 thin-index 에서도 정직 반영). 모든 milestone 은 해당 ROADMAP.md 단일 source — 디렉토리 위치 자체가 scope 강제.

## 활성 ROADMAP

| 구분 | ROADMAP | 비고 |
|---|---|---|
| harness-meta 자체 개발 | [`development/ROADMAP.md`](development/ROADMAP.md) | repo 제품 자체의 개발 이력 (v8.0 재분류 — 본 repo 가 곧 작업 공간) |
| upbit (외부 적용) | [`projects/upbit/ROADMAP.md`](projects/upbit/ROADMAP.md) | upbit 프로젝트의 하네스 milestone (산출물 본체는 upbit repo) |

## 워크플로우 진입

- 메타 milestone: `/harness-meta` 또는 `/harness-meta meta` (CWD=harness-meta)
- 프로젝트별 하네스 milestone: `/harness-meta <name>` (CWD=프로젝트 repo + `.harness.toml` 존재)

상세: [`claude/commands/harness-meta.md`](claude/commands/harness-meta.md), 운영 가이드 [`CLAUDE.md`](CLAUDE.md).

## 관련 문서

- 메타 ARCHITECTURE: [`development/ARCHITECTURE.md`](development/ARCHITECTURE.md)
- ADR: [`docs/adr/README.md`](docs/adr/README.md)
- 영문 요약: [`AGENTS.md`](AGENTS.md)
