# ADR-005: 8-stage Bootstrap 인터뷰 흐름

- **상태**: Accepted
- **날짜**: 2026-04-27 (v1.10 확정) / 2026-04-28 (v1.14 간결화)

## 결정

신규 프로젝트 하네스 도입(`/harness-meta <new-name>`)은 8-stage 흐름으로 진행한다. 사용자에게는 **7 유효 질문**만 노출 (코어 6 + 옵션 1 + 자유 1), 나머지 10건은 자동 적용.

| Stage | 주체 | 산출 |
|-------|------|------|
| S0 모드 진입 | slash command | Bootstrap 확인 |
| S1 감지 | `detect-project.sh` | lang/pm/test_cmd 자동 추출 |
| S2 인터뷰 | `interview.md` | 7Q + HM_* env export |
| S3 manifest | `render-manifest.sh` | `.harness.toml` v1.1 |
| S4 부수 자산 | Claude | AGENTS.md / CLAUDE.md / GUARDRAILS.md |
| S5 .claude/ 배포 | `install-project-claude.{ps1,sh}` | 14 파일 |
| S6 아키텍처+세션 | Claude | projects/<name>/ 4종 + sessions/<name>/v0.1/ |
| S7 후속 안내 | Claude | output style / GUARDRAILS 작성 안내 |

## 배경

v1.10 이전: 인터뷰 질문이 정해지지 않아 매 bootstrap마다 재발명. Q7(meta_ref)/Q8(guardrails)/Q9(locale)는 답이 항상 동일 → v1.14에서 자동 적용으로 이관, 7Q로 간결화.

핵심 설계 원칙:

- **Single-turn UX**: 7질문을 한 번에 표시 → 사용자 한 번에 답변 (7 turn 회피)
- **TOML 안전성**: 5종 특수문자(`"`, `'`, `\n`, `$`, `\`) 거부 (render-manifest.sh exit 2)
- **Idempotency**: `.harness.toml` 존재 시 abort + backup 후 재진입

## 결과

- 자동 적용 10건: manifest 7 (schema_version / mcp_server / agents.primary / [build] / meta_ref / guardrails / locale) + AGENTS.md 콘텐츠 3 (bootstrap_version / install_cmd / license 4-tier)
- License 감지 4-tier: T1 SPDX 헤더 → T2 multi-file → T2 boilerplate 12패턴 → T3 메타데이터 4 source
- Cross-platform: bash 4+ 필수 (macOS 시스템 bash 3.2 → 경고)

## 관련 문서
