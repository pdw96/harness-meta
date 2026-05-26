---
id: audit-team-asset-recommendation-catalog
title: harness-meta canonical 자산 권고 통로(카탈로그 영역 4) 신설
version: v8.9
status: completed
---

# v8.9 — harness-meta canonical 자산 권고 통로(카탈로그 영역 4) 신설

## INTENT

### Spec

```json
{
  "id": "audit-team-asset-recommendation-catalog",
  "goal": "claude-docs-mapper 의 1차 source 도구 카탈로그(bootstrap/claude-code-catalog/README.md)에 '영역 4 — harness-meta canonical 자산'을 신설하고 v8.8 의 session-start-secret-scan.sh 를 첫 항목으로 등록한 뒤, audit-team 3 멤버(harness-gap-analyzer / claude-docs-mapper / component-proposer)를 와이어링하여 audit 이 generic 문서 매핑 + 즉석 hook 생성이 아니라 harness-meta 가 보유·검증한 canonical 자산을 권고 component 로 매핑·draft 하도록 한다. 정확한 detect signal / 매핑 schema / installer 복사 책임 경계는 RESEARCH 에서 확정.",
  "motivation": "5요소 = Context (audit-team 이 읽는 도구 카탈로그 = composer 의 지식 컨텍스트 source). v8.8 oos_1 origin. v8.8 은 secret-scan 자산을 신설했으나 OPEN 전 조사에서 후보 전제가 재차 빈 곳을 가리킴 — claude-docs-mapper 1차 source 카탈로그는 3 영역(code.claude.com/docs generic / built-in / plugin·MCP)뿐이고 'harness-meta 보유 자산'을 권고할 영역 부재. 그래서 audit-team 은 gap 발견 시 generic 문서로만 매핑 + component-proposer 가 hook 을 매번 즉석 생성 → v8.8 자산이 audit-team 눈에 비가시. '지침만 추가'로는 권고할 통로 자체가 없다(v8.8 의 '확장할 파일 부재'와 동형 전제 결함). harness-meta 정체성('적재적소 부품 배치, 기존 자산 존중')이 실효하려면 자기 검증 자산을 재사용·권고할 통로(영역 4)가 필수.",
  "success_criteria": [
    {"id": "sc_1", "criterion": "카탈로그 영역 4 'harness-meta canonical 자산' 신설 — bootstrap/claude-code-catalog/README.md 에 영역 4 섹션(자산명 / source path / 책임 / 권고 case / apply 방식) + session-start-secret-scan.sh 첫 항목 등록. 기존 3 영역 무손상."},
    {"id": "sc_2", "criterion": "harness-gap-analyzer — secret-scan 격차 detect 추가. 대상이 .claude/settings*.json 보유(또는 settings 기반 권한 운영)하나 secret-scan 류 hook 부재 시 harness_gap 으로 surface. 정확한 signal(project-scanner 출력 의존 여부)은 RESEARCH 확정."},
    {"id": "sc_3", "criterion": "claude-docs-mapper — Task 에 영역 4 매핑 추가. harness-meta 자산 gap 을 영역 4 asset 으로 매핑(claude_doc_ref 대신 또는 병기 harness-meta asset source path + apply 방식). generic 문서 매핑(영역 1~3)과 직교 보존."},
    {"id": "sc_4", "criterion": "component-proposer — proposal draft 가 영역 4 자산 권고 시 frontmatter/system-prompt 즉석 생성 대신 canonical 자산 참조(Source case 에 'harness-meta-asset' 분류 + apply_path = 자산 복사). 4 case/5 case 매트릭스와 정합."},
    {"id": "sc_5", "criterion": "기존 smoke 전체 FAIL=0 + agent frontmatter schema(smoke-agent-frontmatter-schema) 무손상 + 카탈로그/agent cross-ref(smoke-cross-ref) 정합 + claude-md-drift 무손상."}
  ],
  "out_of_scope": [
    {"id": "oos_1", "item": "full 자산 라이브러리 구조 정전화(디렉토리 규약 / 버전관리 / 다수 자산 lifecycle) — hook-asset-library-canonicalization 별도 후보 유지. v8.9 = 영역 4 경량 카탈로그(자산 인벤토리 표) + secret-scan 1 항목까지. 영역 4 가 그 경량 버전을 흡수."},
    {"id": "oos_2", "item": "외부 repo(price-compare 등)에 secret-scan 실 배치 — 외부 적용 trace 별도. v8.9 = audit-team 의 권고 능력(read-only 매핑/draft)까지. 실 install 은 component-installer + 사용자 e3 게이트."},
    {"id": "oos_3", "item": "secret-scan 외 다른 canonical 자산(statusline / session-init 등) 영역 4 등록 — v8.9 는 secret-scan 1 항목 seed. 추가 자산 등록은 발생 시 별도(영역 4 표에 row append, 경량)."},
    {"id": "oos_4", "item": "audit-orchestrator(멤버 6, Step 1~6 orchestration) 변경 — 영역 4 wiring 이 orchestration 흐름 자체를 바꾸지 않으면 비대상. RESEARCH 에서 orchestrator inline 첨부(D10) 가 영역 4 매핑에 영향 주는지 확인."}
  ],
  "dependencies": [
    {"id": "dep_1", "ref": "development/milestones/v8.8/MILESTONE.md + claude/hooks/session-start-secret-scan.sh", "purpose": "origin + 등록할 자산 본체(영역 4 첫 항목)."},
    {"id": "dep_2", "ref": "bootstrap/claude-code-catalog/README.md", "purpose": "영역 4 host(현 3 영역). 단일 source 정합 — 영역 4 추가 시 § 신규."},
    {"id": "dep_3", "ref": "agents/{harness-gap-analyzer,claude-docs-mapper,component-proposer}.md", "purpose": "wiring 대상 3 멤버. 각 Task 에 영역 4 detect/매핑/draft 추가."},
    {"id": "dep_4", "ref": "bootstrap/agents/CLAUDE.md (Conflict 4 case + Fleet 5 case + 이종 하네스 회피)", "purpose": "영역 4 자산이 어느 case 로 분류·권고되는지 매트릭스 정합 확인."},
    {"id": "dep_5", "ref": "agents/project-scanner.md", "purpose": "RESEARCH — gap-analyzer 의 secret-scan detect signal 이 project-scanner harness_state 출력에 의존하는지(settings*.json 인지 여부) 확인."},
    {"id": "dep_6", "ref": "tests/smoke-agent-frontmatter-schema.sh + smoke-cross-ref.sh", "purpose": "회귀 차단 — agent frontmatter + cross-ref 정합."}
  ]
}
```

### Narrative

v8.9 는 v8.8 의 직접 후속(oos_1)이나, OPEN 전 조사에서 **v8.8 과 동형의 전제 결함**이 드러났다 — '지침을 보강'하려던 대상(audit-team 이 harness-meta 자산을 권고하는 통로)이 **애초에 없었다**. claude-docs-mapper 가 읽는 카탈로그는 generic Claude Code 문서·built-in·plugin 3 영역뿐이라, harness-meta 가 자기 손으로 만들고 검증한 자산(v8.8 secret-scan)을 권고할 자리가 없다. 그래서 v8.9 의 본질은 '지침 추가'가 아니라 **권고 통로(카탈로그 영역 4) 신설 + 3 멤버 와이어링**이다.

사용자 결정(2026-05-27)으로 범위를 좁혔다 — full 자산 라이브러리 구조 정전화(hook-asset-library-canonicalization)는 별도 후보로 유지하고, v8.9 는 영역 4 경량 카탈로그(자산 인벤토리 표) + secret-scan 1 항목 seed + 3 agent 와이어링까지다. 영역 4 가 자산 라이브러리의 경량 버전을 자연 흡수한다. 핵심 미확정 항목(gap detect signal 이 project-scanner 출력에 의존하는지 / 영역 4 매핑 schema / component-installer 자산 복사가 기존 책임 범위인지)은 RESEARCH 에서 4 agent(.md) + project-scanner 를 전수 조사해 DESIGN 에서 확정한다.

## RESEARCH

### Spec

```json
{
  "external": [
    {"id": "ext_1", "source": "bootstrap/agents/CLAUDE.md (Conflict 4 case + Fleet 5 case + 이종 하네스 회피)", "finding": "영역 4 자산 권고 = harness_gap 축 흐름(harness-gap-analyzer Task 1 → mapper Task 1 Gap 매핑 → proposer 'Source case: gap'). built-in 충돌(4 case)/fleet evolution(5 case)와 직교 — 매트릭스 변경 불요. 영역 4 는 'gap 을 채울 권고 component 의 source 가 generic 문서가 아니라 harness-meta 자산'이라는 매핑 대상 추가일 뿐."},
    {"id": "ext_2", "source": "v8.7 price-compare audit (heterogeneous case)", "finding": "heterogeneous 프로젝트는 extend/adopt 위주(기존 존중, replace 금지). secret-scan 은 직교 격차 보강이라 heterogeneous 에서도 권고됐던 선례(v8.7 P1-2 extend). → 영역 4 권고도 이종 하네스 회피 lens 와 충돌 없음(직교 보강, replace 아님)."}
  ],
  "codebase": [
    {"id": "cb_1", "ref": "agents/project-scanner.md Task 2 (harness_state)", "finding": "project-scanner 이미 harness_state 에 claude_dir(bool) + hooks list(name+matcher) + harness_kind detect. → gap-analyzer 가 'claude_dir=true ∧ secret-scan 류 hook 부재'를 harness_gap 으로 derive 가능. project-scanner 변경 불요(민감정보 .env/.key path-only 정책 유지 — settings 내용 스캔은 audit 책임 아닌 배치될 hook 책임)."},
    {"id": "cb_2", "ref": "agents/claude-docs-mapper.md (Primary source + Task 1 Gap 매핑)", "finding": "mapper Primary source = context7 + bootstrap/claude-code-catalog/README.md. Task 1 이 gap.category → claude_doc_ref + apply_path 매핑. 영역 4 추가 = (a) Primary source 에 영역 4 추가 + (b) Task 1 에 'harness-meta 자산 gap → 영역 4 asset' 분기(claude_doc_ref 대신 asset source path + apply='copy')."},
    {"id": "cb_3", "ref": "agents/component-proposer.md Task 1 (Frontmatter/System prompt draft)", "finding": "proposer 가 권고 component 의 frontmatter+system prompt 를 즉석 draft. 영역 4 자산은 즉석 생성 대신 'canonical 자산 참조 + apply_path=복사'로 분기 필요. Summary table 'Source case' 에 'harness-meta-asset' 추가."},
    {"id": "cb_4", "ref": "agents/component-installer.md + bootstrap/agents/CLAUDE.md (custom lifecycle 화이트리스트)", "finding": "installer Copy-Item 화이트리스트 보유 → 자산 복사 mechanically 가능. 단 v8.9 = 권고 능력(read-only 매핑/draft)까지(oos_2 실 install 제외). installer 변경 불요."},
    {"id": "cb_5", "ref": "bootstrap/claude-code-catalog/README.md (3 영역 + 단일 source 정합)", "finding": "현 3 영역(docs generic / built-in / plugin·MCP). 영역 4 = § 신규(영역 3 뒤). 카탈로그 단일 source 규약상 mapper description/Primary source 의 cross-ref 갱신 동반. 자산 path 는 markdown link 로 두면 smoke-cross-ref 가 drift 자동 차단(risk_3 완화)."}
  ],
  "options": [
    {"id": "opt_signal", "question": "gap detect 신호", "A": "harness_state.hooks 부재 + claude_dir 로 derive(project-scanner 무변경)", "B": "project-scanner 에 settings secret-scan 전용 signal 신규", "recommend": "A — 기존 harness_state 충분(cb_1). project-scanner 무변경 = oos 정합 + 민감정보 path-only 정책 무손상."},
    {"id": "opt_mapping", "question": "영역 4 매핑 schema 표현", "A": "claude_doc_ref 를 harness-meta asset source path 로 재사용(별 field 없이)", "B": "gap_mapping 에 명시 field(asset_source + apply='copy') 추가", "recommend": "B — generic 문서 매핑(영역 1~3)과 직교 명료. 기존 gap_mapping entry 무손상(신규 field optional)."},
    {"id": "opt_proposer", "question": "proposer 영역 4 draft 방식", "A": "Source case 'harness-meta-asset' 분기 + apply_path=copy + frontmatter/system-prompt 즉석 생성 생략(자산 참조)", "B": "기존 즉석 draft 흐름 유지 + note 만", "recommend": "A — 즉석 재생성은 검증된 canonical 자산을 버리는 것. 자산 참조 = '기존 자산 존중' 정체성 정합."}
  ],
  "risks_identified": [
    {"id": "risk_1", "risk": "영역 4 자산을 heterogeneous 프로젝트에 over-recommend(자기 자산 강요) → 이종 하네스 회피 정합 위반.", "severity": "MEDIUM", "mitigation": "영역 4 권고도 extend/adopt(존중) lens 적용 명시 + secret-scan 은 직교 보강이라 replace 아님(ext_2). gap-analyzer wiring 에 heterogeneous 시 '강요 아닌 격차 보강 권고' 명시."},
    {"id": "risk_2", "risk": "mapper/proposer wiring 이 generic 흐름(영역 1~3) 회귀.", "severity": "MEDIUM", "mitigation": "영역 4 분기는 'harness-meta asset gap' 한정, 기존 gap_mapping/draft 흐름 무손상(optional 분기). smoke-agent-frontmatter + cross-ref 회귀 차단."},
    {"id": "risk_3", "risk": "카탈로그 영역 4 자산 path drift(자산 이동 시 stale 참조).", "severity": "LOW", "mitigation": "영역 4 안 자산 path 를 markdown link 로 작성 → smoke-cross-ref 가 broken link 자동 차단(cb_5)."},
    {"id": "risk_4", "risk": "hook-asset-library-canonicalization 후보와 중복/혼선.", "severity": "LOW", "mitigation": "영역 4 = 경량 인벤토리 표(oos_1) 명시. full 구조 정전화(디렉토리 규약/버전관리)는 별도 후보 유지 — REPORT 에서 후보 재scope 거명."}
  ]
}
```

### Narrative

RESEARCH 로 wiring 범위가 예상보다 좁고 깔끔함이 확인됐다 — **project-scanner / component-installer / 매트릭스(4 case·5 case) 모두 변경 불요**. 영역 4 자산 권고는 기존 harness_gap 축(gap-analyzer Task 1 → mapper Task 1 → proposer gap draft)을 그대로 타고, 단지 '권고 component 의 source 가 generic 문서가 아니라 harness-meta 검증 자산'이라는 매핑 대상이 추가될 뿐이다(ext_1). gap detect 신호도 기존 harness_state(claude_dir + hooks list)로 derive 가능해 project-scanner 를 건드리지 않는다(cb_1, opt_signal-A).

실 변경은 4 파일 — (1) 카탈로그 README 영역 4 § 신설 + secret-scan 첫 항목, (2) harness-gap-analyzer Task 1 에 secret-scan gap detect(heterogeneous 시 격차 보강 lens), (3) claude-docs-mapper Primary source + Task 1 에 영역 4 매핑 분기(opt_mapping-B, asset_source field), (4) component-proposer Task 1 에 'harness-meta-asset' Source case(opt_proposer-A, 즉석 생성 대신 자산 참조). 가장 신경 쓸 risk 는 heterogeneous over-recommend(risk_1)와 generic 흐름 회귀(risk_2) — 둘 다 'optional 분기 + 기존 무손상' 원칙으로 완화한다. 정확한 schema field 명/문구는 DESIGN 에서 확정 후 design-review 검토.

## DESIGN

### Spec

```json
{
  "decisions": [
    {"id": "d_1", "decision": "bootstrap/claude-code-catalog/README.md 에 '## 4. harness-meta canonical 자산 인벤토리' § 신설(영역 3 뒤) — 경량 표(자산명 / source path(markdown link) / 책임 / 권고 case / apply 방식). secret-scan 첫 row: session-start-secret-scan.sh / [claude/hooks/session-start-secret-scan.sh](link) / settings*.json 평문 secret SessionStart 경고 / 'settings 기반 권한 운영 ∧ secret-scan hook 부재' gap / copy(대상 .claude/hooks/). 카탈로그 3영역 매트릭스 표 + § '카탈로그 3 영역' 제목도 4 영역 반영.", "rationale": "sc_1. 경량 인벤토리(oos_1, full 구조는 별도 후보). 자산 path = markdown link → smoke-cross-ref drift 자동 차단(risk_3)."},
    {"id": "d_2", "decision": "harness-gap-analyzer Task 1 — secret-scan gap detect 추가. **detect 기준 명시(D-DEC-1)**: gap-analyzer 가 (i) bootstrap/claude-code-catalog/README.md § 4 inventory 의 '권고 case(gap 조건)' 컬럼을 권장 자산 source 로 참조(tools: Read 보유 — 직접 Read) + (ii) project-scanner harness_state.hooks list 의 hook `name` 에 `secret`/`scan` 토큰 부재 ∧ claude_dir=true(settings 기반 권한 운영) 면 gap 판정. 자작 secret-scan hook(name 에 토큰 보유) 존재 시 gap=false(중복 권고 회피). **harness_gaps Output 엔트리에 `source` 필드 추가**(예: {category:hook, name:settings-secret-scan, rationale, source:'harness-meta-asset'}). heterogeneous(Task 2.5) 시 Task 1 gap 재평가 대상에 본 gap 포함 → '강요 아닌 직교 격차 보강 권고(replace 아님)'.", "rationale": "sc_2 + risk_1 + D-DEC-1/관점3 중복 우려. 영역 4 inventory 참조 + name 토큰 기준 = agent-실행 가능 detect. source 필드 = mapper(d_3) 입력 계약. project-scanner 무변경(opt_signal-A)."},
    {"id": "d_3", "decision": "claude-docs-mapper — (a) Primary source + description 에 '영역 4(bootstrap/claude-code-catalog/README.md § 4)' 추가 + (b) Task 1 에 분기: gap.source=='harness-meta-asset' 면 gap_mappings 엔트리 = **{gap, asset_source: '<영역 4 자산 path>', apply: 'copy', claude_doc_ref: null}** (generic 분기는 기존 {gap, claude_doc_ref, apply_path, code_snippet_summary} 무손상 — claude_doc_ref/asset_source mutual-exclusive, 영역 4 분기 시 claude_doc_ref=null 명시). Output schema 예시 2종(generic + harness-meta-asset) 병기.", "rationale": "sc_3 + opt_mapping-B + risk_2 + D-DEC-3. 필드 구성 명시 = sc_3↔sc_4 입력 계약 확정. 기존 entry 무손상(신규 field optional)."},
    {"id": "d_4", "decision": "component-proposer — (a) Task 1 에 'harness-meta-asset' Source case 분기: apply_path=대상 .claude/hooks/<name>.sh + 'Frontmatter/System prompt draft' 대신 'Canonical asset 참조(source path + 복사 안내)' + (b) Task 2 Summary table 'Source case' 칸에 'harness-meta-asset' 값 추가.", "rationale": "sc_4 + opt_proposer-A. 즉석 재생성 대신 검증 자산 참조 = '기존 자산 존중' 정체성."},
    {"id": "d_5", "decision": "회귀 = 기존 smoke 재사용(신규 smoke 불요) — smoke-agent-frontmatter-schema(3 agent frontmatter 무손상) + smoke-cross-ref(영역 4 자산 link drift) + smoke-claude-md-drift. 영역 4 자산 path 를 markdown link 로 둔 d_1 이 cross-ref 자동 차단 제공. **단 영역 4 wiring 의 실효(agent 가 실제 detect/매핑/draft 분기 실행)는 정적 smoke 범위 밖** — agent Task 텍스트 = LLM prompt-time 추론 지시문이라 정적 검증 불가. 분기 실작동 검증은 실 audit 실행(oos_2 외부 적용 trace)에서만 가능.", "rationale": "sc_5 + 관점4 regression comment. wiring = Task 텍스트 edit → 기존 회귀 충분. 실효 검증 공백은 REPORT 에 정직 기록(VERIFY 는 '텍스트 존재 + smoke FAIL=0'까지)."},
    {"id": "d_6", "decision": "cross-ref 정합 — **정확히 2곳(D-DEC-2, 전수 grep 확정)**: (a) bootstrap/claude-code-catalog/README.md:7 § 제목 '카탈로그 3 영역'→'4 영역' + 내부 매트릭스 표 row 추가 + (b) agents/claude-docs-mapper.md:27 '(3 영역 통합 인벤토리)'→'(4 영역...)'. **README:3 '영역 3(Plugin/MCP)'은 번호 참조라 불변**. 루트/bootstrap CLAUDE.md 에 '3 영역' 거론 부재(전수 grep — 갱신 대상 없음). project-harness-audit-team/CLAUDE.md:129 는 영역 수 미언급 cross-ref(불변).", "rationale": "sc_5 + cb_5 + D-DEC-2. 카탈로그 단일 source 규약 + 정확 line 명시로 EXECUTE 누락/과탐 차단."}
  ],
  "approach": "4 파일 edit(카탈로그 README 영역 4 신설 + harness-gap-analyzer/claude-docs-mapper/component-proposer Task wiring) + cross-ref 정합. project-scanner/component-installer/4-case·5-case 매트릭스/audit-orchestrator 무변경(RESEARCH 확인). 모든 wiring = optional 분기(harness-meta-asset gap 한정) → generic 흐름(영역 1~3) 무손상. 회귀 = 기존 smoke 3종.",
  "phases": [
    {"id": "phase-1", "title": "카탈로그 영역 4 신설", "scope": "bootstrap/claude-code-catalog/README.md § 4 신설 + secret-scan 첫 row(markdown link) + 3영역→4영역 cross-ref(d_1). cross-ref smoke 검증.", "maps_to": ["sc_1", "sc_5"]},
    {"id": "phase-2", "title": "3 agent wiring + cross-ref", "scope": "harness-gap-analyzer(d_2) + claude-docs-mapper(d_3) + component-proposer(d_4) Task edit + description/Primary source cross-ref(d_6). smoke-agent-frontmatter + cross-ref + claude-md-drift 회귀.", "maps_to": ["sc_2", "sc_3", "sc_4", "sc_5"]}
  ],
  "risk_mitigation": [
    {"ref": "risk_1(heterogeneous over-recommend)", "design_response": "d_2 — heterogeneous 시 '강요 아닌 직교 격차 보강 권고(replace 아님)' 명시. secret-scan 은 직교 보강이라 이종 하네스 회피 lens 와 충돌 없음(ext_2)."},
    {"ref": "risk_2(generic 흐름 회귀)", "design_response": "d_3/d_4 — 영역 4 분기는 source=='harness-meta-asset' 한정 optional. 기존 gap_mapping/draft 흐름 무손상. smoke-agent-frontmatter + cross-ref 회귀 차단."},
    {"ref": "risk_3(자산 path drift)", "design_response": "d_1 — 영역 4 자산 path = markdown link → smoke-cross-ref broken link 자동 차단."},
    {"ref": "risk_4(asset-library 후보 혼선)", "design_response": "d_1 영역 4 = 경량 인벤토리 명시 + oos_1. full 구조 정전화는 별도 후보 — REPORT 재scope 거명."}
  ],
  "design_review_resolution": "harness-meta:design-review 4 관점(architecture/spec-drift/heterogeneous-respect/regression) 완료, pass-with-comments. decisive 3건 반영 — D-DEC-1(d_2 gap detect 기준: 영역 4 inventory 참조 + name 토큰 매칭 + harness_gaps source 필드, 중복 우려 동시 해소) / D-DEC-2(d_6 cross-ref 정확히 2곳 확정, 전수 grep) / D-DEC-3(d_3 영역 4 분기 gap_mappings 필드 구성 schema 명시). comment 3건 흡수(d_3 schema 예시 2종 / d_2 Task 2.5 재평가 포함 / d_5 실효 검증 공백 정직 기록). scope_out 4건 = ## SCOPE_OUT_NOTES 흡수."
}
```

### Narrative

설계는 RESEARCH 의 '좁고 깔끔함' 결론을 그대로 확정한다 — 4 파일 edit(카탈로그 + 3 agent), 나머지(scanner/installer/매트릭스/orchestrator) 무변경. 핵심 설계 원칙은 **optional 직교 분기** — 영역 4 wiring 은 모두 `source=='harness-meta-asset'` gap 한정 분기라, 기존 generic 흐름(영역 1~3 매핑, 즉석 draft)을 한 줄도 건드리지 않는다(risk_2 완화의 본질).

가장 신경 쓴 판단은 heterogeneous 정합(risk_1) — harness-meta 가 자기 자산을 권고하는 것이 '자기 방법론 강요'로 흐르지 않도록, gap-analyzer wiring 에 'heterogeneous 시 직교 격차 보강 권고(replace 아님)'를 명시한다. secret-scan 은 본질적으로 직교 보강이라(v8.7 price-compare 에서 실제 extend 권고됨) 이종 하네스 회피 lens 와 자연 양립한다. 2 phase — phase-1(카탈로그 영역 4 = 권고 통로) 이 인프라, phase-2(3 agent wiring) 가 통로 활용. 회귀는 신규 smoke 없이 기존 3종(frontmatter/cross-ref/claude-md-drift)으로 충분하다(wiring = Task 텍스트 edit). 다음 design-review 4 관점으로 직교성·정합을 확인한다.

## APPROVE

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-27",
    "approval_summary": "사용자가 v8.9 설계(카탈로그 영역 4 신설 + secret-scan 첫 등록 + 3 agent(gap-analyzer/mapper/proposer) 와이어링, scanner/installer/매트릭스 무변경, optional 직교 분기) 대로 EXECUTE 진입 명시 승인('승인 — EXECUTE 진행', AskUserQuestion APPROVE 게이트). design-review 4 관점 decisive 3건(D-DEC-1/2/3) + comment 3 + scope_out 4 전부 반영 후 승인. 경계 = 영역 4 경량 인벤토리(full 구조 oos_1) + 권고 능력까지(실 install oos_2)."
  }
}
```

## EXECUTE

2 phase 완료 (별책 = `execute/phase-{n}.md`).

- **phase-1** (카탈로그 영역 4 신설) — `bootstrap/claude-code-catalog/README.md` § 4 'harness-meta canonical 자산 인벤토리' 신설 + secret-scan 첫 row(markdown link) + 3영역→4영역 cross-ref(d_1, d_6a). cross-ref/drift PASS. 상세 = `execute/phase-1.md`.
- **phase-2** (3 agent wiring + cross-ref) — harness-gap-analyzer(d_2 detect 기준 + source 필드) + claude-docs-mapper(d_3 영역 4 분기 + Primary source/descriptor) + component-proposer(d_4 harness-meta-asset Source case) Task edit. agent-frontmatter/cross-ref/claude-md-drift/spec/scope 전 회귀 FAIL=0. 상세 = `execute/phase-2.md`.

## VERIFY

### Spec

```json
{
  "smoke": {
    "smoke-cross-ref": "PASS=1 FAIL=0 (영역 4 자산 markdown link broken 0)",
    "smoke-agent-frontmatter-schema": "PASS FAIL=0 (3 agent frontmatter 무손상)",
    "smoke-claude-md-drift": "13/13 PASS",
    "smoke-spec-verification": "PASS=498 FAIL=0",
    "smoke-scope-contract": "PASS=111 FAIL=0",
    "기타(bundle-trigger/open-stage/entry-title/cascade-drift/candidate-draft)": "전부 PASS(exit 0)",
    "verdict": "전체 active smoke FAIL=0"
  },
  "criteria_check": [
    {"id": "sc_1", "criterion": "카탈로그 영역 4 신설 + secret-scan 첫 등록", "status": "MET", "evidence": "bootstrap/claude-code-catalog/README.md § 4 신설 + secret-scan row(markdown link) + § 제목/매트릭스 4영역. smoke-cross-ref 자산 link broken 0."},
    {"id": "sc_2", "criterion": "harness-gap-analyzer secret-scan 격차 detect", "status": "MET", "evidence": "Task 1 에 § 4 inventory 참조 + detect 기준(claude_dir ∧ hooks name 토큰 부재) + harness_gaps source 필드(D-DEC-1). 자작 hook 존재 시 gap=false 중복 회피. project-scanner 무변경."},
    {"id": "sc_3", "criterion": "claude-docs-mapper 영역 4 매핑", "status": "MET", "evidence": "Primary source 영역 4 + Task 1 분기(source=='harness-meta-asset' → asset_source+apply:copy+claude_doc_ref:null) + Output schema 예시(D-DEC-3). generic 매핑 무손상."},
    {"id": "sc_4", "criterion": "component-proposer canonical 자산 참조 draft", "status": "MET", "evidence": "Task 1 harness-meta-asset 분기(즉석 생성 생략 + 자산 참조 + apply=copy) + Task 2 Summary table Source case row."},
    {"id": "sc_5", "criterion": "기존 smoke FAIL=0 + frontmatter/cross-ref 무손상", "status": "MET", "evidence": "8 active smoke sweep FAIL=0. agent-frontmatter PASS(body Task edit, frontmatter 불변). cross-ref/claude-md-drift PASS."}
  ],
  "design_decisions_verified": [
    {"ref": "D-DEC-1", "verified": "gap-analyzer detect 기준(§ 4 참조 + name 토큰 + source 필드) 반영 — Task 1 단락 + harness_gaps 예시."},
    {"ref": "D-DEC-2", "verified": "cross-ref 정확히 2곳(README:7 § 제목+매트릭스, mapper descriptor) 반영. README:3 번호 참조 불변."},
    {"ref": "D-DEC-3", "verified": "mapper gap_mappings 영역 4 분기 필드 구성(asset_source/apply/claude_doc_ref:null) schema 예시 반영."}
  ],
  "verification_limit": "영역 4 wiring 실효(agent 실 detect/매핑/draft 분기 실행)는 정적 smoke 범위 밖(agent Task = LLM prompt-time 지시문). 본 VERIFY 는 'wiring 텍스트 존재 + frontmatter/cross-ref/전 smoke 무손상'까지 입증. '분기 실작동' 검증은 실 audit 실행(oos_2 외부 적용)에서만 가능 — REPORT 정직 기록(SCOPE_OUT_NOTES regression).",
  "verdict": "RESOLVED"
}
```

### Narrative

INTENT.success_criteria 5건 전부 MET, design-review decisive 3건(D-DEC-1/2/3) 반영 확인. 단 본 milestone 의 검증은 **두 층**으로 정직히 분리된다 — (1) 입증된 것: wiring 텍스트 존재 + 3 agent frontmatter 무손상 + 영역 4 자산 link drift 0 + 전체 active smoke FAIL=0 (generic 흐름 무손상). (2) 입증 못 한 것: agent 가 실제 audit 에서 영역 4 분기를 실행하는지 — 이는 LLM prompt-time 추론이라 정적 smoke 로 검증 불가하며, 실 heterogeneous 프로젝트 audit(oos_2)에서만 확인된다. v8.4→v8.5 가 'narrative 시뮬레이션 → 실 재audit' 패턴을 밟았듯, 영역 4 wiring 의 실효도 후속 외부 적용 trace 가 첫 실 무대다. verdict = RESOLVED(scope 안 = wiring 설치 + 회귀 무손상 완결).

## REPORT

### Spec

```json
{
  "summary": "v8.8 oos_1 origin. audit-team 이 harness-meta 자기 검증 자산을 권고할 통로 부재(카탈로그 3 영역뿐)를, 카탈로그 '영역 4 — harness-meta canonical 자산' 신설 + secret-scan 첫 등록 + 3 agent(gap-analyzer detect / mapper 매핑 / proposer draft) 와이어링으로 마련. 산출 = 4 파일 edit(catalog README + 3 agent), scanner/installer/매트릭스/orchestrator 무변경. design-review decisive 3건 반영, sc 5/5 MET, 전 active smoke FAIL=0, verdict RESOLVED.",
  "delta": [
    {"from": "원 후보(secret-scan 권고 지침 보강)", "to": "카탈로그 영역 4 신설 + 3 agent wiring(재설계)", "reason": "OPEN 전 조사로 전제 빈 곳 — audit-team 카탈로그에 'harness-meta 자산' 영역 부재. '지침만 추가'로는 권고할 통로가 없어, 통로(영역 4) 신설이 본질(v8.8 의 '확장할 파일 부재'와 동형)."},
    {"from": "초기 d_2(detect 기준 미명시)", "to": "§ 4 inventory 참조 + name 토큰 매칭 + source 필드", "reason": "D-DEC-1 — gap-analyzer 가 영역 4 를 안 읽으면 secret-scan 부재를 derive 못 함. detect 기준 명시로 sc_2 를 agent-실행 가능 형태로 닫음 + 중복 우려 동시 해소."}
  ],
  "lessons_learned": [
    {"id": "L1", "priority": "P1", "lesson": "v8.8 의 L1(후보 문구 = 방향 가설)이 v8.9 에서 재현 — '지침 보강' 후보가 실제론 '통로 부재'였다. 2 연속 milestone(v8.8/v8.9)에서 next_candidate 전제가 OPEN 전 조사로 무너짐. 컨설팅 자산 큰 건은 후보 전제 재검증이 9-stage 의 첫 실질 가치 — '무엇을 보강한다'가 아니라 '보강할 대상이 존재하는가'를 먼저 본다."},
    {"id": "L2", "priority": "P1", "lesson": "정적 검증의 본질적 공백을 정직히 기록 — agent Task 텍스트 wiring 은 LLM prompt-time 추론 지시문이라 정적 smoke 로 '분기 실작동'을 검증 불가. VERIFY 가 입증한 것(wiring 텍스트 + 회귀 무손상)과 못 한 것(실 분기 실행)을 두 층으로 분리 기록. 실효 검증은 oos_2 외부 적용 trace 가 유일 경로 — v8.4→v8.5 패턴(시뮬레이션→실 검증) 재현 예고."},
    {"id": "L3", "priority": "P2", "lesson": "optional 직교 분기 = 회귀 0 의 핵심 — 영역 4 wiring 을 모두 'source==harness-meta-asset' 한정 분기로 두니 generic 흐름(영역 1~3, 즉석 draft)을 한 줄도 안 건드림. 기존 산출 schema 에 신규 자산을 끼울 때 'optional 분기 + 기존 무손상' 원칙이 회귀 위험을 구조적으로 차단."},
    {"id": "L4", "priority": "P2", "lesson": "조사가 범위를 줄였다 — RESEARCH 전엔 scanner/installer/매트릭스 변경 우려가 있었으나, project-scanner harness_state 가 이미 hooks list 를 출력하고 installer Copy-Item 이 화이트리스트에 있어 4 파일 edit 으로 수렴. '무엇을 안 건드려도 되는가'를 조사로 확정하는 것이 scope 축소의 실질."}
  ],
  "trace": ["development/milestones/v8.9/MILESTONE.md (본 산출)", "execute/phase-1.md + phase-2.md", "git log (milestone 단위 commit, 사용자 확인 후)", "CHANGELOG.md (REPORT 시점 archival 후보)"]
}
```

### Narrative

v8.9 는 v8.8 의 L1(후보 문구는 확정 스펙이 아닌 방향 가설)을 **두 번째로 실증**했다 — '지침 보강' 후보가 OPEN 전 조사에서 '권고할 통로 자체 부재'로 드러났다. 2 연속 milestone 에서 같은 패턴이 재현된 것은, 컨설팅 자산 큰 건에서 '보강할 대상이 존재하는가'를 먼저 검증하는 것이 9-stage 의 첫 실질 가치임을 굳힌다(L1).

본 milestone 의 또 다른 정직함은 검증 공백의 명시다(L2) — agent wiring 은 LLM prompt-time 지시문이라 정적 smoke 가 '분기 실작동'을 못 본다. VERIFY 는 입증된 것과 못 한 것을 두 층으로 갈라 기록했고, 실효 검증은 oos_2 외부 적용 trace 가 유일 경로다(v8.4→v8.5 의 시뮬레이션→실검증 패턴 재현 예고). 설계 측면에선 optional 직교 분기가 회귀 0 을 구조적으로 보장했고(L3), 조사가 변경 범위를 4 파일로 줄였다(L4).

## PROPOSE

### Spec

```json
{
  "next_candidates": [
    {
      "id": "area4-recommendation-external-application-verify",
      "title": "영역 4 권고 wiring 실효를 외부 적용으로 실 검증",
      "trigger": "A_user",
      "origin_milestone": "v8.9",
      "target_version": "v9.0",
      "rationale": "v8.9 oos_2 + L2 direct origin. 영역 4 wiring 의 실효(audit 가 실제 secret-scan gap detect → 영역 4 매핑 → 자산 참조 draft 분기 실행)는 정적 smoke 범위 밖이라 v8.9 VERIFY 가 미입증. v8.4→v8.5 패턴(narrative 시뮬레이션→실 재audit 검증)처럼, 실 heterogeneous 프로젝트(price-compare working tree)에서 audit-orchestrator 실행으로 secret-scan over-recommend false-positive 0 + 영역 4 분기 실작동 검증. verification-philosophy(v8.6) 제품 역량 검증 vector 정합.",
      "decision_pending": "사용자 명시 결정 전까지 next_candidates[] append 보류 (v7.0 T1.2 정합)"
    },
    {
      "id": "hook-asset-library-canonicalization",
      "title": "hook 자산 라이브러리 디렉토리 구조 정전화",
      "trigger": "D_design",
      "origin_milestone": "v8.8",
      "target_version": "v9.0",
      "rationale": "v8.8 + v8.9 oos_1 누적 origin. v8.9 영역 4 = 경량 인벤토리(자산 1건 seed). 2건째 자산 등록 시 gap-analyzer detect 기준이 자산별 ad-hoc 해지는 문제(SCOPE_OUT_NOTES architecture) → 자산 디렉토리 규약 / 버전관리 / detect 기준 일반화(영역 4 표 '권고 case' 컬럼 구조화) full 정전화 후보.",
      "decision_pending": "사용자 명시 결정 전까지 next_candidates[] append 보류 (v7.0 T1.2 정합)"
    }
  ]
}
```

### Narrative

v8.9 의 1차 forward candidate = `area4-recommendation-external-application-verify`(v9.0) — oos_2 + L2 의 직접 귀결이다. v8.9 가 wiring 을 설치했으나 '분기 실작동'은 정적 검증 불가하므로, 실 외부 적용 audit 으로만 실효가 입증된다(v8.4→v8.5 패턴 재현). 둘째 candidate = `hook-asset-library-canonicalization`(v8.8 부터 누적) — 영역 4 가 2건째 자산을 맞을 때 detect 기준 일반화가 필요해지는 SCOPE_OUT_NOTES architecture 거명의 귀결. 둘 다 v7.0 T1.2 정합 — 사용자 명시 결정 후에만 ROADMAP next_candidates 등재.

## SUB_MILESTONES

(부재 — 본 milestone = 단일 본질, sub-milestone 분리 없음)

## SCOPE_OUT_NOTES

design-review 4 관점 안 scope 외 거명 (next_candidates 자동 append 부재 — PROPOSE 사용자 명시 결정 게이트 후만 등재):

- **[architecture] 영역 4 자산 detect 기준의 일반화** — secret-scan 외 자산(oos_3) 누적 시 gap-analyzer 의 자산별 "부재" detect 기준이 ad-hoc 해진다. detect 기준을 영역 4 표 '권고 case(gap 조건)' 컬럼에서 gap-analyzer 가 읽는 구조(d_2 가 이미 부분 채택)로 일반화하면 자산 추가 시 wiring 재작업 0 — oos_1(full 자산 라이브러리 구조 정전화)의 핵심 논점. v8.9 는 secret-scan 1건이라 충분하나 2건째 등록 시 재고 trigger.
- **[spec-drift] 영역 번호 명시 cross-ref 취약성** — README:3 등 영역을 번호로 거론하는 narrative 가 카탈로그 내부에 존재. 영역 순서 변경 시 silent drift. 이름 참조 규약("Plugin/MCP 영역")이 robust 하나 v8.9 scope 밖 (우연 발견).
- **[heterogeneous-respect] 영역 4 권고 over-recommend 실 검증 부재** — risk_1 완화(d_2 lens)는 narrative 시뮬레이션 수준. v8.4→v8.5 패턴(시뮬레이션→실 재audit)처럼, 영역 4 권고도 실 heterogeneous 프로젝트(price-compare working tree)에서 secret-scan over-recommend false-positive 0 실 검증 필요 — oos_2(외부 적용 trace)와 자연 결합, 영역 4 wiring 첫 실 무대.
- **[regression] 영역 4 분기 실효 검증 공백** — agent prompt-time 분기는 정적 smoke 불가, 실 audit 실행만 유일 검증(oos_2). v8.9 VERIFY 는 'wiring 텍스트 존재 + smoke FAIL=0'까지 입증, '분기 실작동'은 미입증임을 REPORT 정직 기록.
