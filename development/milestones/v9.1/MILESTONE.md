---
id: architecture-md-split-by-canonical-definition
title: ARCHITECTURE.md 사전적 정의 정합 분리
version: v9.1
status: in_progress
---

# v9.1 — ARCHITECTURE.md 사전적 정의 정합 분리

## OPEN

본 milestone 은 사용자 명시 큰 건 결정 (2026-05-28, /clear 후 토큰 우려 → 사전적 정의 부합 검증 → N=2 실용 분리 확정) 으로 개시한다. 직전 milestone v9.0 (multi-llm-adapter-tiers, completed 2026-05-28) 의 정체성 cascade 직후 후속 — codex-adapter-surface-enhancement / design-time-intent-amend-pattern-canonicalization 등 다른 v9.1 후보의 § 참조 위치가 본 분리에 의해 변경되므로 **선행 구조 변경**으로 v9.1 우선 처리한다. 본 OPEN 은 그 결정 안 mechanical 진입 본질만 기록 — 실 분리 단위 N / sub-split 경계 / cascade host 정확 enumerate / smoke 영향 등 결정은 INTENT / RESEARCH / DESIGN stage 로 보류한다.

### 왜 본 milestone 을 연다 (origin)

- **사용자 토큰 우려** (1차 trigger, 2026-05-28): "architecture.md에 내용이 이렇게 길면 워크플로우 동작할 때 컨텍스트를 너무 차지하지 않아?" — ARCHITECTURE.md = 559 줄 / 120KB / ≈ 30K tokens. 토큰 효율 검토 round 안 ARCHITECTURE.md 가 always-loaded 아니라 on-demand 인 점 확인했으나 풀로드 시 컨텍스트 15% 차지.
- **사전적 정의 부합 검증** (2차 trigger, 본질 deepening): 사용자 의문 — "ARCHITECTURE.md 내용이 사전적 정의에 맞아?" — § 11 개 enumerate 결과 사전적 정의 ("전체의 뼈대·구성요소·관계") 정합 = § 1/2/9/10 (구조) + § 3 (도메인 정체성, 정당한 architecture 일부) = 5 §, 그 외 § 4/7.3/7.4/11 = 워크플로우 본질 (4 §) / § 5/6/7.1/7.2 = 운영 매뉴얼 본질 (4 §) 로 본질 혼재 확인. "Architecture" 이름표 하나에 4 종류 본질 (구조 + 정체성 + 프로세스 + 정책 + 매뉴얼) 누적 상태.
- **사용자 명시 결정** (2026-05-28): N=2 실용 분리 (ARCHITECTURE 잔류 + WORKFLOW.md / OPERATIONS.md 신설) + § 7 sub-split (§ 7.3/7.4 → WORKFLOW / § 7.1/7.2 → OPERATIONS) + v9.1 우선 처리 + codex-adapter v9.2 / design-time-intent-amend pending 결정.
- **선행 구조 변경 본질**: 본 분리 안 § 3 (ARCHITECTURE 잔류) / § 7.3 (WORKFLOW.md 이동) / § 7.4 (WORKFLOW.md 이동) 등 cross-ref host (≈ 15~20) 의 새 path 가 codex-adapter-surface-enhancement (AGENTS.md tier 표현 cascade — § 3.1 + § 3.5 인용) / design-time-intent-amend-pattern-canonicalization (§ 7.3 정전화 host 자체 변경) 후속 candidate 작업 범위 결정자. 분리를 먼저 처리하지 않으면 다른 v9.1 후보 작업이 곧 무효화될 cross-ref 를 다시 손대야 함.

### 후보 방향 (INTENT 까지 정식 결정 보류)

- **N=2 실용 분리 확정** (사용자 명시): ARCHITECTURE (§ 1/2/3/9/10 잔류) + WORKFLOW.md (§ 4/7.3/7.4/11 신설) + OPERATIONS.md (§ 5/6/7.1/7.2 신설).
- **§ 7 sub-split 확정** (사용자 명시): § 7.3 (Stage 본질) / § 7.4 (LIGHTWEIGHT 트랙) → WORKFLOW.md / § 7.1 (컨텍스트 효율) / § 7.2 (entry title 가이드) → OPERATIONS.md.
- **§ 3 정체성 잔류 확정** (사용자 명시): 도메인 개념 모델 = architecture 의 정당한 일부 (cascade host 가장 많아 분리 비용 최소화).
- **§ 10 (Auto-Mode 최소권한) 위치**: 절반 구조 / 절반 정책. 1차 검토 결과 ARCHITECTURE 잔류 가닥 (preview 안 명시). INTENT 안 확정.
- **활성 cascade host ≈ 15~20**: CLAUDE.md / AGENTS.md / README.md / development CLAUDE.md / tests CLAUDE.md / skills 14 / agents 3 / commands / rules README / GUARDRAILS / ai-ready scorer scripts. 정확 enumerate + 갱신 priority RESEARCH stage 에서.
- **smoke 영향**: smoke-spec-verification.sh / smoke-scope-contract.sh / smoke-bundle-trigger.sh 등 안 ARCHITECTURE 경로 인용 — 분리 후 path 갱신 필요 여부 RESEARCH 에서.
- **historical milestone trace 안 § 인용 (≈ 580 회)**: archived / 종료된 milestone 본문 안 § 인용 = 역사적 사실 보존 (갱신 ✗) — 본 작업 scope 외.

## INTENT

### Spec

```json
{
  "id": "architecture-md-split-by-canonical-definition",
  "title": "ARCHITECTURE.md 사전적 정의 정합 분리",
  "goal": "development/ARCHITECTURE.md 를 사전적 architecture 정의 ('전체의 뼈대·구성요소·관계') 에 맞게 슬림화하고, 혼재된 workflow/process spec 과 operations/governance manual 을 각각 development/WORKFLOW.md / development/OPERATIONS.md 로 분리한다. ARCHITECTURE.md 는 구조·정체성·책임 레이어 중심의 canonical source 로 남기고, workflow 및 operations canonical source 를 신설한 뒤 활성 cross-ref host 를 새 source 경계에 맞게 정합한다.",
  "motivation": "origin = 사용자 토큰 우려 ('ARCHITECTURE.md 가 길면 워크플로우 동작 시 컨텍스트를 너무 차지하지 않나') + 사전적 정의 부합 검증. 실측상 ARCHITECTURE.md 는 always-loaded 는 아니나 559줄/120KB/약 30K tokens 로 무지성 풀로드 시 컨텍스트 부담이 크다. 더 근본적으로 § 11 개 안 구조/정체성, workflow/process, operations/governance, manual/template 본질이 한 파일에 누적되어 'architecture' 이름표의 본질 과부하가 발생했다. 사용자 명시 결정으로 N=2 실용 분리 (ARCHITECTURE 잔류 + WORKFLOW.md + OPERATIONS.md 신설), § 7 sub-split, v9.1 선행 처리 확정.",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "development/ARCHITECTURE.md 슬림화 — 사전적 architecture 본질에 맞는 § 1 디렉토리 구조 / § 2 모듈 책임 / § 3 하네스 엔지니어링 정의·adapter taxonomy / § 9 3-way 책임 직교 / § 10 Auto-Mode 최소권한·subagent frontmatter pattern 중심으로 재구성되고, workflow·operations 본질 본문은 새 파일로 이동"
    },
    {
      "id": "sc_2",
      "criterion": "development/WORKFLOW.md 신설 — 기존 ARCHITECTURE.md § 4 (9-stage workflow + bundling) / § 7.3 (Stage 본질) / § 7.4 (가벼운 흐름) / § 11 (분야 발현 mechanism) 이 workflow canonical source 로 이동하며, stage pipeline·bundling·LIGHTWEIGHT track·RESEARCH cb/DESIGN review mechanism 의 의미 손실이 없음"
    },
    {
      "id": "sc_3",
      "criterion": "development/OPERATIONS.md 신설 — 기존 ARCHITECTURE.md § 5 (비대칭 의도) / § 6 (변경 시 주의 + era 정책) / § 7.1 (AI Native 운영 정의) / § 7.2 (entry title 가이드) 가 operations canonical source 로 이동하며, governance/운영 원칙/entry title 규칙의 의미 손실이 없음"
    },
    {
      "id": "sc_4",
      "criterion": "활성 cross-ref host 정합 — CLAUDE.md / AGENTS.md / README.md / development/CLAUDE.md / tests/CLAUDE.md / skills / agents / commands / rules / scripts 등 현재 운영 표면에서 ARCHITECTURE.md § 4·5·6·7·11 을 참조하는 활성 host 를 RESEARCH 에서 enumerate 하고, DESIGN 결정에 따라 WORKFLOW.md 또는 OPERATIONS.md 로 갱신. historical milestone trace 안 과거 § 인용은 역사 보존으로 갱신하지 않음"
    },
    {
      "id": "sc_5",
      "criterion": "ROADMAP schema_note 및 candidate 참조 정합 — development/ROADMAP.md 안 entry title 가이드 등 현행 canonical source 포인터가 새 파일 경계와 일치하고, v9.0 후속 후보 (codex-adapter-surface-enhancement / design-time-intent-amend-pattern-canonicalization 등) 의 target_version 및 설명이 분리 후 참조 위치와 모순되지 않음"
    },
    {
      "id": "sc_6",
      "criterion": "검증 통과 — 관련 smoke (최소 smoke-open-stage-discipline / smoke-scope-contract / smoke-spec-verification / smoke-workflow-registration / smoke-roadmap-archival / smoke-cross-ref, 가능하면 make smoke 또는 active smoke 전체) PASS 를 VERIFY 에 기록"
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "historical milestone artifacts 안 ARCHITECTURE.md § 인용 일괄 갱신 — 약 580회 수준의 과거 trace 는 당시 source 상태를 보존하는 기록이므로 본 milestone 에서 수정하지 않음"
    },
    {
      "id": "oos_2",
      "item": "workflow 자체 의미 변경 — 9-stage pipeline, APPROVE gate, bundling rule, LIGHTWEIGHT track, RESEARCH cb/DESIGN review mechanism 을 재설계하지 않고 source 위치만 분리·정합"
    },
    {
      "id": "oos_3",
      "item": "operations policy 변경 — 비대칭 의도, era 정책, AI Native 운영 원칙, entry title 4 원칙의 내용 변경은 drift 수정에 필요한 최소 문장 보정 외 범위 밖"
    },
    {
      "id": "oos_4",
      "item": "Codex/Gemini/Cursor 어댑터 표면 보강 — v9.0 후속 후보인 codex-adapter-surface-enhancement 등은 본 구조 분리 후 v9.2+ 에서 처리"
    },
    {
      "id": "oos_5",
      "item": "DESIGN 시점 INTENT amend 패턴 정전화 — 기존 후보는 ARCHITECTURE § 7.3 참조 위치가 바뀌므로 분리 후 WORKFLOW.md 기준 별도 재평가"
    },
    {
      "id": "oos_6",
      "item": "자동 cross-ref rewrite tool 또는 smoke 신규 개발 — 본 milestone 은 문서 분리와 현행 참조 정합이 본질이며, host count 자동 smoke 는 기존 next_candidate identity-cascade-host-count-smoke 등 별도 mechanism 후보로 유지"
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "development/ARCHITECTURE.md 현재 § 1~11",
      "purpose": "분리 대상 원문. RESEARCH 에서 현재 heading/line 범위와 본질 분류를 확정하고 DESIGN 에서 새 파일 배치표를 결정"
    },
    {
      "id": "dep_2",
      "ref": "development/ROADMAP.md schema_note + v9.1 in_progress entry + next_candidates[]",
      "purpose": "entry title 가이드 및 후속 후보 참조 위치가 새 WORKFLOW/OPERATIONS 경계와 정합해야 함"
    },
    {
      "id": "dep_3",
      "ref": "CLAUDE.md / AGENTS.md / README.md",
      "purpose": "root-level always/entry source 안 ARCHITECTURE § 참조를 새 canonical source 로 바꿔야 하는 주요 활성 host"
    },
    {
      "id": "dep_4",
      "ref": "development/CLAUDE.md / tests/CLAUDE.md / module-level guides",
      "purpose": "하위 작업 영역에서 lazy-load 되는 운영 가이드의 canonical source 포인터 정합 대상"
    },
    {
      "id": "dep_5",
      "ref": "tests/smoke-*.sh + .pre-commit-config.yaml + Makefile",
      "purpose": "분리 후 깨질 수 있는 smoke 참조와 검증 표면. VERIFY 안 최소 관련 smoke PASS evidence 필요"
    },
    {
      "id": "dep_6",
      "ref": "v9.0 multi-llm-adapter-tiers REPORT/PROPOSE",
      "purpose": "codex-adapter-surface-enhancement 및 design-time-intent-amend 후보가 v9.1 에서 v9.2 로 밀린 origin. 본 milestone 이 선행 구조 변경이라는 정당화 source"
    }
  ]
}
```

### Narrative

본 milestone 의 단일 본질은 **ARCHITECTURE.md 라는 canonical source 이름과 실제 본문 본질의 불일치를 해소하는 것**이다. 사용자 질문은 토큰 효율에서 출발했지만, 검토 결과 더 큰 문제는 용량 자체보다 한 파일 안에 architecture / workflow / operations / template 성격이 함께 누적된 본질 과부하였다. 따라서 단순 부분 로드 규율만 추가하지 않고, 사전적 architecture 정의에 맞춰 source 경계를 정리한다.

분리 방향은 사용자 명시 결정에 따라 N=2 실용안을 채택한다. `ARCHITECTURE.md` 는 구조·구성요소·관계·정체성·책임 레이어를 보존하고, `WORKFLOW.md` 는 9-stage / bundling / LIGHTWEIGHT / 분야 발현 mechanism 을, `OPERATIONS.md` 는 비대칭 의도 / era 정책 / AI Native 운영 / entry title 가이드를 담당한다. `§ 3` 은 도메인 개념 모델로서 architecture 의 일부로 잔류하고, `§ 7` 은 본질별로 sub-split 한다.

성공은 세 파일이 생기는 것만으로 보지 않는다. 활성 운영 표면의 canonical source 포인터가 새 경계와 맞아야 하며, historical milestone trace 는 과거 기록으로 보존해야 한다. 실제 분리·참조 갱신은 RESEARCH/DESIGN/APPROVE 이후 EXECUTE 에서 수행한다.

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "Merriam-Webster / Cambridge — architecture (사전적 정의)",
      "finding": "'전체의 뼈대·구성요소·관계'. 그리스어 ἀρχιτέκτων (으뜸 장인) — 부분(구현·세부) 보다 상위 층위의 전체 형태·관계 결정. 본 milestone 정합 source — § 1/2/3/9/10 (구조·정체성·책임 레이어) = 정의 정합, § 4/7.3/7.4/11 (프로세스·발현 mechanism) = 워크플로우 본질로 분리, § 5/6/7.1/7.2 (운영 원칙·era 정책·매뉴얼) = 운영 매뉴얼 본질로 분리"
    },
    {
      "id": "ext_2",
      "source": "Diátaxis framework — Documentation as Code (참조 원칙)",
      "finding": "tutorials / how-to / reference / explanation 4 분지 = 문서 본질별 분리 원칙. 본 작업 = ARCHITECTURE (reference) / WORKFLOW (how-to procedure) / OPERATIONS (explanation + policy) 3 분지 정합. 외부 원칙 직접 인용 부재 — 본 작업 driver 는 사전적 정의 ext_1, ext_2 = 보조 정합 근거"
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": "development/ARCHITECTURE.md § 1~11 + sub-section",
      "finding": "H2 11 + H3 sub 총 22 — § 1 (~44 줄, line 7~50) / § 2 (~10 줄, 51~60) / § 3 (~97 줄, 61~157, 7 sub 3.1~3.7) / § 4 (~106 줄, 158~263 + 4.1 bundling 245~263 + § 4 끝 매트릭스 178~244) / § 5 (~6 줄, 264~269) / § 6 (~44 줄, 270~313, 1 sub 6.1) / § 7 (~93 줄, 314~406, 4 sub 7.1~7.4) / § 8 (~8 줄) / § 9 (~32 줄, 3 sub) / § 10 (~31 줄, 3 sub) / § 11 (~80+ 줄, 6 sub). 전체 559 줄"
    },
    {
      "id": "cb_2",
      "ref": "cascade host raw detect (grep `ARCHITECTURE.md.*§ (4|5|6|7|11)`, glob `!development/milestones/**` 만 적용)",
      "finding": "raw detect = 37 file (sc_4 추정 15~20 보다 많음). 단 본 raw 안 historical/audit trace 포함 — projects/upbit/audit-2026-05-19-cycle7/* + audit-2026-05-18/* (audit trace) + projects/upbit/milestones/v1.4/* (upbit historical milestone) + CHANGELOG.md dated entry (append-only, 단 헤더 navigation pointer 는 active) + docs/adr/ADR-006-workflow-revamp.md (ADR append-only). active update target ≈ 28~30 file 으로 DESIGN 안 확정 — 후보 제외 기준 5건 = (1) development/milestones/** + (2) projects/*/milestones/** + (3) projects/*/audit-* + (4) CHANGELOG.md dated entry + (5) docs/adr/* append-only. 주요 active update target = (root) CLAUDE.md / AGENTS.md / README.md / .gitignore / .pre-commit-config.yaml / ROADMAP.md / GUARDRAILS.md / CHANGELOG.md 헤더만 / (development) ARCHITECTURE.md(self) / CLAUDE.md / ROADMAP.md / (claude/commands) harness-meta.md / propose-next.md / cascade-sync.md / (agents) audit-orchestrator.md / design-review.md / version-tracker.md / project-harness-audit-team/CLAUDE.md / (skills) 9 stage skill SKILL.md + lightweight-flow + bootstrap/agents/CLAUDE.md / (tests) CLAUDE.md + smoke-bundle-trigger.sh + smoke-open-stage-discipline.sh + smoke-spec-verification.sh + smoke-scope-contract.sh + smoke-entry-title-guideline.sh / (projects) upbit/ROADMAP.md"
    },
    {
      "id": "cb_3",
      "ref": "§ sub-section 분포 ↔ INTENT 분리 매핑",
      "finding": "§ 3 (7 sub 3.1~3.7) = 모두 ARCHITECTURE 잔류 (사용자 명시 sc_1) — Working definition / philosophy / 5요소 매트릭스 / 외부 컨벤션 / Adapter taxonomy / 단일 source / milestone 발의 평가. § 7 (4 sub) = 정합 분리: § 7.1 (정의, 316~333) + § 7.2 (Entry title, 334~344) → OPERATIONS / § 7.3 (Stage 본질, 345~350) + § 7.4 (가벼운 흐름, 351~406) → WORKFLOW. § 10 (3 sub) = ARCHITECTURE 잔류 (sc_1) — 4 분류 / subagent frontmatter / § 7.1 cross-ref. § 11 (6 sub 11.1~11.6) = 모두 WORKFLOW (sc_2)"
    },
    {
      "id": "cb_4",
      "ref": "line distribution 추정 (분리 후)",
      "finding": "ARCHITECTURE (§ 1/2/3/8/9/10 잔류) ≈ 222 줄 (40%, 토큰 ≈ 12K) / WORKFLOW (§ 4 + § 7.3 + § 7.4 + § 11) ≈ 248 줄 (44%, 토큰 ≈ 13K) / OPERATIONS (§ 5 + § 6 + § 7.1 + § 7.2) ≈ 79 줄 (14%, 토큰 ≈ 4K). 헤딩 + intro paragraph 추가 ≈ +25 줄. 결과 = 풀로드 시 단일 30K 한방 → 본질별 부분 로드 가능 (토큰 효율 부수 이득)"
    },
    {
      "id": "cb_5",
      "ref": "scripts/cascade_sync.py + cascade-source marker (v6.4 mechanism)",
      "finding": "현재 active host 중 cascade-source marker 적용 = CLAUDE.md 1건 (+ historical milestones 4건 = trace 보존). marker 미부착 active host 36건 = 본 작업 안 manual grep replace 의무 (v8.2 가벼운 흐름 deferred 해소 안 grep 3 형식 규율 — relative / 절대 / anchor)"
    },
    {
      "id": "cb_6",
      "ref": "skills/stage-design/SKILL.md:111 — § 6.2 stale reference",
      "finding": "'§ 6.2 — Narrative 정전화 3 단계 패턴 (v3.21 정전화)' 인용. 실제 ARCHITECTURE 안 § 6.2 H3 sub-section 부재 — memory `feedback_section_6_2_abolished` 정합 (§ 6.2 폐지, v4.0). 본 작업과 별개 stale reference — scope_out 거명 (cascade 갱신 중 발견된 drift, 별 lessons P3 후보)"
    },
    {
      "id": "cb_7",
      "ref": "§ 4 끝 매트릭스 #N row 인용 host (정전화 누적 매트릭스, line 178~244)",
      "finding": "claude/commands/cascade-sync.md:9/69/85 (#8 row), propose-next.md:9/113/118 (#9 row), agents/audit-orchestrator.md:132/133 (#5+#10 row), development/ROADMAP.md:113 (#3 row) 등 다수. § 4 → WORKFLOW.md 이동 시 'WORKFLOW.md § N 끝 매트릭스 #M row' 형식 동시 cascade 갱신 의무"
    },
    {
      "id": "cb_8",
      "ref": "smoke 5 안 ARCHITECTURE § 6/§ 6.1 + § 7.2 + § 7.4 인용",
      "finding": "smoke-bundle-trigger.sh:4/49/102/128 (§ 6.1 + § 7.4), smoke-open-stage-discipline.sh:4/72/81 (§ 6.1 + § 7.4), smoke-spec-verification.sh:8/332 (§ 6 + § 7.4), smoke-scope-contract.sh:9 (§ 6), smoke-entry-title-guideline.sh:4/138 (§ 7.2). 본 작업 안 § 6 → OPERATIONS / § 7.2 → OPERATIONS / § 7.4 → WORKFLOW 이동 시 smoke 5 의 comment + error message 안 path 동시 갱신 의무 (sc_6 검증 통과 필수)"
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "cascade host 갱신 방식 — 수동 grep replace 채택 (cascade-source marker 신설 폐기)",
      "rationale": "현재 active host 36 = marker 미부착. marker 신설 작업 (v6.4 cascade_sync.py 자동 동기) 가능하나 본 작업 scope 확대 — 별 milestone 후보 (identity-cascade-host-count-smoke 와 본질 정합). 본 작업 = 분리 + 1회 manual cascade 정합으로 한정. grep 3 형식 규율 (v8.2 deferred 해소) 의무 적용"
    },
    {
      "id": "opt_2",
      "label": "§ 번호 정책 — 보존 채택 (재번호 폐기)",
      "rationale": "ARCHITECTURE 안 § 1/2/3/9/10 잔류 → § 번호 그대로 보존. WORKFLOW.md 안 § 1 부터 새로 부여 (구 § 4 → 신 § 1). OPERATIONS.md 안 § 1 부터 새로 부여 (구 § 5 → 신 § 1). 재번호 시 cross-ref 폭발 risk (현 § 4 인용 host 다수 = WORKFLOW.md § 1 로 일괄 변경 → 한 번에 정합. 만약 ARCHITECTURE 안 § 4 → § 4 보존 시 빈 § 번호 발생 — 본질 손상). 결국 보존 = 새 파일 안 새 § 번호 + 구 ARCHITECTURE 안 § 번호 hole 처리"
    },
    {
      "id": "opt_3",
      "label": "ARCHITECTURE 안 § 번호 hole 처리 — 재번호 채택 (보존 + hole 폐기)",
      "rationale": "opt_2 (§ 번호 보존) 의 부산물 — ARCHITECTURE 잔류 § 1/2/3/9/10 = 비연속. 후속 결정: (a) 비연속 유지 (§ 1/2/3/9/10 그대로, '구 § 4~7+11 = WORKFLOW/OPERATIONS 로 이동' note) vs (b) 재번호 (잔류 § = § 1/2/3/4/5). (b) = 새 § 번호 정합 ↑ but cascade host (특히 § 9 / § 10 인용) 갱신 의무. (a) = cascade host 변경 없음 (§ 9 / § 10 그대로) but § 번호 비연속 인지 부담. DESIGN 안 사용자 명시 결정. 본 RESEARCH 추천 = (b) 재번호 (장기 가독성 + 한 번에 정합 + 분리 작업 본질로 자연)"
    },
    {
      "id": "opt_4",
      "label": "phase 분해 — 2 phase 채택",
      "rationale": "phase-1 = 분리 (3 파일 신설/슬림화) + 활성 cascade host 갱신 + smoke 5 안 path 갱신. phase-2 = smoke 전체 PASS 검증 + drift 정합 finalize. 단일 phase 도 가능 (atomic commit) 이지만 cost 추정상 phase-1 = +1000 LOC 이내 / phase-2 = 검증 only — 분해 자연. DESIGN 안 결정"
    },
    {
      "id": "opt_5",
      "label": "WORKFLOW.md / OPERATIONS.md 위치 — development/ flat 채택",
      "rationale": "ARCHITECTURE.md 동위 (development/ARCHITECTURE.md + development/WORKFLOW.md + development/OPERATIONS.md). subdirectory (development/canonical/) 신설 = 과잉 분리 (3 파일 = subdirectory 가치 미달). flat = 자연"
    },
    {
      "id": "opt_6",
      "label": "WORKFLOW.md / OPERATIONS.md 로드 방식 — lazy load 채택 (CLAUDE.md @import 폐기)",
      "rationale": "CLAUDE.md @import 추가 시 always-loaded — WORKFLOW.md (~13K tokens) + OPERATIONS.md (~4K tokens) 가 매 세션 자동 로드. 본 milestone 1차 의도 (토큰 우려) 와 직접 충돌. lazy load = CLAUDE.md 안 cross-ref pointer 만 + 필요 stage 안 Read on-demand. 현 ARCHITECTURE.md 동일 패턴 정합"
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "cascade host 누락 — 37 file 안 active host 갱신 시 grep 3 형식 (relative path / 절대 path / anchor) 중 1 형식 누락 시 1~N host drift 잠복 (v1.4 lessons #1 origin, v8.2 deferred 해소 evidence)",
      "mitigation": "grep 3 형식 모두 적용 의무 (v8.2 규율). EXECUTE phase-1 안 (1) `\\.\\./.*ARCHITECTURE\\.md` (2) `development/ARCHITECTURE\\.md` (3) `ARCHITECTURE\\.md.*§|anchor` 3 query 병렬 실행. phase-2 VERIFY 안 회귀 검증 — `grep -rE 'ARCHITECTURE.*§ (4|5|6|7|11)' --include='*.md' --include='*.sh'` 잔존 0 확인"
    },
    {
      "id": "risk_2",
      "description": "smoke FAIL — smoke 5 (smoke-bundle-trigger / smoke-open-stage-discipline / smoke-spec-verification / smoke-scope-contract / smoke-entry-title-guideline) 안 comment + error message 안 ARCHITECTURE § 6.1 / § 7.2 / § 7.4 인용 path 갱신 누락 시 사용자 facing 메시지 안 stale reference 발생. smoke 로직 자체는 path-agnostic 이라 FAIL 아님 — 그러나 메시지 drift 본질",
      "mitigation": "EXECUTE phase-1 안 smoke 5 의 comment + error message 동시 갱신. sc_6 검증 = smoke PASS 통과 의무 (smoke 로직 자체 회귀 0 검증). phase-2 VERIFY 안 smoke 5 메시지 안 ARCHITECTURE 인용 잔존 0 확인"
    },
    {
      "id": "risk_3",
      "description": "historical milestone trace 580 회 오인 갱신 — milestones/v*/MILESTONE.md / RESEARCH.md / DESIGN.md 등 안 ARCHITECTURE § 인용 갱신 시 oos_1 위반 (역사 보존 본질 손상)",
      "mitigation": "grep --exclude path 의무 (development/milestones/** + projects/*/milestones/** + projects/*/audit-* 5건 제외 기준 cb_2 정합). EXECUTE phase-1 안 path filter 명시. phase-2 VERIFY 안 historical milestone 변경 0 확인 — v9.1 산출물 제외하고 다른 historical milestone (development/milestones/v{X.Y} where X.Y != 9.1 + projects/upbit/milestones/** + projects/upbit/audit-*) 안 변경 0. 검증 명령 예시 = `git diff --name-only HEAD~ -- '**/milestones/**' | grep -v 'milestones/v9\\.1/'` 부재"
    },
    {
      "id": "risk_4",
      "description": "§ 번호 재번호 (opt_3 채택 시) 안 ARCHITECTURE 잔류 § 9 / § 10 인용 host (.claude/rules/README.md / development/CLAUDE.md / GUARDRAILS.md 등) drift",
      "mitigation": "opt_3 결정에 따라 분기 — 보존 (a) = cascade 변경 0 / 재번호 (b) = § 9 → § 4 / § 10 → § 5 cascade 의무. DESIGN d 안 결정 + risk_mitigation 매핑. 추천 = (b) 재번호 + 본 작업 안 한 번에 cascade 정합 (장기 가독성)"
    },
    {
      "id": "risk_5",
      "description": "WORKFLOW.md / OPERATIONS.md 신규 파일 안 CLAUDE.md @import 추가 시 always-loaded 토큰 증가 (~17K tokens 추가) — 본 milestone 1차 의도 직접 충돌",
      "mitigation": "opt_6 채택 (lazy load) — CLAUDE.md 안 cross-ref pointer 만 추가 (예: '워크플로우 정의: development/WORKFLOW.md / 운영 매뉴얼: development/OPERATIONS.md'). 필요 stage 안 Read on-demand. always-loaded ↑ 부재"
    },
    {
      "id": "risk_6",
      "description": "§ 7 sub-split 안 본질 손실 — § 7.1 (AI Native 정의) / § 7.2 (entry title) → OPERATIONS / § 7.3 (Stage 본질) / § 7.4 (가벼운 흐름) → WORKFLOW 분리 시 § 7 = AI Native 운영 통합 본질이 분산. § 7.1 정의 ↔ § 7.3 Stage 본질 cross-ref 끊김 risk",
      "mitigation": "분리 후 WORKFLOW.md 안 § Stage 본질 / § LIGHTWEIGHT 트랙 = 'OPERATIONS.md § AI Native 정의 (3면 매트릭스) 의 컨텍스트 효율 면 적용' pointer 명시. OPERATIONS.md 안 § AI Native 정의 = 'WORKFLOW.md § Stage 본질 / § LIGHTWEIGHT 트랙' pointer 명시. cross-ref 명시로 본질 통합 보존"
    },
    {
      "id": "risk_7",
      "description": "stage-design/SKILL.md:111 안 § 6.2 stale reference (memory feedback_section_6_2_abolished 정합 — 폐지) — 본 작업과 별개 drift 이나 cascade 갱신 중 발견. 정정 또는 거명 결정 필요",
      "mitigation": "본 milestone scope 외 (oos 안 명시 부재) — DESIGN 안 거명 (## SCOPE_OUT_NOTES 후보) + 별 가벼운 흐름 lessons P3 후보 등재. EXECUTE 시 stale reference 정정 = scope 확대 risk → 거명만 유지"
    }
  ]
}
```

### Narrative

본 RESEARCH 의 핵심 발견은 세 가지다. (1) raw cascade host detect = 37 file (sc_4 추정 15~20 보다 많음) — 단 본 raw 안 historical/audit trace 포함 (CHANGELOG dated entry / docs/adr append-only / projects/*/audit-* / projects/*/milestones/**) 이라 active update target 은 DESIGN 안 historical 제외 후 ≈ 28~30 file 으로 확정 (cb_2 정합). raw "active" 표현 회피 — RESEARCH 본질 = raw 발견 + active update target 분류 보정 source. (2) ARCHITECTURE.md 안 § sub-section 분포가 INTENT 결정과 정확 정합 — § 3 (7 sub) 모두 잔류 / § 7 (4 sub) 정확 분리 (7.1+7.2 OPERATIONS / 7.3+7.4 WORKFLOW) / § 10 (3 sub) 모두 잔류 / § 11 (6 sub) 모두 WORKFLOW. (3) line distribution 추정 = ARCHITECTURE 40% / WORKFLOW 44% / OPERATIONS 14% — 본 milestone 1차 의도 (토큰 우려) 부수 이득은 풀로드 시 30K 단일 → 본질별 부분 로드 가능.

options 6건 안 핵심 결정 2건은 (a) **opt_3 § 번호 재번호 (RESEARCH 추천)** + (b) **opt_6 lazy load (CLAUDE.md @import 폐기)**. opt_3 재번호 채택 시 ARCHITECTURE 잔류 § 1/2/3/4/5 정합 (기존 § 9 → 신 § 4 / 기존 § 10 → 신 § 5) — 비연속 hole 부재 + 장기 가독성. opt_6 lazy load 는 본 milestone 1차 의도 직접 정합 — @import 시 always-loaded 17K 추가 = 의도 충돌. CLAUDE.md 안 cross-ref pointer 추가만 결정. DESIGN 안 사용자 명시 결정 게이트.

risks 7건 중 가장 critical 은 risk_1 (cascade 누락 — grep 3 형식 규율) + risk_2 (smoke 5 메시지 drift) + risk_3 (historical trace 오인 갱신). 모두 mitigation 명료 — EXECUTE phase-1 안 grep 3 형식 / smoke 5 동시 갱신 / milestones/* 제외 filter. risk_7 (§ 6.2 stale reference) 는 scope 외 거명만 — 본 작업 cascade 갱신 중 발견된 별 drift, 본 milestone scope 확대 회피.

본 RESEARCH 종합 = DESIGN 안 결정 사항 4개 식별 — (1) opt_3 § 번호 재번호 vs 보존 (a/b), (2) opt_4 phase 분해 (2 phase 추천), (3) opt_6 lazy load 확정, (4) risk_7 scope_out 거명 처리.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "opt_3 § 번호 재번호 채택 — ARCHITECTURE 잔류 § = § 1/2/3/9/10 → 신 § 1/2/3/4/5 (연속 재번호) + § 8 (관련 문서) → 신 § 6 잔류 (자명 흡수). 신 § 4 = 구 § 9 (3-way 직교) / 신 § 5 = 구 § 10 (Auto-Mode 최소권한) / 신 § 6 = 구 § 8 (관련 문서, 재배치).",
      "rationale": "사용자 명시 결정 (round 1 AskUserQuestion). 연속 § 번호 = 장기 가독성 ↑ + 한 번에 cascade 정합. hole 유지 시 인지 부담 + 'cf. § 4~7+11 이동 note' narrative 의무. cascade 갱신 의무 ↑ but 본 milestone 안 동시 처리 자연 (재번호 cascade + 분리 cascade 가 한 phase 안 통합)."
    },
    {
      "id": "d_2",
      "decision": "opt_4 phase 분해 2 phase 채택 — phase-1 = 분리 + cascade 갱신 + smoke 5 메시지 갱신 (큰 phase, atomic mechanical) / phase-2 = active smoke 15 전체 PASS + drift grep 0 검증 (검증 only).",
      "rationale": "사용자 명시 결정 (round 2 AskUserQuestion). v9.0 동일 패턴 (phase-1 본문 변경 + phase-2 검증). cost 분포 = phase-1 ~1500 LOC ± 200 + phase-2 ~50 LOC (smoke result only). 단일 phase atomic 도 가능 but 검증 trace 분리 = stage gate 본질 ↑."
    },
    {
      "id": "d_3",
      "decision": "opt_6 lazy load 채택 — CLAUDE.md @import 추가 폐기. 신 WORKFLOW.md / OPERATIONS.md = lazy load (cross-ref pointer 만 추가, 현 ARCHITECTURE.md 동일 패턴).",
      "rationale": "본 milestone 1차 의도 (토큰 우려) 직접 정합. @import 시 always-loaded ~17K 토큰 추가 = 의도 충돌. CLAUDE.md root 안 cross-ref pointer 1~2 줄 추가 (예: '워크플로우 정의 → development/WORKFLOW.md / 운영 매뉴얼 → development/OPERATIONS.md'). 필요 stage 안 Read on-demand. risk_5 mitigation 직접 정합."
    },
    {
      "id": "d_4",
      "decision": "opt_1 cascade host 갱신 = 수동 grep replace 채택 — cascade-source marker 신설 폐기. 본 작업 안 marker 추가 부재 (현 marker 1건 active = CLAUDE.md self-host 보존).",
      "rationale": "marker 신설 = scope 확대 (별 milestone identity-cascade-host-count-smoke candidate 와 본질 정합). 본 작업 = 1회 manual cascade 정합으로 한정. grep 3 형식 규율 (v8.2 deferred 해소) 의무 적용 — relative path / 절대 path / anchor."
    },
    {
      "id": "d_5",
      "decision": "opt_5 WORKFLOW.md / OPERATIONS.md 위치 = development/ flat 채택 — ARCHITECTURE.md 동위 (development/ARCHITECTURE.md + development/WORKFLOW.md + development/OPERATIONS.md).",
      "rationale": "subdirectory (development/canonical/) 신설 = 3 파일 = 가치 미달 (과잉 분리). flat = 자연 — meta 안 다른 canonical source (ARCHITECTURE / ROADMAP) 동위."
    },
    {
      "id": "d_6",
      "decision": "§ 매핑 확정 — ARCHITECTURE (잔류 + 재번호): § 1 디렉토리 (보존) / § 2 모듈 책임 (보존) / § 3 하네스 정의 7 sub (보존) / § 4 3-way 직교 (구 § 9, 3 sub) / § 5 Auto-Mode (구 § 10, 3 sub) / § 6 관련 문서 (구 § 8 재배치). WORKFLOW.md (신규): § 1 9-stage + bundling + 끝 매트릭스 (구 § 4) / § 2 Stage 본질 (구 § 7.3) / § 3 가벼운 흐름 (구 § 7.4) / § 4 분야 발현 6 sub (구 § 11). OPERATIONS.md (신규): § 1 비대칭 의도 (구 § 5) / § 2 era 정책 (구 § 6, 1 sub) / § 3 AI Native 정의 (구 § 7.1) / § 4 Entry title 가이드 (구 § 7.2).",
      "rationale": "INTENT sc_1/sc_2/sc_3 + RESEARCH cb_3 § sub-section 분포 직접 매핑. § 7 sub-split = § 7.1/7.2 → OPERATIONS / § 7.3/7.4 → WORKFLOW (사용자 명시). § 7 통합 본질 손실 (risk_6) 은 d_7 cross-ref 명시로 보존."
    },
    {
      "id": "d_7",
      "decision": "§ 7 sub-split 본질 통합 보존 (risk_6 mitigation) — WORKFLOW.md § 2 (Stage 본질) + § 3 (가벼운 흐름) 안 'OPERATIONS.md § 3 AI Native 정의 (3면 매트릭스 = 컨텍스트 효율 + 자율성 + 다중 AI 협업) 의 컨텍스트 효율 면 적용' pointer 명시. OPERATIONS.md § 3 (AI Native 정의) 안 'WORKFLOW.md § 2 Stage 본질 / § 3 가벼운 흐름 = 컨텍스트 효율 면 실 적용 사례' pointer 명시. cross-ref 양방향.",
      "rationale": "§ 7 = AI Native 운영 통합 본질 (정의 + entry title + Stage 본질 + LIGHTWEIGHT 트랙). sub-split 안 본질 단절 risk. cross-ref 명시 = 통합 narrative 보존 + 1차 source 단일 정합."
    },
    {
      "id": "d_8",
      "decision": "risk_7 § 6.2 stale reference (stage-design SKILL:111) scope_out 거명 — 본 milestone ## SCOPE_OUT_NOTES 안 거명 (v7.0 T1.3 정합, H2 신규 생성). 별 가벼운 흐름 lessons P3 후보 (정정 작업 = 1 줄 edit, 가벼운 흐름 자연).",
      "rationale": "본 작업과 별개 drift (stage-design SKILL 안 폐지된 § 6.2 인용, memory feedback_section_6_2_abolished 정합). 본 milestone scope 확대 회피 (1 줄 edit 이지만 cascade 갱신 본질 분리). 거명 = 발견 보존 + 후속 발의 trigger source."
    },
    {
      "id": "d_9",
      "decision": "신규 파일 안 heading 구조 (intro paragraph + § 1~N) — WORKFLOW.md intro = '본 파일은 development/ARCHITECTURE.md 의 워크플로우 본질 (9-stage / bundling / Stage 본질 / 가벼운 흐름 / 분야 발현 mechanism) 단일 source' + OPERATIONS.md intro = '본 파일은 development/ARCHITECTURE.md 의 운영 본질 (비대칭 의도 / era 정책 / AI Native 정의 / entry title 가이드) 단일 source'. 두 파일 모두 lazy load (CLAUDE.md @import 부재).",
      "rationale": "신규 1차 source 본질 명시 + ARCHITECTURE.md 동위 narrative + lazy load 명시. 의도 단일 source 정합 (d_3 lazy load 와 직접 정합). 신 ARCHITECTURE.md intro 안 'workflow 본질 → WORKFLOW.md / operations 본질 → OPERATIONS.md' cross-ref 추가 의무 (3 파일 cross-ref hub)."
    }
  ],
  "approach": "본 milestone = ARCHITECTURE.md (현 559 줄) 안 § 4/5/6/7/11 + § 7 sub-split (§ 7.3/7.4 → WORKFLOW / § 7.1/7.2 → OPERATIONS) → development/WORKFLOW.md (신규, ~248 줄) + development/OPERATIONS.md (신규, ~79 줄) 신설. 잔류 § (§ 1/2/3/8/9/10) 재번호 → 신 § 1/2/3/4/5/6 (§ 6 = 구 § 8 관련 문서, 재배치). cascade host ~28~30 file (raw 37 - historical 7~9 = active update target) = 새 path/§ 매핑 + smoke 5 메시지 갱신. 2 phase 분해 — phase-1 atomic mechanical (분리 + cascade), phase-2 검증 only (smoke 15 PASS + drift grep 0). risk 7 → mitigation 7 1:1 매핑 (d_X 매핑 정합).",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "ARCHITECTURE.md 슬림화 (§ 4/5/6/7 본문 제거 + § 11 제거) + 잔류 § 재번호 (§ 9 → 신 § 4 / § 10 → 신 § 5 / § 8 → 신 § 6 재배치) + intro paragraph 안 cross-ref 추가 (WORKFLOW.md / OPERATIONS.md) + WORKFLOW.md 신설 (§ 1 9-stage + bundling + 끝 매트릭스 / § 2 Stage 본질 / § 3 가벼운 흐름 / § 4 분야 발현 6 sub + d_7 cross-ref 명시) + OPERATIONS.md 신설 (§ 1 비대칭 의도 / § 2 era 정책 / § 3 AI Native 정의 + d_7 cross-ref 명시 / § 4 Entry title 가이드) + cascade host ~28~30 file 갱신 (grep 3 형식 의무, v8.2 규율) + smoke 5 메시지 갱신 (smoke-bundle-trigger / smoke-open-stage-discipline / smoke-spec-verification / smoke-scope-contract / smoke-entry-title-guideline 안 ARCHITECTURE § 6.1 / § 7.2 / § 7.4 인용 → 새 path/§) + CLAUDE.md root 안 cross-ref pointer 추가 (lazy load, @import 부재).",
      "deliverable": "development/ARCHITECTURE.md (slim ~222 줄, § 1~6) + development/WORKFLOW.md (신규 ~248 줄, § 1~4) + development/OPERATIONS.md (신규 ~79 줄, § 1~4) + 28~30 cascade host edit + smoke 5 메시지 edit + CLAUDE.md root cross-ref pointer edit",
      "verification": "phase-1 commit 시점 smoke 5 (smoke-spec-verification / smoke-scope-contract / smoke-bundle-trigger / smoke-open-stage-discipline / smoke-entry-title-guideline) PASS 확인. grep `ARCHITECTURE.md.*§ (4|5|6|7|11)` --exclude milestones/** + projects/*/audit-* + CHANGELOG dated + ADR 부재 (잔존 0)."
    },
    {
      "phase": "phase-2",
      "scope": "active smoke 15 전체 실행 + drift grep 0 확인 (3 형식 모두 — relative / 절대 / anchor). 잔존 drift 발견 시 phase-2 안 정정 (phase-1 회귀 trace 보존). sc_6 검증 통과 evidence 작성.",
      "deliverable": "smoke result trace (VERIFY 안 흡수 본질) + drift grep result trace (잔존 0 확인) + sc_6 통과 evidence",
      "verification": "active smoke 15 PASS + grep 3 형식 모두 잔존 0 (`grep -rE 'ARCHITECTURE.*§ (4|5|6|7|11)' --include='*.md' --include='*.sh'` 부재, milestones/** + audit-* + ADR + CHANGELOG dated 제외)"
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_4",
      "method": "수동 grep replace + grep 3 형식 규율 (v8.2 deferred 해소). phase-1 안 (1) `\\.\\./.*ARCHITECTURE\\.md` (2) `development/ARCHITECTURE\\.md` (3) `ARCHITECTURE\\.md.*§|anchor` 3 query 병렬 실행. phase-2 VERIFY 안 회귀 검증."
    },
    {
      "risk_ref": "risk_2",
      "decision_ref": "d_6",
      "method": "phase-1 안 smoke 5 comment + error message 동시 갱신 (smoke 로직 path-agnostic 이라 FAIL 아님 — message drift 본질). phase-1 commit 시점 smoke 5 PASS 확인."
    },
    {
      "risk_ref": "risk_3",
      "decision_ref": "d_6",
      "method": "grep --exclude path 의무 (development/milestones/** + projects/*/milestones/** + projects/*/audit-* + CHANGELOG dated + docs/adr/* 5건 제외, cb_2 정합). phase-2 VERIFY 안 historical milestone 변경 0 확인 (`git diff --name-only HEAD~ -- '**/milestones/**' | grep -v 'milestones/v9\\.1/'` 부재)."
    },
    {
      "risk_ref": "risk_4",
      "decision_ref": "d_1",
      "method": "§ 9 → 신 § 4 / § 10 → 신 § 5 / § 8 → 신 § 6 cascade 갱신 phase-1 안 한 번에 정합. 인용 host = .claude/rules/README / GUARDRAILS / development/CLAUDE.md / tests/CLAUDE.md / agents/audit-orchestrator / harness-meta.md 등."
    },
    {
      "risk_ref": "risk_5",
      "decision_ref": "d_3",
      "method": "CLAUDE.md root 안 cross-ref pointer 만 추가 (lazy load). @import 부재 — 본 milestone 1차 의도 (토큰 우려) 정합."
    },
    {
      "risk_ref": "risk_6",
      "decision_ref": "d_7",
      "method": "WORKFLOW.md § 2/§ 3 ↔ OPERATIONS.md § 3 cross-ref 양방향 명시. § 7 = AI Native 운영 통합 본질 narrative 보존."
    },
    {
      "risk_ref": "risk_7",
      "decision_ref": "d_8",
      "method": "본 milestone ## SCOPE_OUT_NOTES 안 거명 (v7.0 T1.3 정합). EXECUTE phase 안 정정 부재 (scope 확대 회피). 별 가벼운 흐름 lessons P3 후보 발의 trigger."
    }
  ],
  "five_perspective_review": {
    "method": "inline self-review (lightweight) — design-review subagent skip 결정 (cycle 3 converged 1.09× evidence, memory feedback_subagent_parallel_review_evidence). 본 작업 scope = 분리 + cascade mechanical, 결정 명료 (사용자 명시 결정 round 2 통과). subagent review effort ↓.",
    "perspectives": [
      {
        "perspective": "architecture",
        "verdict": "PASS",
        "comments": "사전적 정의 정합 ↑ — § 분류 = 구조 (ARCHITECTURE) / 워크플로우 (WORKFLOW) / 운영 매뉴얼 (OPERATIONS) 본질 명료. § 7 sub-split 안 본질 손실은 d_7 cross-ref 명시로 보존. decisive issue 0건."
      },
      {
        "perspective": "spec-drift",
        "verdict": "PASS",
        "comments": "schema 변경 부재 (workflow 의미 변경 X, oos_2 / operations policy 변경 X, oos_3). 산출물 schema (milestone artifacts / smoke contract) 영향 부재. § 번호 재번호 = path drift 본질 (1회 정합 의무, d_1). decisive issue 0건."
      },
      {
        "perspective": "security",
        "verdict": "PASS",
        "comments": "보안 영향 부재 — 문서 분리 본질 (코드 변경 부재). 인증 / 권한 / 비밀 / 의존성 영향 0. decisive issue 0건."
      },
      {
        "perspective": "performance",
        "verdict": "pass-with-comments",
        "comments": "토큰 효율 부수 이득 (풀로드 시 30K → 본질별 부분 로드 가능, ~12K + ~13K + ~4K 분리). 본 milestone 1차 의도 (토큰 우려) 직접 정합. 단 lazy load (d_3) 정합 의무 — @import 추가 시 always-loaded 17K 증가로 의도 충돌. comments only."
      },
      {
        "perspective": "dx",
        "verdict": "pass-with-comments",
        "comments": "cross-ref 갱신 ~28~30 host = 단기 cost. 장기 본질 명료 ↑ (architecture vs workflow vs operations 1차 source 분리 명료). § 7 sub-split 안 본질 통합 narrative (d_7) 가 DX 핵심 — cross-ref 양방향 명시로 통합 보존. decisive issue 0건. comments only (단기 cost trade-off, 사용자 의지 합의)."
      }
    ]
  }
}
```

### Narrative

본 DESIGN 의 9 decisions 는 RESEARCH 6 options + 7 risks → 1:1 매핑 본질. d_1~d_3 = 사용자 명시 결정 (round 1/2 AskUserQuestion) + 1차 의도 정합 (lazy load). d_4~d_6 = RESEARCH 자명 결정 (수동 grep / development/ flat / § 매핑). d_7 = risk_6 (§ 7 sub-split 본질 손실) mitigation 직접 정합 (cross-ref 양방향). d_8 = risk_7 scope_out 거명 (## SCOPE_OUT_NOTES H2 신규 생성). d_9 = 신규 파일 안 intro narrative + 신 ARCHITECTURE.md intro 안 cross-ref hub 정합.

approach = 2 phase 분해 — phase-1 atomic mechanical (분리 + 재번호 + 신규 파일 신설 + cascade 28~30 host + smoke 5 메시지 + CLAUDE.md root cross-ref pointer) / phase-2 검증 only (smoke 15 전체 PASS + drift grep 0). phase-1 cost 추정 = +1500 LOC ± 200 / phase-2 cost ≈ +50 LOC (smoke result trace).

risk_mitigation = 7 risks → 7 d_X 매핑 (risk_1→d_4, risk_2→d_6, risk_3→d_6, risk_4→d_1, risk_5→d_3, risk_6→d_7, risk_7→d_8). 각 mitigation = 명시 method + phase 안 검증.

five_perspective_review = inline self-review (cycle 3 converged 1.09×, subagent skip). architecture / spec-drift / security 3 = PASS (decisive 0). performance / dx 2 = pass-with-comments (긍정 trade-off, 사용자 의지 합의). 종합 verdict = PASS — APPROVE 진입 가능.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-28",
    "approval_summary": "DESIGN 9 decisions (d_1~d_9) + 2 phase + risk_mitigation 7 (1:1 매핑) + inline 5 관점 review (architecture/spec-drift/security PASS + performance/dx pass-with-comments, 종합 verdict = PASS) 종합 승인. 사용자 명시 결정 round 2 (round 1 § 번호 재번호 + round 2 phase 분해 2) + DESIGN 종합 승인 round (본 게이트) = 총 3 round 사용자 명시 결정 통과. EXECUTE phase-1 진입 게이트 통과."
  },
  "scope_confirmed": [
    {
      "id": "R1",
      "ref": "d_1 § 번호 재번호 + d_6 § 매핑 확정",
      "confirmed": "ARCHITECTURE 잔류 § 1/2/3/4/5/6 (구 § 9→신 § 4 / 구 § 10→신 § 5 / 구 § 8→신 § 6) + WORKFLOW.md § 1/2/3/4 (구 § 4/7.3/7.4/11) + OPERATIONS.md § 1/2/3/4 (구 § 5/6/7.1/7.2) 매핑 확정"
    },
    {
      "id": "R2",
      "ref": "d_2 phase 2 분해",
      "confirmed": "phase-1 atomic mechanical (분리 + 재번호 + 신규 파일 + cascade ~28~30 + smoke 5 메시지 + CLAUDE.md root cross-ref) / phase-2 검증 only (active smoke 15 + drift grep 0)"
    },
    {
      "id": "R3",
      "ref": "d_3 lazy load + d_5 development/ flat",
      "confirmed": "WORKFLOW.md / OPERATIONS.md = development/ flat + CLAUDE.md @import 폐기 (cross-ref pointer 만, lazy load). 본 milestone 1차 의도 (토큰 우려) 직접 정합"
    },
    {
      "id": "R4",
      "ref": "d_4 cascade host 갱신 방식 + d_7 § 7 sub-split cross-ref",
      "confirmed": "수동 grep replace (cascade-source marker 신설 폐기) + grep 3 형식 규율 (v8.2 deferred 해소) + WORKFLOW.md § 2/3 ↔ OPERATIONS.md § 3 cross-ref 양방향"
    },
    {
      "id": "R5",
      "ref": "d_8 § 6.2 stale scope_out + ## SCOPE_OUT_NOTES 신규",
      "confirmed": "stage-design SKILL:111 § 6.2 stale reference = ## SCOPE_OUT_NOTES 안 거명 (v7.0 T1.3 정합) + 별 가벼운 흐름 lessons P3 candidate. 본 milestone scope 확대 회피"
    },
    {
      "id": "R6",
      "ref": "risk_mitigation 7 (1:1 매핑)",
      "confirmed": "risk_1→d_4 (cascade 누락 mitigation grep 3 형식) / risk_2→d_6 (smoke 메시지 drift) / risk_3→d_6 (historical trace 제외 5 path) / risk_4→d_1 (재번호 cascade) / risk_5→d_3 (always-loaded 회피 lazy load) / risk_6→d_7 (§ 7 sub-split cross-ref) / risk_7→d_8 (scope_out 거명)"
    },
    {
      "id": "R7",
      "ref": "five_perspective_review 종합 verdict = PASS",
      "confirmed": "inline self-review (subagent skip, cycle 3 converged 1.09× evidence). architecture/spec-drift/security = PASS / performance/dx = pass-with-comments (긍정 trade-off). decisive issue 0 + EXECUTE 진입 게이트 통과"
    }
  ]
}
```

### Narrative

본 APPROVE = DESIGN 종합 승인 본질. 사용자 명시 결정 통과 시퀀스 = round 1 (§ 번호 재번호 확정) → round 2 (phase 2 분해 확정) → round 3 (본 APPROVE 게이트, DESIGN 9 decisions + 2 phase + risk 7 + 5 관점 review 종합 승인). scope_confirmed 7 (R1~R7) = DESIGN 본질별 사용자 확정 trace — EXECUTE phase-1 진입 시 정합 source.

EXECUTE phase-1 진입 게이트 통과. 다음 행동 = phase-1 atomic mechanical (분리 + 재번호 + 신규 파일 신설 + cascade ~28~30 + smoke 5 메시지 + CLAUDE.md root cross-ref).

## EXECUTE

### phase-1 (완료, 2026-05-28)

ARCHITECTURE.md (559 줄, 30K tokens) 안 § 4/5/6/7/11 + § 7 sub-split → development/WORKFLOW.md (신규, 265 줄, 13K) + development/OPERATIONS.md (신규, 92 줄, 4K) 신설. 잔류 § (§ 1/2/3/8/9/10) 재번호 → 신 § 1/2/3/4/5/6 (구 § 9→신 § 4 / 구 § 10→신 § 5 / 구 § 8→신 § 6 재배치). cascade host 28 file 새 path/§ 매핑 + smoke 5 메시지 갱신 + CLAUDE.md root 안 신 cross-ref pointer 추가 (lazy load).

Python script atomic mechanical — SECTION_MAP long pattern first (4 끝 / 7.4 / 7.3 / 7.2 / 7.1 / 6.1 / 4.1 / 11 / 10 / 9 / 8 / 7 / 6 / 5 / 4) + link target path fix (link text ↔ target 정합) + self-ref 변환. Codex 검토 6 finding (cascade 누락 5 + ## EXECUTE 본책 보강 1) 일괄 정정 후 commit.

검증 = smoke 5 PASS (spec-verification PASS=547 / scope-contract PASS=122 / bundle-trigger PASS / open-stage-discipline PASS / entry-title-guideline PASS) + drift grep 잔존 0 (scope_out 거명 + historical narrative 제외).

별책 = [`execute/phase-1.md`](execute/phase-1.md) (Spec + Narrative + delta + phase-2 진입 게이트).

### phase-2 (보류, 진입 게이트 통과 후)

active smoke 15 전체 PASS + drift 정합 finalize 본질. 잔존 issue 발견 시 phase-2 안 정정 (phase-1 회귀 trace 보존). sc_6 통과 evidence 작성.

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음. INTENT/DESIGN 안 sub-milestone 분리 필요성 재평가 가능.)

## SCOPE_OUT_NOTES

DESIGN 5 관점 inline self-review 안 거명된 scope 외 본질 1건 — 본 milestone scope (분리 + cascade) 안 포함 부재, 후속 milestone candidate source. v7.0 T1.3 정합 (거명 있을 때만 H2 생성).

1. **§ 6.2 stale reference 정정** (D8, risk_7 origin) — `skills/stage-design/SKILL.md:111` 안 'ARCHITECTURE.md § 6.2 — Narrative 정전화 3 단계 패턴 (v3.21 정전화)' 인용. 실제 ARCHITECTURE 안 § 6.2 H3 sub-section 부재 (memory `feedback_section_6_2_abolished` 정합 — § 6.2 폐지 v4.0). 본 작업과 별개 drift — 정정 작업 = SKILL.md 1 줄 edit (§ 6.2 → 적절 § 참조 또는 reference 제거). 본 milestone scope 확대 회피 (분리 본질 + 1 줄 정정 mechanical 분리). 후속 = 가벼운 흐름 lessons P3 candidate (작은 건 = 4 섹션 LIGHTWEIGHT.md 자연).
