---
name: harness-meta
description: 하네스 자체 개선 또는 프로젝트별 하네스 개선 세션 진입점 (9-stage workflow, 글로벌 harness-meta repo 기반)
argument-hint: "[project-name]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Write
  - Edit
  - Bash(mkdir *)
  - Bash(git *)
  - Bash(bash *)
  - Bash(pwsh *)
  - Bash(uname *)
  - Bash(mv *)
  - Bash(cp *)
  - Bash(rm *)
model: sonnet
---

하네스 관련 milestone을 시작한다. 프로젝트 기능 개발(`phases/`)과 **분리**된 별도 흐름으로,
**글로벌 harness-meta repo** (`~/harness-meta/`)에 9-stage 흐름으로 기록된다.

## 9-stage workflow (v2.0+) + bundling (v3.0+)

```
ROADMAP (입력 source) → OPEN → INTENT → RESEARCH → DESIGN → APPROVE → EXECUTE → VERIFY → REPORT → PROPOSE
```

각 stage = **단어 = 단일 책임 1:1 매핑** (v2.0_workflow-word-fidelity 정정). 상위 stage 산출물만 입력. 모든 산출물은 **Anthropic 정합 하이브리드 (YAML frontmatter + 축소 JSON + Markdown body, v6.1+)** 포맷 — 이전 v1.0~v6.0 = "MD + JSON 코드블록", v6.1 phase-2 안 active 28 milestone backfill 완료.

**v3.0+ 9-stage-bundled era** (v3.0_milestones-restructure 도입): 같은 의미 단위 (모듈 / 주제 / lessons_learned) 후속 candidates 는 version 단위 1 milestone 에 통합 — 디렉토리 `milestones/v{X.Y}/` (sub-id 부재) + `milestones.md` (sub-milestone listing per version) + INTENT/RESEARCH/DESIGN/APPROVE 통합 1건 + execute/phase-{n}.md (sub-milestone 1:1). 상세 bundling trigger 조건 + 자기참조 부합 + breaking change 정책: `~/harness-meta/projects/meta/ARCHITECTURE.md` § 6.1.

| Stage | 산출 파일 | 단어 책임 |
|:-:|---------|---------|
| (입력) ROADMAP | `~/harness-meta/projects/meta/ROADMAP.md` (meta) 또는 `~/harness-meta/projects/<name>/ROADMAP.md` (프로젝트) — root `~/harness-meta/ROADMAP.md` 는 thin index | milestone 목록 (id/title/status/summary/trigger) |
| A. OPEN | (디렉토리 생성) | 컨테이너 마운트 + ROADMAP entry `in_progress` |
| B. INTENT | `.../INTENT.md` | 의도 — goal / motivation / success_criteria / out_of_scope / dependencies |
| C. RESEARCH | `.../RESEARCH.md` | 조사 — external / codebase / options / risks_identified |
| D. DESIGN | `.../DESIGN.md` | 설계 — decisions / approach / phases / risk_mitigation + 5 관점 검토 |
| E. APPROVE | `.../APPROVE.md` | 사용자 명시 승인 게이트 — approved_by / date / approval_summary |
| F. EXECUTE | `.../execute/phase-{n}.md` | per-phase 구현 (1 phase = 1 commit, conventional commits) |
| G. VERIFY | `.../VERIFY.md` | 검증 — smoke / criteria_check vs INTENT / verdict |
| H. REPORT | `.../REPORT.md` | 종합 backward — summary / delta / lessons_learned |
| I. PROPOSE | `.../PROPOSE.md` | 후속 forward — next_candidates ROADMAP 등록 |

## 대상 구분

| 대상 | 경로 | 진입 조건 |
|------|------|---------|
| **메타 milestone** | v3.0+ 9-stage-bundled: `~/harness-meta/projects/meta/milestones/v{X.Y}/` (sub-id 부재) / v2.0~v2.1 9-stage 보존: `milestones/v{X.Y}_{slug}/` | argument 부재 또는 `meta` 또는 CWD=harness-meta |
| **프로젝트별 하네스 개선** | (프로젝트 repo) `milestones/v{X.Y}_{slug}/` | argument=`<name>` + `~/harness-meta/projects/<name>/` 존재 + `.harness.toml` 존재 |
| **신규 프로젝트 도입** | 첫 milestone의 EXECUTE phase에서 처리 | argument=`<name>` + `~/harness-meta/projects/<name>/` 또는 `.harness.toml` 부재 |

## 대상 결정

Argument로 프로젝트 명시: `/harness-meta <name>` (hyphen↔underscore 동치).
없으면 CWD basename을 target으로 간주.

- `<name>`이 `meta`이거나 현재 repo가 `harness-meta`면 → **repo 자체 개선 모드**
- `~/harness-meta/projects/<name>/` 존재 + `.harness.toml` 존재 → **프로젝트별 개선 모드**
- 둘 다 부재 → **신규 도입 모드** (사용자 확인 후 첫 milestone 시작)

## 절차

### Stage A — OPEN (컨테이너 마운트)

#### `--audit` opt-in 분기 (v4.0_harness-composer-pivot, 2026-05-13)

호출 시 `--audit` flag 명시 (`/harness-meta <name> --audit`) 시 Stage A entry 직후 conditional 분기 (D5) — v6.20_agent-type-syntax-adoption 정전화 후 audit-orchestrator agent 단일 invoke 본질:

```text
if (--audit flag present):
  → Agent(subagent_type="harness-meta:audit-orchestrator") 단일 invoke (v6.20 정전화 후)
  → audit-orchestrator agent 안 Step 1~6 통합 책임 수행 (frontmatter
     `tools: Agent(project-scanner, harness-gap-analyzer, claude-docs-mapper,
     component-proposer, component-installer), Read, Bash, Edit, Grep, Glob` —
     v2.1.33+ Claude Code Agent(agent_type) syntax 본 repo 안 첫 사용 사례 +
     audit-team 5 멤버 만 spawn 허용 = audit-team 외 agent 차단 sandbox 효과):
      - Step 1~4: project-scanner / harness-gap-analyzer / claude-docs-mapper /
        component-proposer sequential spawn (read-only 4 멤버, 각 Input Verification
        섹션 정합 — Read tool 보유 멤버 직접 Read / Read tool 부재 멤버 D10 우회
        패턴 = orchestrator inline 첨부 본문 직접 인용, v5.18 정전화)
      - Step 4↔5: USER DECISION GATE (e3 정책, orchestrator agent inline 책임)
      - Step 5: component-installer spawn (accept 시만, 5 멤버 중 유일한 write
        권한 멤버, audit-team 외 agent 차단 sandbox)
      - Step 6 (v6.6 신규): synthesizer fact verify (orchestrator agent inline) —
        `python scripts/audit_fact_verify.py --dir <audit-output>` 자동 호출
        (v5.13 정전화 3 method script-only fact 인용 자동 detect, mismatch 보고
        stdout JSON + exit 1) + markdown lint precheck (MD022/MD031/MD032 3 rule,
        v5.16 정전화) + 직접 매핑 검증 (v5.13 1차 source — boolean/표/수치 method
        분리, v5.18 정전화). 자율 = 검출 only, 사용자/orchestrator 수동 정정
        게이트 보존 (R1 결정).
  → audit 결과 = Stage B INTENT.motivation 자연 흡수
  → v6.20 이전 (v4.0~v6.19) 'audit chain 5 멤버 메인 Claude 직접 sequential 호출'
    분기 = historical milestone 산출물 안 보존 (audit trail)
else (freeform default — v3.x 호환):
  → 아래 step 1~7 그대로 진행 (회귀 0)
```

audit-orchestrator agent 단일 source: [`../../agents/audit-orchestrator.md`](../../agents/audit-orchestrator.md) (frontmatter 4 필드 + body 9 H2 sections — Scope + Note ext_2 hardcode / Input / Step 1~4 / Step 4↔5 GATE / Step 5 / Step 6 / Output / Constraints / 관련 문서). team orchestration narrative source: [`../../agents/project-harness-audit-team/CLAUDE.md`](../../agents/project-harness-audit-team/CLAUDE.md) (5 멤버 + D8 sequence + 사용자 게이트 between proposer 와 installer + v6.20 정전화 Note). `--audit` 부재 시 본 분기 자동 skip — freeform 기본 동작 보존 (b1 결정 정합, 기존 호출자 회귀 0).

#### Standard step (freeform default — `--audit` 미사용 시 또는 audit 종료 후 진행)

1. **대상 ROADMAP 읽기** (입력 source):
   - meta: `~/harness-meta/projects/meta/ROADMAP.md` (root `~/harness-meta/ROADMAP.md` 는 thin index — milestone 목록은 본 경로)
   - 프로젝트: `~/harness-meta/projects/<name>/ROADMAP.md`
2. `milestones[]` 배열에서 `status: "pending"` 또는 신규 발의 검토.
3. **AskUserQuestion 자동 invoke**: 후보 0건 → 새 발의 옵션 2~4안 / 후보 2건+ → 어느 후보?
4. vX.Y 결정 (단조 증가, breaking change면 major bump).
5. 컨테이너 생성:

   ```bash
   # meta — v6.2+ 9-stage-flattened era (의무): milestones/v{X.Y}/ (sub-id 부재, MILESTONE.md 단일 본책 + execute/ 별책)
   mkdir -p ~/harness-meta/projects/meta/milestones/v{X.Y}/execute
   # 프로젝트 — 동일 (v6.2+ 9-stage-flattened 의무, ARCHITECTURE.md § 6.1)
   mkdir -p <project-repo>/milestones/v{X.Y}/execute
   ```

6. ROADMAP `milestones[]` 배열에 신규 항목 추가 (in_progress entry) — v6.2+ 신 schema (`{version: "v{X.Y}", id: "{group-slug}", title, status: "in_progress", summary, trigger, milestones_path: "milestones/v{X.Y}/MILESTONE.md#sub-milestones"}`). v3.0~v6.1 bundled 보존 entry 는 `milestones_path: "milestones/v{X.Y}/milestones.md"` 그대로. **v5.21+ schema A2**: `milestones[]` = recent 3 completed + in_progress + deferred only. PROPOSE 발의 후보는 `next_candidates[]` 별도 필드 (Stage I 안 등재). 과거 completed entry archival = `CHANGELOG.md` (Keep a Changelog v1.1.0 정합). v2.0~v2.1 보존 entry 는 기존 schema (`id: "v{X.Y}_{slug}"` flat) 유지.

7. **`milestones/v{X.Y}/MILESTONE.md` 안 `## SUB_MILESTONES` 섹션 스켈레톤 즉시 작성** (v6.2+ 9-stage-flattened era 의무, narrative 1차 source — v3.0~v6.1 9-stage-bundled era 의 별도 `milestones.md` 파일 흡수). step 6 의 ROADMAP entry `milestones_path` 와 1:1 매핑 강제 (anchor `#sub-milestones`). skeleton 최소 필드 (## SUB_MILESTONES 섹션 안 ```json``` 블록):

   ```json
   {
     "version": "v{X.Y}",
     "title": "<ROADMAP entry title>",
     "status": "in_progress",
     "sub_milestones": [
       {
         "phase": 1,
         "title": "<placeholder, Stage D DESIGN 단계에서 정확한 phase 분할 후 갱신>",
         "status": "in_progress",
         "commit": null
       }
     ]
   }
   ```

   **placeholder title 허용 narrative**: OPEN 시점에서는 정확한 phase 분할 미확정 — phase-1 title placeholder 허용, Stage D DESIGN 단계에서 phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신 (placeholder title 교체).

   **v3.1 L2 CRITICAL mitigation**: milestones.md 부재 시 `tests/_era_detect.py` 가 era 오인 (9-stage-bundled 표지 미충족 → 4-tier/skip 분류) → smoke-spec-verification / smoke-scope-contract FAIL. 또한 `tests/smoke-bundle-trigger.sh` 가 `status: in_progress` entry 의 `milestones_path` 필드 + 실 파일 존재 검증 의무 (status: pending → continue / in_progress|completed → 검증). step 7 가 본 검증 분기와 narrative 부합 — OPEN 단계 종료 시점에 ROADMAP entry status: in_progress + milestones_path 보유 + 실 파일 보유 = 3 조건 동시 충족.

### Stage B — INTENT.md (의도)

```
milestones/v{X.Y}_{slug}/INTENT.md
```

JSON 필드:

- `id`, `title`, `goal` (1-2 문장), `motivation`
- `success_criteria` (관측 가능한 결과 list)
- `out_of_scope` (명시적 제외 list)
- `dependencies` (선행/후행 milestone)

⚠️ phase list / file list / commit 메시지 등 implementation detail은 **DESIGN.md로 미룸**.

**out_of_scope 부산물 정책** (v3.10_stage-byproduct-clarification): `out_of_scope` entry 는 (a) 본 milestone 의 negative scope **사실 진술** — '본 milestone 이 무엇이 **아닌가**' — 만 허용. (b) 후속 milestone 발의 표현 ('별 milestone 으로', '후속 milestone 안 처리' 등 forward propose 명령형) 은 **금지** — 후속 발의는 Stage I (PROPOSE) 의 단일 책임. 부산물 (a) 가 후속 candidate 의 source 가 될 수 있으나, ROADMAP 등재 + `next_candidates` 거명은 PROPOSE 단계에서 통합 흡수.

### Stage C — RESEARCH.md (조사)

```
milestones/v{X.Y}_{slug}/RESEARCH.md
```

JSON 필드:

- `external` (사용자 의도 / 외부 spec 검증 결과 list — source/topic/findings/drift)
- `codebase` (affected_files, untouched_files, current_state, target_state)
- `options` (대안별 pros/cons — raw 분석)
- `risks_identified` (예상 리스크 list)

⚠️ 결정 (decisions)은 **DESIGN.md로 미룸**.

**codebase 분야 Explore 병렬 매핑 (v7.0 T2.3)**:

`codebase` 필드는 단일 묶음이 아니라 작업 본질에 따라 **N+ 가변 분야**로 발현 (agent fleet / smoke fleet / cascade narrative / plugin.json paths 등). 각 분야 1개를 `Explore` subagent 1번 호출로 parallel 매핑 → `codebase.{분야명}` 자연 채움. 발현 mechanism (Stage D review 와 같은 pattern, 다른 본질 = 검증 vs 조사) 1차 source = [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 11.

분야 발현 흐름 (INTENT.md 작성 완료 직후, Stage C 진입):

1. **Claude 메인 자동 cb 분야 발현** — INTENT.goal + INTENT.dependencies 분석 → 작업 본질 type 매트릭스 (§ 11) 정합 cb 분야 자동 선택 + scope 크기 매트릭스 (작음 ≤5 = 2~3 / 중간 6~15 = 3~5 / 큼 16+ = 5~8) 로 count 결정
2. **AskUserQuestion 게이트** — "RESEARCH cb 분야 N건 제안 — 이대로 충분? 추가/제거?"
3. **사용자 명시 후 Explore parallel invoke** — 분야별 1:1, 한 메시지 안 N 호출 동시:

   ```
   Agent(subagent_type: "Explore", prompt: "<분야명> 본질 codebase 안 거주 + cross-reference 본질 매핑. scope: <path_scope>. search breadth: medium (작은 분야 quick / 큰 분야 very thorough). 결과 = RESEARCH codebase.<분야명> 흡수 format.")
   ```

4. **결과 흡수** — 메인 Claude 가 N Explore 결과를 `codebase.{분야명}` (거주 / cross_reference / 본_milestone_영향 sub-field) 로 통합. 부산물 발견 (scope 외) 은 별 분리 (자동 candidate 화 부재).

> **적용 범위**: v7.0+ 신규 milestone 만. 기존 28 active milestone RESEARCH 의 `codebase` narrative 는 자연 보존. 첫 실사용 = v7.1 (v7.0 = 설치만).

**untouched_files / risks_identified 부산물 정책** (v3.10): `codebase.untouched_files_explicit` 와 `risks_identified` 는 (a) 본 milestone 의 영향 부재 파일 / 식별 risk 의 **사실 진술**만 — 'untouched 6건 묶음을 별 milestone 으로' 같이 후속 milestone 명명 표현 **금지**. (b) 사실 진술이 후속 candidate source 가 될 수 있으나, 명명 + ROADMAP 등재는 Stage I (PROPOSE) 통합 흡수.

### Stage D — DESIGN.md (설계 + 5 관점 검토)

```
milestones/v{X.Y}_{slug}/DESIGN.md
```

JSON 필드:

- `decisions` (decision/rationale/alternatives_rejected)
- `approach` (전체 전략 요약)
- `phases` (n / title / scope / affected_files [`execute/phase-{n}.md` 포함 의무] / rationale / risks)
- `risk_mitigation` (risk/mitigation 매핑)

**decisions / phases 부산물 정책** (v3.10): `decisions[i].rationale` 와 `phases[n].scope` 는 (a) 본 milestone 의 결정 / 단계 범위 **사실 진술**만 — 'PROPOSE.md `next_candidates` 발의 narrative' 같이 forward propose 책임 직접 거명 **금지**. (b) 본 milestone 안 결정 / 범위 자체가 후속 candidate source 가 될 수 있으나, 명명 + ROADMAP 등재는 Stage I (PROPOSE) 통합 흡수.

**다각적 검토 — N+ 가변 분야 review (v7.0 T1.3)**:

고정 5 관점 매트릭스 폐기 — 작업 본질 (schema change / new feature / cascade narrative 등) + scope 크기에 따라 검토 분야가 자연 발현 (3~10). 기존 5 관점 (architecture / spec-drift / 회귀 risk / 보안 / scope contract) 은 default 로 보존되되 고정이 아님. 발현 mechanism + 작업 본질 type 매트릭스 1차 source = [`../../projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 11.

분야 발현 흐름 (DESIGN.md 작성 완료 직후, Stage D 종료 직전):

1. **Claude 메인 자동 분야 발현** — INTENT.success_criteria + DESIGN.phases 분석 → 작업 본질 type 매트릭스 (§ 11) 정합 분야 자동 선택 + scope 크기 매트릭스 (작음 ≤5 = 3~5 / 중간 6~15 = 5~7 / 큼 16+ = 7~10) 로 count 자동 결정
2. **AskUserQuestion 게이트** — "DESIGN 검증 N 분야 제안 — 이대로 충분? 추가/제거?" (max 4 question 안 통합)
3. **사용자 명시 후 invoke** — [`design-review` subagent](../../agents/design-review.md) 를 `perspectives:` array 와 함께 부른다 (read-only, 1번 invoke 안 N 분야 순차 통합 — subagent 중첩 불가)
4. **결과 흡수** — scope 안 결과 → DESIGN.md / scope 외 거명 → MILESTONE.md `## SCOPE_OUT_NOTES` (조건부 H2)

**scope 안/외 분리**: scope 안 = INTENT.success_criteria + DESIGN.phases 직접 정합 본질 (DESIGN.md 흡수). scope 외 = scope 본질 외 거명 (관련 본질 / 후속 candidate / 우연 발견) → `## SCOPE_OUT_NOTES` 거주만, **next_candidates 자동 append 부재** (PROPOSE stage 안 사용자 명시 결정 게이트 후만 등재 — 부산물 cycle 차단).

**의견 충돌 처리**: 충돌 발견 시 `AskUserQuestion` 자동 invoke (각 충돌 1 question, 최대 4 question).

> **적용 범위** (breaking change 최소): v7.0+ 신규 milestone 만 본 mechanism. 기존 28 active milestone DESIGN 의 5 관점 narrative 는 자연 보존 (디스크 보존). 본 N+ 가변 mechanism 첫 실사용 = v7.1 (v7.0 = 설치만).

**Stage D 완료 직전 의무 step** (v3.5_open-stage-discipline-strengthening phase-2 도입):

`phases[]` 확정 직후 (5 관점 검토 의견 흡수 후) → `milestones/v{X.Y}/milestones.md` `sub_milestones[]` 를 `phases[]` 와 1:1 동기 갱신 (placeholder title 교체). Stage A step 7 의 forward cross-ref (`milestones.md` 스켈레톤 작성 narrative 안 'Stage D DESIGN 단계에서 `phases[]` 확정 후 `milestones.md sub_milestones` 1:1 동기 갱신') 와 backward cross-ref → 양방향. 본 step 미실행 시 `milestones.md sub_milestones` 가 OPEN 단계 placeholder 잔존 (stale narrative) → smoke-spec-verification 산출물 검증 시 narrative drift 침묵 통과 위험.

### Stage E — APPROVE.md (사용자 명시 승인 게이트)

```
milestones/v{X.Y}_{slug}/APPROVE.md
```

JSON 필드:

- `approved_by` (`"user"` 만 허용 — Claude 자동 작성 금지)
- `date` (ISO-8601 — `YYYY-MM-DD`)
- `approval_summary` (5 관점 검토 결과 + DESIGN 종합 narrative)

**필수 게이트**: 5 관점 검토 결과 + DESIGN.md 종합 → `AskUserQuestion`으로 사용자 명시 승인 받음 → `APPROVE.md` 작성 (`approval.approved_by: "user"` + `date` ISO-8601). **미승인 시 EXECUTE 진입 금지**.

⚠️ 7-stage era 보존 milestone (v1.0~v1.4) 은 `DESIGN.approval.approved_by` 필드로 동치 — smoke `tests/smoke-scope-contract.sh` 가 era 분기 검증 (phase 4 갱신 후).

### Stage F — EXECUTE (phase별 진행, 각 phase = 1 commit)

**선결 조건 (v3.0+ 9-stage-bundled era, EXECUTE 진입 전 의무)**

- `milestones/v{X.Y}/milestones.md` 보유 확인 — 이미 **Stage A step 7 에서 작성됨** (v3.4_open-stage-milestones-md-protocol 도입). EXECUTE 진입 직전 확인만 — 보조 검증 step (예: `test -f milestones/v{X.Y}/milestones.md`). 부재 시 OPEN 단계 누락 = step 7 retroactive 작성 후 진행. skeleton 최소 필드 narrative 1차 source = **Stage A step 7 참조** (v3.4 도입, v3.1 L2 CRITICAL mitigation 의 narrative 1차 source 이동 — Stage F 게이트 → Stage A step 7). Stage D DESIGN 단계 phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신 의무.
- **INTENT~APPROVE commit 시점** — 3 패턴 중 선택 (v3.1 L6):

  - **(a)** phase-1 commit 안 포함 (사용자 재량)
  - **(b)** Stage G (VERIFY) commit 안 포함 — VERIFY 전 산출물 영구 보존 보장 **(권장)**
  - **(c)** 별도 `chore(meta): v{X.Y} Stage B-E artifacts` commit

  기본값 (b): Stage G commit 에 INTENT/RESEARCH/DESIGN/APPROVE.md 4건 포함 → 산출물 소실 없음.

각 phase 진행:

1. `execute/phase-{n}.md` 작성 (status: `in_progress`) + DESIGN.phases[n].affected_files에 `execute/phase-{n}.md` 추가
2. 구현 파일 수정 (Edit/Write) — affected_files 목록에 따라 구현 파일 수정
3. smoke 회귀 검증 (pre-commit hook 자동 실행)
4. `git add` + commit (conventional commits, 메시지: `feat(meta): v{X.Y} phase-{n} — <주제>`)
5. `execute/phase-{n}.md` status `complete` + execution_notes 갱신

**AskUserQuestion 자동 invoke**: 구현 중 INTENT/DESIGN 외 의사결정 발견 시.

**사용자 명시 승인 없이 `--no-verify` 사용 금지** (pre-commit hook 우회는 명시 승인 게이트만).

### Stage G — VERIFY.md (검증)

```
milestones/v{X.Y}_{slug}/VERIFY.md
```

JSON 필드:

- `smoke_tests` (name/command/result/output)
- `manual_checks` (check/result/notes)
- `criteria_check` (INTENT.success_criteria 1:1 매핑)
- `verdict` (`pass` | `fail`), `regressions`

### Stage H — REPORT.md (종합 backward)

```
milestones/v{X.Y}_{slug}/REPORT.md
```

JSON 필드:

- `summary` (1-3 문단 narrative)
- `delta` (files_changed/added/deleted, modules_affected)
- `lessons_learned`

⚠️ `next_candidates` (forward) 는 **PROPOSE.md로 분리** — REPORT 는 backward 종합만.

### Stage I — PROPOSE.md (후속 forward + ROADMAP 등록)

```
milestones/v{X.Y}_{slug}/PROPOSE.md
```

JSON 필드:

- `next_candidates` (id/title/trigger/trigger_type list)
- `propose_summary` (선택, narrative)

**B/C/D 부산물 통합 흡수 책임** (v3.10): `next_candidates` 는 두 origin 을 통합 흡수 — (1) 본 milestone Stage B (`INTENT.out_of_scope`) / C (`RESEARCH.untouched_files_explicit` / `risks_identified`) / D (`DESIGN.decisions[i].rationale` / `phases[n].scope`) 의 **부산물 (사실 진술)** 을 PROPOSE 단계에서 후속 milestone 명명 + ROADMAP 등재. (2) 본 milestone 작업 중 **사용자 명시 발의** (A_user trigger) 직접 등재. **단일 origin 강제** — B/C/D 정의 안 후속 발의 명령형 표현은 금지 (정의 narrative: Stage B/C/D 부산물 정책 참조).

**actual operation** (v5.21+ schema A2 정합):

1. ROADMAP `milestones[]` 배열에서 본 milestone `status: "completed"`로 갱신.
2. `next_candidates` 를 ROADMAP `next_candidates[]` 별도 필드에 등재 (`{id, title, trigger, origin_milestone, target_version, description}` schema). **사용자 명시 결정 게이트 후만 등재** (v7.0 T1.2 정전화) — lessons P2/P3 또는 review 부산물의 **자동 append 폐지**. 부산물 (B/C/D + Stage D review `## SCOPE_OUT_NOTES`) 은 candidate source 일 뿐, ROADMAP 등재는 PROPOSE 안 사용자 명시 결정 후만 (부산물 cycle 차단).
3. **Archival cycle** (v5.21+ 도입, DESIGN.D11 정합): `milestones[]` 안 completed entry count > 3 인 경우 가장 오래된 completed entry 의 summary 를 `CHANGELOG.md` 안 동치 위치 (역순 정합) 로 이전 + ROADMAP entry 제거. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. **PROPOSE register 책임 분리 아님** (v5.21 oos_2 정합) — 등재 위치만 변경.
4. **사용자 확인** (`AskUserQuestion`) → push:

   ```bash
   git push origin <branch>
   ```

4. **PR 생성 + main 머지** (사용자 결정):

   ```bash
   gh pr create --title "milestone v{X.Y}_{slug}" --body "..."
   ```

## AskUserQuestion 자동 invoke 운영 원칙

| 원칙 | 적용 |
|------|------|
| "결정 필요 → invoke" | 추론으로 단정 불가한 분기점 모두 |
| "애매하면 invoke" | 신뢰도 < 90% 시 |
| 2~4 옵션 제시 | tool spec 한계 + 사용자 인지 부담 균형 |
| 첫 옵션 (Recommended) | 권장 명확 시만 |
| 단순 yes/no는 텍스트 | AskUserQuestion 남용 회피 |

**Stage별 trigger**:

| Stage | invoke 조건 |
|:-:|-----------|
| A (OPEN) | ROADMAP 후보 0건 (새 발의) / 2건+ (어느 후보?) |
| B (INTENT) | INTENT 작성 중 결정 분기점 |
| C (RESEARCH) | RESEARCH 중 결정 분기점 |
| D (DESIGN) | 5 관점 의견 충돌 / 회귀 risk |
| E (APPROVE) | **사용자 명시 승인 (항상)** |
| F (EXECUTE) | 구현 중 INTENT/DESIGN 외 의사결정 |
| G (VERIFY) | 회귀 발견 / 검증 verdict 분기 |
| I (PROPOSE) | trigger 분류 애매 / push 전 (항상) |

## 신규 프로젝트 도입

`<name>` 부재 시 (즉 `~/harness-meta/projects/<name>/` 부재 + 타겟 `.harness.toml` 부재) — 첫 milestone (예: `v0.1_setup`)의 EXECUTE phase에서 다음 산출:

- `~/harness-meta/projects/<name>/{ARCHITECTURE,ROADMAP}.md` (2종)
- 타겟 프로젝트 `.harness.toml` (manifest)
- 타겟 프로젝트 `.claude/` 배포 — v5.0+ 프로젝트별 Plugin manifest (`.claude-plugin/plugin.json` paths 명시) 옵션 또는 project-scope plugin install (`claude plugin install <name>@<marketplace> --scope project`). ((Deprecated since v5.0, v5.0+ 환경에서는 비활성) v4.x narrative — `component-installer` subagent / 메인 Claude OS 별 D7 sequence 매핑은 historical 만 보존)

별도 "Bootstrap 모드" 없음 — 첫 milestone이 곧 setup.

## 금지

- `<milestone-dir>/index.json`, `step{N}.md` 생성 (재귀 회피)
- `projects/meta/milestones/v1.84~v1.88/` 4-tier 포맷으로 신규 milestone 작성 (historical 보존, 신규는 v2.0+ 9-stage만)
- 7-stage 포맷 (PLAN/RESEARCH/DESIGN/VERIFY/REPORT, INTENT/APPROVE/PROPOSE 부재) 으로 신규 milestone 작성 (v1.0~v1.4 era 보존, 단 `v2.0_workflow-word-fidelity` 자체는 자기참조 회피 표지로 7-stage 포맷 — 예외)
- root `ROADMAP.md` 에 milestone 직접 기재 (thin index 위배 — `tests/smoke-projects-scope-discipline.sh` 가 차단)
- `--no-verify` 사용자 명시 승인 없이 사용
- `execute.py`를 하네스 개선에 호출 (GSD 부적합)

## 관련

- 운영 가이드: `~/harness-meta/CLAUDE.md`
- 정의 (정전 single source): `~/harness-meta/projects/meta/ARCHITECTURE.md` § 3 + § 4 + § 6
- 프로젝트 thin index: `~/harness-meta/ROADMAP.md`
- 활성 milestone (메타): `~/harness-meta/projects/meta/ROADMAP.md` + `~/harness-meta/projects/meta/CLAUDE.md` (lazy load)
- 모듈 가이드: `~/harness-meta/{claude,bootstrap/skills,tests}/CLAUDE.md`
- ADR: `~/harness-meta/docs/adr/README.md`
