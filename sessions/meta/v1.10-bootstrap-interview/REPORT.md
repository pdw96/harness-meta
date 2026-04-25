# meta v1.10-bootstrap-interview — REPORT

세션 기간: 2026-04-25 ~ 2026-04-26 (PLAN 4회 정밀 검토 후 구현)
세션 범위: `/harness-meta <new-name>` Bootstrap 모드의 10-stage 흐름 설계 + 자산 신설
판정: **PASS** (성공 기준 9/9, smoke 7/7 PASS)

**세션 소속 (self-apply)**: `sessions/meta/`. S2(11) + S1a(1) + S3(2) = 14/14 meta. T1 다수결 + T2 스펙 정의.

## 최종 결과

- **신규 자산 11 + smoke 1 + 세션 기록 3**
- **수정 4 파일** (슬래시 명령 + schema §12.3 + CLAUDE.md + README.md)
- **smoke**: 7-stage / 4 검증 포인트 모두 PASS — `tests/smoke-bootstrap-render.sh`
- **자체 일관성**: PLAN 4회 검토(R/M/W/S 라운드) 끝에 stale 카운트 0건 도달

## 신규 자산 (11)

| 경로 | 라인 | 역할 |
|------|------|------|
| `bootstrap/interview.md` | ~155 | Claude 인터뷰 질문지 (코어 7 + 옵션 manifest 3 + 자유 2) |
| `bootstrap/docs/INTERVIEW_FLOW.md` | ~150 | 10-stage 책임 분리 + abort 정책 + idempotency + cross-platform |
| `bootstrap/render-manifest.sh` | ~85 | env → `.harness.toml` v1.1 직렬화. bash 4+ gate (exit 3) + escaping 5종 (exit 2) + missing required (exit 1) + success (exit 0) |
| `bootstrap/skeletons/CLAUDE.md.tmpl` | ~20 | 신규 프로젝트 root CLAUDE.md baseline + ARCHITECTURE import |
| `bootstrap/skeletons/GUARDRAILS.md.tmpl` | ~20 | docs/GUARDRAILS.md placeholder + 5120 byte 안내 + 빈 § 4개 |
| `bootstrap/skeletons/projects/ARCHITECTURE.md` | ~50 | placeholder (디렉토리 구조 + 통합 지점 + 후속 작업) |
| `bootstrap/skeletons/projects/DECISIONS.md` | ~30 | H-ADR-001 placeholder |
| `bootstrap/skeletons/projects/INTERVIEW.md` | ~110 | 답변 원본 기록 (upbit 형식 준용 — `## QN.` + `**답**` + `**근거**`) |
| `bootstrap/skeletons/projects/STACK.md` | ~30 | 의존성·툴 표 placeholder |
| `bootstrap/skeletons/sessions/v0.1-bootstrap/PLAN.md` | ~50 | v0.1 PLAN placeholder (10-stage 체크박스) |
| `bootstrap/skeletons/sessions/v0.1-bootstrap/REPORT.md` | ~70 | v0.1 REPORT placeholder + 답변 요약 표 |

## 수정 파일 (4)

| 경로 | 변경 |
|------|------|
| `claude/commands/harness-meta.md` | (a) Bootstrap 절차 7-step → 10-stage 갱신 (b) interview.md 정확 링크 (c) tools에 8종 Bash 권한 추가 (`bash*`/`pwsh*`/`grep*`/`sed*`/`uname*`/`mv*`/`cp*`/`rm*`) — 매 호출 prompt 폭주 방지 |
| `bootstrap/manifest-schema.md` | §12.3 "Bootstrap 신규 작성 경로 (v1.10+)" 추가. interview.md / render-manifest.sh / 명시적 omit 7건 / TOML 안전성 cross-link |
| `CLAUDE.md` | 관련 문서 섹션에 INTERVIEW_FLOW.md 링크 + 최신 meta 세션을 v1.5 → v1.10으로 갱신 |
| `README.md` | 관련 문서 섹션에 Bootstrap 인터뷰 흐름 (interview.md + INTERVIEW_FLOW.md) 1줄 + 최신 meta 세션 v1.10 갱신 |

## smoke 7-stage 결과 (`evidence/smoke-bootstrap-render.txt`)

```
[smoke] META_ROOT=/c/Users/qkreh/harness-meta
[smoke] FIXTURE=/c/Users/qkreh/harness-meta/tests/fixtures/detect-python-uv
[Stage 1] detect PASS — language=python, package_manager=uv
[Stage 2] env mock set
[Stage 3] rendered to /tmp/tmp.XXX
[Stage 4] 7-line assertions PASS
[Stage 5] round-trip 3 fields PASS (name/code_dir/phases_dir)
[Stage 6] double-quote rejection PASS (exit 2)
[Stage 7] single-quote rejection PASS (exit 2)

PASS — bootstrap render smoke (7 stages)
```

**검증 항목 (4 포인트)**:
1. **Stage 4 — render TOML 7개 라인** (schema_version + name + locale + mcp_server + primary + meta_ref + type_check_cmd) 모두 정확
2. **Stage 5 — round-trip 3 필드** (name/code_dir/phases_dir): session-init.sh / statusline.sh의 grep+sed 패턴으로 재추출 가능 → hook 호환 보장
3. **Stage 6 — double quote 거부** (exit 2): TOML basic string 깨짐 방지
4. **Stage 7 — single quote 거부** (exit 2): bash `-c` 명령 주입 차단 (W2)

## 구현 요약 — PLAN 9/9

| # | 목표 | 결과 |
|---|------|------|
| 1 | bootstrap/interview.md (코어 7 + 옵션 3 + 자유 2 + 자동 4) | ✅ 12 질문 + 자동 적용 4건 + 명시적 omit 7건 + Q→A 처리 규칙 |
| 2 | bootstrap/docs/INTERVIEW_FLOW.md (10-stage + abort + idempotency + OS 분기) | ✅ 9 절 (진입조건/10-stage/데이터전달/실패정책/Idempotency/OS분기/로깅/CRLF/관련) |
| 3 | bootstrap/render-manifest.sh (bash 4+ gate + escaping 5종 + exit 4종) | ✅ ~85 LOC. schema §10 순서 일치 |
| 4 | skeletons/ 8 placeholder | ✅ projects/4 + sessions/2 + CLAUDE.md.tmpl + GUARDRAILS.md.tmpl |
| 5 | tests/smoke-bootstrap-render.sh (7 stage / 4 검증 포인트) | ✅ 7/7 PASS, 기존 fixture 재사용 (신규 fixture 0) |
| 6 | claude/commands/harness-meta.md (10-stage + interview.md 링크 + tools 8종) | ✅ |
| 7 | bootstrap/manifest-schema.md §12.3 추가 | ✅ Bootstrap 신규 작성 경로 cross-link |
| 8 | CLAUDE.md / README.md (INTERVIEW_FLOW 링크) | ✅ |
| 9 | Grey Area 24건 결정 + 본 REPORT | ✅ |

## Grey Area 24건 결정 반영 결과

| ID | 결정 → 구현 |
|---|---|
| G1 | Claude markdown 인터뷰 → ✅ interview.md (bash interactive 회피) |
| G2 | schema §6.2~6.3 기준 코어 7 → ✅ Q1~Q7 |
| G3 | detect unknown 첫 시도 manual + 빈 응답 3회 abort → ✅ Q→A 규칙 명시 |
| G4 | 기존 manifest abort + 사용자 명시 확인 → ✅ INTERVIEW_FLOW §5 |
| G5 | render-manifest.sh 분리 → ✅ |
| G6 | code_dir 자동 생성 No → ✅ S5 d) v1.11+ overlay 안내만 |
| G7 | install-project-claude 자동 호출 → ✅ S6 + uname 분기 |
| G8 | INTERVIEW.md = 답변 그대로 / ARCHITECTURE/STACK = 부분 채움 → ✅ |
| G9 | 세션 ID v0.1-bootstrap 고정 → ✅ skeletons/sessions/v0.1-bootstrap/ |
| G10 | AGENTS.md baseline v1.10b 후속 → ✅ 본 세션 미생성 (PLAN 제외 § 명시) |
| G11 | 코어 7 + 옵션 manifest 3 + 자유 2 = 12 + 자동 4 → ✅ |
| G12 | locale default "en" → ✅ Q9 default "en" + 한국어 사용자 명시 입력 |
| G13 | 단일 언어 가정 → ✅ |
| G14 | 비대화형 v1.22+ → ✅ PLAN 제외 § |
| G15 | abort 분기 → ✅ INTERVIEW_FLOW §4 stage별 |
| G16 | render bash-only → ✅ ps1 port 안 함 |
| G17 | TOML escaping 5종 거부 → ✅ render check_safe 함수 |
| G18 | skeletons/ 디렉토리 위치 (`bootstrap/skeletons/`) → ✅ install이 미관여 |
| G19 | CLAUDE.md baseline 3분기 → ✅ S5 a) (i/ii/iii) |
| G20 | scripts/harness/ v1.11+ + phases/.gitkeep → ✅ S5 c)/d) |
| G21 | bash 4+ gate (exit 3) → ✅ render-manifest.sh 시작부 |
| G22 | manifest backup 위치 (`.harness/backups/`) + .gitignore append → ✅ INTERVIEW_FLOW §5 |
| G23 | INTERVIEW.md upbit 형식 준용 (`## QN.` + `**답**` + `**근거**`) → ✅ skeletons/projects/INTERVIEW.md |
| G24 | Q&A 한 번에 12 표시 → ✅ interview.md "Q&A UX 시퀀스" 절 |

## Lessons Learned

1. **PLAN 정밀 검토의 효과 — 4 라운드 (R/M/W/S)** — 초안 → R(검토 반영 4건) → M+W(수정 5 + 보완 14) → S(자체 일관성 5 + 보완 4). 매 라운드마다 새로운 결함 유형 발견:
   - R 라운드: 슬래시 명령 약속과의 정합 누락 (CLAUDE.md baseline / GUARDRAILS / phases / README 등록 4건)
   - M 라운드: bash 4 호환·timestamp 형식·.gitkeep 일반화·검증 카운트 등 실 동작 위험
   - W 라운드: TOML escaping 5종(single quote 추가)·tmpl 변수 매핑·tools 권한 등 운영 안전
   - S 라운드: stale 카운트(옵션 5 / 자동 5) 6 위치·G표 stale·검증 포인트 ≠ stage 등 자체 일관성
   → **PLAN 검토는 "1회로 끝나지 않는다"**. 정정마다 다른 위치에 stale 잔존 가능.

2. **render-manifest.sh의 escaping 검증이 보안 경계** — 단순 TOML 깨짐 방지가 아니라 **bash `-c` 명령 주입 차단**이 본질. single quote `'` 추가가 결정적. Claude가 `bash -c "export HM_NAME='value'"` 호출 시 `'` 포함되면 quote escape 깨져 임의 명령 실행 가능. PLAN W2 정정으로 5종 거부 + Stage 7 smoke 검증.

3. **bash 4+ gate (exit 3)의 사일런트 fail 방지** — `${!v}` indirect expansion이 macOS 시스템 bash 3.2.57에서 silent fail. fixture 통과해도 실제 macOS 사용자 broken state. `BASH_VERSINFO[0] >= 4` gate + `brew install bash` 안내. 향후 다른 bash helper도 동일 패턴 적용 권장.

4. **skeleton 디렉토리 위치 분리 (`bootstrap/skeletons/` vs `bootstrap/templates/_base/`)** — install-project-claude는 `_base/.claude/`만 카테고리 순회. skeleton을 `_base/`에 두면 install 동작 간섭 위험. Claude가 직접 소비하는 자산은 별도 `skeletons/`로 분리하여 책임 경계 명확.

5. **명시적 omit 7건의 의도** — Bootstrap이 모든 manifest 필드를 채우려 하면 "v1.11+ overlay 미존재" 시점에서 모순(예: executor 경로가 가리키는 파일이 없음). 명시 omit으로 "v1.10이 만드는 것 / v1.11+가 만드는 것 / 사용자가 만드는 것" 책임 분리.

6. **검증 포인트 ≠ stage 카운트** — smoke 7 stage 중 setup(1-3)은 검증이 아니라 준비. 실 검증은 4-7 = 4 포인트. PLAN W15 정정으로 분리 표기. 향후 smoke 작성 시 동일 표기 권장.

7. **Q11/Q12 자유 응답 — manifest 외 정보 흡수 채널** — upbit INTERVIEW.md의 12 질문이 manifest로는 표현 불가한 도메인 컨텍스트(관측 / CI) 보유. 본 v1.10이 이를 자유 응답으로 흡수 → STACK.md / ARCHITECTURE.md placeholder + INTERVIEW.md 영구 기록. **manifest는 운영 메타, INTERVIEW는 의사결정 audit**.

## 후속 세션 연결

### 직접 연계 (본 흐름 적용·확장)

- **v1.10b-bootstrap-agents-md** (S2) — Bootstrap에 AGENTS.md baseline 자동 생성 추가. v1.5 §10 마이그레이션 가이드 적용. Stage S5와 S6 사이 S5.5로 삽입
- **v1.11~v1.13 bootstrap-templates** (S2) — 언어별 overlay (`bootstrap/templates/<language>/`). 본 세션 omit 7 필드 중 5종(executor / statusline_cmd / statusline_timeout_ms / state_file / harness_test_cmd) overlay에서 공급
- **v1.22-bootstrap-noninteractive** (S2) — JSON config 입력 비대화형 mode (CI/CD)
- **v1.23-monorepo-polyglot** (S2) — 다중 언어 monorepo Bootstrap

### 적용 사례

- 새 프로젝트 추가 시점에 본 인터뷰 호출 → `sessions/<new-name>/v0.1-bootstrap/`
- upbit는 이미 부트스트랩 완료 — 재적용 안 함

### 다음 후보 (보류)

- README.md "17 파일" stale 정정 (실제 14 파일, v1.8b 이후) — 본 세션 범위 외, 별도 chore 세션
- `.gitattributes`에 `*.sh text eol=lf` 명시 검증 — CRLF 회귀 방지 (별도 세션)
- AGENTS.md baseline 자동 생성 (v1.10b)

## 커밋 계획

```
feat(meta): sessions/meta/v1.10-bootstrap-interview — Bootstrap 인터뷰 10-stage 흐름

- add: bootstrap/interview.md (Claude 인터뷰 — 코어 7 + 옵션 manifest 3 + 자유 2 + 자동 4)
- add: bootstrap/docs/INTERVIEW_FLOW.md (10-stage + abort + idempotency + OS 분기)
- add: bootstrap/render-manifest.sh (~85 LOC, bash 4+ gate, escaping 5종, exit 0/1/2/3)
- add: bootstrap/skeletons/projects/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md
- add: bootstrap/skeletons/sessions/v0.1-bootstrap/{PLAN,REPORT}.md
- add: bootstrap/skeletons/CLAUDE.md.tmpl (프로젝트 루트 baseline + ARCHITECTURE import)
- add: bootstrap/skeletons/GUARDRAILS.md.tmpl (5120 byte 안내 + 빈 § 4개)
- add: tests/smoke-bootstrap-render.sh (기존 fixture 재사용, 7-stage / 4 검증 포인트)
- update: claude/commands/harness-meta.md (10-stage 갱신 + interview.md 링크 + 8종 Bash 권한)
- update: bootstrap/manifest-schema.md (§12.3 Bootstrap 신규 작성 경로 cross-link)
- update: CLAUDE.md / README.md (INTERVIEW_FLOW 링크 + 최신 meta 세션 v1.10)
- add: sessions/meta/v1.10-bootstrap-interview/{PLAN,REPORT,evidence/smoke-bootstrap-render.txt}

v1.9 detect-project.sh의 자연 후속. /harness-meta <new-name> Bootstrap 모드를
재현 가능 흐름으로 고정. 실 신규 프로젝트 적용은 별도 sessions/<name>/v0.1-bootstrap/.

Smoke 7/7 PASS — Python/uv fixture detect→render→round-trip(3필드)→`"`/`'` rejection.
Grey Area 24건 결정 (G17~G20: R 반영, G21~G24: M1/W2/W4/W8/W12 반영).
PLAN 4-라운드 검토 (R/M/W/S) 자체 일관성 회복.
```
