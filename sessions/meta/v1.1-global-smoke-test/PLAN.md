# meta v1.1-global-smoke-test — PLAN

세션 시작: 2026-04-24
선행 세션: `sessions/meta/v1.0-bootstrap/` (글로벌화 완료)
목적: 글로벌화 직후 통합 레이어가 기대대로 작동하는지 **실측 검증**.

**세션 소속 (소유권 기준)**: 검증 대상이 글로벌 레이어 자체(`~/harness-meta/claude/**` + symlink + install 결과)이므로 `sessions/meta/`. upbit 프로젝트는 실증용 대상일 뿐.

## 배경

v1.0-bootstrap에서 하네스 통합 레이어를 `~/harness-meta/` repo로 승격하고,
user-level symlink + `.harness.toml` 매니페스트 기반 세션 초기화를 도입했다.
설치 직후 "어디까지가 실제로 작동하는가" 실증 없음 → 본 세션에서 보증.

실패 시 fix는 본 세션에서 처리하지 않고 후속 세션 `v1.2-*`로 기록.
본 세션 범위는 **검증 + 증거 수집**에 한정.

## 목표

- [ ] symlink 무결성 확인 (6 카테고리, 17 링크, 타겟 파일 실존)
- [ ] SessionStart hook 실측: (a) upbit (.harness.toml 有), (b) 매니페스트 없는 CWD, (c) JSON 스키마 준수
- [ ] statusline 실측: upbit 포맷 / 매니페스트 없는 CWD no-op
- [ ] slash commands / agents / skills / output-style이 실제 세션에 로드되는지 확인 (system reminder 기반)
- [ ] `.mcp.json`의 `harness` 서버 선언 확인
- [ ] `python3 scripts/execute.py --doctor` 통과
- [ ] `python3 scripts/execute.py {phase} --status` 동작 확인 (read-only)
- [ ] CLAUDE.md의 `@~/harness-meta/...` include 참조가 실제로 해석되었는지 (현재 세션에 내용 노출)

## 범위

**포함**:
- 글로벌 레이어가 **upbit** 프로젝트에서 정상 작동하는지
- no-op 정책 (매니페스트 없는 프로젝트에서 무간섭)
- 세션 context 주입 증거

**제외**:
- 신규 기능 추가 / 리팩터 / 문서 보강
- 레이어 자체 개선 (발견된 이슈는 후속 세션 백로그)
- bootstrap 템플릿 보강 (이는 meta/v1.1-*에서 별도)

## 변경 대상

| 경로 | 변경 종류 |
|------|-----------|
| `~/harness-meta/sessions/meta/v1.1-global-smoke-test/PLAN.md` | 신규 |
| `~/harness-meta/sessions/meta/v1.1-global-smoke-test/REPORT.md` | 신규 (세션 종료 시) |
| `~/harness-meta/sessions/meta/v1.1-global-smoke-test/evidence/` | 실측 출력 로그 |

**코드 변경 없음**. 기존 파일 수정 없음.

## Grey Areas

### G1. 매니페스트 없는 CWD에서 hook의 no-op 방식

session-init.sh는 `[ ! -f "$MANIFEST" ]`일 때 `printf '{}'` + `exit 0`으로 빈 JSON 반환.
statusline.sh는 `exit 0` (빈 출력).
**결론**: 공식 hook output은 빈 JSON도 허용되는지가 관건. Claude Code 공식 문서 기준으로 `{}` 빈 object는 `additionalContext` 무주입과 동치이므로 안전. 이대로 검증만.

### G2. evidence 디렉토리 커밋 여부

실측 로그는 재현 가능하지만, 시점 고정 증거로서 커밋 가치 있음.
**결론**: 커밋한다. 단 PID/timestamp 등 가변 값은 placeholder로 치환.

### G3. 검증 실패 시 처리

smoke test 도중 이슈 발견 시 본 세션에서 fix 금지. REPORT.md에 **Known Issues** 섹션으로 기록하고 후속 세션 slug 제안.

## 성공 기준

- [ ] symlink 17개 `readlink`로 타겟 확인 완료, 모두 `~/harness-meta/claude/` 하위 실존
- [ ] `session-init.sh`를 upbit CWD로 수동 실행하면 `hookSpecificOutput.additionalContext`에 현재 milestone/phase 정보 노출
- [ ] `session-init.sh`를 매니페스트 없는 CWD로 실행 시 `{}`만 출력
- [ ] `statusline.sh`를 upbit CWD로 실행 시 `[harness] ...` 포맷 출력
- [ ] 현재 Claude 세션의 system reminder에 `harness-*` skill / agent / command 노출 확인 (본 대화 내용 증거)
- [ ] `.mcp.json`에 `harness` 서버 선언 확인 + `scripts/harness/mcp_server.py` 실존
- [ ] `poetry run python scripts/execute.py --doctor` 성공 exit 0 (혹은 의도된 WARN만)
- [ ] evidence/ 로그가 위 모든 항목에 대응

## 커밋 전략

1. PLAN.md 단독 커밋 (세션 시작 선언)
2. evidence/ + REPORT.md 커밋 (세션 종료)

커밋 전 사용자 확인 필수.

## 후속 세션 연결

- 검증 통과 시: 글로벌 레이어 v1.0 안정성 확인. 다음 meta/v1.1-*는 bootstrap 템플릿 보강.
- 검증 실패 시: REPORT.md의 Known Issues가 v1.2-fix-*의 입력.
