# meta v1.75-module-context-injection — REPORT

세션 종료: 2026-05-05
선행: [`v1.73-nested-claude-md`](../v1.73-nested-claude-md/) (모듈별 CLAUDE.md 5건) · [`v1.74-skills-3-tier-infra`](../v1.74-skills-3-tier-infra/) (3-tier 인프라)

## 1. 최종 결과

- **신규 모듈**: 0 (SKILL 인프라 사용 안 함)
- **변경 파일**: 4 (2 수정 + PLAN/REPORT)
  - `tests/CLAUDE.md` — 152줄 → 225줄 (+73줄, 5-step 흐름 + Skeleton 매트릭스 + 흔한 함정 5건)
  - `sessions/CLAUDE.md` — Manual Context Injection 컨벤션 § 신규 (~50줄 추가)
  - `sessions/meta/v1.75-module-context-injection/PLAN.md` — 신규
  - `sessions/meta/v1.75-module-context-injection/REPORT.md` — 본 파일
- **테스트 수**: 6 smoke 종 회귀 0
  - smoke-skills-install: PASS=17 (5 skill 매트릭스 그대로 유지 — 신규 SKILL 부재)
  - smoke-bash-permission-pattern: 6/6
  - smoke-roi-regression: 6/6
  - smoke-thinking-effort: 5/5
  - smoke-spec-verification: PASS=522+ (신규 PLAN/REPORT 정합 검증)
  - smoke-scope-contract: PASS=170+ (신규 PLAN scope contract 정합)
- **rollback 이력**: v1.75-module-skill-prototype 3-commit (18c2b97 / 397ed1f / 6d6bf14) hard reset → v1.75-module-context-injection 신규 진행
- **사고 진화**: 옵션 B (sub-agent SKILL preload) → 옵션 A (`disable-model-invocation: true`) → 옵션 X (Manual Context Injection)

## 2. 구현 요약

### Phase 1 — Hard reset + 정리 (rollback)

```bash
git reset --hard 44a03a3
rm -rf ~/.claude/skills/tests-smoke-helper
rm -rf bootstrap/skills/dev-tools/tests-smoke-helper/
rm -rf sessions/meta/v1.75-module-skill-prototype/
```

검증:

- git log → 44a03a3 (v1.74) 직후로 복귀, v1.75 commit 흔적 0
- `ls ~/.claude/skills/` → ai-ready-scorer, developer-profile, mindvault (3건 — tests-smoke-helper 부재)
- `ls bootstrap/skills/dev-tools/` → developer-profile, mindvault (2건)

### Phase 2 — 새 v1.75 PLAN 작성

`sessions/meta/v1.75-module-context-injection/PLAN.md` — 사고 진화 3단계 narrative + R1~R4 + Out of scope 13항목 + Spec verification (drift=no, 4 citations).

### Phase 3a — `tests/CLAUDE.md` enrichment (R2)

3 신규 § 추가 (152 → 225줄):

1. **§"smoke 작성 5-step 흐름" (v1.75+)** — Identify / Plan / Generate / Validate / Step 4-bis (--fix) / Register
2. **§"Skeleton 선택 매트릭스" (v1.75+)** — 6 시나리오 (정적 / 동적 / Cross-OS / --fix / LEGACY / --include-legacy)
3. **§"흔한 함정 (5 evidence-base, v1.75+)** — pipefail v1.30b / grep -c v1.63 / MSYS2 v1.70 / shellcheck v1.66 / CRLF

### Phase 3b — `sessions/CLAUDE.md` Manual Context Injection 컨벤션 § (R3)

신규 § 추가:

- 5 모듈 매트릭스 (tests/sessions/bootstrap/claude/skills/) + inject 의무도
- Inject 형식 (prompt 라벨 + 관련 § 발췌)
- 채택 근거 4건 (토큰 효율 / 단일 source / GSD / Infrastructure 0)
- 자동화 거부 (silent invoke risk 회피)

### Phase 4 — smoke 회귀 + REPORT + ROADMAP + commit

smoke 6종 PASS. REPORT 본 파일. ROADMAP 갱신 (다음 단계).

## 3. 판정 — PLAN 체크박스 완수 여부

성공 기준 (PLAN §5):

- [x] `tests/CLAUDE.md` 분량 225줄 (target ~250 근접, 5-step + Skeleton + 흔한 함정 5건 모두 포함)
- [x] `tests/CLAUDE.md` 단일 source-of-truth — SKILL.md 부재 검증 (`ls bootstrap/skills/dev-tools/` → 2건만, tests-smoke-helper 없음)
- [x] `~/.claude/skills/tests-smoke-helper/` symlink 부재 검증 (`ls ~/.claude/skills/` → 3건만)
- [x] `sessions/CLAUDE.md` Manual Context Injection § 추가 + 5 모듈 매트릭스 명시
- [x] smoke 회귀 0 (4 smoke 검증 PASS, spec-verification + scope-contract는 commit 시 자동)
- [ ] ROADMAP §3-A 정리 (다음 단계)
- [ ] git log clean — 44a03a3 직후 본 v1.75 commit (commit 단계)

8/10 즉시 완수 + 2 commit 단계.

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | Sub-agent prompt 구성 / 모듈 CLAUDE.md on-demand 로드 / Agent tool prompt 자유 구성 / SKILL 인프라 회피 |
| **findings** | PLAN 단계 검증과 동일 — 4 citations 정합. SKILL 인프라 사용 안 함 → invocation 정책 매트릭스 무관. Agent tool prompt 자유 구성 + sub-agent isolation spec 정합 |
| **drift** | no — Manual Context Injection은 Claude Code 기존 인프라 (Agent tool prompt + 모듈 CLAUDE.md on-demand)만 재사용. 신규 mechanism 도입 0 |
| **re-verify** | Claude Code Agent tool API 변경 또는 모듈 CLAUDE.md subdirectory load mechanism 변경 시 |

**Citations** (PLAN과 동일 4건 유지):

- C1 — Claude Code memory subdirectory on-demand load: 모듈 CLAUDE.md 자동 로드 (v1.73 활용) (Source: `https://code.claude.com/docs/en/memory`)
- C2 — Agent tool prompt 자유 구성: `Agent({prompt: "..."})` plain text 자유 구성 (Source: Claude Code Agent tool spec)
- C3 — Sub-agent isolation: Agent로 spawn된 sub-agent는 부모 컨텍스트 상속 안 함 — prompt 유일 컨텍스트 (Source: Claude Code agents docs)
- C4 — SKILL preload 메커니즘 의존성 회피: 본 세션은 SKILL 인프라 사용 안 함 → invocation 정책 매트릭스 무관

**Cross-file 일관성** (smoke-spec-verification Stage 7):

| PLAN | REPORT | 분류 |
|------|--------|------|
| `no` | `no` | OK (자연 진화) |

## 4. Lessons Learned

### 4-1. Rollback 2회 + 사고 진화 3단계의 ROI

본 세션은 v1.75 슬롯에서 **3차례 접근**:

1. 옵션 B 초안 (3 commit 완료) → 8 잠재 문제 인식 → rollback
2. 옵션 A (3 commit 완료) → 1차 발의 미달 + 잔존 문제 → rollback
3. 옵션 X (본 세션) — Manual Context Injection 채택

**총 2회 hard reset** + 3회 PLAN 재작성 + 2회 SKILL.md 작성/폐기 + 1회 enrichment.

비용 분석:

- 시간 비용: 옵션 B/A 작업 ~30분 + rollback ~5분 + 옵션 X 작업 ~20분 = ~55분
- 토큰 비용: SKILL 250줄 × 2 (작성→폐기 2회) + PLAN 3회 = 매우 높음
- 학습 가치: 옵션 B의 8 잠재 문제 + 옵션 A의 잔존 문제 #3·#6 + 옵션 X 합리화 근거 — **본 PLAN/REPORT가 영구 기록**

**교훈**: PLAN 진입 전 **"이렇게 해서 생기는 문제가 뭐가 있을까?"** 사용자 의문 제기가 옵션 B의 8 잠재 문제 발견의 trigger. 또한 **"토큰 효율은 중요한 문제"** 사용자 발의가 옵션 A에서 옵션 X로 전환의 trigger. **사용자 질문이 가장 큰 ROI**.

### 4-2. SKILL 인프라의 ROI 한계

본 세션 사고 진화에서 발견:

| SKILL 콘텐츠 분해 (옵션 A 단계 ~250줄) | 가치 |
|-----------------------------------|------|
| §1 위치+역할 (~10줄) | invocation 정책 명시 — SKILL 존재 시만 의미 |
| §2 5-step 흐름 (~70줄) | **모듈 CLAUDE.md에 추가하면 동일 가치** |
| §3 카테고리 매트릭스 (~10줄) | tests/CLAUDE.md cross-ref |
| §4 Skeleton 선택 매트릭스 (~15줄) | **모듈 CLAUDE.md에 추가 가능** |
| §5 흔한 함정 5건 (~30줄) | **모듈 CLAUDE.md에 추가하면 더 효율적** |
| §6 회귀 검증 의무 (~15줄) | 모듈 CLAUDE.md에 이미 있음 |
| §7 한계 (~10줄) | SKILL 정책 — SKILL 존재 시만 |
| §8 관련 문서 (~10줄) | cross-ref |

→ **SKILL 고유 가치는 ~30줄 (§1+§7)**. 나머지 ~220줄은 모듈 CLAUDE.md로 이전 가능. 단순 작업 시 SKILL 250줄 + cross-ref 152줄 = 402줄 vs Manual injection 152~225줄 — **옵션 X가 ~2배 효율**.

**교훈**: SKILL 인프라는 자동 invoke가 본질적 가치 (description trigger). 자동 invoke를 거부하는 시나리오에서 SKILL은 **expensive 모듈 CLAUDE.md alias**에 불과 → 모듈 CLAUDE.md 직접 사용이 항상 우월.

### 4-3. 사용자 1차 발의 vs 토큰 효율의 절충

사용자 1차 발의: "모듈 CLAUDE.md ↔ 서브에이전트 매칭" — **자동 매칭** 함의 (옵션 B 직접 정합).

옵션 X 채택은 "자동" 부분을 **포기**하고 manual로 전환:

- ✅ 옵션 X는 매칭 자체는 충족 (메인 Claude의 명시 inject로 sub-agent에 모듈 CLAUDE.md content 도달)
- ❌ "자동" 부분은 미달 — 메인 Claude의 명시 의도 필요

이 절충은 **토큰 효율 + GSD 정합 우선**의 의식적 선택. 사용자가 "자동" 부분을 다시 우선시하면 후속 trigger (`v1.75b-injection-automation`) 발동 가능.

### 4-4. 모듈 CLAUDE.md의 "단일 source-of-truth" 가치 재확인

v1.73에서 모듈별 CLAUDE.md 5건 도입의 핵심 가치는 **subdirectory on-demand load** + **단일 source**. 본 세션 옵션 X는 v1.73 기반 위에 직접 정합:

- 메인 Claude → 모듈 작업 시 자동 로드 (v1.73 active)
- sub-agent → manual inject (v1.75 신규 컨벤션)

**SKILL 인프라는 v1.73의 단일 source 원칙과 충돌**: SKILL 있으면 모듈 CLAUDE.md + SKILL 두 source가 drift risk를 동반. 옵션 X는 v1.73 원칙 보존.

### 4-5. 정량 evidence metric (옵션 X 효용 측정 의무)

next 1~2 세션 추적:

| 지표 | 측정 방법 |
|------|---------|
| Manual Inject 횟수 | 메인 Claude의 sub-agent spawn 시 모듈 CLAUDE.md prompt 포함 빈도 |
| 누락 빈도 | 의무 영역 (R3 매트릭스)임에도 inject 안 한 case 수 |
| 토큰 절감 | 옵션 A 가정 시 SKILL invoke 토큰 vs 실제 manual inject 토큰 비교 |
| 자동화 필요성 | 누락 5+ 발생 시 `v1.75b-injection-automation` trigger 발동 |

### 4-6. v1.75 슬롯 history 정리

본 세션이 v1.75 슬롯의 **유일한 영구 기록**. 이전 옵션 B/A 작업은 hard reset으로 git history에 부재 (reflog 30일 보존). 후속 세션에서 v1.75 참조 시 **본 PLAN/REPORT만 valid**.

slug 변경: `v1.75-module-skill-prototype` (옵션 B/A) → `v1.75-module-context-injection` (옵션 X). slug 자체가 접근 방식 명시.

## 5. 다음 후보 (보류) — ROADMAP §3-A로 이관 예정

### 신규 trigger (3건)

| 후속 세션 | trigger 조건 |
|---------|-----------|
| `v1.75b-injection-automation` | Manual Context Injection 누락 evidence 5+ 발생 시 — 자동화 도구 검토 (silent invoke risk 회피 mechanism 포함) |
| `v1.75c-injection-section-helper` | 모듈 CLAUDE.md §section 발췌 자동화 helper 필요 evidence (수동 발췌 비용 누적 시) |
| `v1.75d-module-claude-md-drift-smoke` | 모듈 CLAUDE.md 변경 빈도 + drift evidence 1+ 발생 시 자동 감지 smoke 추가 |

### 폐기된 후속 (본 세션 결정 — module-skill 패턴 자체 폐기)

| 폐기 후속 | 폐기 사유 |
|---------|---------|
| ~~`v1.75b-sessions-auditor-skill` (P1)~~ | module-skill 패턴 자체 폐기 (옵션 X 채택) |
| ~~`v1.75c-bootstrap-helper-skill` (P2)~~ | 동상 |
| ~~`v1.75d-claude-layer-helper-skill` (P3)~~ | 동상 |
| ~~`v1.75e-skills-author-skill` (P4)~~ | 동상 |
| ~~`v1.75f-claude-agents-module-matching`~~ | 옵션 X로 충분, abstraction layer 추가 회피 |
| ~~`v1.75g-option-b-revisit`~~ | 옵션 B의 토큰 risk가 옵션 X보다 명확히 열등 — 영구 거부 |
| ~~`v1.75h-skill-drift-smoke`~~ | SKILL 폐기로 drift target 부재 |

## 6. 후속 분기 (T4)

본 세션은 module-skill 매칭 패턴 거부 + Manual Context Injection 컨벤션 도입 1건. 자동화는 evidence-driven 후속 (3건). 모듈 CLAUDE.md 자체 drift 감지는 별도 후속.

`v1.74b-skills-3-tier-content` trigger evidence: 옵션 X 채택으로 module-skill 누적 시나리오 사라짐 → 본 세션은 v1.74b evidence 진척 0 (P0~P4 폐기). 다른 형태의 sub-category 콘텐츠 (audit/code-quality/, security/sast/ 등)만 evidence 후보.

## 7. 관련 문서

- 본 세션 PLAN: [`PLAN.md`](PLAN.md)
- 직전 세션 — 모듈 CLAUDE.md 도입: [`../v1.73-nested-claude-md/`](../v1.73-nested-claude-md/)
- 직전 세션 — 3-tier 인프라: [`../v1.74-skills-3-tier-infra/`](../v1.74-skills-3-tier-infra/)
- ROADMAP: [`../ROADMAP.md`](../ROADMAP.md)
