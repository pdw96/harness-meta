# RESEARCH — v3.0_milestones-restructure

```json
{
  "external": [
    {
      "source": "semver.org",
      "topic": "major.minor.patch — breaking change 시 major bump",
      "findings": "본 milestone 은 ROADMAP schema + 디렉토리 명 + 기존 cross-ref 모두 변경 = breaking change → major bump (v2 → v3) 정합.",
      "drift": "없음 — CLAUDE.md '단조 증가, breaking change 시 major bump' 정책과 일치"
    },
    {
      "source": "release train 모델 (Linux kernel merge window, Chromium channel)",
      "topic": "같은 train (= version) 안의 여러 feature (= sub-milestone) grouping",
      "findings": "version = release train, sub-milestone = train 안 feature, phase = commit 단위 — 본 milestone 의 hierarchy 와 일치. 차이점은 release train 은 시간 단위 (예: 6주), 본 milestone 은 의미 단위 (같은 정책/주제).",
      "drift": "없음 — '의미 단위 grouping' 으로 본 milestone 차별화 명시 (release train 의 시간 의존성 없음)"
    },
    {
      "source": "v2.0_workflow-word-fidelity (선례)",
      "topic": "자기참조 회피 vs 부합",
      "findings": "v2.0 은 7-stage → 9-stage 정책 정의 milestone 자체가 자기참조 회피 표지 (구 7-stage 포맷 사용). 본 v3.0 은 자기참조 부합 (도그푸드) 채택 — 사용자 답 기준.",
      "drift": "정책 차이 (v2.0 회피 / v3.0 부합) 의도된 정책 발전 — DESIGN.decisions 에 명시"
    },
    {
      "source": "v2.1_smoke-spawn-batching (선례)",
      "topic": "smoke 인프라 (batched python3 spawn + era 자동 식별)",
      "findings": "v2.1 의 detect_era 함수 + batched spawn 인프라 위에 4 era 추가 가능 (3 era → 4 era). lessons L4 (def detect_era 두 smoke 중복) 미해결 → v2.2_era-detect-shared-module 흡수 (phase-5) 와 함께 정합.",
      "drift": "v2.1 lessons next_candidates 4건 (era-detect / cp949 / controlled-comparison / historical-decision) 모두 본 milestone 흡수 (phase-5~8)"
    }
  ],
  "codebase": {
    "affected_files": [
      "projects/meta/ROADMAP.md (L3-L13 milestones[] schema 변경, v2.2_* 4건 제거 + v3.0 entry 신 schema 변환, phase-3)",
      "projects/meta/ARCHITECTURE.md (§ 3 5요소 매트릭스 'Workflow' 행 4 era 추가 + § 4 9-stage-bundled era 섹션 + § 6 era 정책 4 era 갱신, phase-2)",
      "projects/meta/CLAUDE.md (§ 모듈 가이드 milestone 산출물 항목 + bundle 정책 note, phase-2)",
      "claude/commands/harness-meta.md (Stage A/B 절차 + bundle 정책 trigger + version > sub-milestone > phase 계층 narrative, phase-2)",
      "tests/CLAUDE.md (§ 작성 규약 + smoke matrix 4 era 인식 항목, phase-2 + phase-6)",
      "tests/smoke-spec-verification.sh (detect_era 함수 4 era 추가 + 신 schema version+id 분리 인식, phase-1)",
      "tests/smoke-scope-contract.sh (detect_era 동일 갱신 + 9-stage-bundled era 분기 처리, phase-1)",
      "tests/_era_detect.py (신규, phase-5 v2.2_era-detect-shared-module 흡수)",
      "tests/smoke-python-entry-boilerplate.sh (sys.stdout.reconfigure AST 검증 추가, phase-6 v2.2_smoke-cp949-encoding-pattern 흡수)",
      "claude/hooks/post-report-write.sh (write trigger 패턴 신 디렉토리 milestones/v{X.Y}/REPORT.md 인식, phase-1)",
      "CLAUDE.md (root, § 워크플로우 표 4 era cross-ref 1줄 또는 ARCHITECTURE.md 참조, phase-2)",
      "README.md (cascade narrative — milestone 명명/구조 narrative 갱신, phase-2)",
      "AGENTS.md (영문 cascade — milestone hierarchy + bundle 정책 영문 요약, phase-2)",
      "GUARDRAILS.md (H 매트릭스 + § 4 7-stage 또는 9-stage Scope contract 4 era 갱신, phase-2)",
      "CHANGELOG.md (v3.0 entry 추가, phase-9 또는 REPORT 단계)",
      "docs/adr/ADR-006-workflow-revamp.md (4 era 정책 cross-ref 갱신, phase-2)",
      "projects/meta/milestones/v3.0/INTENT.md (자기참조 부합 신 schema, phase-2 commit)",
      "projects/meta/milestones/v3.0/RESEARCH.md (본 파일, phase-2 commit)",
      "projects/meta/milestones/v3.0/DESIGN.md (phase-2 commit)",
      "projects/meta/milestones/v3.0/APPROVE.md (phase-2 commit)",
      "projects/meta/milestones/v3.0/milestones.md (신규, phase-4)",
      "projects/meta/milestones/v3.0/execute/phase-{1..8}.md (각 phase commit)"
    ],
    "untouched_files_explicit": [
      "milestones/v1.84_*/ ~ milestones/v1.88_*/ (4-tier era, 14 디렉토리) — historical 보존, 디렉토리 명 unchanged",
      "milestones/v1.0_workflow-redesign/ ~ milestones/v1.4_*/ (7-stage era, ~10 디렉토리) — historical 보존",
      "milestones/v2.0_workflow-word-fidelity/ ~ milestones/v2.1_smoke-spawn-batching/ (9-stage era, 2 디렉토리) — historical 보존",
      "root ROADMAP.md (thin index, project 단위 schema) — milestone schema 범위 외 (out_of_scope)",
      "projects/upbit/ROADMAP.md — 별도 후속 milestone 후보 (out_of_scope)",
      "claude/commands/* (harness-meta.md 외) — 본 milestone 영향 없음",
      "bootstrap/skills/* — 본 milestone 영향 없음 (skill 구조 변경 없음)",
      "install.ps1 / install-skills.ps1 / verify.ps1 / verify.sh — 인프라 자동화 변경 없음"
    ],
    "current_state": "ROADMAP `milestones[]` entry id 형식 = `v{X.Y}_{slug}` flat (예: v2.2_smoke-cp949-encoding-pattern). 같은 X.Y 여러 entry 공존 (v1.1_* 6건, v1.4_* 4건, v1.5_* 2건, v2.1_* 3건, v2.2_* 4건). 디렉토리도 동일 형식 (milestones/v{X.Y}_{slug}/). milestones.md 부재. smoke era 분기 3 era (4-tier / 7-stage / 9-stage) — detect_era 함수 spec-verification + scope-contract 두 smoke 중복 (v2.1 lessons L4 미해결).",
    "target_state": "ROADMAP `milestones[]` entry 신 schema (version + id 분리, version 단위 1 entry, sub-milestone 상세는 milestones.md 위임). 디렉토리 milestones/v{X.Y}/ (sub-id 디렉토리에 없음, milestones.md JSON 으로 표현). milestones/v{X.Y}/milestones.md 신규 (sub-milestone listing). smoke era 4 era (+ 9-stage-bundled v3.0+) + tests/_era_detect.py 공유 모듈. forward-only — historical (v1.x ~ v2.1) 디렉토리 unchanged."
  },
  "options": [
    {
      "name": "A — forward-only (사용자 결정)",
      "scope": "신규 (v3.0+) 만 신 구조, historical (v1.x ~ v2.1) 보존",
      "pros": ["안전 — historical 디렉토리 명 unchanged → cross-ref 보존", "smoke 분기 3 → 4 era 추가만", "git history 손상 risk 0", "점진 마이그레이션 가능"],
      "cons": ["두 era 공존 — smoke 분기 코드 복잡 (4 era)", "tests/CLAUDE.md narrative 두 era 모두 명시 의무"],
      "verdict": "채택"
    },
    {
      "name": "B — backward retroactive",
      "scope": "모든 historical milestone retroactive renaming + 디렉토리 git mv",
      "pros": ["단일 표준", "smoke 분기 단순"],
      "cons": ["git mv 시 history 일부 손상 risk (rename detect 한계)", "cross-ref 25+ 곳 갱신 의무", "회귀 risk 큼 — historical INTENT/REPORT cross-ref"],
      "verdict": "제외 — 사용자 결정"
    },
    {
      "name": "C — dual representation",
      "scope": "기존 + 신 schema 병행, 점진 마이그레이션",
      "pros": ["호환성"],
      "cons": ["schema 복잡", "중복 source", "단일 source 원칙 위반"],
      "verdict": "제외"
    },
    {
      "name": "B' — 명명 v{X.Y}_{group-slug} + phase-{n} (사용자 결정)",
      "scope": "milestone id = v{X.Y}_{group-slug}, sub-책임 = phase-{n}, 디렉토리 = milestones/v{X.Y}/",
      "pros": ["검색성 보존 (group slug)", "기존 명명 convention 자연 발전", "phase 단순 번호"],
      "cons": ["디렉토리는 group slug 부재 (milestones/v3.0/) — id ↔ 디렉토리 inconsistency"],
      "verdict": "채택 — INTENT.md JSON 안 id 필드는 group slug, 디렉토리는 version만"
    },
    {
      "name": "version 단위 1 ROADMAP entry (사용자 결정)",
      "scope": "ROADMAP entry = version 단위 1건, sub-milestone 상세는 milestones.md 위임",
      "pros": ["정보 계층 명료 — high-level (ROADMAP) + detailed (milestones.md)", "ROADMAP 간결 보존"],
      "cons": ["sub-milestone 검색은 milestones.md 위임 (한 단계 추가)"],
      "verdict": "채택"
    },
    {
      "name": "milestones/v{X.Y}/milestones.md 위치 (사용자 결정)",
      "scope": "각 version 디렉토리 안 1건, sub-milestone listing per version",
      "pros": ["projects/<name>/ROADMAP.md 와 유사 (프로젝트별 동형)", "version 단위 자연스러운 hierarchy"],
      "cons": ["root milestones/milestones.md 같은 단일 source 부재"],
      "verdict": "채택 — root milestones/milestones.md 는 ROADMAP.md 가 이미 thin index 역할"
    },
    {
      "name": "8 phase 한 milestone (사용자 결정)",
      "scope": "phase-1 smoke era + phase-2 정책 명문화 + phase-3 ROADMAP schema + phase-4 milestones.md + phase-5~8 v2.2_* 흡수",
      "pros": ["통합 1 INTENT + 1 DESIGN + 1 APPROVE = 토큰 ~75% 감소", "의존 관계 명료"],
      "cons": ["partial fail 시 recovery 부담 — 단일 phase 단위 commit 으로 mitigate"],
      "verdict": "채택"
    },
    {
      "name": "자기참조 부합 (사용자 결정)",
      "scope": "v3.0 자체가 신 구조 (milestones/v3.0/ + milestones.md) 첫 적용",
      "pros": ["도그푸드 — 본 milestone 결과물이 자신을 표현", "예외 표지 부담 부재"],
      "cons": ["INTENT~APPROVE 작성 시점에 smoke 신 era 인식 부재 → phase-1 선결 필요"],
      "verdict": "채택 — phase-1 smoke era branching 선결로 mitigate"
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "smoke era 분기 코드 복잡화 — 4 era (현 3 era + 9-stage-bundled)",
      "severity": "medium",
      "mitigation": "phase-5 v2.2_era-detect-shared-module 흡수에서 tests/_era_detect.py 공유 모듈로 분리 — drift 위험 mitigate"
    },
    {
      "id": "R2",
      "risk": "자기참조 부합 inconsistency — INTENT~APPROVE 작성 시점에 smoke 신 era 인식 부재 → commit 시 smoke fail 가능",
      "severity": "high",
      "mitigation": "phase-1 smoke era branching 선결 (commit) → phase-2 INTENT~APPROVE 일괄 commit (이때 신 era smoke 통과)"
    },
    {
      "id": "R3",
      "risk": "ROADMAP schema 변경 break — 다른 도구 / hook 호환성",
      "severity": "medium",
      "mitigation": "사전 grep으로 ROADMAP.md 참조 위치 모두 식별 (본 RESEARCH affected_files 반영) + phase-3 일괄 갱신"
    },
    {
      "id": "R4",
      "risk": "post-report-write.sh write trigger 패턴 누락 — 신 구조 milestones/v{X.Y}/INTENT.md 등 인식",
      "severity": "low",
      "mitigation": "phase-1 hook 패턴 갱신 (4 era 모두 trigger 인식)"
    },
    {
      "id": "R5",
      "risk": "8 phase 큰 scope — partial fail 시 recovery 어려움",
      "severity": "low",
      "mitigation": "각 phase 1 commit, 회귀 격리, 중간 fail 시 commit 단위 revert 가능 — 9-stage workflow 자체 정신과 일치"
    },
    {
      "id": "R6",
      "risk": "historical milestone (v1.x ~ v2.1) cross-ref 깨짐 — 본 milestone 산출물이 historical reference",
      "severity": "low",
      "mitigation": "forward-only 결정으로 historical 디렉토리 unchanged → cross-ref 보존, RESEARCH affected_files 의 historical reference 는 INTENT.md narrative 에서만 사용"
    },
    {
      "id": "R7",
      "risk": "v2.2_* 4건 흡수 시 각 sub-milestone 책임 보존 누락 — milestones.md 가 단순 listing 만 되면 정보 손실",
      "severity": "medium",
      "mitigation": "milestones.md sub-milestone entry 마다 dependencies + summary 충실 보존, 흡수 commit 메시지에 원 milestone id reference 명시"
    },
    {
      "id": "R8",
      "risk": "cascade host 4곳 (README/AGENTS/GUARDRAILS/CHANGELOG) + ADR-006 narrative 갱신 누락",
      "severity": "medium",
      "mitigation": "phase-2 정책 명문화에 4 host + ADR cross-ref 1줄 추가 (보수 — 과도한 정의 중복 회피)"
    },
    {
      "id": "R9",
      "risk": "INTENT.md JSON 안 id 형식 (자기참조 부합으로 신 schema) ↔ ROADMAP.md entry (phase-3 까지 임시 기존 schema) inconsistency",
      "severity": "low",
      "mitigation": "transition state 명시 — phase-3 commit 에서 ROADMAP 도 신 schema 로 변환 → consistency 회복. 또는 INTENT.md JSON 도 임시 기존 schema (id flat) 사용 후 phase-3 변환 (Stage D 결정)"
    },
    {
      "id": "R10",
      "risk": "5 관점 검토 (Stage D) scope (16+ 파일) 큼 — subagent 검토 결과 종합 부담",
      "severity": "low",
      "mitigation": "5 관점 병렬 spawn + AskUserQuestion 으로 의견 충돌 해소 — 9-stage workflow 표준 절차"
    }
  ]
}
```

## external 검토

가장 가까운 비교는 **release train 모델** (Linux kernel merge window, Chromium release channel) — 같은 train (= version) 안의 여러 feature (= sub-milestone) grouping. 단 release train 은 시간 의존 (예: Chromium 6주 cycle), 본 milestone 은 의미 단위 (같은 정책/주제) — 시간 의존성 없음.

semver.org major.minor.patch 의 "breaking change → major bump" 정책과 본 milestone (v2 → v3) 일치. 명명 구조 + ROADMAP schema + 디렉토리 명 모두 변경 = breaking change.

v2.0 자기참조 회피 표지 (예외 7-stage 포맷) 와 본 v3.0 자기참조 부합 (도그푸드) 은 의도된 정책 차이. v2.0 시점에는 5요소 매트릭스 'Workflow' 행 단어 책임 정정이 신뢰가 부족했고, 본 v3.0 시점에는 v2.0 + v2.1 누적 신뢰로 도그푸드 우선.

## codebase 영향 분석

| # | 파일 | 영향 항목 | 변경 phase |
|---|---|---|:-:|
| 1 | `projects/meta/ROADMAP.md` | A, B, C — primary change | phase-3 |
| 2 | `projects/meta/ARCHITECTURE.md` | D, E, F, H — 정전 single source | phase-2 |
| 3 | `projects/meta/CLAUDE.md` | E — subdirectory guide | phase-2 |
| 4 | `claude/commands/harness-meta.md` | E, F — slash command 절차 | phase-2 |
| 5 | `tests/CLAUDE.md` | E, G — smoke matrix + cp949 patterns | phase-2 + phase-6 |
| 6 | `tests/smoke-spec-verification.sh` | D, G — 4 era 추가 | phase-1 |
| 7 | `tests/smoke-scope-contract.sh` | D, G — 4 era 추가 | phase-1 |
| 8 | `tests/_era_detect.py` (신규) | D — 공유 모듈 | phase-5 |
| 9 | `tests/smoke-python-entry-boilerplate.sh` | G — sys.stdout.reconfigure AST | phase-6 |
| 10 | `claude/hooks/post-report-write.sh` | E — write trigger 4 era | phase-1 |
| 11 | `CLAUDE.md` (root) | F — 워크플로우 표 cross-ref | phase-2 |
| 12 | `README.md` | H — narrative cascade | phase-2 |
| 13 | `AGENTS.md` | H — 영문 cascade | phase-2 |
| 14 | `GUARDRAILS.md` | H — H 매트릭스 + Scope contract | phase-2 |
| 15 | `CHANGELOG.md` | — entry 추가 | Stage H |
| 16 | `docs/adr/ADR-006-workflow-revamp.md` | F — cross-ref | phase-2 |
| 17~23 | `milestones/v3.0/{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `milestones.md` + `execute/phase-{1..8}.md` | 신규 | phase-2 + phase-4 + 각 phase |

(영향 항목 코드: A=ROADMAP schema / B=milestone id 패턴 / C=디렉토리 path / D=era 분기 / E=정책 host / F=workflow 표 / G=smoke era 가정 / H=narrative cascade)

## options 분석

사용자 결정 누적:

| 결정 항목 | 채택 | 제외 |
|---|---|---|
| historical 처리 | A — forward-only | B (backward), C (dual) |
| 명명 구조 | B' — v{X.Y}_{group-slug} + phase-{n} | A' (slug 제거), C' (dotted) |
| ROADMAP entry 단위 | version 단위 1 entry | sub-milestone 단위 N entry |
| milestones.md 위치 | milestones/v{X.Y}/milestones.md | milestones/milestones.md (root) |
| milestones.md 내용 | sub-milestone 상세 (id/title/status/summary/dependencies/phase 매핑) | INTENT 종합 narrative, ROADMAP 복사본 |
| 8 phase scope | 정책 4 + 흡수 4 한 milestone | v3.0 + v3.1 분할, 정책만 + 후속 |
| 자기참조 | 부합 (도그푸드) | 회피 표지 (v2.0 선례) |
| milestone id | v3.0_milestones-restructure | v3.0_milestone-bundling-naming, v3.0_milestone-hierarchy-introduction |

## risks 종합

10건 risks_identified 중 high 1건 (R2 자기참조 inconsistency), medium 4건 (R1, R3, R7, R8), low 5건. 모든 risk 에 mitigation 명시. R2 가 가장 결정적 — phase-1 smoke era branching 선결로 commit 시 신 era 인식.

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정의 (정전 single source): [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3 5요소 매트릭스 + § 6 era 정책
- INTENT: [`INTENT.md`](INTENT.md)
- 선행 milestone:
  - [`../v2.0_workflow-word-fidelity/REPORT.md`](../v2.0_workflow-word-fidelity/REPORT.md) — 9-stage workflow + 자기참조 회피 선례
  - [`../v2.1_smoke-spawn-batching/REPORT.md`](../v2.1_smoke-spawn-batching/REPORT.md) — smoke 인프라 + lessons L4 (detect_era 중복)
- 흡수 대상 (pending → v3.0 sub-milestone phase 5-8):
  - v2.2_era-detect-shared-module
  - v2.2_smoke-cp949-encoding-pattern
  - v2.2_smoke-controlled-comparison-pattern
  - v2.2_historical-7stage-stage1-decision
- ADR: [`../../../../docs/adr/ADR-006-workflow-revamp.md`](../../../../docs/adr/ADR-006-workflow-revamp.md)
