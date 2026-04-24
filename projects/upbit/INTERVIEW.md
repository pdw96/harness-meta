# upbit — Bootstrap Interview (역산)

upbit는 글로벌 harness-meta 도입 이전부터 하네스를 보유한 상태였기에, bootstrap 인터뷰를 **역산**(현 구조를 기반으로 "도입 시점에 이런 질문에 어떤 답이었을지")하여 작성. 향후 dowon_trading 등 신규 프로젝트 bootstrap 때 본 문서를 참조 샘플로 사용.

본 문서 질문은 `~/harness-meta/bootstrap/interview.md`(작성 예정)의 표준 템플릿에 대응한다.

---

## Q1. 주 언어 / 런타임?

**답**: Python 3.12 (asyncio 단일 이벤트 루프).

**근거**:
- Upbit WebSocket 체결 tick 수신 + REST API 비동기 호출 수요
- pandas/numpy 벡터 연산 (지표 계산)
- 기존 Python 생태계(pyupbit 대체 시도 후 직접 httpx+PyJWT 채택)

---

## Q2. 패키지 매니저?

**답**: Poetry.

**근거**:
- poetry.lock으로 ARM64/x86 Docker 빌드 재현성 확보 (ADR-024)
- 의존성 그룹 분리 가능 (`dev`, `otel` optional)
- `requirements.txt` 금지 (핵심 규칙)

---

## Q3. 테스트 러너 + 커버리지?

**답**: pytest + pytest-asyncio + pytest-cov.

**부가 설정**:
- `pytest-socket`으로 단위 테스트 네트워크 차단 (실외부 호출 방지)
- 커버리지는 Codecov(`codecov/codecov-action@v5`) CI 자동 업로드
- 테스트 경로 분리: `tests/` (bot), `scripts/tests/harness/` (하네스)

---

## Q4. 타입 체커 + 린터?

**답**: mypy (`strict = true`) + ruff (`target-version = py312`).

**pre-commit 정책**:
- pre-commit: `ruff check`, `ruff format`, `test-docstring`
- pre-push: `mypy --strict`
- 설치: `poetry run pre-commit install && poetry run pre-commit install --hook-type pre-push`

---

## Q5. 배포 타겟?

**답**: Docker Compose 기반 멀티 컨테이너.

**현재**:
- 원격 PC Docker Desktop (Windows, 2-PC 구조 + Tailscale)
- Paper bot (N개 전략) + Live bot (검증 완료 1개) + Grafana Agent

**향후**:
- OCI Always Free ARM VM (Ampere A1.Flex 4-core/24GB) 또는 AWS (미확정)
- 멀티 아키텍처 빌드 (`--platform linux/arm64`)

---

## Q6. Phase 단위 감각?

**답**: 기능 단위 (feature phase). 비즈니스 semver와 매핑.

**예시**:
- v0.1 MVP — 15 steps
- v0.2 Enhancement (Regime + Consensus) — 6 steps
- v1.0 Production (RSI/BB/MACD + Trailing) — 7 steps
- v1.5 Dashboard-Provisioning — 기획 중

**한 phase = 한 모듈군 변경**이 전형. 큰 milestone은 다중 phase(milestone.json)로 분할.

---

## Q7. 문서 구조 선호?

**답**: 3층 구조.

- `docs/core/` — 공통 아키텍처 + ADR (버전 불변)
- `docs/scope/{version}/` — 마일스톤별 PRD + ADR
- `docs/full/` — 원본 전체 문서 (source of truth)

추가:
- `docs/GUARDRAILS.md` — 하네스가 매 step에 주입하는 압축 요약 (5120 byte 상한)
- `CLAUDE.md` — Claude Code 세션 컨텍스트 (프로젝트 루트 + 글로벌 import)

---

## Q8. 알림 채널?

**답**: Discord Webhook (v1.3에서 Telegram → Discord 전환, ADR-030).

**prefix 분리**:
- `[BOT]` — bot runtime notifier (체결/손절/일일 리포트)
- `[INFRA]` — Grafana Managed Alert (up/daily_loss/api_error)
- `[HARNESS]` — 하네스 세션 (H-ADR-009)

동일 webhook URL 공유. 별도 채널 분리는 `DISCORD_WEBHOOK_URL_INFRA/HARNESS` 추가 필드로 가능 (미구현).

---

## Q9. 이미 존재하는 CRITICAL 규칙?

**답**: 6+ 항목 (`docs/GUARDRAILS.md`).

주요:
1. 주문 실행 코드 격리 (`live/paper/order_executor.py`만)
2. 독립 컨테이너 (공유 상태 금지)
3. 환경변수는 `config/settings.py`(pydantic BaseSettings) 경유만
4. 전략 코드는 `core/strategy.py`에만
5. 메트릭 중앙 정의 (`core/metrics.py`)
6. TDD + Paper-First (ADR-027)

---

## Q10. 관측·트레이싱 요구?

**답**:
- **메트릭**: Prometheus (agent → Grafana Cloud remote_write) — 필수
- **트레이싱**: OpenTelemetry OTLP (optional, `HARNESS_OTEL_ENDPOINT` 설정 시에만)
- **로그**: stdout → Docker compose logs (별도 집중화 없음)

---

## Q11. CI/CD 인프라?

**답**: GitHub Actions self-hosted runner.

- `deploy-local.yml` — Paper 자동 / Live 수동 (ADR-031)
- `rollback-local.yml` — 수동 트리거
- self-hosted runner 라벨: `[self-hosted, Windows, upbit-deploy]`
- 원격 PC에 `C:\deploy-state\last-good.sha` 유지

---

## Q12. 기존 하네스 유무?

**답**: **있음** (글로벌화 이전 로컬 관리).

- 코어 코드: `scripts/harness/` (~60 모듈)
- 테스트: `scripts/tests/harness/` (~40 파일)
- 통합 레이어: `.claude/{commands,agents,skills,output-styles,hooks}/harness-*`
- 이력 저장: `harness-meta/v1.1~v1.4/` + `phases/HARNESS_CHANGELOG.md`

**글로벌화 후 처리**:
- 통합 레이어 → `~/harness-meta/claude/`로 이관 + 프로젝트-중립화
- 이력 → `~/harness-meta/sessions/upbit/v*.1-legacy/`로 이관
- 코어 코드 → 현 위치 유지 (L3 보류)

---

## 도출된 첫 `.harness.toml` (upbit)

```toml
schema_version = "1.0"

[project]
name = "upbit"
language = "python"
package_manager = "poetry"
python_version = "3.12"

[harness]
code_dir = "scripts/harness"
phases_dir = "phases"
guardrails = "docs/GUARDRAILS.md"
mcp_server = "harness"
executor = "scripts/execute.py"

[architecture]
meta_ref = "projects/upbit/ARCHITECTURE.md"

[testing]
test_cmd = "poetry run pytest tests/ -q"
harness_test_cmd = "poetry run pytest scripts/tests/ -q"
type_check_cmd = "poetry run mypy bot/ config/ --strict"
lint_cmd = "poetry run ruff check bot/ config/"

[notifications]
discord_webhook_env = "DISCORD_WEBHOOK_URL"
```
