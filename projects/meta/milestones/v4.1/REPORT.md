---
id: install-strategy-reaudit
title: REPORT v4.1
version: v4.1
stage: REPORT
status: completed
---

# REPORT — v4.1

## Spec

```json
{
  "summary": "v4.1 milestone 은 install 전략 자체 재검토 — Windows Developer Mode 강제 chain 분석 후 Option D (NTFS junction Windows default + symlink Linux/macOS) 채택, D7 mechanical sequence 4 step → 5 step rewrite (OS detect step 신규 + Primary attempt by OS 분기 + NTFS same-volume 강제 narrative + ad-hoc 검증 권고), cascade narrative 12 host 정합 (README + AGENTS + root CLAUDE.md + claude/CLAUDE.md + claude/commands/harness-meta.md + GUARDRAILS + bootstrap/agents/CLAUDE.md [phase-1 단일 source] + bootstrap/skills/CLAUDE.md [cross-ref 보존] + ARCHITECTURE.md [D9 정합 보존] + Makefile + .env.example + verify-lib.ps1 + verify.ps1 + verify.sh), stale install.ps1 거명 9건 추가 cleanup (RESEARCH 외 잠재 발견), verify A1 check info-level 격하 (Junction default 시 Developer Mode 불요, Check-Info 함수 신규). 본 milestone scope rewrite 결과 — 이전 v4.1_dev-tools-bootstrap (v4.0 PROPOSE #1+#2 bundle, OPEN~DESIGN 4 stage 완료) 가 사용자 의문 raise (APPROVE 게이트 직전 'dev-tools 를 써야하는 이유' + 본질 의문 'Developer Mode 켜야 하는 이유') 후 폐기 결정 (commit 부재 상태 산출물 삭제) → v4.1 scope rewrite. 2 phase / 2 commit (phase-1 320fac9 mechanical + phase-2 6f23506 cascade) + Stage G commit 안 (b) default INTENT~APPROVE + milestones.md + ROADMAP + VERIFY 흡수. 4 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 0 + 10 decisions (D1~D10) + 7 risk mitigation (R1~R7). INTENT.success_criteria 8건 모두 PASS (7건 PASS + 1건 PASS_WITH_NOTE 실 cross-platform 검증 사용자 환경 의존). pre-commit 14 hook 모두 PASS, 회귀 0."
}
```

## Delta

- **files_changed**: bootstrap/agents/CLAUDE.md (D7 4 step → 5 step rewrite), bootstrap/agents/audit/project-harness-audit-team/component-installer.md (description / Role / D7 Sequence / 화이트리스트), README.md (Windows requirements + Installation narrative), AGENTS.md (Installation L15), CLAUDE.md (root L82 install narrative), claude/CLAUDE.md (L23-26 배포 메커니즘 rewrite + L60/L61/L67/L80 4건 install.ps1 정정), claude/commands/harness-meta.md (L327 install.ps1 정정), GUARDRAILS.md (L34 H5 narrative), verify.ps1 (Check-Info 함수 신규 + A1 info-level + C4/J1/J2 narrative), verify.sh (A1 + C4/J1/J2 narrative), verify-lib.ps1 (header), Makefile (install target → echo 안내), .env.example (Referenced by list)
- **files_added**: projects/meta/milestones/v4.1/INTENT.md, projects/meta/milestones/v4.1/RESEARCH.md, projects/meta/milestones/v4.1/DESIGN.md, projects/meta/milestones/v4.1/APPROVE.md, projects/meta/milestones/v4.1/VERIFY.md, projects/meta/milestones/v4.1/REPORT.md (본 파일), projects/meta/milestones/v4.1/PROPOSE.md (Stage I 직후), projects/meta/milestones/v4.1/milestones.md, projects/meta/milestones/v4.1/execute/phase-1.md, projects/meta/milestones/v4.1/execute/phase-2.md
- **files_deleted**: (이전 v4.1_dev-tools-bootstrap 산출물 — INTENT/RESEARCH/DESIGN.md commit 부재 상태에서 삭제, audit trail = 본 REPORT.summary + lessons_learned narrative)
- **modules_affected**: bootstrap/agents/ (D7 mechanical sequence rewrite — 단일 source), bootstrap/skills/ (cross-ref 보존, 변경 부재), claude/ (글로벌 레이어 cascade narrative), projects/meta/ (milestones/v4.1/ 산출물 + ROADMAP v4.1 entry), tests/ (변경 부재 — pre-commit 14 hook 모두 PASS 보장), root (README + AGENTS + CLAUDE + GUARDRAILS + Makefile + .env.example + verify.ps1/sh + verify-lib.ps1)

## Lessons learned

- **L1**: APPROVE 게이트 안 사용자 의문 raise → milestone scope rewrite 첫 사례 — narrative: 이전 v4.1_dev-tools-bootstrap (OPEN~DESIGN 4 stage 완료) 가 사용자 의문 'dev-tools 를 써야하는 이유' + 본질 'Developer Mode 켜야 하는 이유' raise 후 폐기 결정 → v4.1 scope rewrite (install 전략 자체 재검토). 9-stage workflow 안 commit 부재 상태에서 scope rewrite 처리 정책 narrative 선례 부재 — 본 milestone 자체가 그 선례. 본 패턴: (a) APPROVE 게이트 안 결정적 의문 발견 → (b) 산출물 삭제 (commit 부재 시) → (c) ROADMAP entry rewrite + milestones.md sub_milestones placeholder 복귀 → (d) Stage B/C/D 재작성 → (e) APPROVE 재 게이트. 향후 milestone 안 본 패턴 narrative 정전화 권고 (claude/commands/harness-meta.md 안 'APPROVE 게이트 안 rewrite 처리' section).
- **L2**: install 전략 의문 본질 = 'Developer Mode 강제 chain' 정합성 = onboarding 게이트 — narrative: 사용자 의문 '왜 이 모드를 켜야하는가' 가 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 의 'ecosystem integrator' 책임 본질 = onboarding 게이트. install 메커니즘 자체가 그 게이트 첫 표지. Developer Mode 강제 narrative trade-off (onboarding 마찰 vs drift 회피) 정전화 부재 → 본 milestone 안 정전화 완료 (Option D Junction default 채택).
- **L3**: 4 관점 검토 pass-with-comments + 의견 충돌 0 + 권고 자동 흡수 패턴 — narrative: architecture (Plan) + spec-drift (general-purpose with context7) + 회귀 risk (Explore) + scope contract (Explore) — 모두 pass-with-comments + 권고 자동 흡수 (D2~D8). spec-drift 안 context7 invoke 가 결정적 spec evidence 제공 — PowerShell 7.6 docs `Junction` ItemType elevation note 부재 (standard user 권한 PASS). 의견 충돌 0 → AskUserQuestion 추가 invoke 부재. v3.21 3 단계 패턴 (DESIGN 1차 source + EXECUTE Edit + VERIFY grep) 4번째 cycle 누적 (v3.18 + v3.20 + v3.21 + v4.1).
- **L4**: RESEARCH 안 cascade host inventory 부족 → 실 grep 시 추가 9건 발견 — narrative: RESEARCH 안 cascade 7 host inventory (README + AGENTS + bootstrap/{agents,skills}/CLAUDE.md + claude/CLAUDE.md + root CLAUDE.md + ARCHITECTURE.md) → 회귀 risk 관점 검토 + phase-2 실 grep 시 추가 host 발견 (claude/CLAUDE.md L60/L61/L67/L80 + claude/commands/harness-meta.md L327 + GUARDRAILS.md L34 + Makefile + .env.example + verify-lib.ps1 + verify.ps1 + verify.sh = 추가 9건). 본 milestone scope 자연 확장 (≥2 의미 단위 통합 bundling 정합). RESEARCH 단계 안 'codebase' grep 더 깊이 (전체 repo) 권고 — 향후 cascade narrative 변경 milestone 안 RESEARCH 단계 grep 전체 inventory 의무.
- **L5**: v3.21 narrative 정전화 3 단계 패턴 4번째 cycle 적용 — install 전략 cascade — narrative: (a) DESIGN 안 정확 markdown code block 1차 source (D7 5 step + same-volume narrative + ad-hoc 검증 권고) / (b) phase-1 EXECUTE Edit tool 정확 문구 그대로 삽입 / (c) phase-2 VERIFY grep 검증 키워드 ('Junction' + 'OS detect' + '5 step' + 'same.*volume' + 'Primary attempt by OS' cohesive). 본 cycle = 4번째 누적 (v3.18 narrative 정착 + v3.20 drift 정전화 + v3.21 3 단계 패턴 명문화 + v4.1 install 전략 cascade).
- **L6**: markdownlint MD032 함정 발현 — tests/CLAUDE.md '흔한 함정' 6번째 row 정확 정전 사례 — narrative: phase-2 commit 1차 markdownlint MD032 fail (phase-2.md L35 안 'phase-2 안 6 위치 정정:' 직후 list 시작 시 빈 줄 부재). tests/CLAUDE.md § '흔한 함정' 6 markdownlint row 안 '강조 (`**...**`) 직후 list 시 빈 줄 1개 의무' narrative 정전 → 정정 후 재시도 PASS. autofix wrapper 부재 (markdownlint hook = direct, --fix 미지원) 패턴. 향후 phase commit 전 self-check (markdownlint --all-files) 권장.
- **L7**: 도그푸드 모순 — 본 milestone 실행 환경 안 component-installer install 부재 — narrative: 본 milestone 자체 실행 시 사용자 ~/.claude/agents/ 안 component-installer subagent install 부재 = Agent tool 호출 시 subagent_type 등재 부재 → 메인 Claude 가 Bash 직접 처리 (Agent tool 호출 X). 4 관점 검토 시 Plan / general-purpose / Explore (모두 built-in agent types) 활용 — component-installer 직접 호출 부재. 본 도그푸드 모순 R7 mitigation narrative 정합. v4.0 PROPOSE #5 (dogfood-install-precondition) cross-ref 보존 — 사용자 환경 작업 후속 (본 repo ROADMAP 외).
- **L8**: Option D 선택 — Developer Mode 강제 해소 + drift 회피 유지 + cross-platform 정합 + 복잡도 1 trade-off 우위 — narrative: 5 후보 (A 현 유지 / B copy default / C 환경 자동 detect / D Junction Windows + Symlink Linux/macOS / E lightweight narrative only) 매트릭스 비교. Option D = onboarding 마찰 ✓ + drift 회피 ✓ + cross-platform ✓ + spec 정합 △ (junction 미명시 but OS file API transparency PASS) + 복잡도 1 (Windows narrative 분기). 다른 후보 (B copy default + C 환경 자동 detect) 대비 단순 + 직접. 사용자 명시 결정 (AskUserQuestion 'Option D Recommended') 정합.

## narrative

### 본 milestone 의 도그푸드 정합

v4.0 정체성 (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 의 'ecosystem integrator' 책임 첫 실 행사 사례 — install 전략 자체 재검토 + cascade narrative 정전화. v4.0 phase-3 안 도입된 정전 narrative (D7 4 step) 이 사용자 의문 trigger 후 5 step rewrite + Option D 채택. 본 milestone 자체가 'composer maintenance' 사례.

### Scope rewrite 선례 정합

L1 narrative 정확 — 이전 v4.1_dev-tools-bootstrap (OPEN~DESIGN 4 stage 완료) 폐기 후 v4.1 scope rewrite. 9-stage workflow 안 commit 부재 상태 scope rewrite 처리 정책 narrative 선례 부재 → 본 milestone 자체가 선례. 향후 milestone 안 본 패턴 narrative 정전화 권고 (PROPOSE.next_candidates 안 거명).

### 4 관점 검토 의견 충돌 0 + 권고 자동 흡수 누적

본 milestone 4 관점 검토 = 4 cycle 누적 (v3.21 + v3.20 + v3.18 + v4.1). 모두 pass-with-comments + 의견 충돌 0 + 권고 자동 흡수. AskUserQuestion 추가 invoke 부재. context7 invoke (spec-drift) 가 결정적 evidence 제공 패턴 누적.

### lessons_learned forward propose 부재

본 REPORT.lessons_learned 8건 (L1~L8) 모두 backward 종합 narrative. forward propose 명령형 ('별 milestone 으로') 부재 — PROPOSE 단계 통합 흡수. L1 narrative 정전화 권고 (claude/commands/harness-meta.md 안 'APPROVE 게이트 안 rewrite 처리' section) + L4 narrative 강화 권고 (RESEARCH 단계 grep 전체 inventory 의무) + L6 self-check 권고 (markdownlint --all-files) 등 후속 candidate source 가 될 수 있으나 PROPOSE.next_candidates 안 명명 + ROADMAP 등재.

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- APPROVE: [`APPROVE.md`](APPROVE.md)
- VERIFY: [`VERIFY.md`](VERIFY.md)
- phase-1 commit: `320fac9`
- phase-2 commit: `6f23506`
- 9-stage workflow Stage H: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
