# meta v1.39-precommit-hook — PLAN

세션 시작: 2026-04-30
직접 선행 세션: `sessions/meta/v1.38-verify-posttooluse-stage-j/`

목적: `.pre-commit-config.yaml`에 `repo: local` 섹션을 추가하여 **smoke-spec-verification + smoke-scope-contract를 커밋 전 자동 검증**. 기존 shellcheck/markdownlint framework 그대로 유지.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S3(3) `.pre-commit-config.yaml, README.md, CLAUDE.md` = **3/3 meta**
- **T1 경로 다수결** — S3(Repo 정책·설치) 전체 meta scope

## Scope inheritance (verbatim from 선행 세션)

**Source — `bootstrap/docs/SPEC_VERIFICATION.md` §10-2 후속 분기 표 (verbatim)**:

> | `v1.30-precommit-hook` | pre-commit hook으로 smoke-spec-verification + `--fix` 강제 |

**Parsed sub-items (1)**:

1. **pre-commit hook** — `smoke-spec-verification.sh` + `smoke-scope-contract.sh` 커밋 전 자동 실행. 실패 시 `--fix` 안내 메시지 포함.

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 다른 smoke (smoke-bash-permission-pattern 등) hook 포함 | 후속 evidence-driven (실패 빈도 누적 후) |
| `bootstrap/hooks/` + `core.hooksPath` 방식 | 사용자 결정 — 기존 `.pre-commit-config.yaml` framework 충돌로 채택 안 함 |
| `--fix` 자동 스테이징 (hook이 `git add -u` 직접 실행) | 후속 (사용자 동의 없는 스테이징 위험 회피) |
| macOS/Linux 전용 설치 래퍼 스크립트 | 후속 evidence-driven |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (pre-commit framework 표준 사용법, 외부 docs 검증 불필요) |
| **re-verify** | N/A |

## 1. 배경

`SPEC_VERIFICATION.md §10-2`가 `v1.30-precommit-hook`을 후속 분기로 명시했으나 v1.31~v1.38을 거쳐 미이행. 현재 두 smoke(scope-contract / spec-verification)는 개발자가 수동으로 실행해야 하며, 커밋 시 검증 누락이 반복됨.

`.pre-commit-config.yaml`이 이미 존재 (shellcheck + markdownlint + yaml-check). `repo: local` 섹션으로 smoke를 추가하면 기존 framework를 그대로 유지하면서 자동화 가능.

## 2. 결정

### R1 — `.pre-commit-config.yaml`에 `repo: local` 추가

```yaml
  - repo: local
    hooks:
      - id: smoke-spec-verification
        name: Smoke — Spec verification § 검사
        language: system
        entry: bash tests/smoke-spec-verification.sh
        pass_filenames: false
        always_run: true
      - id: smoke-scope-contract
        name: Smoke — Scope contract § 검사
        language: system
        entry: bash tests/smoke-scope-contract.sh
        pass_filenames: false
        always_run: true
```

**설계 결정**:

- `language: system` — PATH에서 `bash`를 찾아 실행. Windows Git Bash 환경에서 `bash`가 PATH에 있으면 동작
- `pass_filenames: false` — 파일 경로 전달 없음 (smoke가 자체 enumerate)
- `always_run: true` — 변경 파일 없어도 항상 실행 (sessions/** 변경 시만 아닌 커밋 전 항상)
- 실패 시 `--fix` 안내는 smoke 자체 출력 메시지로 처리 (hook 코드 별도 불필요)

### R2 — 기존 hook 설치 확인

현재 `.pre-commit-config.yaml` 존재하지만 `pre-commit install` 실행 여부 미확인. README/CLAUDE.md에 설치 명령어 명시.

### R3 — 문서 갱신 (2 파일)

**`README.md`**: 기존 pre-commit 설치 섹션이 있으면 smoke hook 추가 사실 1줄 갱신. 없으면 "### 개발 pre-commit hook" 섹션 신설.

**`CLAUDE.md`**: `## 명령어` 섹션에 `pre-commit install` 명령어 1줄 추가.

## 3. 변경 대상

| 경로 | 신규/수정 | 내용 |
|------|----------|------|
| `.pre-commit-config.yaml` | 수정 | R1 — `repo: local` 섹션 (2 hook) 추가 |
| `README.md` | 수정 | R3 — pre-commit 설치 안내 갱신 |
| `CLAUDE.md` | 수정 | R3 — 명령어 섹션 `pre-commit install` 1줄 |

## 4. 목표

- [x] 세션 디렉토리 생성 + PLAN.md 작성
- [x] 3 관점 병렬 검토 완료 (architecture/scope-contract/회귀)
- [x] PLAN 접근 방식 수정 (bootstrap/hooks → .pre-commit-config.yaml)
- [ ] **사용자 PLAN 확정 승인**
- [ ] Stage A — `.pre-commit-config.yaml` 갱신 (R1)
- [ ] Stage B — `README.md` 갱신 (R3)
- [ ] Stage C — `CLAUDE.md` 갱신 (R3)
- [ ] Stage D — 검증 (`pre-commit run smoke-spec-verification smoke-scope-contract` 동작 확인)
- [ ] Stage E — REPORT.md + ROADMAP 갱신
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `.pre-commit-config.yaml`에 `repo: local` 섹션 + 2 hook 추가
- [ ] `pre-commit run smoke-spec-verification` → PASS
- [ ] `pre-commit run smoke-scope-contract` → PASS
- [ ] `pre-commit run --all-files` 기존 hook (shellcheck/markdownlint/yaml-check) 회귀 0
- [ ] README.md + CLAUDE.md 설치 안내 존재

## 6. 커밋 전략

```
feat(meta): v1.39-precommit-hook — .pre-commit-config.yaml repo:local smoke hook 추가

- update: .pre-commit-config.yaml (smoke-spec-verification + smoke-scope-contract local hook)
- update: README.md (pre-commit 설치 안내 갱신)
- update: CLAUDE.md (명령어 섹션 pre-commit install 1줄)
- add: sessions/meta/v1.39-precommit-hook/{PLAN,REPORT}.md

기존 shellcheck/markdownlint/yaml-check hook 무영향.
`pre-commit install` 1회 실행으로 smoke 자동 검증 활성화.
```

## 7. 후속 분기

| 후속 세션 | 조건 |
|---------|------|
| `v1.39b-hooks-expand` | 다른 smoke hook 포함 (실패 빈도 evidence 누적 후) |
| `v1.39c-fix-autofix` | smoke 실패 시 `pre-commit` hook 내 `--fix` 자동 실행 (사용자 수요 evidence 후) |
