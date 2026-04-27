# A2 — Real-world LICENSE 분포 + SPDX 헤더 보유율

본 audit 시점(2026-04-27) 기준 LICENSE 파일 분포 조사. T1 (SPDX 헤더) 채택의 실용 가치 한계 명시.

조사 명령:
```bash
find ~ -maxdepth 4 -name "LICENSE*" -type f 2>/dev/null
head -3 <each LICENSE>
grep -E "SPDX-License-Identifier" <each LICENSE>
```

## 1. 시스템 sample (10건, 2026-04-27)

| # | 파일 | 첫 라인 | SPDX 헤더? | T1 매칭 |
|---|------|---------|:---------:|:-------:|
| 1 | `~/harness-meta/LICENSE` | `MIT License` | ❌ | ❌ |
| 2 | `~/.cache/pre-commit/.../LICENSE-APACHE` (Astral) | `Apache License Version 2.0` | ❌ | ❌ |
| 3 | `~/.cache/pre-commit/.../LICENSE-MIT` (Astral) | `MIT License` | ❌ | ❌ |
| 4 | `~/.vscode/extensions/databricks.../LICENSE.txt` | `Neon - Serverless Postgres Extension` | ❌ | ❌ |
| 5-7 | `~/.vscode/extensions/github.copilot-chat-*/LICENSE.txt` (3건) | `GITHUB LICENSE TERMS FOR EXTENSIONS` | ❌ | ❌ |
| 8 | `~/.vscode/extensions/github.remotehub.../LICENSE.txt` | `GitHub Repositories Extension – Software License Agreement` | ❌ | ❌ |
| 9 | `~/.vscode/extensions/github.vscode-github-actions.../LICENSE.txt` | `MIT License` | ❌ | ❌ |
| 10 | `~/.vscode/extensions/github.vscode-pull-request.../LICENSE.txt` | `MIT License` | ❌ | ❌ |

**SPDX 헤더 보유율**: **0/10 (0%)**.

## 2. 분류

| 분류 | 비율 | 처리 |
|------|:----:|------|
| OSS — MIT boilerplate | 4/10 (40%) | T1 미식별 → fallback. T2 채택 시 매칭 가능 |
| OSS — Apache-2.0 boilerplate | 1/10 (10%) | T1 미식별 → fallback. T2 채택 시 매칭 가능 |
| Proprietary/EULA (GitHub/Microsoft/Databricks) | 5/10 (50%) | T1 미식별 → fallback (의도된 동작) |

**시사**:
- T1 단독 (Option C v1.10e) 추출률 **0%** in sample → 거의 모든 LICENSE에서 fallback
- T2 boilerplate 추가 (v1.10e2) 시 추출률 **50%** (OSS만) → 실용 가치 ↑
- T3 fallback (proprietary 가정) — 50% 케이스 정확 처리

## 3. 본 repo (harness-meta) 분포

| 프로젝트 | LICENSE 파일 | SPDX 헤더 | 처리 |
|---------|--------------|:---------:|------|
| `~/harness-meta` | MIT (21 라인) | ❌ | bootstrap 대상 아님 (self-detect 의미 없음) |
| `~/upbit` | 부재 | — | proprietary 가정 (T3 fallback) |
| `~/dowon_trading` | 부재 | — | 동상 |
| `~/price-compare` | 부재 | — | 동상 |

**시사**: 본 사용자 환경의 4 프로젝트 중 LICENSE 파일은 **harness-meta 1건만**. 나머지 3건 부재 = proprietary 가정. v1.10e가 적용돼도 **현재 시점에서 추출 가능 프로젝트 0건** (harness-meta는 bootstrap 대상 아님).

## 4. T1 추출률 한계 + 사용자 안내

T1 (SPDX 헤더) 보유율이 sample 0%인 이유:
- 대부분 LICENSE 파일은 GitHub의 "Add license" UI 또는 cargo/npm 등 도구가 자동 생성한 boilerplate
- Boilerplate에 SPDX 헤더는 표준 미포함 (modern OSS 권장이지만 도입률 낮음)

**v1.10e 추가 가치**:
- 사용자가 **본인 LICENSE 파일에 SPDX 헤더 추가** → bootstrap 시 자동 추출
- INTERVIEW_FLOW.md에 1줄 안내: "LICENSE 파일에 `SPDX-License-Identifier: MIT` 등 추가 시 자동 감지"

## 5. v1.10e2 후속 동기

T2 boilerplate 매칭 추가 시:
- OSS sample 50% 매칭 가능 (MIT 4 + Apache-2.0 1)
- 실용 가치 ↑
- 단 false positive risk (boilerplate 변형 다양)

→ v1.10e 적용 후 사용자가 추출률 한계 인지 → v1.10e2 채택 결정 자연 유도. **본 v1.10e가 v1.10e2 결정의 evidence base**.

## 6. T3 fallback의 정합성

LICENSE 부재 + SPDX 헤더 미식별 → output 없음 + S3 WARN.

- proprietary 의도자 (50% sample) → 정확 처리
- OSS 의도자 (50% sample) → fallback. 사용자 후속 SPDX 헤더 추가 또는 v1.10e2 채택

→ **모든 케이스에서 안전** (false positive 0). v1.10c 거부 결정 (injection 회피)와 정합.

## 7. 통합 결론

| 측면 | sample 결과 | 시사 |
|------|------------|------|
| SPDX 헤더 보유율 | 0% | T1 단독 추출률 매우 낮음 |
| OSS LICENSE 비율 | 50% | T2 추가 시 잠재 매칭 |
| Proprietary 비율 | 50% | T3 fallback이 정확 처리 |
| T1 false positive | 0건 | 안전 (SPDX 표준 정확) |
| T1 false negative | 100% (sample) | 실용 한계 — v1.10e2 동기 |

**v1.10e 적용 후 자연 후속**:
1. INTERVIEW_FLOW.md 1줄 안내 → 사용자 SPDX 헤더 추가 유도
2. 또는 v1.10e2 (T2 boilerplate) 채택 → 실용 추출률 50%+
3. 또는 v1.10e3 (메타데이터 license) 채택 → npm/Python 프로젝트 추가 추출
