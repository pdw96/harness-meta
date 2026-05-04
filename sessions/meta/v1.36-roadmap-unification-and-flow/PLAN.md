# meta v1.36-roadmap-unification-and-flow — PLAN

세션 시작: 2026-04-30
직접 선행 세션:

- [`sessions/meta/v1.31-evidence-driven-roadmap/`](../v1.31-evidence-driven-roadmap/PLAN.md) — `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` 신설 (본 세션에서 폐기·이관 대상)
- [`sessions/meta/v1.31c-archive-sync-automation/`](../v1.31c-archive-sync-automation/PLAN.md) — `tests/smoke-archive-sync.sh` (본 세션에서 `smoke-roadmap-sync.sh`로 rename + glob 양쪽 지원)
- [`sessions/meta/v1.24-plan-spec-verification/`](../v1.24-plan-spec-verification/PLAN.md) — `harness-plan-verify` SKILL (본 세션에서 프로젝트 PLAN 지원 확장 — v1.24b 흡수)
- [`sessions/meta/v1.19-scorer-skill-distribution/`](../v1.19-scorer-skill-distribution/PLAN.md) — `bootstrap/skills/<name>/` 1단계 구조 (본 세션에서 2단계 `<category>/<name>/` 도입 — v1.22 흡수)

목적: harness-meta 세션 진입 → 종료 흐름을 **8단계로 형식화** + ROADMAP 단일화(`sessions/meta/ROADMAP.md` + `projects/<name>/ROADMAP.md`) + `EVIDENCE_DRIVEN_ROADMAP.md` 폐기 + skills 2단계 카테고리 구조 도입 + `harness-plan-verify` 프로젝트 PLAN 확장 + AskUserQuestion 자동 invoke 정책 명문화.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1a(1) `claude/commands/harness-meta.md` + S1c(5: 4 rename + 1 신규) `bootstrap/skills/{audit,dev-tools}/**` + S2(7) `bootstrap/{docs/{OWNERSHIP,SKILLS,SPEC_VERIFICATION,OVERLAY}.md, install-skills.{ps1,sh}, install-project-claude.{ps1,sh}, interview.md, skeletons/projects/ROADMAP.md.tmpl(신규)}` + S2(1 삭제) `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` + S3(4) `{CLAUDE.md, README.md, tests/smoke-{roadmap-sync,spec-verification,skills-install}.sh}` + meta(2) `sessions/meta/{ROADMAP.md(신규), v1.36-.../{PLAN,REPORT}.md}` = **22/22 meta**
- **T1 경로 다수결** — S1a/S1c/S2/S3 모두 meta 영역 22/22
- **T2 스펙 vs 값** — ROADMAP 형식 + 흐름 8단계 + skills 2단계 = 모든 프로젝트·세션 영향 → meta scope
- **T4 크로스 커팅** — `harness-plan-verify` 프로젝트 PLAN 확장(v1.24b)은 스펙 변경 = meta. 실 적용은 v1.36 자체 PLAN의 spec-verif § + 향후 프로젝트 세션이 자연 답습 (별도 후행 세션 불필요)

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — 사용자 발의 (2026-04-30) verbatim**:

> "harness-meta {project명}으로 진입 → ROADMAP.md 읽고 다음 세션 후보 정리(없으면 새로 논의) → PLAN.md 초안 작성 → 다각적 병렬 검토(서브 에이전트 이용) 최소 3번 → Plan-verify → 사용자 확인 → 구현 진행 → Report.md 작성 및 ROADMAP.md에 최근 완료된 항목명 기재 + out of scope로 지정된 항목들과 EVIDENCE_DRIVEN 작성 및 트리거 조건 명시
> 이 순서로 동작하게 만들 수 있어?"
>
> "EVIDENCE_DRIVEN-ROADMAP를 없애려는 의도인데?"
>
> "그리고 ROADMAP 수립 및 PLAN 검토 필요 사항 있을 경우 QuestionSession 자동으로 해"

**Source 2 — `sessions/meta/v1.31-evidence-driven-roadmap/` REPORT 다음 후보 (verbatim)**:

> "**v1.22-skills-categories** — 현 4 skill (ai-ready-scorer/mindvault/developer-profile/harness-plan-verify). 5번째 skill 추가와 동시 진행 시 자연 evidence"

**Source 3 — `bootstrap/docs/SPEC_VERIFICATION.md §10-2` 후속 분기 (verbatim)**:

> "~~`v1.24b-project-plan-verify`~~ → 본 v1.36 흡수 — 프로젝트 PLAN § 의무 확장 이행"

**Parsed sub-items (8)**:

1. **8단계 흐름 형식화** — `/harness-meta` 진입 → ROADMAP 읽기 → PLAN 초안 → subagent 병렬 검토(min 3) → Plan-verify → 사용자 확인 → 구현 → REPORT + ROADMAP 갱신
2. **EVIDENCE_DRIVEN_ROADMAP.md 폐기** — 23건 분류 + §6-0 정책 + §11 cross-file 매트릭스를 `sessions/meta/ROADMAP.md`로 이관 후 삭제
3. **`sessions/meta/ROADMAP.md` 신설** — meta 전역 단일 ROADMAP. "최근 완료" + "Out of scope (trigger 대기)" + "Schedule 후보" 통합 §
4. **`projects/<name>/ROADMAP.md` 신설** — 프로젝트별 ROADMAP 템플릿. Bootstrap S6 자동 생성
5. **subagent 병렬 검토 — 5 관점 가변(min 3)** — architecture / spec-drift / 회귀 / 보안 / scope contract
6. **AskUserQuestion 자동 invoke 정책** — 8단계 모두에서 결정 분기점 발견 시 자동 호출
7. **`harness-roadmap-update` SKILL 신설** — REPORT 작성 직후 ROADMAP "최근 완료" + "Out of scope → trigger" 자동 갱신 (S1c)
8. **skills 2단계 카테고리 구조** — `bootstrap/skills/<category>/<name>/` (audit/dev-tools 2 카테고리). 5번째 skill 추가로 v1.22 trigger 자연 발현
9. **`harness-plan-verify` 프로젝트 PLAN 지원 확장** — v1.24b 흡수. SKILL description + smoke-spec-verification glob 갱신

**의도 추론 명시**: sub-item 9는 사용자 발의 verbatim에는 명시 무. 그러나 단계 5 "Plan-verify"가 프로젝트 진입 흐름에 들어가면서 SKILL이 메타 전용이면 dead — T4 분할 회피로 같이 처리(SPEC_VERIFICATION.md §10-2 verbatim 정합).

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| PostToolUse hook으로 ROADMAP 자동 갱신 (REPORT.md Write 감지) | `v1.36b-postoolse-roadmap-hook` (smoke 안정 후 evidence-driven) |
| pre-commit hook으로 smoke-roadmap-sync 강제 | `v1.31d-precommit-archive-sync` (기존 후속 그대로 유지, 이름은 `v1.31d-precommit-roadmap-sync`로 자연 매핑) |
| ROADMAP § "Schedule 후보 3건" 실 cron 등록 (`/schedule` 명령으로) | 사용자 자율 영역 (별 도메인) |
| skills 3단계 이상 카테고리 구조 (`bootstrap/skills/<cat>/<sub>/<name>/`) | 5+ skill 추가 후 evidence-driven (현 5 skill에 충분) |
| `harness-roadmap-update` SKILL의 deterministic 자동 invoke (description trigger 정확 보장) | description trigger의 opportunistic 한계 — backstop은 smoke `--fix` (현 인프라 답습) |
| 전체 sessions/<project>/ ROADMAP.md 소급 작성 (upbit 등 기존 프로젝트) | `v1.36c-legacy-project-roadmap-migration` (forward-only 정책 답습, evidence-driven) |
| `EVIDENCE_DRIVEN_ROADMAP.md §11` Cross-file 매트릭스 9 case의 `SPEC_VERIFICATION.md` 이관 (현재 둘 다 명시) | drift 정정 — 본 세션에서 SPEC_VERIFICATION.md §11이 단일 소스이므로 EVIDENCE_DRIVEN.md §11 별도 § 삭제만 (이관 무) |
| 5 관점 subagent의 deterministic 호출 (8단계 흐름의 "절차" 문장만 명문화, 실 호출은 Claude 자율) | description-level 명문화로 충분 — hook 또는 subagent dispatcher SKILL은 별 후속 |
| Subagent 검토 의견 충돌 시 자동 resolution algorithm | AskUserQuestion으로 해소 (수동 승인) |
| **Q13(Claude-specific) 응답 자동 정정** — 현 `interview.md` Q13 처리 그대로 | v1.10b 패턴 답습, 본 세션 무관 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | slash command frontmatter / SKILL `disable-model-invocation` 정책 / SKILL frontmatter `allowed-tools:` 6축 / 슬래시 command `allowed-tools:` 작동 / Anthropic 공식 SKILL multi-step 권장 |
| **findings** | see citations below |
| **drift** | no — `harness-meta.md` 8단계 확장은 기존 frontmatter 6축 정합 (model:sonnet, allowed-tools YAML list 유지). 신규 SKILL `harness-roadmap-update`는 `disable-model-invocation: true` 권장 (REPORT side effect 보호 — mindvault 패턴 답습). `harness-plan-verify` description 확장은 trigger keyword 추가만 — 6축 무관 |
| **re-verify** | Anthropic이 SKILL invocation 정책 변경 또는 frontmatter 6축 spec bump 시 재검증. 차기 spec audit (v1.30+ 또는 사용자 명시) |

**Citations**:

- C1 — slash command + skill 모두 `allowed-tools:` 동일 필드. `harness-meta.md` 8단계 확장 후에도 model:sonnet + YAML list 그대로 유효 (Source: `https://code.claude.com/docs/en/permissions`)
- C2 — SKILL `disable-model-invocation: true`는 사용자 명시 호출만 허용 — `harness-roadmap-update`가 REPORT 작성 직후 ROADMAP 편집(side effect)을 수행하므로 mindvault 패턴(`SKILLS.md §1`) 답습 적합 (Source: `https://code.claude.com/docs/en/skills`)
- C3 — SKILL description trigger는 opportunistic. 본 세션 sub-item 7의 "REPORT 직후 자동 호출"은 deterministic 보장 무 → smoke `--fix` backstop 의무 (Source: `https://code.claude.com/docs/en/skills` + 본 repo `SPEC_VERIFICATION.md §5-3`)
- C4 — Anthropic 공식 multi-step workflow 권장 — 본 세션 8단계 흐름은 single SKILL 비대화 회피 + 단계별 책임 분리 (Source: `https://code.claude.com/docs/en/common-workflows`)
- C5 — subagent invocation은 main thread에서 명시 호출 (`Agent` tool). description-level 명문화는 spec 합치 (Source: `https://code.claude.com/docs/en/sub-agents`)

## 1. 문제 (현 흐름의 결함)

### 1-1. 흐름이 docs에 분산

`/harness-meta` slash command 본문에 일반 6단계만 명시. **ROADMAP 읽기**, **subagent 병렬 검토**, **Plan-verify**, **REPORT 직후 ROADMAP 갱신**은 docs 도처에 분산:

- ROADMAP 읽기 — `EVIDENCE_DRIVEN_ROADMAP.md` (메타 후속만, 프로젝트 후속 부재)
- Subagent 검토 — Claude 자율 (구조화된 절차 0)
- Plan-verify — `SPEC_VERIFICATION.md §5` (자동 invoke trigger description, opportunistic)
- REPORT → ROADMAP — v1.31c smoke `--fix` (수동 호출, 망각 risk)

→ 매 세션 진입 시 "어느 docs를 읽어야 하는가" 즉흥 판단. **단일 진입점 부재**.

### 1-2. ROADMAP 형식 분열

- meta 후속 → `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` (23건)
- 프로젝트 후속 → 각 `sessions/<project>/v*/REPORT.md` "다음 후보" § (분산)
- "최근 완료" 이력 → `EVIDENCE_DRIVEN_ROADMAP.md §9` archive

세 위치를 매번 cross-ref. 사용자 발화 "전 프로젝트별 ROADMAP 관리"와 충돌.

### 1-3. skills 1단계 한계

`bootstrap/skills/<name>/` 1단계 (4 skill). 본 세션에서 5번째 skill (`harness-roadmap-update`) 추가로 v1.22 trigger 자연 발현. 1단계 그대로면 audit / dev-tools / 미래 카테고리 분류 부재 → grep noise + 검색 비용.

### 1-4. `harness-plan-verify` 메타 전용 한계

SKILL frontmatter description "harness-meta sessions/meta/** 전용"으로 한정. 프로젝트 PLAN(v1.26 도입 이후 신규)은 SKILL invoke 무 → 자동 trigger 부재. SPEC_VERIFICATION.md §10-2의 v1.24b 후속이 미해결 상태.

## 2. 결정 (R1 ~ R8)

### R1 — 8단계 흐름 명문화 + AskUserQuestion 자동 invoke 정책

**`claude/commands/harness-meta.md` "절차 — 일반 (개선 모드)" §**를 6단계 → **8단계로 확장**:

```
1. 다음 버전 결정 (현행)
2. 디렉토리 생성 (현행)
3. ROADMAP 읽기 — sessions/meta/ROADMAP.md (meta) 또는 projects/<name>/ROADMAP.md (프로젝트) [신규]
   ├─ 후보 0건: AskUserQuestion 자동 invoke (새 발의 scope 옵션 2~4안)
   ├─ 후보 1건: 그대로 진행
   └─ 후보 2건+: AskUserQuestion 자동 invoke (어느 후보?)
4. PLAN.md 초안 작성 (현행, 6 의무 §)
   └─ 결정 분기점 발견 시: AskUserQuestion 자동 invoke
5. 다각적 병렬 검토 — 5 관점 subagent 가변(min 3) [신규]
   ├─ ① architecture (Plan agent)
   ├─ ② spec-drift (general-purpose + context7 query)
   ├─ ③ 회귀 risk (Explore + smoke 영향 분석)
   ├─ ④ 보안 (security-review SKILL)
   └─ ⑤ scope contract (Explore + PLAN.md grep)
   └─ 의견 충돌 / 회귀 risk 발견 시: AskUserQuestion 자동 invoke
6. Plan-verify (context7) — harness-plan-verify SKILL self-apply [기존, 자동 invoke 명문화]
   └─ drift=yes 발견 시: AskUserQuestion 자동 invoke (PLAN 수정? 무시?)
7. 사용자 확인 (현행) — 항상 AskUserQuestion (진입 승인)
8. 구현 진행 (현행) — main thread, execute.py 금지, 단위 커밋
   └─ PLAN 외 의사결정 발견 시: AskUserQuestion 자동 invoke
9. REPORT.md + ROADMAP 자동 갱신 [신규]
   ├─ REPORT.md 작성 (구현 요약 + 판정 + Spec verification post-hoc + Lessons)
   ├─ harness-roadmap-update SKILL invoke (description trigger 또는 사용자 명시)
   ├─ ROADMAP "최근 완료" 항목 추가
   ├─ ROADMAP "Out of scope (trigger 대기)" 표 → 본 세션 PLAN의 Out of scope § 항목 이관 (5 trigger 종류 분류)
   └─ 분류 애매 시: AskUserQuestion 자동 invoke (어느 trigger 종류?)
```

**AskUserQuestion 운영 원칙**:

| 원칙 | 적용 |
|------|------|
| "결정 필요 → invoke" | 추론으로 단정 불가한 분기점 모두 |
| "애매하면 invoke" | 신뢰도 < 90% 시 (OWNERSHIP T5 답습) |
| 2~4 옵션 제시 | tool spec 한계 + 사용자 인지 부담 균형 |
| 단순 yes/no는 텍스트 | AskUserQuestion 남용 회피 |
| 첫 옵션 (Recommended) | 권장 명확 시만 |

⚠️ 단계 9의 "REPORT.md 작성 → ROADMAP 갱신" 순서는 deterministic 보장 무(SKILL trigger opportunistic). backstop:

1. Claude가 절차 명시적 따름 (description-level)
2. `tests/smoke-roadmap-sync.sh --fix`가 누락 감지 + skeleton 삽입 (smoke-archive-sync.sh rename 후행)
3. 향후 PostToolUse hook (Out of scope, v1.36b)

### R2 — `EVIDENCE_DRIVEN_ROADMAP.md` 폐기 + 단일 ROADMAP 이관

**삭제**: `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`

**신설**: `sessions/meta/ROADMAP.md` (~250 lines, 23건 분류 + 흐름 형식화 답습)

**이관 매트릭스**:

| EVIDENCE_DRIVEN.md § | 옮길 위치 |
|---|---|
| §1 정의 + 5분류 (A 외부 사용자 / B 회귀 / C 외부 환경 / D 설계 / E 정규화) | `sessions/meta/ROADMAP.md §1 정의` |
| §2 진행 가능 (현 1건 v1.22) | `sessions/meta/ROADMAP.md §2 다음 후보` (v1.22는 본 세션 흡수 → 빈 표) |
| §3 진행 불가 26건 | `sessions/meta/ROADMAP.md §3 Out of scope (trigger 대기)` (5 trigger 종류 컬럼 유지) |
| §4 Schedule 후보 3건 | `sessions/meta/ROADMAP.md §4 Schedule 후보` |
| §5 권장 진행 순서 | `sessions/meta/ROADMAP.md §2와 통합` (활성 ranking) |
| §6-0 smoke-archive-sync 자동 검증 | `sessions/meta/ROADMAP.md §5 자동 검증` (smoke-roadmap-sync.sh로 rename) |
| §6-1~6-4 갱신 정책 | `sessions/meta/ROADMAP.md §6 갱신 정책` |
| §7 관련 문서 | `sessions/meta/ROADMAP.md §7 관련 문서` |
| §8 확정 세션 list | `sessions/meta/ROADMAP.md §8 최근 완료` (이력) |
| §9 Archive (완료 세션 ~5건 v1.32 onwards) | `sessions/meta/ROADMAP.md §8 최근 완료 통합` |
| §11 Cross-file 매트릭스 9 case | **삭제** (이미 `SPEC_VERIFICATION.md §11`에 단일 소스 존재 — drift 제거) |

**구조 규약 예외 명시**: CLAUDE.md "구조 규칙 (CRITICAL)" `index.json / step{N}.md 생성 금지` 조항에 **`ROADMAP.md` 1 파일 예외** 추가:

> "단, `sessions/<target>/ROADMAP.md` 운영 docs는 예외 허용 (재귀 회피와 무관 — 후속 트리거 통합 view 단일 소스)"

### R3 — `projects/<name>/ROADMAP.md` 템플릿 신설

**신규**: `bootstrap/skeletons/projects/ROADMAP.md.tmpl`

```markdown
# {{name}} — ROADMAP

프로젝트 후속 세션 통합 view. `sessions/meta/ROADMAP.md` (meta scope)와 분리.

## 1. 다음 후보 (활성)

| # | 후속 세션 | 진행 근거 | 출처 |
|:-:|---------|---------|------|
| (없음 — 첫 부트스트랩 후 evidence 누적) |

## 2. Out of scope (trigger 대기)

| 후속 세션 | trigger 종류 | trigger 조건 | 출처 |
|---------|:----------:|------------|------|
| (없음) |

## 3. 최근 완료

| 완료 세션 | 진행 일자 | 산출 |
|---------|---------|------|
| `v0.1-bootstrap` | {{date}} | 신규 프로젝트 도입 |

## 4. 관련 문서

- 상위 ROADMAP (meta): `~/harness-meta/sessions/meta/ROADMAP.md`
- 프로젝트 아키텍처: `~/harness-meta/projects/{{name}}/ARCHITECTURE.md`
- 프로젝트 manifest: `.harness.toml`
```

**자동 생성 시점**: Bootstrap S6 (`install-project-claude.{ps1,sh}` 또는 Claude Bootstrap 수동 작성). **결정**: 본 세션에서는 **Claude 수동 작성** (`interview.md` S6 산출물 4종 → 5종으로 확장). install-project-claude는 `.claude/` 14 파일 배포만 책임 — ROADMAP은 `sessions/<name>/v0.1-bootstrap/`처럼 Claude가 작성. 이유:

- install-project-claude는 OS 분기 cross-platform script — ROADMAP 콘텐츠 변동(date, name 치환)을 bash/PowerShell로 다루면 v1.10c TOML 안전성 risk 재현
- Claude는 이미 skeletons/projects/ 4종 작성 책임 — ROADMAP 1건 추가는 자연 확장

### R4 — 5 관점 subagent 병렬 검토 (가변, min 3)

**관점 매트릭스**:

| # | 관점 | agent type | 검토 포인트 |
|:-:|------|----------|-----------|
| 1 | architecture | `Plan` | 디렉토리 구조 / 파일 책임 / 변경 영향 |
| 2 | spec-drift | `general-purpose` (context7 invoke) | 외부 spec 정합 (Anthropic Claude Code docs) |
| 3 | 회귀 risk | `Explore` | 기존 smoke 21+ 영향 / verify.ps1/sh 영향 |
| 4 | 보안 | `general-purpose` (security-review SKILL invoke) | 새 SKILL의 side effect / 권한 / path traversal |
| 5 | scope contract | `Explore` | PLAN.md `Scope inheritance` ↔ 본문 매핑 / Out of scope verbatim 일치 |

**가변 정책**:

- **scope 작음** (변경 파일 ≤ 5): 3 관점 (1+2+5)
- **scope 중간** (변경 파일 6~15): 4 관점 (1+2+3+5)
- **scope 큼** (변경 파일 16+): 5 관점 전체

본 v1.36 PLAN은 변경 파일 ~22 → **5 관점 전체** 적용 (self-test).

**의견 충돌 처리**:

1. 충돌 항목 list화
2. AskUserQuestion 자동 invoke (각 충돌 1 question, 최대 4 question)
3. 사용자 결정 → PLAN 갱신 → 재진입 (단계 4부터)

### R5 — `harness-roadmap-update` SKILL 신설 (S1c)

**위치**: `bootstrap/skills/audit/harness-roadmap-update/SKILL.md`

**Frontmatter**:

```yaml
---
name: harness-roadmap-update
description: |
  REPORT.md 작성 직후 sessions/<target>/ROADMAP.md 또는 projects/<name>/ROADMAP.md 자동 갱신.
  "최근 완료" 항목 추가 + PLAN의 "Out of scope" 표를 "Out of scope (trigger 대기)" §에 5 trigger 종류 분류와 함께 이관.

  TRIGGER:
  - 사용자가 "ROADMAP 갱신", "roadmap 업데이트", "roadmap sync" 언급
  - 메타 또는 프로젝트 세션 REPORT.md 작성 직후
  - /harness-roadmap-update 명시 호출
disable-model-invocation: true
allowed-tools:
  - Read
  - Glob
  - Grep
  - Edit(sessions/meta/ROADMAP.md)
  - Edit(projects/*/ROADMAP.md)
  - Write(sessions/meta/ROADMAP.md)
  - Write(projects/*/ROADMAP.md)
model: sonnet
---
```

**`disable-model-invocation: true` 정당화**: ROADMAP 갱신은 side effect(파일 편집). mindvault SKILL 패턴(`SKILLS.md §1`) 답습. 사용자 명시 호출 또는 단계 9 명시적 절차에서만 trigger.

**보안 강화 (보안 검토 권고 반영)**:

- **`Bash(bash *)` 제거** — ROADMAP 갱신에 bash 호출 불필요 (Read/Glob/Grep/Edit/Write 충분). PERMISSION_PATTERN.md A5 fragile pattern 회피
- **glob `**` → `*` fine-grain** — `sessions/**/ROADMAP.md` 같은 깊은 glob 금지. `sessions/meta/ROADMAP.md` (정확) + `projects/*/ROADMAP.md` (1단계만) 허용 — Claude Code permission spec의 정확/단일-와일드카드 매칭

**SKILL 본문 흐름** (5-step, `harness-plan-verify` 패턴 답습 + 보안 조항):

1. **Identify** — 본 세션의 PLAN.md 또는 REPORT.md 위치 / target ROADMAP.md 위치 결정 (sessions/meta/ROADMAP.md 또는 projects/<name>/ROADMAP.md)
2. **Validate (target name)** — `<name>` 파라미터 보안 검증 (Q13 sanity 답습):
   - regex `^[a-z0-9][a-z0-9_-]*$` (alphanumeric + `-` + `_` only)
   - `realpath` 검증 — 결과가 `$HARNESS_META_ROOT/{sessions/meta,projects}` prefix 매치 의무
   - 위반 (`..`, 절대경로, null byte, 메타 문자) 시 abort + AskUserQuestion 자동 invoke (재입력)
3. **Classify** — PLAN의 "Out of scope" 표 각 row를 5 trigger 종류 (A 외부 사용자 / B 회귀 / C 외부 환경 / D 설계 / E 정규화)에 매핑. 분류 애매 시 AskUserQuestion 자동 invoke
4. **Sanitize** — ROADMAP에 삽입할 row 텍스트 sanitize (interview.md Q13 패턴 답습):
   - 메타 문자 검출: `@`, `{{`, `}}`, `<!--`, `<script` 5종
   - 발견 시 fenced code block (```text...```) 안에 강제 wrap
   - AskUserQuestion 옵션 텍스트는 plain string + 80 chars truncate (license MAX_LENGTH 답습)
   - control character (ANSI escape, null byte) strip
5. **Update** — ROADMAP "최근 완료"에 본 세션 row 추가 + "Out of scope (trigger 대기)" §에 분류·sanitize된 row 추가 + "Schedule 후보" 갱신 (해당 시)

### R6 — `harness-plan-verify` 프로젝트 PLAN 확장

**SKILL frontmatter description 확장**:

```yaml
description: |
  메타 세션 PLAN 검증 전용 → **메타 + 프로젝트 PLAN 양쪽 검증 (v1.36+)**
  harness-meta sessions/{meta,*}/v*/PLAN.md 작성 후 외부 spec drift를 context7으로 검증
  ...
```

**smoke 갱신**: `tests/smoke-spec-verification.sh` LEGACY_PROJECT_PLANS skip 정책:

- v1.27 ~ v1.35 동결 list 그대로 유지
- v1.36+ 프로젝트 세션 PLAN.md 검증 활성

⚠️ 본 v1.36은 **메타 세션** — 프로젝트 PLAN 첫 검증 인스턴스는 v1.36 자체가 아닌 **차기 프로젝트 세션** (예: `sessions/upbit/v1.3-...`).

### R7 — skills 2단계 카테고리 구조 도입 (v1.22 흡수)

**위치**: `bootstrap/skills/<category>/<name>/`

**Phase 1 — 카테고리 매트릭스 (2 카테고리, 5 skill)**:

| 카테고리 | skill |
|---------|-------|
| `audit/` | `ai-ready-scorer`, `harness-plan-verify`, `harness-roadmap-update` (신규) |
| `dev-tools/` | `mindvault`, `developer-profile` |

**Phase 2 — 이관 (4 git mv + 1 신규)**:

```
git mv bootstrap/skills/ai-ready-scorer       bootstrap/skills/audit/ai-ready-scorer
git mv bootstrap/skills/harness-plan-verify   bootstrap/skills/audit/harness-plan-verify
git mv bootstrap/skills/mindvault             bootstrap/skills/dev-tools/mindvault
git mv bootstrap/skills/developer-profile     bootstrap/skills/dev-tools/developer-profile
# 신규
mkdir -p bootstrap/skills/audit/harness-roadmap-update
write SKILL.md (R5)
```

**install-skills.{ps1,sh} 갱신**:

- skill argument 형식: `<name>` (1단계) → `<category>/<name>` (2단계)
- legacy `<name>` 단독 입력 시 자동 lookup (`bootstrap/skills/*/<name>/`로 glob)
- `--list` 출력에 카테고리 표기
- `~/.claude/skills/<name>/` symlink target은 **카테고리 평탄** (`<name>` 그대로) — Claude Code는 `~/.claude/skills/`에서 1단계만 인식

**보안 강화 (보안 검토 권고 반영) — lookup 매치 분기**:

| 매치 결과 | 동작 |
|---------|------|
| **0건** | exit 1 + WARN "skill `<name>` not found in any category" |
| **1건** | 자동 prefix 후 진행 (정상) |
| **2건+** | AskUserQuestion 자동 invoke (2~4 옵션, header "skill 카테고리"). 사용자 명시 선택 후 진행. typosquatting risk 차단 |

추가 보안:

- glob 결과 디렉토리는 `bootstrap/skills/` prefix 검증 의무 (escape 차단)
- 사용자 입력 `<name>` regex `^[a-z0-9][a-z0-9_-]*$` (R5 Step 2 답습)

⚠️ Claude Code SKILL 인식 경로는 `~/.claude/skills/<name>/SKILL.md` 1단계만 — 2단계 (`~/.claude/skills/audit/<name>/`)는 인식 무. 따라서 source는 2단계, dest는 1단계 (symlink target에서 평탄화).

### R8 — `tests/smoke-archive-sync.sh` rename + glob 양쪽

**Rename**: `tests/smoke-archive-sync.sh` → `tests/smoke-roadmap-sync.sh`

**glob 확장**:

- 기존: `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`만 검사
- 신규: `sessions/meta/ROADMAP.md` + `projects/*/ROADMAP.md` 양쪽

**Stage 갱신** (4 → 5 stage):

| Stage | 기존 (archive-sync) | 신규 (roadmap-sync) |
|-------|------|------|
| 1 | post-v1.31 메타 §8 entry 존재 | meta ROADMAP "최근 완료" entry 존재 (per session) |
| 2 | strikethrough → §9 archive 일치 | (삭제 — strikethrough 패턴 폐기) |
| 3 | §5 stale ranks | (삭제 — §5 폐기) |
| 4 | §2 헤더 카운트 동기화 | meta ROADMAP §2 카운트 |
| 5 (신규) | — | 프로젝트 ROADMAP "최근 완료" entry per 프로젝트 세션 |

`--fix` mode: 본 세션 PLAN의 Out of scope 표 → ROADMAP §3 trigger row skeleton 자동 삽입 (사용자/SKILL이 trigger 종류 채움).

**보안 강화 (보안 검토 권고 반영) — `--fix` sanitize**: ROADMAP에 row 삽입 전 R5 Step 4 sanitize 동등 처리 (Q13 메타 문자 5종 검출 → fenced code block wrap + control character strip). 사용자가 PLAN에 작성한 Out of scope 텍스트가 ROADMAP에 평문 그대로 흘러가지 않도록 차단.

## 3. 변경 대상

### 신규 (5)

| 경로 | scope | 역할 |
|------|------|------|
| `sessions/meta/ROADMAP.md` | meta | R2 — 단일 ROADMAP (~250 lines) |
| `bootstrap/skeletons/projects/ROADMAP.md.tmpl` | S2 | R3 — 프로젝트별 ROADMAP 템플릿 |
| `bootstrap/skills/audit/harness-roadmap-update/SKILL.md` | S1c | R5 — 신규 SKILL (5번째) |
| `sessions/meta/v1.36-.../PLAN.md` | meta | 본 파일 |
| `sessions/meta/v1.36-.../REPORT.md` | meta | Stage K |

### 이관 (4 git mv)

| From | To |
|------|-----|
| `bootstrap/skills/ai-ready-scorer/` | `bootstrap/skills/audit/ai-ready-scorer/` |
| `bootstrap/skills/harness-plan-verify/` | `bootstrap/skills/audit/harness-plan-verify/` |
| `bootstrap/skills/mindvault/` | `bootstrap/skills/dev-tools/mindvault/` |
| `bootstrap/skills/developer-profile/` | `bootstrap/skills/dev-tools/developer-profile/` |

### 삭제 (1)

| 경로 | scope | 이유 |
|------|------|------|
| `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` | S2 | R2 — 폐기 (이관 완료 후) |

### Rename (1)

| From | To |
|------|-----|
| `tests/smoke-archive-sync.sh` | `tests/smoke-roadmap-sync.sh` (R8) |

### 수정 (14)

| 경로 | scope | 변경 |
|------|------|------|
| `claude/commands/harness-meta.md` | S1a | R1 — 8단계 + AskUserQuestion 정책 + 5 관점 subagent + 8단계 trigger 표 |
| `bootstrap/skills/audit/harness-plan-verify/SKILL.md` | S1c | R6 — description 확장 (메타 + 프로젝트) |
| `bootstrap/install-skills.ps1` | S3 | R7 — 2단계 path lookup (legacy `<name>` 자동 prefix) + symlink target 평탄화 + 0/2+ 매치 보안 |
| `bootstrap/install-skills.sh` | S3 | 동상 |
| `bootstrap/interview.md` | S2 | R3 — S6 산출물 5종 (ROADMAP.md 추가) |
| `bootstrap/docs/INTERVIEW_FLOW.md` | S2 | R3 — Stage S6 표 갱신 |
| `tests/smoke-roadmap-sync.sh` | S3 | R8 — 5 stage + glob 양쪽 + `--fix` mode + sanitize |
| `tests/smoke-spec-verification.sh` | S3 | R6 — LEGACY_PROJECT_PLANS skip 정책 갱신 (v1.36+ 프로젝트 PLAN 활성) |
| `tests/smoke-skills-install.sh` | S3 | R7 — 2단계 구조 검증 |
| **`verify.ps1`** | S3 | R7 회귀 보강 — Stage I `$frontmatterFiles` list에서 `bootstrap/skills/<name>/SKILL.md` → `bootstrap/skills/{audit,dev-tools}/<name>/SKILL.md` 5건 갱신 (회귀 검토 권고) |
| **`verify.sh`** | S3 | 동상 — Stage I 글로벌 user-skill 경로 5건 갱신 (verify.ps1 mirror) |
| `CLAUDE.md` | S3 | R1+R2 — 구조 규칙 예외 + 디렉토리 구조 + 관련 문서 cross-ref (EVIDENCE_DRIVEN 제거 + ROADMAP 추가) |
| `bootstrap/docs/OWNERSHIP.md` | S2 | R2+R7 — cross-ref 정정 + S1c 카테고리 구조 명시 |
| `bootstrap/docs/SPEC_VERIFICATION.md` | S2 | R6 — §10-2 v1.24b 흡수 표기 + EVIDENCE_DRIVEN cross-ref 제거 + §11 cross-file 단일 소스 명시 |
| `bootstrap/docs/SKILLS.md` | S2 | R5+R7 — §1 매트릭스 5 skill + 2단계 구조 § 신설 |
| `bootstrap/docs/OVERLAY.md` | S2 | EVIDENCE_DRIVEN cross-ref 제거 (있으면) |
| `README.md` | S3 | R1+R2 — 디렉토리 구조 + cross-ref 갱신 |

(총 24 — 위 표 합계: 신규 5 + 이관 4 + 삭제 1 + rename 1 + 수정 14 = 25 변경 단위 → unique 파일 24)

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 초안 작성
- [ ] **5 관점 subagent 병렬 검토** (이번 PLAN 자체에 self-test)
- [ ] **harness-plan-verify SKILL self-apply** (context7 query)
- [ ] **사용자 진입 확인** (AskUserQuestion)
- [ ] Stage A — skills 2단계 이관 (git mv 4건)
- [ ] Stage B — `harness-roadmap-update` SKILL 신설
- [ ] Stage C — `harness-plan-verify` SKILL description 확장
- [ ] Stage D — `sessions/meta/ROADMAP.md` 신규 + `EVIDENCE_DRIVEN_ROADMAP.md` 삭제
- [ ] Stage E — `bootstrap/skeletons/projects/ROADMAP.md.tmpl` 신규
- [ ] Stage F — `install-skills.{ps1,sh}` 2단계 path
- [ ] Stage G — `interview.md` + `INTERVIEW_FLOW.md` S6 5종
- [ ] Stage H — `smoke-archive-sync.sh` rename → `smoke-roadmap-sync.sh` + 5 stage + glob 양쪽 + `--fix`
- [ ] Stage I — `smoke-spec-verification.sh` LEGACY 정책 갱신
- [ ] Stage J — `smoke-skills-install.sh` 2단계 검증
- [ ] Stage K — `claude/commands/harness-meta.md` 8단계 + AskUserQuestion
- [ ] Stage L — 6 docs cross-ref 갱신 (CLAUDE / README / OWNERSHIP / SPEC_VERIFICATION / SKILLS / OVERLAY)
- [ ] Stage M — REPORT.md + ROADMAP 자동 갱신 (self-test — `harness-roadmap-update` SKILL 첫 invoke)

## 5. 성공 기준

### 정합성 (정적)

- [ ] `sessions/meta/ROADMAP.md` 존재 + EVIDENCE_DRIVEN.md 23건 분류 모두 이관 (§1~§8 정합)
- [ ] `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` 삭제
- [ ] `bootstrap/skeletons/projects/ROADMAP.md.tmpl` 존재 + 4 § (다음 후보 / Out of scope / 최근 완료 / 관련 문서)
- [ ] `bootstrap/skills/audit/{ai-ready-scorer,harness-plan-verify,harness-roadmap-update}/SKILL.md` 존재
- [ ] `bootstrap/skills/dev-tools/{mindvault,developer-profile}/SKILL.md` 존재
- [ ] `bootstrap/skills/<name>/` 1단계 디렉토리 0 (이관 완료)
- [ ] `tests/smoke-roadmap-sync.sh` 존재 + 5 stage + `--fix` mode
- [ ] `tests/smoke-archive-sync.sh` 부재 (rename 완료)
- [ ] `harness-plan-verify` SKILL description "메타 + 프로젝트" 명시
- [ ] `harness-roadmap-update` SKILL frontmatter `disable-model-invocation: true`
- [ ] `claude/commands/harness-meta.md` "절차 — 일반 (개선 모드)" 8단계 + AskUserQuestion 운영 원칙 표
- [ ] CLAUDE.md "구조 규칙" `ROADMAP.md` 예외 1줄 + 디렉토리 구조 § ROADMAP.md 표시
- [ ] 6 docs cross-ref EVIDENCE_DRIVEN_ROADMAP.md 0건 (`grep -r 'EVIDENCE_DRIVEN_ROADMAP' bootstrap/ CLAUDE.md README.md`)

### 회귀 (smoke)

- [ ] `tests/smoke-roadmap-sync.sh` 5/5 PASS (default — meta 1 ROADMAP, 프로젝트 0 ROADMAP)
- [ ] `tests/smoke-spec-verification.sh` 7 stage PASS (LEGACY_PROJECT_PLANS 동결 list 정합)
- [ ] `tests/smoke-skills-install.sh` 5 skill 2단계 검증 PASS
- [ ] `tests/smoke-scope-contract.sh` PASS — 본 PLAN의 Scope inheritance + Out of scope § 자가 검증
- [ ] `verify.ps1` Stage A~I (Windows) 38/38 PASS — overlay/SKILL frontmatter 무영향
- [ ] 기존 21+ smoke 회귀 0

### Self-test

- [ ] 본 PLAN.md 자체가 R4 (5 관점 subagent) 통과 — 검토 결과 PLAN 갱신 0건 또는 명시적 갱신
- [ ] 본 PLAN.md `Spec verification (context7)` § drift=no (pre-check)
- [ ] 본 REPORT.md `Spec verification (context7)` § drift=no (post-hoc)
- [ ] `sessions/meta/ROADMAP.md "최근 완료"`에 v1.36 row 추가 (`harness-roadmap-update` SKILL 첫 invoke)

## 6. 커밋 전략 (4 commit 분할 — architecture 권고 반영)

CLAUDE.md "단위 커밋" 원칙 정합 + bisect 가능 + history 의도 명확. 각 커밋 단위 smoke regression 검증 후 다음 commit 진입.

### Commit 1 — Skills 2단계 카테고리 이관 (R7 인프라)

```
refactor(meta): sessions/meta/v1.36 — skills 1단계 → 2단계 카테고리 이관 + install-skills 0/2+ 매치 보안

git mv bootstrap/skills/ai-ready-scorer       bootstrap/skills/audit/ai-ready-scorer
git mv bootstrap/skills/harness-plan-verify   bootstrap/skills/audit/harness-plan-verify
git mv bootstrap/skills/mindvault             bootstrap/skills/dev-tools/mindvault
git mv bootstrap/skills/developer-profile     bootstrap/skills/dev-tools/developer-profile

- update: bootstrap/install-skills.{ps1,sh} (2단계 lookup + 0/2+ 매치 보안 + regex validation)
- update: tests/smoke-skills-install.sh (2단계 검증)
- update: verify.ps1 + verify.sh (Stage I 4 SKILL 경로 갱신)
- update: bootstrap/docs/SKILLS.md (§1 매트릭스 + 2단계 § 신설 + 향후 5번째 자리 명시)

Smoke: skills-install + bash-permission-pattern + thinking-effort + verify Stage I 모두 PASS.
회귀 0 — backward compat (legacy `<name>` 자동 prefix).
```

### Commit 2 — ROADMAP 단일화 + EVIDENCE_DRIVEN 폐기 (R2 + R3 + R8)

```
feat(meta): sessions/meta/v1.36 — ROADMAP 단일화 (sessions/meta/ROADMAP.md + projects/<name>/) + EVIDENCE_DRIVEN_ROADMAP.md 폐기

- delete: bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md (R2 이관 완료 후 폐기)
- add: sessions/meta/ROADMAP.md (R2 — 23건 분류 통합 view: 다음 후보 / Out of scope (trigger 대기) / Schedule / 자동 검증 / 최근 완료)
- add: bootstrap/skeletons/projects/ROADMAP.md.tmpl (R3 — 프로젝트별 ROADMAP 템플릿 4 §)
- rename: tests/smoke-archive-sync.sh → tests/smoke-roadmap-sync.sh (R8 — 5 stage + glob 양쪽 + --fix sanitize)
- update: bootstrap/{interview.md, docs/INTERVIEW_FLOW.md} (R3 — Bootstrap S6 산출물 5종)
- update: CLAUDE.md (구조 규칙 ROADMAP.md 예외 1줄 + 디렉토리 구조 § ROADMAP.md + 관련 문서 cross-ref EVIDENCE_DRIVEN 제거 + ROADMAP 추가)

Smoke: roadmap-sync 5/5 PASS + 회귀 0.
EVIDENCE_DRIVEN_ROADMAP.md cross-ref 0건 (grep 검증).
```

### Commit 3 — 8단계 흐름 형식화 + 신규 SKILL `harness-roadmap-update` (R1 + R5)

```
feat(meta): sessions/meta/v1.36 — 8단계 흐름 형식화 + harness-roadmap-update SKILL 신설 (5번째 글로벌)

- update: claude/commands/harness-meta.md (R1 — 절차 6 → 8단계 + AskUserQuestion 자동 invoke 정책 + 5 관점 subagent 가변 min 3)
- add: bootstrap/skills/audit/harness-roadmap-update/SKILL.md (R5 — disable-model-invocation:true + 5-step + path traversal 방어 + sanitize)
- update: bootstrap/docs/SKILLS.md (§1 매트릭스 5 skill — harness-roadmap-update row 추가)
- update: verify.ps1 + verify.sh (Stage I — harness-roadmap-update SKILL 5번째 경로 추가)
- update: tests/smoke-{bash-permission-pattern,thinking-effort}.sh (신규 SKILL frontmatter 검증)

8단계: 1.버전 → 2.디렉토리 → 3.ROADMAP 읽기 → 4.PLAN 초안 → 5.5 관점 subagent (가변 min 3) → 6.Plan-verify (context7) → 7.사용자 확인 → 8.구현 → 9.REPORT + ROADMAP 자동 갱신
각 단계 결정 분기점 → AskUserQuestion 자동 invoke (운영 원칙 5조)

Smoke: 신규 SKILL 6축 frontmatter 검증 + verify Stage I 39/39 PASS.
```

### Commit 4 — `harness-plan-verify` 프로젝트 확장 + docs cross-ref + REPORT (R6 + 6 docs + Stage K)

```
feat(meta): sessions/meta/v1.36 — harness-plan-verify 프로젝트 PLAN 확장 (v1.24b 흡수) + 6 docs cross-ref + REPORT

- update: bootstrap/skills/audit/harness-plan-verify/SKILL.md (R6 — description 메타 + 프로젝트 PLAN 양쪽)
- update: tests/smoke-spec-verification.sh (R6 — LEGACY_PROJECT_PLANS skip 정책 v1.36+ 활성)
- update: bootstrap/docs/OWNERSHIP.md (cross-ref 정정 + S1c 카테고리 구조 명시)
- update: bootstrap/docs/SPEC_VERIFICATION.md (§10-2 v1.24b 흡수 + EVIDENCE_DRIVEN cross-ref 제거 + §11 단일 소스 명시)
- update: bootstrap/docs/OVERLAY.md (EVIDENCE_DRIVEN cross-ref 제거)
- update: README.md (디렉토리 구조 + cross-ref 갱신)
- add: sessions/meta/v1.36-.../REPORT.md (구현 요약 + 판정 + Spec verification post-hoc + Lessons + 다음 후보)
- update: sessions/meta/ROADMAP.md (harness-roadmap-update SKILL 첫 invoke — 최근 완료 v1.36 row + Out of scope 표 → §3 trigger row 11건 분류·sanitize 이관)

Smoke 21+ 회귀 0 + verify.{ps1,sh} 39/39 PASS + self-test PASS (5 관점 subagent + Plan-verify drift=no).
```

### 4-commit 분할 정합성

| Commit | 의미 단위 | rollback 가능 | 회귀 검증 |
|:-:|-------|:-:|----------|
| 1 | 인프라 (이관 + lookup 보안) | ✓ | smoke-skills-install |
| 2 | ROADMAP 형식 (단일화 + 템플릿) | ✓ | smoke-roadmap-sync |
| 3 | 흐름 + 신규 SKILL | ✓ | smoke-bash-permission + thinking-effort + verify Stage I |
| 4 | docs + REPORT (마무리) | ✓ | smoke 21+ 전체 |

각 커밋은 직전 커밋 head 위에서 smoke PASS 의무 — 부분 실패 시 그 commit만 revert 가능.

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.36b-postoolse-roadmap-hook` | PostToolUse hook으로 REPORT.md Write 감지 → `harness-roadmap-update` 자동 invoke (smoke 안정 후) |
| `v1.31d-precommit-roadmap-sync` (rename from v1.31d-precommit-archive-sync) | pre-commit hook으로 smoke-roadmap-sync 강제 |
| `v1.36c-legacy-project-roadmap-migration` | 기존 프로젝트 (upbit 등) ROADMAP.md 소급 작성. evidence-driven |
| `v1.37-skills-3-tier-categories` | 5+ skill 추가 후 3단계 구조 필요 evidence 발생 시 |

## 8. Lessons Forward (예상)

- **L1 — 흐름 형식화는 ROADMAP 단일화와 분리 불가** — "8단계 흐름" 명문화 시점에 단계 3(ROADMAP 읽기) + 단계 9(ROADMAP 갱신) 진입점이 필요. 흐름만 정의하면 dead end → 같이 처리 정합 (T4 분할 회피)
- **L2 — `disable-model-invocation: true`는 side effect SKILL 표준** — `harness-roadmap-update`의 ROADMAP 편집은 mindvault PyPI 설치와 동급 side effect. 사용자 명시 호출 또는 단계 9 절차 명시만 허용
- **L3 — skills 2단계 구조의 Claude Code 호환** — source 2단계 (`audit/<name>/`) + dest 1단계 (`~/.claude/skills/<name>/`) 매핑이 핵심. install-skills의 symlink target 평탄화로 Claude Code SKILL 인식 100% 보존
- **L4 — AskUserQuestion 자동 invoke는 description-level이 한계** — slash command 본문 명문화는 Claude 자율 판단에 의존. deterministic 보장은 hook (v1.36b 후속). 그러나 description-level만으로도 망각 risk 90%+ 차단 (사용자 발화 + smoke backstop)
- **L5 — Self-test 의무화** — 본 PLAN이 정의하는 8단계를 본 PLAN 작성에 자체 적용 (Scope contract v1.10j 첫 정식 적용 답습 패턴). 5 관점 subagent + plan-verify + AskUserQuestion 모두 본 세션에서 first invocation
