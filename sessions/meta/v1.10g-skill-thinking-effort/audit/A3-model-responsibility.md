# A3 — 6 파일 model 책임 분석

## 1. 결론

`harness-meta.md` (slash command 진입점) = **디스패처 책임** → `model: sonnet` 강등이 정합 (라우팅 중심, opus 추론 깊이 불필요). 나머지 5 파일은 현행 model 유지. R1 = 1 파일 강등.

## 2. 6 파일 책임 매트릭스 (v1.10f A6 §1 표 + 본 v1.10g 분석)

| 파일 | 현 model | 책임 | 추론 깊이 필요 | 적정 model | 변경 |
|------|------|------|:---:|------|:---:|
| `claude/commands/harness-meta.md` | **opus** | 세션 진입점 — target 추론 + Bootstrap 분기 + 새 세션 디렉토리 생성 | 낮음 (라우팅) | **sonnet** | ✓ |
| `bootstrap/templates/_base/.claude/skills/harness/SKILL.md` | sonnet | 디스패처 — 상태 read + routing | 낮음 (라우팅) | sonnet ✓ | — |
| `bootstrap/templates/_base/.claude/skills/harness-run/SKILL.md` | sonnet | 8~9단계 — executor 호출 + status read | 낮음 (실행 + 모니터링) | sonnet ✓ | — |
| `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` | opus | 1~4단계 — 탐색 + 사용자 논의 + PLAN.md 생성 | 높음 (논의 + 설계) | opus ✓ | — |
| `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md` | opus | 5~7단계 — Phase 설계 + 7-Dimension 검증 + step 파일 생성 | 높음 (설계 + 검증) | opus ✓ | — |
| `bootstrap/templates/_base/.claude/skills/harness-ship/SKILL.md` | opus | 10단계 — Goal-backward 검증 + REPORT + commit/push | 높음 (검증 + 회복) | opus ✓ | — |

**변경 1건**: `harness-meta.md` opus → sonnet (R1).

## 3. `harness-meta.md` 책임 deep-dive

### 3-1. 본문 분석 (실 수행 작업)

| 단계 | 작업 | 추론 종류 |
|------|------|------|
| 1. 대상 결정 | argument / CWD basename / projects/<name>/ 존재 여부 분기 | 패턴 매칭 (단순) |
| 2. 세션 모드 결정 | meta / 프로젝트별 개선 / Bootstrap 3 분기 | 조건 분기 |
| 3. 다음 버전 결정 | sessions/<target>/ 디렉토리 스캔 + minor bump | grep + 정렬 |
| 4. 세션 디렉토리 생성 | mkdir | shell |
| 5. PLAN.md 작성 | 사용자 논의 → 본 세션은 **즉시 종료** (논의는 후속 turn) | template fill |
| 6. Bootstrap 모드 (10-stage) | detect-project.sh + interview.md 호출 → **각 stage는 별도 turn** | 라우팅 |

→ harness-meta.md 자체는 **세션 진입점 + 라우팅** 만 수행. 실제 추론 (PLAN 작성, audit, 인터뷰)은 후속 turn 또는 다른 SKILL이 담당.

### 3-2. v1.10f 선례 — `harness/SKILL.md` (디스패처)

v1.10f A6 §1에서 확정:
> `harness/SKILL.md` | `harness` | 디스패처 | true | `""` | sonnet | — | A1 §1

`harness/SKILL.md`는 8~9단계 디스패처 + sonnet + effort declare 무. **harness-meta.md와 책임이 동일** (라우팅) → model 동일하게 **sonnet** 강등이 정합.

### 3-3. 비용 비교 (cache hit ratio 가정 동일)

Anthropic API 가격 (2026-04 기준, claude-opus-4-7 vs claude-sonnet-4-6):
- Opus 4.7: input $15/MTok / output $75/MTok
- Sonnet 4.6: input $3/MTok / output $15/MTok

→ **약 5x 차이**. 매 세션 진입 시 호출되는 harness-meta.md를 sonnet으로 강등 = 누적 비용 큰 절감.

## 4. opus 유지 3 skill 정당화

### 4-1. `harness-plan/SKILL.md` (1~4단계)

본문 (`bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md` line 15-21):
> Harness 1~4단계: 탐색 → 요구사항 → 논의 → PLAN.md 생성
>
> **역할 분담:**
> - **오케스트레이터(이 command)가 직접 처리**: 사용자 대화 (논의, 질문, 승인), 경량 파일 Read, Write
> - **Agent(subagent_type="harness-explore", model="opus")로 위임**: 코드 분석, 탐색, 호출 관계 / 설정 / 테스트 커버리지 수집

→ **사용자 대화 + 설계 결정** 수행. opus + xhigh effort 정합.

### 4-2. `harness-design/SKILL.md` (5~7단계)

본문 (line 15-29):
> Harness 5~7단계: Phase 설계 → 7-Dimension 검증 → 파일 생성
>
> **오케스트레이터**: 경량 조율자. 무거운 분석/파일 생성은 Agent(model="opus")로 위임.

→ **7-Dimension 검증 + step 파일 설계**. 추론 깊이 필요. opus + xhigh 정합.

### 4-3. `harness-ship/SKILL.md` (10단계)

v1.10f A6 §1 표: "10단계 — Goal-backward 검증 + REPORT + commit/push 복잡". `Edit(phases/**)` + `Write(phases/**)` fine-grain → 검증 + 작성 + git ops 동시 수행. opus + xhigh 정합.

## 5. sonnet 유지 2 skill 정당화

### 5-1. `harness/SKILL.md` (디스패처)

v1.10f A6 §1: "디스패처. argument-hint `""` 빈 문자열 — args 없음 의도". 라우팅 → sonnet 정합.

### 5-2. `harness-run/SKILL.md` (8~9단계)

v1.10f A6 §1: "8~9단계 step 실행". executor 호출 + status read. 추론 < 실행 → sonnet 정합.

## 6. R1 변경 영향 매트릭스

`harness-meta.md` opus → sonnet 강등 영향:

| 측면 | 강등 전 | 강등 후 | 영향 |
|------|------|------|:---:|
| 비용 | opus 호출 (5x) | sonnet 호출 | ↓ 큰 절감 |
| 라우팅 정확성 | opus 추론 (과잉) | sonnet 추론 (충분) | 동등 |
| Bootstrap 분기 | 10-stage 인터뷰 시작 — 각 stage는 별도 turn | 동상 | 동등 |
| effort | thinking: high silent ignore → 세션 default `xhigh` (Opus 4.7) | declare 무 → 세션 default `high` (Sonnet 4.6) | 약간 ↓ (라우팅엔 충분) |
| 세션 진입 latency | opus latency | sonnet latency (빠름) | ↑ 빠름 |
| 사용자 perception | opus 진입 = "비싼 진입점" 인상 | sonnet = 가벼운 진입 | 일치 (실제 책임에 정합) |

→ **장점 다수 + 단점 0**. 라우팅 정확성 손실 우려는 v1.10f harness/SKILL.md sonnet 선례로 무력화.

## 7. Cross-platform 호환

`model: sonnet` 강등은 frontmatter 텍스트 변경만. 모든 OS / Claude Code 버전 / 플러그인에 영향 무 (frontmatter parser 동일).

## 8. R1 정정 후 6 파일 model+effort 매트릭스

| 파일 | model | effort | 의미 |
|------|------|------|------|
| `claude/commands/harness-meta.md` | **sonnet** ← R1 | (declare 무, default `high`) | 라우팅 + 비용 최적 |
| `harness/SKILL.md` | sonnet | (declare 무, default `high`) | 디스패처 (선례) |
| `harness-run/SKILL.md` | sonnet | (declare 무, default `high`) | 실행 + 모니터링 |
| `harness-plan/SKILL.md` | opus | **`xhigh`** ← R2 | 1~4단계 + 사용자 논의 |
| `harness-design/SKILL.md` | opus | **`xhigh`** ← R2 | 5~7단계 + 7-Dim 검증 |
| `harness-ship/SKILL.md` | opus | **`xhigh`** ← R2 | 10단계 + Goal-backward |

→ **3 sonnet (라우팅/실행)** + **3 opus + xhigh (논의/설계/검증)** 명료 분할. v1.10f A6 §1 표의 model 분포 패턴 보존 + harness-meta 1건 정합.

## 9. 결론 요약

- 6 파일 책임 분석 → `harness-meta.md` opus 과잉 식별
- v1.10f harness/SKILL.md (디스패처, sonnet) 선례 정합 → R1 sonnet 강등
- 나머지 5 파일 model 유지 (3 sonnet + 3 opus 자연 분할)
- 비용 절감 (5x) + 라우팅 정확성 동등 + 진입 latency 개선
- 본 v1.10g R1+R2 = templates baseline 4 파일 + 글로벌 1 파일 (총 4 변경) frontmatter 6축 정합
