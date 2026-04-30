# upbit — ROADMAP

프로젝트 후속 세션 통합 view. `~/harness-meta/sessions/meta/ROADMAP.md` (meta 전역)와 분리된 **프로젝트별 단일 소스**.

⚠️ 본 파일은 운영 docs 성격 — `projects/upbit/` 하위 5번째 표준 파일 (ARCHITECTURE / DECISIONS / INTERVIEW / STACK + ROADMAP). 후속 트리거 통합 view + harness-meta 8단계 흐름의 단계 3(ROADMAP 읽기) + 단계 9(ROADMAP 갱신) 진입점.

마지막 audit: 2026-04-30 (v1.3-roadmap-backfill 소급 작성)

## 1. 다음 후보 (활성)

| # | 후속 세션 | 진행 근거 | 출처 |
|:-:|---------|---------|------|
| (현재 없음 — trigger 도달 시 §2에서 promote) |

## 2. Out of scope (trigger 대기)

각 후속 세션을 5 trigger 종류 (A 외부 사용자 / B 회귀 / C 외부 환경 / D 설계 / E 정규화)에 매핑.

| 후속 세션 | trigger 종류 | trigger 조건 | 출처 |
|---------|:----------:|------------|------|
| `v1.4-statusline-cmd-migration` — statusline 풍부한 출력 복원 (v1.6/v1.7 spec 후속) | B | `verify.ps1/sh` statusline 출력 불완전 또는 사용자 요청 | `v1.0 REPORT "후속 세션 연결"` |
| `v1.4-manifest-upgrade-1.1` — `.harness.toml` schema_version `"1.0"` → `"1.1"` bump | E | 사용자가 v1.1 신규 필드(`runtime_version`/`state_file` 등) 활성화 원할 때 | `v1.0 REPORT "후속 세션 연결"` |

## 3. Schedule 후보

자동 감지 가능한 정기 점검 항목 (cadence 추정값).

| 작업 | cadence | trigger 조건 | 출처 |
|------|---------|------------|------|
| (없음) |

## 4. 자동 검증 (drift 감지)

본 ROADMAP drift 감지: `bash ~/harness-meta/tests/smoke-roadmap-sync.sh`. 프로젝트 ROADMAP은 Stage 5에서 검증.

각 upbit 프로젝트 세션 종료 후 `harness-roadmap-update` SKILL 명시 invoke로 §6 "최근 완료" + §2 "Out of scope (trigger 대기)" 자동 갱신.

## 5. 갱신 정책

meta ROADMAP §6 답습:
- 진행 가능 → §6 archive (완료 일자 + 산출 기록)
- 신규 후속 → §2 또는 §3 분류 추가
- §2 → §1 promote (trigger 도달 + 사용자 확인 시)

## 6. 최근 완료

| 완료 세션 | 진행 일자 | 산출 |
|---------|---------|------|
| **v1.3-roadmap-backfill** | 2026-04-30 | v1.36 Bootstrap S6 5종 파일 체계 소급 보완. `projects/upbit/ROADMAP.md` 신규 작성 (v1.0~v1.2 이력 기반). pending 2건 §2 trigger 대기 이관 |
| **v1.2-python-overlay-apply** | 2026-04-28 | meta v1.11b Python overlay T4 후행. `harness-python/SKILL.md` + `python-quality.md` upbit 배포. `install-project-claude.sh --force` exit 0. 기존 6 skill + 4 agent + output-style 회귀 0 |
| **v1.1-skills-migration** | 2026-04-25 | meta v1.8b commands→skills T4 후행. `.claude/commands/` 6 파일 삭제 + skills 6 정리. `.claude/backup-*/` gitignore 추가. rename 3 + delete 3 + modified 3 |
| **v1.0-project-claude-install** | 2026-04-25 | meta v1.8 BREAKING 후속. `install-project-claude.ps1` 실행 → upbit `.claude/` 17 파일 복구 (commands 6 + agents 4 + skills 6 + output-styles 1). upbit commit `703a21e` |

## 7. 관련 문서

- 상위 진입: [`../../CLAUDE.md`](../../CLAUDE.md)
- 프로젝트 아키텍처: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- 프로젝트 결정 (H-ADR): [`DECISIONS.md`](DECISIONS.md)
- 프로젝트 인터뷰 답변: [`INTERVIEW.md`](INTERVIEW.md)
- 프로젝트 스택: [`STACK.md`](STACK.md)
- meta ROADMAP (전역 횡단 view): [`~/harness-meta/sessions/meta/ROADMAP.md`](../../sessions/meta/ROADMAP.md)
- upbit `.harness.toml` 매니페스트: (upbit repo 루트)
- 8단계 흐름: [`~/harness-meta/claude/commands/harness-meta.md`](../../claude/commands/harness-meta.md)
- ROADMAP 갱신 SKILL: [`~/harness-meta/bootstrap/skills/audit/harness-roadmap-update/SKILL.md`](../../bootstrap/skills/audit/harness-roadmap-update/SKILL.md)
