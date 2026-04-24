# meta v1.8b-commands-to-skills-migration — REPORT

세션 기간: 2026-04-25 (단일 세션)
세션 범위: `_base/.claude/commands/` 6 파일을 `_base/.claude/skills/*/SKILL.md`로 `git mv` 통합. Anthropic 공식 `.claude/skills/` preferred format 채택.
판정: **PASS** (성공 기준 8/8, smoke 14 파일 복사 PASS, BREAKING)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 전부 **S1b(_base 템플릿) + S2**. T1/T2 meta 확정. upbit 재배포는 T4 후행.

## 최종 결과

- **git mv 6**: `_base/.claude/commands/harness{,-plan,-design,-run,-ship,-review}.md` → `_base/.claude/skills/<name>/SKILL.md` (이력 보존)
- **frontmatter 추가**: 6 SKILL.md 각각에 `disable-model-invocation: true` + `allowed-tools` rename (tools → allowed-tools)
- **삭제**: 기존 template-role SKILL.md 3개 (harness-plan/harness-design/harness-ship) — 재작성으로 대체
- **유지**: template 파일 3 (plan-template.md, 7d-checklist.md, report-template.md)
- **디렉토리 제거**: `_base/.claude/commands/` 완전 삭제
- **문서 갱신 2**: `_base/README.md` (skills-only 반영), `OWNERSHIP.md` (Evolution v1.8b)
- **Smoke**: 임시 /tmp 디렉토리에 install-project-claude 실행 → **14 파일 복사** (commands 0 + agents 4 + skills 9 + output-styles 1), 6 skill 디렉토리 확인 PASS

## 구현 요약 (PLAN 8/8)

| # | 목표 | 결과 |
|---|------|------|
| 1 | commands 6 `git rm` (실제 `git mv`로 이력 보존) | ✅ |
| 2 | 6 SKILL.md 재구성 (frontmatter + 본문) | ✅ |
| 3 | template 파일 3 유지 | ✅ |
| 4 | `_base/README.md` 갱신 | ✅ |
| 5 | `OWNERSHIP.md` Evolution v1.8b | ✅ |
| 6 | install-project-claude 수정 불필요 (카테고리 단위 복사, commands 빈 상태 skip) | ✅ |
| 7 | Smoke PASS | ✅ 14 파일 + 6 skills |
| 8 | Grey Area 15건 결정 | ✅ |

## 파일 구조 비교

### v1.8 이전 (17 파일)

```
_base/.claude/
├── agents/ (4)
├── commands/ (6)              ← legacy
├── output-styles/ (1)
└── skills/
    ├── harness-plan/ (2: SKILL + plan-template)
    ├── harness-design/ (2: SKILL + 7d-checklist)
    └── harness-ship/ (2: SKILL + report-template)
```

### v1.8b 이후 (14 파일)

```
_base/.claude/
├── agents/ (4)
├── output-styles/ (1)
└── skills/
    ├── harness/ (1: SKILL)                ← 신규 dispatcher
    ├── harness-plan/ (2: SKILL + plan-template)
    ├── harness-design/ (2: SKILL + 7d-checklist)
    ├── harness-run/ (1: SKILL)            ← 신규
    ├── harness-ship/ (2: SKILL + report-template)
    └── harness-review/ (1: SKILL)         ← 신규
```

변화: -6 commands + 3 신규 skill dir + 3 재작성 = **net -3 파일** (17 → 14).

## SKILL.md frontmatter 패턴 (6개 공통)

```yaml
---
name: <harness 또는 harness-plan 등>
description: <기존 commands .md description> /harness-... 명시 호출로만 활성화.
disable-model-invocation: true
argument-hint: "..."              # 선택
allowed-tools: Read, Glob, ...    # tools → allowed-tools 명칭 변경
model: <opus/sonnet/haiku>
thinking: <high>                  # 선택
---

<기존 commands/<name>.md 본문 전체>
```

**핵심**: `name` 필드가 slash 이름을 결정. `harness-plan` 유지 → `/harness-plan` UX 불변.

## Smoke 실측

```
/tmp/tmp.rajsoKrcxA/.claude/
├── agents/ (4)
├── skills/ (6 디렉토리)
│   ├── harness/
│   ├── harness-design/
│   ├── harness-plan/
│   ├── harness-review/
│   ├── harness-run/
│   └── harness-ship/
└── output-styles/ (1)

총 14 파일 · exit 0 · install-project-claude "11 항목 복사" 출력
```

- `_base/.claude/commands/` 부재 → install 스크립트가 해당 카테고리 skip (정상)
- 6 skill 디렉토리 모두 정상 복사
- `[OK] 11 항목` = top-level 항목 수(agents 4 + skills 6 + output-styles 1). 실 파일 14.

## Grey Area 결정 사후 검증 (15건)

| ID | 결정 | 구현 |
|----|------|------|
| G1 | agents 유지 | ✅ subagent는 별개 개념 |
| G2 | 기존 SKILL.md 재작성 | ✅ template-role 내용 삭제 (template 파일이 실제 가이드) |
| G3 | `disable-model-invocation: true` 유지 | ✅ 사용자 slash만 허용 |
| G4 | `name` 필드 값 | ✅ `harness-plan` 등 slash UX 불변 |
| G5 | template 파일 3 유지 | ✅ |
| G6 | commands 빈 디렉토리 삭제 | ✅ |
| G7 | install-project-claude 수정 불필요 | ✅ Smoke로 실증 |
| G8 | smoke 기대 파일 | **14** (17 → 14, -3) |
| G9 | `allowed-tools` 정확성 | ✅ commands tools 그대로 복사 (명칭만 변경) |
| G10 | description 50~150자 | ✅ 모두 준수 |
| G11 | upbit 후속 필요 | ✅ `sessions/upbit/v1.1-skills-migration/` 계획 |
| G12 | commands 완전 제거 대비 | ✅ 본 세션이 그 준비 |
| G13 | skill 이름 collision | ✅ 각 독립 |
| G14 | `model`/`thinking` 복사 | ✅ frontmatter 보존 |
| G15 | SKILL.md 본문 규모 | ✅ commands 전체 이관 OK |

**15/15 결정 반영.**

## Lessons Learned

1. **`git mv`로 commands→skills 이동의 이력 보존 이점**: 6 파일 모두 `git log --follow`로 commands 시절 히스토리 추적 가능. 만약 `git rm` + `git add` 패턴이었으면 blame 끊김. v1.8 때와 동일 교훈 재확인.

2. **Anthropic `tools` → `allowed-tools` frontmatter 명칭 변경**: context7 SKILL.md 예시는 `allowed-tools` 사용. commands의 `tools:` 필드를 그대로 두면 skill parser가 인식 못 할 수 있음. 본 세션은 명시적 rename하여 Anthropic 공식 format 준수.

3. **`disable-model-invocation: true`의 역할 재확인**: "사용자 slash 호출은 허용, 모델 자동 로드는 차단." 하네스 명령은 **의도적 명시 호출만** 유효 — 모델이 자의적으로 `/harness-plan`을 실행하면 workflow 깨짐. 이 플래그가 정확히 방어.

4. **기존 template-role SKILL.md (name: harness-plan-template 등)는 `/harness-plan-template` 같은 이상한 slash 생성**: 이름이 의도와 다름. 새 통합 SKILL.md는 `name: harness-plan`으로 명확. 사용자가 `/harness-plan-template` 호출 시도 시 혼란 유발 가능성 사전 제거.

5. **3개 skill의 template 파일 유지 전략**: `plan-template.md`, `7d-checklist.md`, `report-template.md`는 **SKILL.md에서 참조**하는 자산. 삭제 불가. skill 디렉토리 내 여러 파일 허용되는 Claude Code 구조 활용.

## ⚠️ BREAKING 사용자 액션

각 프로젝트는 **install-project-claude 재실행**하여 `.claude/` 업데이트 필요:

```powershell
cd <project-root>
pwsh ~/harness-meta/bootstrap/install-project-claude.ps1 -Force
```

- 기존 `.claude/commands/harness*.md` 6개는 **stale** 상태 → `-Force`로 backup 이동
- 기존 `.claude/skills/harness-{plan,design,ship}/SKILL.md` 내용 변경 → backup + 새 파일

upbit 복구는 **`sessions/upbit/v1.1-skills-migration/`** 별도 세션.

## 커밋 계획

```
feat(meta)!: sessions/meta/v1.8b-commands-to-skills-migration

- git mv 6: _base/.claude/commands/harness*.md
            → _base/.claude/skills/<name>/SKILL.md (이력 보존)
- delete: 기존 template-role SKILL.md 3 (재작성 대체)
- update: 6 SKILL.md frontmatter — disable-model-invocation: true,
          tools → allowed-tools rename, name 값 slash UX 유지
- keep: template 파일 3 (plan-template, 7d-checklist, report-template)
- update: _base/README.md (skills-only 반영)
- update: OWNERSHIP.md Evolution v1.8b
- add: sessions/meta/v1.8b-commands-to-skills-migration/{PLAN,REPORT,evidence/smoke-v1.8b.txt}

Smoke PASS — 14 파일 복사 (commands 0 + 6 skills + agents 4 + output-styles 1).
Grey Area 15건 결정. Anthropic .claude/skills/ preferred 채택.

BREAKING: 각 프로젝트 install-project-claude -Force 재실행 필요.
upbit 후속: sessions/upbit/v1.1-skills-migration/
```

## 후속 세션

- `sessions/upbit/v1.1-skills-migration` — upbit `.claude/` 재배포
- v1.9-project-auto-detect (다음 계획)
