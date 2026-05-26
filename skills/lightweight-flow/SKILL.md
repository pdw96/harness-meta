---
name: lightweight-flow
description: 작은 meta-work (또는 외부 프로젝트의 작은 조정) 을 9-stage 무거운 절차 대신 가벼운 흐름 (4 섹션 한 장 LIGHTWEIGHT.md = 문제→결정→적용→기록) 으로 처리할 때. 사용 case = 사용자가 '가벼운 흐름' / 'lightweight flow' / '작은 건이니 가볍게' / 'LIGHTWEIGHT.md 작성' 언급 또는 내부·작은 조정 (좁은 mechanical 수정, 기존 자산 1 줄 보강) 진행. SKIP = 컨설팅 자산 (방법론·도구·외부 제공물) 에 영향 가는 큰 건 (era 신설 / ROADMAP schema 변경 / 9-stage 단어 정의 / smoke 판정 재설계) → 9-stage 의무. 본 skill = ARCHITECTURE.md § 7.4 1차 source 의 derived checklist.
---

# lightweight-flow — 가벼운 흐름 (4 섹션 트랙) 작성 checklist

> 본 skill 은 `development/ARCHITECTURE.md` § 7.4 '가벼운 흐름 (4 섹션 트랙)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.

v8.1_meta-lightweight-flow-design 에서 도입. harness-meta 의 정체성 = **harness engineering 컨설턴트** — 9-stage 무거운 절차는 '고객 납품물 (방법론·도구) 변경 = 큰 건' 전용이고, 작은 자기-운영 작업은 **4 섹션 한 장** 으로 충분하다. 본 skill 은 가벼운 흐름 진행 시 forcing function — schema template + 승격 판단 checklist 만 제공, 실제 narrative 는 LLM at runtime.

## 입력

> ★ 첫 게이트 = **승격 판단** (어느 트랙인가). 컨설팅 자산 (방법론·도구·외부 제공물) 에 영향 가면 큰 건 → **9-stage 로 가라** (본 skill 중단, `skills/stage-open/` 진입). 내부·작은 조정 (좁은 mechanical 수정, 기존 자산 보강) 이면 가벼운 흐름 진행.

| 판단 축 | 판정 |
|---|---|
| era 신설 / ROADMAP schema 변경 / 9-stage 단어 정의 변경 / smoke 판정 로직 재설계 | ❌ 큰 건 → 9-stage |
| 새 skill·agent·hook·command (컨설팅 자산) 추가 | ❌ 큰 건 → 9-stage |
| 기존 skill/docs 1~2 줄 보강 / 좁은 mechanical 수정 / 자기 장부정리 | ✅ 가벼운 흐름 |

읽을 곳:

- `development/ARCHITECTURE.md` § 7.4 — 가벼운 흐름 정의 + 승격 기준 worked example + LIGHTWEIGHT.md template (1차 source)
- `development/ROADMAP.md` (meta) 또는 `projects/<name>/ROADMAP.md` (외부) — `next_candidates[]` 안 본 candidate (있으면)

## 작성할 것

### 1. milestone 디렉토리 생성

```
development/milestones/v{X.Y}/        # meta
projects/<name>/milestones/v{X.Y}/    # 외부 프로젝트 (parametrize)
```

- `v{X.Y}` = semver 단조 증가 (직전 milestone + 1)
- 디렉토리 명 정합 = `^v\d+\.\d+$` (밑줄 부재). `MILESTONE.md` 는 만들지 않음 (LIGHTWEIGHT.md 단일 본책 — era 식별 `4-section-lightweight`).

### 2. LIGHTWEIGHT.md 작성 (4 섹션)

```yaml
---
id: {kebab-case-slug}
title: {≤ 60자 + Active form 본질 동사 종결 + 한 본질, § 7.2 정합}
version: v{X.Y}
status: {draft|completed}
---

# v{X.Y} — {title}

## 문제
(무엇이 문제/필요인가 — origin + 좁은 scope 1~2 문단)

## 결정
(어떻게 할지 결정 + 근거. 큰 건임이 드러나면 여기서 멈추고 9-stage 로 승격)

## 적용
(실 변경 list + commit SHA. 9-stage execute/phase-{n}.md 의 압축형)

## 기록
(검증 결과 + 교훈 + 후속 자연. 9-stage VERIFY+REPORT+PROPOSE 의 압축형)
```

frontmatter 필드:

- `id`: kebab-case-slug (regex `^[a-z0-9-]+$`).
- `title`: ≤ 60자 (한국어 codepoint) + Active form 본질 동사 종결 (`정리` / `보강` / `갱신` 등) + 한 본질 (' + ' literal 부재, § 7.2).
- `version`: `v{X.Y}` semver (regex `^v\d+\.\d+$`).
- `status`: `draft` (진행 중) → `completed` (## 기록 작성 후).

H2 4 섹션 = `## 문제` / `## 결정` / `## 적용` / `## 기록` (순서 의무, 단어 fidelity). 9-stage 대비 압축 매핑 — 문제 ≈ INTENT, 결정 ≈ RESEARCH+DESIGN+APPROVE, 적용 ≈ EXECUTE, 기록 ≈ VERIFY+REPORT+PROPOSE.

### 3. ROADMAP entry 추가

`development/ROADMAP.md` (meta) 또는 `projects/<name>/ROADMAP.md` (외부) 안 `milestones[]` 첫 위치에 entry append:

```json
{
  "version": "v{X.Y}",
  "id": "{kebab-case-slug}",
  "title": "{title}",
  "status": "completed",
  "trigger": "{A_user|B_regression|D_design}",
  "milestones_path": "milestones/v{X.Y}/LIGHTWEIGHT.md",
  "summary": "{가벼운 흐름 — origin + 결정 + 결과 압축}"
}
```

`milestones_path` = `milestones/v{X.Y}/LIGHTWEIGHT.md` (anchor 부재 — sub-milestone 없음). 추가 후 `updated` 필드 갱신.

### 4. commit

CLAUDE.md root § 개발 프로세스 정합 — `repo 변경은 커밋 전 사용자 확인 필수`. conventional commits prefix. 가벼운 흐름도 git commit + ROADMAP entry 로 trace 보존 (`## 기록` 은 release-publish.yml `## REPORT` 자동 추출 대상 아님 — § 7.4 trace 편입 정합).

## 검증

```bash
bash tests/smoke-spec-verification.sh
bash tests/smoke-open-stage-discipline.sh
bash tests/smoke-bundle-trigger.sh
```

기대 결과 = 모두 PASS. spec-verification 이 LIGHTWEIGHT.md frontmatter 4 필드 + 4 섹션 (## 문제 / ## 결정 / ## 적용 / ## 기록) 존재 검증. open-stage-discipline 이 디렉토리 ↔ LIGHTWEIGHT.md 페어링 검증. bundle-trigger 가 ROADMAP entry milestones_path 형식 검증.

## 관련

1차 source narrative:

- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 7.4 — 가벼운 흐름 (4 섹션 트랙) + 두 갈래 공존 + 승격 기준 (1차 source)
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 6.1 — era 정책 (4-section-lightweight era 표지)
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 7.2 — Entry title 가이드 (4 원칙)
- [`development/ARCHITECTURE.md`](../../development/ARCHITECTURE.md) § 3.1 끝 — 정체성 (harness engineering 컨설턴트, 승격 기준 판단 축)

운영 가이드:

- [`CLAUDE.md`](../../CLAUDE.md) (root) § 워크플로우 — 두 갈래 공존 (큰 건 9-stage / 작은 건 가벼운 흐름)
- 큰 건 (9-stage) 진입 = `skills/stage-open/` (가벼운 흐름이 아닌 경우)

도그푸드 1차 evidence:

- `development/milestones/v8.2/LIGHTWEIGHT.md` — 첫 가벼운 흐름 산출물 (deferred v1.5 해소, phase-2 생성)
