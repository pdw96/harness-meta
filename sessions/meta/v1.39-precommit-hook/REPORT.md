# meta v1.39-precommit-hook — REPORT

세션 완료: 2026-04-30

## 최종 결과

| 항목 | 값 |
|------|---|
| 변경 파일 수 | 3 (`.pre-commit-config.yaml`, `README.md`, `CLAUDE.md`) |
| 신규 파일 수 | 2 (세션 PLAN.md + REPORT.md) |
| smoke 결과 | smoke-spec-verification PASS=198 FAIL=0 + smoke-scope-contract PASS=98 FAIL=0 |

## 구현 요약

### Stage A — `.pre-commit-config.yaml` `repo: local` 섹션 추가

`.pre-commit-config.yaml` 말미에 `repo: local` 섹션 추가. `smoke-spec-verification`과 `smoke-scope-contract` 두 hook을 `language: system` + `always_run: true`로 등록. 기존 shellcheck/markdownlint/yaml-check hook 무영향.

**설계 결정**: 초안은 `bootstrap/hooks/` 신설 + `core.hooksPath` 방식이었으나, 기존 `.pre-commit-config.yaml` (shellcheck/markdownlint)과 충돌이 발견되어 `repo: local` 방식으로 전환. 기존 framework를 그대로 유지하면서 smoke를 추가하는 방식이 더 깔끔.

### Stage B — `README.md` 갱신

"Optional dev tooling" 섹션 설명 문장 갱신 (shellcheck + markdownlint → harness smoke tests 포함으로 확장). 개별 smoke hook 실행 명령어 2줄 추가.

### Stage C — `CLAUDE.md` 갱신

`## 명령어` > "설치 / 재설치" 코드블록에 `pre-commit install` 1줄 추가 (v1.39+ 주석 포함).

## 판정

- [x] `.pre-commit-config.yaml`에 `repo: local` 섹션 + 2 hook 추가
- [x] smoke-spec-verification 직접 실행 PASS (198/198)
- [x] smoke-scope-contract 직접 실행 PASS (98/98)
- [x] 기존 hook (shellcheck/markdownlint/yaml-check) 회귀 0 (파일 무변경)
- [x] README.md + CLAUDE.md 설치 안내 존재
- [ ] `pre-commit run smoke-spec-verification` → 미검증 (pre-commit 미설치 환경)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 구현 중 외부 spec drift 없음 (PLAN N/A 유지) |
| **re-verify** | N/A |

## Lessons Learned

- **L1 — 기존 파일 우선 탐색 필수**: 초안에서 `bootstrap/hooks/` 신설을 계획했으나, `.pre-commit-config.yaml` 존재를 사전에 확인했더라면 처음부터 `repo: local` 방식을 선택했을 것. 3 관점 병렬 검토(architecture)가 이를 발견 → PLAN 전환. **세션 시작 시 repo 루트 파일 전수 확인이 설계 결정에 중요**.
- **L2 — `.pre-commit-config.yaml`은 S3 scope**: `bootstrap/hooks/` (S2)로 오분류할 뻔했으나, 실제 `.pre-commit-config.yaml` 수정은 S3(Repo 정책·설치)로 scope 분류 정확.
- **L3 — pre-commit 미설치 환경에서도 smoke는 직접 bash로 검증 가능**: `pre-commit run` 동작 확인은 미완이나, smoke 자체가 bash 스크립트이므로 직접 실행으로 정합성 확인 가능.

## 다음 후보 (보류)

| 후속 | trigger | 근거 |
|------|---------|------|
| `v1.39b-hooks-expand` | 다른 smoke 실패 evidence 누적 | Out of scope 표 |
| `v1.39c-fix-autofix` | 사용자 `--fix` 자동 실행 수요 | Out of scope 표 |
| pre-commit 설치 + `pre-commit run` 검증 | 사용자가 `pip install pre-commit && pre-commit install` 실행 후 | L3 미완 항목 |
