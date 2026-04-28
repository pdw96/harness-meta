# ADR-002: 세션 소속 S1–S7 + T1–T5 규약

- **상태**: Accepted
- **날짜**: 2026-04-24
- **세션**: [sessions/meta/v1.2-ownership-rules/](../../sessions/meta/v1.2-ownership-rules/)

## 결정

하네스 관련 변경을 `sessions/meta/` 또는 `sessions/<name>/`에 귀속시킬지는 **CWD가 아닌 변경 대상의 scope**로 판정한다. S1–S7 경로 분류 + T1–T5 tie-breaker 순차 적용이 단일 소스.

## 배경

v1.1-global-smoke-test 세션이 CWD=upbit에서 글로벌 레이어를 검증하다 초기에 `sessions/upbit/`에 잘못 생성된 사례 발생. CWD basename 기준 분류의 결함이 드러남.

- **S1–S3** (글로벌 UX / bootstrap / repo 정책) → `sessions/meta/` 소유
- **S4–S6** (프로젝트 아키텍처 문서 / 실행기 코드 / 매니페스트) → `sessions/<name>/` 소유
- **S7** (비즈니스 코드) → 본 체계 대상 아님

Tie-breaker: T1 경로 다수결 → T2 스펙 vs 값 → T3 검증 대상 기준 → T4 크로스 커팅 분할 → T5 애매하면 meta.

## 결과

- 모든 `sessions/**/PLAN.md` 상단에 "세션 소속 근거" 섹션 의무화 (S#/T# 명시)
- v1.10j에서 Scope contract 강화: "Scope inheritance" + "Out of scope" 두 섹션 의무
- v1.8에서 S1 split (S1a 글로벌 최소 + S1b 메타 소유 템플릿), S6 확장 (`.claude/**` 포함)

## 관련 문서

- 상세 규약: [bootstrap/docs/OWNERSHIP.md](../../bootstrap/docs/OWNERSHIP.md)
- Scope contract 의무화: [sessions/meta/v1.10j-scope-contract-discipline/](../../sessions/meta/v1.10j-scope-contract-discipline/)
