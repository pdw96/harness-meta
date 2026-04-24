# upbit — Stack

본 파일은 upbit 프로젝트의 언어·도구·버전 pin 정보를 기록한다. 자주 갱신되는 축이므로 `ARCHITECTURE.md`와 분리.

## 런타임

- **Python 3.12**
- **asyncio** (단일 이벤트 루프)
- **Docker Compose** (OCI ARM VM / 원격 PC Docker Desktop 배포)

## 패키지 매니저

- **Poetry** (`pyproject.toml` + `poetry.lock`)
- `requirements.txt` 미사용 (ADR-024)

## 주요 의존성 (프로덕션)

| 라이브러리 | 버전 | 용도 |
|---|---|---|
| `websockets` | ^12.0 | Upbit WebSocket 체결 tick |
| `httpx` | ^0.27 | Upbit REST API 비동기 호출 |
| `PyJWT` | ^2.8 | Upbit API 인증 |
| `pydantic-settings` | ^2.2 | 환경변수 관리 |
| `pandas` | ^2.2 | 지표 계산 |
| `numpy` | >=1.26,<3 | 벡터 연산 |
| `prometheus-client` | ^0.20 | 메트릭 노출 |
| `python-dotenv` | ^1.0 | `.env` 로드 |
| `jsonschema` | ^4.26 | index.json 스키마 검증 (harness) |
| `pyyaml` | ^6.0 | 설정/로드 |

## 개발 도구

| 도구 | 버전 | 역할 |
|---|---|---|
| `pytest` | ^8.0 | 테스트 러너 |
| `pytest-asyncio` | ^1.3 | async 테스트 |
| `pytest-cov` | ^5.0 | 커버리지 |
| `pytest-socket` | ^0.7 | 네트워크 차단 (단위 테스트) |
| `mypy` | ^1.10 | 타입 체크 (`strict = true`) |
| `ruff` | ^0.4 | 린터 + 포매터 (target-version = py312) |
| `pre-commit` | ^4.5 | commit hook (ruff/ruff-format/test-docstring on pre-commit; mypy --strict on pre-push) |

## 관측 (Optional Group)

| 라이브러리 | 용도 |
|---|---|
| `opentelemetry-api/sdk` | 트레이싱 (미사용 시 dormant) |
| `opentelemetry-exporter-otlp-proto-http` | OTLP HTTP exporter |

`HARNESS_OTEL_ENDPOINT` 설정 시에만 활성.

## 빌드·검증 커맨드

| 목적 | 커맨드 |
|---|---|
| 테스트 (bot) | `poetry run pytest tests/ -q` |
| 테스트 (harness) | `poetry run pytest scripts/tests/ -q` |
| 타입 체크 | `poetry run mypy bot/ config/ --strict` |
| 린트 | `poetry run ruff check bot/ config/` |
| 포맷 | `poetry run ruff format bot/ config/` |

`.harness.toml [testing]`에 동일 등록 예정.

## 배포 인프라

- 현재 원격 PC Docker Desktop (2-PC 구조: 바이브 코딩 PC + 서버 PC, Tailscale mesh)
- 향후 OCI Always Free ARM VM (Ampere A1.Flex 4-core/24GB)
- 이미지 빌드: `docker compose build --force-recreate` (멀티 아키텍처 `--platform linux/arm64`)

## 관측·알림

- **메트릭**: Grafana Agent → Grafana Cloud (remote_write)
- **대시보드**: Grafana Cloud (v1.2에서 구성)
- **알림**: Discord Webhook (ADR-030, bot notifier + Grafana Managed Alert 공유 channel)

## CI/CD

- GitHub Actions (`deploy-local.yml`) self-hosted runner (label: `[self-hosted, Windows, upbit-deploy]`)
- 실패 시 `rollback-local.yml` 수동 트리거 (ADR-031)
- Paper bot 자동 / Live bot 수동 배포

## 버전 정보 (snapshot 시점)

- upbit 비즈니스 semver 진행: v0.1 → v1.5 (planning)
- upbit 하네스 이력 (레거시): v1.1 ~ v1.4 (글로벌화 이전, `sessions/upbit/v*.1-legacy/`로 이관)
