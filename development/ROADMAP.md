# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-28-v9.1-approve",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = GitHub Releases (v6.19+ 단일 source, commit marker [release:v{X.Y}] → release-publish.yml; CHANGELOG.md 는 v6.19 까지 historical, Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). milestones[] completed ≤ 3 강제 = tests/smoke-roadmap-archival.sh (v8.13). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md(9-stage)/LIGHTWEIGHT.md ## 기록(가벼운 흐름) + git log + GitHub Release(v6.19+ 단일 source, v6.19 까지 CHANGELOG entry — v8.13_archival-mechanism-reconciliation 정합). entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE 종합, v7.0 T1.2 후 lessons P2 자동 종합 제외) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제. next_candidates[] append = 사용자 명시 결정 게이트 후만 (자동 append 폐지, v7.0 T1.2 정전화). lessons P2/P3 자동 enumerate 폐지 — PROPOSE stage 안 사용자 명시 결정만 candidate 본질 source (scripts/propose_next.py lessons P2 grep/count 제거 정합). 기존 33 next_candidates (부산물 cycle 누적 임시 후보) 일괄 폐기 — git history 보존.",
  "deferred_note": "동결 정책 은퇴 (v8.1_meta-lightweight-flow-design, 2026-05-26). 구 동결 정책 (v3.13_pending-milestone-renumber-policy + v3.14_deferred-revaluation-cycle-2 자기참조 milestone 동결 + v4.0 § 6.2 폐지 후 재발의 trigger 조건 '외부 적용 5건+ ∧ 사용자 명시 발의') 은 컨설턴트 정체성 (harness engineering 컨설턴트) + 가벼운 흐름 창구 (ARCHITECTURE § 7.4) 도입으로 무의미해짐 — '§ 6.2 부활' 아닌 deferred_note drift 해소 (memory feedback_section_6_2_abolished 정합, 자기참조 루프 우려가 가벼운 흐름으로 흡수). deferred 3건 처리 = (1) v1.5_research-cascade-grep-discipline → v8.2 가벼운 흐름 도그푸드 실처리 (completed) + (2) v1.4_hook-narrative-separation / v1.4_design-review-trace → next_candidates[] 전환 (작은 건 = 가벼운 흐름 후보) → **v8.12 후 pre-PLAN 검토에서 양쪽 전제 broke 확인되어 폐기 (retired, 2026-05-27)**: design-review-trace = v6.2 평탄화 + v7.0 T1.3 (verdict + comments + disposition 인라인 DESIGN.five_perspective_review 보존) 이 핵심 trace 를 이미 흡수 → raw 전체 보존은 토큰효율 우선과 충돌, 사실상 해소(superseded). hook-narrative-separation = post-report-write.sh 메시지가 정적 hard-code 가 아닌 동적 템플릿 (FILE_TYPE 분기 + ${FILE_BASENAME}/${SECTIONS} 런타임 보간) 이라 'hook = 단순 reader' 전제 불성립 — MD 분리 시 hook 이 reader + 템플릿엔진 + 분기선택 + 런타임 파일의존을 떠안아 오히려 복잡화. 거명 보존 (재발의 trigger 부재). 부수 발견 (폐기와 별개, 미등재) = hook PROPOSE 메시지 (line 178) 의 'completed > 3 archival' 규칙이 schema_note ('recent 3만') + 실제 운영 (milestones[] 16건 누적) 과 3중 드리프트 — 별도 검토 후보 (사용자 게이트). deferred[] = 빈 배열 (동결 대상 부재).",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v9.1",
      "id": "architecture-md-split-by-canonical-definition",
      "title": "ARCHITECTURE.md 사전적 정의 정합 분리",
      "status": "in_progress",
      "trigger": "A_user",
      "milestones_path": "milestones/v9.1/MILESTONE.md#sub-milestones",
      "summary": "사용자 명시 큰 건 결정 (2026-05-28, 토큰 우려 → 사전적 정의 부합 검증 → 분리 확정). ARCHITECTURE.md 안 § 11 개 중 사전적 정의 ('전체의 뼈대·구성요소·관계') 정합 = § 1/2/9/10 (구조) + § 3 (도메인 정체성, 정당한 architecture 일부), 그 외 § 4/7.3/7.4/11 = 워크플로우 본질 / § 5/6/7.1/7.2 = 운영 매뉴얼 본질로 혼재. N=2 실용 분리 결정 (ARCHITECTURE 잔류 + WORKFLOW.md + OPERATIONS.md 신설). § 7 sub-split (§ 7.3/7.4 → WORKFLOW / § 7.1/7.2 → OPERATIONS). 활성 cascade host ≈ 15~20 (큰 건 1 milestone scope). 선행 구조 변경 본질 — codex-adapter-surface-enhancement / design-time-intent-amend 등 다른 v9.1 후보의 § 참조 위치가 본 분리에 의해 변경되므로 v9.1 우선 처리 (사용자 명시 결정)."
    },
    {
      "version": "v9.0",
      "id": "multi-llm-adapter-tiers",
      "title": "Multi-LLM 어댑터 tier 정책 도입",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v9.0/MILESTONE.md#sub-milestones",
      "summary": "사용자 명시 큰 건 결정 (2026-05-28, codex 외부 검토 보완 후). 정체성 첫 줄 breaking change (단수형 'Claude Code adapter maintainer' → 복수형 'reference adapter maintainer (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)') 본질 major bump. 3 층 분리 (Core methodology / Adapter docs / Portable tools) + 4 tier 분류 (Core / Reference / Portable / Optional integration) ARCHITECTURE § 3.1 + § 3.5 안 정전화. 핵심 원칙 한 줄 (codex 제안 정확 표현 = '목표는 LLM 도구 간 자동화 동등성이 아니라, 도구별 자동화 tier 를 인정하는 이식 가능한 방법론이다') + 10 host (primary 7 + 별 표현 3 v4.0 ecosystem-integrator 보존) cascade 완료. delta = 11 file (3 신규 + 8 edit) / +803 -19 LOC / 10 commit. verdict RESOLVED (sc 5/5 PASS + risk 5/5 MITIGATED + smoke 22/22). lessons 5건 — L1 P1 (DESIGN 시점 INTENT amend 패턴 도그푸드 = codex finding 1 stage 책임 분리 직접 정합) + L2-L4 P2 (cascade host smoke mechanism / subagent fact-hallucination evidence / 본문 cascade v9.1 흡수) + L5 P3 (정전화만 본질 작은 milestone 권장 evidence). 실 어댑터 (oos_1~3 v9.1+) / 자동화 매트릭스 (oos_4 v9.2+) / portable scripts CLI (oos_5 v9.3+) / portable fallback (oos_7) / SDK 평가 (oos_8 v9.5+) / MCP wrapper (oos_6 v10.0+) 모두 별 milestone 분해. 후속 candidate 3 등재 = codex-adapter-surface-enhancement (v9.1) + design-time-intent-amend-pattern-canonicalization (v9.1) + identity-cascade-host-count-smoke (v9.2)."
    },
    {
      "version": "v8.15",
      "id": "codex-authored-change-absorption",
      "title": "codex 작성 변경을 운영 표면 정합으로 정식 흡수",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.15/MILESTONE.md#sub-milestones",
      "summary": "사용자 명시 큰 건 결정 (2026-05-28). Codex 가 harness-meta 평가·개선 작업으로 광범위 편집 후 working tree 미커밋 상태로 인계 — milestone 기록 부재 (CLAUDE.md '모든 변경은 milestone 기록' 위반). Codex = Claude Code 전용 plugin 미사용 (AGENTS.md 진입 + 자율 준수 의존, harness-meta.md:225 cross-check 트랙 역할 역전 — codex 가 작성, Claude Code 가 작성자/운영자 역할 회복하여 정식 흡수). codex 변경 5 갈래 = (a) 검증 표면 동기화 (CI/Makefile/pre-commit active smoke 6→15 통일 + smoke-workflow-registration 신설) + (b) plugin manifest inventory smoke 신설 (smoke-plugin-manifest) + (c) v8.0 meta 재분류 narrative 잔존 정합 (AGENTS/README/ARCHITECTURE projects/meta/→development/) + (d) GitHub Actions node24 마이그레이션 (checkout v4→v6, next_candidate release-workflow-node24-migration 소비) + (e) ai-ready-scorer 개선 (깨진 smoke 참조·CI smoke 누락 감지 + development/ARCHITECTURE.md 경로 인식 + trailing-whitespace 정리). 흡수 시 정리 = tests/CLAUDE.md 하단 '현행 hook 현황' 표 stale (13→15) + settings.local.json 커밋 제외. 검증 = active smoke 15 PASS 실측. scope = 큰 건 (검증 매트릭스·CI·plugin manifest·방법론 문서 = 컨설팅 자산)."
    },
    {
      "version": "v8.14",
      "id": "changelog-header-path-drift-reconcile",
      "title": "CHANGELOG 헤더의 v8.0 meta 경로 drift 정합",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v8.14/LIGHTWEIGHT.md",
      "summary": "가벼운 흐름 (4 섹션) — v8.13 archival 정합 검토 중 부수 발견. CHANGELOG.md 헤더(line 3) navigation pointer 가 v8.0 meta 재분류(projects/meta/→development/) 이후 깨진 경로 가리킴 (backtick 안이라 smoke-cross-ref 미검출 잠복). 헤더 line 3 운영 pointer 만 development/milestones/ 정합 + v6.2+ flattened era(MILESTONE.md ## REPORT) 명시 + v6.20+ GitHub Releases 단일 source note. dated historical entry 내부 ref(line 29/103/152/390+)는 Keep a Changelog append-only 불변 + v8.0 milestone-내부 ref 보존 원칙으로 scope 외. 교훈 = backtick 안 경로는 cross-ref 미검출 → 대규모 디렉토리 이동 시 수동 grep 점검 필요."
    }
  ],
  "next_candidates": [
    {
      "id": "open-stage-entry-title-precheck",
      "title": "OPEN stage title entry-title 사전 검증 권고 추가",
      "trigger": "B_regression",
      "origin_milestone": "v7.1",
      "target_version": "v7.2",
      "description": "v7.1 L4 origin — entry-title gate (smoke-entry-title-guideline) 가 v7.1 EXECUTE 중 title 의 ' + ' 를 실제 차단 (도그푸드). 2 반쪽 bundling milestone 은 OPEN 시점에 title 의 ' + ' P1 정합을 사전 확인하면 EXECUTE 중 재커밋 cost 회피. stage-open skill 또는 propose-next 안 title 사전 검증 checklist 1줄 추가 후보."
    },
    {
      "id": "cross-check-role-reversal-doc",
      "title": "cross-check 트랙에 codex 작성자 역전 케이스 명문화",
      "trigger": "B_byproduct",
      "origin_milestone": "v8.15",
      "target_version": "v8.16",
      "description": "v8.15 L1 — harness-meta.md:225 cross-check 트랙은 'Claude=작성자/Codex=감사자' 단방향 전제이나 v8.15 가 codex=작성자 역전 실 사례. 트랙 narrative 에 '역할 역전(codex 작성) 시 Claude Code 작성자 회복 + retroactive 흡수' 케이스 1 단락 추가 후보 (작은 건 = 가벼운 흐름 후보)."
    },
    {
      "id": "stage-execute-skill-json-status-field",
      "title": "stage-execute skill 별책 템플릿 JSON에 status 필드 정합",
      "trigger": "B_regression",
      "origin_milestone": "v8.15",
      "target_version": "v8.16",
      "description": "v8.15 L4 — stage-execute skill 별책 schema 가 frontmatter 에 status 를 두고 JSON 블록엔 부재이나, smoke-spec-verification Stage 9(:232)는 JSON 블록에서 phase+status 검사. 템플릿 그대로 따르면 FAIL (v8.15 EXECUTE 실증). skill 별책 schema JSON 에 'status' 필드 추가 정합 후보 (작은 건 = 가벼운 흐름 후보)."
    },
    {
      "id": "codex-adapter-surface-enhancement",
      "title": "Codex 어댑터 표면 보강 (AGENTS.md 안 tier 표현 cascade 강화)",
      "trigger": "A_user",
      "origin_milestone": "v9.0",
      "target_version": "v9.2",
      "description": "v9.0 oos_1 + L4 P2 + SCOPE_OUT_NOTES #1 통합 origin. v9.0 안 정체성 첫 줄 cascade 후 AGENTS.md 본문 narrative (line 44 'Claude Code adapter' 본문 인용 + README.md:96/165 directory tree comment 안 동일 어휘 잔존) 정합 + AGENTS.md 안 9-stage 진입 절차 / tier 정합 표현 / harness-meta workflow 안내 강화 본질. v8.15 codex 작성자 사례 안 codex 가 본 repo 를 더 잘 다루도록 어댑터 표면 강화 origin 직접 정합. trigger = A_user (codex 외부 진단 origin 연쇄). target_version v9.1 → v9.2 (2026-05-28) — v9.1 architecture-md-split 선행 구조 변경 우선 처리, 본 candidate 는 분리 완료 후 후속 (사용자 명시 결정)."
    },
    {
      "id": "design-time-intent-amend-pattern-canonicalization",
      "title": "DESIGN 시점 INTENT amend 패턴 ARCHITECTURE 정전화",
      "trigger": "B_byproduct",
      "origin_milestone": "v9.0",
      "target_version": "v9.2",
      "description": "v9.0 L1 P1 + SCOPE_OUT_NOTES #3 origin. v9.0 안 sc_4 host 5→10 + oos_8 SDK 신규 양자 모두 DESIGN 안 amend (phase-2 안 추가 amend 부재) — codex finding 1 stage 책임 분리 직접 정합 cycle 도그푸드. 본 amend 패턴 정전화 = ARCHITECTURE § 7.3 (Stage 본질 = templated section 작성 task) 안 'DESIGN 시점 INTENT amend 허용 — trace 명료 정합' narrative 추가 후보. INTENT 회수 (rework) 아닌 forward cycle 안 자연 흡수 본질 강조. target_version v9.1 → v9.2 placeholder (2026-05-28) — v9.1 architecture-md-split 후 § 7.3 가 WORKFLOW.md 로 이동, 본 amend 패턴 정전화 host (ARCHITECTURE § 7.3 → WORKFLOW.md § 4 base) 자체가 분리에 의해 변경되므로 분리 후 WORKFLOW.md § 4 기준 재평가 — target 실 확정 보류 (사용자 명시 결정)."
    },
    {
      "id": "identity-cascade-host-count-smoke",
      "title": "정체성 cascade host count 자동 smoke mechanism 신설",
      "trigger": "B_byproduct",
      "origin_milestone": "v9.0",
      "target_version": "v9.2",
      "description": "v9.0 L2 P2 + SCOPE_OUT_NOTES #2 + #4 통합 origin. v9.0 안 manual 검증 (Grep 3 형식 + Windows PowerShell Select-String 직접 1회) 으로 cascade 정합 확인 — 자동 smoke 부재 시 향후 정체성 narrative 변경 milestone 안 host enumerate 누락 risk 재발 가능. smoke-roadmap-archival 패턴 정합 안 (a) 정체성 host count 자동 enumerate + (b) § 3.5 Adapter taxonomy 표 갱신 자동 매트릭스 양자 통합 mechanism 후보."
    }
  ]
}
```

## 의도 (v5.21+ schema A2)

본 ROADMAP 은 **forward-looking 이정표** — 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 정합. `milestones[]` = 현재 진행 (in_progress) + 최근 완료 (recent 3건, carry-over context) + deferred (재발의 trigger 조건 보유) + `next_candidates[]` = PROPOSE 발의 후보 (forward-looking 본질).

**과거 completed entry archival** = **GitHub Releases** (v6.19+ 단일 source — commit marker `[release:v{X.Y}]` → `.github/workflows/release-publish.yml` 자동 발행, 두 트랙 모두: 9-stage=MILESTONE.md ## REPORT / 가벼운 흐름=LIGHTWEIGHT.md ## 기록, v8.13). [`../../CHANGELOG.md`](../CHANGELOG.md) 는 v6.19 까지 historical hybrid (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). trace 3중 보존:

1. **GitHub Release** — 외부 visible artifact (release note, v6.19+; v6.19 까지는 CHANGELOG.md entry)
2. **milestones/v{X.Y}/REPORT.md** (9-stage) 또는 **LIGHTWEIGHT.md ## 기록** (가벼운 흐름) — milestone 종합 backward (lessons + delta)
3. **git log** — 원자 commit history + diff

## v5.21 정전화 1차 source

본 schema redesign 정전화 = [`milestones/v5.21/`](milestones/v5.21/) (RESEARCH + DESIGN + REPORT). [`ARCHITECTURE.md`](ARCHITECTURE.md) § 4 끝 #3 narrative 본질 변경 (drift 수용 → drift 해소 사례 정전화).

## 관련 문서

- 운영 가이드 (root): [`../../CLAUDE.md`](../CLAUDE.md)
- ARCHITECTURE: [`ARCHITECTURE.md`](ARCHITECTURE.md)
- subdirectory CLAUDE.md (lazy load): [`CLAUDE.md`](CLAUDE.md)
- 최근 완료 milestone: [`milestones/v6.2/`](milestones/v6.2/) (completed, 2026-05-19 — milestone 산출물 디렉토리 평탄화 / 9-stage-flattened era)
- 과거 completed milestone (v1.0 ~ v5.20) 종합: [`../../CHANGELOG.md`](../CHANGELOG.md) — entry 별 REPORT.md cross-ref
- Archive (v4.0 phase-2 분리): `milestones/_archive/v1.0_*` ~ `v3.21/` (역사적 디렉토리 보존)

## 비고

본 ROADMAP 은 v5.21_roadmap-forward-looking-redesign-and-changelog-archival (2026-05-19) 에서 schema A2 재설계. 이전 schema (v3.0+ 9-stage-bundled era, v3.0_milestones-restructure 도입) 는 `milestones[]` 단일 array 안 forward + past 혼재 = ~30~40% 부합 drift (v3.19/v5.9 정전화). v5.21 schema A2 는 `milestones[]` + `next_candidates[]` 명료 이원 분리 + CHANGELOG.md archival 흡수 = ~95%+ 부합 도달. 본 파일이 meta 진행/완료/후보 trace 의 단일 source — 단 past trace 본질은 GitHub Releases 위임 (v6.19+ 단일 source, CHANGELOG.md 는 v6.19 까지 historical; v8.13_archival-mechanism-reconciliation 정합).
