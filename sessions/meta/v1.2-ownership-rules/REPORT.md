# meta v1.2-ownership-rules — REPORT

세션 기간: 2026-04-24 (단일 세션)
세션 범위: `sessions/meta/` vs `sessions/<project>/` 귀속 판정 규약 명문화
판정: **PASS** (성공 기준 6/6 충족)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 파일 4건이 S1×1(`claude/commands/harness-meta.md`) + S2×1(`bootstrap/docs/OWNERSHIP.md`) + S3×2(`README.md`, `CLAUDE.md`) — 전부 글로벌/repo-소유. **T1 경로 다수결** + **T2 스펙 범주**(분류 규약 자체)로 meta 소유 확정. 본 규약의 단일 소스(`bootstrap/docs/OWNERSHIP.md`)를 만드는 세션이므로 자기 참조는 규약 발효 시점부터 일관.

## 최종 결과

- **신규 파일 2**: `bootstrap/docs/OWNERSHIP.md`, `CLAUDE.md`
- **재작성 1**: `README.md` (설명서 기조 전면 재작성, 대상 프로젝트 섹션 제거)
- **갱신 1**: `claude/commands/harness-meta.md` (세션 소속 판단 소섹션 신설)
- **세션 기록 2**: `PLAN.md` + `REPORT.md` (본 디렉토리)
- **테스트**: 수동 self-apply — 4 파일 전부 S1/S2/S3 → T1 다수결 meta 확인

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 | 구현 파일 |
|---|------|------|----------|
| 1 | Scope 분류 S1–S7 명문화 | ✅ | `bootstrap/docs/OWNERSHIP.md` §Scope 분류 |
| 2 | Tie-breaker T1–T5 명문화 | ✅ | `bootstrap/docs/OWNERSHIP.md` §Tie-breakers |
| 3 | PLAN 템플릿 "세션 소속 근거" 규격 | ✅ | `bootstrap/docs/OWNERSHIP.md` §PLAN 템플릿 |
| 4 | Evolution 조항 (L3 추출 시 S5 재분류) | ✅ | `bootstrap/docs/OWNERSHIP.md` §Evolution |
| 5 | `CLAUDE.md` 신규 (upbit 스타일) | ✅ | `CLAUDE.md` — `@bootstrap/docs/OWNERSHIP.md` import 포함 |
| 6 | `README.md` 설명서 재작성 (대상 프로젝트 제거) | ✅ | `README.md` — 11 섹션 (목차/개요/요구사항/설치/구조/활성화/사용법/소속판정/버전축/재현/트러블슈팅/관련) |
| 7 | `harness-meta.md` command 갱신 | ✅ | `claude/commands/harness-meta.md` "세션 소속 판단" 소섹션 + OWNERSHIP 링크 |
| 8 | v1.1 motivating example 인용 | ✅ | `bootstrap/docs/OWNERSHIP.md` §v1.1 motivating example |

**완수율**: 8/8 (100%).

## 판정 (PLAN 성공 기준)

| 기준 | 결과 | 검증 |
|------|------|------|
| OWNERSHIP.md에 S1–S7, T1–T5, Evolution, PLAN 템플릿 4 블록 | ✅ | 목차 확인 |
| CLAUDE.md upbit 스타일 + OWNERSHIP import | ✅ | `@bootstrap/docs/OWNERSHIP.md` 구문 포함 |
| README 설명서 구조, 대상 프로젝트 섹션 없음 | ✅ | "## 대상 프로젝트" 섹션 부재 확인 |
| harness-meta.md 세션 소속 판단 소섹션 | ✅ | `## 세션 소속 판단` 헤더 존재 |
| 본 PLAN self-apply 검증 (S1/S2/S3 → meta) | ✅ | 변경 4 파일 scope 분류 일치 |
| REPORT에 v1.1 motivating example 인용 | ✅ | OWNERSHIP.md §v1.1 motivating example + 본 REPORT 하단 |

**6/6 전부 충족**.

## v1.1 motivating example (인용)

v1.1-global-smoke-test는 본 규약이 해결하는 문제의 **실제 사례**:
- **목표**: 글로벌 레이어(symlink / hook / statusline / MCP tools) 정상 작동 검증
- **실행 위치**: CWD=upbit (다른 CWD에서는 글로벌 동작 관찰 불가)
- **잘못된 최초 분류**: `sessions/upbit/` (CWD basename 기준 자동 추론)
- **올바른 분류**: `sessions/meta/` (검증 대상이 글로벌 레이어 → T3 적용)
- **정정**: 사용자 지적으로 이동 완료

v1.2 규약 도입 이후는 PLAN 상단의 **"세션 소속 근거"** 섹션에서 T3를 명시적으로 적용 → 동일 오분류 원천 차단.

## Lessons Learned

1. **CWD ≠ 소유권**: 하네스 세션은 실행 위치(CWD)와 변경 대상(scope)이 다를 수 있다. `/harness-meta` 자동 추론은 편의 수단이며, 최종 판정은 변경 대상 기준. PLAN 상단 "세션 소속 근거" 섹션을 의무화한 이유.
2. **단일 소스의 가치**: scope 분류를 README / CLAUDE / command에 분산시키면 drift 발생. `bootstrap/docs/OWNERSHIP.md` 단일 소스 + 각 진입점은 링크만 유지하는 방식으로 drift 차단.
3. **설명서 ≠ 인벤토리**: README는 repo의 **사용법**을 설명해야 하며, 관리 중인 프로젝트 **목록**을 담으면 유지 비용(프로젝트 추가/삭제 시 README 동기화)과 설명서 가독성이 함께 나빠짐. 프로젝트 목록은 `projects/` 디렉토리 그 자체가 소스.
4. **CLAUDE.md는 repo 진입점의 역할**: upbit/CLAUDE.md가 프로젝트 정체성·규칙·명령어·구조를 담듯이, `~/harness-meta/CLAUDE.md`도 동일 역할. Claude Code가 세션 시작 시 자동 로드하는 파일이므로 반복 호출되는 지침은 여기에 집중.
5. **규약 자체의 귀납적 자기 검증**: 본 세션은 scope 규약을 만드는 세션이면서 동시에 그 규약으로 자신의 소속을 결정한다. 이는 규약 발효 시점 이후로는 일관된 순환이며, **OWNERSHIP.md 문서 자체가 S2에 속하고 이를 수정하는 세션은 meta 소유**라는 점이 규약의 보편성을 뒷받침.

## 다음 후보 (보류)

| 후보 세션 | 진입 command | scope | 내용 |
|-----------|--------------|-------|------|
| `sessions/meta/vX-bootstrap-templates/` | `/harness-meta meta` | S2 | `bootstrap/templates/{language-{pm}}/` 언어별 뼈대 작성 (v1.0-bootstrap 범위 제외분) |
| `sessions/meta/vX-install-verify/` | `/harness-meta meta` | S3 | `install.ps1`에 post-install 자가 검증 추가 (smoke 절차 스크립트화) |
| `sessions/upbit/vX-milestone-status-sync/` | `/harness-meta upbit` | S5 | v1.1 KI-1 해결 (상위 `phases/index.json` milestone 자동 전파) |
| `sessions/meta/vX-ownership-l3/` | `/harness-meta meta` | S1 | L3(코어 추출) 시점에 OWNERSHIP 개정 (Evolution 조항 트리거) |

**"백로그"는 자동 후행이 아니라 사용자가 다음에 명시적으로 command 호출해야 진행됨.**

## 커밋 계획

단일 커밋 제안:

```
docs(meta): sessions/meta/v1.2-ownership-rules — ownership S1–S7 / T1–T5 codification

- add: bootstrap/docs/OWNERSHIP.md (S1–S7 + T1–T5 + Evolution + PLAN 템플릿 규격)
- add: CLAUDE.md (upbit/CLAUDE.md 스타일, @bootstrap/docs/OWNERSHIP.md import)
- rewrite: README.md (설명서 기조, 대상 프로젝트 섹션 제거)
- update: claude/commands/harness-meta.md (세션 소속 판단 소섹션 신설)
- add: sessions/meta/v1.2-ownership-rules/{PLAN,REPORT}.md

motivating example: v1.1-global-smoke-test 초기 오분류 사례 (CWD=upbit로 실행하여
sessions/upbit/에 잘못 생성 → sessions/meta/로 이동). 규약 발효 후 PLAN 상단
"세션 소속 근거" 섹션의 T3 명시로 재발 차단.
```

사용자 확인 후 `~/harness-meta` repo에 커밋.
