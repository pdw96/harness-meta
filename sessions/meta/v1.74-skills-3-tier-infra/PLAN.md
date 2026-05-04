# meta v1.74-skills-3-tier-infra — PLAN

세션 시작: 2026-05-05
직접 선행 세션: [`sessions/meta/v1.36-roadmap-unification-and-flow/`](../v1.36-roadmap-unification-and-flow/PLAN.md) (2-tier 카테고리 도입) · [`sessions/meta/v1.73-nested-claude-md/`](../v1.73-nested-claude-md/PLAN.md) (직전)

목적: `bootstrap/skills/<category>/<subcategory>/<name>/` 3-tier 디렉토리 구조 **인프라**만 도입. install-skills.{ps1,sh} resolve 로직 + smoke + SKILLS.md 갱신. 실 3-tier 콘텐츠 0 — evidence 누적 후 v1.74b+에서 단계 도입. v1.11 language-overlay-infra 패턴 답습.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:

- 변경 파일: S1c(1) `bootstrap/docs/SKILLS.md` + S3(2) `install-skills.{ps1,sh}` + S3(1) `tests/smoke-skills-install.sh` + S2(1) `bootstrap/skills/CLAUDE.md` 갱신 = 5/5 meta
- **T1 경로 다수결** — meta scope 5/5
- **T2 스펙 vs 값** — 3-tier 디렉토리 규약 = 모든 사용자 영향 → meta

## Scope inheritance (verbatim from 선행 세션)

**Source 1 — `sessions/meta/v1.36-...../PLAN.md` Out of scope §** (interpreted from v1.36 PLAN context — v1.36은 2-tier만 도입):

> "3단계 이상 (`<cat>/<sub>/<name>/`)는 v1.37+ evidence (5+ skill 추가) 시 도입. 신규 카테고리(security/, automation/ 등)도 evidence-driven."

**Source 2 — `bootstrap/docs/SKILLS.md §2`** (verbatim):

> "3단계 이상 (`<cat>/<sub>/<name>/`)는 v1.37+ evidence (5+ skill 추가) 시 도입. 신규 카테고리(security/, automation/ 등)도 evidence-driven."

**Source 3 — 사용자 발의 (2026-05-05) verbatim**:

> "3-tier 인프라만 도입 (skill 0 추가)" → "현 5 skill은 2-tier 유지, install-skills 등에 3-tier lookup 로직만 추가 (향후 도입 대비 — v1.11 언어 overlay 인프라 패턴)"

**Parsed sub-items (4)**:

1. **3-tier 디렉토리 규약** — `bootstrap/skills/<category>/<subcategory>/<name>/` 정의 + reserved prefix + naming convention
2. **install-skills.{ps1,sh} resolve 로직 확장** — 0/1/2-segment input → 1/2/3-tier 검색 매트릭스
3. **smoke-skills-install.sh 검증** — 3-tier 정합 + lookup 경로 + 회귀 0
4. **SKILLS.md 갱신** — §2 3-tier 규약 active 표기 + 알고리즘 문서화

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 실 3-tier skill 도입 (예: `audit/code-quality/<name>/`) | v1.74b+ (evidence-driven, 신규 skill 추가 시) |
| 기존 5 skill을 3-tier로 마이그레이션 | 미적용 — current 5건 evidence 부족, 2-tier 유지 |
| 신규 카테고리 도입 (`security/`, `automation/`) | v1.74c+ (evidence-driven) |
| `~/.claude/skills/` symlink target 구조 변경 | Out of scope — Claude Code SKILL 인식 1단계 평탄 유지 (v1.36 결정) |
| 4-tier 이상 구조 | 영구 거부 — Claude Code on-demand 인식 깊이 + 사용자 인지 부담 |
| install-skills.ps1/sh의 다른 주요 로직 변경 (cleanup / copy mode 등) | 별 후속 (evidence-driven) |
| AskUserQuestion 자동 invoke 로직 (multiple matches 시) | 사용자 명시 입력 의무 유지 — 보안 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | `/websites/code_claude` |
| **topic** | Skills directory structure / SKILL.md location / nested skill discovery |
| **findings** | see citations below |
| **drift** | no — Claude Code SKILL 인식 spec은 `~/.claude/skills/<name>/SKILL.md` 1단계 평탄. 본 세션은 source-of-truth 측 3-tier만 도입, dest는 1단계 유지로 spec 정합 |
| **re-verify** | Claude Code SKILL 인식 spec 변경 시 또는 nested skill discovery 도입 시 |

**Citations**:

- C1 — Skills source 디렉토리는 `~/.claude/skills/<skill-name>/SKILL.md` 1-level 구조 (Source: `https://code.claude.com/docs/en/skills`)
- C2 — SKILL frontmatter `name` 필드가 매칭 식별자 (Source: `https://code.claude.com/docs/en/skills`)
- C3 — sub-skill / nested skill spec 부재 — 사용자 측 디렉토리 구조 자유 (source-of-truth 측만, install 시 평탄화 필수)

## 1. 현 상태 (2-tier)

```
bootstrap/skills/                    # source-of-truth (git tracked)
├── audit/                           # 3 skill
│   ├── ai-ready-scorer/
│   ├── harness-plan-verify/
│   └── harness-roadmap-update/
└── dev-tools/                       # 2 skill
    ├── mindvault/
    └── developer-profile/

~/.claude/skills/                    # dest (Claude Code 인식)
├── ai-ready-scorer/                 → symlink to bootstrap/skills/audit/ai-ready-scorer/
├── harness-plan-verify/             → ditto
├── harness-roadmap-update/          → ditto
├── mindvault/                       → symlink to bootstrap/skills/dev-tools/mindvault/
└── developer-profile/               → ditto
```

`install-skills.{ps1,sh}` `resolve_skill_name()` 함수가 `<name>` 또는 `<cat>/<name>` 입력 처리. regex: `^[a-z0-9][a-z0-9_-]*(/[a-z0-9][a-z0-9_-]*)?$`.

## 2. 목표 상태 (3-tier 인프라)

```
bootstrap/skills/                    # source-of-truth (git tracked)
├── audit/                           # 카테고리
│   ├── ai-ready-scorer/             # 2-tier (현 상태 유지)
│   ├── harness-plan-verify/         # 2-tier
│   ├── harness-roadmap-update/      # 2-tier
│   └── <subcategory>/               # 3-tier (예: code-quality/, governance/) — 향후
│       └── <name>/                  # 실 콘텐츠 v1.74b+
│           └── SKILL.md
└── dev-tools/
    └── ...                          # 동상 — 2-tier 유지, 3-tier 향후 evidence

~/.claude/skills/                    # dest (Claude Code 인식 — 1단계 평탄 유지)
├── ai-ready-scorer/                 → symlink to bootstrap/skills/audit/ai-ready-scorer/
├── ...                              # 모든 skill 1단계 평탄 (3-tier source도 1단계 dest로 평탄화)
```

**핵심 mechanism**: source는 N-tier 자유, dest는 항상 1-tier (Claude Code SKILL 인식 호환). install-skills 평탄화 logic 확장.

## 3. 결정 (R1 ~ R4)

### R1 — 디렉토리 규약 + Naming convention

**위치**: `bootstrap/skills/<category>/<subcategory>/<name>/SKILL.md` (3-tier)

**카테고리 매트릭스** (현 2 + 향후 evidence-driven):

| `<category>` | 의미 | 현 skill | 3-tier 후보 (예시) |
|------|------|---------|-------------------|
| `audit/` | 검증·평가·갱신 | 3건 | `audit/code-quality/` / `audit/governance/` |
| `dev-tools/` | 개발 도구·context | 2건 | `dev-tools/knowledge/` / `dev-tools/profile/` |
| `security/` (향후) | 보안 검증 | 0 | `security/sast/` / `security/secrets/` |
| `automation/` (향후) | 자동화 | 0 | `automation/ci/` / `automation/deploy/` |

**Sub-category 정규화**:

- `<category>` + `<subcategory>` 모두 lowercase + `[a-z0-9][a-z0-9_-]*` (skill name과 동일 regex)
- alias 불지원 (사용자 정확 입력 의무)
- Reserved prefix `_*` 금지 (sentinel) — 카테고리/서브카테고리 모두

**Skill name 컨벤션** (변경 없음):

- 현 5 skill 모두 `harness-*` prefix 미사용 (예: `ai-ready-scorer`, `mindvault`). 본 세션도 강제 prefix 도입 안 함
- template overlay의 `harness-*` prefix(OVERLAY.md §6)와 의도적 분리 — skill은 글로벌 user-skill, template은 프로젝트별 자산 (다른 도메인)

### R2 — install-skills.{ps1,sh} resolve 로직 확장

**현 알고리즘**:

```
resolve_skill_name(input):
  regex 검증 (1 또는 2 segment)
  if input은 <cat>/<name>:
    bootstrap/skills/<cat>/<name>/SKILL.md 검증 → 정확 path 반환
  else (input은 <name>):
    모든 category 검색 → 0/1/2+ 매치 분기
```

**확장 알고리즘** (3-tier 지원):

```
resolve_skill_name(input):
  regex 검증 (1, 2, 또는 3 segment)
  if input은 <cat>/<subcat>/<name> (3 segment):
    bootstrap/skills/<cat>/<subcat>/<name>/SKILL.md 검증 → 정확 path 반환
  elif input은 <cat>/<name> (2 segment):
    먼저 <cat>/<name>/ 직접 검증 (기존 동작 유지)
    부재 시 <cat>/*/<name>/ subcat 검색
    매트릭스 분기 (0/1/2+)
  else (input은 <name>, 1 segment):
    bootstrap/skills/<cat>/<name>/ (2-tier) + bootstrap/skills/<cat>/<subcat>/<name>/ (3-tier) 동시 검색
    매트릭스 분기 (0/1/2+)
  반환은 항상 최종 source path (1-tier dest 평탄화는 caller 책임)
```

**Regex 확장**: `^[a-z0-9][a-z0-9_-]*(/[a-z0-9][a-z0-9_-]*){0,2}$` (0~2 slashes 허용)

**Sentinel `_*` prefix 거부** (신설 enforce):

- input 어느 segment라도 `_` 시작이면 reject (regex `^[a-z0-9]...`로 자연 차단)
- enumerate 시 `_*` 디렉토리 자연 스킵 (sentinel — `_base`, `_test` 등 미래 fixture 보호)

**Backward compat**: 현 5 skill 모두 2-tier 유지 → input 1 또는 2 segment 동작 100% 동일.

### R3 — smoke-skills-install.sh 갱신

**기존 검증** (유지):

- 정적 매트릭스 5 skill (audit/ 3 + dev-tools/ 2)
- regex pattern 정합
- resolve_skill_name 함수 단위 테스트

**신규 검증** (3-tier 추가):

- **R3-1 정적**: install-skills.sh + install-skills.ps1 양쪽에서 regex `{0,2}` quantifier grep 정합
- **R3-2 동적 (3-segment)**: temp `bootstrap/skills/<cat>/<subcat>/<skill>/SKILL.md` fixture 생성 → resolve_skill_name `<cat>/<subcat>/<skill>` 입력 → 정확 path 반환 검증 → cleanup
- **R3-3 동적 (sentinel)**: regex가 `_test` 등 underscore-prefix input 거부 검증
- **R3-4 회귀**: 현 5 skill (1-segment / 2-segment) 입력 모두 정확 동일 동작 (resolve return path 일치)

### R4 — 단일 소스 doc 갱신

**`bootstrap/docs/SKILLS.md`**:

- §2 "디렉토리 규약" 갱신 — 3-tier (`<cat>/<subcat>/<name>/`) active 표기
- §2 "카테고리 매트릭스" — 3-tier 후보 예시 추가
- §3 "SKILL.md frontmatter 표준" 변경 없음
- §4 "install-skills 사용법" 갱신 — 3-segment 입력 형식 예시 추가
- §6 "OS 분기" 변경 없음
- §10 "관련 문서" 본 v1.74 세션 cross-ref

**`bootstrap/skills/CLAUDE.md`** (v1.73 신설 모듈 가이드):

- 매트릭스 표 변경 없음 (현 5 skill 그대로)
- "디렉토리 구조" § 갱신 — 3-tier 인프라 active 명시
- "신규 글로벌 user-skill 추가 절차" § 갱신 — 1단계 "카테고리 결정"에 "필요 시 sub-category" 옵션 추가

## 4. 변경 대상 (4 수정)

### 수정 (4)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/docs/SKILLS.md` | S1c/S2 | R1 + R4 — 3-tier 디렉토리 규약 + 매트릭스 + 사용법 갱신 |
| `bootstrap/skills/CLAUDE.md` | S1c/S2 | R4 — "디렉토리 구조" + "신규 추가 절차" 갱신 |
| `install-skills.sh` | S3 | R2 — resolve_skill_name regex 확장 + 3-tier 검색 분기 |
| `install-skills.ps1` | S3 | R2 — 동상 (PowerShell idiom) |
| `tests/smoke-skills-install.sh` | S2/S3 | R3 — 3-tier regex / resolve 검증 추가 |

### 신규 (2)

| 경로 | 역할 |
|------|------|
| `sessions/meta/v1.74-skills-3-tier-infra/PLAN.md` | 본 파일 |
| `sessions/meta/v1.74-skills-3-tier-infra/REPORT.md` | 종료 시 |

## 5. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 PLAN 확인**
- [ ] Stage A — `install-skills.sh` resolve_skill_name 확장
- [ ] Stage B — `install-skills.ps1` 동상
- [ ] Stage C — `tests/smoke-skills-install.sh` 3-tier 검증 추가
- [ ] Stage D — `bootstrap/docs/SKILLS.md` §2/§4 갱신
- [ ] Stage E — `bootstrap/skills/CLAUDE.md` 갱신
- [ ] Stage F — smoke 회귀 검증 + REPORT.md
- [ ] 커밋 (사용자 확인 후)

## 6. 성공 기준

- [ ] regex 3-segment 입력 허용 (`<cat>/<subcat>/<name>`) — 정확 path 검증 시 정상 resolve
- [ ] 1-segment / 2-segment 입력 backward compat (현 5 skill resolve 정확 동일)
- [ ] 3-tier 부재 상태(현 시점)에서 install-skills 정상 동작 (회귀 0)
- [ ] smoke-skills-install.sh PASS — 5 skill 정적 매트릭스 + 3-tier regex
- [ ] smoke 3종 회귀 0 (spec-verification + scope-contract + roi-regression)
- [ ] SKILLS.md §2 3-tier active 명시
- [ ] `bootstrap/skills/CLAUDE.md` 신규 추가 절차에 sub-category 옵션 포함

## 7. 위험과 회피

| 위험 | 회피 |
|------|------|
| regex 확장 시 기존 input 거부 | regex `{0,2}` quantifier로 0/1/2 slash 모두 허용 (하위 호환) |
| resolve 함수 분기 추가 시 ambiguity | 정확 path 우선 (직접 검증) → 부재 시만 search. 1-segment 검색 시 2-tier + 3-tier 동시 enumerate (multi-match는 기존 분기로 처리) |
| 3-tier 부재 상태에서 search 무한 깊이 | depth 2 hard-cap (`<cat>/<subcat>/<name>` 까지만) — sentinel `_*` prefix 추가 보호 |
| `~/.claude/skills/` symlink target 변경 | Out of scope — dest는 1단계 평탄 유지. source path만 이동 가능 |
| 사용자 혼란 (1/2/3-tier 입력 모두 허용) | SKILLS.md §4에 명확한 입력 형식 표 + 우선순위 정책 명시 |

## 8. 커밋 전략

```
feat(meta): sessions/meta/v1.74-skills-3-tier-infra — bootstrap/skills/ 3-tier 인프라 도입 (실 콘텐츠 0)

- update: bootstrap/docs/SKILLS.md (R1 + R4 — 3-tier 디렉토리 규약 + 매트릭스 + 사용법)
- update: bootstrap/skills/CLAUDE.md (R4 — 디렉토리 구조 + 신규 추가 절차)
- update: install-skills.sh (R2 — resolve_skill_name regex 확장 + 3-tier 검색 분기)
- update: install-skills.ps1 (R2 — 동상)
- update: tests/smoke-skills-install.sh (R3 — 3-tier regex / resolve 검증)
- add: sessions/meta/v1.74-skills-3-tier-infra/{PLAN,REPORT}.md

Scope: 인프라만 (실 3-tier skill 0). v1.11 language-overlay-infra 패턴 답습.
- 디렉토리 규약: <category>/<subcategory>/<name>/ + reserved _* + sub-category 정규화
- resolve 알고리즘: 1/2/3-segment 입력 매트릭스 (backward compat 보장)
- dest는 1단계 평탄 유지 (Claude Code SKILL 인식 spec 정합)
- 실 3-tier 콘텐츠는 v1.74b+ evidence-driven

Smoke: 회귀 0 보장 (5 skill 매트릭스 + spec-verification + scope-contract + roi-regression PASS).
```

## 9. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.74b-skills-3-tier-content` | 실 sub-category + skill 5+ 추가 시 (예: `audit/code-quality/<new-skill>/`) |
| `v1.74c-skills-new-category` | `security/` 또는 `automation/` 카테고리 도입 evidence (사용자 도메인 확장) |
| `v1.74d-claude-md-skills-update` | bootstrap/skills/CLAUDE.md 매트릭스 표 갱신 (실 3-tier 추가 시) |
