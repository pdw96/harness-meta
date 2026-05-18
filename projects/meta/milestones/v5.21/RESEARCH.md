# RESEARCH — v5.21 (또는 v6.0)

```json
{
  "id": "roadmap-forward-looking-redesign-and-changelog-archival",
  "title": "ROADMAP forward-looking 재정의 + CHANGELOG backfill + recent 3건 + cascade — 사전 RESEARCH",
  "external": [
    {
      "id": "ext_1",
      "source": "ARCHITECTURE.md § 4 끝 #3 narrative (v5.9_dictionary-semantics-integrated-audit 정전화)",
      "summary": "Merriam-Webster 'roadmap = 목표를 향한 진행을 안내하는 상세 계획' + Cambridge 'step-by-step visibility'. 현 projects/meta/ROADMAP.md = completed-dominant 92% (v5.9 50 entry baseline) 부합도 ~30~40%. v3.19 baseline 88.9% 대비 +3.1pp 확대",
      "implication": "본 milestone 의 evidence-base trigger 1차 source. drift 수용 → drift 해소 방향 첫 사례"
    },
    {
      "id": "ext_2",
      "source": "Keep a Changelog v1.1.0 spec (이미 본 repo CHANGELOG.md 정합)",
      "summary": "[Unreleased] 최상단 + 역순 (최신 위 / 과거 아래) entry 배치. v3.15_changelog-v3-backfill (v3.0~v3.14 14 entry) + v3.16_changelog-unreleased-position-cleanup ([Unreleased] 최상단 이동) 두 milestone 안 정전화 완료",
      "implication": "본 milestone 안 backfill (v5.7~v5.20 14 entry) + archival 이전 (recent 3건 외 41건 entry summary 흡수) 모두 Keep a Changelog 정합 보존"
    },
    {
      "id": "ext_3",
      "source": "Industry roadmap convention (general forward-looking convention — 외부 spec 명시 부재, narrative 추정 wave)",
      "summary": "Product roadmap convention 일반적 — 단순 status field 분기 (not started / in progress / shipped) + 'shipped' archive 분리 (별도 release notes 또는 changelog). 본 repo CHANGELOG = release notes 동치 역할",
      "implication": "사용자 제안 (ROADMAP = forward / CHANGELOG = past) 가 외부 일반 convention 정합. 단 외부 spec 명시 부재 인식 (spec-drift spike 패턴 정합 — context7 source 명시 시 hardcode, 본 경우 추정 narrative 유지)"
    }
  ],
  "codebase": {
    "current_state": {
      "roadmap_entries": {
        "total": 50,
        "by_status": {
          "completed": 46,
          "deferred": 3,
          "in_progress": 1,
          "pending": 0
        },
        "completed_dominant_pct": 92.0,
        "forward_looking_pct": 0.0,
        "baseline_source": "v5.9 RESEARCH § axis_c_roadmap_word (이후 v5.10~v5.20 추가 누적, 본 milestone 진입 시점 v5.21 in_progress entry 1 + completed 46 = 47 total, 단 in_progress note 추가)"
      },
      "size_metrics": {
        "roadmap_md_lines": 593,
        "roadmap_md_size_bytes": "~37000",
        "entry_summary_avg_chars": "~700~1500 (per completed entry, narrative summary)"
      },
      "changelog_state": {
        "highest_version_entry": "[v5.6]",
        "missing_versions": ["v5.7", "v5.8", "v5.9", "v5.10", "v5.11", "v5.12", "v5.13", "v5.14", "v5.15", "v5.16", "v5.17", "v5.18", "v5.19", "v5.20"],
        "count_missing": 14,
        "backfill_pattern_source": "v3.15_changelog-v3-backfill (v3.0~v3.14 14 entry, 동일 분량, 1-phase Lightweight)"
      }
    },
    "cascade_host_inventory": [
      {
        "id": "host_1",
        "file": "CLAUDE.md (root)",
        "lines": ["L33 (workflow 단어 책임 표 ROADMAP row)", "L60 (v3.0+ 9-stage-bundled schema entry 명시)", "L64 (root ROADMAP thin index)"],
        "impact": "L33 'milestone 목록 (id/title/status/summary/trigger)' narrative 갱신 필요 (forward-looking + recent reference 분리). L60 schema 변경 시 동기. L64 영향 부재 (thin index 의무 그대로)"
      },
      {
        "id": "host_2",
        "file": "claude/hooks/post-report-write.sh",
        "lines": ["L173 (PROPOSE 작성 hook 메시지)"],
        "impact": "메시지 'next_candidates 를 ROADMAP milestones[] 에 status:\"pending\" 등록' — 신 schema 안 next_candidates 등록 위치 (별도 필드 또는 'next_candidate' status 신 값) 갱신 의무. smoke-posttooluse-hook 25 checks 안 키워드 변경 검증"
      },
      {
        "id": "host_3",
        "file": "claude/commands/harness-meta.md",
        "lines": ["L93-108 (Stage A OPEN step 5-7)", "L286-287 (Stage I PROPOSE 절차)"],
        "impact": "Stage A step 6: 'ROADMAP milestones[] 배열에 신규 항목 추가 — 신 schema {version, id, title, status: in_progress, summary, trigger, milestones_path}' 신 schema 정합. Stage I step 1-2: '본 milestone status: completed 갱신 + next_candidates 를 ROADMAP milestones[] 에 status: pending 등록' — 신 schema 안 archival cycle (completed status entry 가 recent 3건 외 archival CHANGELOG 흡수) narrative 추가 의무"
      },
      {
        "id": "host_4",
        "file": "bootstrap/agents/CLAUDE.md",
        "lines": ["L198 (e3 정책 정합 narrative)"],
        "impact": "'사용자 명시 결정 후 → milestones[] 정식 등재' — 의미 보존 (e3 정책 그대로). 단 등재 위치 (신 schema 안 next_candidate 영역) 미세 cross-ref 가능"
      },
      {
        "id": "host_5",
        "file": "projects/meta/ARCHITECTURE.md",
        "lines": ["L91 (Trace 행 mechanism cross-ref)", "L151 (§ 4 끝 #3 ROADMAP drift 수용 paragraph)", "L165 (bundling 정책 entry schema)", "L208 (bundling 운용 narrative)"],
        "impact": "L91 mechanism = 'ROADMAP.milestones[] + git history' → '+ CHANGELOG.md archival' 추가. L151 § 4 끝 #3 narrative 본질 변경 (drift 수용 → drift 해소 사례 narrative 정전화). L165 schema entry 갱신. L208 bundling 운용 동기 (ROADMAP entry version 단위 1건 narrative 보존)"
      },
      {
        "id": "host_6",
        "file": "projects/meta/ROADMAP.md (본체)",
        "lines": ["L7 deferred_note (보존)", "L8 schema_note (갱신)", "L9 candidate_draft[] (벤치마크 cycle, 보존)", "L589 비고 narrative (갱신, archival 분리 narrative 추가)"],
        "impact": "L7 deferred_note v3.13/v3.14 narrative 보존 (deferred 3건 status 유지). L8 schema_note 신 schema 명시. L589 비고 '본 파일이 meta milestones[] 단일 source' → '+ CHANGELOG.md archival 의 사실 진술 단일 source' narrative 추가"
      },
      {
        "id": "host_7",
        "file": "CHANGELOG.md (본체)",
        "lines": ["L9 [Unreleased] 직후 (v5.7~v5.20 14 entry backfill 위치)", "L11 [v5.6] entry 위 (역순 정합)"],
        "impact": "v5.7~v5.20 14 entry 역순 삽입 (최신 v5.20 → 과거 v5.7) + recent 3건 외 archival 흡수 (각 ROADMAP entry summary → CHANGELOG entry mapping). Keep a Changelog v1.1.0 정합. ROADMAP entry summary 가 보통 ~700~1500 char → CHANGELOG entry 권장 ~5~10 line summary 로 압축 (사용자 발의 + 핵심 결정 + 결과 narrative)"
      }
    ],
    "untouched_files_explicit": [
      "projects/upbit/ROADMAP.md — 외부 프로젝트 trace, 본 milestone 안 schema migration 적용 여부 RESEARCH 안 분석. cascade 영향 정밀 식별 후 DESIGN 안 결정",
      "tests/_inactive/smoke-roadmap-sync.sh — v1.36 sessions/meta/ROADMAP.md 기반 archive smoke, 현 운영 비정합 (영향 부재)",
      "milestones/v{X.Y}/REPORT.md 산출물 (trace 1차 source 보존) — ROADMAP entry summary 가 archival 위치 변경되어도 REPORT.md 자체 보존 (3중 archival: REPORT.md + git log + CHANGELOG)",
      "bootstrap/skills/CLAUDE.md / agents/*.md — ROADMAP 직접 참조 부재 (단 audit chain 안 ROADMAP 분석 책임 있음, narrative 영향 부재)",
      "docs/adr/README.md — ADR 자체 trace, ROADMAP entry 직접 참조 부재"
    ]
  },
  "options": [
    {
      "id": "opt_schema_a1",
      "category": "schema",
      "name": "A1 — milestones[] 단일 array 통합 (status 필드 분기)",
      "description": "기존 milestones[] schema 유지. entry 안 status 필드로 분기 — in_progress / completed (최근 3건만 보존) / next_candidate (신 status 값, PROPOSE next_candidates 흡수). 별도 next_candidates[] 필드 부재",
      "pros": "schema 변경 최소 (status 신 값 추가) / smoke 영향 0 / Stage A OPEN/Stage I PROPOSE 절차 narrative 변경 미세",
      "cons": "next_candidate status 신 값 = 기존 'pending' 과 의미 중복 (v3.13_pending-milestone-renumber-policy 안 pending → deferred 일괄 변환 narrative 있음, 의미 분리 불명료)",
      "bump_implication": "v5.21 minor (schema 부분 확장)"
    },
    {
      "id": "opt_schema_a2",
      "category": "schema",
      "name": "A2 — milestones[] (recent 3 + in_progress) + next_candidates[] 별도 필드",
      "description": "milestones[] = recent 3 completed + in_progress 1 + deferred (cross-ref 보존) only. 신규 발의는 next_candidates[] 별도 array 안 entry (id/title/trigger/origin_milestone 등)",
      "pros": "사전적 의미 명료 (milestones = 이정표 status / next_candidates = 미래 발의 후보 분리). PROPOSE register 책임 명료 흡수 위치. Stage I PROPOSE 절차 narrative 명료",
      "cons": "schema 본질 변경 (신 필드 추가) → v6.0 major bump 후보. cascade host 7건 narrative 모두 갱신 (특히 ARCHITECTURE § 6.1 schema entry). smoke-projects-scope-discipline 영향 부재 (milestones[] 보유 검증만)",
      "bump_implication": "v6.0 major (schema 본질 변경)"
    },
    {
      "id": "opt_schema_a3",
      "category": "schema",
      "name": "A3 — milestones[] entry 단순 filter (schema 무변경, content reduce)",
      "description": "schema 변경 zero. 현 milestones[] 안 completed entry 46건 중 43건 (recent 3건 제외) summary 만 CHANGELOG.md 로 이전 + ROADMAP entry 자체 제거. next_candidates 등재 시 기존 'pending' status 활용 (v3.13 deferred 일괄 변환 narrative 와 자연 정합)",
      "pros": "schema 변경 zero → v5.21 minor + cascade host narrative 변경 최소 / smoke 영향 0 / Stage A OPEN/Stage I PROPOSE 절차 변경 부재 (단 archival cycle narrative 추가)",
      "cons": "pending status 가 '미래 발의 후보' 와 'open 가능' 두 의미 혼재 가능 (v3.13 narrative 안 일부 해소). 신 archival cycle (completed → recent 3건 외 entry remove) narrative 정전화 필요",
      "bump_implication": "v5.21 minor (content reduce only)"
    },
    {
      "id": "opt_archival_b1",
      "category": "archival",
      "name": "B1 — CHANGELOG.md 흡수 (사용자 결정 — Recommended)",
      "description": "ROADMAP entry summary (recent 3건 외 43건) → CHANGELOG entry 동치 mapping 후 ROADMAP 안 제거. Keep a Changelog v1.1.0 정합. v5.7~v5.20 누락 14 entry 동시 backfill. trace 3중 archival = CHANGELOG entry + milestones/v{X.Y}/REPORT.md + git log",
      "pros": "사용자 결정 / Keep a Changelog 정합 / archival 단일 위치 / 도구 추가 부재",
      "cons": "CHANGELOG.md 비대화 (현 452 line → 예상 ~900 line, v3.15 backfill 패턴과 동일 분량). 단 ROADMAP 감소 (~593 line → ~150 line) 와 trade-off",
      "trade_off_quantified": "CHANGELOG +~450 line / ROADMAP -~440 line ≈ net 0 — 단 책임 분리 (forward vs past) 효과는 추가"
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "category": "self-reference",
      "description": "본 milestone 자체가 self-loop 카운트 +1 (v5.8 baseline 92.3% + v5.9~v5.20 누적). Workflow self-improvement cycle 누적 17번째 인지",
      "mitigation": "Trace 메커니즘 재정의 (Workflow 자체 변경 부재) 본질 명시. § 3.3 5요소 매트릭스 Trace 행 (c) 정전 강화. § 4 끝 #3 narrative drift 수용 → drift 해소 정전화 (drift 의도성 narrative 보존, 단 ROADMAP 단어 sub-paragraph 갱신)"
    },
    {
      "id": "risk_2",
      "category": "cascade_drift",
      "description": "cascade host 7건 narrative 동기 갱신 시 일부 drift 가능 (v3.21 narrative 정전화 3 단계 패턴 정합 — DESIGN 1차 source + EXECUTE Edit 그대로 + VERIFY grep)",
      "mitigation": "DESIGN 안 exact_text 1차 source (markdown code block) + EXECUTE phase Edit tool 그대로 삽입 + VERIFY grep 3 키워드 (v3.21 3 단계 패턴 누적 22번째 cycle). 7 host inventory cell-by-cell 검증 의무"
    },
    {
      "id": "risk_3",
      "category": "trace_loss",
      "description": "ROADMAP entry 제거 시 deferred_note 안 v3.13/v3.14 narrative 의 'v1.4_hook-narrative-separation / v1.4_design-review-trace / v1.5_research-cascade-grep-discipline pending entry' cross-ref 손실 가능. trigger 조건 cross-ref 도 같이 손실",
      "mitigation": "deferred 3건 entry 자체는 ROADMAP 안 보존 (deferred 가 미래지향성 보유 — 'evidence-base trigger 충족 시 재발의' = forward-looking). recent 3건 외 completed entry archival 만 분리"
    },
    {
      "id": "risk_4",
      "category": "changelog_duplicate",
      "description": "v3.0~v3.14 14 entry 가 CHANGELOG 안 이미 backfill (v3.15) — archival 흡수 시 동일 entry 중복 생성 risk",
      "mitigation": "EXECUTE phase 안 dedupe 검증 의무 (CHANGELOG 안 [vX.Y] 헤더 grep → 동일 헤더 존재 시 본문만 강화 또는 skip). v1.0~v2.1 entry 도 동일 검증"
    },
    {
      "id": "risk_5",
      "category": "smoke_regression",
      "description": "신 schema 도입 시 smoke-projects-scope-discipline / smoke-bundle-trigger / smoke-open-stage-discipline 영향",
      "mitigation_verified": "본 RESEARCH 안 검증 완료 — smoke-projects-scope-discipline: milestones[] 배열 *존재* 만 검증 (영향 0) / smoke-bundle-trigger: version 필드 검증 (in_progress + recent + next_candidates 모두 version 보유 PASS) / smoke-open-stage-discipline: milestone 디렉토리 milestones.md 페어링 (영향 0). 단 신 next_candidates[] 별도 필드 채택 시 (Option A2) smoke-projects-scope-discipline 의 'milestones[] 배열 부재 → FAIL' 조건은 PASS (milestones[] = recent 3 + in_progress 1 보유)"
    },
    {
      "id": "risk_6",
      "category": "upbit_cascade",
      "description": "projects/upbit/ROADMAP.md 의 schema 동기 cascade 필요성 결정 부재",
      "mitigation": "Stage D DESIGN 안 결정 — Option A (meta only 적용, upbit 보존) 또는 Option B (upbit 동기 cascade). 사용자 명시 결정 의무"
    },
    {
      "id": "risk_7",
      "category": "propose_semantics",
      "description": "Stage I PROPOSE 의 'next_candidates 를 ROADMAP milestones[] 에 status: pending 등록' 의미 변경 — 신 schema 안 등록 위치 모호",
      "mitigation": "Option A2 (별도 next_candidates[] 필드) 채택 시 명료 분리 / Option A1 채택 시 status: 'next_candidate' 신 값 정의 / Option A3 채택 시 'pending' status 보존 (현행 v3.13 narrative 와 자연 정합)"
    },
    {
      "id": "risk_8",
      "category": "hook_message",
      "description": "post-report-write.sh L173 hook 메시지 'next_candidates 를 ROADMAP milestones[] 에 status: pending 등록' 갱신 시 smoke-posttooluse-hook 25 checks (Dynamic 22 A~V) 안 키워드 검증 위반 가능",
      "mitigation": "smoke-posttooluse-hook 검증 키워드 grep + 변경 시 smoke 정합 갱신 (Option A2/A1 schema 변경 시) 또는 보존 (Option A3 schema 무변경 시)"
    }
  ],
  "verification_baseline_for_smoke_regression": {
    "active_hooks": 7,
    "expected_pass": 7,
    "expected_skip": 0,
    "expected_fail": 0,
    "regression_check_files": [
      "tests/smoke-projects-scope-discipline.sh (ROADMAP schema 검증)",
      "tests/smoke-bundle-trigger.sh (version 필드)",
      "tests/smoke-open-stage-discipline.sh (디렉토리 페어링)",
      "tests/smoke-spec-verification.sh (milestone 산출물 schema)",
      "tests/smoke-scope-contract.sh (INTENT.out_of_scope + APPROVE)",
      "tests/smoke-cross-ref.sh (link 정합)",
      "tests/smoke-claude-md-drift.sh (CLAUDE.md drift)"
    ]
  },
  "context7_verification_status": "skipped",
  "context7_verification_rationale": "v5.7 spec-drift spike 패턴 정합 — Keep a Changelog v1.1.0 spec 는 본 repo CHANGELOG.md 의 header narrative 직접 명시 (L5), v3.15 backfill 패턴 1차 source 보유. 추가 context7 호출 marginal value 낮음 (이미 spec 정전화). ROADMAP convention 외부 spec 명시 부재 인식 (추정 narrative 유지)."
}
```

## 본질 분석

### ROADMAP 책임의 의미 변화 (사전적 정의 정합)

현 `projects/meta/ROADMAP.md` 의 실 책임 = (a) milestone 발의 입력 source (v2.0_workflow-word-fidelity '입력 source' narrative 정합) + (b) 완료 milestone trace 보존 (v1.1_meta-as-project 신설 narrative L589 '본 파일이 meta milestones[] 단일 source') 2중 책임. 사전적 'roadmap = forward-looking 이정표' 와 (b) 가 충돌 — § 4 끝 #3 narrative 안 'drift 수용' 으로 정전화.

본 milestone = (b) 책임을 CHANGELOG.md 로 위임 분리. (a) 책임만 ROADMAP 보존 — 사전적 부합 100% 도달. PROPOSE register 책임도 (a) 안 자연 흡수 — 신 schema 안 'next_candidate' (Option A1) 또는 별도 `next_candidates[]` 필드 (Option A2) 또는 'pending' status 활용 (Option A3) 어느 옵션이든 forward-looking 영역.

### Version bump 결정 evidence

- Option A1 (status 신 값 추가): schema 부분 확장 = minor (semver additive)
- Option A2 (별도 next_candidates[] 필드): schema 본질 확장 = major (breaking, 외부 도구 schema 파싱 영향)
- Option A3 (content reduce only): schema 무변경 = minor (content 변경)

v3.0 milestones-restructure (schema 변경 v2 → v3) / v4.0 harness-composer-pivot (정체성 재정의 v3 → v4) / v5.0 plugin-pivot (install 메커니즘 v4 → v5) 선례 — 모두 schema 또는 본질 변경이 major bump trigger. Option A2 채택 시 v6.0 major 정합.

### Self-loop 인지 narrative

본 milestone scope = Trace 요소 재정의 (5요소 매트릭스 § 3.3 row 5). Workflow 자체 변경 부재 — 9-stage 단어/책임 그대로. workflow self-improvement 본질 아님 (memory `feedback_section_6_2_abolished` 정합). 단 PROPOSE register 책임 의미 변화 (10-stage 분리 회피) = workflow drift 수용 narrative 일부 영향.

self-loop 누적 카운트 (v5.8 baseline 12 meta / 1 외부 = 92.3% → 본 milestone 진입 시 13 meta / 7 외부 (v1.17~v5.20 cycle 7 누적) = 19 self-loop / 27 total = 70.4% — RESEARCH 안 sub-metric 정확 계산. PROPOSE 안 narrative).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- 1차 source narrative: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 4 끝 #3 (L151)
- 정량 baseline: [`../v5.9/RESEARCH.md`](../v5.9/RESEARCH.md) § axis_c_roadmap_word
- CHANGELOG backfill 패턴: [`../_archive/v3.15/REPORT.md`](../_archive/v3.15/REPORT.md)
- DESIGN: 본 RESEARCH 의 options + risks 기반 5 관점 검토 후 결정
