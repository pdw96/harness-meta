# meta v1.1-global-smoke-test — REPORT

세션 기간: 2026-04-24 (단일 세션)
세션 범위: v1.0-bootstrap 글로벌화 결과의 실측 검증 (read-only)
판정: **PASS (1 Known Issue 발견, 본 세션 범위 외로 분리)**

**세션 소속 (소유권 기준)**: 검증 대상이 `~/harness-meta/claude/**` 글로벌 레이어 자체이므로 `sessions/meta/`. 초기에 `sessions/upbit/`에 잘못 생성했던 것을 사용자 지적으로 이동. 이 실수의 근본 원인은 `/harness-meta` command가 "주제의 소유권"보다 "CWD"를 선결 기준으로 삼고, README에 소유권 매트릭스가 명시되지 않은 구조적 결함 — 후속 세션 `meta/v1.2-ownership-rules/`에서 규칙화 예정.

## 최종 결과

- **17/17 symlink** 정상 (target 실존)
- **6 카테고리** 글로벌 레이어 모두 현 세션에 노출 확인
- **3 hook 케이스** 모두 기대 동작
- **1 statusline 케이스** 기대 포맷 출력, no-op 정책 준수
- **11 MCP tools** deferred tool 목록 노출 확인
- **execute.py --doctor 10 checks**: 0 FAIL / 1 WARN (ANTHROPIC_API_KEY 미설정만)
- **execute.py --status**: v1.5/7-dashboard-provisioning 4/4 steps 조회 성공
- **1 Known Issue**: 상위 `phases/index.json` milestone status가 phase 완료 후 자동 업데이트되지 않음

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 | 증거 |
|---|------|------|------|
| 1 | symlink 무결성 | ✅ 17/17 OK | `evidence/01-symlinks.txt` |
| 2 | SessionStart hook — upbit | ✅ `hookSpecificOutput.additionalContext` 2179 chars 주입 | `evidence/02-hook.txt` Case A |
| 3 | SessionStart hook — no-manifest | ✅ `{}` 빈 JSON, exit 0 | `evidence/02-hook.txt` Case B |
| 4 | Hook JSON schema | ✅ `hookEventName=SessionStart`, `additionalContext` 존재 | `evidence/02-hook.txt` Case C |
| 5 | statusline — upbit | ✅ `[harness] v1.5 OK` 출력 | `evidence/03-statusline.txt` Case A |
| 6 | statusline — no-manifest | ✅ 빈 출력, exit 0 | `evidence/03-statusline.txt` Case B |
| 7 | slash commands 노출 | ✅ 7종 (harness, harness-plan, -design, -run, -ship, -review, -meta) | `evidence/06-claude-layer.txt` §1 |
| 8 | skills 노출 | ✅ 3종 (harness-plan, -design, -ship) | `evidence/06-claude-layer.txt` §2 |
| 9 | agents 노출 | ✅ 4종 (harness-dispatcher, -explore, -grey-area, -verifier) | `evidence/06-claude-layer.txt` §3 |
| 10 | output-style 활성 | ✅ "Harness Engineer" preset 본 응답에 적용 | `evidence/06-claude-layer.txt` §4 |
| 11 | `.mcp.json` harness 서버 | ✅ 선언 + `scripts/harness/mcp_server.py` 실존 | `evidence/04-mcp.txt` |
| 12 | MCP deferred tools | ✅ 11 tools (`mcp__harness__harness_*`) | `evidence/04-mcp.txt` |
| 13 | `execute.py --doctor` | ✅ 0 FAIL / 1 WARN | `evidence/05-doctor.txt` |
| 14 | `execute.py --status` | ✅ v1.5/7-dashboard-provisioning 4/4 조회 | `evidence/07-status.txt` |
| 15 | `@~/harness-meta/...` include | ✅ CLAUDE.md 로드 시점에 경로 해석됨 | `evidence/06-claude-layer.txt` §6 |

**완수율**: 15/15 (100%). PLAN의 모든 목표 달성.

## Known Issue (본 세션 범위 외 — 후속 처리)

### KI-1. 상위 `phases/index.json` milestone status stale

**증상**: `phases/v1.5/milestone.json.status == "completed"` + `phases/v1.5/7-dashboard-provisioning/index.json.completed_at` 존재하는 상황에서도, 상위 `phases/index.json.milestones[v1.5].status == "planning"`로 남아 있음.

**영향**:
- `session-init.sh`가 v1.5를 "진행 중 milestone"으로 오표시 → 새 세션 시 오해 소지
- `statusline.sh`는 `current-version` 판정에서 v1.5를 current로 선택해 `[harness] v1.5 OK` 출력
- `--doctor`의 "milestone consistency" PASS는 `milestone.json`들 간의 상호 일관성만 체크하고, 상위 `phases/index.json`과의 동기화는 검사 대상 아님

**증거**: `evidence/08-known-issues.txt`

**후속 세션 제안**: `sessions/upbit/v1.2-milestone-status-sync/` (upbit scope — `scripts/harness/` 소유 코드 수정)
- 옵션 A: `upbit/scripts/harness/executor/orchestration.py` phase 완료 훅에서 상위 `phases/index.json.milestones[*].status` 자동 전파
- 옵션 B: `upbit/scripts/harness/doctor.py`에 top-index↔milestone.json 일관성 체크 추가 (PASS → FAIL 변환)
- ~~옵션 C (session-init.sh / statusline.sh fallback)~~ — 근본 치료가 아닌 회피 patch. 채택 지양.
- 진입 command: `/harness-meta upbit` (프로젝트별 하네스 개선 모드, execute.py 미사용)
- 선택은 v1.2 플래닝에서 결정

## 판정 (PLAN 성공 기준)

| 기준 | 결과 |
|------|------|
| symlink 17개 readlink OK | ✅ |
| upbit CWD hook → additionalContext 주입 | ✅ |
| no-manifest CWD hook → `{}` | ✅ |
| upbit CWD statusline → `[harness] ...` | ✅ |
| system reminder에 harness-* skill/agent/command 노출 | ✅ |
| `.mcp.json` harness 선언 + `mcp_server.py` 실존 | ✅ |
| `--doctor` exit 0 (WARN 허용) | ✅ |
| evidence/ 로그 대응 | ✅ |

**PLAN 8/8 전부 충족**.

## Lessons Learned

1. **msys/bash ↔ Windows Python path 불일치**: git bash의 `/c/...`를 native Windows python3에 넘기면 FileNotFoundError. Python 스크립트 호출 시 `C:/...` 형식 사용 필요. `session-init.sh` / `statusline.sh`는 이미 `CLAUDE_PROJECT_DIR` 환경변수가 Claude Code에 의해 native path로 설정되어 문제 없음.
2. **milestone status 이원화**: 상위 `phases/index.json`과 하위 `phases/{version}/milestone.json`의 status가 독립적으로 진화. `execute.py`가 phase 완료 시 milestone.json은 갱신하지만 상위 index는 갱신 경로가 명확치 않음. 설계 의도 vs 버그 판단은 v1.2에서.
3. **하네스 레이어 6종 노출**: Claude Code는 SessionStart 시점에 commands/agents/skills를 file system scan으로 enumerate. symlink는 투명하게 처리됨 — 글로벌화 설계가 Claude Code 런타임과 호환되는 것 확증.
4. **검증 전용 세션의 가치**: 글로벌화 직후 "작동 증거"를 남기지 않으면 회귀 발생 시 원인 추적이 오래 걸림. 각 주요 infra 변경 후에는 smoke test 세션을 관례화할 가치가 있음.

## 다음 후보 (보류 — 별도 세션에서 처리)

**"백로그"는 자동 후행이 아니라 사용자가 다음에 명시적으로 command 호출해야 진행됨.** 현재 REPORT 문자 기록이 유일한 트래킹 수단.

| 후보 세션 | 진입 command | scope | 내용 |
|-----------|--------------|-------|------|
| `sessions/meta/v1.2-ownership-rules/` | `/harness-meta meta` | meta | README + harness-meta.md에 소유권 매트릭스 명문화 (본 세션에서 겪은 오분류 재발 방지) |
| `sessions/upbit/v1.2-milestone-status-sync/` | `/harness-meta upbit` | upbit | KI-1 해결 (옵션 A/B 중 택1) |
| `sessions/meta/v1.1-bootstrap-templates/` | `/harness-meta meta` | meta | `bootstrap/templates/{language-{pm}}/` 뼈대 작성 (v1.0-bootstrap 범위 제외 항목) |
| `sessions/meta/v1.1-install-verify/` | `/harness-meta meta` | meta | `install.ps1`에 post-install 자가 검증 추가 (본 smoke 절차 스크립트화) |

## 커밋 계획

단일 커밋 제안:

```
docs(meta): sessions/meta/v1.1-global-smoke-test — PLAN + REPORT + 8 evidence

- 17/17 symlink OK
- 3 hook cases + 1 statusline case all pass
- 11 MCP tools exposed
- execute.py --doctor 10 checks (0 FAIL / 1 WARN)
- Known Issue: top phases/index.json milestone status stale (→ sessions/upbit/v1.2 후보)
- 소유권 오분류 사례: 초기 sessions/upbit/에 생성했다가 sessions/meta/로 이동 (→ sessions/meta/v1.2-ownership-rules 후보)
```

사용자 확인 후 `~/harness-meta` repo에 커밋.
