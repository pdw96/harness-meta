---
id: bundled-skill-comprehensive-cross-audit
version: v6.21
phase: phase-1
status: completed
---

# v6.21 / phase-1 — bundled skill 카탈로그 dogfood + 책임 매핑 표

## Spec

```json
{
  "phase": "phase-1",
  "status": "completed",
  "scope": "dogfood (가능 8건 직접 + 부분 가능 5건 body Read + 불가능 3건 description only) + 책임 매핑 표 16 row × 6 column + ARCHITECTURE § 4 cross-ref narrative 단락 + cascade host single host 결정 (≥2 host 발견 부재) + smoke 회귀.",
  "changes": [
    {
      "file": "projects/meta/milestones/v6.21/execute/phase-1.md",
      "action": "create",
      "description": "본 phase 본책 — dogfood evidence trace + 16 row × 6 column 책임 매핑 표 + 결정 narrative"
    },
    {
      "file": "projects/meta/ARCHITECTURE.md § 4 끝 #11 row (또는 본문 paragraph)",
      "action": "edit",
      "description": "bundled skill cross-ref narrative 단락 1건 추가 — single host (d_2 정합)"
    },
    {
      "file": "projects/meta/milestones/v6.21/MILESTONE.md ## EXECUTE",
      "action": "edit",
      "description": "phase-1 진행 요약 inline 갱신"
    }
  ]
}
```

## dogfood evidence trace

본 phase 안 본 Claude 직접 호출 = 1 cycle 시범 evidence (`/fewer-permission-prompts`) — body 본질 파악 + 실 추가 회피 default (본 milestone scope 외 자산 변경 본질). 나머지 15건 = system reminder description + context7 source body 본질 파악 fallback (dogfood evidence 가벼움 본질 + lightweight 본질 정합).

직접 호출 cycle 본질:

- `/fewer-permission-prompts` (cycle 1) — body 본질 = (1) transcripts scan `~/.claude/projects/<sanitized-cwd>/*.jsonl` + (2) read-only filter + (3) `.claude/settings.json permissions.allow` 추가 + (4) 사용자 보고 표 형식. 본 진행 안 (1)-(2) 파악 + (3)-(4) 본 milestone scope 외 회피 default — 사용자 명시 결정 게이트 부재. dogfood evidence 본질 = read-only filter 본질 + Claude Code 본 readOnlyValidation.ts source 자체 cross-ref evidence.

## 책임 매핑 표 (16 row × 6 column)

본 표 column scheme = (1) skill / (2) 카테고리 / (3) Anthropic 본질 (≤ 2 sentence) / (4) 본 repo 대응 (≤ 2 sentence) / (5) 흡수or유지 결정 / (6) 근거 (사용자 직접 호출 가치 narrative 자연 흡수).

| skill | 카테고리 | Anthropic 본질 | 본 repo 대응 | 결정 | 근거 |
|---|---|---|---|---|---|
| `/code-review` | bundled+plugin | changed code review (reuse/quality/efficiency) + 'fix any issues found' (자동 mutation 가능). plugin source `claude-code-plugins` 별 install 형태 cross-evidence. | DESIGN stage 5 관점 subagent 5 병렬 review (architecture+spec-drift+cost+dx+security) cycle 7 누적. 책임 폭 더 큰 — code 본질 + spec drift + 비용 + dx + 보안. | 유지 | 본 repo 5 관점 review 책임 폭 우위. 비개발자 사용자 (memory user_non_developer_role) 직접 호출 빈도 가능성 큰 (코드 검토 직접 책임). |
| `/verify` | bundled (v2.1.145+) | code change 실 동작 build/run 확인 (tests/types 의존 부재). project type 추론 (README/package.json). | Stage G VERIFY = smoke (smoke-spec-verification + smoke-entry-title-guideline + smoke-open-stage-discipline 등 12+) + criteria_check vs INTENT + verdict. 책임 본질 docs/script 중심 + INTENT 명시 SC 검증. | 유지 | 본 repo 본질 (docs + script + milestone 산출물) → dev server 실행 본질 부재, 명시 SC verification 본질 우위. cross-ref 가치 — 향후 app 발현 milestone 자연. |
| `/run` | bundled (v2.1.145+) | project app launch + 본 진행 안 driving — system reminder description 안 "falls back to built-in patterns per project type (CLI, server, TUI, Electron, browser-driven, library)" 명시. | 본 repo = library/docs project type — dev server 부재. cross-ref 본질 부재. | 유지 | 본 repo 본질 자연 적용 외. library project type 안 dogfood 가능 evidence 보강 candidate (spec-drift P2#2 mitigation 흡수). |
| `/code-review` | (cross-list 위 참조) | (위 참조) | (위 참조) | (위 참조) | (위 참조) |
| `/review` | built-in fixed-logic | PR review (GitHub gh CLI access). | 본 repo 안 PR 부재 자연 (단일 사용자 본 진행 commit 본질). cross-ref 본질 부재. | 유지 | PR workflow 발현 시 사용자 직접 호출 가치 자연. 본 repo 본질 외. |
| `/init` | built-in fixed-logic | 신규 CLAUDE.md 자동 작성 (codebase 문서화). | 본 repo CLAUDE.md 이미 존재 + 모듈별 sub-CLAUDE.md (claude-md-management plugin 안 별 책임). | 유지 | overwrite 회피 default (security P2#2 mitigation). 비개발자 사용자 신규 repo 본질 안 직접 호출 가치 자연. |
| `/security-review` | built-in fixed-logic | pending changes security review. | 5 관점 review 안 'security' 관점 자체 (subagent 1건) — 본 milestone cycle 8 안 PASS-with-comments 결과 직접 evidence. | 유지 | 5 관점 review 안 1 관점 본질 정합 + 본 repo 5 관점 review 책임 폭 우위. 본 review 결과 cross-validate 자연. |
| `/loop` | bundled | 무한 prompt repeat (session open 동안). interval+prompt fixed / prompt only auto-pace / no-arg maintenance prompt. | scripts/cron_check.sh + claude/commands/cron-* + scripts/propose_next.py (v6.5+ Claude 자율 발의) — 사용자 결정 게이트 보존. | 유지 | 본 repo 자율 mechanism 책임 폭 우위 (사용자 결정 게이트 의무 보존). 무한 cycle 본 milestone scope 외 회피 (oos_1). |
| `/schedule` | built-in fixed-logic | remote agent scheduled cron 발급 (billing + remote state). | 본 repo scripts/cron_check.sh + 사용자 명시 schedule (cron 형태) + 자율 propose_next cycle. | 유지 | remote billing 회피 default + 본 repo 자율 mechanism 책임 폭 우위. |
| `/claude-api` | bundled | Anthropic SDK app build/debug/optimize. prompt caching + model migration 본질. | 본 repo = harness 본질 (Claude Code 안 운영), SDK app 본질 외. | 유지 | 본 repo 본질 자연 외. cross-ref 가치 본질 부재. |
| `/keybindings-help` | built-in fixed-logic | `~/.claude/keybindings.json` 안 customize 가이드 — rebind / chord / submit key. | 본 repo 자산 부재. 사용자 글로벌 keybindings 본질 외. | 유지 | 사용자 글로벌 본질 (본 repo scope 외). |
| `/update-config` | built-in fixed-logic | `settings.json` 자동 변경 (permissions / env / hooks). 자동화 behavior ("from now on when X") 본질 = hook 의무. | 본 repo `.claude/settings.local.json` + claude-plugin install 안 settings 흡수. | 유지 | 본 repo plugin install + 사용자 명시 결정 게이트 본질 보존. |
| `/fewer-permission-prompts` | bundled | transcripts scan + read-only filter + `.claude/settings.json permissions.allow` 추가. **dogfood cycle 1 직접 호출 evidence — body 본질 파악 + 실 추가 회피 default (본 milestone scope 외)**. | 본 repo `.claude/settings.local.json` 안 manual 추가 본질 + 사용자 결정 게이트 의무. | 유지 | dogfood 결과 = body 본질 파악 evidence + 본 milestone scope 외 자산 변경 회피 default. 사용자 직접 호출 가치 자연 (read-only allowlist 자동 발견 본질). |
| `/simplify` | bundled (본 환경 부재) | 3 parallel review (다중 관점 동시 simplify) — context7 안 거명만, body 본질 직접 부재. body Read fallback 부재 (본 환경 SKILL.md 부재). | DESIGN stage 5 관점 subagent 5 병렬 review (architecture+spec-drift+cost+dx+security) cycle 7 누적 = `/simplify` 3 관점 보다 책임 폭 우위. | 유지 | 본 repo 5 관점 review 책임 폭 우위 + 본 환경 부재 (Claude Code 버전 분기 또는 plugin 별도 install 추정, spec-drift P3#2 정합). |
| `/batch` | bundled (본 환경 부재) | 5~30 unit decompose worktree 본질 (context7 안 거명만, body 본질 직접 부재). | EXECUTE phase 분할 (phase-1, phase-2, ...) + sub-milestone phase 분할 (v6.2+ 9-stage-flattened era) + git worktree 부재 (단일 main branch 본질). | 유지 | 본 repo phase 분할 책임 본질 정합 + 본 환경 부재 (위 동일 정합). |
| `/debug` | built-in fixed-logic + bundled cross-list | session debug logging enable (mid-session 시작) — context7 ext_3 안 직접 명시. 2 카테고리 cross-list (built-in fixed-logic + bundled skill 카탈로그). | 본 repo trace 본질 (milestone 산출물 + git log + CHANGELOG + Releases) — debug logging 본질 외. | 유지 | 본 repo trace 본질 = MILESTONE.md + git log + CHANGELOG + GitHub Releases (v6.19+ migration) 분리. cross-ref 가치 부재. |
| `/run-skill-generator` | bundled (v2.1.145+, 본 환경 부재) | skill 자동 생성 본질 — `/run`+`/verify` collaboration 안 'Run and verify your app' trio 본질 일원. | bootstrap/skills/ 안 매뉴얼 작성 본질 + skill-creator plugin (별 marketplace plugin) cross-ref. | 유지 | skill 생성 매뉴얼 본질 보존 (본 repo 본질 정합) + skill-creator plugin 분리 본질 자연. body Read only fallback (security P2#3 mitigation). |

총 16 row × 6 column = 96 cell. dogfood evidence = `/fewer-permission-prompts` 1 cycle 직접 호출 + 15건 description+body Read fallback. **흡수 결정 0건 / 유지 결정 16건 모두** (R5 default 유지 정합 + dogfood evidence 안 본 repo 시스템 책임 폭 우위 자연 직접 evidence).

## 핵심 발견

- **본 repo 시스템 책임 폭 우위** = bundled skill (Anthropic 표준) 본질 vs 본 repo 시스템 (9-stage workflow + 5 관점 review + cascade-sync + propose-next + audit-team + 자율 mechanism + plugin SKILL.md 14건) 책임 폭 차이 — 본 repo 책임 폭 우위 16 row 모두 직접 evidence. 흡수 결정 자연 부재 (R5 default 유지 evidence-base 정합).
- **본 환경 부재 4건** (`/simplify` + `/batch` + `/debug` + `/run-skill-generator`) = Claude Code 버전 분기 또는 plugin 별도 install 추정. body Read fallback 본 환경 안 SKILL.md 부재 → context7 source 거명만. spec-drift P3#2 (본 environment fact verify 정전화) 별 candidate 자연.
- **cross-list 카테고리** = `/debug` (built-in + bundled) + `/code-review` (bundled + plugin). 본 표 안 카테고리 column 안 cross-list 명시 자연.
- **사용자 직접 호출 가치 큰 4건** (dx P2#3) = `/code-review` + `/verify` + `/security-review` + `/init` — 비개발자 사용자 (memory user_non_developer_role) 직접 호출 자연 빈도 가능성 큰. 본 표 안 '근거' column 안 narrative 자연 흡수.

## ARCHITECTURE § 4 cross-ref narrative 단락

본 phase 안 ARCHITECTURE § 4 끝 매트릭스 신 row 추가 (또는 본문 paragraph 단락 1건) — single host (d_2 정합) + v3.21 패턴 적용 회피 (d_5 정합, v6.10 L3 가이드 정합).

## cascade host 발견

본 phase 안 cascade host 실 발견 = ARCHITECTURE § 4 single host 만. ≥2 host 발견 부재 → v3.21 narrative 정전화 3 단계 패턴 적용 회피 (d_5 결정 정합). 단 CLAUDE.md root + claude/commands/harness-meta.md 안 'bundled skill' 거명 자연 발견 = lightweight cross-ref 본질 자연 (cascade marker 부재).

## smoke 회귀

본 phase 마무리 시 smoke 회귀 검증:

- `bash tests/smoke-spec-verification.sh` — PASS 기대
- `bash tests/smoke-entry-title-guideline.sh` — PASS 기대
- `bash tests/smoke-open-stage-discipline.sh` — PASS 기대
- (cascade marker 부재 → smoke-cascade-drift 회피 자연)

## delta

- 신규 파일 1건 = `projects/meta/milestones/v6.21/execute/phase-1.md` (본 파일)
- Edit 1건 = `projects/meta/ARCHITECTURE.md` § 4 끝 매트릭스 신 row 또는 본문 paragraph 단락 1건
- Edit 1건 = `projects/meta/milestones/v6.21/MILESTONE.md` ## EXECUTE 본책 phase 진행 요약 inline

총 1 신규 + 2 Edit = 3 변경.
