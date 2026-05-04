# meta v1.10j-scope-contract-discipline — PLAN (placeholder)

세션 시작: TBD (v1.10h 완료 후 — 1차 demo 평가 후)
직접 선행 세션:

- [`sessions/meta/v1.10h-agents-md-license-line-policy/`](../v1.10h-agents-md-license-line-policy/PLAN.md) — Scope inheritance/Out of scope 섹션 1차 demo. 본 v1.10j가 정식 rule化 + verify

목적: PLAN.md "Scope inheritance (verbatim)" + "Out of scope (explicit rejection)" 두 섹션을 **모든 sessions PLAN.md 의무**로 정식화. OWNERSHIP.md 갱신 + verify 자동 검사 추가 → over-scope drift 영구 차단.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S2(2) `bootstrap/docs/{OWNERSHIP.md, INTERVIEW_FLOW.md}` + S3(2) `verify.ps1` + `tests/smoke-scope-contract.sh` = **4/4 meta**
- **T1 경로 다수결** — meta scope 4/4
- **T2 스펙 vs 값** — 본 세션은 PLAN.md 구조 **스펙** 변경 (모든 세션에 영향) → meta

## Scope inheritance (verbatim from 선행 세션 발의)

**Source — v1.10h 진행 중 사용자 발의** (verbatim 요약):

> "계속 over-scope이 되는 경우가 있어. 절대 벗어나지 않게 할 수는 없나?"

→ Q3 (b) 채택: "v1.10z-scope-contract-discipline 같은 번호에서 OWNERSHIP.md 갱신까지"

**Parsed sub-items (3)**:

1. **Scope contract 두 섹션 의무화** — 모든 PLAN.md에 `## Scope inheritance (verbatim)` + `## Out of scope (explicit rejection)` 의무
2. **OWNERSHIP.md 갱신** — 위 rule 정식 기록 (S1–S7 / T1–T5에 이은 새 규약 §)
3. **verify 자동 검사** — `verify.ps1` 또는 별도 smoke가 PLAN.md 두 섹션 존재 검증

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 기존 모든 sessions PLAN.md 소급 갱신 (legacy 25+ 세션) | 후속 세션 — 점진 마이그레이션 |
| PreToolUse hook으로 PLAN.md 작성 시 실시간 차단 | v1.21+ (verify.ps1 통합 후) |
| 프로젝트 sessions (S6) PLAN.md 의무화 — 본 세션은 meta sessions only | 별도 후속 — project 영향 분리 |
| `Scope items (parsed)` 섹션 추가 의무화 (4번째 섹션) | v1.10j2+ (정량 평가 후) |

## 1. 문제 분석 (over-scope 진단)

### 사례 누적

| 세션 | Over-scope 발생 양상 |
|------|------|
| v1.10h v1 PLAN | Issue B (T1/T2 fail + T3 hit) 추가 — sub-item 명시 외 |
| v1.10h v2 PLAN | + Case 3 enhancement (G3) + Issue D / R3 (L5 README 정리) — 3개 인접 issue 묶음 |
| (가설) 향후 세션 | mechanism 부재 시 동일 패턴 반복 예상 |

### Root cause (3)

1. **인접 issue 발견 시 묶고 싶은 충동** — 같은 파일 영역 작업 중 인접 발견 → "이 김에 같이"
2. **선행 세션 인용 verbatim 부재** — 메모리에서 자유 해석 (umbrella vs sub-items)
3. **"명시 외 항목 거부" 섹션 부재** — 검토 항목 자리 없으면 본문에 섞임

## 2. 결정 (R1 ~ R3)

### R1 — OWNERSHIP.md 신규 § 추가

위치: `## Tie-breakers (T1–T5)` 다음, `## PLAN 템플릿 — "세션 소속 근거" 섹션 규격` 위.

신규 §: `## Scope contract — "Scope inheritance" + "Out of scope" 섹션 규격`

내용:

- 두 섹션 의무 (의무 위치: "세션 소속 근거" 직후)
- "Scope inheritance" — 선행 세션 명시적 sub-item 인용 (verbatim, 변형 금지)
- "Out of scope" — 인접 발견 issue 명시적 부정 + 분리 대상 세션 ID
- 본문 진입 규칙: 모든 작업은 "Scope inheritance" sub-item에 매핑 가능해야 함
- 위반 시: PLAN 거부 + 사용자 재작성 요청

### R2 — INTERVIEW_FLOW.md / harness-meta.md slash command 안내 갱신

- `claude/commands/harness-meta.md` `### 3. PLAN.md 작성` 절에 두 섹션 추가
- `bootstrap/docs/INTERVIEW_FLOW.md` (혹은 별 doc) Bootstrap PLAN 작성 시에도 동일 적용

### R3 — Smoke / verify 자동 검사

- `tests/smoke-scope-contract.sh`: 본 세션 자체 검증
  - v1.10h PLAN.md `## Scope inheritance` + `## Out of scope` 섹션 존재
  - v1.10h2 / v1.10j PLAN.md 동일
- `verify.ps1` (또는 후속 v1.21에서 흡수) 신규 체크:
  - `sessions/meta/vX.Y-*/PLAN.md` 글롭에서 두 섹션 missing → ERR

## 3. 변경 대상 (2 수정 + 3 신규)

### 수정 (2)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/docs/OWNERSHIP.md` | S2 | R1 — Scope contract § 신설 |
| `claude/commands/harness-meta.md` | S1a | R2 — `### 3. PLAN.md 작성` 절 갱신 |

### 신규 (3)

| 경로 | scope | 역할 |
|------|------|------|
| `tests/smoke-scope-contract.sh` | S3 | R3 검증 (PLAN.md 두 섹션 존재) |
| `sessions/meta/v1.10j-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.10j-.../REPORT.md` | meta | Stage F |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md placeholder 작성
- [ ] **사용자 진입 확인 (v1.10h 완료 + 1차 demo 효과 평가 후)**
- [ ] Stage A — OWNERSHIP.md R1 신규 §
- [ ] Stage B — harness-meta.md R2 안내
- [ ] Stage C — Smoke R3 자동 검사
- [ ] Stage D — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] OWNERSHIP.md `## Scope contract` § 존재 + 위반 정책 명시
- [ ] harness-meta.md slash 안내에 두 섹션 의무 반영
- [ ] Smoke 자동 검사: v1.10h, v1.10h2, v1.10j 본 세션 3개 PASS
- [ ] 향후 sessions/meta/ PLAN.md는 본 rule 의무 적용

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.10j-scope-contract-discipline — PLAN.md "Scope inheritance" + "Out of scope" 섹션 의무화

- update: bootstrap/docs/OWNERSHIP.md (R1 — Scope contract § 신설)
- update: claude/commands/harness-meta.md (R2 — PLAN.md 작성 안내 갱신)
- add: tests/smoke-scope-contract.sh (R3 — 두 섹션 존재 자동 검사)
- add: sessions/meta/v1.10j-.../{PLAN,REPORT}.md

v1.10h 1차 demo 효과 정식 rule化:
- 모든 sessions/meta/ PLAN.md 두 섹션 의무
- 위반 시 PLAN 거부 + 재작성 (over-scope drift 영구 차단)

Smoke 자동 검사 PASS. legacy 세션 마이그레이션은 별도 후속.
```

## 7. Lessons Forward (예상)

- **L1 — mechanism 효과는 demo 누적으로 평가** — v1.10h 1차 적용 후 over-scope 발생률 정량화 후 정식화
- **L2 — verify 자동 검사 = 영구 guardrail** — 사람 의존 < 도구 의존
- **L3 — OWNERSHIP.md는 정책 단일 소스** — Scope contract도 자연 흡수
