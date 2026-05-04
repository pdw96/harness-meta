# meta v1.10h2-l5-readme-link-cleanup — PLAN (placeholder)

세션 시작: TBD (v1.10h 완료 후)
직접 선행 세션:

- [`sessions/meta/v1.10h-agents-md-license-line-policy/`](../v1.10h-agents-md-license-line-policy/PLAN.md) — Out of scope 명시적 분리: "L5 `See [README.md](README.md) for project overview (human-readable).` 제거"

목적: AGENTS.md 템플릿 L5 라인의 `See [README.md](README.md) for project overview (human-readable).` 부분을 제거 — L7 blockquote (`AGENTS.md complements README.md...`) 중복 해소.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(1) `bootstrap/skeletons/AGENTS.md.tmpl` + S3(1) `tests/smoke-l5-readme-link-cleanup.sh` = **2/2 meta**
- **T1 경로 다수결** — meta scope 2/2

## Scope inheritance (verbatim from 선행 세션)

**Source — `sessions/meta/v1.10h-agents-md-license-line-policy/PLAN.md` Out of scope 표** (verbatim):

> | **L5 `See [README.md](README.md) for project overview (human-readable).` 제거** (Issue D / R3 in v2 PLAN) | "라인 자체 정책" umbrella 해석 외 — sub-items 3개 어디에도 명시 없음 | **`sessions/meta/v1.10h2-l5-readme-link-cleanup/`** (사용자 결정 — 별도 분리) |

**Parsed sub-items (1)**:

1. L5 라인 `See [README.md](README.md) for project overview (human-readable).` 제거

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| Case 3 enhancement | v1.10i+ |
| 정규화 map | v1.10i+ |
| Scope contract mechanism | v1.10j |
| 기타 AGENTS.md.tmpl 라인 정리 (1번 sub-item 외) | 별 세션 |

## 1. 문제 (1 issue)

### Issue D — AGENTS.md.tmpl L5 라인 형식 어색

현재 template:

```
License: {{license}} See [README.md](README.md) for project overview (human-readable).
```

v1.10h Case 1 치환 결과:

```
License: MIT (see [LICENSE](LICENSE)) See [README.md](README.md) for project overview (human-readable).
```

문제 3가지:

1. **두 링크 한 라인** — `[LICENSE]` + `[README.md]` 시각 충돌
2. **L7 blockquote 중복** — `> AGENTS.md complements README.md...` 이미 README 관계 설명
3. **"human-readable" 함의** — AGENTS.md가 non-human-readable로 함의됨 (잘못된 추론 유도)

## 2. 결정 (R1 + Smoke)

### R1 — `skeletons/AGENTS.md.tmpl` L5 정리

```diff
-License: {{license}} See [README.md](README.md) for project overview (human-readable).
+License: {{license}}
```

근거:

- L7 blockquote 중복 해소
- 두 링크 한 라인 충돌 해소
- "human-readable" 함의 제거
- AGENTS.md spec 컨벤션 정합 (license 라인 = license-only)

### Smoke — 1 stage 2 checks

```bash
Stage 1 — AGENTS.md.tmpl L5 (2 checks)
  ✓ "See [README.md]" 잔존 0 (line 5 only)
  ✓ L5 = "License: {{license}}" exact match
```

## 3. 변경 대상 (1 수정 + 3 신규)

### 수정 (1)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/skeletons/AGENTS.md.tmpl` | S2 | R1 — L5 1행 변경 |

### 신규 (3)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-l5-readme-link-cleanup.sh` | S2 | 1 stage 2 checks |
| `sessions/meta/v1.10h2-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10h2-.../REPORT.md` | meta | Stage F |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md placeholder 작성
- [ ] **사용자 진입 확인 (v1.10h 완료 후)**
- [ ] Stage A — AGENTS.md.tmpl R1
- [ ] Stage B — Smoke 2/2 PASS
- [ ] Stage C — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] L5 = `License: {{license}}` (단독)
- [ ] `See [README.md]` 라인 5에서 잔존 0
- [ ] Smoke 2/2 PASS

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.10h2-l5-readme-link-cleanup — AGENTS.md.tmpl L5 단독화

- update: bootstrap/skeletons/AGENTS.md.tmpl (R1 — "See [README.md]..." 제거)
- add: tests/smoke-l5-readme-link-cleanup.sh (1 stage 2 checks)
- add: sessions/meta/v1.10h2-.../{PLAN,REPORT}.md

v1.10h Out of scope 분리:
- L7 blockquote 중복 해소 + 두 링크 한 라인 시각 충돌 정리

Smoke 2/2 PASS.
```
