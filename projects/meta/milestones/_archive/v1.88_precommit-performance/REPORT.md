# milestone REPORT — v1.88_precommit-performance

## 최종 결과

| 항목 | 값 |
|------|---|
| 변경 파일 | 2 (`.pre-commit-config.yaml` + `tests/CLAUDE.md`) |
| 신규 docs | 4 (milestone PLAN/REPORT + plan-1 PLAN/REPORT) |
| 커밋 | 2 (`624379c` phase-1, `f88ab51` phase-2) |
| smoke 회귀 | 0 (spec-verification 608/SKIP=4 + scope-contract 198/198 + cross-ref 1/1 + claude-md-drift 16/16 + roadmap-sync 31/0) |

## 각 PLAN 구현 요약

### plan-1-scope-guards

- **phase-1** (`624379c`): `.pre-commit-config.yaml` 4 local hook entry 갱신.
  `always_run: true` 제거 + 의미론적 `files:` 패턴 추가:

  | hook id | `files:` 패턴 (최종, PR #8 review 반영 후) |
  |---------|---------------------------------------|
  | `smoke-spec-verification` | `sessions/.*\.md$\|milestones/.*\.md$` |
  | `smoke-scope-contract` | `sessions/.*\.md$\|milestones/.*\.md$\|bootstrap/docs/OWNERSHIP\.md$\|claude/commands/harness-meta\.md$` |
  | `smoke-cross-ref` | `\.(md\|sh\|ps1\|toml\|json\|yaml\|yml\|py\|txt)$` |
  | `smoke-claude-md-drift` | `CLAUDE\.md$\|tests/smoke-.*\.sh$` |

- **phase-2** (`f88ab51`): `tests/CLAUDE.md` §"현행 4 hook 현황" 표 갱신.
  v1.80 기준 → v1.88 기준 + 정책 1줄 + `files:` 컬럼 추가.

상세: [`plan-1-scope-guards/REPORT.md`](plan-1-scope-guards/REPORT.md).

## 판정

- [x] `.pre-commit-config.yaml`: 4 local hook에 `always_run: true` 없음
- [x] `.pre-commit-config.yaml`: 4 local hook 각각 의미론적 `files:` 패턴 존재
- [x] `pre-commit run --all-files` → 4 smoke 모두 PASS (기존 동작 회귀 없음)
- [x] shell-only 스테이징 → 4 smoke hook 미실행 확인 (phase-2 commit `tests/CLAUDE.md` 단일 staged 시 spec-verification + scope-contract SKIP 실측)
- [x] `tests/CLAUDE.md` §hook 현황표 `files:` 정보 반영
- [ ] ROADMAP §8 stamp + §2 해소 처리 (Stage E phase-3 진행)

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | pre-commit (`pre-commit/pre-commit-hooks` v5.0.0 + pre-commit framework) |
| **topic** | `always_run`, `files`, `pass_filenames` hook 필드 상호작용 — skip 조건 |
| **findings** | `files:` 패턴 설정 + `always_run` 미설정 → staged 파일 중 `files:` 매칭 없으면 hook skip 동작 실측 검증 (phase-2 commit에서 spec-verification + scope-contract "no files to check Skipped" 출력). `pass_filenames: false` 유지 → hook 호출 시 파일명 미전달 (full scan 동일). |
| **drift** | no — `files:` / `always_run` / `pass_filenames` 필드 의미론 v1.x부터 변경 없음. 현 config `rev: v5.0.0` 정합. |
| **re-verify** | pre-commit major version bump (v5→v6) 시 또는 `files:` 정규식 엔진 변경 공지 시 |

**Citations**:

- C1 — pre-commit 공식 문서: "always_run — if true, runs even when no files match." (`https://pre-commit.com/#creating-new-hooks`)
- C2 — pre-commit 공식 문서: "files — A pattern of filenames to run on. The hook will run only if at least one of the files in the commit matches the pattern." (동일 URL)

## Lessons Learned

### L1 — files: 가드는 즉각 효과 검증 가능

phase-1 commit 출력에서 scope-contract / claude-md-drift "no files to check Skipped"
직접 관찰. 변경 파일이 패턴 미매칭이므로 hook 미실행. **"Why"**: pre-commit 표준 동작이지만
사전 가설 → 즉시 실측 가능한 패턴 (phase별 다른 staging set로 4 hook 모두 SKIP 사례 누적).
**"How to apply"**: 신규 hook 추가 시 `files:` 패턴 + 의도된 staging set 한 쌍을 PLAN에서 사전 명시 → REPORT에서 실측 표 1:1 대조.

### L2 — milestone PLAN은 markdownlint MD032 회피 의무

milestone PLAN.md 초안에서 list 앞 빈 줄 누락 → markdownlint FAIL → autofix 미지원 영역
(블록 구조 판단). 3 위치 수동 빈 줄 삽입 후 commit 성공. **"Why"**: pre-commit이
markdownlint 실패 시 autofix-or-fail wrapper 미경유 (markdownlint 자체는 wrapper 외부) →
별도 처리 필요. **"How to apply"**: 신규 milestone PLAN.md 작성 후 `pre-commit run markdownlint --files <PLAN.md>` 선제 검증 권장. 또는 `markdownlint --fix` opt-in (evidence-driven 후속).

### L3 — architecture review 가치 입증 (false negative 방지)

초안 `smoke-scope-contract: sessions/.*\.md$` 만으로 OWNERSHIP.md / harness-meta.md 단독
변경 시 hook skip → false negative. Stage C architecture 관점 검토에서 발견 → 패턴
3분기로 보정. **"Why"**: 5-Stage A~E의 Stage C 다각적 검토 단계가 단순 scope의 위험 요소
사전 차단 메커니즘으로 작동. 단일 fast-path 진행 시 발견 어려운 false negative.
**"How to apply"**: scope ≤5 파일이라도 hook entry 등 정책 결정의 미세 조정에는 architecture review 의무.

### L4 — files: 가드 한계 (Stage 5 SKILL.md acceptable omission)

smoke-spec-verification Stage 5 검사 대상 `bootstrap/skills/audit/harness-plan-verify/SKILL.md`
는 패턴 미포함 → SKILL.md 단독 변경 시 hook skip. **"Why"**: SKILL.md 수정 빈도 낮음 +
수동 smoke 실행 가능 + 패턴 복잡도 트레이드오프. **"How to apply"**: SKILL.md 변경 시
`bash tests/smoke-spec-verification.sh` 수동 호출 권장. 변경 빈도 누적 (3+) 시 패턴 추가
검토.

### L5 — PR review 2차 반영 (codex bot P1+P2)

PR #8 게시 후 `chatgpt-codex-connector` 봇이 2건 false negative 추가 발견:

- **P1 — smoke-cross-ref**: `\.md$` 패턴은 AT_IMPORT regex가 인식하는 비-md 확장자
  (`.sh/.ps1/.py/.yaml/.toml/.json/.txt`) 미커버. 비-md 참조 대상 deletion/rename만 staged
  되는 commit에서 broken link 미감지. **수정**: `\.(md\|sh\|ps1\|toml\|json\|yaml\|yml\|py\|txt)$`
  로 확장 (smoke-cross-ref.sh AT_IMPORT regex와 1:1 정합).
- **P2 — smoke-scope-contract**: 패턴에 `milestones/` 미포함. tests/smoke-scope-contract.sh
  Stage 1이 `milestones/v[0-9]*_*/PLAN.md`도 enumerate (line 212) → milestone-only PLAN edit이
  hook 우회. **수정**: `milestones/.*\.md$` 추가 (4분기로 확장).

**"Why"**: Stage C architecture review에서도 발견하지 못한 false negative. AT_IMPORT regex 본체
정독 + smoke 본문 enumerate logic 정독 부족. **"How to apply"**: 신규 hook의 `files:` 패턴
설계 시 smoke 본체의 enumerate logic + regex 본문을 1:1 대조하는 단계 추가. 향후 spec-drift
review 관점에 "smoke 본체 vs files: 패턴 정합" sub-check 추가 검토.

## 다음 후보 (§3 trigger 등록 candidates)

### §3-B 후속 후보

- **`v1.88b-precommit-pass-filenames-incremental`** — L2 옵션 (`pass_filenames: true` +
  smoke 파일-레벨 증분 검사). 본 milestone L1 효과 측정 후 사용자 발의 시 진행.
  현재 spec-verification 608건 → N건 축소 가능성 (markdown commit도 가속).

- **`v1.88c-markdownlint-autofix`** — L3 옵션 (`markdownlint --fix` 통합).
  본 milestone에서 milestone PLAN.md 수동 빈 줄 삽입 1 case 발생 → evidence 1.
  3+ case 누적 시 진입 검토.

### §3-A (외부 사용자 등장 의존)

- 없음 (현 시점 본 milestone 적용 효과로 충분)

## 변경 파일 (전체)

| 파일 | 변경 | 라인 |
|------|------|------|
| `.pre-commit-config.yaml` | modified | +12 / -4 |
| `tests/CLAUDE.md` | modified | +10 / -8 |
| `milestones/v1.88_precommit-performance/PLAN.md` | new | +83 |
| `milestones/v1.88_precommit-performance/plan-1-scope-guards/PLAN.md` | new | +43 |
| `milestones/v1.88_precommit-performance/REPORT.md` | new | (this file) |
| `milestones/v1.88_precommit-performance/plan-1-scope-guards/REPORT.md` | new | +35 |
