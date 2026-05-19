---
id: roadmap-forward-looking-redesign-and-changelog-archival
title: ROADMAP forward-looking 재정의 + CHANGELOG v5.7~v5.20 backfill + completed entry 41건 CHANGELOG 이전 + cascade 7 host
version: v5.21
stage: DESIGN
status: completed
---

# DESIGN — v5.21

## Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Version bump = v5.21 minor",
      "rationale": "Schema A2 (milestones[] = recent 3 + in_progress + deferred / next_candidates[] 별도 필드 신규) = additive minor + content reduce. semver minor 정합. v6.0 명명은 자동 전환 + PoLP 별도 milestone 에 예약 (사용자 (A) 결정 정합). breaking 측면 (milestones[] content 41건 제거) narrative 흡수 — CHANGELOG.md 이전 trace 보존, 외부 도구 schema 파싱 영향 없음 (milestones[] 배열 자체 보유)",
      "alternatives_considered": [
        {
          "option": "v6.0 major",
          "reason_rejected": "v6.0 = 자동 전환 + PoLP 별도 milestone 예약 (사용자 (A) 결정). schema A2 의 additive 측면 우위 — minor 정합"
        }
      ]
    },
    {
      "id": "D2",
      "decision": "Schema redesign = Option A2 채택",
      "rationale": "milestones[] (수행/완료 trace) + next_candidates[] (PROPOSE 발의 후보) 명료 이원 분리. 사전적 의미 정합 (milestones = 이정표 status / next_candidates = 미래 후보). v6.0 자동 전환 시 PROPOSE.next_candidates → ROADMAP.next_candidates[] 1:1 매핑 명료. 사용자 명시 결정 (Q1 A2)",
      "exact_text_schema": "```json\n{\n  \"project\": \"meta\",\n  \"updated\": \"YYYY-MM-DD\",\n  \"deferred_note\": \"<보존>\",\n  \"schema_note\": \"v5.21+ schema: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug 패턴, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver minor/major)\",\n  \"candidate_draft\": [<벤치마크 cycle routine 산출물, 보존>],\n  \"milestones\": [\n    {\"version\": \"v5.21\", \"id\": \"<group-slug>\", \"title\": \"...\", \"status\": \"completed\", \"trigger\": \"A_user\", \"milestones_path\": \"milestones/v5.21/milestones.md\", \"summary\": \"...\"},\n    {\"version\": \"v5.20\", \"id\": \"...\", \"status\": \"completed\", \"...\": \"...\"},\n    {\"version\": \"v5.19\", \"id\": \"...\", \"status\": \"completed\", \"...\": \"...\"},\n    {\"version\": \"v1.4_hook-narrative-separation\", \"id\": \"...\", \"status\": \"deferred\", \"deferred_reason\": \"<v3.13 narrative 보존>\"},\n    {\"version\": \"v1.4_design-review-trace\", \"...\": \"...\", \"status\": \"deferred\"},\n    {\"version\": \"v1.5_research-cascade-grep-discipline\", \"...\": \"...\", \"status\": \"deferred\"}\n  ],\n  \"next_candidates\": [\n    {\"id\": \"workflow-automation-and-least-privilege\", \"title\": \"...\", \"trigger\": \"A_user\", \"origin_milestone\": \"v5.21\", \"target_version\": \"v6.0\"},\n    {\"id\": \"<v5.21 PROPOSE 안 추가 후보>\", \"...\": \"...\"}\n  ]\n}\n```",
      "schema_validation_pattern_source": "smoke-projects-scope-discipline.sh L75 path_pattern (`^projects/[a-z0-9_-]+/ROADMAP\\.md$`) 동치 강도. smoke-bundle-trigger.sh 안 `milestones_path` regex (`^milestones/v[0-9]+\\.[0-9]+/milestones\\.md$`) 검증 책임 1:1 대응. (security review P2-2 흡수)"
    },
    {
      "id": "D3",
      "decision": "upbit ROADMAP cascade = Meta only",
      "rationale": "사용자 명시 결정 (Q2 Meta only). upbit 외부 repo 책임 분리. 필요 시 upbit 별도 milestone PROPOSE. v6.0 자동 전환 milestone 진행 시 upbit ROADMAP cascade 자연 발의 가능"
    },
    {
      "id": "D4",
      "decision": "Phase 분할 = 3-phase",
      "rationale": "사용자 명시 결정 (Q3). 책임 분리 명료: phase-1 = CHANGELOG backfill (v5.7~v5.20 14 entry 역순 삽입) / phase-2 = ROADMAP redesign (milestones[] content reduce + next_candidates[] 신규 + completed 41건 archival 이전) / phase-3 = cascade 7 host narrative 갱신",
      "phase_structure": {
        "phase_1": {
          "scope": "CHANGELOG.md 안 [v5.7] ~ [v5.20] 14 entry 역순 삽입 (최신 v5.20 위 / 과거 v5.7 아래). 각 entry = ROADMAP.milestones[].summary 압축 (~5~10 line) + Added/Changed/Fixed 분류 + milestone REPORT.md cross-ref",
          "affected_files": [
            "CHANGELOG.md"
          ],
          "commit_message": "feat(meta): v5.21 phase-1 — CHANGELOG.md v5.7~v5.20 14 entry backfill (역순 삽입, Keep a Changelog v1.1.0 정합)"
        },
        "phase_2": {
          "scope": "projects/meta/ROADMAP.md schema redesign — milestones[] = recent 3 (v5.20/v5.19/v5.18 보존) + in_progress 1 (v5.21 자체) + deferred 3 (v1.4_hook/v1.4_design-review/v1.5_research 보존) + next_candidates[] 신규 필드 (v6.0_workflow-automation-and-least-privilege 거명 + 기타 PROPOSE 후보). completed entry 41건 (v5.17~v1.0_workflow-redesign) 제거 (이미 CHANGELOG 흡수). schema_note 갱신",
          "affected_files": [
            "projects/meta/ROADMAP.md"
          ],
          "commit_message": "feat(meta): v5.21 phase-2 — ROADMAP schema A2 + completed 41건 CHANGELOG 이전 + next_candidates[] 신규 필드"
        },
        "phase_3": {
          "scope": "cascade 7 host narrative 동기 갱신 (RESEARCH host inventory) — (1) root CLAUDE.md L33 workflow 단어 책임 표 / L60 schema entry / (2) claude/hooks/post-report-write.sh L173 hook 메시지 (next_candidates 등록 위치 갱신 + smoke 정합 검증) / (3) claude/commands/harness-meta.md Stage A OPEN step 6 + Stage I PROPOSE 절차 (archival cycle narrative 추가) / (4) bootstrap/agents/CLAUDE.md L198 (e3 정책 micro cross-ref) / (5) projects/meta/ARCHITECTURE.md L91 Trace mechanism + L151 § 4 끝 #3 drift narrative 갱신 (drift 수용 → drift 해소 사례 narrative 정전화) + L165 bundling schema / (6) CHANGELOG.md [v5.21] entry 신규 / (7) post-report-write.sh smoke 정합 검증 (smoke-posttooluse-hook 25 checks 안 키워드 변경 확인)",
          "affected_files": [
            "CLAUDE.md",
            "claude/hooks/post-report-write.sh",
            "claude/commands/harness-meta.md",
            "bootstrap/agents/CLAUDE.md",
            "projects/meta/ARCHITECTURE.md",
            "CHANGELOG.md"
          ],
          "commit_message": "feat(meta): v5.21 phase-3 — cascade 7 host narrative + [v5.21] CHANGELOG entry + § 4 끝 #3 drift 해소 정전화"
        }
      }
    },
    {
      "id": "D5",
      "decision": "Review mode = 5 관점 subagent 병렬 검토",
      "rationale": "사용자 명시 결정 (Q3). 대규모 cascade scope (7 host narrative + CHANGELOG 본질 + ROADMAP schema 변경) — 검토 필수. 5 관점 = (1) architecture (Trace 메커니즘 재정의 정합) / (2) spec-drift (context7 Keep a Changelog v1.1.0 정합 + ROADMAP convention) / (3) 회귀 risk (smoke 7건 영향 + post-report-write.sh 정합) / (4) 보안 (input validation / path traversal) / (5) scope contract (INTENT.out_of_scope 6건 정합)"
    },
    {
      "id": "D6",
      "decision": "Recent 3건 = v5.20 + v5.19 + v5.18 (chronological)",
      "rationale": "사용자 결정 round Q2 Recent 3건 — chronological 정확. v5.20 (2026-05-19) + v5.19 (2026-05-19) + v5.18 (2026-05-18) 최근 3건. carry-over candidate origin tracing 가능 (v5.18 → v5.17 cycle 5 → v5.19 cycle 6 → v5.20 cycle 7 stability). v5.21 자체 (in_progress) 는 별도",
      "alternatives_considered": [
        {
          "option": "Recent 5건",
          "reason_rejected": "사용자 결정 3건"
        },
        {
          "option": "Recent 1건",
          "reason_rejected": "사용자 결정 3건. carry-over context 부족"
        }
      ]
    },
    {
      "id": "D7",
      "decision": "Deferred 3건 entry 보존 (v1.4_hook / v1.4_design-review / v1.5_research)",
      "rationale": "deferred status = 미래지향성 보유 (evidence-base trigger 충족 시 재발의 = forward-looking). recent 3건 chronological 매핑 외 별도 보존. RESEARCH risk_3 mitigation 정합 — deferred_note narrative 손실 회피",
      "deferred_note_handling": "현 deferred_note (v3.13/v3.14 narrative) 그대로 보존 — 사실 진술 1차 source"
    },
    {
      "id": "D8",
      "decision": "next_candidates[] entry 1 = v6.0_workflow-automation-and-least-privilege 거명",
      "rationale": "사용자 (A) 결정 정합 — v6.0 분리 발의 trigger 보존. entry schema = {id, title, trigger, origin_milestone, target_version, description}. v5.21 PROPOSE 안 narrative source"
    },
    {
      "id": "D9",
      "decision": "CHANGELOG entry 포맷 = Keep a Changelog v1.1.0 권장 분류 (Added / Changed / Fixed / Removed)",
      "rationale": "v3.15_changelog-v3-backfill 선례 정합 — entry 본문 = ROADMAP.milestones[].summary 압축 + 분류 + 분량 ~5~10 line. ROADMAP entry summary 가 ~700~1500 char (narrative 산물) → CHANGELOG entry 권장 ~5~10 line summary 압축 (handlebar — '핵심 결정 + 결과' 본질만, lessons_learned 등 본문 detail 은 milestones/v{X.Y}/REPORT.md cross-ref)",
      "exact_format_example_v5.7": "```\n## [v5.7] - 2026-05-16\n\n### Changed\n\n- **spec-drift spike 패턴 ARCHITECTURE § 6 정전화** — v4.2 + v5.6 두 origin (context7 source 추정 → DESIGN/Stage F 정정 → DESIGN.decisions hardcode 4 단계) ARCHITECTURE.md § 6 본문 안 bold lead paragraph 1건 정전화. v3.21 narrative 정전화 3 단계 패턴 9 cycle 완성. 자세히: [`projects/meta/milestones/v5.7/REPORT.md`](projects/meta/milestones/v5.7/REPORT.md)\n```",
      "category_mapping_rule": "v5.7~v5.20 14 entry 분류 1차 source = ROADMAP entry summary 안 동사. 'Added' 한정 = 신규 산출물 (예: v5.10 audit-2026-05-18 디렉토리 + 4 산출물, v5.11/v5.18 H2 sub-section 신규, v5.16/v5.18 신규 절차 paragraph, v5.20 § 4 끝 매트릭스 신규). 'Changed' 우선 = narrative 정전화 / cleanup / audit cycle / 갱신 (예: v5.7/v5.13/v5.17/v5.19 등 stability cycle, v5.12 narrative cleanup). 'Fixed' 한정 = fact 정정 / hallucination 정정 (예: v5.11 audit chain hallucination cycle 2 inline 정정). 'Removed' 한정 = 폐기 / 삭제 산출 (v5.7~v5.20 안 해당 부재). (spec-drift review P2 흡수, v3.10~v3.16 historical 패턴 정합)",
      "sanitize_awareness": "ROADMAP entry summary → CHANGELOG 이전 시 5 메타 문자 (`@`, `{{`, `}}`, `<!--`, `<script`) grep awareness — tests/_inactive/smoke-roadmap-sync.sh L36-L45 (v1.36 sanitize_row 함수) 1차 source. 현 ROADMAP 50 entry summary scan 결과 (보안 review 실 검증) = 5 메타 문자 자연 발현 0건 확인. 신 entry 작성 시만 awareness narrative 적용 (untrusted vector 부재). (security review P2-1 흡수)"
    },
    {
      "id": "D10",
      "decision": "ARCHITECTURE § 4 끝 #3 narrative paragraph 본질 변경 (drift 수용 → drift 해소 사례)",
      "rationale": "v5.9_dictionary-semantics-integrated-audit 정전화 narrative (drift 수용 = pragmatic 절충, 부합도 ~30~40%) 의 본질 변경 — v5.21 가 evidence-base trigger 첫 사례로 drift 해소 (부합도 ~30~40% → 95%+). exact_text 변경 — paragraph 본질 'drift 수용' → 'drift 해소 사례 (v5.21_roadmap-forward-looking-redesign-and-changelog-archival)' + 매트릭스 row #3 갱신 (검증 method = 수치 + 표)",
      "exact_text_paragraph": "**ROADMAP 단어 drift 해소** (v5.9_dictionary-semantics-integrated-audit 진단 + v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화): `roadmap` 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 와 현 `projects/meta/ROADMAP.md` 실 상태 부합도 ~30~40% drift 가 v5.21 evidence-base trigger 사례로 해소 — milestones[] = recent 3 completed + in_progress + deferred (수행/완료 trace) + next_candidates[] (PROPOSE 발의 후보, forward-looking 본질) 명료 이원 분리. completed entry 41건 archival 위치 = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill 패턴). PROPOSE register 책임 (70% drift) 도 자연 흡수 — PROPOSE.next_candidates → ROADMAP.next_candidates[] 1:1 매핑. 부합도 ~95%+ 도달 (forward-looking + recent reference 분리). drift 해소 trade-off — milestones/v{X.Y}/REPORT.md + git log + CHANGELOG entry 3중 archival = trace 보존. 정전화 1차 source = [`milestones/v5.21/RESEARCH.md`](milestones/v5.21/RESEARCH.md) + [`milestones/v5.21/REPORT.md`](milestones/v5.21/REPORT.md)."
    },
    {
      "id": "D11",
      "decision": "Stage I PROPOSE 절차 narrative 갱신 = archival cycle 추가 (단 PROPOSE register 책임 분리 아님)",
      "rationale": "claude/commands/harness-meta.md L286-287 Stage I PROPOSE 'actual operation' — step 신규: completed 갱신 후 'milestones[] 안 4번째 이전 entry 가 있으면 CHANGELOG.md 이전 + ROADMAP entry 제거' archival cycle. step 1+2 후 신규 step 1.5 또는 step 3 (사용자 확인 전). 또는 별도 sub-section 'Archival cycle (v5.21 도입)' 추가. **PROPOSE register 책임 분리 아님 — 등재 위치만 milestones[] (status:pending) → next_candidates[] (별도 필드) 변경. PROPOSE stage 단어 / 책임 자체는 보존 (INTENT.out_of_scope oos_2 정합). 단어-책임 70% drift 의 자연 해소는 sub-mechanism cross-ref 명료화 효과 — 10-stage 분리 (PROPOSE + REGISTER) 본질 아님** (scope contract review P1 흡수)",
      "exact_text_proposal": "(phase-3 EXECUTE 안 exact_text 확정 — 본 DESIGN 안 narrative 1차 source: 'archival cycle (v5.21+): step 1 (completed 갱신) 후, milestones[] 안 completed entry count > 3 인 경우 가장 오래된 entry 의 summary 를 CHANGELOG.md [v5.21] 등치 위치 (역순 정합) 로 이전 + ROADMAP entry 제거. trace = REPORT.md + git log + CHANGELOG 3중 보존')"
    },
    {
      "id": "D12",
      "decision": "post-report-write.sh L173 hook 메시지 갱신 (smoke-posttooluse-hook 회귀 자동 차단 부재 인지)",
      "rationale": "현 메시지 'next_candidates 를 ROADMAP milestones[] 에 status:pending 등록' → 신 메시지 'next_candidates 를 ROADMAP next_candidates[] 필드에 등재 (v5.21+ schema)'. **smoke-posttooluse-hook (25 checks Dynamic A~V) 는 `tests/_inactive/` 안 거주 (회귀 risk review P1 evidence) — pre-commit 자동 차단 부재**. active 7 hook (smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift / smoke-bundle-trigger / smoke-open-stage-discipline) 안 본 hook 메시지 검증 부재 = 회귀 자동 차단 0. **수동 검증 권고** — phase-3 EXECUTE 직후 (commit 직전) `bash tests/_inactive/smoke-posttooluse-hook.sh` 수동 호출 25/25 PASS evidence 확보. 단 hook 본질 = silent additionalContext inject (session UX 영향, 회귀 본질 아님). active 승격은 v5.22+ 별도 candidate (PROPOSE 거명 가능)",
      "exact_text_diff": "before: 'PROPOSE.md 작성 감지 (9-stage era). next_candidates 를 ROADMAP milestones[] 에 status:\"pending\" 등록 + ROADMAP v2.0 status:\"completed\" 갱신 + 사용자 확인 후 push (/harness-meta).'\nafter: 'PROPOSE.md 작성 감지 (9-stage era). next_candidates 를 ROADMAP next_candidates[] 필드에 등재 (v5.21+ schema A2) + 본 milestone milestones[] entry status:\"completed\" 갱신 + archival cycle (completed > 3 시 가장 오래된 CHANGELOG 이전) + 사용자 확인 후 push (/harness-meta).'"
    },
    {
      "id": "D13",
      "decision": "narrative 정전화 3 단계 패턴 적용 (v3.21 cycle 23 누적, 도그푸드) + phase-3 markdownlint self-check 의무",
      "rationale": "(a) DESIGN.D10 + D11 + D12 exact_text 1차 source (markdown code block) / (b) phase-3 EXECUTE 안 Edit tool 그대로 삽입 / (c) VERIFY grep 키워드 (예: 'drift 해소' + 'next_candidates[]' + 'archival cycle'). 매트릭스 row #3 갱신 의무 (ARCHITECTURE § 4 끝 매트릭스 v5.21 갱신, # 3 본질 변경 표기). **phase-3 commit 직전 의무: `markdownlint --all-files` self-check** (회귀 risk review P2 흡수) — v5.16 narrative 정합 (MD022/MD031/MD032 hardcode + MD028 회귀 risk 사전 차단)"
    },
    {
      "id": "D14",
      "decision": "milestones.md sub_milestones 갱신 (DESIGN phase 결정 후)",
      "rationale": "OPEN 단계 작성 milestones.md placeholder → DESIGN D4 phase_structure 정합 갱신. sub_milestones[] = phase-1/2/3 entry. EXECUTE 진입 전 의무",
      "exact_text_sub_milestones": "[\n  {\"id\": \"phase-1-changelog-backfill\", \"title\": \"CHANGELOG.md v5.7~v5.20 14 entry backfill\", \"status\": \"pending\", \"phase\": 1},\n  {\"id\": \"phase-2-roadmap-schema-redesign\", \"title\": \"ROADMAP schema A2 + completed 41건 archival\", \"status\": \"pending\", \"phase\": 2},\n  {\"id\": \"phase-3-cascade-narrative\", \"title\": \"cascade 7 host narrative + § 4 끝 #3 drift 해소\", \"status\": \"pending\", \"phase\": 3}\n]"
    },
    {
      "id": "D15",
      "decision": "ROADMAP convention 외부 spec 부재 hardcode (v5.7 spike 패턴 정합)",
      "rationale": "spec-drift review P1 흡수. RESEARCH ext_3 안 'ROADMAP convention 외부 명시 spec 부재, narrative 추정 wave' 인지 narrative 보유, 단 DESIGN.decisions 안 hardcode 부재 = v5.7 spike 패턴 3단계 중 (d) DESIGN.decisions hardcode 단계 누락. 본 D15 = (d) 단계 충족. v5.21 schema A2 의 'milestones[] = past trace / next_candidates[] = forward-looking' 이원 분리는 Keep a Changelog (CHANGELOG = past) + 일반 product roadmap convention (forward-looking) 의 본 repo 합성. **외부 spec authority claim 회피, internal canon 으로 정전화**. v5.7 spike 패턴 (RESEARCH 추정 → DESIGN 식별 → DESIGN 즉시 정정 → hardcode) 정확 정합",
      "exact_text_hardcode": "**v5.21 ROADMAP 신 schema A2 의 spec 근거 = 본 repo internal canon**: 외부 spec 안 'ROADMAP forward-looking + past archival' 이원 분리 명시 spec 부재 (RESEARCH ext_3, 추정 narrative 인지). 본 milestone 안 (a) Keep a Changelog v1.1.0 (CHANGELOG = past trace, 외부 spec 명시) + (b) 일반 product roadmap convention (forward-looking, 외부 spec 명시 부재) 합성으로 internal canon 정전화. 외부 spec authority claim 회피. context7 추가 검증 source 부재 = '추정 narrative 유지' (v5.7 spec-drift spike 패턴 정합)"
    },
    {
      "id": "D16",
      "decision": "ARCHITECTURE § 4 끝 #2 paragraph cross-ref 추가 + 매트릭스 row #3 row replace narrative",
      "rationale": "architecture review P1 흡수. § 4 끝 #2 (Word-fidelity drift 수용, v3.20 정전화) 안 9 stage 부합도 평균 86.1% / PROPOSE 70% drift narrative — 본 v5.21 안 PROPOSE register 책임 등재 위치 명료화 (milestones[] status:pending → next_candidates[]) 효과로 PROPOSE 부합도 70% → ~90% 부분 해소 자연 발생 (D11 narrative 안 oos_2 정합 — 단어 분리 아님 명시). § 4 끝 #2 paragraph 안 cross-ref 1줄 추가: '(v5.21 PROPOSE 등재 위치 명료화로 PROPOSE drift 70% → ~90% 부분 해소 — 단 단어-책임 분리 아님)'. 매트릭스 row #3 (ROADMAP 단어 drift 수용 → drift 해소 본질 변경) 은 row replace (v5.9 baseline 유지 + v5.21 신규 method 'drift 해소 정량 ~30~40% → 95%+ 추가). v3.21 narrative 정전화 3 단계 패턴 cycle 23 도그푸드 (D13 정합)"
    }
  ],
  "phases": [
    {
      "phase": 1,
      "scope": "CHANGELOG.md v5.7~v5.20 14 entry backfill (역순 삽입)",
      "affected_files": [
        "CHANGELOG.md"
      ],
      "commit": "feat(meta): v5.21 phase-1 — CHANGELOG.md v5.7~v5.20 14 entry backfill"
    },
    {
      "phase": 2,
      "scope": "ROADMAP.md schema A2 + completed 41건 archival + next_candidates[] 신규",
      "affected_files": [
        "projects/meta/ROADMAP.md"
      ],
      "commit": "feat(meta): v5.21 phase-2 — ROADMAP schema A2 + completed 41건 CHANGELOG 이전 + next_candidates[] 신규 필드"
    },
    {
      "phase": 3,
      "scope": "cascade 7 host narrative + § 4 끝 #3 drift 해소 정전화 + [v5.21] CHANGELOG entry",
      "affected_files": [
        "CLAUDE.md",
        "claude/hooks/post-report-write.sh",
        "claude/commands/harness-meta.md",
        "bootstrap/agents/CLAUDE.md",
        "projects/meta/ARCHITECTURE.md",
        "CHANGELOG.md",
        "projects/meta/milestones/v5.21/milestones.md"
      ],
      "commit": "feat(meta): v5.21 phase-3 — cascade 7 host narrative + § 4 끝 #3 drift 해소 + [v5.21] CHANGELOG entry"
    }
  ]
}
```

## Approach

- **summary**: 3-phase sequential — (1) CHANGELOG backfill 우선 (archival 위치 사전 준비) → (2) ROADMAP schema redesign + content reduce (CHANGELOG 이전 완료 후 ROADMAP entry 제거 안전) → (3) cascade 7 host narrative 동기 (schema 변경 후 cascade 자연). 각 phase 1 commit (conventional commits). v3.21 narrative 정전화 3 단계 패턴 정합 — DESIGN exact_text 1차 source + EXECUTE Edit + VERIFY grep
- **stage_word_fidelity_mapping**: 본 milestone = Trace 요소 재정의 (§ 3.3 5요소 매트릭스). Workflow 자체 변경 부재. PROPOSE register 책임 의미 부분 흡수 (PROPOSE → ROADMAP.next_candidates[] 1:1 매핑, 70% drift 부분 해소)

## Risk mitigation

- risk_id: risk_1 (self-reference); mitigation: Trace 본질 명시 (Workflow 자체 변경 부재). v4.0 정체성 자연 부합 명료 narrative 안 흡수. workflow self-improvement 본질 아님
- risk_id: risk_2 (cascade_drift); mitigation: narrative 정전화 3 단계 패턴 (D13). 7 host inventory cell-by-cell 검증. phase-3 commit 전 grep 3 키워드
- risk_id: risk_3 (trace_loss); mitigation: deferred 3건 entry 보존 (D7). recent 3건 외 archival = CHANGELOG entry + REPORT.md + git log 3중 보존
- risk_id: risk_4 (changelog_duplicate); mitigation: phase-1 EXECUTE 안 dedupe 검증 (CHANGELOG 안 [vX.Y] 헤더 grep). v3.0~v3.14 이미 backfill 위치 보존, v5.7~v5.20 만 신규 삽입
- risk_id: risk_5 (smoke_regression); mitigation: RESEARCH 안 검증 완료 — smoke 7건 모두 영향 부재 또는 호환. 단 smoke-posttooluse-hook 25 checks 키워드 변경 시 동기 갱신 (phase-3 EXECUTE 안 직접 검증)
- risk_id: risk_6 (upbit_cascade); mitigation: D3 Meta only 결정 — 사용자 명시. v6.0 자동 전환 milestone 진행 시 upbit cascade 자연 발의 가능 (별도 PROPOSE)
- risk_id: risk_7 (propose_semantics); mitigation: Schema A2 (D2) — next_candidates[] 별도 필드 = 의미 명료. 'pending' status (현행) vs 'next_candidate' (Option A1 후보) 의미 중복 회피. Stage I PROPOSE 절차 narrative 갱신 (D11)
- risk_id: risk_8 (hook_message); mitigation: post-report-write.sh L173 hook 메시지 갱신 (D12) + smoke-posttooluse-hook 키워드 변경 동기 검증 (phase-3 EXECUTE 안 grep)

## 5 관점 검토 (phase별 review 위탁, 본 milestone EXECUTE 진입 전)

### 검토 위탁

5 관점 subagent 병렬 호출 (architecture / spec-drift / 회귀 risk / 보안 / scope contract). 각 관점 read-only audit + decisive issue 여부 + 권고. 결정적 이슈 발견 시 본 DESIGN 안 흡수 + 사용자 명시 결정 round 추가.

### 5 관점 결과 (subagent 검토 완료, 2026-05-19)

| 관점 | verdict | decisive | 주요 P1 권고 | 흡수 위치 |
|---|---|---|---|---|
| architecture | pass-with-comments | 부재 | (a) § 4 끝 #2 paragraph PROPOSE drift cross-ref 추가 (b) INTENT mapping `(c) 정전 sub-mechanism 분리` 정정 | D16 (a) + INTENT.harness_engineering_mapping (b) |
| spec-drift | pass-with-comments | 부재 | D15 신규 — ROADMAP convention 외부 spec 부재 hardcode (v5.7 spike 패턴) | D15 신규 |
| 회귀 risk | pass-with-comments | 부재 | D12 정정 — smoke-posttooluse-hook `_inactive` 거주, pre-commit 자동 검증 부재 + 수동 검증 권고 | D12 갱신 |
| 보안 | pass-with-comments | 부재 | (P2 흡수) next_candidates[] schema strict regex + sanitize awareness | D2 schema_validation_pattern_source + D9 sanitize_awareness |
| scope contract | pass-with-comments | 부재 | (a) D11 'PROPOSE register 책임 분리 아님' 표지 강화 (b) sc_3 cross-cutting 명시 | D11 갱신 (a) + 본 § sc_3 명시 (b) |

**5/5 PASS, decisive 부재. APPROVE Stage 진입 가능.**

### P2 추가 흡수 (DESIGN 안 narrative 보강)

- spec-drift P2 — D9 entry 분류 가이드 (Changed 우선, Added 한정 — narrative canonicalization 본질 우위): D9.category_mapping_rule 흡수
- 회귀 risk P2 — phase-3 commit 전 `markdownlint --all-files` self-check 의무: D13 narrative 보강
- 보안 P2 — CHANGELOG 이전 시 5 메타 문자 sanitize awareness: D9.sanitize_awareness 흡수
- 보안 P2 — next_candidates[] schema strictness (id regex + target_version regex): D2.schema_validation_pattern_source 흡수

### sc_3 cross-cutting 명시 (scope contract P1 (b))

sc_3 (completed 41건 CHANGELOG 이전, 중복 회피 + backfill) = phase-1 + phase-2 cross-cutting:

- **phase-1 책임**: CHANGELOG v5.7~v5.20 14 entry 역순 삽입 + dedupe 검증 (CHANGELOG 안 [vX.Y] 헤더 grep, 동일 헤더 존재 시 본문만 강화 또는 skip)
- **phase-2 책임**: ROADMAP entry 41건 (recent 3건 + deferred 3건 외) 제거 + summary CHANGELOG 동치 entry mapping 검증

VERIFY.criteria_check 분기 명료화 의무 — phase-1 직후 CHANGELOG 안 14 entry 존재 검증 + phase-2 직후 ROADMAP 안 7 entry (in_progress 1 + recent 3 + deferred 3) 검증.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- milestones.md (phase 결정 후 갱신): [`milestones.md`](milestones.md)
