# AGENTS.md 표준 채택 규약

`sessions/meta/v1.5-agents-md-strategy/`에서 확정. 이후 **모든 adapter · template · install 세션의 전제**.
본 규약은 "하네스가 배포하는 프로젝트 컨텍스트 파일(AGENTS.md)을 어떤 방식으로 각 AI 코딩 도구에 공급하는가"를 단일 소스로 정의한다.

## 1. 결정 (Decision)

### 1-1. Source of truth

**`AGENTS.md`를 하네스의 유일한 프로젝트 컨텍스트 source of truth로 채택한다.**

- 배포 대상 각 프로젝트 루트에 `AGENTS.md` 1개가 실 파일로 존재
- 기존 `CLAUDE.md` / `GEMINI.md` / `.cursor/rules/main.mdc` / `.github/copilot-instructions.md` / `CONVENTIONS.md` 등은 **모두 AGENTS.md로 수렴** (symlink 또는 copy)
- 각 도구 전용 override 지시가 필요하면 `<TOOL>.override.md` 패턴으로 별도 파일 (symlink 대상 아님)

### 1-2. SKILL.md 표준 경로

**`.agents/skills/`를 skill 디렉토리의 표준 경로로 채택한다.**

- 2025-12 SKILL.md 표준 경로 준수 (Claude Code / Cursor / Codex CLI / Gemini CLI / Windsurf / Roo Code 등 12+ 도구 지원)
- Claude Code의 `.claude/skills/`는 junction(Windows) / symlink(Unix)로 `.agents/skills/`에 연결, 또는 복사 모드 시 동기화

### 1-3. 이중 배포 전략

**Symlink (primary) + Copy fallback** 이중 전략. `install` 스크립트가 OS·권한 감지 후 자동 선택.

## 2. 배경 (Why)

### 2-1. 오픈 표준의 부상 (2026-04 기준)

- **AGENTS.md**: Linux Foundation 산하 Agentic AI Foundation이 관리. **60,000+ 프로젝트 채택**
- **네이티브 지원 도구**: OpenAI Codex · Google Jules · Google Gemini CLI · Cursor · Amp · Factory · Devin · Windsurf · GitHub Copilot (2025-08-28부터)
- **Claude Code만 미지원**: 이슈 `anthropics/claude-code#6235` (3,200+ upvote) · `#34235` 진행. 2026 하반기 네이티브 지원 가능성 높음
- **SKILL.md**: 2025-12 공식 표준화. `.agents/skills/` 경로

### 2-2. 전략적 함의

하네스가 범용(cross-tool)성을 극대화하려면:
- Claude Code 전용 `CLAUDE.md` + `.claude/skills/` 구조는 **minority 유지 중**
- 오픈 표준 `AGENTS.md` + `.agents/skills/`를 base로 삼고 **Claude Code는 symlink 호환 레이어**
- 이 전환은 v1.14~v1.20의 각 adapter 세션의 **공통 인터페이스** 확보에 필수

### 2-3. AI 도구 시장 현황 (JetBrains 2026-04 조사)

| 도구 | 업무 adoption | AGENTS.md 지원 | CLAUDE.md 지원 |
|------|-------------|---------------|----------------|
| GitHub Copilot | 29% | ✅ (2025-08~) | — |
| Cursor | 18% | ✅ | ✅ (CLI) |
| Claude Code | 18% | ⏳ 이슈 진행 중 | ✅ |
| Windsurf | 무료 티어 최대 | ✅ | — |
| Codex CLI | 초기 | ✅ | — |
| Gemini CLI | Google 개발자 | ✅ (alias) | — |
| Cline / Roo Code | VSCode | 📎 `.clinerules/` | — |
| Aider | CLI | 📎 `CONVENTIONS.md` | — |

**70%의 엔지니어가 2-4개 도구를 동시 사용** → 단일 컨텍스트 파일 표준화의 실용 가치 높음.

## 3. 파일명 매핑 매트릭스

모든 경로는 **프로젝트 루트 기준 상대경로**.

| Canonical | Adapter / 도구 | 대응 경로 | 배포 방식 |
|-----------|---------------|---------|----------|
| `AGENTS.md` | 표준 (모든 지원 도구) | `AGENTS.md` | **source of truth** |
| `AGENTS.md` | Claude Code | `CLAUDE.md` | symlink (primary) / copy (fallback) |
| `AGENTS.md` | Gemini CLI · Android Studio Gemini · Antigravity | `GEMINI.md` | symlink / copy |
| `AGENTS.md` | GitHub Copilot (repo instruction) | `.github/copilot-instructions.md` | symlink / copy |
| `AGENTS.md` | Cursor (rules 디렉토리) | `.cursor/rules/main.mdc` | symlink (상대경로 `../../AGENTS.md`) / copy |
| `AGENTS.md` | Aider | `CONVENTIONS.md` (+ `.aider.conf.yml`의 `read: CONVENTIONS.md`) | symlink / copy |
| `AGENTS.md` | Windsurf (Cascade) | native 지원. `.windsurfrules`는 override 용도 | (symlink 불필요) |
| `AGENTS.md` | Cline | `.clinerules/main.md` | symlink / copy |
| `AGENTS.md` | Roo Code | `.roo/rules/main.md` | symlink / copy |
| `AGENTS.md` | Continue (config.yaml `rules`) | `file://./AGENTS.md` 참조 | 구성 파일에서 직접 참조 (별도 symlink 불필요) |
| `.agents/skills/` | 표준 | `.agents/skills/` | source of truth 디렉토리 |
| `.agents/skills/` | Claude Code | `.claude/skills/` | junction (Windows) / symlink (Unix) / copy 디렉토리 |

### 3-1. Override 파일 (symlink 없이 독립 공존)

도구 전용 추가 지시가 필요한 경우:

| Override 파일 | 읽는 도구 | 용도 |
|--------------|----------|------|
| `CLAUDE.override.md` | Claude Code (추가 컨텍스트로 주입) | Claude 전용 모델/thinking/subagent 지시 |
| `GEMINI.override.md` | Gemini CLI, Antigravity | GEMINI 전용 safety / tool 설정 |
| `.cursor/rules/override.mdc` | Cursor | Cursor 전용 (`alwaysApply: true` 등 MDC frontmatter) |
| `.windsurfrules` | Windsurf | Cascade-specific 규칙 |
| `.clinerules/override.md` (YAML `paths:` frontmatter) | Cline | 파일 패턴별 조건부 규칙 |

**규약**: override 파일은 **AGENTS.md 내용을 중복하지 않는다**. baseline은 AGENTS.md, 추가·덮어쓰기만 override.

## 4. 이중 배포 전략

### 4-1. Primary: Symlink

**조건 전부 충족 시 symlink 모드**:
- `macOS` 또는 `Linux` → 무조건 symlink
- `Windows` + Developer Mode ON + Git `core.symlinks=true` → symlink
- `Windows` + `SeCreateSymbolicLinkPrivilege` (관리자 또는 Group Policy) → symlink

생성 예시:

```bash
# macOS / Linux
ln -sfn AGENTS.md CLAUDE.md
ln -sfn AGENTS.md .github/copilot-instructions.md
mkdir -p .cursor/rules && ln -sfn ../../AGENTS.md .cursor/rules/main.mdc

# Windows Developer Mode (PowerShell)
New-Item -ItemType SymbolicLink -Path CLAUDE.md -Target AGENTS.md
New-Item -ItemType SymbolicLink -Path GEMINI.md -Target AGENTS.md
New-Item -ItemType Junction -Path .claude\skills -Target .agents\skills
```

**감지** (`verify.ps1`):
- `fs.lstat` → `LinkType: SymbolicLink` (파일) 또는 `Junction` (디렉토리)
- `Target` resolve → canonical 파일(`AGENTS.md`)과 동일 경로
- 상대 symlink는 resolve 후 절대경로 비교

### 4-2. Fallback: Copy + Sync Script

**조건 하나라도 해당 시 copy 모드**:
- Windows Developer Mode OFF + admin 권한 없음
- Git `core.symlinks=false` (기본값 상태)
- 사용자가 `.harness-mode = "copy"` 명시

동작:

```
sync-agents.{ps1, sh}  (실제 구현: v1.21-cross-platform-install)

1. AGENTS.md SHA-256 계산
2. 매핑 대상 파일 각각 SHA-256 계산
3. 불일치 시 정책 분기:
   (a) source-wins       → AGENTS.md → 대상 파일 복사 (덮어쓰기)
   (b) target-wins       → 대상 파일 → AGENTS.md 역복사 (사용자가 대상 파일을 편집한 경우)
   (c) warn-and-prompt   → [WARN] 출력 + 수동 해결 대기 (기본값)
4. 정책 파일 참조: .harness-sync-policy ("source-wins" | "target-wins" | "warn-and-prompt")
```

### 4-3. 혼용 금지

- 한 repo 내 **symlink 모드와 copy 모드 혼재 금지** (일관성 붕괴)
- `install` 스크립트가 `.harness-mode` 파일(`symlink` | `copy`)에 현재 모드를 기록
- 모드 전환은 사용자 명시 `install --mode=<mode>` 호출로만

### 4-4. Drift 감지 알고리즘

```python
# 의사코드 (v1.21 구현 예정)

def detect_drift(project_root: Path) -> DriftReport:
    canonical = project_root / "AGENTS.md"
    canonical_hash = sha256(canonical.read_bytes())

    report = DriftReport()
    for mapping in FILE_MAPPINGS:
        target = project_root / mapping.path
        if not target.exists():
            report.missing.append(target)
            continue

        if mode == "symlink":
            # symlink는 자동으로 같은 파일 참조, drift 불가능
            if not target.is_symlink():
                report.broken_symlink.append(target)
            continue

        # copy mode
        target_hash = sha256(target.read_bytes())
        if target_hash != canonical_hash:
            report.drift.append((target, target_hash, canonical_hash))

    return report
```

**exit code 정책**:
- `symlink 깨짐`: ERR (exit 1) — 재설치 필요
- `drift 감지`: WARN (exit 0) — 사용자가 override 의도적으로 편집했을 수 있음
- `파일 누락`: ERR (exit 1) — 대상 adapter 활성화 상태면 설치 필요

## 5. Windows 특수 처리

### 5-1. 분기 매트릭스

| `core.symlinks` | Developer Mode | admin / Group Policy | 결과 |
|----------------|----------------|---------------------|------|
| true | ON | — | ✅ 정상 symlink |
| true | OFF | admin 권한 또는 `SeCreateSymbolicLinkPrivilege` 정책 | ✅ symlink (자격 충족) |
| true | OFF | 권한 없음 | ❌ `CreateSymbolicLinkW` silent fail — git이 **텍스트 stub** 체크아웃 (파일 내용이 "AGENTS.md" 한 줄) |
| false | — | — | ❌ git이 symlink를 텍스트 파일로 저장 — 위와 동일 증상 |

### 5-2. 대응 절차 (install 스크립트가 수행)

```
1. Windows 여부 감지 ($IsWindows 또는 OS 확인)
2. Git config 확인: `git config --get core.symlinks`
3. Developer Mode 감지: 레지스트리 `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock\AllowDevelopmentWithoutDevLicense == 1`
4. 토큰 특권 확인: `whoami /priv | Select-String "SeCreateSymbolicLinkPrivilege"`
5. 세 조건 모두 충족 → symlink 모드
6. 하나라도 실패 → copy 모드로 전환 + 사용자에게 안내:
   "symlink 생성 불가 (Dev Mode OFF / 권한 부재). copy 모드 진입.
    향후 AGENTS.md 편집 시 `sync-agents.ps1`를 실행해 대응 파일 동기화."
```

### 5-3. 대안 평가 (채택하지 않음)

- **Hardlink** (`mklink /H`): 같은 볼륨만 가능. git은 별개 파일로 인식 → 커밋 후 sync 효과 없음 → 부적합
- **Junction** (`mklink /J`): 파일 불가(디렉토리만). `.agents/skills/ → .claude/skills/`에는 사용 가능하지만 AGENTS.md 단일 파일에는 부적용
- **Group Policy 변경**: 개인 사용자가 수행 어려움 + 기업 환경에서 금지 가능 → install 스크립트가 강요 불가

### 5-4. 복사 모드 사용자에게 주는 메시지

```
[INFO] 복사 모드로 동작 중 (Windows symlink 권한 미충족).
       AGENTS.md 편집 후 `pwsh $HOME/harness-meta/sync-agents.ps1`를 실행하여
       CLAUDE.md / GEMINI.md 등 대응 파일을 동기화하세요.
       또는 pre-commit hook 등록으로 자동화 가능.
```

## 6. Claude Code 공존 — 3가지 시나리오

### 시나리오 A — 현재 (AGENTS.md 미지원)

```
AGENTS.md          ← source of truth (하네스가 생성/유지)
CLAUDE.md          → symlink AGENTS.md
CLAUDE.override.md ← (선택) Claude 전용 지시
```

Claude Code는 `CLAUDE.md`(=AGENTS.md)를 읽고, 있으면 `CLAUDE.override.md`도 함께 읽음.
현재 Claude Code는 CLAUDE.md only이므로 override 파일이 자동 주입되지 않을 수 있음 — **CLAUDE.md 말미에 `@CLAUDE.override.md` import 선언** 또는 override 파일명을 CLAUDE.md가 참조하는 방식으로 통합.

### 시나리오 B — 가까운 미래 (Claude Code가 AGENTS.md 네이티브 지원)

```
AGENTS.md
CLAUDE.override.md (선택적 유지)
```

Claude Code가 `AGENTS.md`를 직접 읽음 → `CLAUDE.md` symlink 제거 가능.
이 시점에 `sessions/meta/vX-claude-native-agents/` 세션 진행 (symlink 정리 + 문서 업데이트).

### 시나리오 C — CLAUDE.md 우선 (legacy 프로젝트 이식)

기존 Claude Code 프로젝트 흡수 시 CLAUDE.md가 이미 풍부한 내용을 가진 경우:

```
CLAUDE.md          ← 기존 source of truth
AGENTS.md          → symlink CLAUDE.md (역방향)
```

다만 AGENTS.md가 canonical인 미래 방향과 **반대**이므로 마이그레이션 세션에서 **CLAUDE.md 내용을 AGENTS.md로 이관** 후 시나리오 A로 전환 권장.

## 7. Override 패턴

### 7-1. 목적

AGENTS.md는 **모든 AI 도구에 동일한 baseline** 전달. 도구별 특수 요구(모델 선택, 고유 hook, 고유 capability)는 별도 override 파일로 분리하여 **중복 없음 + 충돌 방지**.

### 7-2. 각 도구별 override 스펙

| 도구 | Override 파일 | 읽는 방식 |
|------|--------------|----------|
| Claude Code | `CLAUDE.override.md` | `CLAUDE.md` 내부에서 `@CLAUDE.override.md` import |
| Gemini CLI (Antigravity) | `GEMINI.override.md` | `GEMINI.md` precedence → override 파일을 import 또는 appended |
| Cursor | `.cursor/rules/override.mdc` | MDC frontmatter `alwaysApply: true` / `globs: [...]` |
| Windsurf | `.windsurfrules` | Cascade가 자동 로드 |
| Cline | `.clinerules/override.md` | YAML `paths:` frontmatter 조건 |
| Copilot | `.github/copilot-instructions.md`의 추가 섹션 | 단일 파일 내 subsection |
| Aider | `CONVENTIONS.override.md` + `.aider.conf.yml` `read: [CONVENTIONS.md, CONVENTIONS.override.md]` | 여러 파일 nd-load |
| Codex CLI | `AGENTS.md` 하위 디렉토리 (`frontend/AGENTS.md` 등) | 가장 가까운 AGENTS.md 우선 (nested) |

### 7-3. 중복 금지 규약

- Override 파일은 baseline(AGENTS.md)에 이미 있는 규칙을 **반복 선언하지 않는다**
- override 내용은 "추가 지시" 또는 "이 도구의 특별 동작"에 한정
- 사용자가 override 내용과 AGENTS.md 내용이 충돌하게 작성하면 각 도구별 precedence가 결정 (Claude Code: CLAUDE.md 자체 우선, Gemini: GEMINI.md > AGENTS.md, 기타: AGENTS.md baseline)

## 8. Locale 정책

### 8-1. 영문 기본

- `AGENTS.md`: **영문 필수** (AI 모델들의 영문 학습 데이터 압도적 + 오픈소스 표준 언어)
- 번역본: `AGENTS.ko.md` · `AGENTS.ja.md` · `AGENTS.zh.md` 등 locale suffix로 공존 가능
- 번역본은 **reference only** — 법적 효력 및 도구 우선순위는 영문 원본

### 8-2. Claude Code 한국어 사용자 옵션

`CLAUDE.md`를 `AGENTS.ko.md`로 symlink하는 옵션 제공:

```bash
# 사용자가 CLI에서 한국어 선호 명시
pwsh install.ps1 --locale=ko
# → CLAUDE.md → AGENTS.ko.md symlink 생성 (또는 복사)
#   Claude Code가 한국어 CLAUDE.md를 읽음
```

매니페스트 필드로도 선언 가능 (v1.7-manifest-schema-v1.1에서 스키마 확장):

```toml
[project]
name = "my-project"
locale = "ko"
```

### 8-3. 동기화 책임

- 영문 AGENTS.md 편집 시 번역본은 **수동 업데이트** (자동 번역 강제 안 함)
- `sync-agents` 스크립트가 번역본 drift 감지 시 `[WARN]`만 출력 (영문 원본 편집 후 번역 업데이트 상기)

### 8-4. 본 규약의 언어

- 본 `AGENTS_MD_STRATEGY.md` 자체는 **한국어** (프로젝트 `~/harness-meta/` 전체 한국어 유지 맥락)
- `~/harness-meta/AGENTS.md` 최종 작성 시에는 **영문** (v1.5b 세션에서 별도)

## 9. SKILL.md 표준 경로

### 9-1. 채택

`.agents/skills/` — 2025-12 SKILL.md 표준 경로.

지원 도구 (현 시점):
- Claude Code: `.claude/skills/` 별도 경로 유지
- Cursor: `.agents/skills/` 직접 지원
- Codex CLI: `.agents/skills/` 직접 지원
- Gemini CLI: `.agents/skills/` 직접 지원
- Windsurf, Roo Code: `.agents/skills/` 직접 지원

### 9-2. Claude Code 호환

```
.agents/skills/  ← source of truth (표준 경로)
.claude/skills/  → junction (Windows) / symlink (Unix) / copy
```

디렉토리 전체를 연결 (파일 단위 symlink 아님). Windows junction은 관리자 권한 불필요.

### 9-3. SKILL.md frontmatter

표준 frontmatter 필드:
- `name` (필수)
- `description` (필수)

Claude Code 특화 필드 (다른 도구가 해석 못 하면 **조용히 무시**, 안전 공존):
- `disable-model-invocation: true`
- `allowed-tools: [...]`
- `argument-hint: "..."`

도구 전용 필드는 표준 SKILL.md frontmatter에 포함시켜도 됨 — 미지원 도구는 ignore.

## 10. 마이그레이션 가이드 (기존 CLAUDE.md only 프로젝트)

### 10-1. 단계

```
1. AGENTS.md 생성: CLAUDE.md 내용을 그대로 복사 (또는 영문 번역)
2. Claude-특화 섹션 식별:
   - Claude Code만 해석하는 지시 (subagent, skill 호출 등)
   - 이 부분을 CLAUDE.override.md로 분리
3. AGENTS.md의 Claude-특화 내용 제거 (baseline만 유지)
4. CLAUDE.md를 AGENTS.md symlink로 교체:
   rm CLAUDE.md
   ln -s AGENTS.md CLAUDE.md
5. CLAUDE.override.md 말미 확인 — AGENTS.md 내용과 중복 없음
6. verify.ps1 실행 — drift / broken symlink 없음 확인
7. 차기 Claude Code 세션에서 응답 품질 변화 없음을 smoke test
```

### 10-2. 롤백

마이그레이션 결과 문제 발생 시:
```
1. CLAUDE.md를 regular 파일로 복원
2. 이전 AGENTS.md 삭제 (또는 최소 포인터 파일로 축소)
3. 후속 세션에서 재시도
```

git이 symlink 변경을 기록하므로 `git revert <마이그레이션 커밋>`으로 원상복구 가능.

## 11. 검증 (verify.ps1 체크리스트)

`verify.ps1`(및 향후 `verify.sh`)이 확인할 항목:

| # | 체크 | PASS 조건 | 실패 시 |
|---|------|----------|---------|
| A1 | AGENTS.md 존재 | 프로젝트 루트에 파일 | ERR |
| A2 | 배포 모드 일관성 | `.harness-mode`와 실제 파일 상태 일치 | WARN |
| A3 | symlink 무결성 (symlink mode) | 각 매핑 대상이 LinkType=SymbolicLink/Junction + Target resolve 성공 | ERR |
| A4 | Drift 감지 (copy mode) | canonical vs 대상 SHA-256 일치 | WARN |
| A5 | Override 파일 중복 체크 | override가 AGENTS.md 섹션을 완전 복제하지 않음 (heuristic: 80% 이상 substring match 시) | WARN |
| A6 | Locale 파일 presence | `locale = "ko"` 매니페스트 있으면 `AGENTS.ko.md` 존재 | WARN |
| A7 | SKILL.md frontmatter 준수 | `.agents/skills/*/SKILL.md`가 `name` + `description` 최소 필드 | ERR |
| A8 | Broken symlink loop | 순환 참조 (A → B → A) 없음 | ERR |

## 12. 로드맵 연계

본 규약을 **전제로 하는** 후속 세션:

| 세션 | Scope | 본 규약 활용 |
|------|-------|------------|
| v1.5b-apply-agents-md-to-harness-meta | S3 | 본 repo(~/harness-meta/)에 AGENTS.md 실제 적용 |
| v1.6-language-neutral-claude-layer | S1 | hook/statusline 재작성 시 AGENTS.md 참조 |
| v1.7-manifest-schema-v1.1 | S2 | `[agents]` 섹션 + `locale` 필드를 본 규약과 동기 |
| v1.8-core-adapter-split | S1+S2 | 각 `adapters/<tool>/adapter.yaml`에 본 매핑 매트릭스 내재화 |
| v1.11~v1.13 bootstrap-templates | S2 | 각 언어 템플릿이 AGENTS.md 기본 + override 패턴 포함 |
| v1.14~v1.20 adapter-* (7개) | S1 | 각 adapter 세션이 본 매트릭스의 자기 행 구현 |
| v1.21-cross-platform-install | S3 | symlink/copy 자동 분기 + sync-agents 스크립트 구현 |

## 13. Evolution 조항

### 13-1. Claude Code 네이티브 지원 시

- 이슈 `anthropics/claude-code#6235` / `#34235` 종결 + Claude Code 공식 changelog에 AGENTS.md 추가 확인 시
- 세션 `sessions/meta/vX-claude-native-agents/` 진행:
  - `CLAUDE.md → AGENTS.md` symlink 제거 (또는 legacy 호환으로 유지)
  - `CLAUDE.override.md`만 남김
  - 본 문서 §6 시나리오 A → 시나리오 B로 기본 전환

### 13-2. SKILL.md 표준 bump

- `.agents/skills/` 표준 bump (frontmatter 필드 추가 등) 시 본 문서 §9 갱신 + `sessions/meta/vX-skill-spec-update/`

### 13-3. 새 AI 도구 출현

- Antigravity · Amp · 신규 도구가 `AGENTS.md` 변형 포맷을 제시하면 본 문서 §3 매트릭스에 행 추가
- 커뮤니티 기여로도 수용 가능 (PR)

### 13-4. 3개월 재평가 게이트

`sessions/meta/vX-ecosystem-audit/` 정기 세션에서 본 규약 적합성 재확인.

## 14. 관련 문서

- 상위: `../../CLAUDE.md` · `../../README.md`
- 세션 소속 규약: `OWNERSHIP.md` (본 문서와 함께 Evolution 조항 갱신)
- 매니페스트: `../manifest-schema.md` (v1.1부터 `[agents]` 섹션)
- 확정 세션: `../../sessions/meta/v1.5-agents-md-strategy/`
- 외부 표준: [agents.md](https://agents.md/) · [SKILL.md 표준](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)
