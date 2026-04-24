# meta v1.5-agents-md-strategy — REPORT

세션 기간: 2026-04-24 (단일 세션)
세션 범위: AGENTS.md 오픈 표준 채택 규약 확정 + symlink/copy 이중 배포 전략 + 파일명 매핑 매트릭스
판정: **PASS** (성공 기준 10/10 충족)

**세션 소속 (self-apply)**: `sessions/meta/`
**근거**: 변경 파일 4건 — S2(`bootstrap/docs/AGENTS_MD_STRATEGY.md`, `bootstrap/docs/OWNERSHIP.md`) + S3(`CLAUDE.md`, `README.md`). **T1 경로 다수결** + **T2 스펙 범주**(AGENTS.md 채택 자체가 repo-global 규약) → meta 소유 확정.

## 최종 결과

- **신규 파일 1**: `bootstrap/docs/AGENTS_MD_STRATEGY.md` (14 섹션, 10 adapter 매핑, Grey Area 16건 결정)
- **수정 파일 3**: `bootstrap/docs/OWNERSHIP.md` (Evolution 조항 확장), `CLAUDE.md` (링크 2곳), `README.md` (링크 1곳)
- **세션 기록 2**: `PLAN.md` / 본 REPORT
- **법적/기술 전제 없음**: v1.4-license-mit에서 MIT 확정 후라 배포·기여 법적 장벽 제거된 상태에서 규약 수립

## 구현 요약 (PLAN 목표 대조)

| # | 목표 | 결과 | 구현 위치 |
|---|------|------|----------|
| 1 | AGENTS.md 채택 규약 문서 (source of truth + symlink/copy + Windows + precedence) | ✅ | `AGENTS_MD_STRATEGY.md` §1~§6 |
| 2 | OWNERSHIP.md Evolution 조항 확장 | ✅ | `OWNERSHIP.md:119-125` (신규 섹션) |
| 3 | 파일명 canonical 매핑 매트릭스 (Tier 1 + Tier 2 adapter) | ✅ | §3 — 10 adapter + `.agents/skills/` |
| 4 | Drift 감지 규약 (SHA-256 비교 알고리즘) | ✅ | §4-4 (의사코드) |
| 5 | Claude Code 특수 처리 (`CLAUDE.override.md` 패턴) | ✅ | §6 (3 시나리오) + §7 (Override 패턴) |
| 6 | Locale 정책 (영문 기본 + `AGENTS.ko.md`) | ✅ | §8 |
| 7 | CLAUDE.md / README.md 갱신 | ✅ | 각 파일 링크 2곳 / 1곳 |
| 8 | Grey Area 16건 결정 | ✅ | PLAN G1~G16 표 |
| 9 | SKILL.md 표준 경로 `.agents/skills/` 채택 | ✅ | §9 |
| 10 | 로드맵 연계 (v1.5b ~ v2.0) | ✅ | §12 + §13 Evolution |

**완수율**: 10/10 (100%).

## 핵심 결정사항 요약

### D1. AGENTS.md source of truth

- 프로젝트 루트 `AGENTS.md` 1개가 canonical
- 기존 `CLAUDE.md` · `GEMINI.md` · `.github/copilot-instructions.md` · `CONVENTIONS.md` · `.cursor/rules/main.mdc` · `.clinerules/main.md` 전부 AGENTS.md로 **수렴** (symlink 또는 copy)
- 도구 전용 override는 `<TOOL>.override.md` 패턴으로 분리

### D2. 이중 배포 (Symlink primary + Copy fallback)

- **Symlink 조건**: macOS/Linux 무조건 · Windows는 Dev Mode ON + `core.symlinks=true` + 특권 충족
- **Copy 조건**: 위 조건 미충족 시
- 모드 전환 금지 (한 repo 내 혼재 금지), `.harness-mode` 파일이 현재 모드 기록
- Drift 감지: SHA-256 비교. WARN 수준 (사용자 override 가능성)

### D3. Windows 분기 매트릭스

| core.symlinks | Dev Mode | 특권 | 결과 |
|---------------|----------|------|------|
| true | ON | — | ✅ symlink |
| true | OFF | `SeCreateSymbolicLinkPrivilege` 보유 | ✅ symlink |
| true | OFF | 없음 | ❌ copy mode 진입 |
| false | — | — | ❌ copy mode 진입 |

### D4. Adapter별 파일명 매핑 (10개)

Claude Code / Gemini CLI / GitHub Copilot / Cursor / Aider / Windsurf / Cline / Roo Code / Continue / 표준 — 각 경로 확정 (§3 매트릭스).

### D5. `.agents/skills/` 표준 + Claude Code junction

- canonical: `.agents/skills/`
- Claude Code: `.claude/skills/` → junction(Windows) / symlink(Unix) / copy
- SKILL.md frontmatter: 표준은 `name` + `description`만, 도구별 확장 필드는 미지원 도구가 무시 (안전 공존)

### D6. Locale 정책

- `AGENTS.md` 영문 기본 (AI 영문 학습 데이터 압도적)
- 번역본은 `AGENTS.ko.md` · `AGENTS.ja.md` 등 suffix, reference only
- Claude Code 한국어 사용자: `--locale=ko`로 `CLAUDE.md → AGENTS.ko.md` symlink 선택 가능

### D7. Override 패턴

- `CLAUDE.override.md` / `GEMINI.override.md` / `.cursor/rules/override.mdc` / `.windsurfrules` / `.clinerules/override.md` 등
- baseline(AGENTS.md) 내용 중복 금지. 추가·덮어쓰기만.

### D8. 마이그레이션 (기존 CLAUDE.md only 프로젝트)

7단계 (§10-1): AGENTS.md 생성 → Claude-특화 분리 → CLAUDE.md symlink화 → override 파일 중복 제거 → verify → smoke test.

## OWNERSHIP.md 확장 검증

`OWNERSHIP.md:119-125`에 신규 "AGENTS.md 오픈 표준 채택 시" 섹션 추가. 영향 정리:

- **S1 확장 예정**: `claude/**` → `adapters/{claude-code, cursor, codex-cli, gemini-cli, windsurf, cline, aider}/**` (v1.8)
- **S2 확장**: `AGENTS_MD_STRATEGY.md` 추가
- **S4**: 영향 없음 (프로젝트 아키텍처 문서는 AGENTS.md와 별개)
- **S6**: 프로젝트의 `AGENTS.md` / `CLAUDE.md` / `GEMINI.md`는 S6. 스펙은 meta / 적용은 각 project (T4 분할).

## 판정 (PLAN 성공 기준)

| 기준 | 결과 | 증거 |
|------|------|------|
| AGENTS_MD_STRATEGY.md 신규 + 12 섹션 | ✅ | 실제 14 섹션 (추가 §13 Evolution, §14 관련 문서) |
| Tier 1 7 + Tier 2 3 adapter 모두 매핑 | ✅ | §3 표 — 10개 adapter + 표준 |
| Windows 분기 3가지 명시 | ✅ | §5-1 매트릭스 |
| Drift 감지 알고리즘 의사코드 | ✅ | §4-4 |
| `CLAUDE.override.md` / `GEMINI.override.md` 패턴 | ✅ | §7-2 표 |
| Locale 정책 (영문 기본 + `AGENTS.ko.md`) | ✅ | §8 |
| OWNERSHIP.md Evolution 조항 업데이트 | ✅ | `OWNERSHIP.md:119-125` |
| CLAUDE.md + README.md 링크 | ✅ | 각 2 / 1 곳 |
| Grey Area 16건 결정 기록 | ✅ | PLAN G1~G16 |
| 후속 세션 DAG 제공 | ✅ | §12 연계 표 + PLAN 후속 세션 섹션 |

**10/10 전부 충족**.

## Lessons Learned

1. **오픈 표준 승기가 Claude Code의 AGENTS.md 미지원에 추격 압력**: 이슈 `#6235` 3,200+ upvote, Windsurf/Cursor/Codex/Copilot 전부 네이티브. Linux Foundation 관리 + 60,000+ 프로젝트 채택. 본 규약의 **시나리오 B 전환**(Claude Code 네이티브 지원 후)은 예상보다 빨리 올 수 있음 → Evolution 조항에 `sessions/meta/vX-claude-native-agents/` 준비.

2. **Windows symlink의 실제 블로커**: Dev Mode OFF + 관리자 아닌 상태가 **기업 환경 기본값**. git `core.symlinks=false`가 default인 Git for Windows 조합에서 symlink가 텍스트 stub으로 저장되는 증상은 사용자 관점에서 "알 수 없는 버그"로 경험됨. 본 규약의 copy fallback은 **선택이 아닌 필수**. v1.21 구현에서 install 스크립트가 silent fallback하지 말고 **명시적 모드 선택**을 요구하도록 해야 함 (사용자 혼란 방지).

3. **Override 패턴이 precedence 충돌 방지의 핵심**: Antigravity/Android Studio Gemini의 `GEMINI.md > AGENTS.md` precedence, Claude Code의 `CLAUDE.md` 우선 등 도구별 precedence 상이. 동일 내용을 여러 파일에 중복 쓰면 **각 도구가 다른 결과 해석** 위험. baseline(AGENTS.md) + 추가 override만 쓰는 규약이 정답. `verify` 체크 A5로 heuristic 중복 감지 수행.

4. **`.agents/skills/` + Claude Code junction 공존 검증 필요**: Windows junction(디렉토리 대상)은 관리자 권한 불필요. 본 규약이 `.claude/skills/` 디렉토리 대응에 junction 채택한 이유. 단 **SKILL.md frontmatter의 도구 전용 필드**(`disable-model-invocation` 등)가 다른 도구에서 조용히 무시되는지는 v1.14~v1.20 adapter 세션에서 smoke test로 검증.

5. **Locale 정책이 한국 사용자 배려와 AI 영문 학습 우위를 병립**: AGENTS.md 영문 필수(도구 인식률 + 오픈 표준) + `AGENTS.ko.md` 번역본 제공(사용자 가독성). Claude Code에만 `CLAUDE.md → AGENTS.ko.md` 옵션 제공 — Claude Code가 한국어 응답 강한 특성 활용. 다른 도구는 영문 강제 (번역본 중복 유지 부담 회피).

6. **본 규약이 v1.6~v2.0 17 세션의 공통 전제**: `§12 로드맵 연계` 표에 7개 세션 나열. 각 세션이 본 규약의 §3 매트릭스 또는 §4 이중 전략을 **자기 scope에서 구현**. 규약을 늦게 확정하면 후속 세션마다 재논의 반복 → v1.5 시점 확정 결정 타이밍 적절.

## Grey Area 결정 사후 검증 (PLAN 16개)

| ID | 결정 | 구현 반영 |
|----|------|----------|
| G1 | AGENTS.md 영문 기본 | ✅ §8-1 |
| G2 | Claude Code 네이티브 지원 시 세션 진행 | ✅ §13-1 Evolution |
| G3 | `.agents/skills/` 표준 + junction 호환 | ✅ §9 |
| G4 | CLAUDE.md는 symlink 대상, override는 `CLAUDE.override.md` | ✅ §6-A + §7-2 |
| G5 | override 파일 없어도 정상 | ✅ §7 전제 |
| G6 | Cursor `main.mdc`는 AGENTS.md symlink, `override.mdc`는 MDC frontmatter | ✅ §3 + §7-2 |
| G7 | Gemini는 GEMINI.md = AGENTS.md symlink + `GEMINI.override.md` | ✅ §3 + §7-2 |
| G8 | Aider `CONVENTIONS.md`가 AGENTS.md symlink, `.aider.conf.yml`이 참조 | ✅ §3 + §7-2 |
| G9 | Monorepo nested AGENTS.md 지원 (가장 가까운 우선) | ✅ Codex CLI 행 §3 + §7-2 |
| G10 | symlink 상대경로 | ✅ §4-1 예시 `../../AGENTS.md` |
| G11 | README.md (인간) / AGENTS.md (AI) 역할 분리 | ✅ §8-4 본 문서 언어 구분 + 차기 세션 |
| G12 | 본 repo의 AGENTS.md 실적용은 v1.5b 별도 세션 | ✅ PLAN 후속 + §12 |
| G13 | upbit/CLAUDE.md 변경은 upbit 소유 (T4 분할) | ✅ PLAN 범위 제외 + §12 |
| G14 | SKILL.md frontmatter 표준(단순) + 도구 확장 필드 공존 | ✅ §9-3 |
| G15 | Drift WARN only (exit 0), broken symlink만 ERR | ✅ §4-4 + §11 체크리스트 |
| G16 | Claude Code 한국어 사용자 `CLAUDE.md → AGENTS.ko.md` | ✅ §8-2 |

**16/16 결정 유지. 구현 중 재논의 없음.**

## 커밋 계획

단일 커밋 (규약 문서 + OWNERSHIP 확장 + 링크 동기화 원자적):

```
docs(meta): sessions/meta/v1.5-agents-md-strategy — AGENTS.md 표준 채택 규약

- add: bootstrap/docs/AGENTS_MD_STRATEGY.md (14 섹션)
    source of truth 선언 · symlink/copy 이중 전략 · Windows 분기 매트릭스
    drift 감지 알고리즘 · adapter 10개 매핑 · override 패턴
    locale 정책 · .agents/skills/ 표준 · 마이그레이션 가이드
    verify 체크리스트 · 로드맵 연계 · Evolution 조항
- update: bootstrap/docs/OWNERSHIP.md — AGENTS.md 채택 Evolution 조항 추가
- update: CLAUDE.md — AGENTS_MD_STRATEGY 링크 (2곳)
- update: README.md — AGENTS_MD_STRATEGY 링크 + 최신 meta 세션 갱신
- add: sessions/meta/v1.5-agents-md-strategy/{PLAN,REPORT}.md

Grey Area 16건 결정. D1~D3 반영.
본 규약은 v1.6~v2.0 모든 adapter/templates/install 세션의 전제.
차기 세션 후보: v1.5b-apply-agents-md-to-harness-meta (본 repo 실적용).
```

사용자 확인 후 `~/harness-meta` repo에 커밋 + push.

## 후속 세션 연결

### 직접 연계 (본 규약 적용 대상)

| 순위 | 세션 ID | Scope | 본 규약 활용 |
|-----|---------|-------|------------|
| 1 | v1.5b-apply-agents-md-to-harness-meta | S3 | 본 repo에 AGENTS.md 실적용 (dogfooding) |
| 2 | v1.6-language-neutral-claude-layer | S1 | hook/statusline Python 하드코딩 제거 |
| 3 | v1.7-manifest-schema-v1.1 | S2 | `[agents]` + `locale` 필드 스키마 |
| 4 | v1.8-core-adapter-split | S1+S2 | adapter 디렉토리 구조 + 파일 매핑 내재화 |
| 5 | v1.9-project-auto-detect | S2 | language/PM/test_cmd 감지 (v1.7 병행 가능) |
| 6 | v1.10-bootstrap-interview | S2 | 인터뷰 템플릿 |
| 7-9 | v1.11~v1.13 bootstrap-templates-* | S2 | 각 언어 템플릿이 AGENTS.md + override 포함 |
| 10-16 | v1.14~v1.20 adapter-* (7개) | S1 | 각 adapter가 본 매트릭스의 자기 행 구현 (완전 병렬 가능) |
| 17 | v1.21-cross-platform-install | S3 | symlink/copy 자동 분기 구현 |
| 18 | v1.22-bootstrap-e2e-orchestration | S1+S2 | 전체 통합 |
| 19 | v1.23-polyglot-monorepo-support | S2 | turborepo/pnpm-workspace/cargo-workspace |
| 20 | v1.24-community-tier2-tier3-scaffold | S2 | Ruby/PHP/Swift/Elixir/Kotlin 뼈대 |
| 21 | **v1.25-opensource-readiness** | S3 | CONTRIBUTING/SECURITY/CHANGELOG/.github/ (최종) |
| 22 | **v2.0-harness-core-extraction** (L3) | S5→S1 승격 | `scripts/harness/` 이관 + 타 언어 runtime 스펙 |

### 3개월 재평가 게이트

로드맵 전체 기간에 `sessions/meta/vX-ecosystem-audit/` 정기 세션 삽입:
- Claude Code의 AGENTS.md 네이티브 지원 여부 (`#6235`, `#34235`)
- SKILL.md 표준 bump
- Cursor Hooks beta → GA 전환
- Biome v3 · uv · Astral 생태계 변동
- 본 규약에 반영 필요하면 Evolution 조항으로 버전 bump

**백로그는 자동 후행 아님**. 사용자가 명시적 command 호출 시 진행.
