# meta v1.10h3-stale-smoke-fix — REPORT

세션 종료: 2026-04-28
선행 세션:

- [`sessions/meta/v1.10h2-l5-readme-link-cleanup/`](../v1.10h2-l5-readme-link-cleanup/REPORT.md) — Out of scope 표에서 본 v1.10h3 분리 명시

## 1. 최종 결과

| 지표 | 수치 |
|------|:---:|
| 변경 파일 | **1** (`tests/smoke-bootstrap-agents-md.sh`) |
| 신규 파일 (PLAN/REPORT) | **2** |
| smoke 6/6 | **PASS** |
| FAIL 포인트 해소 (F1~F5) | **5 / 5** |
| 회귀 smoke (v1.10h 11/11 + v1.10d 6/6 + v1.10f 6/6 + v1.10g 5/5 + v1.10h2 2/2) | **PASS** |

## 2. 구현 요약

### Root cause

`smoke-bootstrap-agents-md.sh`는 `v1.10c` 기준 작성. v1.10e에서 AGENTS.md.tmpl L5가
`License: see LICENSE` → `License: {{license}}` 로 변수화됐으나 smoke가 4 세션(v1.10e/e2/e3/g)
동안 회귀 검증 목록에서 누락 → stale 지속.

### 수정 내용 (5 FAIL 포인트)

| # | 위치 | 변경 |
|---|------|------|
| F1 | Stage 2 for loop | `{{license}}` 추가 (14 → 15 vars) |
| F2 | Stage 2 line 39 | `'License: see LICENSE'` → `'License: {{license}}'` |
| F3 | Stage 4 sed | `{{license}}` 치환 라인 추가 (mock: `MIT (see [LICENSE](LICENSE))`) |
| F4 | Stage 4 line 78 | `'License: see LICENSE'` → `'License: MIT (see \[LICENSE\](LICENSE))'` |
| F5 | Stage 4 line 82 | F3 해결로 `{{license}}` 미치환 잔존 → 자동 해소 |

### 코멘트/echo 갱신 (7곳)

헤더 버전 `v1.10c` → `v1.10h3`, sed 변수 수 `14` → `15`, `license placeholder` 관련 표현 전량 갱신, 최종 echo 버전 갱신.

## 3. Smoke 결과

### v1.10h3 — `tests/smoke-bootstrap-agents-md.sh` 6/6 PASS

```
[Stage 1] AGENTS.md.tmpl 8 sections PASS
[Stage 2] AGENTS.md.tmpl 15 sed vars + description + license var ({{license}}) + README relation + footer link PASS
[Stage 3] CLAUDE.md.tmpl 3 imports PASS
[Stage 4] sed 15-var + bootstrap_version stamp v1.10c + install_cmd=uv sync + license var 치환 PASS — {{ 잔존 0
[Stage 5] absolute path 0 + Do/Don't 5 + Boundaries 3 backups PASS
[Stage 6] CLAUDE.override.md.tmpl marker + header + Q13 § PASS

PASS — bootstrap agents-md smoke (6 stages, v1.10h3 — {{license}} var 갱신)
```

### 회귀

| Smoke | 결과 |
|------|:---:|
| `tests/smoke-license-line-policy.sh` (v1.10h) | 11/11 ✓ |
| `tests/smoke-bash-permission-pattern.sh` (v1.10d) | 6/6 ✓ |
| `tests/smoke-broad-bash-fine-grain.sh` (v1.10f) | 6/6 ✓ |
| `tests/smoke-thinking-effort.sh` (v1.10g) | 5/5 ✓ |
| `tests/smoke-l5-readme-link-cleanup.sh` (v1.10h2) | 2/2 ✓ |

## 4. 판정

| PLAN 체크박스 | 상태 |
|------|:---:|
| 세션 디렉토리 생성 | ✓ |
| PLAN.md 작성 | ✓ |
| Stage A — smoke-bootstrap-agents-md.sh R1 | ✓ |
| Stage B — smoke 6/6 PASS | ✓ |
| Stage C — REPORT.md | ✓ (본 파일) |
| 사용자 확인 후 커밋 | (대기) |

→ **모든 PLAN 목표 달성**.

## 5. Lessons Learned

### L1 — 회귀 목록 누락이 stale 장기화의 주범

v1.10e에서 template 변수 도입 시 smoke도 동시 갱신하거나, 해당 smoke를 회귀 목록에 포함시켰어야
했다. 4 세션 동안 누락된 근본 원인은 "변경 시 연동 smoke 식별 절차 부재".

v1.10h2 L2에서 이미 지적한 것과 동일 패턴 — meta-smoke 또는 `verify.ps1` 통합이 구조적 해결책.
이는 v1.10j에서 다룬다.

### L2 — 사전 분석이 구현 품질을 높임

PLAN 단계에서 F1~F5 포인트를 모두 식별하고 진입 → 구현 중 추가 발견 없이 단번에 PASS.
"디테일하게 분석해서 놓치는 부분 없게 해" 요청이 직접적으로 효과를 발휘한 케이스.

## 6. 후속 세션

| 세션 | scope | 상태 |
|------|------|:---:|
| `v1.10j-scope-contract-discipline` | S2 | placeholder PLAN ✓ — 진입 대기 |
| `v1.10i` (가설) | S2 | 미작성 — Case 3 / Issue B / 정규화 map |

## 7. 관련 문서

- PLAN: [`PLAN.md`](PLAN.md)
- 선행 세션 v1.10h2: [`../v1.10h2-l5-readme-link-cleanup/`](../v1.10h2-l5-readme-link-cleanup/)
- 후속 placeholder v1.10j: [`../v1.10j-scope-contract-discipline/PLAN.md`](../v1.10j-scope-contract-discipline/PLAN.md)
