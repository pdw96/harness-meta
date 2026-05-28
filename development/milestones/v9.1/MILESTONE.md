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

(미작성 — Stage C RESEARCH 에서 작성)

## DESIGN

(미작성 — Stage D DESIGN 에서 작성)

## APPROVE

(미작성 — Stage E APPROVE 에서 사용자 명시 승인)

## EXECUTE

(미작성 — Stage F EXECUTE 에서 phase 별 작성. 본책 = phase 진행 요약, 별책 = `execute/phase-{n}.md`)

## VERIFY

(미작성 — Stage G VERIFY 에서 작성)

## REPORT

(미작성 — Stage H REPORT 에서 작성)

## PROPOSE

(미작성 — Stage I PROPOSE 에서 작성)

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음. INTENT/DESIGN 안 sub-milestone 분리 필요성 재평가 가능.)
