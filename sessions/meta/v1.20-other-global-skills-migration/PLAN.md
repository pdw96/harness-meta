# meta v1.20-other-global-skills-migration — PLAN

세션 시작: 2026-04-29
직접 선행 세션:
- [`sessions/meta/v1.19-scorer-skill-distribution/`](../v1.19-scorer-skill-distribution/PLAN.md) — S1c 신규 (`bootstrap/skills/`) + `install-skills.{ps1,sh}` opt-in 배포 인프라 확정
- [`sessions/meta/v1.10j-scope-contract-discipline/`](../v1.10j-scope-contract-discipline/PLAN.md) — Scope contract 의무화

목적: `~/.claude/skills/`에 git 미추적 상태로 존재하는 두 글로벌 user-skill (`mindvault`, `developer-profile`)을 `bootstrap/skills/`로 이관해 source-of-truth 단일화 + 다른 기기 재현 가능 + git history 확보. v1.18b 사례(ai-ready-scorer 57 lines 손실 위험)와 동일 동기.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(2 신규 — `bootstrap/skills/{mindvault,developer-profile}/SKILL.md`) + S2(1 — `bootstrap/docs/SKILLS.md`) + S3(1 — `tests/smoke-skills-install.sh`) = **4/4 meta** (PLAN/REPORT 별도)
- **T1 경로 다수결** — meta scope 4/4
- **T2 스펙 vs 값** — 글로벌 skill 디렉토리 인스턴스 추가 + 디렉토리 규약 evolution (이관 사례 § 추가) → meta

## Scope inheritance (verbatim from 선행 세션)

**Source — 사용자 발의 (2026-04-29) verbatim**:

> "A안" — `v1.20-other-global-skills-migration` 진입 — mindvault 등 다른 글로벌 user-skill 이관 (`bootstrap/skills/`)

이후 추천안 + 디테일 분석 단계에서 **"응"** 확정 (2 skill 이관 + B1-a 분기 채택 + B2 정정 + B3 정정).

**Parsed sub-items (2)**:

1. **mindvault 글로벌 user-skill을 `bootstrap/skills/mindvault/`로 이관** — upstream archived 경고 + multi-line YAML reformat + `disable-model-invocation: true`
2. **developer-profile 글로벌 user-skill을 `bootstrap/skills/developer-profile/`로 이관** — 그대로 (`user-invocable: false` 유지)

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| install-skills.{sh,ps1} 코드 변경 | scope 외 — 현 auto-enumerate (`for d in "$SKILLS_SRC"/*/`) 충분. 디렉토리만 추가하면 자동 노출 |
| graphify 도입 (mindvault 활성 alternative) | 사용자 사용 여부 미확인 → evidence-driven 후속 |
| mindvault 본문 의미 변경 / 새 기능 추가 | re-format only. 의미 변경 동반 시 별 후속 |
| developer-profile 콘텐츠 수정 | 사용자 본인 환경 그대로 유지 (Windows 11 + WSL2 가정 등) |
| `bootstrap/skills/<category>/` 카테고리화 | v1.22 (5+ skill 누적 후) |
| mindvault PyPI archived 영향 mitigation (자체 fork 의존 전환 등) | 별 도메인 — 의미 변경 동반 |
| ai-ready-scorer에 `disable-model-invocation: true` 추가 검토 | 별 후속 (관련 evidence 누적 후) |
| developer-profile 내용을 `~/.claude/CLAUDE.md`로 이관 통합 | 별 도메인 — 위치 분리 의도 (auto-load mechanism) |
| `~/.claude/CLAUDE.md` 글로벌 사용자 instruction 정합화 | scope 외 |
| issue #26251 (disable-model-invocation slash bug) 영향 검증 | 외부 issue — 본 세션 무관 |
| ai-ready-scorer SKILL.md 수정 | scope 외 — 회귀 0 검증만 |
| README.md cross-ref 갱신 | scope 외 — 기존 표기는 SKILLS.md로 위임 형태로 OK (단일 소스 정책) |
| 추가 검토 단계 발견 — `CLAUDE.md` L97 stale (`ai-ready-scorer` 단일 skill 표기 → 3 skill로 확장됨) | **본 세션 추가 포함** (1줄 수정, SKILLS.md §1로 위임 형태로 정정) |

## 1. 문제

### 1.1. 현황 — git 미추적 글로벌 skill 2건

```
~/.claude/skills/
├── ai-ready-scorer  → /c/Users/qkreh/harness-meta/bootstrap/skills/ai-ready-scorer  (v1.19에서 이관 완료 ✓)
├── developer-profile/                                                                (git 미추적 ✗)
│   └── SKILL.md (750 bytes, frontmatter `user-invocable: false`)
└── mindvault/                                                                        (git 미추적 ✗)
    └── SKILL.md (9.7 KB, single-line frontmatter — upstream 형식 그대로)
```

### 1.2. Root cause

- 2 skill 모두 **다른 기기 재현 불가** + **version history 0** + **수정 시 손실 위험**
- v1.19 SKILLS.md §9에 evidence-driven 후속으로 명시: "다른 글로벌 user-skill (mindvault 등) 이관. 사용자 명시 요청 시"
- 사용자 명시 요청 (2026-04-29) 도착 → 본 세션 진행

### 1.3. 외부 evidence 점검 결과 (2026-04-29 수집)

| 항목 | 발견 | 영향 |
|------|------|------|
| **mindvault upstream 상태** | `etinpres/mindvault` **archived 2026-04-14**. 저자 폐기 선언. License MIT. PyPI `mindvault-ai` | B1-a 채택 — 이관 진행 + upstream archived 경고 명시 의무 |
| **mindvault alternative** | `graphify` (graphifyy on PyPI) 활성 유지 | scope 외 (사용자 채택 미확인) |
| **frontmatter spec — `user-invocable` vs `disable-model-invocation`** | 직교(orthogonal). `user-invocable: false` = 메뉴 숨김 + Claude 자동 호출 가능. `disable-model-invocation: true` = Claude 자동 호출 차단 + 사용자 명시 호출만 (Issue #19141 명확화) | developer-profile은 `user-invocable: false` 정확. mindvault는 `disable-model-invocation: true` 추가 (PyPI 설치 + git hook side effect) |
| **install-skills 현 구현** | `for d in "$SKILLS_SRC"/*/` auto-enumerate (sh:60, ps1:141). `--all` / `--list` 동작 중 | R5(매트릭스 확장) scope 제거 — 디렉토리 추가만으로 자동 노출 |

## 2. 결정 (R1 ~ R5)

### R1 — mindvault 이관 + upstream archived 경고 (B1-a 채택)

**위치**: `bootstrap/skills/mindvault/SKILL.md`

**처리**:
- `~/.claude/skills/mindvault/SKILL.md` (single-line frontmatter + 9.7 KB 압축 본문) → multi-line YAML + 정상 markdown 분리 후 보관
- **의미 변경 0** — re-format only. 모든 instruction · 코드 블록 · trigger keyword 보존
- frontmatter 메타블록 추가 (헤딩 직후):
  ```markdown
  > **Upstream**: [etinpres/mindvault](https://github.com/etinpres/mindvault) (archived 2026-04-14, MIT license)
  > **Local divergence (v1.20)**: multi-line YAML frontmatter + markdown reformat. 의미 변경 없음.
  > **Alternative**: [graphify](https://graphify.net/) (active).
  ```
- `disable-model-invocation: true` 추가 — PyPI `pip install mindvault-ai` + git post-commit hook 등 side effect 차단
- license 호환: harness-meta MIT × upstream mindvault MIT ✓

**SKILL.md 최종 frontmatter 형식**:
```yaml
---
name: mindvault
description: Turn any folder into a searchable knowledge base with a graph, wiki, and BM25 index. Three layers — Search (zero tokens) + Graph (relationships) + Wiki (context).
disable-model-invocation: true
---
```

### R2 — developer-profile 이관 (그대로)

**위치**: `bootstrap/skills/developer-profile/SKILL.md`

**처리**:
- `~/.claude/skills/developer-profile/SKILL.md` (750 bytes, multi-line YAML 정상) → byte-for-byte 보존
- `user-invocable: false` 유지 — Claude 자동 로드 + 메뉴 숨김 의도 정확 (context7 spec 정합)
- 콘텐츠 수정 0 — 사용자 본인 환경 그대로 유지

### R3 — `~/.claude/skills/` symlink 교체 (v1.19 패턴 재사용)

순서:
1. `cp -r ~/.claude/skills/mindvault/ ~/harness-meta/bootstrap/skills/mindvault/` (단, R1 reformat 별도 적용)
2. `cp -r ~/.claude/skills/developer-profile/ ~/harness-meta/bootstrap/skills/developer-profile/`
3. `bash install-skills.sh --all` 실행
   - 기존 `~/.claude/skills/{mindvault,developer-profile}/` → `~/.claude/backups/skills/{name}.<ts>/` 자동 backup
   - symlink 생성: `~/.claude/skills/{name}` → `~/harness-meta/bootstrap/skills/{name}`
4. 작동 검증:
   - mindvault: `ls -la ~/.claude/skills/mindvault` → SymbolicLink 확인
   - developer-profile: 동상

### R4 — `bootstrap/docs/SKILLS.md` 갱신

추가 § (2):
- **§ "v1.20 이관 사례 (mindvault + developer-profile)"** — 동기 + upstream archived 경고 + frontmatter 차이 (mindvault `disable-model-invocation` vs developer-profile `user-invocable: false`)
- **§ "사용 가능 skill 목록"** — 표 갱신 (3 skill: ai-ready-scorer + mindvault + developer-profile, 각 trigger + invocation 정책 명시)

기존 § "v1.18b → v1.19 이관 사례 (ai-ready-scorer)"는 그대로 유지. 본 v1.20 사례를 별 § 추가.

### R5 — `tests/smoke-skills-install.sh` 매트릭스 확장

정적 매트릭스 추가 (5 → 7 checks):
- ✓ `bootstrap/skills/mindvault/SKILL.md` 존재 + frontmatter `disable-model-invocation: true` grep
- ✓ `bootstrap/skills/developer-profile/SKILL.md` 존재 + frontmatter `user-invocable: false` grep

기존 dynamic (3 — Linux/macOS only)는 그대로 유지. ai-ready-scorer 단독 install 검증이 회귀 detect.

## 3. 변경 대상 (3 신규 + 2 수정)

### 신규 (3)

| 경로 | scope | 역할 |
|------|------|------|
| `bootstrap/skills/mindvault/SKILL.md` | S1c | R1 — multi-line + reformat + divergence 메타 + `disable-model-invocation: true` |
| `bootstrap/skills/developer-profile/SKILL.md` | S1c | R2 — byte-for-byte 이관 |
| `sessions/meta/v1.20-.../{PLAN,REPORT}.md` | meta | 본 파일 + Stage G |

### 수정 (2)

| 경로 | scope | 변경 |
|------|------|------|
| `bootstrap/docs/SKILLS.md` | S2 | R4 — § "v1.20 이관 사례" + § 사용 가능 skill 표 갱신 |
| `tests/smoke-skills-install.sh` | S3 | R5 — 정적 7 checks (5 + 2 신규) |

## 4. 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성 + 외부 evidence 반영 + B1-a/B2/B3 정정
- [ ] **사용자 진입 확인**
- [ ] Stage A — `bootstrap/skills/mindvault/SKILL.md` 신규 (R1)
- [ ] Stage B — `bootstrap/skills/developer-profile/SKILL.md` 신규 (R2)
- [ ] Stage C — `bash install-skills.sh --all` 실행 + symlink 검증 (R3)
- [ ] Stage D — `bootstrap/docs/SKILLS.md` 갱신 (R4)
- [ ] Stage E — `tests/smoke-skills-install.sh` 매트릭스 확장 (R5)
- [ ] Stage F — 작동 검증 (mindvault PyPI import + developer-profile auto-load)
- [ ] Stage G — REPORT.md
- [ ] 사용자 확인 후 커밋

## 5. 성공 기준

- [ ] `bootstrap/skills/mindvault/SKILL.md` 존재 + multi-line YAML + 본문 markdown 정상 + upstream divergence 메타 + `disable-model-invocation: true`
- [ ] `bootstrap/skills/developer-profile/SKILL.md` 존재 + `user-invocable: false` 유지
- [ ] **의미 변경 0** — 양 SKILL의 instruction · code block · trigger 모두 보존 (re-format only)
- [ ] `bash install-skills.sh --list` 출력에 3 skill 모두 노출 (ai-ready-scorer + mindvault + developer-profile)
- [ ] `~/.claude/skills/{mindvault,developer-profile}` symlink 작동 (backup → symlink 교체 완료)
- [ ] `bootstrap/docs/SKILLS.md`: § "v1.20 이관 사례" + § 사용 가능 skill 표 갱신 + upstream archived 경고
- [ ] `tests/smoke-skills-install.sh` 7 정적 + 3 dynamic = 10/10 PASS
- [ ] **회귀 0** — ai-ready-scorer install 영향 0 (smoke dynamic 3 PASS)
- [ ] **upbit 영향 0** — `bootstrap/skills/`는 글로벌 user-skill source-of-truth. 프로젝트별 `<proj>/.claude/skills/`는 별 경로

## 6. 커밋 전략

```
feat(meta): sessions/meta/v1.20-other-global-skills-migration — mindvault + developer-profile 글로벌 user-skill 이관

- add: bootstrap/skills/mindvault/SKILL.md (R1 — multi-line YAML reformat + upstream archived 경고 + disable-model-invocation:true)
- add: bootstrap/skills/developer-profile/SKILL.md (R2 — byte-for-byte 이관, user-invocable:false 유지)
- update: bootstrap/docs/SKILLS.md (R4 — § v1.20 이관 사례 + § 사용 가능 skill 표 갱신)
- update: tests/smoke-skills-install.sh (R5 — 정적 5 → 7 checks)
- add: sessions/meta/v1.20-.../{PLAN,REPORT}.md

Scope: 글로벌 user-skill 2건 source-of-truth 이관 (B1-a 채택).
- mindvault upstream archived 2026-04-14 — 경고 명시 + 의미 변경 0 (re-format only)
- developer-profile 그대로 이관 (user-invocable:false 자동 로드 의도 보존)
- install-skills 코드 변경 0 (auto-enumerate 충분)

Smoke: 7/7 정적 + 3/3 dynamic PASS. 회귀 0 — ai-ready-scorer install 영향 0.
upstream evidence: github.com/etinpres/mindvault (archived 2026-04-14, MIT) + Issue #19141 (frontmatter spec 명확화)
```

## 7. 후속 분기

| 후속 세션 | 조건 / 내용 |
|-----------|---|
| `v1.20b-graphify-evaluation` | mindvault alternative graphify 도입 검토. 사용자 사용 의향 확인 시 |
| `v1.21-cross-platform-install` | install-skills + sync-agents 통합. macOS/Linux dynamic 확장 |
| `v1.22-skills-categories` | `bootstrap/skills/<category>/<name>/` 2단계 구조. 5+ skill 누적 후 |
| `vX-mindvault-self-fork` | mindvault PyPI archived 영향 mitigation. PyPI unpublish 발생 시 evidence-driven |

## 8. Lessons Forward (예상)

- **L1 — 이관 전 외부 upstream 상태 검증 의무** — mindvault archived 사례. 추천안 작성 시 web search 부재로 위배 사항 누락. PLAN 작성 단계에서 context7 + web search 병행 정형화
- **L2 — frontmatter 직교 필드 정확 매칭** — `user-invocable` vs `disable-model-invocation`은 의미 다름. skill 의도(자동 로드 / side effect 보호)에 따라 선택
- **L3 — install 인프라 재독해 후 scope 결정** — auto-enumerate 이미 동작 시 매트릭스 작업 불필요. 추천안 R5 over-engineering 발견
- **L4 — re-format은 의미 변경 0 의무** — upstream divergence 명시 + 본문 instruction 보존. 향후 갱신 시 추적 가능
