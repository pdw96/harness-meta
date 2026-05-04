# meta v1.17-ai-ready-improvements — PLAN

세션 시작: 2026-04-29
직접 선행 세션: [`sessions/meta/v1.16-adr-docs/`](../v1.16-adr-docs/PLAN.md)

목적: AI-Ready 스코어러(84/100) 결과 기반 두 가지 실질 개선.

- **A: session-init.sh 버그 수정** — 백슬래시 포함 state_file 시 invalid JSON 생성 버그
- **B: 통합 테스트 신설** — `tests/integration/` 3개 smoke (스코어러 +2점, 실질 커버리지 갭 해소)

> **제외 확정**: lock 파일(Python 의존성 없음·uv 미설치), src/ 분리(부적합), Docker(부적합).

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1a(1) `claude/hooks/session-init.sh` + S3(4) `tests/integration/` 3건 + `Makefile` = **5/5 meta**
- **T1 경로 다수결** — S1a+S3 전부 meta scope

## Scope inheritance (verbatim from 선행 세션)

**Source — 사용자 발의 (2026-04-29, AI-Ready 스코어러 roi_actions) verbatim**:

> 3. [중기/2점] tests/integration/ 디렉토리에 주요 플로우 통합 테스트 추가

**Parsed sub-items (2)**:

1. **tests/integration/ 신설** — 스코어러 +2점 + 실질 커버리지 갭 해소
2. **session-init.sh 버그 수정** — 정밀 분석 중 발견, 통합 테스트로 검증 가능

## Out of scope (explicit rejection)

| ❌ Item | 사유 |
|--------|------|
| Lock 파일 (uv.lock) | Python 의존성 없음, uv 미설치, 형식적 조치 |
| src/ 디렉토리 분리 | shell/Markdown repo에 부적합 |
| Docker / docker-compose.yml | meta repo 성격상 불필요 |
| test/source 비율 | 스코어러 오감지 (.py 소스 기준, shell repo에 부적용) |
| smoke-v1.1.sh 리팩토링 | 별도 세션 (현행 실행 성공만 검증하는 구조 개선은 범위 밖) |

## 1. 배경

### A — session-init.sh 버그

정밀 분석 중 발견. state_file에 백슬래시가 있으면 sed 파이프라인이 `\b`를 JSON backspace escape로 오생성, Python `json.loads`가 JSONDecodeError: Invalid control character를 던짐.

**재현**:

```bash
printf 'data with \backslash' > state.txt
# hook 출력 → ... ackslash" + invalid control char (0x08)
```

**원인**: `sed 's/\\/\\\\/g'` 이후 `\b` 조합이 JSON 파서에서 backspace escape로 해석됨.

**수정 방향**: `\b`, `\f`, `\n`, `\r`, `\t` 외 미정의 escape를 만들지 않도록 sed 처리 순서 정비 + 제어문자 범위 보강.

### B — 통합 테스트 갭

| 갭 | 기존 커버 | 필요한 검증 |
|----|---------|-----------|
| session-init.sh 4개 분기 | 1개만 실행 (출력 미검증) | 전 분기 + JSON validity |
| statusline timeout fallback | fixture 있으나 smoke 없음 | 3초 후 `[harness] <name>` 확인 |
| install manifest 가드 | 없음 | exit 1 확인 |
| install --force backup | 없음 | backup 디렉토리 생성 확인 |

## 2. 변경 대상

| 경로 | 변경 |
|------|------|
| `claude/hooks/session-init.sh` | 버그 수정: 백슬래시·제어문자 이스케이프 보강 |
| `tests/integration/` | 신규 디렉토리 |
| `tests/integration/test-session-init-branches.sh` | 4 분기 + JSON validity + 버그 회귀 방지 |
| `tests/integration/test-statusline-timeout.sh` | timeout 3초 fallback 검증 |
| `tests/integration/test-install-guards.sh` | manifest 가드 + --force backup |
| `Makefile` | `test-integration` 타겟 추가 |

## 3. 목표

- [ ] A: session-init.sh 백슬래시 JSON 버그 수정
- [ ] B-1: `tests/integration/test-session-init-branches.sh` — 4분기 + JSON valid + 버그 회귀
- [ ] B-2: `tests/integration/test-statusline-timeout.sh` — timeout fallback
- [ ] B-3: `tests/integration/test-install-guards.sh` — manifest 가드 + --force backup
- [ ] Makefile `test-integration` 타겟 추가
- [ ] 기존 smoke 13개 회귀 0 확인
- [ ] AI-Ready 재스코어 ≥ 86 확인

## 4. 성공 기준

- [ ] session-init.sh: 백슬래시 포함 state_file → valid JSON 출력
- [ ] `tests/integration/` 3개 smoke ALL PASS
- [ ] `make test-integration` exit 0 (또는 동등 bash 루프)
- [ ] 기존 smoke-*.sh 13개 ALL PASS (회귀 0)
- [ ] AI-Ready 스코어 ≥ 86

## 5. 커밋 전략

```
fix(meta): session-init.sh 백슬래시 JSON 이스케이프 버그 수정
feat(meta): v1.17-ai-ready-improvements — tests/integration/ 3개 smoke 신설
```
