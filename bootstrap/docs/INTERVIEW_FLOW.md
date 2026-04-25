# Bootstrap Interview Flow — `/harness-meta <new-name>` 10-stage 책임 분리

`/harness-meta <new-name>` Bootstrap 모드의 **end-to-end 흐름**을 단일 소스로 정의. v1.10에서 확정 (`sessions/meta/v1.10-bootstrap-interview/`).

각 stage는 단일 책임. 실패 단위 격리 + 재실행 단위 명확.

## 1. Bootstrap 모드 진입 조건

다음 두 조건 동시 충족:

- 대상 프로젝트 루트에 `.harness.toml` 부재
- `~/harness-meta/projects/<name>/` 부재

하나라도 위배 시 Bootstrap 진입 거부 (Idempotency §5 참조).

## 2. 10-stage 표

| Stage | 주체 | 산출 |
|------|------|------|
| **S0 모드 진입** | 슬래시 명령 (`harness-meta.md`) | Bootstrap 의사 확인 |
| **S1 감지** | `detect-project.sh` (v1.9) | TOML snippet (lang/pm/test_cmd) |
| **S2 인터뷰** | `interview.md` | 사용자 답변 (key=value 매핑 후 HM_* env export) |
| **S3 렌더링** | `render-manifest.sh` | `.harness.toml` 텍스트 미리보기 |
| **S4 매니페스트 작성+검증** | Claude (Write + Bash grep) | `<proj>/.harness.toml` + round-trip 통과 (3 필드: name/code_dir/phases_dir) |
| **S5 프로젝트 부수 자산** | Claude (skeletons/ 기반 Write) | `<proj>/CLAUDE.md` baseline + `<proj>/{HM_GUARDRAILS}` placeholder + `<proj>/{HM_PHASES_DIR}/.gitkeep` |
| **S6 .claude/ 배포** | Claude (uname OS 분기 → install-project-claude.{ps1,sh}) | `<proj>/.claude/` 14 파일 |
| **S7 아키텍처 기록** | Claude (skeletons/projects/ 기반 Write) | `~/harness-meta/projects/<name>/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md` |
| **S8 세션 기록** | Claude (skeletons/sessions/v0.1-bootstrap/ 기반 Write) | `~/harness-meta/sessions/<name>/v0.1-bootstrap/{PLAN,REPORT}.md` |
| **S9 README 등록** | Claude (Edit) | `~/harness-meta/README.md` 프로젝트 섹션 |
| **S10 후속 안내** | Claude (텍스트 출력) | 사용자 행동 항목 (output style / GUARDRAILS 작성 / code_dir 골격) |

## 3. 데이터 전달 명세

### 3.1. detect output 파싱 절차 (S1 → S2)

```bash
# (a) Claude는 Bash tool로 detect-project.sh 실행, stdout 캡처:
DETECT_OUT=$(bash $HARNESS_META_ROOT/bootstrap/detect-project.sh "$PROJECT_ROOT")

# (b) Claude는 출력에서 line별 grep으로 default 추출:
detected_lang=$(echo "$DETECT_OUT" | grep -E '^language = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_pm=$(echo   "$DETECT_OUT" | grep -E '^package_manager = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_test_cmd=$(echo "$DETECT_OUT" | grep -E '^test_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_lint_cmd=$(echo "$DETECT_OUT" | grep -E '^lint_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')
detected_format_cmd=$(echo "$DETECT_OUT" | grep -E '^format_cmd = "' | sed -E 's/.*"([^"]+)".*/\1/')

# (c) 각 default를 Q2/Q3/Q10에 표시 → 사용자 확정 → HM_* env export
# (d) Q11/Q12 자유 응답은 env 미매핑 — Claude 메모리에만 보유 후 INTERVIEW.md/STACK.md/ARCHITECTURE.md 기록
```

### 3.2. interview → render env 매핑 (S2 → S3)

| Q | env (HM_*) | render-manifest.sh 처리 |
|---|---|---|
| Q1 name | `HM_NAME` | required |
| Q2 language | `HM_LANGUAGE` | required |
| Q3 package_manager | `HM_PACKAGE_MANAGER` | required |
| Q4 runtime_version | `HM_RUNTIME_VERSION` | required |
| Q5 code_dir | `HM_CODE_DIR` | required |
| Q6 phases_dir | `HM_PHASES_DIR` | required |
| Q7 meta_ref | `HM_META_REF` | required |
| Q8 guardrails | `HM_GUARDRAILS` | optional |
| Q9 locale | `HM_LOCALE` | optional, default "en" |
| Q10 test/lint/format/type_check | `HM_TEST_CMD`/`HM_LINT_CMD`/`HM_FORMAT_CMD`/`HM_TYPE_CHECK_CMD` | optional |
| (자동) build (컴파일 언어) | `HM_BUILD_TOOL`/`HM_BUILD_CMD`/`HM_ARTIFACT_DIR` | optional |
| Q11/Q12 자유 응답 | (env 미매핑) | render 무관 — INTERVIEW.md/STACK.md/ARCHITECTURE.md placeholder 채움 |

### 3.3. tmpl 변수 매핑 (S5/S7/S8)

`skeletons/CLAUDE.md.tmpl` / `skeletons/GUARDRAILS.md.tmpl` / `skeletons/projects/*.md` / `skeletons/sessions/v0.1-bootstrap/*.md`의 `{{var}}` 마커 → Claude가 답변(env)에서 치환:

| Tmpl marker | env source | Fallback |
|---|---|---|
| `{{name}}` | `HM_NAME` | (코어, 필수) |
| `{{language}}` | `HM_LANGUAGE` | (코어, 필수) |
| `{{runtime_version}}` | `HM_RUNTIME_VERSION` | (코어, 필수) |
| `{{package_manager}}` | `HM_PACKAGE_MANAGER` | (코어, 필수) |
| `{{code_dir}}` | `HM_CODE_DIR` | `scripts/harness` |
| `{{phases_dir}}` | `HM_PHASES_DIR` | `phases` |
| `{{meta_ref}}` | `HM_META_REF` | `projects/{{name}}/ARCHITECTURE.md` |
| `{{guardrails_path}}` | `HM_GUARDRAILS` | `docs/GUARDRAILS.md` |
| `{{locale}}` | `HM_LOCALE` | `en` |
| `{{test_cmd}}` | `HM_TEST_CMD` | `(미설정)` |
| `{{lint_cmd}}` | `HM_LINT_CMD` | `(미설정)` |
| `{{format_cmd}}` | `HM_FORMAT_CMD` | `(미설정)` |
| `{{type_check_cmd}}` | `HM_TYPE_CHECK_CMD` | `(미설정)` |
| `{{q11_observability}}` | (Q11 자유 응답) | `(미설정)` |
| `{{q12_ci}}` | (Q12 자유 응답) | `(미설정)` |
| `{{date}}` | `$(date +%Y-%m-%d)` | (자동) |

**치환 방식**: Claude가 Read tmpl → 답변 기반 텍스트 치환 → Write 결과 파일. bash sed helper 별도 작성 안 함.

## 4. Stage 실패/abort 정책

| Stage | 실패 사례 | 정책 |
|------|-----------|------|
| S0 | 진입 조건 위배 (manifest 또는 projects/<name>/ 존재) | abort + Idempotency §5 분기로 |
| S1 | detect unknown 출력 | unknown으로 진행, Q2/Q3 사용자 manual 입력 강제 |
| S2 | 사용자 abort (코어 빈/skip 3회) | 0 영향 (아직 파일 미작성). manifest 미작성 |
| S3 | render 실패 (escaping 위반 exit 2 / bash 3 exit 3 / required missing exit 1) | 사용자 재입력 요구. 3회 시도 후 abort |
| S4 | round-trip 실패 (grep+sed가 name/code_dir/phases_dir 추출 못함) | 작성된 manifest를 backup (`.harness/backups/manifest.<ts>.toml`) 후 재시도 안내 |
| S5 | 부수 자산 작성 실패 (CLAUDE.md/GUARDRAILS/.gitkeep) | manifest 보존, 사용자 수동 작성 안내 |
| S6 | install-project-claude 실패 (충돌 backup, 권한 오류 등) | manifest+부수 자산 그대로, 사용자에게 `-Force` 또는 conflicts 수동 해결 후 재실행 안내 |
| S7~S9 | 작성 실패 | 사용자 수동 작성 안내 (manifest+`.claude/`는 보존, 프로젝트는 작동 가능 상태) |
| S10 | (사용자 행동 항목 출력만) | 실패 분기 없음 |

## 5. Idempotency

재실행 시 `.harness.toml` 존재하면 **abort + Claude가 사용자에게 명시 확인**:

```
"기존 .harness.toml 발견. backup 후 재진행할까요? (yes/no)"
```

- **yes**: `<proj>/.harness.toml` → `<proj>/.harness/backups/manifest.<YYYYMMDD-HHMMSS>.toml` 이동
  - `<proj>/.harness/backups/` 디렉토리 자동 생성 (`mkdir -p`)
  - `<proj>/.gitignore`에 `.harness/backups/` 자동 append (없으면 .gitignore 신규 작성). git 추적 오염 방지
  - 같은 Claude 대화 내 인터뷰 재진입 (S2부터). **슬래시 명령 재호출 아님**
- **no**: abort. 0 영향

`<proj>/projects/<name>/` 존재 (harness-meta repo 측)에 대해서는 별도 분기 — 사용자에게 "이미 부트스트랩됨. 재부트스트랩하려면 `v0.2-rebootstrap` 별도 세션" 안내.

`--force` 같은 flag는 없음 — 모두 대화 분기로 처리.

## 6. Cross-platform OS 분기 (S6 install-project-claude 호출)

```bash
case "$(uname -s 2>/dev/null || echo Windows)" in
    MINGW*|MSYS*|CYGWIN*|Windows)
        pwsh "$HARNESS_META_ROOT/bootstrap/install-project-claude.ps1" -ProjectRoot "$PWD"
        ;;
    Darwin|Linux|*)
        bash "$HARNESS_META_ROOT/bootstrap/install-project-claude.sh" "$PWD"
        ;;
esac
```

Claude는 Bash tool로 `uname -s` 실행 후 분기 명령 호출. Git Bash on Windows의 `uname -s`는 `MINGW*` 출력 → 첫 분기 매치.

`pwsh` 부재 시(Windows에 PowerShell 7 미설치) — 사용자에게 `pwsh` 설치 안내 또는 `powershell.exe` fallback 검토.

## 7. 로깅

- 인터뷰 진행 중 답변 (Q1~Q12 + 자유 응답) → Claude 메모리 (대화 컨텍스트)
- manifest 작성 후 → `~/harness-meta/projects/<name>/INTERVIEW.md`에 영구 기록 (12 Q + 자유 응답 그대로)
- 세션 진행 → `~/harness-meta/sessions/<name>/v0.1-bootstrap/{PLAN,REPORT}.md`

INTERVIEW.md는 audit trail. 향후 ARCHITECTURE/STACK 업데이트 시 근거 자료.

## 8. CRLF / 라인 종결 주의

`render-manifest.sh` / `tests/smoke-bootstrap-render.sh` / 추후 추가되는 모든 .sh는 **LF 라인 종결 필수**. CRLF로 commit되면 Git Bash / Linux / macOS에서 `$'\r': command not found` 오류.

`.gitattributes`에 `*.sh text eol=lf` 명시 (이미 있으면 확인). 신규 .sh 파일 작성 시 LF 저장 검증.

## 9. 관련 문서

- 인터뷰 질문지: [`../interview.md`](../interview.md)
- 매니페스트 스펙: [`../manifest-schema.md`](../manifest-schema.md)
- 감지 규칙: [`DETECTION.md`](DETECTION.md)
- 세션 소속: [`OWNERSHIP.md`](OWNERSHIP.md)
- AGENTS.md 표준: [`AGENTS_MD_STRATEGY.md`](AGENTS_MD_STRATEGY.md)
- 본 흐름 확정 세션: [`../../sessions/meta/v1.10-bootstrap-interview/`](../../sessions/meta/v1.10-bootstrap-interview/)
