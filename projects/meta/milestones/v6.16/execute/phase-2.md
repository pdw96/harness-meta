# v6.16 phase-2 — skills/stage-open + skills/stage-propose 2 SKILL.md 추가

## Spec

```json
{
  "phase": 2,
  "title": "skills/stage-open + skills/stage-propose 2 SKILL.md 신규 추가 — frontmatter (name + description trigger narrow) + body 4 H2 (입력 / 작성할 것 / 검증 / 관련)",
  "status": "complete",
  "completion_date": "2026-05-21",
  "changes": [
    {"file": "skills/stage-open/SKILL.md", "action": "create", "summary": "milestone OPEN stage 진입 시 mechanical task 3건 (디렉토리 생성 + MILESTONE.md skeleton + ROADMAP entry 추가) checklist + schema template. frontmatter description = trigger keyword narrow ('OPEN stage 진입' / 'milestone v{X.Y} 새로 시작' / 'new milestone 시작'), SKIP keyword 명시 ('open file' / 'open issue' 회피). body 4 H2 = 입력 (이전 stage 부재) / 작성할 것 (3 task) / 검증 (smoke 2건) / 관련 (1차 source cross-ref)."},
    {"file": "skills/stage-propose/SKILL.md", "action": "create", "summary": "milestone PROPOSE stage 작성 시 mechanical task 2건 (## PROPOSE 섹션 작성 + ROADMAP next_candidates[] append) checklist + schema template. frontmatter description = trigger keyword narrow ('PROPOSE stage 작성' / 'next_candidates 등재' / 'milestone PROPOSE 진입'), SKIP keyword 명시 ('propose change' / propose_next 자율 mechanism 회피). body 4 H2 = 입력 (## REPORT 안 lessons) / 작성할 것 (2 task) / 검증 (smoke 2건) / 관련 (1차 source + 별 mechanism cross-ref)."},
    {"file": "projects/meta/milestones/v6.16/execute/phase-2.md", "action": "create", "summary": "본 파일 — phase-2 실 진행 일지."},
    {"file": "projects/meta/milestones/v6.16/MILESTONE.md", "action": "edit", "summary": "## EXECUTE 섹션 안 phase-2 진행 요약 갱신 (작성 중 → 완료)."}
  ],
  "commit": "(phase-2 commit hash, 본 commit 자체)",
  "verification": [
    {"check": "skills/stage-open/SKILL.md 신규 파일 존재", "result": "PASS", "evidence": "skills/stage-open/ 디렉토리 + SKILL.md 신규 생성. frontmatter `name: stage-open` + description multi-trigger narrow (4 keyword) + SKIP 2 keyword 명시. body 4 H2 (## 입력 / ## 작성할 것 / ## 검증 / ## 관련) 4 섹션."},
    {"check": "skills/stage-propose/SKILL.md 신규 파일 존재", "result": "PASS", "evidence": "skills/stage-propose/ 디렉토리 + SKILL.md 신규 생성. frontmatter `name: stage-propose` + description multi-trigger narrow (3 keyword) + SKIP 2 keyword 명시. body 4 H2 (## 입력 / ## 작성할 것 / ## 검증 / ## 관련) 4 섹션."},
    {"check": "skill body = checklist + schema template only (예시 narrative 부재)", "result": "PASS", "evidence": "INTENT sc_4 정합. 두 SKILL.md body 모두 예시 narrative (실 milestone 인용) 부재 — checklist (필수 필드 목록) + schema template (frontmatter skeleton + section 구조) 만. 'P2 description multi-line vs single-line' DESIGN 5 관점 review P2 = single-line 선택 (description 안 narrative 분리 부재, body 참조)."},
    {"check": "ARCHITECTURE § 7.3 1차 source 인용 (단방향 derived)", "result": "PASS", "evidence": "두 SKILL.md body lead 안 직접 명시 — 'projects/meta/ARCHITECTURE.md § 7.3 Stage 본질 (templated section 작성 task) 1차 source 의 derived checklist (단방향 derived, cascade marker 부재)'. r_3 mitigation evidence."},
    {"check": "plugin.json 갱신 부재 자연 (auto-discovery 정합)", "result": "PASS", "evidence": ".claude-plugin/plugin.json `skills: ./skills/` add-to-default 명시 = skills/* 자동 인식 (v5.1+). 신규 skills/stage-open + skills/stage-propose 디렉토리 추가 시 plugin.json 변경 부재. sc_5 정합."},
    {"check": "entry skill ↔ stage skill trigger keyword 본질 별 분리 (D3 rm_6 mitigation)", "result": "PASS", "evidence": "harness-meta:harness-meta entry skill description = 'project 하네스 개선 세션 진입점 (9-stage workflow)' (workflow 진입). stage-open description = 'OPEN stage 진입 / milestone v{X.Y} 새로 시작' (단일 stage 진행). stage-propose description = 'PROPOSE stage 작성 / next_candidates 등재' (단일 stage 작성). trigger keyword 본질 별 — 충돌 부재 가설."},
    {"check": "v3.21 narrative 정전화 3 단계 패턴 cycle 37 (c) VERIFY grep 3 host", "result": "PASS", "evidence": "(c) VERIFY grep = `stage = templated\\|7.3 Stage\\|## 7.3` 3 host 존재 확인 (phase-1 commit 후 grep PASS) + skills/stage-open + skills/stage-propose 2 디렉토리 신규 (phase-2 commit)."}
  ]
}
```

## Narrative

phase-2 = skill 시범 도입 only (D9 phase 분리 정합). scope = 2 신규 파일 (skills/stage-open/SKILL.md + skills/stage-propose/SKILL.md) + 1 phase-2.md 별책 + 1 MILESTONE.md ## EXECUTE 갱신.

**mechanical apply sequence**:

1. skills/stage-open/ + skills/stage-propose/ 2 디렉토리 생성
2. skills/stage-open/SKILL.md 작성 — frontmatter (name + description trigger narrow) + body 4 H2
3. skills/stage-propose/SKILL.md 작성 — frontmatter (name + description trigger narrow) + body 4 H2
4. phase-2.md 별책 생성 (본 파일)
5. MILESTONE.md ## EXECUTE 섹션 phase-2 진행 갱신

**Skill spec 정합** (Anthropic Claude Code Skill spec, RESEARCH ext_1):

- frontmatter = `---` markers + YAML
- 필수 = `description` (auto-invoke trigger source)
- 권장 = `name` (Claude 가 이해)
- 선택 = `disable-model-invocation` / `allowed-tools` / `argument-hint` — 본 milestone scope 외 (D6 결정 = allowed-tools 명시 부재)
- body = Markdown 자유 — 본 milestone 적용 = 4 H2 (입력 / 작성할 것 / 검증 / 관련)
- skill dir name = slash command 이름 (`stage-open` → `/stage-open`, `stage-propose` → `/stage-propose`, 단 본 milestone scope = description trigger auto-load 본질, /command 사용 oos)

**r_3 mitigation evidence**:

두 SKILL.md body lead paragraph 안 직접 명시 — `> 본 skill 은 projects/meta/ARCHITECTURE.md § 7.3 'Stage 본질 (templated section 작성 task)' 1차 source 의 derived checklist (단방향 derived, cascade marker 부재). 1차 source 변경 시 본 skill 후속 갱신 manual.` 단방향 derived 본질 evidence — cascade-sync mechanism (v6.4) marker 부재 자연 (v6.10 L3 판정 = cascade host ≥2 → 본 milestone 단일 host 1차 source = 적용 외).

**rm_1 mitigation evidence**:

두 SKILL.md description multi-line trigger keyword narrow:

- stage-open: 'OPEN stage 진입' / 'milestone v{X.Y} 새로 시작' / 'new milestone 시작' (4 keyword)
- stage-propose: 'PROPOSE stage 작성' / 'next_candidates 등재' / 'milestone PROPOSE 진입' (3 keyword)

SKIP keyword 명시:

- stage-open: 'open file' 등 일반 파일 열기 / 'open issue' 등 다른 도메인
- stage-propose: 'propose change' 등 일반 제안 / propose_next 자율 발의 mechanism

trigger condition narrow = auto-load 정확도 향상 (r_1 본질).

## Out-of-scope rationale (phase-2 안)

phase-2 = 2 SKILL.md 신규 생성 only — ARCHITECTURE 정전화는 phase-1 책임 (이미 완료). skill 자체 smoke 도입 (oos_3) + skill trigger 모델 정전화 (oos_4) + entry skill 재설계 (oos_2) + 나머지 7 stage skill 확장 (oos_1) = 별 milestone 자연.

## v6.17 도그푸드 첫 cycle 예정

본 milestone REPORT 후 후속 milestone (v6.17) 첫 OPEN stage 진입 시 `skills/stage-open/` auto-load evidence 확인 (rm_2 도그푸드 mitigation). vacuous 시 (auto-load 부재 / skill 사용 부재) 별 milestone re-evaluation candidate.
