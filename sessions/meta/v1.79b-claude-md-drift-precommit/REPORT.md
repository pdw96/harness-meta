# REPORT — v1.79b claude-md-drift pre-commit hook

## 최종 결과

- **변경 파일**: 2개 (`.pre-commit-config.yaml` + `tests/CLAUDE.md`)
- **세션 문서**: 2개 (`PLAN.md` + `REPORT.md`)
- **hook 신규 등록**: 1건 (`smoke-claude-md-drift`)
- **회귀**: 0

## 구현 요약

### H1 — `.pre-commit-config.yaml` smoke-claude-md-drift hook entry 추가

`.pre-commit-config.yaml` `repos.local.hooks` 배열 말미에 hook entry 6 field 추가:

```yaml
- id: smoke-claude-md-drift
  name: Smoke — root ↔ 모듈 CLAUDE.md drift 검사
  language: system
  entry: bash tests/smoke-claude-md-drift.sh
  pass_filenames: false
  always_run: true
```

기존 3 hook (smoke-spec-verification / smoke-scope-contract / smoke-cross-ref) 동일 6 field 패턴 1:1 답습.

**주의**: `smoke-claude-md-drift.sh`는 `--fix` mode 미지원 (content drift는 사람 판단 필요 — v1.79 Out of scope 유지). 따라서 `precommit-autofix-or-fail.sh` wrapper 경유 없이 직접 호출.

### H2/H4 — 검증 결과

```
pre-commit run smoke-claude-md-drift --all-files → Passed
  (직접 실행: 16/16 PASS — S1×5/S2×5/S3×5/S4×1)
pre-commit run smoke-spec-verification --all-files → Passed
pre-commit run smoke-scope-contract --all-files    → Passed (182/182)
pre-commit run smoke-cross-ref --all-files         → Passed
```

### H3 — `tests/CLAUDE.md` §"Pre-commit 통합" 1 line 추가

```bash
pre-commit run smoke-claude-md-drift           # v1.79b — root ↔ 모듈 CLAUDE.md drift 자동 차단
```

## 판정

| 목표 | 결과 |
|------|------|
| H1 — `.pre-commit-config.yaml` hook entry 추가 | ✅ |
| H2 — `pre-commit run smoke-claude-md-drift --all-files` PASS | ✅ 16/16 |
| H3 — `tests/CLAUDE.md` §"Pre-commit 통합" 1 line 추가 | ✅ |
| H4 — 기존 smoke 회귀 0 | ✅ 4 hook 모두 PASS |

**PLAN 체크박스 4/4 완수.**

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/pre-commit/pre-commit.com` |
| **topic** | local hook 6 field spec 정합 (PLAN과 동일) |
| **findings** | 기존 3 hook 패턴 1:1 답습 — drift 발생 여지 없음. `--fix` wrapper 미경유는 `smoke-claude-md-drift.sh`가 `--fix` 미지원 설계(v1.79 결정)에 의한 의도적 차이 |
| **drift** | no — v1.78b 동일 spec, 기존 hook 답습 |
| **re-verify** | 2026-11 |

**Citations**:

- `/pre-commit/pre-commit.com` — `language: system` + `pass_filenames`/`always_run` optional field spec

## Lessons Learned

- **L1 — wrapper vs 직접 호출 분기**: `smoke-claude-md-drift.sh`는 `--fix` 미지원이므로 `precommit-autofix-or-fail.sh` wrapper 경유 불필요. `entry: bash tests/smoke-claude-md-drift.sh` 직접 호출 채택. `--fix` 지원 smoke에만 wrapper 경유 원칙 명확화.
- **L2 — trivial scope 기준**: v1.78b/v1.79b 연속으로 "1 hook entry + 1 doc line" 패턴이 trivial scope 기준 확립. 5 관점 검토 skip + Plan-verify inline 완료로 세션 처리 속도 최적화.

## 다음 후보 (보류)

- `v1.79b-smoke-hook-pattern-doc`: wrapper vs 직접 호출 기준을 `tests/CLAUDE.md` §"Pre-commit 통합"에 명문화 — evidence 누적(hook 추가 빈도 3+ 시) 검토
- 기타 도메인 smoke pre-commit 등록: 자주 실패 evidence 누적 시 §3-B trigger

## 선행 세션

- [`v1.79-claude-md-drift-smoke/`](../v1.79-claude-md-drift-smoke/) — smoke-claude-md-drift.sh 신설
