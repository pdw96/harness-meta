# GUARDRAILS — harness-meta repo 자체 행동 가드레일

본 파일은 `~/harness-meta/` repo **자체 개선 세션** (`/harness-meta` 또는 `/harness-meta meta` 진입) 시 AI 에이전트가 따를 행동 규칙의 **단일 소스**다.

> **스코프 구분**:
>
> - 본 GUARDRAILS.md = **메타 repo 자체** 세션 (sessions/meta/) 진행 시
> - 프로젝트 repo의 `docs/GUARDRAILS.md` (manifest의 `[harness].guardrails`) = **각 프로젝트 step-level** 주입용
> - 둘은 **독립**. 본 파일은 프로젝트 repo에 배포되지 않음

---

## 1. 목적

- 메타 repo는 **모든 다운스트림 프로젝트에 영향**을 미치는 글로벌 layer (`claude/**`) + bootstrap 자산 (`bootstrap/**`)을 보유
- 한 번의 잘못된 변경이 **다중 프로젝트 회귀**로 확산
- AI 에이전트가 매 세션 위험 작업 패턴을 재발견하지 않도록 **사전 명시 규약** 제공
- 본 파일은 PLAN.md 작성 단계에서 자동 참조 (Scope contract와 함께)

---

## 2. 금지 행동 (Hard rules)

다음은 **명시적 사용자 승인 없이 절대 수행 금지**.

| # | 금지 행동 | 이유 |
|---|----------|------|
| H1 | `sessions/meta/<old-version>/PLAN.md` 또는 `REPORT.md` 직접 수정 | 이력 보존 — 정정은 신규 세션 (e.g., `v1.10b-{topic}-fix`)으로 |
| H2 | `git commit --amend` (published 커밋) | 이력 무결성 — pre-commit hook 실패 시 신규 commit으로 fix |
| H3 | `git push --force` (main branch) | 다른 사용자 작업 손실 위험 |
| H4 | `--no-verify` / `--no-gpg-sign` flag 사용 | pre-commit / signing 우회 = repo 정책 무력화 |
| H5 | `~/.claude/` 직접 편집 | 글로벌 layer는 `install.ps1` symlink로만 갱신. 직접 수정 시 다음 install로 손실 |
| H6 | 외부 프로젝트 repo (upbit 등) 에 직접 commit | T4 후행 세션으로 분할 — `sessions/<project>/vX.Y-{name}/` |
| H7 | `execute.py` 또는 `phases/` 도구 호출 | 메타 세션은 GSD 패턴. phase 세션 인프라는 재귀 회피 위해 미사용 |
| H8 | `.harness.toml` schema **breaking change** without major bump | SemVer 위반 — minor bump (additive only)만 허용. breaking은 `2.0` major bump |
| H9 | 신규 `sessions/**/index.json` 또는 `sessions/**/step{N}.md` 생성 | 메타 세션은 `PLAN.md + REPORT.md` 한 쌍 고정 (재귀 구조 회피) |

---

## 3. 위험 작업 (Confirmation 의무)

다음 변경은 **PLAN.md에 명시 + 사용자 사전 승인** 후 진행.

| # | 위험 작업 | 영향 범위 |
|---|----------|----------|
| C1 | `claude/**` 변경 (글로벌 layer) | 모든 프로젝트 — symlink 통해 즉시 반영 |
| C2 | `bootstrap/templates/_base/**` 변경 | 신규 install 시 모든 프로젝트에 복사 |
| C3 | `bootstrap/templates/<language>/**` overlay 변경 | 해당 언어 프로젝트 신규 install 영향 |
| C4 | `bootstrap/install-project-claude.{sh,ps1}` 변경 | 배포 logic — 회귀 시 모든 install 영향 |
| C5 | `bootstrap/manifest-schema.md` 필드 추가/제거 | 모든 매니페스트 round-trip 영향 |
| C6 | `bootstrap/docs/{OWNERSHIP,AGENTS_MD_STRATEGY,OVERLAY,PERMISSION_PATTERN}.md` 변경 | 규약 단일 소스 — 모든 후속 세션 영향 |
| C7 | 파일 5+ 동시 변경 | scope drift 의심 신호 — Out of scope 표 재확인 |
| C8 | 신규 `sessions/meta/vX.0` major bump | breaking change 가능성 — 마이그레이션 가이드 의무 |

---

## 4. Scope contract 의무

`sessions/meta/v1.10j-scope-contract-discipline/`에서 확정. 모든 PLAN.md 상단에 **3 섹션 의무**:

1. **세션 소속 근거** (3–5줄, S#/T# 명시)
2. **Scope inheritance (verbatim from 선행 세션)** — 선행 sub-item 원문 인용. 변형·해석·umbrella 확장 금지
3. **Out of scope (explicit rejection)** — 인접 발견 issue를 표로 명시. 빈 표 = "없음" 명시 선언 / 부재 = 규약 위반

**위반 정책**:

- 두 섹션 (Scope inheritance + Out of scope) 중 하나라도 누락 → PLAN 거부
- Scope inheritance에 없는 항목을 본문에서 구현 → over-scope, Out of scope 표로 이관 후 재확인
- 구현 중 신규 발견 issue → Out of scope 표 즉시 갱신 (post-hoc 허용, 사후 누락 금지)

---

## 5. Smoke 회귀 의무

- `tests/smoke-*.sh` 영향 변경 시 **본 세션에서 PASS 확인 후 커밋** (Stage G 또는 별도 stage)
- CI (`.github/workflows/ci.yml`) 실패 시 **force-merge 금지** — 사용자 명시 승인 외
- 신규 도메인 추가 시 smoke 신설 권장 (e.g., `tests/smoke-{domain}.sh`)
- 기존 smoke 변경 시 PLAN의 변경 대상 표에 명시 + REPORT의 회귀 확인 결과 기록

---

## 6. References

- 변경 이력: [`CHANGELOG.md`](CHANGELOG.md)
- 메인 진입점: [`CLAUDE.md`](CLAUDE.md) · [`README.md`](README.md) · [`AGENTS.md`](AGENTS.md)

---

## Evolution

본 가드레일은 **규약 위반 사례**가 발생할 때마다 신규 룰 추가 또는 기존 룰 명료화 방식으로 진화한다. 변경은 `sessions/meta/vX.Y-guardrails-{topic}/` 별도 세션에서 수행 (S3 scope).
