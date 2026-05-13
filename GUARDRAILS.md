# GUARDRAILS — harness-meta repo 자체 행동 가드레일

본 파일은 `~/harness-meta/` repo **자체 개선 milestone** (`/harness-meta` 또는 `/harness-meta meta` 진입) 시 AI 에이전트가 따를 행동 규칙의 **단일 소스**다.

> **스코프 구분**:
>
> - 본 GUARDRAILS.md = **메타 repo 자체** milestone (`projects/meta/milestones/v{X.Y}_{slug}/`) 진행 시
> - 프로젝트 repo의 `docs/GUARDRAILS.md` (manifest의 `[harness].guardrails`) = **각 프로젝트 milestone-level** 주입용
> - 둘은 **독립**. 본 파일은 프로젝트 repo에 배포되지 않음

---

## 1. 목적

- 메타 repo는 **모든 다운스트림 프로젝트에 영향**을 미치는 글로벌 layer (`claude/**`) + bootstrap 자산 (`bootstrap/skills/**`)을 보유
- 한 번의 잘못된 변경이 **다중 프로젝트 회귀**로 확산
- AI 에이전트가 매 milestone 위험 작업 패턴을 재발견하지 않도록 **사전 명시 규약** 제공
- 본 파일은 INTENT.md 작성 단계 (v2.0+ 9-stage; 7-stage era 보존 milestone 은 PLAN.md) + DESIGN.md 결정 단계 + APPROVE.md 게이트 단계에서 자동 참조 (INTENT/PLAN.success_criteria / out_of_scope / dependencies 의무 3 필드 + APPROVE.md / DESIGN.approval gate 와 함께)

> **하네스 엔지니어링 정의** (정전 single source): [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑.

---

## 2. 금지 행동 (Hard rules)

다음은 **명시적 사용자 승인 없이 절대 수행 금지**.

| # | 금지 행동 | 이유 |
|---|----------|------|
| H1 | 기 완료 milestone 의 산출물 직접 수정 — v3.0+ 9-stage-bundled: `{INTENT,RESEARCH,DESIGN,APPROVE,VERIFY,REPORT,PROPOSE}.md` + `milestones.md`; v2.0~v2.1 9-stage: 7 산출물 (milestones.md 부재); 7-stage era v1.0~v1.4 보존: `{PLAN,RESEARCH,DESIGN,VERIFY,REPORT}.md`; `execute/phase-{n}.md` 공통 | 이력 보존 — 정정은 신규 milestone 으로 |
| H2 | `git commit --amend` (published 커밋) | 이력 무결성 — pre-commit hook 실패 시 신규 commit으로 fix |
| H3 | `git push --force` (main branch) | 다른 사용자 작업 손실 위험 |
| H4 | `--no-verify` / `--no-gpg-sign` flag 사용 | pre-commit / signing 우회 = repo 정책 무력화 |
| H5 | `~/.claude/plugins/cache/harness-meta/` 또는 `~/.claude/` 직접 편집 | v5.0+ 글로벌 layer 는 Plugin install lifecycle (`claude plugin install/uninstall/enable/disable`) 으로만 갱신 — 직접 수정 시 다음 plugin install 또는 reinstall 로 손실. ((Deprecated since v5.0, v5.0+ 환경에서는 비활성) v4.x D7 5 step sequence (Backup → OS detect → SymbolicLink/Junction → Copy fallback → Cleanup) 안 `~/.claude/{commands,hooks,statusline}/` 매핑 narrative — historical 만 보존) |
| H6 | 외부 프로젝트 repo (upbit 등) 에 직접 commit | 해당 프로젝트 repo의 자체 milestone (`milestones/v{X.Y}_{slug}/`) 으로 분리 — 메타 milestone 안에서 외부 repo commit 금지 |
| H7 | `.harness.toml` schema **breaking change** without major bump | SemVer 위반 — minor bump (additive only) 만 허용. breaking 은 `2.0` major bump |
| H8 | APPROVE.md (`approval.approved_by: "user"` + `date: YYYY-MM-DD`) 부재 상태로 EXECUTE 진입 — v2.0+ 9-stage; 7-stage era 보존 milestone 은 DESIGN.approval 동치 | 정의 § 3.3 매트릭스 'Constraint' 정전 메커니즘 위반 — 사용자 명시 승인 게이트 강제 |

---

## 3. 위험 작업 (Confirmation 의무)

다음 변경은 **PLAN.md 의 `out_of_scope` / DESIGN.md 의 `decisions` 안에 명시 + 사용자 사전 승인** 후 진행.

| # | 위험 작업 | 영향 범위 |
|---|----------|----------|
| C1 | `claude/**` 변경 (글로벌 layer — `commands/`, `hooks/`, `statusline/`) | 모든 사용자 — v5.0+ `.claude-plugin/plugin.json` paths 명시 안 Plugin install 후 자동 인식 (Claude Code 재시작 또는 `claude plugin enable` 시 즉시 반영) |
| C2 | `bootstrap/skills/**` 변경 | 글로벌 user-skill — v5.0+ Plugin install 환경 안 `.claude-plugin/plugin.json` `skills` add-to-default paths 자동 인식. v4.x `install-skills.{ps1,sh}` 폐기 (deprecated since v5.0, v5.0+ 환경에서는 비활성) |
| C3 | 파일 5+ 동시 변경 | scope drift 의심 신호 — PLAN.out_of_scope 표 재확인 + DESIGN.phases.affected_files 화이트리스트 강제 |
| C4 | 신규 major bump 진입 — v3.0+ 9-stage-bundled: `projects/meta/milestones/v{X+1}.0/` (sub-id 부재) / 보존 era: `milestones/v{X+1}.0_{slug}/` | breaking change 가능성 — 마이그레이션 가이드 작성 의무 (REPORT.lessons_learned). 사례: v3.0_milestones-restructure (ROADMAP schema + 디렉토리 구조 변경, semver 정합) |

---

## 4. Scope contract 의무 (v2.0+ 9-stage / v3.0+ 9-stage-bundled)

모든 INTENT.md (7-stage era 보존 milestone 은 PLAN.md) 의 JSON 본문은 다음 **3 필드 의무**:

1. **`success_criteria`** (관측 가능한 결과 list) — milestone 완료 검증 기준
2. **`out_of_scope`** (명시적 제외 list) — 인접 발견 issue 의 표 명시. 빈 list = "없음" 명시 선언 / 부재 = 규약 위반
3. **`dependencies`** (`predecessors` / `successors_anticipated`) — 선행/후행 milestone 매핑

DESIGN.md 의 JSON 본문 (decisions / approach / phases / risk_mitigation) 은 v2.0+ 부터 approval 필드 분리 — APPROVE.md 가 별 stage 산출:

4. **APPROVE.md** = `{ "approval.approved_by": "user", "date": "YYYY-MM-DD", "approval_summary": "..." }` — EXECUTE phase-{n}.md commit 진입 게이트. 부재 시 H8 위반. 7-stage era 보존 milestone 은 DESIGN.approval 동치.

**위반 정책**:

- 3 필드 (success_criteria / out_of_scope / dependencies) 중 하나라도 누락 → `tests/smoke-spec-verification.sh` + `tests/smoke-scope-contract.sh` 가 차단 (pre-commit hook)
- `success_criteria` 에 없는 항목을 EXECUTE 단계 본문에서 구현 → over-scope, `out_of_scope` 표로 이관 후 재확인 (post-hoc 허용, 사후 누락 금지)
- 구현 중 신규 발견 issue → `out_of_scope` 표 즉시 갱신 (post-hoc 허용)

---

## 5. Smoke 회귀 의무

- `tests/smoke-*.sh` 영향 변경 시 **본 milestone 안에서 PASS 확인 후 commit** (각 phase commit 전 pre-commit hook 자동 실행)
- CI (`.github/workflows/ci.yml`) 실패 시 **force-merge 금지** — 사용자 명시 승인 외
- 신규 도메인 추가 시 smoke 신설 권장 (e.g., `tests/smoke-{domain}.sh`)
- 기존 smoke 변경 시 PLAN.md `success_criteria` 또는 DESIGN.md `phases.affected_files` 에 명시 + VERIFY.md `smoke_tests` 결과 기록

---

## 6. References

- 변경 이력: [`CHANGELOG.md`](CHANGELOG.md)
- 메인 진입점: [`CLAUDE.md`](CLAUDE.md) · [`README.md`](README.md) · [`AGENTS.md`](AGENTS.md)
- 정의 host: [`projects/meta/ARCHITECTURE.md`](projects/meta/ARCHITECTURE.md) § 3
- 9-stage workflow 진입점 (v2.0+): [`claude/commands/harness-meta.md`](claude/commands/harness-meta.md)
- 메타 milestone trace: [`projects/meta/milestones/`](projects/meta/milestones/)

---

## Evolution

본 가드레일은 **규약 위반 사례**가 발생할 때마다 신규 룰 추가 또는 기존 룰 명료화 방식으로 진화한다. 변경은 `projects/meta/milestones/v{X.Y}_guardrails-{topic}/` 별개 milestone 으로 수행.
