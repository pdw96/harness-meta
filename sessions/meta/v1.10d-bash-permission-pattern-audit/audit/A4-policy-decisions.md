# A4 — Policy 결정 (R1'-R7' 채택 근거, β scope)

본 audit의 7개 policy 결정. 각 결정은 A1 verbatim 인용 + A2/A3 분석 근거.

## R1' (REVISED) — 공백 형식 + YAML 리스트 채택 (콜론 폐기)

**결정**: 5 파일 frontmatter 모두 YAML 리스트 + 공백 패턴 형식 (`Bash(cmd *)`).

**근거**:

- A1 인용 1: 공백 = 콜론 equivalent (둘 다 word-boundary)
- A1 인용 2: dialog 자동 저장 형식 = 공백 (공식 dominant 표기)
- A1 인용 7: skills docs verbatim — separator는 "space-separated string or YAML list" (콤마 미명시)
- 공식 docs 3건 (permissions / settings / skills) 모두 공백 형식 dominant
- context7 plugin-dev (콜론 + 콤마)는 conflict — skills docs canonical 따름

**대안 평가**:

- (a) 콜론 inline (`Bash(cmd:*)`): 공식 등가지만 alias. plugin-dev 표기 — **rejected** (skills docs와 conflict)
- (b) 공백 inline (`Bash(cmd *)` 콤마/공백 separator): 공식 spec 정합이지만 long line — **rejected** (가독성)
- (c) **YAML 리스트 + 공백 패턴**: 모호성 0, spec 정합, 가독성 ✓ — **채택**

## R2' — Redundant declare 제거 (변경 없음)

**결정**: 자동 허용 set declare 6건 제거. 16 → 9 Bash 패턴.

**근거**:

- A1 인용 3: auto-allow set은 모든 모드에서 자동 허용 (declare 효과 0)
- A1 인용 9: `allowed-tools` 제거 시 baseline permissions 폴백 (차단 아님 — pre-approval 제거뿐)

**제거 6건**:

1. `harness-meta.md` `Bash(ls*)`, `Bash(grep*)` (2건 — 자동 허용)
2. `harness-design/SKILL.md` `Bash(ls*)` (1건)
3. `harness-plan/SKILL.md` `Bash(ls*)`, `Bash(wc*)` (2건)
4. `harness-review/SKILL.md` `Bash(git*)` (1건 — review = read-only, 자동 허용으로 충분)

## R3' — Conservative destructive 정책 (변경 없음)

**결정**: argument 분리 미시도. `git push` 별도 deny rule 추가 안 함.

**근거**:

- A1 인용 4 verbatim: argument 제약 fragile warning
- 신뢰성 있는 제약은 PreToolUse hook (별도 인프라, 본 audit 범위 외)

## R4' — upbit 사본은 T4 후행 별도 세션 (변경 없음)

**결정**: 본 v1.10d는 harness-meta source-of-truth 5 파일만. upbit deployed 6 SKILL + settings 36 패턴은 `sessions/upbit/v1.2-bash-permission-update/` 별도.

**근거**: OWNERSHIP.md T4 — 크로스 커팅 분할.

## R5' — `bootstrap/docs/PERMISSION_PATTERN.md` 신규 작성 (변경 없음)

**결정**: 5축 통합 doc 작성 (~140-160 라인 — β scope 확장).

**내용 구성** (10 §):

1. § 1. 결정 — 5축 통합 정책
2. § 2. 필드명 매트릭스 — slash command / skill / subagent 별 (`allowed-tools:` vs `tools:`)
3. § 3. Separator — YAML 리스트 (권장) / 공백 inline / 콤마 (비권장)
4. § 4. 형식 매트릭스 — 4 형식 word-boundary 동작
5. § 5. 자동 허용 set — declare 금지 list (12건)
6. § 6. fragile pattern 금지 — argument 제약 + PreToolUse hook 권장
7. § 7. compound + wrapper — `&&` 분해 + 자동 strip 5종
8. § 8. harness-meta 정책 — Conservative R3' 정책
9. § 9. 사용자 settings 마이그레이션 가이드 — Layer 3 upbit 표
10. § 10. verify 체크리스트 — V1+V5+V7 grep + 후속 세션 link

## R6' (NEW) — `harness-meta.md` 필드명 `tools:` → `allowed-tools:`

**결정**: slash command frontmatter 필드명 정정. `tools:` (subagent 전용) → `allowed-tools:` (slash command/skill 공식).

**근거**:

- A1 인용 7-8: skills docs frontmatter table — `allowed-tools` 공식 필드. slash command는 skill과 동일 frontmatter ("Files in `.claude/commands/` still work and support the same frontmatter")
- 현재 `tools:` 사용 → silent ignore 또는 lenient 파서 의존 (spec 미보장)
- 정정 후 declare 정상 작동 보장

**부작용**: declare가 처음 정상 작동할 수 있음 → 일부 명령 prompt 안 발생 (긍정적 변화 가능). 단 자동 허용 set 명령은 무관.

## R7' (NEW) — 콤마 → YAML 리스트 형식 전환 (5 파일)

**결정**: 5 파일 (`harness-meta.md` + 4 SKILL.md) 모두 콤마 separator 폐기 → YAML 리스트.

**근거**:

- A1 인용 7 verbatim: skills docs 명시 "space-separated string or YAML list" — 콤마 미명시
- 콤마 형식의 spec 보장 없음 — 단일 문자열로 파싱돼 `allowed-tools` 전체 무효 가능
- YAML 리스트는 unambiguous + 확장성 + 가독성

**대안 평가**:

- (a) 공백 inline: `allowed-tools: Read Glob Grep Bash(mkdir *)` — long line, 가독성 ✗
- (b) YAML 리스트: 추천 — 명시 spec 정합 + 모호성 0

**부작용**: 형식 변경으로 git diff 큼 (5 파일 frontmatter 재구성). 단 단일 commit으로 통합 정정.

## 결정 매트릭스 요약 (R1'-R7')

| ID | 결정 | 근거 인용 | 변화 (vs v1.10d α) |
|----|------|----------|:------------------:|
| R1' | 공백 형식 (콜론 폐기) | 인용 1, 2, 7 | revised (α는 콜론) |
| R2' | redundant 제거 (-6건) | 인용 3 | 변경 없음 |
| R3' | Conservative | 인용 4 | 변경 없음 |
| R4' | T4 후행 분리 | OWNERSHIP T4 | 변경 없음 |
| R5' | PERMISSION_PATTERN.md | bootstrap/docs/* 패턴 | 확장 (5축 통합) |
| R6' | 필드명 `tools:` → `allowed-tools:` | 인용 7-8 | NEW |
| R7' | 콤마 → YAML 리스트 (5 파일) | 인용 7 | NEW |

## 별도 후속 세션 (β scope 외)

| 세션 | scope | 내용 |
|------|------|------|
| `v1.10f-broad-bash-fine-grain` | S1b | 발견 6 — `harness/`, `harness-run/`, `harness-ship/` SKILL의 broad `Bash` declare를 사용 분석 후 fine-grain (또는 의도된 broad 유지). 본 v1.10d 범위 외 (D3-b 결정) |
| `v1.10g-skill-frontmatter-thinking-effort` | S1b | 발견 12 — `harness-meta.md`의 `thinking: high`가 deprecated `effort:` alias인지 검증 + 필요 시 정정 |
| `sessions/upbit/v1.2-bash-permission-update/` | S6 | T4 후행 — upbit deployed 6 SKILL + settings 36 패턴 5축 통합 정정 (본 v1.10d 결과 적용) + deny 7 fragile pattern 재설계 (PreToolUse hook 또는 ask 전환) |
