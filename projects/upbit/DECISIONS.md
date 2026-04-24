# upbit — Harness Decisions (H-ADR)

upbit 프로젝트의 **하네스 설계 결정** 이력. 봇 도메인 결정(`docs/core/ADR.md`, 예: ADR-027 Paper-First)과 구분.

각 결정은 (a) 배경, (b) 대안, (c) 결정, (d) 트레이드오프, (e) 필요 시 롤백 경로를 포함한다.

---

## H-ADR-001: 디렉토리 `scripts/harness/` 채택

**배경**: 하네스 코드를 어디 둘지 — `tools/`, `harness/` (루트), `src/harness/`, `scripts/harness/` 후보

**결정**: `scripts/harness/` — 이유:
- `scripts/`는 비즈니스 런타임과 분리된 개발 도구 관례
- `scripts/tests/harness/`로 테스트 병치 가능
- `mypy_path = ["scripts"]` 설정으로 `import harness`/`import execute` 해소 (pyproject.toml)

**트레이드오프**: 프로젝트 레이아웃에 `scripts/`가 없는 팀은 적용 어색. 글로벌화 후 L3 (코어 추출) 시 별도 repo로 이동 검토

---

## H-ADR-002: Poetry + pyproject.toml 단일 의존성 관리

**배경**: Poetry vs pip + requirements.txt vs pip-tools

**결정**: Poetry. 비즈니스 코드(ADR-024)와 동일 관리 — `requirements.txt` 생성 금지

**트레이드오프**: Poetry 설치 필요 (Dockerfile + CI 포함). 신규 기여자 학습 비용 소량

---

## H-ADR-003: 가드레일 5120 byte 상한

**배경**: `builders.py`가 매 step 프롬프트에 주입하는 공통 규칙 문서. 무한정 길어지면 비용·context pollution

**결정**: `docs/GUARDRAILS.md` 5120 byte / UTF-8 기준 ≈5KB 유지. 초과 시 `builders.load_guardrails()`가 stderr WARN

**트레이드오프**: 모든 CRITICAL 규칙을 이 상한 내에 압축 필요. 상세는 `docs/core/ADR.md` 및 `CLAUDE.md`로 분산

---

## H-ADR-004: `index.json` 단일 진실 원천 + atomic 갱신

**배경**: step 상태(`pending/completed/error/blocked`) 관리를 어디서? DB / SQLite / JSON / markdown?

**결정**: `phases/{version}/{phase}/index.json` JSON 파일. `execute.py`만 atomic write (`index_store.py`의 O_EXCL 락). JSON schema로 구조 강제 (`schemas.py`)

**트레이드오프**: 복잡 쿼리 불가 (DB 대비). 동시 접근은 `.harness.lock` PID 기반 락으로 차단 (v0.1.1)

---

## H-ADR-005: MCP 서버 (`harness`) — schema-enforced 조회/갱신

**배경**: Claude Code 세션 내부에서 index.json 직접 편집 시 schema 위반 위험. 래퍼 필요

**결정**: MCP server (`scripts/harness/mcp_server.py`) + tool 다수 (`harness_list_phases`, `harness_get_phase_index`, `harness_update_step_status` 등). `.mcp.json`의 `enabledMcpjsonServers`에 `harness` 이름 고정 (글로벌 관례)

**트레이드오프**: MCP 프로토콜 의존. Claude Code 환경 외부에선 사용 불가 (CLI로 대체 가능)

---

## H-ADR-006: Retry 상한 + fallback 모델

**배경**: Claude API 500 / transient error 시 전체 phase 중단 방지

**결정**: `HARNESS_MAX_RETRIES` 환경변수 (기본 3) + step-level `fallback_model`(sonnet default). index.json의 step 필드 `max_budget_usd`, `timeout_s`, `fallback_model` optional 지원

**트레이드오프**: API 서비스 degradation 시 비용 증가. budget 필드로 상한 설정 가능

---

## H-ADR-007: `depends_on` DAG 병렬 실행 (v1.24+)

**배경**: 독립 가능한 step들을 직렬 실행하면 시간 낭비

**결정**: step 필드 `depends_on: [int]` 추가 → 위상정렬 + level 단위 병렬. `--parallel-steps --parallel-no-commit --push-per-level` 조합 가능. 순환 감지는 `validation.py`

**트레이드오프**: 병렬 실행 중 실패 시 부분 상태. `--parallel-no-commit` 옵션으로 level 전체 성공 시만 commit

---

## H-ADR-008: statusline + session-init hook 글로벌 승격 (v1.5+)

**배경**: 통합 레이어(.claude/harness-*)가 프로젝트별 중복. 신규 프로젝트 도입 시 복사 번거로움

**결정**: 글로벌 harness-meta repo(`~/harness-meta/claude/`) 도입. `~/.claude/`에 symlink. 각 프로젝트는 `.harness.toml` 매니페스트만 유지

**트레이드오프**: symlink 유지 관리 필요 (Windows Dev Mode 필수). repo 위치 강제 (`HARNESS_META_ROOT` 환경변수로 완화)

**롤백**: upbit 로컬 `.claude/harness-*` 제거 커밋 revert → project-level이 다시 작동

---

## H-ADR-009: Discord webhook 하네스 전용 prefix `[HARNESS]`

**배경**: 봇 runtime notifier (ADR-029 `[BOT]`, Grafana Managed Alert `[INFRA]`)와 동일 채널 공유 시 메시지 혼잡

**결정**: harness notifier는 prefix `[HARNESS]`. bot runtime / Grafana와 동일 webhook URL 사용

**트레이드오프**: channel 하나에 3 prefix 공존. 분리 원하면 `DISCORD_WEBHOOK_URL_HARNESS` 추가 필드 가능 (현재 미구현)

---

## H-ADR-010: `docs/GUARDRAILS.md` 경로 매니페스트화

**배경**: builders.py가 경로 하드코딩 → 다른 프로젝트 재사용 시 수정 필요

**결정**: `.harness.toml [harness].guardrails` 필드로 프로젝트별 선언. 기본값 `docs/GUARDRAILS.md`. 글로벌화(v1.5) 시 도입. upbit는 현 경로 유지 (별도 이동 불필요)

**트레이드오프**: 매니페스트 파싱 의존 — 매니페스트 미설치 시 builders 기본값 fallback

---

## H-ADR-011: `.harness.lock` atomic O_EXCL + PID cleanup

**배경**: 같은 phase를 두 Claude 세션에서 동시 실행 시 `index.json` race condition. 잘못된 step 상태 overwrite 또는 중복 API 비용 발생 위험

**대안**:
- (a) 파일 기반 락 (O_EXCL 원자 생성) — 채택
- (b) SQLite advisory lock — DB 도입 비용
- (c) Unix flock() — Windows 비호환

**결정** (v0.1.1):
- `phases/{version}/{phase}/.harness.lock` 파일을 `O_EXCL | O_CREAT`로 생성 → 이미 있으면 실패
- 락 파일에 현재 PID 기록
- 락 존재 시 해당 PID 생존 여부 확인 (`psutil` or `os.kill(pid, 0)`) → 죽은 PID면 stale 판정 후 자동 cleanup, 생존 시 차단
- 정상 종료 시 signal handler로 락 해제. 비정상 종료도 다음 실행 시 cleanup됨

**트레이드오프**:
- NFS/SMB 공유 파일시스템에선 `O_EXCL` 원자성 보장 약함 → 로컬 디스크 전제. CI 환경(GitHub Actions self-hosted)에서도 runner 로컬 워크스페이스라 OK
- PID recycling 위험 (죽은 PID가 다른 프로세스에 재할당) — 현실 확률 낮고, 최악의 경우 락이 부당하게 유지되어 사용자가 수동 삭제

**롤백**: 락 기능 제거는 `lock.py` 삭제 + executor 호출부 제거. 단, 동시 실행 방지 대체 메커니즘 없으면 race 재발생 — 제거 비권장

---

## 변경 이력 (레거시 semver 매핑)

글로벌화(harness-meta repo `v1.0-bootstrap`, 2026-04-24) 이전 upbit 하네스 변경 이력은 **`upbit` repo git history에 보존**된다. 구체적 위치:

- v0.x~v1.4: `upbit/phases/HARNESS_CHANGELOG.md` (세션 단위 분리 이전. semver 태깅된 1~14차 레거시)
- v1.5~v1.41: `upbit/harness-meta/vX.Y/PLAN.md + REPORT.md` (2026-04-15 ~ 2026-04-24 동안 누적)

글로벌화 커밋 시점에 `upbit/harness-meta/` 디렉토리는 upbit repo에서 삭제되며(git history에 영구 보존), 이후 upbit 하네스 개선은 `~/harness-meta/sessions/upbit/vX.Y-{name}/` (글로벌 repo)에 기록한다.

본 DECISIONS.md의 H-ADR 11개는 그 기간의 **주요** 결정 요약:
- H-ADR-001~H-ADR-007, H-ADR-011 — 레거시 세션에서 결정된 내용
- H-ADR-008~H-ADR-010 — 글로벌화 세션(v1.0-bootstrap)에서 신규 도입

자세한 결정 맥락은 해당 SHA 범위의 커밋 메시지 + `git show <sha>:harness-meta/vX.Y/REPORT.md`로 조회 가능.
