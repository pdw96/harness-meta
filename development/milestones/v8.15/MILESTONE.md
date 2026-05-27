---
id: codex-authored-change-absorption
title: codex 작성 변경을 운영 표면 정합으로 정식 흡수
version: v8.15
status: completed
---

# v8.15 — codex 작성 변경을 운영 표면 정합으로 정식 흡수

## INTENT

### Spec

```json
{
  "id": "codex-authored-change-absorption",
  "title": "codex 작성 변경을 운영 표면 정합으로 정식 흡수",
  "goal": "codex 가 작성자/운영자 없이 working tree 로 인계한 광범위 변경을, Claude Code 가 작성자/운영자 역할을 회복하여 줄별 정밀 리뷰한 뒤 9-stage 큰 건으로 정식 기록·흡수하고, 흡수 과정에서 발견된 운영 표면 drift 를 함께 정합한다.",
  "motivation": "codex 평가·개선 작업이 milestone 기록·커밋 확인 없이 진행됨 (CLAUDE.md '모든 변경은 milestone 기록' + '커밋 전 사용자 확인' 위반). codex 는 Claude Code 전용 plugin 미사용 → AGENTS.md 진입 + 자율 준수 의존 → 누락 발생. claude/commands/harness-meta.md:225 cross-check 트랙은 codex=감사자 전제이나 이번엔 codex=작성자로 역전 → Claude Code 가 작성자/운영자 역할 회복하여 정식 흡수 필요. 사용자 명시 큰 건 결정 (2026-05-28).",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": "codex 변경 5갈래(검증 표면 동기화 / plugin manifest smoke / v8.0 narrative 정합 / node24 마이그레이션 / ai-ready-scorer 개선)가 줄별 정밀 리뷰되어 의도 부합·회귀 부재 확인 (RESEARCH 근거 + VERIFY criteria_check)"
    },
    {
      "id": "sc_2",
      "criterion": "흡수 중 발견된 운영 표면 drift 정합 — 최소 tests/CLAUDE.md 하단 '현행 hook 현황' 표 (총 13 hook + 12행 → 실제 15 pre-commit hook) 갱신 + 정밀 리뷰에서 추가 발견 시 함께 정합"
    },
    {
      "id": "sc_3",
      "criterion": "active smoke 15종 전부 PASS (실측 evidence 기록)"
    },
    {
      "id": "sc_4",
      "criterion": "codex 변경은 RESEARCH 중 사용자가 이미 dedf1b2 로 커밋·origin/main 푸시 확인 (.claude/settings.local.json 정상 제외 = AGENTS.md 정합). 본 milestone 은 dedf1b2 를 EXECUTE 에 retroactive 기록 + 잔존 drift 수정 + v8.15 기록을 별 후속 커밋 (명시 staging, never git add . / -A)"
    },
    {
      "id": "sc_5",
      "criterion": "SUB_MILESTONES phases[] = codex 변경 5갈래 (dedf1b2, retroactive) + 잔존/inactive drift 정합 1갈래 = 6 sub-milestone, ai-ready-scorer 포함 (사용자 결정 2026-05-28)"
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "cross-check 트랙의 smoke/hook 강제화 — harness-meta.md:225 '자동 강제 안 함' 명시. 강제화는 별 milestone 발의 본질 (사용자 명시 결정 게이트 후)"
    },
    {
      "id": "oos_2",
      "item": "정밀 리뷰에서 codex 변경의 구조적 결함 발견 시 대규모 재설계 — 본 milestone 은 정밀 리뷰 + drift 정합까지. 구조 재설계는 별 candidate 로 PROPOSE"
    },
    {
      "id": "oos_3",
      "item": "settings.local.json 권한의 영구 정책화 — 본 milestone 은 커밋 제외만 처리. 권한 정책 검토는 별건"
    },
    {
      "id": "oos_4",
      "item": "node24 외 다른 GitHub Actions 버전 전수 audit — codex 는 checkout@v4→v6 만 처리. 나머지 action 전수 점검은 별건 (release-publish.yml 등)"
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "development/ROADMAP.md next_candidate release-workflow-node24-migration (origin v7.1→target v8.15)",
      "purpose": "codex 가 node24 마이그레이션으로 본 candidate 를 소비. 본 milestone 이 정식 흡수하며 candidate 제거를 정합화"
    },
    {
      "id": "dep_2",
      "ref": "claude/commands/harness-meta.md:225 Claude Code × Codex cross-check 트랙",
      "purpose": "역할 분담 정의 (Claude=작성자/운영자, Codex=독립 감사자). 본 milestone 이 역할 역전 사례 — Claude Code 가 작성자 역할 회복"
    },
    {
      "id": "dep_3",
      "ref": "v8.0_reclassify-meta-as-development",
      "purpose": "codex 가 정합한 AGENTS/README/ARCHITECTURE narrative 잔존(projects/meta/→development/)의 origin milestone"
    },
    {
      "id": "dep_4",
      "ref": "tests/CLAUDE.md smoke 매트릭스 + tests/smoke-claude-md-drift.sh",
      "purpose": "흡수 후 root↔모듈 CLAUDE.md drift 정합 검증 source (단 하단 hook 현황 표는 drift smoke 사각지대 — sc_2 수동 정합)"
    }
  ]
}
```

### Narrative

본 milestone 은 **codex 가 작성자로 광범위 편집한 변경을 Claude Code 가 작성자/운영자 역할을 회복하여 정식 흡수**하는 retroactive 기록이다. origin = 사용자가 codex 로 harness-meta 평가·개선 작업을 진행한 뒤 (2026-05-28) milestone 기록 없이 working tree 미커밋 상태로 인계 — CLAUDE.md "모든 변경은 milestone 기록" + "커밋 전 사용자 확인" 두 원칙 미준수. 근본 원인은 codex 가 Claude Code 전용 plugin (skill/command/subagent) 을 못 쓰고 `AGENTS.md` 진입 + 자율 준수에 의존하기 때문이다.

설계상 cross-check 트랙(harness-meta.md:225)은 **Claude=작성자, Codex=독립 감사자** 전제이나, 이번엔 codex 가 작성자였던 **역할 역전** 상황이다. 따라서 본 milestone 의 핵심은 (1) Claude Code 가 작성자/운영자 역할을 회복하여 codex 변경을 줄별 정밀 리뷰하고 (사용자 결정 2026-05-28), (2) 변경을 5갈래(검증 표면 동기화 / plugin manifest smoke / v8.0 narrative 정합 / node24 마이그레이션 / ai-ready-scorer 개선)로 SUB_MILESTONES 분할 기록하며, (3) 흡수 중 발견된 운영 표면 drift(특히 tests/CLAUDE.md 하단 hook 현황 표가 13건으로 stale — smoke 사각지대)를 함께 정합하는 것이다.

scope 경계 = 정밀 리뷰 + drift 정합 + 정식 기록 + 명시 staging 커밋까지. cross-check 트랙 강제화(oos_1), 구조적 재설계(oos_2), settings 권한 정책화(oos_3), node24 외 actions 전수 audit(oos_4)은 별건으로 분리한다. ai-ready-scorer 개선은 외부 제공 컨설팅 자산이자 이번 검증 표면 drift 와 직접 연결(같은 smoke 참조 문제 감지)되므로 v8.15 한 phase 로 포함한다 (사용자 결정).

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "git log / git rev-parse (HEAD vs origin/main)",
      "finding": "RESEARCH 중 working tree 의 codex 변경이 전부 사라짐을 발견 → commit dedf1b26ef45982eaf4dd4e5a55b42bf9ef75c95 'fix(meta): align smoke automation and plugin checks' (author Dowon Park, 2026-05-28 02:58:22 +0900) 로 커밋됨. HEAD == origin/main 확인 = 이미 origin/main 푸시 완료. 포함 20 파일 = codex 변경 전부, .claude/settings.local.json 정상 제외 (sc_4 충족). 커밋 메시지에 milestone 참조/[release:] 마커 부재 = 9-stage 밖 커밋."
    },
    {
      "id": "ext_2",
      "source": "claude/commands/harness-meta.md:225-238 (Claude Code × Codex cross-check 트랙)",
      "finding": "트랙 정의 = Claude(작성자/운영자) + Codex(독립 감사자). 이번 사례는 codex 가 작성자 → 역할 역전. 산출물 흡수 위치 = MILESTONE.md ## DESIGN/## VERIFY 안 codex_cross_check block (자동 강제 안 함, 권장 트랙)."
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": ".github/workflows/ci.yml:33-55 + Makefile:33-58 + .pre-commit-config.yaml (smoke hooks)",
      "finding": "검증 표면 동기화 — active smoke 가 CI ACTIVE_SMOKES 6개에서 15개로 통일, Makefile smoke target + pre-commit 15 hook 과 일치. smoke-workflow-registration.sh 실측 'pre-commit=15, CI=15, Makefile=15' PASS. 회귀 없음."
    },
    {
      "id": "cb_2",
      "ref": "tests/smoke-plugin-manifest.sh + .claude-plugin/plugin.json",
      "finding": "manifest agents 10 ↔ 실제 agents/*.md 10 일치, skills 15 ↔ skills/ 하위 15 일치, commands/hooks path 검증. smoke 실측 'agents=10, skills=15' PASS. 잘 작성됨 (cp949 reconfigure 포함). 회귀 없음."
    },
    {
      "id": "cb_3",
      "ref": "AGENTS.md + README.md + development/ARCHITECTURE.md (v8.0 narrative)",
      "finding": "projects/meta/ → development/ 재분류 narrative 정합. '15 skills', '10 agents', development/milestones/ 경로 등 사실 정확. 회귀 없음."
    },
    {
      "id": "cb_4",
      "ref": ".github/workflows/ci.yml:17 + release-publish.yml:38",
      "finding": "actions/checkout@v4 → @v6 (Node24). 두 workflow 의 uses: 는 checkout 단 1개씩 (release 발행은 gh CLI 사용) → 마이그레이션 완전, 부분 아님. oos_4 (다른 actions 점검) 사실상 무의미."
    },
    {
      "id": "cb_5",
      "ref": "skills/ai-ready-scorer/scripts/{categories_ops,categories_test_quality,html_renderer,score_codebase,categories_documentation}.py",
      "finding": "categories_ops = Makefile 안 깨진 tests/smoke-*.sh 참조 감지 (make_score 차등), categories_test_quality = CI smoke 가 pre-commit smoke 목록 누락 시 감지, html_renderer = line rstrip, score_codebase = trailing newline, categories_documentation = development/ARCHITECTURE.md 경로 인식. 로직 건전, 회귀 없음. ai-ready-report.json/dashboard 재생성물 동반."
    },
    {
      "id": "cb_6",
      "ref": "tests/CLAUDE.md:291 (하단 '현행 hook 현황' 표)",
      "finding": "잔존 drift — 상단 매트릭스는 16 active 로 갱신됐으나 하단 표는 '총 13 hook active' + 12행 그대로 (실제 pre-commit 15). dedf1b2 에도 미수정. smoke-claude-md-drift 는 상단 count 만 검사 (S4) → 하단 표 사각지대. sc_2 수동 정합 대상."
    },
    {
      "id": "cb_7",
      "ref": "tests/_inactive/{smoke-scorer-output-newline,smoke-roi-regression,smoke-detect-language,smoke-agentic-safety-na}.sh",
      "finding": "기존 drift (codex 무관, git status 미변경) — 4 inactive smoke 가 stale 경로 bootstrap/skills/audit/ai-ready-scorer/scripts/ 참조 (scorer 는 skills/ai-ready-scorer/ 로 이전). 전부 'No such file' FAIL. 사용자 결정 (2026-05-28) 으로 v8.15 sub-milestone 포함 수정 (경로 치환)."
    }
  ],
  "options": [
    {
      "id": "opt_1",
      "label": "dedf1b2 EXECUTE retroactive 기록 (채택)",
      "rationale": "이미 푸시된 커밋 — amend/재커밋은 origin/main 강제 푸시 (외부 이력 재작성, 비권장). retroactive 기록 + 잔존 drift 수정을 별 후속 커밋으로 분리하면 9-stage 정직성 유지 + 외부 이력 불변. 사용자 결정 2026-05-28."
    },
    {
      "id": "opt_2",
      "label": "inactive scorer smoke stale 경로 v8.15 포함 수정 (채택)",
      "rationale": "scorer 가 본 milestone phase 5 에 이미 있고, 경로 치환(bootstrap/skills/audit/→skills/)만으로 4건 복구. 별 candidate 분리보다 같은 scorer 맥락에서 묶는 게 효율. 사용자 결정 2026-05-28. (active smoke 아님 = CI 게이트 무영향, 재사용성만 복구)"
    }
  ],
  "risks_identified": [
    {
      "id": "risk_1",
      "description": "dedf1b2 가 milestone 참조/[release:] 마커 없이 푸시됨 → v8.15 와 commit 의 연결이 이력상 암묵적 (commit 메시지로 역추적 불가)",
      "mitigation": "EXECUTE 안 dedf1b2 SHA 명시 + REPORT 안 trace 기록. v8.15 후속 커밋 메시지에 [release:v8.15] 마커 부착 → release-publish.yml 발행 시 dedf1b2 맥락 포함 (DESIGN d_X 결정)."
    },
    {
      "id": "risk_2",
      "description": "inactive smoke 경로 수정 시 다른 stale 참조 (line range / 함수명) 동반 가능 → 경로만 고치면 여전히 FAIL 잔존",
      "mitigation": "EXECUTE 에서 4 smoke 각각 경로 치환 후 실 실행 PASS 확인 (controlled — bootstrap/skills/audit/ 참조 0건 + rc=0 검증)."
    },
    {
      "id": "risk_3",
      "description": "tests/CLAUDE.md 하단 hook 표 갱신 시 상단 매트릭스(16)와 숫자 정합 필요 — 'active 16 = pre-commit 15 + manual 1' narrative 와 하단 'hook active' count 일치 강제",
      "mitigation": "하단 표에 신규 2 hook (smoke-workflow-registration + smoke-plugin-manifest) row 추가 + '총 13→15 hook active' 갱신. smoke-claude-md-drift 재실행 PASS 확인."
    }
  ]
}
```

### Narrative

RESEARCH 의 가장 중요한 발견은 **전제 변경**이다: working tree 의 codex 변경을 줄별 리뷰하던 중 변경이 전부 사라진 것을 발견 → `git log` 추적 결과 사용자가 `dedf1b2` 로 커밋(2026-05-28 02:58)하고 origin/main 에 이미 푸시했음을 확인(`HEAD == origin/main`). 따라서 본 milestone 은 "working tree 흡수"가 아니라 **이미 푸시된 dedf1b2 의 retroactive 정식 기록 + 잔존 drift 정합**으로 재정의된다 (ext_1). dedf1b2 는 `.claude/settings.local.json` 을 정상 제외(sc_4 충족)했으나 milestone 참조/`[release:]` 마커가 없는 9-stage 밖 커밋이다 (risk_1).

codex 변경 5갈래는 줄별 리뷰 결과 **회귀 없음·의도 부합**으로 확인됐다 (cb_1~cb_5): 검증 표면 동기화(6→15), plugin manifest smoke(agents 10/skills 15 일치), v8.0 narrative 정합(사실 정확), node24(checkout v4→v6, 두 workflow 모두 완전 — cb_4 로 oos_4 무의미 확인), ai-ready-scorer 자기참조 개선(깨진 smoke 참조·CI smoke 누락 감지). Claude Code 가 작성자/운영자 역할을 회복해 수행한 정밀 리뷰가 cross-check 트랙(ext_2)의 감사 책임을 대체했다.

리뷰가 추가로 드러낸 drift 2건: (cb_6) `tests/CLAUDE.md:291` 하단 hook 표가 13건으로 stale — dedf1b2 도 못 잡은 smoke 사각지대 → sc_2 수동 정합. (cb_7) `tests/_inactive/` scorer smoke 4건이 옛 `bootstrap/skills/audit/ai-ready-scorer/` 경로 참조로 전부 FAIL — codex 무관 기존 drift이나 scorer 맥락(phase 5)에서 경로 치환으로 함께 복구(사용자 결정, opt_2). 이 둘이 본 milestone 자체 작업(EXECUTE 후속 커밋)의 핵심이며, dedf1b2 5갈래(retroactive)와 합쳐 SUB_MILESTONES 6 sub-milestone 로 분할한다.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "d_1",
      "decision": "dedf1b2 (이미 origin/main 푸시) 는 amend/재커밋하지 않고 EXECUTE 안 SHA 명시로 retroactive 기록. phase-1~5 = dedf1b2 흡수 (구현 완료 표기).",
      "rationale": "RESEARCH opt_1 채택 — 푸시된 커밋 재작성은 외부 이력 재작성(강제 푸시, 비권장). retroactive 기록 + 잔존 drift 별 후속 커밋 분리가 9-stage 정직성 + 외부 이력 불변 둘 다 만족. 사용자 결정 2026-05-28."
    },
    {
      "id": "d_2",
      "decision": "v8.15 후속 커밋 (phase-6 + milestone 기록) 메시지에 [release:v8.15] 마커 부착.",
      "rationale": "risk_1 mitigation — dedf1b2 가 마커 없이 푸시돼 v8.15↔commit 연결이 이력상 암묵적. 후속 커밋 마커가 release-publish.yml 발행을 trigger 하고 REPORT 가 dedf1b2 SHA 를 trace 로 흡수."
    },
    {
      "id": "d_3",
      "decision": "tests/_inactive/ scorer smoke 4건의 stale 경로 bootstrap/skills/audit/ai-ready-scorer/ → skills/ai-ready-scorer/ 치환 (phase-6).",
      "rationale": "RESEARCH opt_2 채택 — scorer 가 phase-5 맥락에 있고 경로 치환만으로 복구. 별 candidate 분리보다 효율. active smoke 아님 = CI 게이트 무영향, 재사용성 복구. 사용자 결정 2026-05-28."
    },
    {
      "id": "d_4",
      "decision": "tests/CLAUDE.md:291 하단 '현행 hook 현황' 표에 신규 2 hook (smoke-workflow-registration + smoke-plugin-manifest) row 추가 + '총 13 → 15 hook active' 갱신 (phase-6).",
      "rationale": "sc_2 + risk_3 — 상단 매트릭스(16 active = pre-commit 15 + manual 1)와 하단 표 count 정합. dedf1b2 미수정 + smoke-claude-md-drift 하단표 사각지대."
    },
    {
      "id": "d_5",
      "decision": "## SUB_MILESTONES = 6 sub-milestone (sub_1~5 = codex 5갈래 dedf1b2 / sub_6 = 잔존·inactive drift 정합) 을 phases[] 와 1:1 동기.",
      "rationale": "sc_5 — SUB_MILESTONES ↔ phases[] 1:1 매핑 의무 (Stage D 완료 직전 의무 step). ai-ready-scorer 포함."
    }
  ],
  "approach": "dedf1b2 (이미 푸시) 를 phase-1~5 로 retroactive 흡수 (구현 완료 표기, 추가 변경 없음) + phase-6 (잔존 drift 정합 = hook 표 + inactive scorer smoke) 을 본 milestone 자체 EXECUTE 작업으로 별 후속 커밋([release:v8.15] 마커, d_2). cascade host 정합 = 본 변경은 ARCHITECTURE § 매트릭스 narrative 변경이 아닌 검증 인프라 운영 표면 + 문서 count 정합 → cascade marker 신설 불요 (tests/CLAUDE.md 는 smoke 매트릭스 자체 narrative, cascade source 아님). 단일 후속 커밋 = phase-6 변경 + v8.15 MILESTONE.md 기록 묶음.",
  "phases": [
    {
      "phase": "phase-1",
      "scope": "검증 표면 동기화 — ci.yml ACTIVE_SMOKES 6→15 + Makefile smoke target + pre-commit 15 hook 통일 + smoke-workflow-registration.sh 신설 (parity 강제)",
      "deliverable": "dedf1b2 (retroactive)",
      "verification": "smoke-workflow-registration.sh 'pre-commit=15, CI=15, Makefile=15' PASS (실측 완료)"
    },
    {
      "phase": "phase-2",
      "scope": "plugin manifest inventory smoke 신설 — smoke-plugin-manifest.sh (manifest ↔ 실제 agents/skills/commands/hooks 일치)",
      "deliverable": "dedf1b2 (retroactive)",
      "verification": "smoke-plugin-manifest.sh 'agents=10, skills=15' PASS (실측 완료)"
    },
    {
      "phase": "phase-3",
      "scope": "v8.0 meta 재분류 narrative 정합 — AGENTS.md / README.md / development/ARCHITECTURE.md (projects/meta/ → development/)",
      "deliverable": "dedf1b2 (retroactive)",
      "verification": "smoke-cross-ref.sh + smoke-claude-md-drift.sh PASS (실측 완료)"
    },
    {
      "phase": "phase-4",
      "scope": "GitHub Actions node24 마이그레이션 — actions/checkout@v4 → @v6 (ci.yml + release-publish.yml, 두 workflow 의 유일 action)",
      "deliverable": "dedf1b2 (retroactive)",
      "verification": "grep uses: → checkout@v6 단일 (cb_4 완전 마이그레이션 확인)"
    },
    {
      "phase": "phase-5",
      "scope": "ai-ready-scorer 자기참조 개선 — 깨진 smoke 참조 감지(categories_ops) + CI smoke 누락 감지(categories_test_quality) + development/ARCHITECTURE.md 경로 인식 + newline 정리(html_renderer/score_codebase) + report.json/dashboard 재생성",
      "deliverable": "dedf1b2 (retroactive)",
      "verification": "scorer 로직 줄별 리뷰 회귀 없음 (cb_5) — active smoke 무영향"
    },
    {
      "phase": "phase-6",
      "scope": "잔존·inactive drift 정합 (본 milestone 자체 작업) — (a) tests/CLAUDE.md:291 하단 hook 표 13→15 + 신규 2 hook row (d_4) + (b) tests/_inactive/ scorer smoke 4건 stale 경로 치환 (d_3)",
      "deliverable": "tests/CLAUDE.md + tests/_inactive/{smoke-scorer-output-newline,smoke-roi-regression,smoke-detect-language,smoke-agentic-safety-na}.sh (새 후속 커밋 [release:v8.15])",
      "verification": "smoke-claude-md-drift.sh PASS + 4 inactive smoke 각각 bootstrap/ 참조 0건 + rc=0 (controlled, risk_2/risk_3)"
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "risk_1",
      "decision_ref": "d_2",
      "method": "EXECUTE 안 dedf1b2 SHA 명시 + 후속 커밋 [release:v8.15] 마커 + REPORT trace 흡수"
    },
    {
      "risk_ref": "risk_2",
      "decision_ref": "d_3",
      "method": "4 inactive smoke 경로 치환 후 각각 실 실행 — bootstrap/skills/audit/ 참조 0건 grep + rc=0 controlled 검증"
    },
    {
      "risk_ref": "risk_3",
      "decision_ref": "d_4",
      "method": "하단 표 신규 2 hook row 추가 + 총 count 13→15 + 상단 매트릭스(16=15+1 manual) 정합 + smoke-claude-md-drift 재실행 PASS"
    }
  ],
  "five_perspective_review": {
    "method": "inline self-review (lightweight) — 변경 대부분이 dedf1b2 retroactive 기록 + 작은 drift 정합(문서 count + 경로 치환), 새 메커니즘/방법론 설계 부재 → v6.17 inline 패턴 정합 (decisive 0 기대). RESEARCH 안 Claude 정밀 리뷰가 cross-check 감사 책임 대체.",
    "perspectives": [
      {
        "perspective": "architecture",
        "verdict": "PASS",
        "comments": "phase 분할이 codex 5갈래 + drift 1과 1:1. dedf1b2 retroactive(phase-1~5) ↔ 새 후속 커밋(phase-6) 분리가 외부 이력 불변 + 9-stage 정직성 둘 다 유지. v6.2+ flattened era 정합 (MILESTONE.md 단일 본책)."
      },
      {
        "perspective": "spec-drift",
        "verdict": "pass-with-comments",
        "comments": "INTENT sc_4/sc_5 를 RESEARCH 발견(dedf1b2 푸시 + inactive smoke 포함 결정) 후 정직 갱신함 — 전제 변경 정합 반영. comment: oos_4(node24 다른 actions 점검)가 cb_4(유일 action=checkout)로 무의미해졌으나 scope boundary 로 무해 보존."
      },
      {
        "perspective": "security",
        "verdict": "PASS",
        "comments": "dedf1b2 가 .claude/settings.local.json 정상 제외(평문 secret 커밋 회피, sc_4). working tree settings.local.json 잔존 권한은 미커밋(gitignore 대상, oos_3). 새 secret 노출 0."
      },
      {
        "perspective": "performance",
        "verdict": "PASS",
        "comments": "CI active smoke 6→15 = CI 실행 시간 증가하나 검증 표면 누락 차단(정확성) 우선 — 수용 trade-off. inactive smoke 는 CI 미실행 = 성능 무영향."
      },
      {
        "perspective": "dx",
        "verdict": "PASS",
        "comments": "하단 hook 표 13→15 정합으로 기여자 혼란 해소(sc_2). inactive scorer smoke 4건 복구로 수동 재사용성 회복. retroactive 기록으로 dedf1b2 의 milestone 맥락 추적 가능."
      }
    ]
  }
}
```

### Narrative

DESIGN 핵심은 **dedf1b2(이미 푸시) retroactive 흡수 ↔ 본 milestone 자체 작업(phase-6) 분리**다 (d_1). 푸시된 커밋 재작성(강제 푸시)을 피하고, codex 5갈래를 phase-1~5 로 구현 완료 표기(추가 변경 없음)한 뒤, 잔존 drift 정합(hook 표 + inactive scorer smoke)만 phase-6 의 새 후속 커밋으로 처리한다. 후속 커밋에 `[release:v8.15]` 마커를 부착(d_2)해 dedf1b2 의 암묵적 연결(risk_1)을 REPORT trace 로 보강한다.

decisions ↔ risks ↔ sc 매핑: d_1/d_2 ↔ risk_1 ↔ sc_4 (dedf1b2 처리), d_3 ↔ risk_2 ↔ sc_5 (inactive smoke 경로 치환), d_4 ↔ risk_3 ↔ sc_2 (hook 표 정합), d_5 ↔ sc_5 (SUB_MILESTONES 6 sub 동기). cascade host 정합 = 본 변경은 검증 인프라 운영 표면 + 문서 count 정합이라 ARCHITECTURE § 매트릭스 narrative 1차 source 변경이 아님 → cascade marker 신설 불요.

5 관점 inline self-review 결과 = decisive issue 0 (architecture/security/performance/dx PASS, spec-drift pass-with-comments). spec-drift comment = oos_4 가 cb_4 로 무의미해졌으나 scope boundary 로 무해 보존 (P3 lessons 후보, 즉시 흡수 불요). RESEARCH 의 Claude 정밀 리뷰가 cross-check 트랙의 독립 감사 책임을 대체했으므로 별도 subagent 5 관점 병렬 호출은 비례성상 생략.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "approved_at": "2026-05-28",
    "approval_method": "자연어 응답 '응' — DESIGN phase-6 계획 (hook 표 13→15 + inactive scorer smoke 4건 경로 치환 + [release:v8.15] 마커 커밋) 제시 후 승인",
    "scope_confirmed": [
      "ai-ready-scorer 개선 v8.15 포함 (AskUserQuestion 2026-05-28)",
      "codex 변경 = Claude 정밀 리뷰 트랙 (AskUserQuestion 2026-05-28)",
      "dedf1b2 = EXECUTE retroactive 기록 (no amend, AskUserQuestion 2026-05-28)",
      "inactive scorer smoke 4건 v8.15 포함 수정 (AskUserQuestion 2026-05-28)",
      "phase-6 편집 + [release:v8.15] 마커 커밋 계획 승인 ('응', 2026-05-28)"
    ]
  }
}
```

### Narrative

사용자가 DESIGN 의 phase-6 계획(tests/CLAUDE.md 하단 hook 표 13→15 정합 + tests/_inactive/ scorer smoke 4건 stale 경로 치환 + 새 후속 커밋에 [release:v8.15] 마커 부착)을 제시받은 뒤 '응'으로 명시 승인했다. dedf1b2(이미 푸시)는 amend 하지 않고 retroactive 기록한다는 결정 포함. pre-PLAN round 누적 4 결정(scorer 포함 / Claude 정밀 리뷰 / dedf1b2 retroactive / inactive smoke 포함)이 모두 사용자 명시 게이트를 통과했다. 이로써 EXECUTE phase-6 진입 게이트를 연다 — 단 실 커밋은 CLAUDE.md '커밋 전 사용자 확인' 정합으로 EXECUTE 후 별도 재확인한다.

## EXECUTE

### Spec

```json
{
  "phases_executed": [
    {
      "phase": "phase-1",
      "status": "completed",
      "deliverable_path": "(dedf1b2 retroactive — 별책 없음)",
      "commits": [{"sha": "dedf1b2", "message": "fix(meta): align smoke automation and plugin checks"}],
      "summary": "검증 표면 동기화 (CI/Makefile/pre-commit active smoke 6→15 + smoke-workflow-registration 신설). dedf1b2 흡수."
    },
    {
      "phase": "phase-2",
      "status": "completed",
      "deliverable_path": "(dedf1b2 retroactive — 별책 없음)",
      "commits": [{"sha": "dedf1b2", "message": "fix(meta): align smoke automation and plugin checks"}],
      "summary": "plugin manifest inventory smoke 신설 (smoke-plugin-manifest). dedf1b2 흡수."
    },
    {
      "phase": "phase-3",
      "status": "completed",
      "deliverable_path": "(dedf1b2 retroactive — 별책 없음)",
      "commits": [{"sha": "dedf1b2", "message": "fix(meta): align smoke automation and plugin checks"}],
      "summary": "v8.0 meta 재분류 narrative 정합 (AGENTS/README/ARCHITECTURE). dedf1b2 흡수."
    },
    {
      "phase": "phase-4",
      "status": "completed",
      "deliverable_path": "(dedf1b2 retroactive — 별책 없음)",
      "commits": [{"sha": "dedf1b2", "message": "fix(meta): align smoke automation and plugin checks"}],
      "summary": "GitHub Actions node24 마이그레이션 (checkout v4→v6, 두 workflow 유일 action = 완전). dedf1b2 흡수."
    },
    {
      "phase": "phase-5",
      "status": "completed",
      "deliverable_path": "(dedf1b2 retroactive — 별책 없음)",
      "commits": [{"sha": "dedf1b2", "message": "fix(meta): align smoke automation and plugin checks"}],
      "summary": "ai-ready-scorer 자기참조 개선 (깨진 smoke 참조·CI smoke 누락 감지 + newline). dedf1b2 흡수."
    },
    {
      "phase": "phase-6",
      "status": "completed",
      "deliverable_path": "execute/phase-6.md",
      "commits": [{"sha": "pending", "message": "fix(meta): [v8.15] phase-6 hook 현황 표 13→15 정합 + inactive scorer smoke 경로 치환 [release:v8.15]"}],
      "summary": "본 milestone 유일 실작업 — tests/CLAUDE.md 하단 hook 표 13→15 (실행 중 agent-frontmatter-schema row pre-existing 누락 발견 → 3 row 추가) + line 260/Archive stale count 정합 + inactive scorer smoke 4건 경로 치환 (전부 rc=0). 커밋 사용자 확인 대기 (pending)."
    }
  ]
}
```

### Narrative

phase-1~5 는 dedf1b2 (이미 origin/main 푸시) 의 retroactive 흡수로 추가 변경 없음 (RESEARCH 줄별 리뷰 = 회귀 0 확인). phase-6 만 본 milestone 자체 실작업이며 별책 `execute/phase-6.md` 에 상세 기록. 실행 중 d_4 가정(2 row 추가)보다 1 row 더 어긋난 pre-existing gap (smoke-agent-frontmatter-schema 표 row 부재) 을 발견해 3 row 로 확장 정합 + 부수 stale count 2건(line 260 '14 hook', Archive 'active 7')도 같은 범위 갱신. inactive scorer smoke 4건은 경로 치환만으로 복구(risk_2). 커밋은 사용자 확인 후 진행 (phase-6 sha pending, [release:v8.15] 마커 — d_2/risk_1).

## VERIFY

### Spec

```json
{
  "smoke": {
    "method": "active 15 smoke (pre-commit 강제) + 4 inactive scorer smoke (phase-6 복구) + smoke-spec-verification (milestone 산출물)",
    "result": "active 15 = 0 FAIL / 4 inactive scorer = 4 PASS (rc=0) / spec-verification PASS=530 FAIL=0 SKIP=367",
    "detail": "EXECUTE 중 phase-6.md JSON 블록 status 필드 누락 FAIL 1건 발생 → JSON 안 'status':'completed' 추가 정정 후 PASS (Stage 9 는 frontmatter 아닌 JSON 블록에서 phase/status 검사, smoke-spec-verification:232). 그 외 회귀 0."
  },
  "criteria_check": [
    {
      "sc_ref": "sc_1",
      "verdict": "PASS",
      "evidence": "codex 5갈래 줄별 리뷰 회귀 없음 (RESEARCH cb_1~5) + smoke 실측: smoke-workflow-registration 'pre-commit=15, CI=15, Makefile=15' + smoke-plugin-manifest 'agents=10, skills=15' + node24 checkout@v6 두 workflow 유일 action (cb_4) + scorer 로직 리뷰 (cb_5)."
    },
    {
      "sc_ref": "sc_2",
      "verdict": "PASS",
      "evidence": "tests/CLAUDE.md 하단 hook 표 13→15 (3 row 추가 = agent-frontmatter-schema pre-existing 누락 + 신규 2건) + line 260 '14→15' + Archive 'active 7→16' 정합. smoke-claude-md-drift.sh 13/13 PASS (count 16=16)."
    },
    {
      "sc_ref": "sc_3",
      "verdict": "PASS",
      "evidence": "active 15 smoke failed=0 실측 (재검증). 4 inactive scorer smoke 도 rc=0 복구."
    },
    {
      "sc_ref": "sc_4",
      "verdict": "PASS",
      "evidence": ".claude/settings.local.json dedf1b2 제외 확인 (git show dedf1b2 settings count=0). 본 milestone 후속 종결 커밋 명시 staging 대상 = development/ROADMAP.md + tests/CLAUDE.md + tests/_inactive/scorer smoke 4건 + development/milestones/v8.15/ (settings.local.json + scheduled_tasks.lock 제외). 실 커밋 SHA = REPORT 안 확정 (PROPOSE 후 단일 [release:v8.15] 종결 커밋)."
    },
    {
      "sc_ref": "sc_5",
      "verdict": "PASS",
      "evidence": "## SUB_MILESTONES = 6 sub_milestones (sub_1~5 = codex 5갈래 dedf1b2 / sub_6 = drift 정합), phases[] 와 1:1. sub_5 = ai-ready-scorer 포함 (사용자 결정 2026-05-28)."
    }
  ],
  "risk_check": [
    {
      "risk_ref": "risk_1",
      "mitigation_verdict": "MITIGATED",
      "evidence": "EXECUTE 안 dedf1b2 SHA 명시(phases_executed commits) + 종결 커밋 [release:v8.15] 마커(phase-6 commit message) + REPORT trace 흡수 예정. v8.15↔dedf1b2 연결 이력화."
    },
    {
      "risk_ref": "risk_2",
      "mitigation_verdict": "MITIGATED",
      "evidence": "4 inactive scorer smoke 경로 치환 후 각각 rc=0 + bootstrap/skills/audit/ 참조 grep 0건 (controlled, 경로 외 잔존 stale 없음)."
    },
    {
      "risk_ref": "risk_3",
      "mitigation_verdict": "MITIGATED",
      "evidence": "하단 표 15 = 상단 매트릭스(16 = pre-commit 15 + manual 1) 정합 + smoke-claude-md-drift PASS. 정합 후 drift 재발 0."
    }
  ],
  "verdict": "RESOLVED"
}
```

### Narrative

verdict = **RESOLVED**. sc_1~5 전체 PASS + risk_1~3 전체 MITIGATED. codex 5갈래는 RESEARCH 줄별 리뷰 + smoke 실측으로 회귀 0 확인(sc_1), 잔존 hook 표 drift 는 13→15 정합(sc_2, 실행 중 agent-frontmatter-schema row pre-existing 누락 발견해 3 row 로 확장 + 부수 stale count 2건 동반 정합), active 15 smoke 0 FAIL(sc_3), settings.local.json 은 dedf1b2 에서 정상 제외 확인(sc_4), SUB_MILESTONES 6 sub 1:1 동기(sc_5).

EXECUTE 중 1 FAIL(phase-6.md JSON status 누락 — Stage 9 는 frontmatter 아닌 JSON 블록 검사, smoke-spec-verification:232)을 'status':'completed' 추가로 즉시 정정해 final 530 PASS/0 FAIL 도달. inactive scorer smoke 4건은 경로 치환만으로 복구(risk_2). 유일 pending = 종결 커밋(SHA REPORT 확정) — codex 변경(dedf1b2)은 이미 푸시됐고 본 milestone 의 phase-6 + 기록만 명시 staging 으로 단일 [release:v8.15] 종결 커밋 예정. 커밋 미실행은 9-stage 표준 ordering(VERIFY/REPORT 작성 후 종결 커밋, v8.13 패턴 정합)으로 BLOCKED 아님 → RESOLVED.

## REPORT

### Spec

```json
{
  "summary": "codex 가 작성자/운영자 없이 광범위 편집한 변경(검증 표면 동기화 / plugin manifest smoke / v8.0 narrative 정합 / node24 / ai-ready-scorer)을 Claude Code 가 작성자/운영자 역할 회복하여 줄별 정밀 리뷰 후 9-stage 큰 건으로 정식 흡수. RESEARCH 중 codex 변경이 이미 dedf1b2 로 커밋·origin/main 푸시됐음을 발견 → milestone 을 retroactive 기록(phase-1~5)으로 재정의 + 잔존 drift 정합(phase-6, 자체 작업)으로 마무리. verdict RESOLVED (sc 5/5 PASS + risk 3/3 MITIGATED).",
  "delta": {
    "files_created": 2,
    "files_edited": 6,
    "files_created_list": [
      "development/milestones/v8.15/MILESTONE.md",
      "development/milestones/v8.15/execute/phase-6.md"
    ],
    "files_edited_list": [
      "development/ROADMAP.md",
      "tests/CLAUDE.md",
      "tests/_inactive/smoke-roi-regression.sh",
      "tests/_inactive/smoke-detect-language.sh",
      "tests/_inactive/smoke-scorer-output-newline.sh",
      "tests/_inactive/smoke-agentic-safety-na.sh"
    ],
    "loc_approx": "본 milestone phase-6 + 기록 = 약 +22 -10 LOC (ROADMAP v8.15 entry + v8.12 trim + tests/CLAUDE.md hook 표 + inactive smoke 4건 경로). 별도 dedf1b2(codex, 이미 푸시) = 20 파일 +392 -80.",
    "commits": "phase-1~5 = dedf1b2 (기 푸시). 본 milestone = 단일 [release:v8.15] 종결 커밋 (사용자 확인 후, SHA pending).",
    "smoke": "spec-verification 530 PASS / 0 FAIL (EXECUTE 중 phase-6.md JSON status 누락 1 FAIL 즉시 정정) + active 15 smoke 0 FAIL + inactive scorer 4건 rc=0 복구."
  },
  "lessons_learned": [
    {
      "id": "L1",
      "priority": "P2",
      "description": "cross-check 트랙(harness-meta.md:225)은 'Claude=작성자/Codex=감사자' 단방향 전제이나, 실제론 codex 가 작성자가 되는 역할 역전이 발생할 수 있다. 도구 비대칭(codex=Claude Code plugin 미사용→AGENTS.md 자율 준수 의존)이 milestone 기록·커밋 확인 누락을 구조적으로 낳는다.",
      "context": "사용자가 codex 로 평가·개선 후 milestone 없이 working tree 인계. Claude Code 가 작성자 역할 회복으로 retroactive 흡수.",
      "next_action_candidate": "cross-check 트랙 narrative 에 '역할 역전(codex 작성) 시 Claude Code 작성자 회복 + retroactive 흡수' 케이스 명문화 후보 (PROPOSE 사용자 게이트)."
    },
    {
      "id": "L2",
      "priority": "P3",
      "description": "병렬 세션/외부 커밋이 milestone 진행 중 working tree 를 바꿀 수 있다 — RESEARCH 중 codex 변경이 dedf1b2 로 사라진(커밋된) 것을 발견. 9-stage 는 INTENT sc 정직 갱신 + EXECUTE retroactive 로 견고히 흡수했다.",
      "context": "RESEARCH 줄별 리뷰 중 git status 가 비어 dedf1b2 추적으로 발견.",
      "next_action_candidate": "거명만 보존 — stage 진입마다 git status 재확인 권고는 운영 습관, 별 milestone 발의 부재."
    },
    {
      "id": "L3",
      "priority": "P3",
      "description": "smoke 사각지대 — smoke-claude-md-drift 는 tests/CLAUDE.md 상단 매트릭스 count(16)만 검사하고 하단 'hook 현황' narrative count(13)는 미검사 → stale 잠복. inactive smoke 의 경로 drift 도 어떤 active smoke 도 안 잡음(수동 실행만).",
      "context": "phase-6 정밀 리뷰에서 하단 표 13 stale + inactive scorer smoke 4건 경로 drift 발견.",
      "next_action_candidate": "하단 hook 표 ↔ pre-commit 실제 hook 수 정합 smoke 후보 — 단 over-engineering 주의(P3 거명만, 발의 보류)."
    },
    {
      "id": "L4",
      "priority": "P2",
      "description": "stage-execute skill 별책 템플릿이 frontmatter 에 status 를 두고 JSON 블록엔 status 부재인데, smoke-spec-verification Stage 9(:232)는 JSON 블록에서 phase+status 를 검사한다. 템플릿 ↔ smoke 불일치로 템플릿 그대로 따르면 FAIL.",
      "context": "EXECUTE 중 phase-6.md 가 템플릿대로 frontmatter status 만 둬서 '필드 누락: status' FAIL → JSON 에 status 추가로 정정.",
      "next_action_candidate": "stage-execute skill 별책 schema JSON 에 'status' 필드 추가 정합 후보 (PROPOSE 사용자 게이트)."
    }
  ]
}
```

### Narrative

goal 달성 — codex 5갈래를 Claude Code 작성자 역할 회복으로 줄별 정밀 리뷰(회귀 0) 후 정식 흡수(phase-1~5 retroactive = dedf1b2) + 잔존 drift 정합(phase-6 = hook 표 13→15 + inactive scorer smoke 4건 복구). verdict RESOLVED. delta = 본 milestone 자체는 신규 2 + 편집 6 파일(약 +22 -10), codex 변경 dedf1b2 는 별도 20 파일(+392 -80, 기 푸시).

lessons 핵심 2건이 P2 후속 candidate: L1(cross-check 트랙 역할 역전 케이스 명문화) + L4(stage-execute skill 별책 JSON status 필드 정합 — 본 milestone EXECUTE 에서 실제 FAIL 유발한 템플릿 drift). L2(외부 커밋 mid-milestone)/L3(smoke 사각지대)는 P3 거명만 — over-engineering 회피. P2 2건은 PROPOSE 에서 사용자 명시 게이트 후 next_candidates[] 등재 결정(v7.0 T1.2 자동 append 폐지 정합).

ROADMAP archival = v8.15 완료 시 milestones[] completed 4건(v8.15/v8.14/v8.13/v8.12) → recent 3 초과. 가장 오래된 v8.12 trim (GitHub Release v8.12 기 발행 확인 = trace 보존, v8.13 catch-up 산물). publish-then-trim 정합 — 본 REPORT 에서 milestones[] 에서 v8.12 entry 제거.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
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
    }
  ],
  "next_candidates_named_only": [
    "L3 — 하단 hook 표 ↔ pre-commit 실제 hook 수 정합 smoke (over-engineering 주의, evidence 더 누적 시 발의)",
    "tests/_inactive/smoke-skills-install.sh 의 bootstrap/skills/audit/ 옛 경로 참조 (v4.x symlink install 메커니즘 검증, deprecated since v5.0 — 복구 vs 폐기 별 판단 필요)"
  ]
}
```

### Narrative

v8.15 lessons 중 P2 2건이 사용자 명시 결정(2026-05-28 AskUserQuestion)으로 next_candidates[] 등재 확정: (1) `cross-check-role-reversal-doc` (L1 origin) — 본 milestone 이 codex 작성자 역전의 실 사례라 cross-check 트랙 narrative 보강 자연. (2) `stage-execute-skill-json-status-field` (L4 origin) — 본 milestone EXECUTE 에서 실제 FAIL 을 유발한 skill 템플릿↔smoke 불일치, 재발 방지 가치 명확. 둘 다 작은 건(가벼운 흐름 후보) 성격이라 target v8.16.

named_only 2건은 거명만 보존: L3(하단 hook 표 정합 smoke — over-engineering 회피로 발의 보류) + smoke-skills-install.sh 옛 경로(v4.x deprecated install 메커니즘 검증이라 복구 가치 자체가 별 판단 — phase-6 scope 외 SCOPE_OUT_NOTES 연장). v7.0 T1.2 정합 — 부산물 자동 append 폐지, 사용자 게이트 통과분만 등재.

## SUB_MILESTONES

```json
{
  "sub_milestones": [
    {
      "id": "sub_1",
      "phase_ref": "phase-1",
      "title": "검증 표면 동기화 (CI/Makefile/pre-commit active smoke 6→15 + smoke-workflow-registration 신설)",
      "status": "completed",
      "commit": "dedf1b2"
    },
    {
      "id": "sub_2",
      "phase_ref": "phase-2",
      "title": "plugin manifest inventory smoke 신설 (smoke-plugin-manifest)",
      "status": "completed",
      "commit": "dedf1b2"
    },
    {
      "id": "sub_3",
      "phase_ref": "phase-3",
      "title": "v8.0 meta 재분류 narrative 정합 (AGENTS/README/ARCHITECTURE)",
      "status": "completed",
      "commit": "dedf1b2"
    },
    {
      "id": "sub_4",
      "phase_ref": "phase-4",
      "title": "GitHub Actions node24 마이그레이션 (checkout v4→v6)",
      "status": "completed",
      "commit": "dedf1b2"
    },
    {
      "id": "sub_5",
      "phase_ref": "phase-5",
      "title": "ai-ready-scorer 자기참조 개선 (깨진 smoke 참조·CI smoke 누락 감지 + newline)",
      "status": "completed",
      "commit": "dedf1b2"
    },
    {
      "id": "sub_6",
      "phase_ref": "phase-6",
      "title": "잔존·inactive drift 정합 (hook 표 13→15 + inactive scorer smoke 4건 경로 치환)",
      "status": "pending",
      "commit": "(EXECUTE 후속 커밋 [release:v8.15])"
    }
  ]
}
```
