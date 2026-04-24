# meta v1.5-agents-md-strategy — PLAN

세션 시작: 2026-04-24
선행 세션: [`sessions/meta/v1.4-license-mit/`](../v1.4-license-mit/REPORT.md)
목적: **AGENTS.md 오픈 표준**(Linux Foundation 관리, 60,000+ 프로젝트 채택)을 본 repo의 **source of truth**로 공식 채택하고, **Windows symlink 블로커를 우회하는 이중 배포 전략**(symlink + 복사 fallback)을 규약으로 고정한다. 차기 v1.6~v2.0의 **모든 adapter 세션 전제**.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: `~/harness-meta/{bootstrap/docs/AGENTS_MD_STRATEGY.md (신규), bootstrap/docs/OWNERSHIP.md (Evolution 조항 추가), CLAUDE.md, README.md}` → S1(×0) + S2(×2) + S3(×2).
- **T1 경로 다수결** — 4/4 meta scope(S2 + S3) 전부 → meta 소유 확정.
- **T2 스펙 vs 값** — AGENTS.md "표준 채택 결정" 자체가 repo-global 규약 → meta. (각 adapter 프로젝트가 채택을 어떻게 적용하는지는 v1.14~v1.20 각 project 세션에서 다룸.)

## 배경

### v1.4 로드맵 확정 사항

2026-04-24 대화에서 context7 + 웹 검색(JetBrains 2026-04 조사 등)으로 최신 AI 코딩 생태계 분석 완료. 그 결과:

1. **AGENTS.md 오픈 표준** (Linux Foundation 산하 Agentic AI Foundation 관리):
   - OpenAI Codex, Google Jules, Gemini CLI, Cursor, Amp, Factory, Devin, Windsurf, GitHub Copilot(2025-08-28부터) 전부 **네이티브 지원**
   - 60,000+ 프로젝트 채택
   - Claude Code만 CLAUDE.md 고수 (공식 이슈 `anthropics/claude-code#6235` 3,200+ upvote, `#34235`도 진행)

2. **SKILL.md 표준** (2025-12 공식화):
   - Claude Code / Cursor / Codex CLI / Gemini CLI / Windsurf / Roo Code 등 12+ 도구 지원
   - 표준 경로: `.agents/skills/`

3. **현 harness-meta 구조의 결합**:
   - `claude/{commands,agents,skills,hooks,statusline,output-styles}/` — Claude Code 전용 디렉토리
   - `CLAUDE.md` — Claude Code만 읽음
   - 타 adapter 지원 시 **AGENTS.md 호환 레이어** 필요

### 확정된 D1~D3 결정

사용자 승인(2026-04-24 로드맵 분석):
- **D1**: AGENTS.md source of truth 채택 — **symlink + 복사 fallback 이중 전략**
- **D2**: Windows symlink 없는 팀원 — `install.sh/.ps1`이 OS/모드 감지 후 자동 선택. drift 감지 포함
- **D3**: 문서 언어 — **영문 기본** (AGENTS.md), 한국어 override 허용 (`CLAUDE.ko.md` 등)

### Windows symlink 실측 리스크 (v1.4 grey area 분석)

| 시나리오 | `core.symlinks` | Dev Mode | 결과 |
|---------|----------------|----------|------|
| Dev Mode ON + config true | true | ON | ✅ 정상 symlink |
| Dev Mode OFF + config true | true | OFF | ❌ `CreateSymbolicLinkW` silent fail → git이 **텍스트 stub 파일** 체크아웃 |
| config false (기본값) | false | — | ❌ symlink가 텍스트 파일로 저장됨 (위와 동일 증상) |
| 관리자 권한 + Group Policy | true | OFF | ⚠️ `SeCreateSymbolicLinkPrivilege` 필요 — 기업 환경에서 흔함 |

**대안 평가 결과** (면밀 분석 세션):
- Hardlink (`mklink /H`): 같은 볼륨만, git은 별개 파일로 인식 → sync 효과 X
- Junction (`mklink /J`): 파일 불가 (디렉토리만)
- **복사 + 동기화 스크립트**: OS 중립, drift는 hash 비교로 감지 가능 → **fallback으로 채택**

## 목표

- [ ] **AGENTS.md 채택 규약 문서** — `bootstrap/docs/AGENTS_MD_STRATEGY.md` 신규. source of truth 선언 + symlink/복사 이중 전략 + Windows 블로커 대응 + 도구별 precedence 매핑
- [ ] **OWNERSHIP.md Evolution 조항 확장** — AGENTS.md 표준 채택이 S1/S2 scope에 미치는 영향 명시
- [ ] **파일명 canonical 매핑 매트릭스** — AGENTS.md ↔ CLAUDE.md / GEMINI.md / .cursor/rules/main.mdc / .github/copilot-instructions.md / `CONVENTIONS.md` (Aider) 대응
- [ ] **Drift 감지 규약** — 복사 fallback 시 파일 간 해시 비교 로직 스펙 (실구현은 v1.21-cross-platform-install)
- [ ] **Claude Code 특수 처리** — CLAUDE.md가 AGENTS.md의 symlink/복사본인 상태에서 Claude-특수 override가 필요한 경우의 규약 (`CLAUDE.override.md` 패턴 제안)
- [ ] **언어 정책** — D3 영문 기본 + `AGENTS.ko.md` 등 locale suffix 규약
- [ ] **CLAUDE.md / README.md 갱신** — 본 문서 링크 추가
- [ ] 본 세션 REPORT — 결정사항 + 차기 adapter 세션으로의 전달 요약

## 범위

**포함**:
- AGENTS.md를 "harness-meta가 배포하는 source of truth"로 선언하는 규약 문서
- symlink/복사 이중 전략의 **규약 레벨 결정** (실제 install 스크립트 구현은 v1.21)
- 모든 지원 예정 adapter(7개 Tier 1 + 3개 Tier 2)의 파일명 매핑
- Claude Code 특수 처리 (CLAUDE.md와의 관계)
- 언어(영문/한국어) locale 정책

**제외** (T4 분할 원칙):
- `install.ps1` / `verify.ps1` **실제 symlink 자동 감지 구현** → v1.21-cross-platform-install
- 각 adapter별 `adapter.yaml` capabilities 스펙 구체화 → v1.14~v1.20 각 adapter 세션
- `core/` 디렉토리 재구성 → v1.8-core-adapter-split
- Manifest v1.1 `[agents]` 섹션 스키마 → v1.7-manifest-schema-v1.1
- `bootstrap/templates/` 안에 AGENTS.md 템플릿 작성 → v1.11~v1.13 bootstrap-templates
- `~/harness-meta/AGENTS.md` 신규 작성 (본 repo 자체 AGENTS.md) → **규약 확정 후 차기 세션** (예: v1.5b-repo-agents-md-apply)
- 기존 `CLAUDE.md`를 AGENTS.md로 전환 → 동일 (후행 적용 세션)

## 변경 대상

### 신규 파일 (1)

| 경로 | scope | 역할 |
|------|-------|------|
| `~/harness-meta/bootstrap/docs/AGENTS_MD_STRATEGY.md` | S2 | AGENTS.md 표준 채택 단일 소스. 규약 + 파일명 매핑 매트릭스 + Windows 대응 + locale 정책 |

### 수정 파일 (3)

| 경로 | scope | 변경 내용 |
|------|-------|----------|
| `~/harness-meta/bootstrap/docs/OWNERSHIP.md` | S2 | "Evolution 조항"에 AGENTS.md 채택이 S1/S2/S4에 미치는 영향 + `.agents/skills/` 표준 경로 언급 추가. 약 10~15줄 |
| `~/harness-meta/CLAUDE.md` | S3 | 관련 문서 섹션에 `@bootstrap/docs/AGENTS_MD_STRATEGY.md` 링크 추가 |
| `~/harness-meta/README.md` | S3 | 관련 문서 섹션에 AGENTS.md 전략 문서 링크 추가 |

### 세션 기록 (2)

| 경로 | 역할 |
|------|------|
| `~/harness-meta/sessions/meta/v1.5-agents-md-strategy/PLAN.md` | 본 파일 |
| `~/harness-meta/sessions/meta/v1.5-agents-md-strategy/REPORT.md` | 구현 후 작성 |

## AGENTS_MD_STRATEGY.md 구조 (예정 목차)

1. **결정 (Decision)** — AGENTS.md를 source of truth로 채택
2. **배경 (Why)** — 오픈표준 생태계, 60,000+ 채택, Claude Code 이슈 진행 상태
3. **파일명 매핑 매트릭스** — adapter × canonical 파일명 표
4. **이중 배포 전략** — symlink (primary) + 복사 (fallback)
   - 4.1 symlink 생성 조건 (OS + permission)
   - 4.2 복사 fallback 조건
   - 4.3 Drift 감지 알고리즘 (파일 SHA-256 비교)
5. **Windows 특수 처리** — Dev Mode / `core.symlinks` / Group Policy 분기
6. **Claude Code 공존** — CLAUDE.md가 AGENTS.md로 수렴하는 3가지 시나리오
7. **override 패턴** — `CLAUDE.override.md` / `GEMINI.override.md` (도구 전용 지시)
8. **locale 정책** — `AGENTS.md` 영문 기본, `AGENTS.ko.md` / `AGENTS.ja.md` 번역본은 reference only (법적 효력·도구 우선순위 영문)
9. **SKILL.md 표준 경로** — `.agents/skills/` 채택, Claude Code는 `.claude/skills/` 유지(junction 또는 복사)
10. **마이그레이션 가이드** — 기존 CLAUDE.md only 프로젝트가 AGENTS.md로 전환하는 단계
11. **검증** — `verify.ps1`이 확인할 항목 (파일 존재 / symlink 무결성 / drift 감지)
12. **로드맵 연계** — v1.6~v2.0 각 세션에서 본 규약을 어떻게 적용하는지 참조 표

## 파일명 매핑 매트릭스 (확정)

| Canonical | Adapter | 대응 경로 (프로젝트 루트 기준) | 배포 방식 |
|-----------|---------|-----------------------------|----------|
| `AGENTS.md` | 표준 (모든 지원 도구) | `AGENTS.md` | **source of truth** |
| `AGENTS.md` | Claude Code | `CLAUDE.md` | symlink (primary) / copy (fallback) |
| `AGENTS.md` | Gemini CLI (Android Studio 등) | `GEMINI.md` | symlink / copy |
| `AGENTS.md` | GitHub Copilot | `.github/copilot-instructions.md` | symlink / copy |
| `AGENTS.md` | Cursor (rules 디렉토리) | `.cursor/rules/main.mdc` | symlink (상대경로 `../../AGENTS.md`) / copy |
| `AGENTS.md` | Aider | `CONVENTIONS.md` | symlink / copy |
| `AGENTS.md` | Windsurf | `.windsurfrules` 또는 `.windsurf/rules/main.md` | symlink / copy (Windsurf도 native AGENTS.md 지원이라 symlink만으로 충분 가능) |
| `AGENTS.md` | Cline | `.clinerules/main.md` | symlink / copy |
| `.agents/skills/` | 표준 | `.agents/skills/` | source of truth 디렉토리 |
| `.agents/skills/` | Claude Code | `.claude/skills/` | junction (Windows dir symlink) / copy 디렉토리 |

**override 파일** (각 도구 전용 추가 지시, symlink 없이 독립 파일로 공존):
- `CLAUDE.override.md` — Claude Code만 읽음 (기존 CLAUDE.md 패턴 연장)
- `GEMINI.override.md` — Gemini 전용
- `.cursor/rules/override.mdc` — Cursor 전용

## 이중 배포 전략 (확정)

### Primary: Symlink

```
(macOS / Linux)
ln -sfn AGENTS.md CLAUDE.md
ln -sfn AGENTS.md .github/copilot-instructions.md
mkdir -p .cursor/rules && ln -sfn ../../AGENTS.md .cursor/rules/main.mdc

(Windows Dev Mode + core.symlinks=true)
New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md
```

**감지**: `fs.lstat` → `LinkType: SymbolicLink` + `Target` resolve 후 AGENTS.md와 동일 inode / 경로.

### Fallback: Copy + Sync Script

```
# sync-agents.{ps1, sh} (v1.21에서 실제 구현)
1. SHA-256(AGENTS.md) 계산
2. 대응 파일(CLAUDE.md 등)의 SHA-256 비교
3. 불일치 시:
   (a) 사용자 정책 = "source-wins" → AGENTS.md → 복사 덮어쓰기
   (b) 사용자 정책 = "warn-and-prompt" → 경고 출력 + 수동 해결 대기
```

### Drift 감지 알고리즘

- 매 `verify.ps1` 실행 시 canonical 파일 + 매핑 파일의 SHA-256 대조
- 불일치 건수를 `[WARN]`으로 표시, exit code는 유지(drift는 경고지 실패 아님 — 사용자가 override 의도적으로 쓸 수 있음)
- symlink 상태면 drift 검증 skip (같은 파일 참조)

### 혼용 금지

- symlink 방식과 복사 방식을 **한 repo 내 혼재 금지** — 일관성 깨짐
- `install.ps1`이 "이 repo는 symlink 모드" 또는 "복사 모드"를 `.harness-mode` 파일에 기록 (v1.21)

## Grey Areas — 결정 사항

| ID | 질문 | 결정 | 근거 |
|----|------|------|------|
| G1 | AGENTS.md 영문 vs 한국어 | **영문 기본** | AI 모델들의 영문 학습 데이터 압도적. 번역본은 `AGENTS.ko.md`로 별도 제공 (reference only, 법적/기술 우선순위는 영문) |
| G2 | Claude Code가 AGENTS.md 네이티브 지원하게 되면 | **그 시점에 CLAUDE.md symlink 제거 세션** 진행 예정 (`sessions/meta/vX-claude-native-agents/`). 현재는 이중 유지 |
| G3 | `.claude/skills/` vs `.agents/skills/` | **`.agents/skills/` 표준 채택** + Claude Code 호환은 **junction(Windows) / symlink(Unix)**로 `.claude/skills/` 제공. 복사 모드 시 양 디렉토리 동기화 |
| G4 | `CLAUDE.md`가 override 파일인가, symlink 대상인가 | **기본은 symlink 대상** (AGENTS.md 그대로). Claude 전용 지시가 필요하면 **별도 `CLAUDE.override.md`** 패턴 (도구가 둘 다 읽음 — precedence는 "AGENTS.md baseline + override") |
| G5 | override 파일이 없으면? | symlink 대상 AGENTS.md만 존재. 정상 |
| G6 | Cursor의 `.cursor/rules/*.mdc` frontmatter | **`main.mdc`는 AGENTS.md symlink**, 추가 `.mdc`는 adapter-specific override (`alwaysApply: true` 등). v1.14-adapter-cursor에서 확정 |
| G7 | Gemini가 `GEMINI.md` > `AGENTS.md` precedence | **GEMINI.md를 AGENTS.md symlink로 두면 중복 제거**. GEMINI-특수 지시는 `GEMINI.override.md`에 |
| G8 | Aider `CONVENTIONS.md` | `.aider.conf.yml`의 `read: CONVENTIONS.md` 유지하되 **`CONVENTIONS.md`가 AGENTS.md symlink**. 도구는 `CONVENTIONS.md`를 읽음 |
| G9 | Monorepo의 nested AGENTS.md | 2026-04 AGENTS.md 표준이 공식 지원 (subdirectory `AGENTS.md`가 local scope에 적용, 가장 가까운 파일 우선). **동일 규약 채택**. 각 sub-package가 독자 AGENTS.md 가능 |
| G10 | symlink 상대경로 vs 절대경로 | **상대경로** (예: `.cursor/rules/main.mdc` → `../../AGENTS.md`). 절대경로는 OS 이식성 깨짐 |
| G11 | README.md와 AGENTS.md 역할 분리 | README.md = 인간 대상 프로젝트 소개. AGENTS.md = AI 에이전트 대상 프로젝트 컨텍스트. 내용 중복 최소화 권장 (AGENTS.md의 summary를 README.md가 참조 or vice versa) |
| G12 | 본 repo 자체의 AGENTS.md 작성 | **본 세션 범위 외**. 규약 확정 후 별도 후행 세션 `v1.5b-apply-agents-md-to-harness-meta`에서 실적용 (OWNERSHIP T4 크로스 커팅 분할) |
| G13 | 기존 projects/upbit/CLAUDE.md 변경 | **upbit 소유** (S4/S6) — sessions/upbit/vX-agents-md-migration/ 별도 세션. 본 meta 세션은 규약만 |
| G14 | SPDX `SKILL-` prefix (2025-12 표준) | SKILL.md frontmatter의 `disable-model-invocation` 등 필드는 **Claude Code 특화** — 표준 SKILL.md는 frontmatter 단순화. **`.agents/skills/` 표준 SKILL.md 형식 채택** + Claude Code 전용 필드는 `disable-model-invocation: true`처럼 도구가 해석 못 하면 무시됨 → 안전 공존 |
| G15 | Drift 감지 실패 시 exit code | **WARN only (exit 0)** — 사용자가 의도적 override 가능. ERR은 symlink mode에서 링크 끊어진 경우만 |
| G16 | locale 파일 Claude Code 매핑 | `CLAUDE.ko.md`를 Claude Code가 읽는가? — 미지원. `CLAUDE.md` 하나만 읽음. **한국어 사용자는 `CLAUDE.md` → `AGENTS.ko.md` symlink** 옵션 제공 (매니페스트에 `locale = "ko"` 필드로 자동 선택) |

## 성공 기준

- [ ] `bootstrap/docs/AGENTS_MD_STRATEGY.md` 신규 — 12개 섹션 모두 존재
- [ ] 파일명 매핑 매트릭스 — Tier 1 adapter 7개 + Tier 2 adapter 3개 모두 포함
- [ ] Windows 분기 3가지(Dev Mode ON / OFF / Group Policy) 명시
- [ ] Drift 감지 알고리즘 의사코드 수준 서술
- [ ] `CLAUDE.override.md` / `GEMINI.override.md` 패턴 제안
- [ ] locale 정책 (영문 기본 + `AGENTS.ko.md` 등) 명시
- [ ] OWNERSHIP.md Evolution 조항 업데이트 (AGENTS.md 채택 영향)
- [ ] CLAUDE.md + README.md에서 본 문서 링크
- [ ] Grey Area 16개 모두 결정 기록 (위 표)
- [ ] 후속 세션 DAG에서 본 규약이 전제인 세션(v1.6~v2.0)을 명시

## 커밋 전략

단일 커밋 (규약 문서 + OWNERSHIP 확장 + 문서 링크 동기화는 원자 단위).

```
docs(meta): sessions/meta/v1.5-agents-md-strategy — AGENTS.md 표준 채택 규약

- add: bootstrap/docs/AGENTS_MD_STRATEGY.md
    (source of truth 선언 / symlink + 복사 이중 전략 /
     Windows Dev Mode 분기 / drift 감지 / adapter 10개 매핑 /
     locale 정책 / SKILL.md .agents/skills/ 표준)
- update: bootstrap/docs/OWNERSHIP.md — Evolution 조항 AGENTS.md 영향 추가
- update: CLAUDE.md — AGENTS_MD_STRATEGY 링크
- update: README.md — AGENTS_MD_STRATEGY 링크
- add: sessions/meta/v1.5-agents-md-strategy/{PLAN,REPORT}.md

Grey Area 16건 결정. D1~D3 반영 (AGENTS.md source of truth,
Windows symlink 이중 전략, 영문 기본 locale).
본 규약은 v1.6~v2.0 모든 adapter/templates/install 세션의 전제.
```

사용자 확인 후 `~/harness-meta` repo에 커밋 + push.

## 후속 세션 연결

### 직접 연계 (본 규약 적용 대상)

- **v1.5b-apply-agents-md-to-harness-meta** (S3) — 본 repo에 AGENTS.md 신규 + CLAUDE.md → AGENTS.md symlink (또는 복사 모드 전환). 규약을 본인 repo에 실적용 (eating our own dogfood)
- **v1.6-language-neutral-claude-layer** (S1) — 기존 `claude/**` 내 Python 하드코딩 제거 시 AGENTS.md 호환 레이어 고려
- **v1.7-manifest-schema-v1.1** (S2) — `[agents]` 섹션이 **primary adapter 선언** 기능 포함. 본 규약의 locale 필드(`locale`)도 이 스키마에 반영
- **v1.8-core-adapter-split** (S1+S2) — `core/` + `adapters/{claude-code, cursor, ...}/` 디렉토리 구조. 본 규약의 파일명 매핑 매트릭스가 adapter별 `adapter.yaml.file_mapping` 필드로 구현됨
- **v1.21-cross-platform-install** (S3) — symlink/복사 **자동 분기 로직** 실제 구현. 본 규약의 알고리즘이 코드화됨
- **v1.14~v1.20 adapter 세션 7개** — 각 adapter의 symlink target / override 파일 규약 세부화

### 의존성 다이어그램

```
v1.5 AGENTS.md 전략 (본 세션)
  ├─ v1.5b: 본 repo 적용 (즉시 가능)
  ├─ v1.7: manifest schema 1.1 [agents] 섹션 설계 기반
  ├─ v1.8: core-adapter-split의 파일명 매핑 공급
  ├─ v1.11~v1.13: bootstrap templates이 AGENTS.md + override 패턴 포함
  ├─ v1.14~v1.20: 각 adapter 세션이 본 매트릭스 준수
  └─ v1.21: install.ps1/install.sh이 본 알고리즘 구현
```

### 3개월 재평가 게이트

로드맵 전체 기간에 `sessions/meta/vX-ecosystem-audit/` 정기 세션 삽입:
- Claude Code의 AGENTS.md 네이티브 지원 여부 재확인 (이슈 `#6235`, `#34235`)
- Cursor / Gemini / Codex의 구성 파일 스펙 변경 감시
- Biome v3 / uv / Astral 생태계 변동
- 본 규약에 반영 필요하면 Evolution 조항으로 버전 bump
