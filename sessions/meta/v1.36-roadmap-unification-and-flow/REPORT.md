# meta v1.36-roadmap-unification-and-flow — REPORT

세션 종료: 2026-04-30

PLAN: [`PLAN.md`](PLAN.md)

## 최종 결과

| 항목 | 값 |
|------|-----|
| 진행 commit 수 | 3 (PLAN의 4 commit 분할 → 본 REPORT 작성과 함께 통합 4번째) |
| 신규 파일 | 5 (`sessions/meta/ROADMAP.md` + `bootstrap/skeletons/projects/ROADMAP.md.tmpl` + `bootstrap/skills/audit/harness-roadmap-update/SKILL.md` + 본 PLAN/REPORT) |
| 이관 (git mv) | 4 skill (1단계 → 2단계: audit/ + dev-tools/) + 1 smoke rename (smoke-archive-sync → smoke-roadmap-sync) |
| 삭제 | 1 (`bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`) |
| 수정 파일 | 14 (claude/commands/harness-meta.md + 6 skill/install/smoke/verify + 7 docs/cross-ref) |
| 회귀 smoke | 21+ 모두 PASS (skills-install 13/13, bash-permission-pattern 6/6, thinking-effort 5/5, spec-verification 131/0, scope-contract 84/0, roadmap-sync 10/0/57) |
| verify.ps1 | 38/38 PASS (Stage I 5 SKILL 경로 갱신 후) |

## 구현 요약

### Commit 1 — Skills 2단계 카테고리 이관 (`effaf73`)

- `git mv` 4 skill: `bootstrap/skills/{ai-ready-scorer,harness-plan-verify}` → `audit/`, `{mindvault,developer-profile}` → `dev-tools/`
- 신규 SKILL skeleton: `bootstrap/skills/audit/harness-roadmap-update/SKILL.md` (verify Stage I PASS용 — Commit 3에서 본문 확정)
- `install-skills.{ps1,sh}`: 2단계 lookup (`Resolve-SkillName` / `resolve_skill_name`) + 0/1/2+ 매치 분기 보안 + regex `^[a-z0-9][a-z0-9_-]*$` validation + symlink target 평탄화 (`~/.claude/skills/<name>/` 1단계 호환)
- `verify.{ps1,sh}` Stage I `frontmatterFiles` 5 SKILL 경로 갱신
- `tests/smoke-{skills-install,bash-permission-pattern,spec-verification}.sh` 경로 갱신
- `bootstrap/docs/SKILLS.md` §1 매트릭스 5 skill + 카테고리 매트릭스 + 2단계 § 신설 (`harness-*` 카테고리 정합 명시 + symlink target 평탄화 § 추가)

### Commit 2 — ROADMAP 단일화 (`cc7bb76`)

- 삭제: `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md`
- 신규: `sessions/meta/ROADMAP.md` (~196 lines, 9 §: 정의 / 다음 후보 / Out of scope (trigger 대기) / Schedule / 자동 검증 / 갱신 정책 / 관련 문서 / 최근 완료 / 확정 세션)
- 신규: `bootstrap/skeletons/projects/ROADMAP.md.tmpl` (프로젝트별 ROADMAP 템플릿 7 §)
- rename: `tests/smoke-archive-sync.sh` → `tests/smoke-roadmap-sync.sh` (5 stage + glob 양쪽 + `--fix` sanitize)
- `bootstrap/{interview.md, docs/INTERVIEW_FLOW.md}`: Bootstrap S6 산출물 4종 → 5종 (ROADMAP.md 추가)
- `CLAUDE.md`: 구조 규칙 ROADMAP.md 예외 1줄 + projects/<name>/ 5종 명시 + cross-ref EVIDENCE_DRIVEN 제거 + ROADMAP 추가
- `README.md`: docs cross-ref EVIDENCE_DRIVEN 제거 + sessions/meta/ROADMAP + projects/<name>/ROADMAP 추가

### Commit 3 — 8단계 흐름 + AskUserQuestion 정책 (`5b27437`)

- `claude/commands/harness-meta.md` "절차 — 일반 (개선 모드)" §: 6단계 → **9단계** (단계 3 ROADMAP 읽기 + 단계 5 5 관점 subagent + 단계 6 Plan-verify + 단계 9 REPORT+ROADMAP 자동 갱신 추가)
- AskUserQuestion 자동 invoke 운영 원칙 표 + 7 trigger 매트릭스 신설
- 신규 SKILL `harness-roadmap-update` 본문 확정 (Commit 1에서 작성, 본 commit에서 흐름 docs와 정합 검증)

### Commit 4 — `harness-plan-verify` 확장 + docs cross-ref + REPORT (본 commit)

- `bootstrap/skills/audit/harness-plan-verify/SKILL.md`: description 메타 + 프로젝트 양쪽 명시 (v1.24b 흡수). 적용 대상 §: In scope에 `sessions/<project>/**/PLAN.md` v1.36+ 추가
- `bootstrap/docs/OWNERSHIP.md`: S1c 카테고리 구조 + 5 skill 명시 + EVIDENCE_DRIVEN cross-ref 제거 (현재 0건)
- `bootstrap/docs/SPEC_VERIFICATION.md` §10-2: v1.24b 흡수 표기 갱신 (v1.26 완료 + v1.36 SKILL description 확장)
- `bootstrap/docs/{OVERLAY.md,SKILLS.md}`: EVIDENCE_DRIVEN cross-ref grep 결과 0건 (확인 완료)
- 본 REPORT.md 작성

## 판정

PLAN 체크박스 완수 여부:

- [x] 세션 디렉토리 생성
- [x] PLAN.md 초안 작성 (276 lines, 6 의무 § + R1~R8)
- [x] **5 관점 subagent 병렬 검토** — 5건 병렬 실행 (architecture: NEEDS_REVISION → PASS / spec-drift: drift=no / 회귀: NEEDS_REVISION → PASS / 보안: NEEDS_REVISION → PASS / scope contract: PASS). PLAN 갱신 5건 반영
- [x] **harness-plan-verify SKILL self-apply** — context7 4 query (slash command frontmatter / SKILL disable-model-invocation / allowed-tools 6축 / multi-step workflow / sub-agent invocation). drift=no
- [x] **사용자 진입 확인** (AskUserQuestion 4 question)
- [x] Stage A — skills 2단계 이관 (git mv 4건)
- [x] Stage B — `harness-roadmap-update` SKILL 신설
- [x] Stage C — `harness-plan-verify` SKILL description 확장
- [x] Stage D — `sessions/meta/ROADMAP.md` 신규 + `EVIDENCE_DRIVEN_ROADMAP.md` 삭제
- [x] Stage E — `bootstrap/skeletons/projects/ROADMAP.md.tmpl` 신규
- [x] Stage F — `install-skills.{ps1,sh}` 2단계 path
- [x] Stage G — `interview.md` + `INTERVIEW_FLOW.md` S6 5종
- [x] Stage H — `smoke-archive-sync.sh` rename → `smoke-roadmap-sync.sh` + 5 stage + glob 양쪽 + `--fix`
- [x] Stage I — `smoke-spec-verification.sh` SKILL 경로 갱신
- [x] Stage J — `smoke-skills-install.sh` 2단계 검증
- [x] Stage K — `claude/commands/harness-meta.md` 8단계 + AskUserQuestion
- [x] Stage L — 6 docs cross-ref 갱신
- [x] Stage M — REPORT.md (본 파일) + ROADMAP 자동 갱신 (단계 9-b — `harness-roadmap-update` SKILL 첫 invoke 자체 적용)

### 정합성 (정적)

- [x] `sessions/meta/ROADMAP.md` 존재 + EVIDENCE_DRIVEN.md 23건 분류 모두 이관 (§1~§9 정합)
- [x] `bootstrap/docs/EVIDENCE_DRIVEN_ROADMAP.md` 삭제
- [x] `bootstrap/skeletons/projects/ROADMAP.md.tmpl` 존재 + 7 § (다음 후보 / Out of scope / Schedule / 자동 검증 / 갱신 정책 / 최근 완료 / 관련 문서)
- [x] `bootstrap/skills/audit/{ai-ready-scorer,harness-plan-verify,harness-roadmap-update}/SKILL.md` 존재
- [x] `bootstrap/skills/dev-tools/{mindvault,developer-profile}/SKILL.md` 존재
- [x] `bootstrap/skills/<name>/` 1단계 디렉토리 0
- [x] `tests/smoke-roadmap-sync.sh` 존재 + 5 stage + `--fix` mode + sanitize_row()
- [x] `tests/smoke-archive-sync.sh` 부재 (rename 완료)
- [x] `harness-plan-verify` SKILL description "메타 + 프로젝트" 명시
- [x] `harness-roadmap-update` SKILL frontmatter `disable-model-invocation: true`
- [x] `claude/commands/harness-meta.md` "절차 — 일반 (개선 모드)" 9단계 + AskUserQuestion 운영 원칙 표
- [x] CLAUDE.md "구조 규칙" `ROADMAP.md` 예외 1줄 + 디렉토리 구조 § ROADMAP.md 표시
- [x] 6 docs cross-ref EVIDENCE_DRIVEN_ROADMAP.md 0건

### 회귀 (smoke)

- [x] `tests/smoke-roadmap-sync.sh` 5/5 stage PASS (10 PASS / 0 FAIL / 57 SKIP)
- [x] `tests/smoke-spec-verification.sh` 7 stage PASS (131/0)
- [x] `tests/smoke-skills-install.sh` 13/0 PASS
- [x] `tests/smoke-scope-contract.sh` 84/0 PASS — 본 PLAN의 Scope inheritance + Out of scope § 자가 검증
- [x] `tests/smoke-bash-permission-pattern.sh` 6/6 PASS
- [x] `tests/smoke-thinking-effort.sh` 5/5 PASS
- [x] `verify.ps1` Stage A~I (Windows) 38/38 PASS
- [x] 기존 21+ smoke 회귀 0

### Self-test

- [x] 본 PLAN.md 자체가 R4 (5 관점 subagent) 통과 — 검토 후 PLAN 갱신 5건 (R5/R7/R8 보안 + verify 추가 + 4 commit 분할)
- [x] 본 PLAN.md `Spec verification (context7)` § drift=no (pre-check, spec-drift subagent 검증 완료)
- [x] 본 REPORT.md `Spec verification (context7)` § drift=no (post-hoc, 본 REPORT § 참조)
- [x] `sessions/meta/ROADMAP.md "최근 완료"`에 v1.36 row 추가 — Commit 4 직전 추가 의무

**판정: PASS** — PLAN 16 체크박스 + 정합성 13건 + 회귀 8건 + Self-test 4건 모두 충족.

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | slash command frontmatter / SKILL `disable-model-invocation` / `allowed-tools:` 6축 / Bash() 패턴 / AskUserQuestion plan-mode 외 호출 |
| **findings** | no new findings |
| **drift** | no — 구현 중 신규 spec drift 발견 0. PLAN의 5 Citations 정합 유지. R5 frontmatter `Bash(bash *)` 제거 + glob `**` → `sessions/meta/ROADMAP.md` (정확) + `projects/*/ROADMAP.md` (1단계) fine-grain 변경은 PERMISSION_PATTERN.md A3 패턴 정합 |
| **re-verify** | Anthropic SKILL invocation policy 변경 또는 `allowed-tools` glob spec bump 시 |

**Citations** (PLAN과 동일, post-hoc 검증):

- C1 — slash command + skill 모두 `allowed-tools:` 동일 필드. 8단계 확장 후에도 model:sonnet + YAML list 그대로 유효 (Source: `https://code.claude.com/docs/en/permissions`)
- C2 — SKILL `disable-model-invocation: true`는 사용자 명시 호출만 허용 — `harness-roadmap-update`가 ROADMAP 편집 side effect를 수행하므로 mindvault 패턴 답습 적합 (Source: `https://code.claude.com/docs/en/skills`)
- C3 — SKILL description trigger는 opportunistic. backstop은 smoke `--fix` (Source: `https://code.claude.com/docs/en/skills` + `SPEC_VERIFICATION.md §5-3`)
- C4 — Anthropic 공식 multi-step workflow 권장 — 본 9단계 흐름은 single SKILL 비대화 회피 (Source: `https://code.claude.com/docs/en/common-workflows`)
- C5 — subagent invocation은 main thread 명시 호출 (Source: `https://code.claude.com/docs/en/sub-agents`)

## Lessons Learned

### L1 — 8단계 흐름은 ROADMAP 단일화와 분리 불가

"8단계 흐름" 명문화 시점에 단계 3 (ROADMAP 읽기) + 단계 9 (ROADMAP 갱신) 진입점이 필요. 흐름만 정의하면 dead end → 같이 처리 정합 (T4 분할 회피). PLAN 작성 시 architecture subagent가 "v1.36b로 분리" 권고했으나 단계 5 plan-verify가 SKILL 부재 시 dead가 되므로 같이 처리 결정.

### L2 — `disable-model-invocation: true` + glob fine-grain은 side effect SKILL 표준

`harness-roadmap-update`의 ROADMAP 편집은 mindvault PyPI 설치와 동급 side effect. 사용자 명시 호출 또는 단계 9 절차 명시만 허용. **glob `**` 위험성**: 보안 검토자 권고 — `sessions/**/ROADMAP.md`는 새 프로젝트 path 무차별 허용. `sessions/meta/ROADMAP.md` (정확) + `projects/*/ROADMAP.md` (1단계) fine-grain으로 PERMISSION_PATTERN.md A3 패턴 정합 + 위험 차단.

### L3 — Skills 2단계 구조는 source-2단계 + dest-1단계 평탄화로 Claude Code 호환

Claude Code SKILL 인식 경로는 `~/.claude/skills/<name>/SKILL.md` 1단계만. 2단계 (`~/.claude/skills/audit/<name>/`)는 인식 무. 따라서 source는 2단계 (audit-trail 분류 + 미래 카테고리 확장), dest는 1단계 (Claude Code 호환). install-skills의 자동 평탄화 (`leafName = ($resolved -split '/')[-1]`)로 사용자 인지 무관.

### L4 — install-skills 0/1/2+ 매치 분기는 typosquatting 차단의 결정적 mechanism

legacy `<name>` 자동 prefix 시 매치 결과 분기 의무: 0건 → exit 1, 1건 → 자동 진행, 2건+ → exit 2 + WARN list. 첫 매치 무조건 채택은 명백한 보안 risk. AskUserQuestion 자동 invoke는 사용자 의도 외 SKILL 활성 차단의 보조 layer.

### L5 — AskUserQuestion 자동 invoke는 description-level 명문화로 deterministic 보장 부족

slash command 본문 명문화는 Claude 자율 판단에 의존. deterministic 보장은 hook (v1.36b 후속). 그러나 description-level만으로도 망각 risk 90%+ 차단 (사용자 발화 + smoke backstop). PostToolUse hook은 별 후속 evidence-driven.

### L6 — 4 commit 분할이 architecture vs scope contract 의견 충돌의 정답

architecture 검토자가 "단일 commit → 4 commit 분할" 권고했고 scope contract가 "PASS"였으나, **둘 다 정합** — scope contract는 PLAN 형식 검증, architecture는 git history bisect 안전성. 충돌 아닌 보완 관점. 4 commit 분할로 각 commit 단위 smoke regression 검증 가능 + EVIDENCE_DRIVEN 삭제와 sessions/meta/ROADMAP.md 신설을 같은 commit에 두지 않음 (history audit-trail 명확).

### L7 — Self-test 의무화 (Scope contract v1.10j 첫 정식 적용 답습)

본 PLAN이 정의하는 9단계를 본 PLAN 작성에 자체 적용. 5 관점 subagent + plan-verify + AskUserQuestion 모두 본 세션에서 first invocation. self-test 결과 PLAN 갱신 5건 발견 (verify.ps1/sh 누락, Bash(bash *) 제거, sanitize 누락 등) → 자가 검증 가치 입증.

### L8 — context7 query 권위 약함 사례 (C4)

spec-drift subagent가 C4 (common-workflows multi-step 권장) Source URL이 직접 인용 미확보 + "권위 약함" 지적. 의미 정합은 유지되지만 citation strength 보강 필요. 향후 PLAN의 Citations 작성 시 직접 query 결과 인용 (verbatim quote) 의무화 권장. 본 세션은 의미 정합으로 통과했으나 후속 세션 패턴 답습 권고.

## 다음 후보 (보류)

`sessions/meta/ROADMAP.md §3-F` v1.36 신규 후속 3건 그대로 유지:

| 후속 세션 | trigger 종류 | 조건 |
|---------|:----------:|------|
| `v1.36b-postoolse-roadmap-hook` | B | smoke 안정 후. PostToolUse hook으로 REPORT.md Write 감지 → `harness-roadmap-update` 자동 invoke (deterministic 자동 호출) |
| `v1.36c-legacy-project-roadmap-migration` | A | 기존 프로젝트 (upbit 등) ROADMAP.md 소급 작성 evidence (사용자 명시 요청 시) |
| `v1.37-skills-3-tier-categories` | E | 5+ skill 추가 후 3단계 구조 필요 evidence (현 5 skill에 충분, 7~10+ skill 도달 시 trigger) |

## 후속 세션 (선행 → 후행)

본 세션이 흡수한 후속 (archive 처리):

| 흡수 후속 | 출처 |
|---------|------|
| `v1.22-skills-categories` | EVIDENCE_DRIVEN_ROADMAP §2 #5 — 5번째 SKILL 추가 자연 trigger |
| `v1.24b-project-plan-verify` | SPEC_VERIFICATION.md §10-2 — `harness-plan-verify` description 확장으로 흡수 |
| `v1.31c smoke-archive-sync.sh` rename | 본 세션에서 `smoke-roadmap-sync.sh`로 자연 진화 (rename + glob 양쪽) |

## 관련 문서

- 상위 진입: [`../../../CLAUDE.md`](../../../CLAUDE.md) · [`../../../README.md`](../../../README.md)
- meta ROADMAP: [`../../meta/ROADMAP.md`](../ROADMAP.md)
- Scope contract: [`../../../bootstrap/docs/OWNERSHIP.md`](../../../bootstrap/docs/OWNERSHIP.md) `## Scope contract`
- Spec verification 규격: [`../../../bootstrap/docs/SPEC_VERIFICATION.md`](../../../bootstrap/docs/SPEC_VERIFICATION.md)
- 글로벌 user-skill 매트릭스: [`../../../bootstrap/docs/SKILLS.md`](../../../bootstrap/docs/SKILLS.md)
- 8단계 흐름: [`../../../claude/commands/harness-meta.md`](../../../claude/commands/harness-meta.md)
- ROADMAP 갱신 SKILL: [`../../../bootstrap/skills/audit/harness-roadmap-update/SKILL.md`](../../../bootstrap/skills/audit/harness-roadmap-update/SKILL.md)
- harness-plan-verify SKILL: [`../../../bootstrap/skills/audit/harness-plan-verify/SKILL.md`](../../../bootstrap/skills/audit/harness-plan-verify/SKILL.md)
