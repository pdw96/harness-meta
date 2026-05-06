# Architecture Decision Records (ADR)

harness-meta의 핵심 아키텍처 결정을 기록한 인덱스. 각 ADR은 **왜 이 구조가 만들어졌는가**를 단일 문서로 설명한다.

## 포맷

```markdown
# ADR-NNN: <제목>

- **상태**: Accepted | Deprecated | Superseded by ADR-NNN
- **날짜**: YYYY-MM-DD
- **세션**: sessions/meta/vX.Y-{name}/

## 결정
## 배경
## 결과
## 관련 문서
```

## 인덱스

| ADR | 제목 | 상태 | 확정 세션 |
|-----|------|------|---------|
| [ADR-001](ADR-001-agents-md-source-of-truth.md) | AGENTS.md를 프로젝트 컨텍스트 source of truth로 채택 | Accepted | v1.5 |
| [ADR-002](ADR-002-session-ownership-rules.md) | 세션 소속 S1–S7 + T1–T5 규약 | Accepted | v1.2 |
| [ADR-003](ADR-003-template-base-overlay.md) | `_base` + `<language>/` overlay 2단계 배포 | Accepted | v1.8, v1.11 |
| [ADR-004](ADR-004-permission-pattern.md) | frontmatter `allowed-tools:` 6축 통합 | Accepted | v1.10d, v1.10g |
| [ADR-005](ADR-005-bootstrap-interview-flow.md) | 8-stage Bootstrap 인터뷰 흐름 | Accepted | v1.10, v1.14 |
| [ADR-006](ADR-006-milestone-phase-2tier.md) | milestone-phase 2-tier 구조 도입 | Accepted | v1.83 |

## 관련

- 상위 진입점: [../../CLAUDE.md](../../CLAUDE.md)
- 아키텍처 개요: [../ARCHITECTURE.md](../ARCHITECTURE.md)
- 세션 소속 규약 (S1–S7): [../../bootstrap/docs/OWNERSHIP.md](../../bootstrap/docs/OWNERSHIP.md)
