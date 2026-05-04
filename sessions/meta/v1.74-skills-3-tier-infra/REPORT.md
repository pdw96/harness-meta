# meta v1.74-skills-3-tier-infra — REPORT

세션 종료: 2026-05-05
선행 세션: [`sessions/meta/v1.36-roadmap-unification-and-flow/`](../v1.36-roadmap-unification-and-flow/PLAN.md) (2-tier 카테고리) · [`sessions/meta/v1.73-nested-claude-md/`](../v1.73-nested-claude-md/PLAN.md) (직전)

## 최종 결과

- 변경 파일: 5 (install-skills.{sh,ps1}, smoke-skills-install.sh, SKILLS.md, bootstrap/skills/CLAUDE.md)
- 신규 세션 파일: 2 (PLAN.md + REPORT.md)
- 3-tier 디렉토리 규약 + resolve 알고리즘 + smoke 검증 인프라 도입 (실 콘텐츠 0)
- smoke-skills-install: **17/17 PASS** (Windows static 검증 — Linux/macOS dynamic R3-2~R3-4 자동 추가 실행)
- 회귀 0 — smoke 4종 PASS

## 구현 요약

| 목표 | 실제 |
|------|------|
| R1 디렉토리 규약 + sentinel `_*` 거부 | ✓ SKILLS.md §2 + bootstrap/skills/CLAUDE.md 갱신. 모든 segment에서 `_*` prefix 거부 명시 |
| R2 install-skills.sh resolve 확장 | ✓ regex `{0,2}` quantifier + 3-segment 정확 path + 2-segment subcat 검색 + 1-segment 2/3-tier 동시 검색 + sentinel skip |
| R2 install-skills.ps1 동등 | ✓ Resolve-SkillName 동일 로직 + slashCount 분기 + Get-ChildItem `-like '_*'` skip |
| R3 smoke 3-tier 검증 | ✓ 정적 4 추가 (regex {0,2} ×2 + sentinel skip ×2) + dynamic 5 추가 (R3-2 fixture + R3-3 sentinel reject + R3-4 회귀) |
| R4 SKILLS.md §2/§4 갱신 | ✓ 디렉토리 구조 3-tier active + 카테고리 매트릭스 4-row + input 매트릭스 표 + regex 갱신 |
| bootstrap/skills/CLAUDE.md 갱신 | ✓ 디렉토리 구조 3-tier 추가 + 신규 추가 절차 sub-category 옵션 |

## 판정

- [x] regex 3-segment 입력 허용 (`<cat>/<subcat>/<name>`)
- [x] 1-segment / 2-segment 입력 backward compat (현 5 skill 정확 동일 동작)
- [x] 3-tier 부재 상태(현 시점)에서 install-skills 정상 동작
- [x] sentinel `_*` prefix 거부 (regex + enumerate skip 이중 차단)
- [x] smoke-skills-install.sh 17/17 PASS
- [x] smoke 회귀 0 (scope-contract 168/168 + roi-regression 6/6 + spec-verification 509+/509+ PASS)
- [x] SKILLS.md §2 3-tier active 명시
- [x] bootstrap/skills/CLAUDE.md 신규 추가 절차에 sub-category 옵션

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | Skills directory structure / SKILL.md location / nested skill discovery |
| **findings** | no new findings |
| **drift** | no — Claude Code SKILL 인식 spec 1단계 평탄 dest 유지. source 측 3-tier 확장은 Claude Code 인식과 독립 (install-skills 평탄화) |
| **re-verify** | Claude Code SKILL 인식 spec 변경 시 또는 nested skill discovery 도입 시 |

## Lessons Learned

- **L1 — Source N-tier / Dest 1-tier 분리 mechanism의 일반성** — v1.36에서 도입한 source-of-truth 측 카테고리화 vs Claude Code dest 1단계 평탄 분리 패턴이 3-tier로 자연 확장. 외부 도구의 인식 spec 변화 없이 source 측만 진화 가능
- **L2 — Sentinel `_*` prefix는 regex first-char + enumerate skip 이중 차단이 안전** — regex만으로는 직접 path 검증 우회 가능 (예: input `audit/_test/skill`). enumerate skip이 추가 안전망
- **L3 — Reviewer findings → PLAN refinement → 구현 순서가 미흡 발견 mechanism** — Stage 5 multi-perspective review에서 sentinel 거부 enforce 누락 + smoke 검증 약속 vs 현실 괴리 2건 발견. PLAN 보강 후 구현 → 회귀 0 + 검증 정합 확보
- **L4 — Windows MSYS2 환경에서 dynamic test skip은 정상** — Windows에서 `ln -s` MSYS2 fallback 동작으로 인해 dynamic 검증 skip이 정상 패턴 (v1.22 `_ps_args` 위임 패턴 정합). Linux/macOS CI에서 dynamic R3-2~R3-4 자동 실행

## 후속 분기

| 후속 세션 | Trigger 종류 | Trigger 조건 |
|---------|:----------:|------------|
| `v1.74b-skills-3-tier-content` | A | 실 sub-category + skill 5+ 추가 evidence (예: `audit/code-quality/<new-skill>/`) |
| `v1.74c-skills-new-category` | A | `security/` 또는 `automation/` 카테고리 도입 evidence (사용자 도메인 확장) |
| `v1.74d-skills-claude-md-update` | E | bootstrap/skills/CLAUDE.md 매트릭스 표 갱신 (실 3-tier 추가 시) |

## 변경 파일 목록 (commit 대상)

- `install-skills.sh` (수정 — resolve_skill_name 3-tier 확장)
- `install-skills.ps1` (수정 — Resolve-SkillName 동상)
- `tests/smoke-skills-install.sh` (수정 — R3-1 정적 4 + R3-2~R3-4 dynamic 5 추가)
- `bootstrap/docs/SKILLS.md` (수정 — §2 3-tier active + §4 input 매트릭스)
- `bootstrap/skills/CLAUDE.md` (수정 — 디렉토리 구조 + 신규 절차)
- `sessions/meta/v1.74-skills-3-tier-infra/PLAN.md` (신규)
- `sessions/meta/v1.74-skills-3-tier-infra/REPORT.md` (신규)
