# meta v1.66-precommit-cleanup — PLAN

세션 시작: 2026-05-04
직접 선행 세션: [`sessions/meta/v1.65-fix-v8-separator/`](../v1.65-fix-v8-separator/REPORT.md) — pre-commit 설치 후 `--all-files` 실행으로 기존 위반 1,500+ 발견

목적: `pre-commit run --all-files` 통과를 위한 **markdownlint auto-fix 일괄 적용** + **shellcheck critical 위반 수동 수정**.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: 다수 — markdownlint auto-fix가 `bootstrap/docs/**`, `bootstrap/manifest-schema.md`, `bootstrap/interview.md`, `sessions/meta/**` (legacy 포함), `README.md`, `CLAUDE.md` 등 전반 적용. shellcheck fix는 `tests/**`, `verify.sh` (S3)
- **T1 경로 다수결** — S2(bootstrap docs) + S3(tests) + S1a(claude/) 전부 meta scope
- **T5 정리/정책** — 전반적 lint 정합화 작업, meta 소유 자연

## Scope inheritance (verbatim from 선행 세션)

**Source — 사용자 발의 (2026-05-04) verbatim**:

> "기존 위반은 별도 정리 세션 (`vX-precommit-cleanup`) trigger 후보입니다." (v1.65 REPORT 후 응답)
> "정리 세션 진행해줘" + AskUserQuestion 답변: "전체 auto-fix + critical shellcheck"

**Parsed sub-items (2)**:

1. **markdownlint 전체 auto-fix** — 1,549건 위반 (MD032 989 + MD031 265 + MD022 106 + 기타) `--fix` 일괄 적용. legacy 세션 포함 (메커니컬 변환 — 빈 줄 추가/code span 정정 — 의미 변동 0)
2. **shellcheck critical fix** — SC1102 ERROR 1건 (smoke-sync-agents.sh:105) 필수 수정 + 완화 가능한 WARNING (SC2010/SC2034/SC2064/SC2088/SC1102) 가능한 한 정정

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 자동 fix 후 잔존 markdownlint 수동 수정 (MD013/MD007/MD026 등 일부) | 별 후속 evidence-driven (auto-fix 후 잔존 카운트 보고) |
| `.markdownlintignore` 확장 (legacy session 추가) | 회피 — 자동 fix가 먼저. 잔존 시 evidence-driven |
| shellcheck WARNING 일부 (소소한 SC2034 등) | 자동 정정 어려운 항목은 보류 |
| 다른 hook 추가 (yamllint 등) | scope 외 |
| pre-commit 설정 변경 (.pre-commit-config.yaml) | 본 세션 무관 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 내부 lint 정합화. 외부 spec 의존 무 |
| **re-verify** | N/A |

## 1. 문제

v1.65에서 `pre-commit install` 후 `--all-files` 실행 결과 누적된 lint 위반 발견:

- **markdownlint**: 1,549건 (MD032 989 / MD031 265 / MD022 106 / MD038 42 / MD056 35 / MD034 27 / MD004 20 등)
- **shellcheck**: 1 ERROR (SC1102) + ~14 WARNING

향후 신규 커밋 시 staged 파일만 lint하므로 즉시 차단은 안 되지만, 정기 `--all-files` 검증 시 noise. 본 세션에서 일괄 정리.

## 2. 결정 (R1 ~ R3)

### R1 — markdownlint --fix 일괄 적용

pre-commit이 설치한 markdownlint v0.42.0 (`~/.cache/pre-commit/repo0iyl5uua/node_env-default/Scripts/markdownlint`) `--fix` 지원 확인.

```bash
# .pre-commit-config.yaml과 동일 config + ignore 적용
MDL=~/.cache/pre-commit/repo0iyl5uua/node_env-default/Scripts/markdownlint
$MDL --config .markdownlint.json --ignore-path .markdownlintignore --fix '**/*.md'
```

**자동 fix 가능 항목** (markdownlint v0.42 기준):

- MD031 (blanks-around-fences) — 빈 줄 자동 삽입
- MD032 (blanks-around-lists) — 빈 줄 자동 삽입
- MD022 (blanks-around-headings) — 빈 줄 자동 삽입
- MD038 (no-space-in-code) — 공백 제거
- MD034 (bare URL) — `<url>` wrap
- MD058 (blanks-around-tables) — 빈 줄 삽입
- MD028 (blank-in-blockquote) — 정정
- MD010 (no-hard-tabs) — 공백 변환
- MD004 (ul-style) — `-` 통일
- MD056 (table-pipe-style) — 정합화

**자동 fix 불가** (보고만):

- MD013 (line-length) — 1건
- MD007 (ul-indent) — 6건 (수동 검토 필요)
- MD026 (heading-trailing-punct) — 1건

### R2 — shellcheck SC1102 ERROR 수정 (필수)

`tests/smoke-sync-agents.sh:105`:

```bash
list_out=$((cd "$TMPDIR_TEST" && bash "$REPO_ROOT/sync-agents.sh" --list-targets) 2>/dev/null || true)
```

`$((cd ...))` 가 산술식으로 잘못 파싱됨. 정정:

```bash
list_out=$( (cd "$TMPDIR_TEST" && bash "$REPO_ROOT/sync-agents.sh" --list-targets) 2>/dev/null || true )
```

`$(` 다음 공백 추가로 subshell `(` 와 분리.

### R3 — shellcheck WARNING 완화 (가능한 한)

| 위반 | 위치 | 정정 |
|------|------|------|
| SC2010 (ls\|grep) | tests/integration/test-install-guards.sh:75,79 | `find` 또는 glob 사용 |
| SC2064 (trap quotes) | 4 파일 | `trap "..." EXIT` → `trap '...'  EXIT` (single quote) |
| SC2088 (tilde in quotes) | verify.sh:146,148,463 | `"~/.claude/..."` → `"$HOME/.claude/..."` |
| SC2034 (unused vars) | smoke-roadmap-sync.sh, smoke-scope-contract.sh, smoke-verify-sh-parity.sh | 사용 안 하면 `# shellcheck disable=SC2034` 주석 |

## 3. 변경 대상 (다수)

### markdownlint --fix 자동 적용 (예상 ~150 파일)

- `bootstrap/docs/{SPEC_VERIFICATION,SKILLS,OWNERSHIP,...}.md` — S2
- `bootstrap/{manifest-schema,interview}.md` — S2
- `bootstrap/skills/audit/**/*.md` — S1c
- `sessions/meta/**/*.md` — S2 (legacy 포함, 메커니컬 변환)
- `README.md`, `CLAUDE.md`, `AGENTS.md` — S3

### shellcheck 수동 fix

- `tests/smoke-sync-agents.sh` — SC1102 (필수)
- `tests/smoke-roadmap-sync.sh` — SC2034
- `tests/smoke-scope-contract.sh` — SC2034 × 2
- `tests/smoke-verify-sh-parity.sh` — SC2034
- `tests/integration/test-install-guards.sh` — SC2010 × 2
- `tests/integration/test-session-init-branches.sh` — SC2064
- `tests/integration/test-statusline-timeout.sh` — SC2064
- `tests/smoke-language-overlay.sh` — SC2064
- `tests/smoke-legacy-cleanup-overlay.sh` — SC2064
- `tests/smoke-license-line-policy.sh` — SC2064
- `verify.sh` — SC2088 × 3

### 세션 docs

- `sessions/meta/v1.66-precommit-cleanup/{PLAN,REPORT}.md`
- `sessions/meta/ROADMAP.md` 갱신

## 4. 목표

- [x] 세션 디렉토리 + PLAN 작성
- [ ] **사용자 PLAN 확정**
- [ ] Stage A — markdownlint --fix 일괄 실행
- [ ] Stage B — shellcheck SC1102 (smoke-sync-agents.sh) 수정
- [ ] Stage C — shellcheck WARNING 완화 (가능한 항목)
- [ ] Stage D — `pre-commit run --all-files` 재실행 + 잔존 카운트 보고
- [ ] Stage E — REPORT.md + ROADMAP 갱신
- [ ] Stage F — 커밋 (대용량 변경 1건 + shellcheck fix 별도 가능)

## 5. 성공 기준

- [ ] markdownlint --fix 후 위반 90%+ 감소 (1,549 → ≤150 잔존)
- [ ] shellcheck SC1102 0건
- [ ] shellcheck WARNING 50%+ 감소
- [ ] smoke 6/6 PASS 회귀 0 (smoke-bash-permission-pattern + smoke-spec-verification + smoke-scope-contract)
- [ ] 자동 fix 잔존 위반 명시적 보고 (REPORT)

## 6. 커밋 전략

**2개 커밋 분할** — 자동 fix와 수동 fix 분리 (review 가독성):

```
chore(meta): v1.66a — markdownlint --fix 일괄 적용
- update: ~150 .md 파일 (MD031/MD032/MD022/MD038/MD034 등 메커니컬 변환)
- 의미 변동 0 (빈 줄 추가/code span 공백 제거)

chore(meta): v1.66b — shellcheck SC1102 ERROR + WARNING 완화
- fix: tests/smoke-sync-agents.sh SC1102 (subshell 공백 분리)
- fix: 4 파일 SC2064 (trap single quote)
- fix: verify.sh SC2088 ($HOME 치환)
- annotate: SC2034 의도 변수 (# shellcheck disable=SC2034)
- add: sessions/meta/v1.66-precommit-cleanup/{PLAN,REPORT}.md
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|-----------|------|
| `v1.66c-markdownlint-residual` | auto-fix 잔존 MD007/MD013/MD026 수동 정리 evidence (잔존 카운트 + 우선순위) |
| `v1.66d-shellcheck-residual` | shellcheck WARNING 잔존 — SC2010 (ls\|grep) 등 구조 변환 evidence |
| `vX-precommit-config-tighten` | --severity=warning 외 추가 hook (e.g., yamllint) |
