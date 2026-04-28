# ADR-003: `_base` + `<language>/` overlay 2단계 배포 구조

- **상태**: Accepted
- **날짜**: 2026-04-25 (v1.8) / 2026-04-28 (v1.11 overlay 확장)
- **세션**: [sessions/meta/v1.8-core-adapter-split/](../../sessions/meta/v1.8-core-adapter-split/) + [sessions/meta/v1.11-language-overlay-infra/](../../sessions/meta/v1.11-language-overlay-infra/)

## 결정

프로젝트에 배포되는 `.claude/` 파일은 두 단계로 구성한다:
1. **Phase 1** — `bootstrap/templates/_base/.claude/` (언어 불문 baseline 17 파일)
2. **Phase 2** — `bootstrap/templates/<language>/.claude/` (언어별 overlay, 동일 이름 시 overlay 승)

`install-project-claude.{ps1,sh}`가 두 단계를 순차 실행. overlay 파일은 `harness-*` prefix 의무.

## 배경

v1.8 이전: 글로벌 symlink로 모든 프로젝트가 같은 파일 공유. 프로젝트마다 다른 언어 특화 skill을 추가할 방법 없음.

v1.8: `claude/` 최소화 + `bootstrap/templates/_base/.claude/` 신설. 프로젝트별 copy 배포로 전환.

v1.11: `_base` 위에 언어별 overlay 계층 추가. Python/TS/Go/Rust 등 10개 언어 매트릭스 확정. 실 콘텐츠는 evidence-driven으로 v1.11b+에서 단계 도입.

## 결과

- **충돌 정책**: C1(사용자 vs _base) = abort/-Force / C2(사용자 vs overlay) = overlay 자동 승 (harness-* prefix 보호)
- **언어 정규화**: `[project].language` lowercase 변환 후 매치 (`Python` → `python/`)
- Reserved prefix `_*` 사용 금지 (sentinel 디렉토리)
- v1.11b+에서 언어별 실 콘텐츠 evidence-driven 도입 예정

## 관련 문서

- overlay 규약 단일 소스: [bootstrap/docs/OVERLAY.md](../../bootstrap/docs/OVERLAY.md)
- 매니페스트 `[project].language`: [bootstrap/manifest-schema.md](../../bootstrap/manifest-schema.md)
