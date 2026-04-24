# upbit — Harness Architecture

업비트 자동매매 봇 프로젝트의 **하네스** 아키텍처 스냅샷. 비즈니스 코드(`bot/`, `config/`)는 대상 외 — 본 문서는 `scripts/harness/` 및 관련 통합 레이어만 다룬다.

> 비즈니스 측면(코드 구조·데이터 흐름)은 upbit repo의 `docs/core/ARCHITECTURE.md` 참조.

## 1. 디렉토리 구조

```
upbit/
├── scripts/
│   ├── execute.py                    # CLI entrypoint
│   ├── harness/                      # 하네스 코어 (package)
│   │   ├── __init__.py
│   │   ├── analytics.py              # 세션 분석 + 집계 (harness_get_analytics MCP tool)
│   │   ├── builders.py               # 프롬프트 조립 + GUARDRAILS 주입
│   │   ├── ci_events.py              # CI JSON 이벤트 emitter
│   │   ├── claude_runner.py          # Claude Code CLI 서브프로세스
│   │   ├── commit_policy.py          # 커밋 메시지 정책
│   │   ├── constants.py              # 상수 (경로, limits)
│   │   ├── doctor.py                 # 환경 진단 (Poetry/Python/git/Claude CLI 등 7항목)
│   │   ├── errors.py                 # 커스텀 예외
│   │   ├── executor/                 # 실행 엔진
│   │   │   ├── lifecycle.py          # phase lifecycle + retry
│   │   │   ├── actions.py            # step 개별 액션
│   │   │   ├── dry_run.py            # UAT 검증 (no mutation)
│   │   │   ├── orchestration.py      # --push-per-step, --from-step 등
│   │   │   ├── parallel.py           # depends_on DAG 병렬 실행 (v1.24+)
│   │   │   └── context.py            # step 컨텍스트 구성
│   │   ├── git_ops.py                # git status/diff/commit/push 래퍼
│   │   ├── index_store.py            # index.json atomic read/write
│   │   ├── iter_helpers.py           # step iterator 유틸
│   │   ├── lock.py                   # atomic O_EXCL 락 + PID cleanup
│   │   ├── logging_setup.py          # -v/-vv 레벨 조정
│   │   ├── mcp/                      # MCP 서버 (schema-enforced)
│   │   │   ├── protocol.py
│   │   │   └── tools/
│   │   │       ├── queries.py        # harness_list_phases, get_phase_index, …
│   │   │       └── mutations.py      # harness_update_step_status, reset_step, …
│   │   ├── mcp_server.py             # MCP stdin/stdout entrypoint
│   │   ├── meta_index.py             # harness-meta/INDEX.md 갱신 (레거시, 글로벌화 이후 미사용)
│   │   ├── milestone.py              # milestone.json helpers
│   │   ├── notifier.py               # Discord webhook (하네스 전용, bot notifier와 독립)
│   │   ├── otel.py                   # OTLP exporter (옵셔널)
│   │   ├── paths.py                  # 표준 경로 resolver
│   │   ├── reporter.py               # step-output.json 집계
│   │   ├── scaffolder.py             # --new-phase 뼈대 생성
│   │   ├── schemas.py                # JSON schema (index.json 등)
│   │   ├── self_test.py              # 내장 smoke test
│   │   ├── snapshot.py               # 상태 스냅샷 (에러 분석용)
│   │   ├── statusline_stats.py       # statusline.sh가 호출하는 stats 모듈
│   │   ├── step_hook.py              # step 전후 hook
│   │   ├── token_counter.py          # count_tokens (ANTHROPIC_API_KEY 사용 시)
│   │   ├── utils.py                  # 범용 유틸
│   │   ├── validation.py             # PLAN.md / index.json 검증
│   │   └── worktree_advisor.py       # 병렬 실행 권장 판정
│   └── tests/harness/                # 하네스 unit 테스트 (~40개 파일)
└── phases/                           # 실행 산출물
    ├── ROADMAP.md
    ├── index.json                    # milestone 레벨
    ├── HARNESS_CHANGELOG.md          # 레거시 v0.x~v1.4 이력 (글로벌화 이후 신규 작성 금지)
    └── {version}/
        ├── milestone.json
        └── {phase-dir}/
            ├── PLAN.md
            ├── index.json            # step 레벨 (JSON schema enforced)
            ├── step{N}.md
            └── REPORT.md             # ship 완료 후
```

## 2. 모듈 책임 요약

| 계층 | 모듈 | 역할 |
|---|---|---|
| **CLI** | `scripts/execute.py` | argparse entrypoint. 모든 옵션(--push-per-step, --dry-run, --reset-step, --from-step, --parallel-steps, --doctor, --new-phase 등) 라우팅 |
| **lifecycle** | `executor/lifecycle.py` + `orchestration.py` | phase 전체 실행 흐름, retry (`HARNESS_MAX_RETRIES`), commit/push 전략 |
| **DAG 병렬** | `executor/parallel.py` | `depends_on` 배열 기반 위상정렬 + level 단위 병렬 (v1.24+) |
| **상태** | `index_store.py` + `lock.py` | atomic read/write + O_EXCL 락 (v0.1.1) |
| **검증** | `validation.py` + `schemas.py` | index.json JSON schema, 순환 depends_on 감지 |
| **프롬프트** | `builders.py` | GUARDRAILS 5120 byte 상한, docs 압축 주입 |
| **CLI-Claude** | `claude_runner.py` | `claude` CLI 서브프로세스 (stdin 입력, stdout/stderr 캡처, exit code 판정) |
| **MCP** | `mcp/` + `mcp_server.py` | index.json 조회/갱신을 MCP tool로 노출. `.mcp.json` 등록 |
| **관측** | `ci_events.py` + `otel.py` + `logging_setup.py` | JSON 이벤트 (HARNESS_CI), OTLP 트레이스 (HARNESS_OTEL_ENDPOINT) |
| **알림** | `notifier.py` | Discord webhook (prefix `[HARNESS]`, bot notifier와 분리) |
| **진단** | `doctor.py` | Poetry/Python/git/Claude CLI/Node/pre-commit/lock 7항목 검사 |
| **스태튜스** | `statusline_stats.py` | 글로벌 `statusline.sh`가 호출 (current-version / phase-stats / milestone-cost / cache-hit) |

## 3. 실행 흐름 매핑

```
/harness              → dispatcher: phases/ 상태 읽고 다음 /harness-X 안내
/harness-plan         → 탐색+요구사항+논의+PLAN.md Write
/harness-design       → 설계+7-Dimension 검증+step{N}.md Write
/harness-run          → dry-run UAT + execute.py --push-per-step (실 CLI)
/harness-ship         → Goal-backward 검증 + /harness-review + REPORT.md + commit + push
/harness-review       → 5항목 체크 (ship 내부 호출용)
/harness-meta         → 하네스 자체 개선 세션 (harness-meta/sessions/upbit/vX.Y-{name}/)
```

## 4. 통합 지점

- **테스트 러너**: `poetry run pytest <path> -q` (bot + scripts/tests/harness 분리)
- **타입·린트**: `poetry run mypy bot/ config/ --strict`, `poetry run ruff check bot/ config/`
- **pre-commit**: `poetry run pre-commit install && poetry run pre-commit install --hook-type pre-push`
- **CI**: GitHub Actions `deploy-local.yml` (self-hosted runner + `rollback-local.yml`)
- **알림**: `DISCORD_WEBHOOK_URL` (bot runtime + harness notifier 공유, prefix로 구분)
- **Codecov**: `codecov/codecov-action@v5` (CI 자동 업로드)

## 5. 프로젝트 특이 규칙

- `docs/GUARDRAILS.md` — builders.py가 매 step에 주입. 5120 byte 상한, UTF-8 기준 ≈5KB. 초과 시 stderr WARN
- `bot/` 하위 CRITICAL 금지 (주문 격리, os.environ 직접 접근, 전략 중복 구현) — 자세한 목록은 upbit `CLAUDE.md` + `docs/GUARDRAILS.md`
- Paper-First (ADR-027): 실전 배포 전 Paper 72시간 검증 필수
- Docker 메모리 한도 (ADR-021): live 512MB, paper 256MB, agent 128MB

## 6. 변경 시 주의

- `index.json` 스키마 변경 → `schemas.py` + `migration` 스텝 필요 (v1.X-schema-migration 세션)
- `builders.load_guardrails()` 경로 변경 → `.harness.toml [harness].guardrails`와 동기 필요
- MCP tool 추가 → `.mcp.json` 재로드 + schema 문서화

## 7. 관련 문서

- [DECISIONS.md](DECISIONS.md) — H-ADR 이력
- [STACK.md](STACK.md) — 도구·버전 pin
- [INTERVIEW.md](INTERVIEW.md) — bootstrap 답변 역산
- 레거시 이력: `harness-meta/sessions/upbit/v1.1-legacy/ ~ v1.4-legacy/`
- upbit 비즈니스 아키텍처: `upbit/docs/core/ARCHITECTURE.md` (본 repo 아님)
