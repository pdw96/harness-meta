# A5 — 회귀 위험 분석

## 1. 결론

R1+R2 정정의 회귀 위험은 **무시 수준**. 3 시나리오 (model 강등 / effort 명시 / cross-model fallback) 모두 silent 또는 graceful. v1.10d/v1.10f smoke 모두 PASS 유지 예상.

## 2. 시나리오별 분석

### S1 — `harness-meta.md` model: opus → sonnet 강등

| 이전 동작 | 정정 후 동작 | 위험 | 완화 |
|----------|------------|:---:|------|
| opus 호출 (5x 비용) + thinking: silent ignore + Opus 4.7 default `xhigh` 사용 | sonnet 호출 (1x) + Sonnet 4.6 default `high` 사용 | **낮음** | 라우팅 책임 → sonnet 충분 (v1.10f harness/SKILL.md 선례) |

**우려 시나리오 → 반박**:
1. **"opus 추론력으로만 가능한 라우팅 결정?"** → harness-meta.md 본문은 패턴 매칭 + 조건 분기 + grep + mkdir만 수행. 추론 깊이 무관. 인터뷰/PLAN 작성 등 깊은 작업은 후속 turn에서 별도 SKILL/agent가 담당
2. **"Bootstrap 분기 정확성 손실?"** → 10-stage 흐름은 각 stage가 별도 turn — harness-meta.md는 stage S0만 수행 (모드 진입 확인). detect-project.sh / interview.md는 별도 호출
3. **"기존 사용자 경험 회귀?"** → cost 절감 + latency 개선 → UX **향상**. 기능 손실 없음

### S2 — 3 opus skill thinking: high → effort: xhigh 명시

| 모델 | 이전 동작 (thinking: silent) | 정정 후 (effort: xhigh) | 차이 |
|------|------|------|------|
| Opus 4.7 | session default `xhigh` | frontmatter `xhigh` (동일) | 0 |
| Opus 4.6 | session default `high` | frontmatter `xhigh` → graceful fallback `high` | 0 |
| Sonnet 4.6 | session default `high` | frontmatter `xhigh` → graceful fallback `high` | 0 |
| Opus 4.5 이전 | effort 미지원 | effort 미지원 → silent ignore | 0 |
| Haiku 4.5 | effort 미지원 | effort 미지원 → silent ignore | 0 |

→ **모든 모델에서 회귀 0**. 정정 후가 정정 전과 동등하거나 더 명시적.

**우려 시나리오 → 반박**:
1. **"`xhigh` 명시가 Opus 4.6 사용자에게 fallback overhead?"** → 인용 20 fallback graceful. 한 번 fallback 후 동일 동작. token cost 영향 0
2. **"max로 더 강화해야?"** → 인용 22 — `max`는 session-only persist 안 함. 인용 24 — overthinking risk + diminishing returns. xhigh가 권장 default (인용 24 "Best results for most coding and agentic tasks")
3. **"effort 명시가 사용자 settings.effortLevel override 깨뜨림?"** → 인용 21 precedence — env var > settings > frontmatter > model default. 사용자 settings effortLevel은 **frontmatter보다 우선**. frontmatter는 skill 활성 동안만 일시 override

### S3 — Cross-model fallback (모델 미지원 level 명시 시)

| 명시 level | Opus 4.7 | Opus 4.6 | Sonnet 4.6 | Opus 4.5 이전 |
|------|:---:|:---:|:---:|:---:|
| `low` | ✓ | ✓ | ✓ | silent ignore (effort 미지원) |
| `medium` | ✓ | ✓ | ✓ | 동상 |
| `high` | ✓ | ✓ | ✓ | 동상 |
| `xhigh` | ✓ (default) | → `high` (graceful) | → `high` (graceful) | 동상 |
| `max` | ✓ | ✓ | ✓ | 동상 |

→ R2의 `xhigh` 명시는 **모든 모델에서 안전** (graceful 또는 silent ignore).

## 3. v1.10d/v1.10f 회귀 영향

### v1.10d 5축 spec (frontmatter Bash patterns)

본 v1.10g 변경은 frontmatter의 `model:` 값 변경 + `thinking:` 라인 제거 + `effort:` 라인 추가.

| v1.10d 검증 | 영향 |
|----------|:---:|
| V1 (콜론 없음 패턴) — `Bash\([a-z][a-z\-]*\*\)` 잔존 0 | 0 (Bash 라인 변경 0) |
| V4 (PERMISSION_PATTERN.md 9 keyword) | 0 (R3는 keyword 보존 + 추가) |
| V5 (auto-allow set declare 잔존 0) | 0 (Bash 변경 0) |
| V7 (slash command `allowed-tools:` 매치) | 0 (allowed-tools 라인 보존) |
| V8 (single-line 콤마 separator 잔존 0) | 0 (frontmatter list 형식 보존) |
| V9 (YAML list `^  - ` 라인 ≥3) | 0 (allowed-tools 라인 보존) |

→ **v1.10d smoke 6/6 PASS 유지 예상**.

### v1.10f 7 파일 frontmatter 정합 (broad Bash + 3 agent 콤마)

본 v1.10g 변경 4 파일 vs v1.10f 7 파일 — **교집합 0**.

| v1.10f 검증 파일 | v1.10g 변경 |
|----------|:---:|
| `harness/SKILL.md` | 변경 0 (R1 대상 외) |
| `harness-run/SKILL.md` | 변경 0 |
| `harness-ship/SKILL.md` | R2 대상 — frontmatter 라인 추가/제거 (allowed-tools 라인 보존) |
| `harness-verifier.md` | 변경 0 |
| `harness-dispatcher.md` | 변경 0 |
| `harness-explore.md` | 변경 0 |
| `harness-grey-area.md` | 변경 0 |

→ `harness-ship/SKILL.md`는 양쪽 검증 대상이지만 v1.10f 검증 항목 (broad Bash + Edit/Write fine-grain + YAML list)은 보존. v1.10g는 별 라인 (`thinking:` ↔ `effort:`) 변경.

→ **v1.10f smoke 6/6 PASS 유지 예상**.

## 4. smoke 5 stage 정당화

본 v1.10g `tests/smoke-thinking-effort.sh` 5 stage:

| Stage | 검증 | 명령 | 기대 |
|:---:|------|------|------|
| 1 | V10 (A1) — 4 파일 `thinking:` 잔존 0 | `grep -E '^thinking:' <files>` | 0 |
| 2 | R1 — `harness-meta.md` model+effort 정합 | `grep -E '^model: sonnet$' && ! grep -E '^effort:'` | both pass |
| 3 | R2 — 3 SKILL effort+thinking 정합 | `grep -E '^effort: xhigh$' && ! grep -E '^thinking:'` | both pass each file |
| 4 | model 보존 (R2) — 3 SKILL `model: opus` 유지 | `grep -E '^model: opus$'` | match each file |
| 5 | 5축 회귀 (V1+V5+V8+V9) — v1.10d/v1.10f spec 정합 유지 | v1.10d smoke 명령 재실행 | 0 (변경 영향 0) |

**Stage 1 정당화** (V10 신설):
- `thinking:` 필드는 silent ignore (A1 §4) → grep 검증으로 잔존 자동 차단
- 회귀 시나리오: 누군가 미래 frontmatter에 `thinking:` 다시 추가 → 본 검증이 즉시 차단

**Stage 2/3 정당화** (R1/R2 정합):
- 부정 검증 (`! grep`)으로 정정 누락 즉시 식별
- 명시 검증 (`grep -E '^...$'`)으로 spec 형식 (line-anchored) 정합

**Stage 4 정당화** (model 보존):
- R2가 `effort:` 추가하면서 `model: opus` 라인 실수 변경 회귀 차단

**Stage 5 정당화** (cross-session 회귀):
- v1.10d/v1.10f smoke 자체를 본 v1.10g smoke가 호출 — 단일 게이트로 통합 검증

## 5. 시그널 모니터링 (REPORT 단계 4건)

본 v1.10g 후 monitoring 권장:

| 시그널 | 관찰 방법 | 기대 |
|------|------|------|
| harness-meta.md 진입 latency | 사용자 perception | sonnet → 빠름 |
| harness-meta.md 라우팅 정확성 | Bootstrap/meta/project 분기 오류 frequency | 0 (sonnet 충분) |
| 3 opus skill effort 적용 | `/effort` 출력 또는 `/status` (skill 활성 시) | xhigh (Opus 4.7) / high (Opus 4.6 graceful) |
| settings.effortLevel override | 사용자가 settings.json에 effortLevel 설정 시 frontmatter override 정합 | settings 우선 (인용 21 precedence) |

## 6. cross-platform 영향

| 측면 | 영향 |
|------|:---:|
| Windows (PowerShell + git bash) | 0 (frontmatter 텍스트 변경) |
| macOS (zsh) | 0 (동상) |
| Linux | 0 (동상) |
| Git Bash | 0 (동상) |
| 신규 프로젝트 bootstrap | install-project-claude.{ps1,sh}가 `cp -r` (v1.10f A6 §6 인용 18) → templates baseline 변경 자동 반영 |
| 기존 deployed projects | 변경 자동 반영 안 됨 — 각 프로젝트 install-project-claude 재실행 필요 (T4 후행) |

## 7. 결론 요약

- 3 시나리오 모두 회귀 risk 무시 수준 (silent / graceful / 동등)
- v1.10d 6 smoke + v1.10f 6 smoke = 12 smoke 모두 PASS 유지 예상
- 본 v1.10g smoke 5 stage = V10 신설 + R1/R2 정합 + 회귀 통합 검증
- 시그널 4건 monitoring (REPORT 단계)
- cross-platform 영향 0 — frontmatter 텍스트 변경만
