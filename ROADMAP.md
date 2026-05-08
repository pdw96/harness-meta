# ROADMAP — harness-meta (thin index)

본 파일은 **thin index** — `harness-meta` repo가 인지하는 프로젝트 ROADMAP 의 단일 진입점. milestone 등재는 `projects/<name>/ROADMAP.md` 에만 (root 에 milestone 직접 기재 금지 — `tests/smoke-projects-scope-discipline.sh` 가 차단).

```json
{
  "project": "harness-meta-projects-index",
  "updated": "2026-05-08",
  "projects": [
    {
      "name": "meta",
      "roadmap_path": "projects/meta/ROADMAP.md"
    },
    {
      "name": "upbit",
      "roadmap_path": "projects/upbit/ROADMAP.md"
    }
  ]
}
```

## 의도

v1.1_meta-as-project (2026-05-08) 에서 도입. 이전 root ROADMAP.md 는 meta scope milestone 직접 기재 + project milestone 도 잘못 섞이는 misclassification 사례 있었다 (e.g., `v1.1_upbit-cross-ref-cleanup` 가 root 에 등재). 본 thin index 도입 후 모든 milestone 은 `projects/<name>/ROADMAP.md` 단일 source — 디렉토리 위치 자체가 scope 강제.

## 활성 ROADMAP

| 프로젝트 | ROADMAP | 비고 |
|---|---|---|
| meta | [`projects/meta/ROADMAP.md`](projects/meta/ROADMAP.md) | harness-meta repo 자체 milestone (본 repo 가 곧 작업 공간) |
| upbit | [`projects/upbit/ROADMAP.md`](projects/upbit/ROADMAP.md) | upbit 프로젝트의 하네스 milestone (산출물 본체는 upbit repo) |

## 워크플로우 진입

- 메타 milestone: `/harness-meta` 또는 `/harness-meta meta` (CWD=harness-meta)
- 프로젝트별 하네스 milestone: `/harness-meta <name>` (CWD=프로젝트 repo + `.harness.toml` 존재)

상세: [`claude/commands/harness-meta.md`](claude/commands/harness-meta.md), 운영 가이드 [`CLAUDE.md`](CLAUDE.md).

## 관련 문서

- 메타 ARCHITECTURE: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md)
- ADR: [`docs/adr/README.md`](docs/adr/README.md)
- 영문 요약: [`AGENTS.md`](AGENTS.md)
