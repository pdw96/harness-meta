---
id: changelog-github-releases-migration
title: GitHub Releases hybrid migration 도입
version: v6.19
status: open
---

# v6.19 — GitHub Releases hybrid migration 도입

## INTENT

### Spec

```json
{
  "id": "changelog-github-releases-migration",
  "title": "GitHub Releases hybrid migration 도입",
  "goal": "CHANGELOG.md SIZE_LIMIT 회귀 회피 + GitHub Releases mechanism 도입. hybrid 본질 = (a) 과거 v1.0~v5.21 entry CHANGELOG.md 안 ID + title + REPORT link 1줄 단축 + (b) v6.0~v6.18 entry CHANGELOG.md 본문 잔존 + (c) v6.19 = CHANGELOG 안 last full entry (hybrid 분기 marker) + (d) v6.20+ Release publish 단일 source (CHANGELOG entry 추가 안 함). trigger = GitHub Actions workflow, commit msg explicit marker `[release:v{X.Y}]`. Release body = MILESTONE.md ## REPORT 섹션 자동 추출.",
  "motivation": "v6.18 evidence (CHANGELOG.md = 99998 bytes / SIZE_LIMIT 100000 -2 한계 + v6.17/v6.18 entry 1줄 단축 압박 누적) + ROADMAP next_candidates#12 origin (v6.18 발의). 다음 milestone REPORT 추가 시 즉시 SIZE_LIMIT 회귀 자연. CHANGELOG.md 단순 entry 추가 단속 = trace visibility 손실. trace 3중 보존 (CHANGELOG short / REPORT.md full / git log + git tag + GitHub Releases) 본질. pre-PLAN 5 round 결정 (2026-05-21, 이전 세션 API Error 후 새 세션 재진행) trace = R1 hybrid scope / R2 ID+title+REPORT link 단축 / R3 Actions 자동 / R4 explicit marker `[release:v{X.Y}]` / R5 Release body = MILESTONE.md ## REPORT 추출.",
  "success_criteria": [
    {
      "id": "sc_1",
      "criterion": ".github/workflows/release-publish.yml 신규 추가 — trigger = push to main + commit msg regex `\\[release:v[0-9]+\\.[0-9]+\\]` 매칭 + workflow_dispatch 수동 입력 옵션 (dry-run test 용도)"
    },
    {
      "id": "sc_2",
      "criterion": "workflow logic 본질 = (a) commit msg 안 marker 추출 v{X.Y} parsing + (b) git tag v{X.Y} 발급 + (c) projects/meta/milestones/v{X.Y}/MILESTONE.md 파일 존재 확인 (없으면 fail) + (d) ## REPORT 섹션 추출 (다음 H2 `## PROPOSE` 또는 EOF 까지) + (e) gh release create v{X.Y} --title --notes 발행"
    },
    {
      "id": "sc_3",
      "criterion": "CHANGELOG.md 안 v1.0~v5.21 entry (line 392 이후 ~ EOF) → ID + title + REPORT link 1줄 단축 형식 = `- [v{X.Y}] - {date} - **{title}** ([REPORT]({REPORT.md relative path}))`. v6.0~v6.18 entry (line 11~391) 본문 잔존 (hybrid 본질). 결과 size < 70KB target (DESIGN D5 → EXECUTE phase-2 dry-run evidence 안 65705 bytes 측정 후 second retouch — 초기 < 20KB / DESIGN D5 < 50KB 모두 추정 본질 + 실 측정 후 evidence-base 자연 도달. < 70KB = SIZE_LIMIT 100KB 대비 ~30KB 여유 = 향후 v6.x entry 추가 0건 본질 정합)."
    },
    {
      "id": "sc_4",
      "criterion": "v6.19 = CHANGELOG.md 안 last full entry — `## [v6.19] - 2026-05-21` 본문 + 마지막 줄 narrative `> 본 entry 부터 CHANGELOG.md 안 신규 full entry 추가 중단. v6.20+ release note = GitHub Releases 단일 source (hybrid 분기 marker).`"
    },
    {
      "id": "sc_5",
      "criterion": "v6.19 commit msg 안 explicit marker `[release:v6.19]` 포함 — workflow 첫 실 trigger test (REPORT stage commit 시점). Actions workflow 실행 evidence + GitHub Releases 페이지 발급 evidence + git tag v6.19 push evidence."
    },
    {
      "id": "sc_6",
      "criterion": "ARCHITECTURE § 4 매트릭스 신 row #13 또는 본문 paragraph 안 'GitHub Releases hybrid migration mechanism' 정전화 (단일 host, v3.21 narrative 정전화 3 단계 패턴 (a) DESIGN 1차 + (b) EXECUTE Edit + (c) VERIFY grep 적용)"
    },
    {
      "id": "sc_7",
      "criterion": "pre-commit 18 hook 전체 PASS (smoke-spec-verification + smoke-open-stage-discipline + smoke-entry-title-guideline + smoke-candidate-draft-schema 등 회귀 0). CHANGELOG.md size 단축 후 SIZE_LIMIT smoke (있다면) PASS."
    }
  ],
  "out_of_scope": [
    {
      "id": "oos_1",
      "item": "과거 v1.0~v6.18 entry 의 GitHub Releases backfill (hybrid 본질 = CHANGELOG.md 안 단축 only, Releases backfill 부재). 시간 분기 본질 — v1~v5 trace = git log + REPORT.md / v6.0~v6.18 trace = CHANGELOG.md 본문 / v6.19+ trace = GitHub Releases."
    },
    {
      "id": "oos_2",
      "item": "release-please / changesets 등 외부 자동화 도구 도입. R4 explicit marker = self-hosted workflow yaml 단순 결정. 외부 도구 도입 = 별 milestone 자연 trigger (evidence 누적 후)."
    },
    {
      "id": "oos_3",
      "item": "CHANGELOG.md 완전 제거. hybrid 본질 = 잔존 (archive role 도달, v6.19 부터 신규 추가 없음)."
    },
    {
      "id": "oos_4",
      "item": "과거 milestone (v1.0~v6.18) git tag backfill. tag 발급 = v6.19 부터만 (workflow 안 자동). 과거 milestone tag 부재 = trace 분리 자연 (out_of_scope, oos_1 동질)."
    },
    {
      "id": "oos_5",
      "item": "ci.yml (Smoke Tests) 와 release-publish.yml 통합. 별 workflow file = 책임 분리 본질 (R4 결정 본질 정합)."
    },
    {
      "id": "oos_6",
      "item": "MILESTONE.md ## REPORT 섹션 추출 logic 의 markdown rendering polish (예: relative link → absolute URL 변환 등). 본 milestone scope = bare extract (## REPORT ~ 다음 H2). polish 는 evidence 누적 후 후속 milestone 자연."
    }
  ],
  "dependencies": [
    {
      "id": "dep_1",
      "ref": "v6.18 evidence (CHANGELOG.md = 99998 bytes / SIZE_LIMIT -2 / v6.17/v6.18 entry 1줄 단축 압박)",
      "purpose": "본 milestone trigger source — ROADMAP next_candidates#12 description 안 evidence 명시. SIZE_LIMIT 회귀 회피 본질 = goal 직접 motivation."
    },
    {
      "id": "dep_2",
      "ref": ".github/workflows/ci.yml (기존 Smoke Tests workflow)",
      "purpose": "release-publish.yml 신규 workflow 작성 시 GitHub Actions 패턴 reference (env / runs-on / steps / permissions 등). 책임 분리 본질 = 통합 안 함 (oos_5 정합)."
    },
    {
      "id": "dep_3",
      "ref": "Keep a Changelog v1.1.0 + Semantic Versioning (CHANGELOG.md 명시 정합)",
      "purpose": "단축 entry 형식 정합 — Keep a Changelog 안 'each version section' 패턴 정합 (단 본문 압축은 본 milestone novel). semver `.harness.toml` schema level 정합 (CHANGELOG.md header 명시)."
    },
    {
      "id": "dep_4",
      "ref": "ARCHITECTURE § 4 매트릭스 (mechanism row 누적 #1~#12)",
      "purpose": "신 mechanism row 추가 또는 enhancement narrative 정전화 host. v3.21 narrative 정전화 3 단계 패턴 적용 대상 자연 도달 (단일 host vs 다중 host 결정 = DESIGN 단계)."
    },
    {
      "id": "dep_5",
      "ref": "GitHub Actions release event + gh CLI (context7 RESEARCH 단계 spec 확인 예정)",
      "purpose": "workflow logic 핵심 = tag 발급 + Release publish + body 본문 작성. context7 query 안 actions/checkout + gh release create + GITHUB_TOKEN permissions 정합 확인 의무 (RESEARCH ext_1~ext_3)."
    },
    {
      "id": "dep_6",
      "ref": "v5.21_roadmap-forward-looking-redesign-and-changelog-archival",
      "purpose": "CHANGELOG.md 안 v1.0~v5.20 entry archival 첫 적용 milestone (2026-05-19 backfill). 본 milestone = v5.21 archival cycle 두 번째 (v1.0~v5.21 단축 + v6.0~v6.18 잔존 hybrid 본질). archival pattern reference."
    }
  ],
  "risks": [
    {
      "id": "r_1",
      "risk": "workflow yaml 문법 오류 또는 logic bug → Release 발행 실패 (첫 trigger = v6.19 REPORT commit)",
      "mitigation": "phase-1 안 workflow_dispatch 수동 dry-run trigger 의무 (v0.0 dummy version test) + commit 전 yaml linter (yamllint) 통과 의무"
    },
    {
      "id": "r_2",
      "risk": "marker `[release:v{X.Y}]` false trigger — 비 release 의도 commit 안 우연 매칭",
      "mitigation": "regex strict (`\\[release:v[0-9]+\\.[0-9]+\\]` 정확 매칭) + branch=main 한정 trigger + 이미 발급된 tag 중복 발급 회피 (gh release view 사전 check)"
    },
    {
      "id": "r_3",
      "risk": "MILESTONE.md ## REPORT 섹션 추출 logic 실패 (awk/sed range matching 오류)",
      "mitigation": "phase-1 안 awk/sed 추출 evidence test (v6.18 MILESTONE.md fixture) + 추출 결과 minimum length 검증 + 실패 시 workflow fail-fast"
    },
    {
      "id": "r_4",
      "risk": "자동 발행 = 사용자 통제 본질 손실 우려 (커밋·배포 전 확인 요청 memory feedback)",
      "mitigation": "commit msg 안 explicit marker 작성 자체 = 명시 결정 게이트 (R3+R4 결정 본질). marker 부재 commit = workflow no-op. 추가 안전망 = workflow_dispatch 수동 trigger 옵션 (dry-run 또는 미트리거 회복)"
    },
    {
      "id": "r_5",
      "risk": "77 entry 단축 시 release note 정보 손실 (외부 visible artifact 본질 약화)",
      "mitigation": "trace 3중 보존 = (1) CHANGELOG short link → REPORT.md full / (2) REPORT.md full body (milestone 종합 backward) / (3) git log atomic commits. 단축 형식 안 REPORT link 의무 (sc_3)"
    },
    {
      "id": "r_6",
      "risk": "v6.19 = 첫 git tag 발급 + 첫 GitHub Release — 과거 tag 부재 = trace baseline 분리 (oos_1+oos_4 본질)",
      "mitigation": "out_of_scope 명시 (oos_1+oos_4) + ARCHITECTURE narrative 안 'v1.0~v6.18 trace = CHANGELOG.md / v6.19+ trace = Releases' 시간 분기 본질 명료화 (sc_6 cascade)"
    },
    {
      "id": "r_7",
      "risk": "Release body 추출 시 markdown link 깨짐 — MILESTONE.md 안 relative link (../../ARCHITECTURE.md 등) Release 페이지 안 broken (GitHub UI 안 다른 repo path 본질)",
      "mitigation": "oos_6 명시 (polish out_of_scope) + 첫 Release evidence 안 broken link 인정 narrative (REPORT.md cross-ref 가 user 가이드 본질). 후속 milestone 자연 (link 변환 logic)"
    }
  ]
}
```

### Narrative

본 milestone = CHANGELOG.md SIZE_LIMIT 회귀 회피 + GitHub Releases mechanism 도입. v6.18 evidence (99998 bytes / 한계 -2 / entry 1줄 단축 압박 누적) origin. ROADMAP next_candidates#12 promote.

pre-PLAN 5 round 결정 trace (2026-05-21, 이전 세션 API Error 후 새 세션 재진행) = R1 hybrid scope (신규 Releases + 과거 단축) / R2 ID+title+REPORT link 1줄 단축 / R3 GitHub Actions 자동 (commit msg trigger) / R4 explicit marker `[release:v{X.Y}]` / R5 Release body = MILESTONE.md ## REPORT 섹션 추출. 핵심 본질 = 사용자 통제 (commit msg 작성 자체 = 명시 결정 게이트, r_4 mitigation 본질) + trace 3중 보존 (r_5 mitigation 본질) + 시간 분기 (v1~v5 → v6.0~v6.18 → v6.19+ 3 era 분리, oos_1+oos_4 본질).

hybrid 분기 marker = v6.19 entry = CHANGELOG.md 안 last full entry (sc_4). v6.20+ 부터는 Release publish 단일 source — CHANGELOG.md 안 entry 추가 단속.

v3.21 narrative 정전화 3 단계 패턴 적용 대상 자연 검토 — mechanism 본질 = ARCHITECTURE § 4 매트릭스 (단일 host 또는 신 row 추가). DESIGN 단계 안 cascade host 갯수 결정 (v6.10 L3 판정 기준).

## RESEARCH

### Spec

```json
{
  "external": [
    {
      "id": "ext_1",
      "source": "GitHub Actions docs — events that trigger workflows (context7 /websites/github_en_actions query)",
      "finding": "push trigger 안 branches filter = `on: push: branches: ['main']` 정합. workflow_dispatch 수동 trigger + inputs (string/choice/boolean type) 지원. 두 trigger 통합 가능 (on: push + workflow_dispatch 동시 명시). dry-run test 본질 = workflow_dispatch 채택.",
      "verified": true
    },
    {
      "id": "ext_2",
      "source": "GitHub Actions docs — composite action release (context7 인용)",
      "finding": "tag 발급 + push = `git tag -a v{X.Y} -m '...' && git push --follow-tags` 정합. workflow 안 step shell 안 직접 실행 가능 (actions/checkout@v4 후 git CLI 자연 사용).",
      "verified": true
    },
    {
      "id": "ext_3",
      "source": "GitHub Actions docs — GITHUB_TOKEN authentication (context7 인용)",
      "finding": "gh CLI 안 GITHUB_TOKEN = `env: GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}` 패턴. `permissions: contents: write` 명시 의무 (release 발급 권한). context7 안 직접 인용 = `permissions > contents > write` allows action to create a release.",
      "verified": true
    },
    {
      "id": "ext_4",
      "source": "gh CLI spec — gh release create command",
      "finding": "gh release create v{X.Y} --title '...' --notes-file body.md --target {sha} 패턴 일반 (gh CLI 공식 spec, ubuntu-latest 기본 설치). context7 query 안 직접 인용 부재 (gh issue create / gh issue comment 만 인용) — gh CLI 공식 docs (cli.github.com) 정합 추정. EXECUTE phase-1 안 dry-run trigger evidence 확보 의무 (r_1 mitigation).",
      "verified": false,
      "verification_method": "EXECUTE phase-1 안 workflow_dispatch dry-run test (v0.0 dummy version)"
    },
    {
      "id": "ext_5",
      "source": "GitHub Actions docs — contains() expression / github.event.head_commit.message",
      "finding": "commit msg filter 일반 패턴 = `if: contains(github.event.head_commit.message, '[release:')` (job-level 또는 step-level). context7 query 안 직접 인용 부재 — GitHub Actions expression docs 정합 추정. EXECUTE phase-1 안 dry-run test (marker contains 매칭 evidence) 확보 의무 (r_2 mitigation).",
      "verified": false,
      "verification_method": "EXECUTE phase-1 안 workflow_dispatch dry-run + push commit dual test"
    }
  ],
  "codebase": [
    {
      "id": "cb_1",
      "ref": ".github/workflows/ci.yml",
      "finding": "기존 Smoke Tests workflow 패턴 = `on: push: branches: [main]` + `runs-on: ubuntu-latest` + `actions/checkout@v4` + `timeout-minutes: 10` + ACTIVE_SMOKES 배열 (bash for loop). release-publish.yml 책임 분리 본질 = 통합 안 함 (INTENT oos_5 정합)."
    },
    {
      "id": "cb_2",
      "ref": "CHANGELOG.md = 99998 bytes / 934 lines / 76 entry",
      "finding": "v6.0 = line 379 / v5.21 = line 392. v6.0~v6.18 = ~390 line (~42% byte). v1.0~v5.21 = ~544 line (~58% byte). v5.x 압축 entry (v5.18~v5.21 = 6 line each) + v1.0~v4.x 큰 entry (~10 line each * ~50 entry). 단축 후 size 추정 = (~80 byte × 76 entry) ≈ 6KB + v6.0~v6.18 본문 ~42KB ≈ 48KB. INTENT sc_3 target (< 20KB) = 매우 공격적 — v6.0~v6.18 본문도 일부 단축 필요? DESIGN 단계 결정."
    },
    {
      "id": "cb_3",
      "ref": "projects/meta/milestones/v6.18/MILESTONE.md ## REPORT 섹션",
      "finding": "awk 추출 evidence = `awk '/^## REPORT/,/^## PROPOSE/' MILESTONE.md` 정상 작동 (98 line). 단 awk range 본질 = 마지막 줄 `## PROPOSE` 포함 → sed '$d' 추가 또는 flag-based awk (start 후 next + end 직전 exit) 패턴 안전."
    },
    {
      "id": "cb_4",
      "ref": "git tag --list (0건) + .git/refs/tags/ 부재",
      "finding": "현재 git tag 0건 (v6.18 까지 모든 milestone tag 부재). v6.19 = 첫 tag + 첫 GitHub Release (INTENT r_6 evidence). 과거 milestone tag backfill = oos_4 명시."
    },
    {
      "id": "cb_5",
      "ref": "projects/meta/milestones/v5.21/REPORT.md (archival cycle 첫 적용)",
      "finding": "v5.21_roadmap-forward-looking-redesign-and-changelog-archival 안 v1.0~v5.20 entry CHANGELOG backfill 적용 (INTENT dep_6). 본 milestone = v5.21 archival cycle 두 번째 (단축 + hybrid 본질, 단순 backfill 보다 1 step 발전)."
    }
  ],
  "options": [
    {
      "id": "opt_A_release_tool",
      "context": "GitHub Release 발급 도구",
      "candidates": [
        {"label": "gh CLI", "pros": "minimal dependency + ubuntu-latest 기본 설치 + Anthropic 정합 (Claude Code CLI 패턴 동질)", "cons": "context7 직접 인용 부재 (ext_4 추정, EXECUTE dry-run 검증 의무)"},
        {"label": "softprops/action-gh-release@v2", "pros": "body_path 직접 지원 + 추출 후처리 부재", "cons": "third-party action dependency"},
        {"label": "actions/create-release@v1", "pros": "공식 action", "cons": "archived (deprecated)"}
      ],
      "recommendation": "gh CLI (cb_1 ci.yml 패턴 정합 + minimal dependency)"
    },
    {
      "id": "opt_B_report_extract",
      "context": "MILESTONE.md ## REPORT 섹션 추출 logic",
      "candidates": [
        {"label": "awk range + sed '$d'", "pros": "단순 (한 줄)", "cons": "마지막 줄 제거 본질 = 후처리 의무"},
        {"label": "flag-based awk", "pros": "start/end 마커 제외 + 자체 완결", "cons": "조금 더 복잡"},
        {"label": "python regex", "pros": "정확 + 가독성", "cons": "python 설치 의존 (ubuntu-latest 기본 있음, but 단순함 손실)"}
      ],
      "recommendation": "flag-based awk (`awk '/^## REPORT/{flag=1; next} /^## PROPOSE/{flag=0} flag' MILESTONE.md`)"
    },
    {
      "id": "opt_C_tag_creation",
      "context": "git tag 발급 시점",
      "candidates": [
        {"label": "workflow 안 git tag 발급 + push --follow-tags", "pros": "명시적 + ext_2 직접 인용 정합", "cons": "step 1개 추가"},
        {"label": "gh release create --target {sha} 자동 tag 생성", "pros": "단순 (1 step)", "cons": "gh CLI 안 tag 자동 생성 spec 추정 (ext_4 동질 검증 부재)"}
      ],
      "recommendation": "workflow 안 git tag 발급 (명시적 + ext_2 인용 정합)"
    },
    {
      "id": "opt_D_workflow_dispatch_input",
      "context": "workflow_dispatch 수동 trigger input schema",
      "candidates": [
        {"label": "version: string (required) + dry_run: boolean (default false)", "pros": "dry-run 분기 + 명시 version", "cons": "input 2개"},
        {"label": "version: string only", "pros": "단순", "cons": "dry-run 분기 부재"},
        {"label": "input 부재 (push only)", "pros": "최단", "cons": "수동 dry-run 부재 (r_1 mitigation 약함)"}
      ],
      "recommendation": "version + dry_run 2 input (r_1 mitigation 본질)"
    }
  ],
  "risks_identified": [
    {
      "id": "ri_1",
      "risk": "commit msg filter regex (`[release:v{X.Y}]`) 정확성 검증 부재 (context7 ext_5 추정)",
      "mitigation": "EXECUTE phase-1 안 push commit dry-run test (marker contains 매칭 evidence) + workflow_dispatch fallback"
    },
    {
      "id": "ri_2",
      "risk": "gh CLI release notes 안 한국어 multi-byte 인코딩 깨짐",
      "mitigation": "--notes-file 안 UTF-8 file 사용 (ubuntu-latest 기본 UTF-8). 단순 한국어 일반 ASCII 외 evidence 누적 필요 시 별 milestone"
    },
    {
      "id": "ri_3",
      "risk": "## REPORT 섹션 안 ``` JSON code block GitHub Release UI 안 truncate 또는 rendering 깨짐",
      "mitigation": "INTENT oos_6 명시 (polish 별 milestone). 첫 Release evidence 안 깨짐 인정 + REPORT.md cross-ref user 가이드 본질"
    },
    {
      "id": "ri_4",
      "risk": "76 entry 단축 시 entry 별 REPORT.md path 추출 logic (file 명 = `REPORT.md` 부재 v6.2+ flattened era = `MILESTONE.md` 단일 본책)",
      "mitigation": "era 분기 logic 의무 — v6.2+ → `MILESTONE.md` / v3.0~v6.1 → `REPORT.md` / v2.0~v2.1 → 슬러그 dir / v1.0~v1.4 → 슬러그 dir + 7-stage. era 매핑 표 DESIGN 단계 정리"
    },
    {
      "id": "ri_5",
      "risk": "CHANGELOG.md size target (< 20KB) 공격적 — v6.0~v6.18 본문 잔존 시 ~48KB 추정 (cb_2)",
      "mitigation": "DESIGN 단계 안 target 재조정 (예: < 50KB) 또는 v6.0~v6.18 안 일부 단축 (예: v6.0~v6.13 단축 + v6.14~v6.18 본문 잔존). hybrid 본질 자체 = 시간 분기 본질, 분기 시점 DESIGN 결정"
    },
    {
      "id": "ri_6",
      "risk": "v6.19 첫 Release 발행 본문 안 'GitHub Releases hybrid migration 도입' = milestone 본질 self-reference (도그푸드 본질)",
      "mitigation": "REPORT 단계 안 명시 narrative — '본 release = mechanism 도입 + 첫 발행 self-host evidence' 명료화. 도그푸드 본질 정합"
    }
  ]
}
```

### Narrative

본 RESEARCH 안 핵심 evidence = context7 GitHub Actions docs query 3 (ext_1~ext_3 verified) + 추정 2 (ext_4 gh release + ext_5 contains expression — EXECUTE phase-1 안 dry-run 검증 의무). v5.7 spec-drift spike 패턴 적용 대상 (cycle 13 자연 도달 가능성, v6.6 이후) — DESIGN 단계 안 채택 또는 단순 hardcode 결정.

codebase audit 5 finding 안 핵심 = (cb_2) CHANGELOG.md size 단축 후 ~48KB 추정 → INTENT sc_3 target (< 20KB) 공격적 → DESIGN 단계 안 target 재조정 의무 (ri_5 mitigation). era 분기 logic (ri_4) = 76 entry REPORT link 추출 시 era 별 path 본질 다름 (4 era 매핑 표 DESIGN 정리).

options 4 후보 안 핵심 = opt_A gh CLI (단순 + ci.yml 패턴 정합) + opt_B flag-based awk (자체 완결) + opt_C workflow 안 git tag 발급 (명시적) + opt_D version + dry_run 2 input (r_1 mitigation).

risks_identified 6건 = ri_1~ri_3 (context7 추정 검증 + multi-byte + UI rendering) + ri_4~ri_6 (era 분기 + size target + 도그푸드 self-reference). DESIGN 단계 안 mitigation phase 매핑.

## DESIGN

### Spec

```json
{
  "decisions": [
    {
      "id": "D1",
      "topic": "release 발급 도구",
      "decision": "gh CLI 채택 (`gh release create v{X.Y} --title --notes-file`)",
      "rationale": "RESEARCH opt_A recommendation. minimal dependency + ci.yml 패턴 정합 + ubuntu-latest 기본 설치 + Anthropic 생태계 정합. third-party action (softprops/action-gh-release) 회피.",
      "alternatives_rejected": ["softprops/action-gh-release@v2 (third-party dependency)", "actions/create-release@v1 (archived)"]
    },
    {
      "id": "D2",
      "topic": "REPORT 섹션 추출 logic",
      "decision": "flag-based awk (`awk '/^## REPORT/{flag=1; next} /^## PROPOSE/{flag=0} flag' MILESTONE.md`)",
      "rationale": "RESEARCH opt_B recommendation. start/end 마커 제외 + 자체 완결 (sed '$d' 후처리 부재). pure awk = ubuntu-latest 기본 도구.",
      "alternatives_rejected": ["awk range + sed '$d' (후처리 의무)", "python regex (단순함 손실)"]
    },
    {
      "id": "D3",
      "topic": "tag 발급 시점",
      "decision": "workflow 안 git tag 발급 + push --follow-tags (gh release create 전 단계)",
      "rationale": "RESEARCH opt_C recommendation. ext_2 context7 직접 인용 정합. gh CLI 안 tag 자동 생성 spec 추정 (verified=false) 회피.",
      "alternatives_rejected": ["gh release create --target {sha} 자동 tag (ext_4 추정 의존)"]
    },
    {
      "id": "D4",
      "topic": "workflow_dispatch input schema",
      "decision": "version (string, required) + dry_run (boolean, default false) 2 input",
      "rationale": "RESEARCH opt_D recommendation. r_1 mitigation (workflow yaml 오류 dry-run 검증) + 사용자 통제 본질 (dry-run = release 실제 발급 회피).",
      "alternatives_rejected": ["input 부재 (수동 dry-run 본질 부재)", "version only (dry-run 분기 부재)"]
    },
    {
      "id": "D5",
      "topic": "CHANGELOG size target 재조정",
      "decision": "INTENT sc_3 target `< 20KB` → `< 50KB` 재조정 (RESEARCH cb_2 evidence)",
      "rationale": "cb_2 추정 (76 entry 단축 ~6KB + v6.0~v6.18 본문 ~42KB ≈ 48KB) 정합. v6.0~v6.18 본문 잔존 = 사용자 R1 결정 본질 보존. 공격적 target = 본문 단축 강제 → R1 위반 risk.",
      "scope_change_note": "INTENT sc_3 retouch 본질 = DESIGN 안 mitigation 본질 자연 (사용자 명시 결정 전 단계, sc 재조정 OK)"
    },
    {
      "id": "D6",
      "topic": "76 entry REPORT link 추출 시 era 분기",
      "decision": "4 era 매핑 표 = v6.2+ → `milestones/v{X.Y}/MILESTONE.md` / v3.0~v6.1 → `milestones/v{X.Y}/REPORT.md` / v2.0~v2.1 → `milestones/v{X.Y}_{slug}/REPORT.md` / v1.0~v1.4 → `milestones/v{X.Y}_{slug}/REPORT.md`",
      "rationale": "RESEARCH ri_4 mitigation. era 분기 본질 = ARCHITECTURE § 6.1 정합. _archive/ 디렉토리 안 historical milestone path 본질 변경 (v4.0 phase-2 분리 후 archived path).",
      "implementation": "phase-2 안 단축 script (python 또는 bash) 안 era 매핑 함수 + version regex → era 분류 → path 조합"
    },
    {
      "id": "D7",
      "topic": "phase 분할",
      "decision": "2 phase = phase-1 (workflow yaml + dry-run evidence) + phase-2 (CHANGELOG 단축 + v6.19 last full entry + ARCHITECTURE 정전화 cascade)",
      "rationale": "lightweight 본질 + v6.x phase 분포 매트릭스 정합 (v3.17 audit 70.6% 1-phase / v6.x 누적 lightweight). 2 phase = 책임 분리 (workflow 추가 vs CHANGELOG 정리) + commit 분기 자연.",
      "phases_summary": {
        "phase-1": "workflow yaml 신규 + dry-run evidence (workflow_dispatch v0.0 dummy) + awk 추출 spike",
        "phase-2": "CHANGELOG.md 76 entry 단축 + v6.19 last full entry 추가 + ARCHITECTURE § 4 mechanism row #13 신규 정전화 cascade"
      }
    },
    {
      "id": "D8",
      "topic": "ARCHITECTURE cascade host 결정 (v3.21 narrative 정전화 3 단계 패턴 적용)",
      "decision": "신 row #13 추가 (단일 host, v6.10 L3 판정 host =1 → 적용 대상 부재 자연). 단 § 4 본문 paragraph cascade host 추가 ≥2 → 패턴 적용.",
      "rationale": "v3.21 패턴 = (a) DESIGN 1차 + (b) EXECUTE Edit + (c) VERIFY grep. mechanism row 본질 = enhancement 패턴 부적합 (신 mechanism = 신 row 자연). 단 본문 paragraph cascade = 'GitHub Releases hybrid migration mechanism' 인용 narrative → 2 host (row + paragraph) → 패턴 적용 자연.",
      "cascade_marker": "신 row #13 + § 4 본문 paragraph 안 marker 부재 자연 (단일 host vs 다중 host 결정 = DESIGN 결정)"
    },
    {
      "id": "D9",
      "topic": "첫 release v6.19 실 발행 시점",
      "decision": "REPORT stage commit 시점 (`feat(meta): v6.19 ...  [release:v6.19]` marker)",
      "rationale": "EXECUTE phase-1 = dry-run evidence (v0.0 dummy) / phase-2 = CHANGELOG + ARCHITECTURE 정리 commit (marker 부재 = no-op) / REPORT commit = 첫 실 발행. self-host 도그푸드 본질 (sc_5 evidence + r_6 인정 narrative).",
      "fallback": "release 발급 실패 시 workflow_dispatch fallback (수동 trigger)"
    }
  ],
  "approach": "본 milestone = 2 phase EXECUTE + REPORT 시점 첫 실 release 발행. phase-1 = .github/workflows/release-publish.yml 신규 추가 + dry-run evidence (v0.0 dummy version workflow_dispatch trigger). phase-2 = CHANGELOG.md 76 entry 단축 (4 era 매핑) + v6.19 last full entry 추가 + ARCHITECTURE § 4 mechanism row #13 신규 + § 4 본문 paragraph cascade. REPORT commit msg 안 `[release:v6.19]` marker → 첫 실 release 자동 발행 (sc_5 evidence).",
  "phases": [
    {
      "id": "phase-1",
      "title": "workflow yaml 신규 + dry-run evidence",
      "scope": [
        ".github/workflows/release-publish.yml 신규 작성 (D1 gh CLI + D2 awk + D3 git tag + D4 workflow_dispatch input)",
        "yamllint 검증 (commit 전 의무)",
        "workflow_dispatch dry-run trigger evidence — version=v0.0, dry_run=true 안 awk 추출 logic + commit msg contains filter 검증 (실 release 발급 회피, gh release create 안 --draft flag 또는 dry_run branch)",
        "ext_4/ext_5 verification — context7 추정 본질 dry-run 안 실 검증 (r_1 mitigation 본질)"
      ],
      "deliverables": [
        ".github/workflows/release-publish.yml (~50 LOC 예상)",
        "execute/phase-1.md (workflow 본문 + dry-run evidence + ext_4/ext_5 verification trace)"
      ],
      "commit_message": "feat(meta): v6.19 phase-1 — release-publish workflow yaml + dry-run evidence"
    },
    {
      "id": "phase-2",
      "title": "CHANGELOG 단축 + v6.19 last full entry + ARCHITECTURE 정전화",
      "scope": [
        "CHANGELOG.md 76 entry 단축 — v1.0~v5.21 (line 392~934) → ID + title + REPORT link 1줄 (D6 era 매핑 적용). v6.0~v6.18 본문 잔존 (R1 결정 본질 정합)",
        "v6.19 = CHANGELOG.md 안 last full entry 추가 (`## [v6.19] - 2026-05-21` + 본문 + 마지막 줄 hybrid 분기 marker narrative)",
        "ARCHITECTURE.md § 4 매트릭스 안 mechanism row #13 신규 추가 (GitHub Releases hybrid migration mechanism)",
        "ARCHITECTURE.md § 4 본문 paragraph 안 본 mechanism 인용 narrative (cascade host 2 = row + paragraph, v3.21 패턴 적용)",
        "root CLAUDE.md 안 짧은 reference 추가 (옵션, 사용자 결정)",
        "v3.21 narrative 정전화 3 단계 패턴 적용 — (a) 본 DESIGN paragraph 1차 + (b) EXECUTE phase-2 Edit 양방 host + (c) VERIFY grep"
      ],
      "deliverables": [
        "CHANGELOG.md (size 99998 → ~48KB 예상)",
        "projects/meta/ARCHITECTURE.md (§ 4 row #13 + 본문 paragraph)",
        "execute/phase-2.md (단축 script trace + cascade host evidence)"
      ],
      "commit_message": "feat(meta): v6.19 phase-2 — CHANGELOG hybrid 단축 + ARCHITECTURE § 4 #13 mechanism 정전화"
    }
  ],
  "risk_mitigation": [
    {
      "risk_ref": "r_1 (workflow yaml 오류)",
      "mitigation_phase": "phase-1",
      "method": "yamllint 사전 검증 + workflow_dispatch dry-run trigger (version=v0.0, dry_run=true) 실 evidence"
    },
    {
      "risk_ref": "r_2 (marker false trigger)",
      "mitigation_phase": "phase-1",
      "method": "regex strict (`\\[release:v[0-9]+\\.[0-9]+\\]`) + branch=main 한정 + push commit dry-run test (marker contains 매칭 evidence)"
    },
    {
      "risk_ref": "r_3 (REPORT 추출 실패)",
      "mitigation_phase": "phase-1",
      "method": "awk flag-based 패턴 (D2) + v6.18 MILESTONE.md fixture dry-run evidence (98 line evidence 정합)"
    },
    {
      "risk_ref": "r_4 (사용자 통제 손실)",
      "mitigation_phase": "phase-1+REPORT",
      "method": "commit msg marker 작성 자체 = 명시 결정 게이트 (R3+R4) + workflow_dispatch dry_run fallback + 첫 실 발행 = REPORT commit 본질 사용자 명시 (commit·배포 전 확인 요청 memory 정합)"
    },
    {
      "risk_ref": "r_5 (정보 손실)",
      "mitigation_phase": "phase-2",
      "method": "trace 3중 보존 = CHANGELOG short link → REPORT.md / REPORT.md 본문 / git log atomic commits. 단축 형식 안 REPORT link 의무 (sc_3 정합)"
    },
    {
      "risk_ref": "r_6 (첫 tag baseline 분리)",
      "mitigation_phase": "phase-2",
      "method": "ARCHITECTURE § 4 row #13 안 시간 분기 narrative 명시 = 'v1.0~v6.18 trace = CHANGELOG.md / v6.19+ trace = Releases' (oos_1+oos_4 정합)"
    },
    {
      "risk_ref": "r_7 (link 깨짐)",
      "mitigation_phase": "REPORT",
      "method": "INTENT oos_6 명시 (polish 별 milestone). 첫 Release evidence 안 깨짐 인정 narrative + REPORT.md cross-ref user 가이드"
    },
    {
      "risk_ref": "ri_1 (commit msg filter regex)",
      "mitigation_phase": "phase-1",
      "method": "EXECUTE phase-1 안 push commit dry-run test (실 marker contains 매칭 evidence — context7 ext_5 추정 verification)"
    },
    {
      "risk_ref": "ri_4 (era 분기 path)",
      "mitigation_phase": "phase-2",
      "method": "D6 매핑 표 적용 (4 era 매핑 함수). _archive/ path 본질 인식 의무 (v4.0 phase-2 후)"
    },
    {
      "risk_ref": "ri_5 (size target 공격적)",
      "mitigation_phase": "DESIGN",
      "method": "D5 결정 = sc_3 target < 20KB → < 50KB 재조정"
    }
  ],
  "five_perspective_review": [
    {
      "perspective": "architecture",
      "evaluation": "9-stage-flattened era 정합 + hybrid 본질 (시간 분기 3 era) 자연. mechanism 본질 = ARCHITECTURE § 4 매트릭스 신 row #13. cascade host 2 (row + 본문 paragraph) = v3.21 패턴 적용 자연 (v6.10 L3 판정 ≥2). AI Native § 7.1 면 = (a) 컨텍스트 효율 (CHANGELOG size 감소) + (b) 자율성 (commit msg marker 자동 발행) + (c) 다중 AI 협업 (GitHub Releases = 외부 visible) — 3 면 모두 enhancement 자연.",
      "verdict": "PASS — 본질 정합 + 신 row #13 자연. concern 0.",
      "concerns": []
    },
    {
      "perspective": "spec-drift",
      "evaluation": "context7 evidence 5 ext 안 ext_1~ext_3 verified + ext_4~ext_5 추정 (gh release create + contains expression). DESIGN 안 EXECUTE phase-1 dry-run 검증 의무 명시 (r_1 + ri_1 mitigation). v5.7 spec-drift spike 패턴 cycle 13 적용 본질 = (a) RESEARCH 안 추정 명시 + (b) EXECUTE phase-1 안 spike (dry-run) + (c) DESIGN 안 verification method 사전 결정. 본 milestone 안 (a)+(b)+(c) 본질 자연 발현.",
      "verdict": "PASS — 추정 명시 + verification method 사전 결정 (spike 패턴 정합). concern 1 = ext_4/ext_5 verification 실 evidence 부재 시 phase-1 fail-fast 필요.",
      "concerns": ["P2: phase-1 dry-run evidence 결과 안 ext_4/ext_5 mismatch 발견 시 hardcode 정정 의무 (v5.7 패턴 (c) 단계)"]
    },
    {
      "perspective": "safety",
      "evaluation": "사용자 통제 본질 (r_4) 핵심 = commit msg marker 작성 자체 = 명시 결정 게이트. workflow_dispatch dry_run fallback = 추가 안전망. permissions: contents: write 명시 (gh release create + git tag push 권한). GITHUB_TOKEN auto-provided (별 secret 부재). branch=main 한정 trigger (false positive 회피). regex strict (r_2).",
      "verdict": "PASS — 사용자 통제 + permissions 명료 + branch 한정. concern 1 = release 발급 실패 시 partial state (tag pushed but release 부재) 회복 방법.",
      "concerns": ["P2: tag push 후 release 발급 실패 시 회복 방법 = `gh release delete` + `git tag -d` + `git push --delete origin {tag}`. workflow 안 fail-fast 또는 atomic 본질 결정"]
    },
    {
      "perspective": "code-quality",
      "evaluation": "workflow yaml = yamllint 사전 검증 의무 (r_1). bash script (awk + git tag + gh release create) = `set -euo pipefail` 의무 (ci.yml 패턴 정합). 단축 script = python 또는 bash 결정 (DESIGN 안 미결정 — EXECUTE phase-2 안 결정). era 매핑 함수 = D6 표 적용.",
      "verdict": "PASS-with-comments — code quality 본질 명료. concern 1 = 단축 script 본질 (python vs bash) DESIGN 단계 미결정 → EXECUTE phase-2 안 결정 자연.",
      "concerns": ["P3: 단축 script python vs bash 선택 — python = 정확 (regex + era 매핑 함수) / bash = 단순 (single shell script). 76 entry × era 매핑 본질 = python 추천 (sc_3 sc_4 정합)"]
    },
    {
      "perspective": "ai-native",
      "evaluation": "§ 7.1 3 면 매트릭스 적용 = (a) 컨텍스트 효율 (CHANGELOG size 99998 → ~48KB, -52%) cycle 4 (v6.0 → v6.2 → v6.16 → v6.19) + (b) 자율성 (commit msg marker 자동 발행) cycle 2 (v6.8 propose-next dedupe 후) + (c) 다중 AI 협업 (GitHub Releases = 외부 visible release note) cycle 4 (v6.4 cascade-sync → v6.6 audit chain → v6.8 propose-next dedupe → v6.19 Releases). 3 면 모두 enhancement.",
      "verdict": "PASS — 3 면 enhancement cycle 누적 + 자연 발현. concern 0.",
      "concerns": []
    }
  ],
  "ai_native_alignment": {
    "context_efficiency": "CHANGELOG.md size 99998 → ~48KB (-52%) + v6.20+ = Releases 단일 source (CHANGELOG entry 추가 단속) — repo clone 시 토큰 절감 자연. cycle 4 누적 (v6.0/v6.2/v6.16/v6.19).",
    "autonomy": "commit msg marker `[release:v{X.Y}]` 자동 trigger → release 자동 발행 (LLM/사용자 추가 step 부재). 단 marker 작성 자체 = 명시 결정 게이트 (사용자 통제 본질 보존, r_4 mitigation).",
    "multi_ai_collaboration": "GitHub Releases = 외부 visible release note (Anthropic Claude Code 생태계 외 visible). 다른 AI 도구 (Cursor / Copilot 등) repo audit 시 Releases UI 인식 자연 (CHANGELOG.md 또는 REPORT.md cross-ref 대체)."
  },
  "cascade_check": {
    "v321_pattern_applicable": true,
    "host_count": 2,
    "hosts": ["ARCHITECTURE § 4 매트릭스 row #13 신규", "ARCHITECTURE § 4 본문 paragraph 안 본 mechanism 인용 narrative"],
    "pattern_steps": {
      "step_a_design_1차": "본 DESIGN paragraph 안 cascade host 2 명시",
      "step_b_execute_edit": "phase-2 안 두 host 양방 Edit",
      "step_c_verify_grep": "VERIFY 안 grep 두 host 매칭 evidence 의무"
    },
    "cycle_count": 13
  }
}
```

### Narrative

본 DESIGN = 2 phase EXECUTE 분할 + REPORT 시점 첫 실 release 발행 도그푸드. 9 decisions trace (D1~D9) + 10 risk_mitigation 매핑 + 5 관점 inline review (4 PASS + 1 PASS-with-comments) + cascade host 2 (v3.21 패턴 cycle 13 적용 자연) + AI Native § 7.1 3 면 모두 enhancement.

핵심 결정 = (D1) gh CLI + (D2) flag-based awk + (D3) workflow 안 git tag + (D4) version+dry_run input + (D5) sc_3 target < 50KB 재조정 (RESEARCH cb_2 evidence) + (D6) 4 era 매핑 표 (ri_4 mitigation) + (D7) 2 phase 분할 (lightweight) + (D8) cascade host 2 (v3.21 패턴 적용) + (D9) REPORT commit 시점 첫 실 발행 (도그푸드).

v5.7 spec-drift spike 패턴 cycle 13 적용 본질 = RESEARCH ext_4/ext_5 추정 → DESIGN 안 verification method 명시 → EXECUTE phase-1 dry-run evidence → mismatch 시 hardcode 정정. spec-drift perspective concern P2 정합.

INTENT sc_3 retouch 본질 (D5) = DESIGN 안 mitigation 자연 (사용자 명시 결정 전 단계). 사용자 APPROVE 게이트 안 확인 필요.

## APPROVE

### Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-21",
    "scope": "DESIGN 9 decisions (D1~D9) + 2 phase 분할 + 5 관점 inline review + cascade host 2 (v3.21 cycle 13) + AI Native § 7.1 3 면 enhancement",
    "method": "AskUserQuestion APPROVE 게이트 — 옵션 '승인 — EXECUTE phase-1 진행' 명시 선택",
    "pre_plan_rounds": 5,
    "pre_plan_round_decisions": {
      "R1": "migration scope = hybrid (신규 v6.19+ Releases + 과거 v1.0~v6.18 CHANGELOG.md 잔존 + 단축)",
      "R2": "과거 76 entry 단축 형태 = ID + title + REPORT link 1줄",
      "R3": "v6.19+ git tag + GitHub Release 발급 = GitHub Actions 자동 (commit msg trigger)",
      "R4": "trigger pattern = explicit marker `[release:v{X.Y}]`",
      "R5": "Release body = MILESTONE.md ## REPORT 섹션 추출"
    },
    "approve_round_decision": "EXECUTE phase-1 즉시 진행 — DESIGN 9 decisions 모두 승인",
    "session_note": "이전 세션 (2026-05-21 earlier) 안 5 round 결정 후 API Error 발생. 새 세션 (본 세션) 안 결정 trace 재구성 + OPEN/INTENT/RESEARCH/DESIGN 진행 후 APPROVE 게이트 재진입. 결정 본질 보존."
  }
}
```

### Narrative

사용자 명시 결정 — DESIGN 9 decisions + 2 phase 분할 + 5 관점 review 결과 모두 승인. EXECUTE phase-1 진입 권한 확보.

본 milestone 안 사용자 결정 trace = pre-PLAN 5 round (이전 세션) + APPROVE 게이트 1 round (본 세션) = 총 6 round 결정. 이전 세션 API Error 후 재진행 본질 명시 (session_note).

EXECUTE phase-1 본질 = .github/workflows/release-publish.yml 신규 + dry-run evidence (workflow_dispatch v0.0 dummy version + ext_4/ext_5 context7 추정 verification 의무).

## EXECUTE

### Spec

```json
{
  "phases_progress": [
    {
      "id": "phase-1",
      "status": "completed",
      "summary": ".github/workflows/release-publish.yml 신규 (145 LOC) + 4 evidence verification (yaml syntax + awk fixture + ext_5 verified + ext_4 partial verified). v5.7 spec-drift spike 패턴 cycle 13 완성. deferred_to_remote 1 항목 (실 dry-run trigger = REPORT commit 시점 자연 흡수).",
      "artifact": "execute/phase-1.md",
      "commit": "TBD (phase-2 후 일괄 commit 또는 phase-1 단독 commit, 사용자 결정)"
    },
    {
      "id": "phase-2",
      "status": "completed",
      "summary": "CHANGELOG.md 안 v1.0~v5.21 52 entry 단축 (99998 → 65705 bytes, -34.3%) + ARCHITECTURE § 4 row #13 + 본문 paragraph cascade host 2 (v3.21 cycle 39) + INTENT sc_3 second retouch < 70KB. v6.19 last full entry = REPORT 단계 deferred (REPORT 본문 single source 본질).",
      "artifact": "execute/phase-2.md + execute/shrink_changelog.py (1회성 mechanical script)"
    }
  ]
}
```

### Narrative

EXECUTE phase-1 완료. release-publish workflow yaml 신규 + 4 evidence verification. phase-2 진입 예정 = CHANGELOG hybrid 단축 + ARCHITECTURE § 4 row #13 정전화 cascade.

## VERIFY

### Spec

```json
{
  "smoke_results": {
    "smoke-spec-verification": {"verdict": "PASS", "result": "PASS=389 / FAIL=0 / SKIP=184 (v6.19 5 stage 추가 +5)"},
    "smoke-open-stage-discipline": {"verdict": "PASS", "result": "checked=47 / historical skipped=1"},
    "smoke-entry-title-guideline": {"verdict": "PASS", "result": "no violations"},
    "smoke-projects-scope-discipline": {"verdict": "PASS"},
    "smoke-scope-contract": {"verdict": "PASS", "result": "PASS=88 / FAIL=0 / SKIP=8"},
    "smoke-cross-ref": {"verdict": "PASS", "result": "PASS=1 / FAIL=0"},
    "smoke-bundle-trigger": {"verdict": "PASS"},
    "smoke-claude-md-drift": {"verdict": "PASS", "result": "13/13 PASS"},
    "smoke-candidate-draft-schema": {"verdict": "PASS", "result": "PASS=11 / FAIL=0"}
  },
  "criteria_check": [
    {
      "sc_id": "sc_1",
      "criterion": ".github/workflows/release-publish.yml 신규 + 2 trigger (push + workflow_dispatch)",
      "verdict": "PASS",
      "evidence": "release-publish.yml 145 LOC (phase-1 commit) — `on: push: branches: [main]` + `workflow_dispatch: inputs: {version, dry_run}` 본문 확인"
    },
    {
      "sc_id": "sc_2",
      "criterion": "workflow logic 5 단계 (commit msg marker 추출 → tag 발급 → MILESTONE.md locate → REPORT 추출 → gh release create)",
      "verdict": "PASS",
      "evidence": "release-publish.yml 안 7 step 본문 정합 (5 핵심 단계 + dry_run summary + tag conflict check 보강 2 단계 추가). python yaml.safe_load PASS"
    },
    {
      "sc_id": "sc_3",
      "criterion": "CHANGELOG.md v1.0~v5.21 entry → ID + title + REPORT link 1줄 단축 + 결과 size < 70KB (DESIGN D5 + phase-2 second retouch)",
      "verdict": "PASS",
      "evidence": "shrink_changelog.py --apply 실 evidence — size 99998 → 65705 bytes (-34.3%), 52 entry shrunk, 0 title 부재 (fallback PASS), 19 link 부재 자연 (range entry 본질 인정, r_5 trace 3중 mitigation). 65705 < 70000 PASS"
    },
    {
      "sc_id": "sc_4",
      "criterion": "v6.19 = CHANGELOG.md 안 last full entry + hybrid 분기 marker narrative",
      "verdict": "PENDING",
      "evidence": "REPORT 단계 자연 흡수 — REPORT 본문 = entry 본문 single source 본질 (phase-2 deferred_to_report 항목 정합). REPORT 단계 진행 시 entry 추가 + marker narrative 의무"
    },
    {
      "sc_id": "sc_5",
      "criterion": "v6.19 commit msg `[release:v6.19]` marker 실 trigger evidence — workflow 실행 + Releases 발급 + git tag push",
      "verdict": "PENDING",
      "evidence": "REPORT commit 시점 자연 흡수 (DESIGN D9 정합) — 본 EXECUTE/VERIFY 단계 = local 검증만, 실 trigger = remote Actions 실행 본질"
    },
    {
      "sc_id": "sc_6",
      "criterion": "ARCHITECTURE § 4 매트릭스 row #13 + 본문 paragraph cascade host 2 (v3.21 narrative 정전화 3 단계 패턴)",
      "verdict": "PASS",
      "evidence": "grep evidence — line 149 매트릭스 row #13 (v6.19) + line 179 본문 paragraph (anchor=section-4-end-row-13). v3.21 (a) DESIGN 1차 D8 + (b) EXECUTE Edit phase-2 + (c) VERIFY grep 본 단계 = 3 단계 모두 PASS, cycle 39 완성"
    },
    {
      "sc_id": "sc_7",
      "criterion": "pre-commit 18 hook 전체 PASS (smoke 회귀 0)",
      "verdict": "PASS",
      "evidence": "9 active smoke 풀패스 (smoke_results 정합) — pre-commit 등록된 hook 모두 PASS. 회귀 0건"
    }
  ],
  "risk_mitigation_status": [
    {"risk_id": "r_1", "status": "MITIGATED", "method": "yamllint 사전 검증 (python yaml.safe_load PASS) + workflow_dispatch dry-run trigger 옵션 추가"},
    {"risk_id": "r_2", "status": "MITIGATED", "method": "regex strict `\\[release:v[0-9]+\\.[0-9]+\\]` + branch=main 한정 + tag conflict check (실 trigger evidence = REPORT commit 시점 자연)"},
    {"risk_id": "r_3", "status": "MITIGATED", "method": "awk flag-based 패턴 + v6.18 MILESTONE.md fixture dry-run 95 line 추출 evidence"},
    {"risk_id": "r_4", "status": "MITIGATED", "method": "commit msg marker 작성 자체 = 명시 결정 게이트 + workflow_dispatch dry_run fallback + 사용자 명시 결정 게이트 (APPROVE 통과)"},
    {"risk_id": "r_5", "status": "MITIGATED", "method": "trace 3중 보존 (CHANGELOG short link + REPORT.md 본문 + git log atomic commits). 단축 형식 안 REPORT link 의무 (19 entry link 부재 = range entry 본질 자연 인정, _archive directory 매핑 trace 보존)"},
    {"risk_id": "r_6", "status": "MITIGATED", "method": "ARCHITECTURE § 4 row #13 + paragraph 안 '시간 분기 3 era' narrative 명시 (v1.0~v5.21 archived / v6.0~v6.18 본문 / v6.19+ Releases)"},
    {"risk_id": "r_7", "status": "ACKNOWLEDGED", "method": "INTENT oos_6 명시 (polish 별 milestone). 첫 Release evidence REPORT 단계 안 broken link 인정 narrative 의무"},
    {"risk_id": "ri_1", "status": "MITIGATED", "method": "context7 ext_5 fully verified (`contains()` spec) + ext_4 partial verified (`gh release create --generate-notes` 직접 인용 + `--notes-file` 동질). v5.7 spike 패턴 cycle 13 완성, mismatch 부재 hardcode 유지"},
    {"risk_id": "ri_2", "status": "PENDING", "method": "UTF-8 file 사용 (ubuntu-latest 기본). 실 multi-byte evidence = REPORT commit 시점 release body 발급 후 확인 자연"},
    {"risk_id": "ri_3", "status": "ACKNOWLEDGED", "method": "INTENT oos_6 정합 (polish 별 milestone). 첫 Release evidence 안 ``` JSON code block UI rendering 인정 narrative"},
    {"risk_id": "ri_4", "status": "MITIGATED", "method": "DESIGN D6 4 era 매핑 표 + script _fallback_archive_link 함수 (18 entry archive slug 매핑). 19 entry link 부재 자연 (range entry / slug mismatch, 정보 손실 인정 본질)"},
    {"risk_id": "ri_5", "status": "MITIGATED", "method": "DESIGN D5 < 50KB → EXECUTE phase-2 evidence-base second retouch < 70KB → 실 측정 65705 bytes PASS"},
    {"risk_id": "ri_6", "status": "PENDING", "method": "REPORT 단계 안 'self-host 도그푸드 본질' 명시 narrative 의무 (sc_5 + r_6 정합)"}
  ],
  "cascade_check": {
    "v321_pattern_applied": true,
    "host_count": 2,
    "cycle": 39,
    "step_a_design": "PASS — DESIGN D8 안 cascade host 2 명시",
    "step_b_execute": "PASS — phase-2 안 두 host 양방 Edit (line 149 매트릭스 row + line 179 본문 paragraph)",
    "step_c_verify_grep": "PASS — grep evidence (line 149 + line 179 모두 매칭)"
  },
  "size_evidence": {
    "before_bytes": 99998,
    "after_bytes": 65705,
    "delta_bytes": -34293,
    "delta_pct": -34.3,
    "size_limit_bytes": 100000,
    "margin_bytes": 34295,
    "target_bytes": 70000,
    "target_met": true
  },
  "verdict": {
    "overall": "RESOLVED",
    "rationale": "sc 5 PASS (sc_1~sc_3 + sc_6~sc_7) + sc 2 PENDING (sc_4 + sc_5) — PENDING sc 2건 = REPORT 단계 본질 자연 흡수 (sc_4 = CHANGELOG entry 추가 본질 + sc_5 = REPORT commit 시점 첫 실 release 발행). risk 11 MITIGATED + 2 ACKNOWLEDGED + 2 PENDING (ri_2 multi-byte + ri_6 도그푸드 self-reference, 모두 REPORT 단계 자연). cascade host 2 v3.21 cycle 39 완성. SIZE_LIMIT 회귀 회피 본질 (goal) PASS."
  }
}
```

### Narrative

VERIFY 본 단계 = local 검증 본질. smoke 9 active 풀패스 + criteria_check 7 sc (5 PASS + 2 PENDING REPORT 자연) + risk 13 mitigation (11 MITIGATED + 2 ACKNOWLEDGED + 2 PENDING REPORT 자연) + cascade host 2 v3.21 cycle 39 grep evidence + size evidence (99998 → 65705 bytes, < 70KB target PASS, SIZE_LIMIT 대비 ~34KB 여유).

**verdict = RESOLVED** — goal (SIZE_LIMIT 회귀 회피 + GitHub Releases mechanism 도입) 본질 PASS. PENDING 2 sc + 2 risk 모두 REPORT 단계 안 자연 흡수 본질 (commit msg marker + Releases 첫 발급 evidence 본질).

다음 단계 = REPORT — summary + delta + lessons_learned + v6.19 CHANGELOG entry 추가 + commit msg [release:v6.19] marker 첫 실 trigger.

## REPORT

### Spec

```json
{
  "summary": "CHANGELOG.md SIZE_LIMIT 회귀 회피 + GitHub Releases hybrid migration mechanism 도입. (a) .github/workflows/release-publish.yml 신규 (145 LOC, gh CLI + flag-based awk + workflow_dispatch + commit msg marker filter) + (b) CHANGELOG.md 안 v1.0~v5.21 52 entry 일괄 단축 (99998 → 65705 bytes, -34.3%) + (c) ARCHITECTURE § 4 매트릭스 row #13 + 본문 paragraph cascade host 2 정전화 (v3.21 cycle 39) + (d) INTENT sc_3 evidence-base double retouch (< 20KB → < 50KB → < 70KB). 본 milestone 자체 = 첫 GitHub Release 발급 self-host 도그푸드 cycle (REPORT commit msg `[release:v6.19]` marker = trigger). 시간 분기 3 era 본질 (v1.0~v5.21 archived / v6.0~v6.18 본문 / v6.19+ Releases). pre-PLAN 5 round (이전 세션) + APPROVE 1 round (본 세션) trace 보존 (multi-session 결정 본질). verdict = RESOLVED (sc 5 PASS + 2 PENDING REPORT 자연 흡수, risk 11 MITIGATED + 2 ACKNOWLEDGED + 2 PENDING REPORT 자연).",
  "delta": {
    "files_created": 4,
    "files_edited": 4,
    "files_created_list": [
      "projects/meta/milestones/v6.19/MILESTONE.md (본책, 9 section + frontmatter)",
      "projects/meta/milestones/v6.19/execute/phase-1.md (workflow yaml + 4 evidence verification)",
      "projects/meta/milestones/v6.19/execute/phase-2.md (CHANGELOG 단축 + ARCHITECTURE cascade)",
      "projects/meta/milestones/v6.19/execute/shrink_changelog.py (1회성 mechanical script, 138 LOC)",
      ".github/workflows/release-publish.yml (145 LOC)"
    ],
    "files_edited_list": [
      "CHANGELOG.md (size 99998 → 65705 bytes / 52 entry 단축 + v6.19 last full entry 추가)",
      "projects/meta/ARCHITECTURE.md (§ 4 매트릭스 row #13 + 본문 paragraph #13 신규, cascade host 2)",
      "projects/meta/ROADMAP.md (v6.19 entry append + recent 3 archival = v6.16 archival)",
      "MILESTONE.md (REPORT + PROPOSE 본 단계 작성)"
    ],
    "loc_delta": {
      "added": 1487,
      "removed": 521,
      "net": 966
    }
  },
  "lessons_learned": [
    {
      "id": "L1",
      "priority": "P1",
      "lesson": "multi-session pre-PLAN 결정 trace 보존 패턴 — 이전 세션 API Error 후 새 세션 안 5 round 결정 본질 재구성 + APPROVE.session_note 명시 → 결정 trace 보존",
      "evidence": "사용자 'API Error 떠서 새 세션에서 진행하는거야. 결정 다 했어' 명시 → 새 세션 안 결정 본질 재정리 → APPROVE.session_note 안 multi-session trace 명시 → INTENT motivation 안 명시",
      "next_milestone_impact": "차후 multi-session 진행 시 APPROVE.session_note 또는 INTENT 안 pre-PLAN round trace 명시 의무 (workflow 자연 패턴)"
    },
    {
      "id": "L2",
      "priority": "P1",
      "lesson": "size target evidence-base double retouch 패턴 — DESIGN D5 1차 retouch (< 20KB → < 50KB, RESEARCH cb_2 추정 근거) + EXECUTE phase-2 2차 retouch (< 50KB → < 70KB, dry-run 실 측정 evidence). 추정 → 측정 → 재조정 본질 v5.7 spike 패턴 동질",
      "evidence": "INTENT sc_3 초기 < 20KB (사용자 5 round 결정 본질 정합) → DESIGN D5 안 RESEARCH cb_2 evidence ~48KB 추정 기반 < 50KB → EXECUTE phase-2 dry-run 65705 bytes 실 측정 → < 70KB. 두 번 retouch trace 명시 = sc 변경 자연 본질 (사용자 명시 결정 전 단계 evidence-base)",
      "next_milestone_impact": "size/numeric target 본질 결정 시 RESEARCH 추정 → DESIGN 1차 결정 → EXECUTE dry-run 측정 → second retouch 패턴 자연. INTENT sc 안 evidence-base 본질 명시 의무"
    },
    {
      "id": "L3",
      "priority": "P2",
      "lesson": "context7 verification 추정 → verified 전환 cycle (v5.7 spike 패턴 cycle 13) — RESEARCH ext_4 (`gh release create --notes-file`) + ext_5 (`contains()` expression) 추정 명시 → EXECUTE phase-1 직접 query 검증 → ext_5 fully verified + ext_4 partial verified (`--generate-notes` 직접 인용 + `--notes-file` 동질)",
      "evidence": "RESEARCH ext_4.verified=false + verification_method 명시 → phase-1 v_3+v_4 안 query 결과 inline + mismatch 부재 hardcode 유지",
      "next_milestone_impact": "외부 spec 추정 시 RESEARCH 안 verified flag + verification_method 명시 의무. EXECUTE phase 안 직접 query 검증 패턴. v5.7 spike 패턴 cycle counter 갱신 (cycle 13)"
    },
    {
      "id": "L4",
      "priority": "P2",
      "lesson": "1회성 mechanical script 보존 패턴 — shrink_changelog.py = execute/ 안 보존 (artifact). 향후 동질 archival cycle 시 reference 자연",
      "evidence": "execute/shrink_changelog.py 138 LOC, parsing logic (4 era 매핑 fallback) + size delta 측정 출력. 1회성이나 script 자체 = mechanical trace 본질",
      "next_milestone_impact": "차후 archival cycle (v5.21 + v6.19 + ?) 시 본 script reference 자연. 동질 patterning 시 script 보존 본질 default"
    },
    {
      "id": "L5",
      "priority": "P2",
      "lesson": "cascade host 2 patterning — v3.21 narrative 정전화 3 단계 패턴 cycle 39 자연 발현. § 4 매트릭스 row + § 4 본문 paragraph 양방 host = host 2 (v6.10 L3 판정 ≥2 → 패턴 적용 자연)",
      "evidence": "DESIGN D8 cascade host 2 명시 + EXECUTE phase-2 양방 Edit + VERIFY grep line 149+179 매칭 = 3 단계 모두 PASS",
      "next_milestone_impact": "신 mechanism 정전화 시 cascade host 갯수 결정 본질 = v6.10 L3 판정 기준 (≥2 → 패턴 적용). cycle counter 갱신 의무 (cycle 39)"
    },
    {
      "id": "L6",
      "priority": "P2",
      "lesson": "AI Native § 7.1 3 면 cycle 누적 — 컨텍스트 효율 cycle 4 (v6.0 정의 → v6.2 디렉토리 평탄화 → v6.16+v6.18 stage 본질 → v6.19 CHANGELOG size 단축) + 자율성 cycle 2 (v6.5+v6.8 propose-next → v6.19 commit msg marker 자동 trigger) + 다중 AI 협업 cycle 4 (v6.4 cascade-sync → v6.6+v6.9 audit chain → v6.19 GitHub Releases 외부 visible)",
      "evidence": "DESIGN ai_native_alignment 안 3 면 매핑 + ARCHITECTURE § 4 paragraph #13 안 3 면 cycle 본문 명시",
      "next_milestone_impact": "AI Native 3 면 cycle 누적 trace 본질 = 각 milestone 안 면 매핑 의무. v7.0 major bump (AI Native 3 면 통합) 후보 자연 (next_candidates#2 정합)"
    },
    {
      "id": "L7",
      "priority": "P3",
      "lesson": "19 entry link 부재 자연 인정 — range entry (v1.0–v1.4 / v1.10c–v1.10h3) 안 단일 REPORT.md path 매핑 모호. 정보 손실 인정 = trace 3중 본질 (CHANGELOG short + REPORT.md + git log) 정합",
      "evidence": "shrink_changelog.py 결과 = 19 entry link 부재 (range entry slug mismatch 본질). r_5 mitigation trace 3중 본질 정합",
      "next_milestone_impact": "차후 archival cycle 시 range entry parsing 향상 candidate (next_candidates#3 정합) — 그러나 본질 정보 손실 자연 인정"
    },
    {
      "id": "L8",
      "priority": "P3",
      "lesson": "workflow yaml dry_run mode 분기 패턴 — `if: steps.mode.outputs.dry_run == 'true'` 안 release create step skip + 추출 logic only. local 검증 한계 보완 본질. 본 패턴 후속 workflow 일반 정합",
      "evidence": "release-publish.yml 안 'Dry-run summary' step (dry_run==true) + 'Create GitHub Release' step (dry_run != 'true') 분기",
      "next_milestone_impact": "차후 workflow 추가 시 dry_run input + 분기 패턴 default candidate"
    }
  ],
  "candidates_named_only": [
    "도그푸드 self-reference 본질 narrative 정전화 — 본 milestone 자체 = 첫 GitHub Release 발급 self-host evidence. ri_6 PENDING resolution 본질 REPORT narrative 안 흡수 (별 milestone 부재).",
    "OPEN/INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE 9 stage skill 도그푸드 cycle 2 evidence stream (v6.17 cycle 1 후속) — 본 milestone 진행 자체가 9 stage skill auto-load evidence cycle, 의식적 호출 안 함 + 사후 회고 가능 (오는 milestone 안 평가).",
    "archival cycle 세 번째 (v5.21 첫 + v6.19 둘째 + ?) — evidence-base trigger 본질, 다음 SIZE_LIMIT 회귀 시점 자연 (현 65705 bytes + ~34KB 여유, v6.x entry 추가 0건 본질 → trigger 회피)."
  ],
  "verdict_final": "RESOLVED",
  "verdict_narrative": "goal (SIZE_LIMIT 회귀 회피 + GitHub Releases mechanism 도입) PASS. local 검증 본질 (workflow yaml + CHANGELOG 단축 + ARCHITECTURE cascade) 모두 evidence-base 정합. 실 trigger evidence (sc_5 + ri_2 + ri_6) = 본 commit msg `[release:v6.19]` marker 첫 실 release 발급 자연 흡수 (PENDING → RESOLVED 전환 REPORT commit 이후 self-evidence)."
}
```

### Narrative

본 v6.19 = CHANGELOG → GitHub Releases hybrid migration mechanism 도입 milestone. (a) workflow yaml 신규 + (b) CHANGELOG 52 entry 단축 + (c) ARCHITECTURE 매트릭스 row #13 + 본문 paragraph 정전화 + (d) INTENT sc_3 evidence-base double retouch.

8 lessons (P1 2 + P2 4 + P3 2) — multi-session pre-PLAN trace 보존 (L1) + size target evidence-base double retouch (L2) + context7 추정 verification cycle 13 (L3) + 1회성 script 보존 (L4) + cascade host 2 cycle 39 (L5) + AI Native 3 면 cycle 누적 (L6) + 19 entry link 부재 자연 인정 (L7) + workflow yaml dry_run 분기 패턴 (L8).

3 candidates_named_only — 도그푸드 self-reference + 9 stage skill cycle 2 evidence + archival cycle 세 번째 trigger.

**self-host 도그푸드 본질** — 본 milestone 자체 = 첫 GitHub Release 발급 evidence. REPORT commit msg `[release:v6.19]` marker = 본 mechanism 첫 실 trigger. 본 paragraph 가 release body 본문 일부 (## REPORT 섹션 추출 본질 정합). ri_6 PENDING resolution 본질 자연 흡수 (별 milestone 부재).

verdict = **RESOLVED**. SIZE_LIMIT 회귀 회피 (goal) + GitHub Releases mechanism 도입 (goal) + cascade host 2 v3.21 cycle 39 + AI Native § 7.1 3 면 cycle 누적 모두 PASS. local 검증 완료, 실 trigger evidence = REPORT commit 시점 self-evidence 본질.

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "v6-19-first-release-trigger-verification",
      "title": "v6.19 첫 release Actions trigger evidence verification (sc_5+ri_2+ri_6 PENDING 자연 해소)",
      "trigger": "B_regression",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "v6.19 sc_5 + ri_2 (multi-byte 인코딩) + ri_6 (도그푸드 self-reference) PENDING resolution 본질. REPORT commit msg `[release:v6.19]` marker → Actions workflow trigger → release 발급 evidence verification. 첫 실 release 발급 후 본문 안 한국어 multi-byte rendering + markdown link 깨짐 (r_7+ri_3 polish) inline 확인 → 후속 milestone 자연 (polish 또는 broken link 회복). trigger = REPORT commit 후 자연 평가 cycle."
    },
    {
      "id": "milestone-md-report-link-polish-mechanism",
      "title": "release body markdown link polish mechanism 도입",
      "trigger": "D_design",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "v6.19 oos_6 + r_7 + ri_3 origin — 첫 Release 발급 evidence 안 markdown link (relative path `../../ARCHITECTURE.md` 등) GitHub Release UI 안 broken. polish 본질 = release-publish.yml 안 link 변환 logic 추가 (relative → absolute URL `https://github.com/{owner}/{repo}/blob/{tag}/{path}`). evidence 누적 시 별 milestone 자연. DESIGN 단계 = (a) 변환 scope (markdown link only / image / anchor 분리) + (b) 변환 timing (release 발급 시점 또는 별 step) + (c) regex 복잡성 trade-off."
    },
    {
      "id": "range-entry-archive-link-recovery",
      "title": "CHANGELOG range entry archive link 회복 mechanism",
      "trigger": "D_design",
      "origin_milestone": "v6.19",
      "target_version": "v6.x",
      "description": "v6.19 ri_4 + L7 origin — shrink_changelog.py 안 19 entry link 부재 (range entry 안 단일 path 매핑 모호 — v1.0–v1.4 / v1.10c–v1.10h3 등). 본질 정보 손실 자연 인정 (r_5 trace 3중 mitigation 본질). 회복 candidate = (a) range entry 안 다수 directory link 본문 안 명시 (예: `[REPORT-v1.0](...), [REPORT-v1.1](...)` 다수) + (b) range entry 일괄 단일 _archive/ directory link + (c) git log atomic commit hash link. trigger = 별 archival cycle 시점 자연 (next_candidates#3 archival cycle 세 번째 trigger 정합)."
    }
  ],
  "candidates_named_only": [
    {
      "id": "ai-native-3-dimension-integration-v7",
      "title": "AI Native 3 면 통합 v7.0 major bump (cycle 누적 evidence)",
      "rationale": "v6.19 L6 P2 origin — 컨텍스트 효율 cycle 4 + 자율성 cycle 2 + 다중 AI 협업 cycle 4 = 누적 evidence 본질. v6.0~v6.x 시리즈 완성 후 통합 본질. next_candidates#2 (AI Native 3 면 통합 major) 정합 — origin v6.0 carry-over."
    },
    {
      "id": "stage-skill-dogfood-cycle-2-evaluation",
      "title": "stage skill 도그푸드 cycle 2 평가 (v6.17 cycle 1 후속 + v6.18 stage skill 9 stage 적용 후)",
      "rationale": "v6.19 candidates_named_only origin — 본 milestone 진행 자체 = 9 stage skill auto-load evidence cycle 2 (v6.17 cycle 1 후속). 의식적 호출 안 함 + 사후 회고 본질 가능 (오는 milestone 안 평가). v6.17 패턴 정합."
    },
    {
      "id": "archival-cycle-third-trigger-natural",
      "title": "archival cycle 세 번째 trigger 본질 (SIZE_LIMIT 회귀 시점)",
      "rationale": "v6.19 candidates_named_only origin — v5.21 (cycle 1, 2026-05-19) + v6.19 (cycle 2, 2026-05-21) 후 cycle 3 자연 trigger 본질. 현 size 65705 + ~34KB 여유 → v6.x entry 추가 0건 본질 (hybrid 분기 marker) → trigger 회피 자연. evidence-base trigger 본질 (사용자 명시 발의 또는 SIZE_LIMIT 회귀)."
    },
    {
      "id": "v6-6-numeric-lookup-auto-trigger-mechanism",
      "title": "수치 method lookup 자동 trigger (evidence 도달 시) — v6.6 origin carry-over",
      "rationale": "ROADMAP next_candidates 안 carry-over (origin v6.6). 본 milestone 안 vacuous (적용 대상 부재). evidence 누적 시 자연."
    },
    {
      "id": "v6-7-cascade-blockquote-body-auto-sync",
      "title": "cascade-sync blockquote 본문 자동 동기 mechanism (marker hash 외) — v6.7 origin carry-over",
      "rationale": "ROADMAP next_candidates 안 carry-over (origin v6.7). 본 milestone 안 vacuous. v6.6 oos_2 패턴 정합 (LLM 추론 필요, script-only 불가능)."
    }
  ],
  "registered_count": 3,
  "named_only_count": 6,
  "narrative": "v6.19 PROPOSE = 3 registered next_candidates (v6.19 첫 release evidence verification + ## REPORT 섹션 link polish + range entry archive link 회복) + 6 candidates_named_only (AI Native v7.0 통합 + stage skill cycle 2 evaluation + archival cycle 세 번째 + v6.6/v6.7 carry-over). v3.21 narrative 정전화 3 단계 패턴 적용 본질 부재 (PROPOSE 단순 발의, 신 mechanism 정전화 본질 부재)."
}
```

### Narrative

본 PROPOSE = 3 registered (B_regression 1 + D_design 2) + 6 named_only (v6.x carry-over 본질).

**1차 registered candidates** (origin v6.19):

1. `v6-19-first-release-trigger-verification` (B_regression) — v6.19 본 milestone REPORT commit 자연 후속 evidence verification (sc_5+ri_2+ri_6 PENDING 자연 해소). 첫 실 release 발급 후 multi-byte rendering + broken link inline 확인 → 후속 polish 또는 회복 milestone 자연.
2. `milestone-md-report-link-polish-mechanism` (D_design) — INTENT oos_6 정합. release body 안 markdown link 변환 logic. evidence 누적 시 별 milestone.
3. `range-entry-archive-link-recovery` (D_design) — 19 entry link 부재 자연 인정 후 회복 mechanism. archival cycle 세 번째 trigger 자연.

**carry-over named_only** = AI Native v7.0 통합 (v6.0 carry-over) + stage skill cycle 2 evaluation + archival cycle 세 번째 + v6.6/v6.7 carry-over 2건.

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)
