# meta v1.10h3-stale-smoke-fix — PLAN

세션 시작: 2026-04-28
직접 선행 세션:
- [`sessions/meta/v1.10h2-l5-readme-link-cleanup/`](../v1.10h2-l5-readme-link-cleanup/REPORT.md) — 사전 존재 실패 발견 + Out of scope 표에 `v1.10h3-stale-smoke-fix` 명시

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S2(1) `tests/smoke-bootstrap-agents-md.sh` = **1/1 meta**
- **T1 경로 다수결** — meta scope 1/1

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.10h2-l5-readme-link-cleanup/REPORT.md` §3 Out of scope 표** (verbatim):

> | `tests/smoke-bootstrap-agents-md.sh` Stage 2 + Stage 4 `License: see LICENSE` assertion 갱신 | 별도 후속 (예: **`v1.10h3-stale-smoke-fix`**) | 미작성 |

**Parsed sub-items (1)**:
1. `smoke-bootstrap-agents-md.sh` Stage 2 + Stage 4의 `License: see LICENSE` assertion → `{{license}}` 변수 기준으로 갱신

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| AGENTS.md.tmpl 자체 변경 | 별도 세션 |
| 다른 smoke 파일 수정 | 별도 세션 |
| Stage 2/4 외 다른 stage assertion 변경 | 추가 evidence 필요 시 별도 |
| bootstrap_version stamp `1.10c` → 최신값 갱신 (Stage 4 sed) | 별도 — Stage 4는 치환 mechanism 검증용, 값 자체 의미 없음 |

## 1. 문제 분석

### Root cause

`smoke-bootstrap-agents-md.sh`는 `v1.10c` 기준 작성. 당시 AGENTS.md.tmpl L5:

```
License: see LICENSE
```

`v1.10e`에서 AGENTS.md.tmpl L5 변경:

```
License: {{license}}
```

smoke 파일은 4 세션 (v1.10e / v1.10e2 / v1.10e3 / v1.10g) 동안 회귀 검증 목록에서 누락 → stale 상태 지속.

### FAIL 포인트 (2)

| Stage | 위치 | 현재 assertion | 실패 이유 |
|------|------|------|------|
| Stage 2 | line 39 | `grep -q 'License: see LICENSE'` | tmpl에 `see LICENSE` 텍스트 없음 — `{{license}}` 변수로 교체됨 |
| Stage 4 | line 68 | sed에 `{{license}}` 치환 없음 | `{{license}}` 미치환 → line 82 `{{ 잔존 0` FAIL |
| Stage 4 | line 78 | `grep -q 'License: see LICENSE'` | 치환 후에도 `see LICENSE` 없음 |

## 2. 결정 (R1)

### R1 — Stage 2 + Stage 4 갱신

**Stage 2 (line 38-39)**:
- 기존: `grep -q 'License: see LICENSE'`
- 변경: `grep -q 'License: {{license}}'`
- echo: "license placeholder" → "license var" 표현 정정

**Stage 4 sed (lines 61-75)**:
- `{{license}}` 치환 라인 추가: `-e 's/{{license}}/MIT (see [LICENSE](LICENSE))/g'`
- (Case 1 형식 — v1.10h 3-way 대표 케이스)

**Stage 4 assertion (line 78)**:
- 기존: `grep -q 'License: see LICENSE'`
- 변경: `grep -q 'License: MIT (see \[LICENSE\](LICENSE))'` (sed 치환 결과 검증)

**Stage 4 echo (line 83)**:
- `license placeholder 잔존` → `license var 치환 PASS` 표현 정정

**헤더 + 최종 echo**:
- 버전 표기 `v1.10c` → `v1.10h3`
- 설명 `install_cmd 변수화` → `{{license}} var 갱신`

## 3. 변경 대상 (2 파일)

### 수정 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `tests/smoke-bootstrap-agents-md.sh` | S2 | R1 — Stage 2/4 assertion 갱신 |

### 신규 (2)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/v1.10h3-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10h3-.../REPORT.md` | meta | Stage 완료 후 작성 |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 확인**
- [ ] Stage A — smoke-bootstrap-agents-md.sh R1
- [ ] Stage B — 수정 후 smoke 실행 PASS 확인
- [ ] Stage C — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `bash tests/smoke-bootstrap-agents-md.sh` 6/6 PASS
- [ ] Stage 2: `{{license}}` 검사 통과
- [ ] Stage 4: sed 치환 후 `{{ 잔존 0` + `License: MIT (see [LICENSE](LICENSE))` 검사 통과
- [ ] 회귀: 기존 smoke (v1.10h 11/11, v1.10d 6/6, v1.10f 6/6, v1.10g 5/5, v1.10h2 2/2) PASS

## 6. 커밋 전략

```
fix(meta): sessions/meta/v1.10h3-stale-smoke-fix — smoke-bootstrap-agents-md.sh {{license}} 갱신

- fix: tests/smoke-bootstrap-agents-md.sh (Stage 2/4 license assertion — v1.10c→h3)
- add: sessions/meta/v1.10h3-.../{PLAN,REPORT}.md

v1.10e {{license}} 변수화 이후 stale된 Stage 2 + Stage 4 assertion 정정.
Stage 4 sed에 {{license}} 치환 추가 + {{ 잔존 0 검사 통과.

Smoke 6/6 PASS.
```
