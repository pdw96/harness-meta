# ROADMAP — meta

```json
{
  "project": "meta",
  "updated": "2026-05-27-v8.8-completed",
  "schema_note": "v5.21+ schema A2: milestones[] = recent 3 completed + in_progress + deferred only. next_candidates[] = PROPOSE 발의 후보 (id/title/trigger/origin_milestone/target_version/description). 과거 completed entry archival = CHANGELOG.md (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). next_candidates[].id regex: ^[a-z0-9-]+$ (group-slug, path-safe). target_version regex: ^v[0-9]+\\.[0-9]+$ (semver). v5.21_roadmap-forward-looking-redesign-and-changelog-archival 정전화. trace 3중 보존 = REPORT.md + git log + CHANGELOG entry. entry title 가이드 = ARCHITECTURE.md § 7.2 4 원칙 (v6.0 정전화) — 한 entry = 한 본질 + ≤ 60자 + active form + detail 은 summary 안. candidate_draft[] entry schema (v6.5_claude-autonomous-milestone-proposal 정전화): 7 필드 = id/title/source/detected_at/rationale/category/decision_pending. category enum 2 값 = 'internal_synthesis' (v6.5 자율 발의 = 내부 ROADMAP + 최근 5 milestone PROPOSE 종합, v7.0 T1.2 후 lessons P2 자동 종합 제외) | 'benchmark_external' (v4.0 벤치마크 cycle routine = 외부 GitHub + Claude Code release notes). smoke tests/smoke-candidate-draft-schema.sh 자동 강제. next_candidates[] append = 사용자 명시 결정 게이트 후만 (자동 append 폐지, v7.0 T1.2 정전화). lessons P2/P3 자동 enumerate 폐지 — PROPOSE stage 안 사용자 명시 결정만 candidate 본질 source (scripts/propose_next.py lessons P2 grep/count 제거 정합). 기존 33 next_candidates (부산물 cycle 누적 임시 후보) 일괄 폐기 — git history 보존.",
  "deferred_note": "동결 정책 은퇴 (v8.1_meta-lightweight-flow-design, 2026-05-26). 구 동결 정책 (v3.13_pending-milestone-renumber-policy + v3.14_deferred-revaluation-cycle-2 자기참조 milestone 동결 + v4.0 § 6.2 폐지 후 재발의 trigger 조건 '외부 적용 5건+ ∧ 사용자 명시 발의') 은 컨설턴트 정체성 (harness engineering 컨설턴트) + 가벼운 흐름 창구 (ARCHITECTURE § 7.4) 도입으로 무의미해짐 — '§ 6.2 부활' 아닌 deferred_note drift 해소 (memory feedback_section_6_2_abolished 정합, 자기참조 루프 우려가 가벼운 흐름으로 흡수). deferred 3건 처리 = (1) v1.5_research-cascade-grep-discipline → v8.2 가벼운 흐름 도그푸드 실처리 (completed) + (2) v1.4_hook-narrative-separation / v1.4_design-review-trace → next_candidates[] 전환 (작은 건 = 가벼운 흐름 후보). deferred[] = 빈 배열 (동결 대상 부재).",
  "candidate_draft": [],
  "milestones": [
    {
      "version": "v8.8",
      "id": "settings-allowlist-secret-scan",
      "title": "settings allow-list 평문 secret SessionStart 스캔 자산 신설",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v8.8/MILESTONE.md#sub-milestones",
      "summary": "v8.7 P0-1+P1-2 origin (next_candidate secret-guard-settings-allowlist-scan 소비, 조사 후 재설계). v8.7 부수 발견 — Claude Code 가 과거 curl 명령을 settings.local.json allow 리스트에 통째 저장하며 Docker Hub PAT+JWT 평문 박제. 조사 결과 후보의 전제 2겹 붕괴: (1) harness-meta 엔 확장할 secret-guard.py 자체가 부재 (외부 price-compare 의 hook 은 audit-team 즉석 생성 1회성 외부 부품, harness-meta 미소유 — hook 템플릿 라이브러리 0건) + (2) allow 리스트 박제는 PreToolUse(Edit|Write) 로 구조적 관측 불가 (Claude Code 가 settings 파일 직접 갱신 = 도구 호출 아님, claude-code-guide 확인 — allow 갱신 발화 hook 이벤트 부재). 따라서 기존 hook 확장 ❌ → 별도 메커니즘(SessionStart 주기 스캔) 필요. 결정 = harness-meta 에 settings*.json allow 리스트 평문 secret 스캔 SessionStart hook canonical 자산 신설 — harness-meta 자신 보호(이미 SessionStart hook 운영 중) + audit-team 이 외부에 권고할 재사용 컨설팅 자산. 새 컨설팅 자산 = 큰 건(9-stage). self-loop 로 못 본 보안 격차의 외부 검출 → 제품 보강."
    },
    {
      "version": "v8.7",
      "id": "price-compare-coexistence-audit",
      "title": "price-compare 이종 fleet 공존 audit 능동 재수행",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.7/LIGHTWEIGHT.md",
      "summary": "가벼운 흐름 (4 섹션) — v8.6 external-application-active-drive 소비. 검증철학(외부 적용=제품 역량 검증 1차 vector)의 첫 능동 실 무대. price-compare 현 HEAD(14bb1a3) working tree 의 살아있는 자작 fleet(6 도메인 agent + rules 3 + skill 1 + settings.json, untracked) 대상 full audit-orchestrator Step1~4 read-only chain(Step5 미spawn, 외부 repo write 0). 결과: harness_kind=mixed→heterogeneous 우선, Task 2.5(v8.4 이종 충돌 case) Step 2 구조적 발화(false positive 0), replace 억제 5건(자작 reviewer/도메인 fleet/워크플로우 존중), 격차 보강 extend 4건. fact-verify hallucination 0. 부수 발견=settings.local.json:37-38 평문 Docker Hub PAT+JWT(repo:admin) 박제 보안사고(메인 Claude 직접 Read 재확인, 즉시 회수 권고, secret-guard.py Edit/Write 한정 scope 격차). v8.5(과거커밋 대조)→v8.7(현 working tree 능동) — self-loop로 못 본 보안격차 외부 검출 재현."
    },
    {
      "version": "v8.6",
      "id": "verification-philosophy-redefine",
      "title": "검증철학을 외부 적용 1차 vector로 재정의",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.6/MILESTONE.md#sub-milestones",
      "summary": "v8.0 oos_3 origin. 자기개발(meta self-loop, 책상 검증)≠제품 역량 검증(외부 적용, 현장 검증)을 ARCHITECTURE § 3.1 신 paragraph 에 명시 분리 선언 + 외부 적용을 제품 컨설팅 자산의 1차 역량 검증 vector 로 정전화(v8.3/v8.5 실증 2건 근거). self-loop 92.3% = '자기개발 trace 통계'로 재라벨(수치 보존, oos_2). '검증' 3중 의미(9-stage VERIFY(G)/5요소 Verification=책상 vs 제품 역량 검증=현장)는 제품 층위만 신설로 경계(기존 단어 무손상, sc_5 FAIL=0). 산출물=문서 only(§ 3.1 1차 source + § 3.3 row 명료화 + § 7.1 단방향 pointer). design-review 3관점 pass-with-comments(decisive 1건 host 컬럼 흡수). sc 5/5 MET, verdict RESOLVED. 후속=external-application-active-drive(oos_1, 사용자 게이트)."
    },
    {
      "version": "v8.5",
      "id": "price-compare-reaudit-conflict-verification",
      "title": "price-compare 실 재audit으로 v8.4 충돌 판정 실효 검증",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.5/LIGHTWEIGHT.md",
      "summary": "가벼운 흐름 (4 섹션) — v8.4 보강(이종 하네스 충돌 판정)의 실효를 실 외부 vector로 검증. v8.4는 sc_4를 narrative 시뮬레이션으로만 검증하고 실 재audit은 oos_3로 분리했던 것을 사용자 발의로 수행. v8.3에서 gsd가 완전 삭제(905e80f)돼 heterogeneous 시나리오가 현재 HEAD(14bb1a3)에 없으므로, gsd 제거 직전 커밋 abfc174를 git worktree로 비파괴 체크아웃해 대조 audit. full audit-orchestrator chain Step1~4 read-only(Step5 installer 미spawn, 외부 repo write 0) × 2상태. 결과: abfc174=harness_kind=heterogeneous→Task2.5 Step2 선행 발화→권고 replace 0건(기존 자산 존중+격차 보강) / HEAD=harness_kind=harness-meta→Task2.5 NO-OP(false positive 없음). v8.4 sc_4 시뮬레이션이 실 audit으로 재현 + 대조군이 과적합 risk_1 반증. verification-philosophy-redefine(v8.6) 첫 실 검증 데이터."
    },
    {
      "version": "v8.4",
      "id": "audit-team-heterogeneous-harness-conflict-case",
      "title": "audit-team 충돌 매트릭스에 이종 하네스 충돌 case 추가",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v8.4/MILESTONE.md#sub-milestones",
      "summary": "v8.3 origin (audit-team-blank-slate-assumption-check 후보 승격). v8.3 price-compare 외부 적용에서 노출된 audit-team 결함 — RESEARCH 정밀 조사 결과 'project-scanner가 기존 하네스를 못 본다'는 부정확(harness_state로 inventory함). 진짜 gap = harness-gap-analyzer Task2 충돌 매트릭스가 'custom vs Claude Code built-in'만 다루고 '기존 이종 하네스(gsd 등 비-harness-meta 방식) vs harness-meta 신규 권고' 충돌 case 부재 + orchestrator Step6은 fact/lint만이라 입력 전제 정정이 구조적으로 강제되지 않음(v8.3 정정은 ad-hoc). 최소 변경 = gap-analyzer 매트릭스에 이종 하네스 충돌 case 1행 + project-scanner harness_state 방식 판정 힌트 1줄. audit-team=고객 납품 컨설팅 도구라 §7.4상 규모 작아도 9-stage 의무."
    },
    {
      "version": "v8.3",
      "id": "price-compare-external-harness-application",
      "title": "price-compare 외부 harness 적용으로 audit-team 백지전제 결함 검출",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.3/LIGHTWEIGHT.md",
      "summary": "가벼운 흐름 (4 섹션) — 첫 이종 스택 외부 적용 실증. self-loop 92.3%(외부 upbit 1건뿐) 격파 위해 사용자 발의로 price-compare(Next.js/TS/Prisma/k8s — upbit Python 트레이딩과 이질)에 audit→권고→e3→부품 배치 전 과정 수행. 적용 깊이=부품만(9-stage 이식 ❌, .harness.toml ❌ — 정체성=적재적소 부품 배치 정합). 배치=secret-guard + git-push-guard hook(audit P0#2/P1#3#4, 차단 아닌 경고, 로직 파일 분리). 사용자 결정으로 gsd(get-shit-done-cc + .planning 86파일 + worktree)를 선행 완전 삭제. 외부 repo 커밋 905e80f(gsd 제거)+14bb1a3(hook 배치, push 없음). 핵심 교훈=audit-team '신규=백지' 전제가 외부에서 깨짐(price-compare는 이미 gsd+자작 하네스 보유) → 책임이 '구축'→'기존 자산 존중+충돌 회피+격차 보강'으로 재정의, self-loop로는 못 본 결함. verification-philosophy-redefine 첫 실증 데이터."
    },
    {
      "version": "v8.1",
      "id": "meta-lightweight-flow-design",
      "title": "meta 가벼운 흐름을 컨설팅 자산으로 도입",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.1/MILESTONE.md#sub-milestones",
      "summary": "v8.0 oos_1+oos_2 origin (재구성 2단계). meta-work 용 가벼운 흐름(문제→결정→적용→기록 4섹션 한 장) 설계·도입. 사용자 pre-PLAN 대화(2026-05-26)로 본질 격상 — harness-meta = harness engineering 컨설턴트라는 정체성에서, 가벼운 흐름은 meta 전용이 아니라 외부(upbit 등)도 쓸 컨설팅 자산. 승격 기준 = 컨설팅 자산(방법론·도구) 영향=큰 건(9단계)/내부·작은 조정=가벼운 흐름. v8.1 자체는 새 자산 추가=큰 건이라 9단계로 진행(부트스트랩 자동 해소). 범위 = 자산 설계 + meta 검증까지, upbit 실적용은 후속. lightweight 1-phase 반창고는 가벼운 흐름이 대체, 동결 정책은 재평가."
    },
    {
      "version": "v8.2",
      "id": "research-cascade-grep-discipline",
      "title": "RESEARCH cascade host grep 3 형식 규율 보강",
      "status": "completed",
      "trigger": "B_regression",
      "milestones_path": "milestones/v8.2/LIGHTWEIGHT.md",
      "summary": "harness-meta 첫 가벼운 흐름(4섹션 트랙, ARCHITECTURE § 7.4) 산출물 — v8.1 도그푸드. deferred v1.5(v1.4 lessons #1 — RESEARCH cascade host grep 이 relative path 누락) 해소. stage-research SKILL.md 에 cascade host grep 3 형식(relative/절대/symlink·anchor) 규율 1 블록 추가. 9-stage ceremony 8 섹션 대신 4 섹션 한 장 = v6.23 표본(9-stage 산출이 자기 장부정리 문단 1개) 본말전도 해소 evidence. v8.1 sc_5(가벼운 흐름 실작동) 직접 입증."
    },
    {
      "version": "v8.0",
      "id": "reclassify-meta-as-development",
      "title": "meta를 development/ 최상위로 재분류",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v8.0/MILESTONE.md#sub-milestones",
      "summary": "meta = 프로젝트 아닌 repo 제품-개발 이력 재구성의 1단계 (단계적, 사용자 다라운드 pre-PLAN 도출). projects/meta(외부 적용과 같은 서랍)를 최상위 development/로 재분류 — projects/는 외부 적용(upbit)만 보존. 진단: meta-work(프레임워크 진화)와 외부 적용은 본질이 다른데 같은 projects/에 들어가 dogfooding 착시 + 자기참조 루프를 낳았고, 동결 정책·lightweight 모드 2 반창고로 봉합돼왔다(v6.23 표본 = 9단계 산출이 자기 장부정리 문단 1개; 파일 비율 자기개발~200 vs 외부~6). 1단계 = git mv projects/meta→development/ + 살아있는 배선 ~30-40개 갱신, 과거 milestone ~200개 폴더째 이동(자기 이사를 스스로 기록). 구조 breaking → major bump v8.0. 후속: 2단계 가벼운 흐름 도입 + 반창고 은퇴, 검증철학(dogfooding 은퇴) 별도."
    },
    {
      "version": "v7.1",
      "id": "context-gauge-and-stage-carryover",
      "title": "컨텍스트 효율 게이지·stage carry-over 권고",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v7.1/MILESTONE.md#sub-milestones",
      "summary": "candidate_draft 'stage-completion-context-clear-recommendation' 채택 + 검증 후 재설계. 컨텍스트 % 실시간 신호는 statusline stdin JSON context_window.used_percentage 에만 존재 (hook ❌ / 세션 안 모델 직접 ❌, claude-code-guide verify v2.1.132+) → 2 반쪽 분리: (1) 계기판 = statusline.sh 가 stdin used_percentage 표시 + 임계 마커 / (2) carry-over = stage 완료 결정적 trigger 에 carry-over 블록 + /clear 권고. v7.0 6 mechanism 첫 dogfood (design-review N+가변 / RESEARCH Explore 병렬 / next_candidates 절제). AI Native § 7.1 컨텍스트 효율 면."
    },
    {
      "version": "v7.0",
      "id": "ai-native-mechanism-installation",
      "title": "AI Native 6 mechanism 설치 (외부 vector 운영)",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v7.0/MILESTONE.md#sub-milestones",
      "summary": "Claude Code 2026-w13+ 외부 vector (Auto-Mode / .claude/rules/ / SessionStart hook) 정합 6 mechanism 설치 — Tier 0 (T1.6 버전추적 + T1.1 .claude/rules 3-way 직교) → Tier 1 (T1.5 Auto-Mode 최소권한) → Tier 2 (T1.3 design-review N+가변 + T2.3 RESEARCH Explore 병렬) → Tier 3 (T1.2 next_candidates 절제) → Tier 1.5 (T1.6b 권한 정전화). 설치만 (정정 #7, 첫 사용 v7.1) + T2.1 완전 폐기 (정정 #1). root v7-design.md 13 정정 권위 source. 5-phase (Tier 단위 1 commit: 034f0e8/7e83ce7/f28375b/857a85b/fb3e057) + 정식화 + sc 7/7 PASS + risk 5/5 MITIGATED + verdict RESOLVED. ## SUB_MILESTONES 6 mechanism (cycle 2, v6.23 첫 활용 후). 외부 spec 실재 ≠ plugin 배포 (settings/rules repo-local) + 설치≠사용 분리 (L3 full rollback 격리) lessons."
    },
    {
      "version": "v6.23",
      "id": "version-mechanism-integration-rethink",
      "title": "version mechanism 통합 재고",
      "status": "completed",
      "trigger": "A_user",
      "milestones_path": "milestones/v6.23/MILESTONE.md#sub-milestones",
      "summary": "milestone version mechanism 통합 재고 lightweight 1-phase milestone — 2 sub-milestone (v6.23.1 bundling cycle 자연 발현 평가 + v6.23.2 git tag 단일 source 평가) 자연 통합. 평가 outcome 두 결정 = v6.23.1 opt_2 자연 발현 (R6, 현행 본질 명문화) + v6.23.2 opt_4 N=5 유지 + 5 source 우선순위 narrative 정전화 (R7). ARCHITECTURE § 4 끝 매트릭스 #16 row + paragraph 본문 추가 (단일 host, v3.21 cycle 43 single host cycle 3 누적). 'forward-only forsake' misnomer evidence 흡수 (R5 historical 보존) + ## SUB_MILESTONES 첫 실 활용 cycle dogfood (v6.2~v6.22 21 milestone 부재 후 첫, cb_8). 9 round 누적 결정 + 7 commit (lightweight 1-phase v6.6~v6.22 14 consec → v6.23 15 consec) + 7 lessons (L1~L7 P1 × 3 + P2 × 3 + P3 × 1) + verdict RESOLVED."
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
      "id": "hook-narrative-separation",
      "title": "hook hard-code 메시지 narrative 분리 (post-report-write.sh)",
      "trigger": "D_design",
      "origin_milestone": "v8.1",
      "target_version": "v8.4",
      "description": "구 deferred v1.4_hook-narrative-separation — v1.3 § 3.1 명료화 단락 거명 자동화 #2 'hook hard-code'. post-report-write.sh inject 메시지를 shell 안에 박지 않고 MD 파일에 분리, hook 은 단순 reader. v8.1 동결 정책 은퇴로 deferred → next_candidates 전환 (작은 건 = 가벼운 흐름 후보 자연). v1.4_design-review-trace 와 같은 workflow-trace 테마 = bundling 적격."
    },
    {
      "id": "design-review-trace",
      "title": "Stage D 5 관점 검토 raw 출력 보존 (design-review/)",
      "trigger": "D_design",
      "origin_milestone": "v8.1",
      "target_version": "v8.4",
      "description": "구 deferred v1.4_design-review-trace — § 3.3 매트릭스 'Trace' 정합이나 Stage D design-review 5 관점 검토 결과가 MILESTONE.md 통합 후 raw 출력 소실. milestones/v{X.Y}/design-review/{architecture,spec-drift,...}.md 로 보존 후보. v8.1 동결 정책 은퇴로 deferred → next_candidates 전환. hook-narrative-separation 과 bundling 적격 (workflow-trace 테마)."
    }
  ]
}
```

## 의도 (v5.21+ schema A2)

본 ROADMAP 은 **forward-looking 이정표** — 사전적 의미 (Merriam-Webster '목표를 향한 진행을 안내하는 상세 계획' / Cambridge 'step-by-step visibility') 정합. `milestones[]` = 현재 진행 (in_progress) + 최근 완료 (recent 3건, carry-over context) + deferred (재발의 trigger 조건 보유) + `next_candidates[]` = PROPOSE 발의 후보 (forward-looking 본질).

**과거 completed entry archival** = [`../../CHANGELOG.md`](../CHANGELOG.md) (Keep a Changelog v1.1.0 정합, v3.15_changelog-v3-backfill + v5.21 backfill 패턴). trace 3중 보존:

1. **CHANGELOG.md entry** — 외부 visible artifact (release note 동치)
2. **milestones/v{X.Y}/REPORT.md** — milestone 종합 backward (lessons + delta)
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

본 ROADMAP 은 v5.21_roadmap-forward-looking-redesign-and-changelog-archival (2026-05-19) 에서 schema A2 재설계. 이전 schema (v3.0+ 9-stage-bundled era, v3.0_milestones-restructure 도입) 는 `milestones[]` 단일 array 안 forward + past 혼재 = ~30~40% 부합 drift (v3.19/v5.9 정전화). v5.21 schema A2 는 `milestones[]` + `next_candidates[]` 명료 이원 분리 + CHANGELOG.md archival 흡수 = ~95%+ 부합 도달. 본 파일이 meta 진행/완료/후보 trace 의 단일 source — 단 past trace 본질은 CHANGELOG.md 위임.
