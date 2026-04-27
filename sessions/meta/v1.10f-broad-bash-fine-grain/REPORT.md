# meta v1.10f-broad-bash-fine-grain — REPORT

세션 완료: 2026-04-28
직접 선행 세션: [`sessions/meta/v1.10d-bash-permission-pattern-audit/`](../v1.10d-bash-permission-pattern-audit/REPORT.md)

## 최종 결과

- 신규 audit: **6** 파일 (A1-A6, 1346 라인) — v1.10d 수준 디테일 + Anthropic 인용 11-18 신규 8건
- 정정 파일: **7** (3 SKILL + 4 agent — Q4=a 확장 적용)
- 신규 smoke: **6 stage** (`tests/smoke-broad-bash-fine-grain.sh`) — 6/6 PASS
- 회귀 smoke: v1.10d `smoke-bash-permission-pattern.sh` 6/6 PASS (β scope 무변경)
- 정합 갱신: `bootstrap/docs/PERMISSION_PATTERN.md` §8 (7 파일 정책 yaml 블록 5개 추가) + §11 (audit reference 추가) + `CLAUDE.md` + `README.md`
- 합 변경: 12 파일 (7 정정 + 1 smoke + 1 spec doc + 2 README + 1 PLAN + 6 audit + 1 REPORT + 2 evidence = 본 커밋 산출물)

## 구현 요약

### Stage A — audit 6 파일 (디테일 분석 v1.10d 수준)

| Audit | 라인 | 핵심 내용 |
|------|:---:|----------|
| **A1 — Bash usage inventory** | 172 | 4 파일 line별 Bash 호출 inventory. `harness/` 0건 / `harness-run/` 5건 (100% DYN) / `harness-ship/` 13건 (DYN 4 + WRITE 6 + AUTO 3) / `harness-verifier` 0건. AUTO/WRITE/DYN/DOC 분류 체계 |
| **A2 — Anthropic docs cross-ref** | 198 | 권위 인용 11-15 신규. subagent `tools:` array (인용 11) + `Bash(*)` spec 명시 (인용 15) + plugin-dev "comma" vs skills "space/list" docs conflict → YAML list 채택 |
| **A3 — dynamic vars matrix** | 245 | `{executor}` 17 PM × `{test_cmd}/{type_check_cmd}/{lint_cmd}` 13+ PM 매트릭스. 첫 token 17가지 폭발 + Python pip 3 분기. git ops 옵션 위치 변경 시나리오 |
| **A4 — policy decisions** | 297 | R1-R6 결정 5요소 구조 (결정/근거/인용/회귀/패턴) + Grey G1-G3 + scope 매트릭스 (포함 6 + 제외 6) + 결정 종합 표 |
| **A5 — regression risk** | 244 | 3 시나리오 (신규/deployed/v1.10d β) + cross-platform OS 매트릭스 (POSIX 자동허용 12명령 × 5환경) + smoke 6 stage 정당화 + 시그널 모니터링 4건. 회귀 위험 LOW |
| **A6 — frontmatter cross-validation** | 316 | **추가 발견 5건** — 3 agent 콤마 위반 (Q4) + isolated context safety + install-project-claude `cp -r` (line 84) + settings.json 상호작용 매트릭스 + 4 형식 separator 매트릭스. 인용 16-18 신규 |

**사용자 결정 적용**:
- Q1=B (3 SKILL + harness-verifier 4 파일)
- Q2=A (`harness/` Bash declare 제거)
- Q3=A (broad Bash 유지)
- **Q4=a (3 agent 콤마 → YAML list 확장)** — A6 §2 발견 통합

### Stage B — 7 파일 frontmatter 정정

| 파일 | 변경 전 | 변경 후 | R# |
|------|---------|---------|:---:|
| `harness/SKILL.md:6` | `Read, Glob, Grep, Bash, Edit` (콤마) | YAML list 4 entries (Bash 제거) | R2 |
| `harness-run/SKILL.md:5` | `Read, Glob, Grep, Bash, Edit` | YAML list 5 entries (broad Bash 유지) | R3 |
| `harness-ship/SKILL.md:5` | `Read, Glob, Grep, Bash, Edit(phases/**), Write(phases/**)` | YAML list 6 entries (broad Bash + Edit/Write fine-grain 보존) | R3+R5 |
| `harness-verifier.md:4` | `tools: Read, Glob, Grep, Bash` | YAML list 4 entries (`tools:` 필드 broad 유지) | R4 |
| `harness-dispatcher.md:4` | `tools: Read, Glob, Grep` | YAML list 3 entries (Bash 무) | R6 |
| `harness-explore.md:4` | `tools: Read, Glob, Grep` | YAML list 3 entries | R6 |
| `harness-grey-area.md:4` | `tools: Read, Glob, Grep` | YAML list 3 entries | R6 |

### Stage C — smoke + 회귀 + 문서 정합

**`tests/smoke-broad-bash-fine-grain.sh` 6 stage** (`evidence/smoke-broad-bash-fine-grain.txt`):

| Stage | 검증 | 결과 |
|------|------|:---:|
| 1 (V8 A2) | 7 파일 single-line 콤마 separator 잔존 0 | ✓ 0/0 |
| 2 (V9 A2) | 7 파일 YAML list entries 정합 (4/5/6/4/3/3/3) | ✓ 7/7 정확 매치 |
| 3 (R2) | `harness/SKILL.md` Bash declare 부재 | ✓ 0건 |
| 4 (R3/R4) | `harness-run`/`harness-ship`/`harness-verifier` broad Bash 1건 | ✓ 3/3 정확 |
| 5 (V5 A4) | 7 파일 자동 허용 set declare 잔존 0 | ✓ 0/0 |
| 6 (Field name + R6) | 3 SKILL `allowed-tools:` + 4 agent `tools:` + R6 3 agent Bash 부재 | ✓ 정합 |

**회귀 smoke v1.10d** (`evidence/regression-smoke-bash-permission-pattern.txt`): 6/6 PASS — β scope 4 파일 (harness-meta.md + harness-design/plan/review SKILL) 무변경

**문서 정합 갱신**:
- `bootstrap/docs/PERMISSION_PATTERN.md` §8 — v1.10f scope 7 파일 정책 yaml 블록 5개 추가 (R2/R3/R3+R5/R4/R6 각각)
- `bootstrap/docs/PERMISSION_PATTERN.md` §11 — audit reference 추가 (A1-A6 + 인용 11-18)
- `CLAUDE.md` — 최신 meta 세션 링크 v1.10e3 → v1.10f
- `README.md` — 최신 + 직전 meta 세션 2단 링크

## 판정

PLAN 체크박스 9건 모두 완수:

- [x] audit/A1-A6 6 파일 작성
- [x] 7 파일 frontmatter 정정 (콤마 → YAML list + R2/R3/R4/R6 적용)
- [x] `tests/smoke-broad-bash-fine-grain.sh` 6/6 PASS (검증 파일 7)
- [x] 기존 `tests/smoke-bash-permission-pattern.sh` 6/6 회귀 PASS
- [x] `evidence/smoke-broad-bash-fine-grain.txt` + `regression-smoke-bash-permission-pattern.txt` 저장
- [x] `bootstrap/docs/PERMISSION_PATTERN.md` §8 + §11 갱신 (7 파일 정책 추가)
- [x] `CLAUDE.md` / `README.md` 정합 갱신
- [x] REPORT.md 작성
- [ ] 사용자 확인 후 단일 커밋 + push ← 진행 대기

## Lessons Learned

### 1. 디테일 검토 = 추가 발견 + 전체 일관성

사용자 "디테일하게 분석해" 요청 후 audit 5 → 6 확장 결과 **추가 발견 5건**:
1. 3 agent (`harness-dispatcher`/`harness-explore`/`harness-grey-area`) 콤마 위반 — v1.10d Layer 1B "별건"으로 처리됐으나 본 v1.10f A2 인용 11 (subagent `tools:` array spec) 확보로 해소
2. JSON-style array 형식 (인용 16) — MCP integration docs 명시
3. subagent isolated context broad Bash safety — main thread보다 격리 환경 안전 (R4 추가 정당화)
4. `install-project-claude.sh:84` `cp -r` evidence 확보 — symlink 아님 (A5 §1 정합 확인)
5. `Bash(*)` spec 명시 (인용 15) — broad declare가 spec 무효 아님 (R3 정당화)

→ **scope 4 → 7 확장** (Q4=a) — audit 0 추가 + smoke 1 라인 추가 + 일관성 ✓ + 단일 커밋 효율 ✓.

### 2. v1.10d "별건" 결정의 재평가 패턴

v1.10d audit/A2 line 40: "subagent docs 별도 — spec 미확인. 본 audit 범위 외 — 별건." → 별도 후속 위임됐으나 **다음 세션이 spec 확보하면 통합 처리** 가능. evidence-driven 진화 패턴 — "별건" 결정도 영구 미루기 아님, 후속 evidence 확보 시 재통합.

### 3. broad Bash 정당화 5층 evidence

R3 (broad 유지) 결정 정당화는 단일 근거 아님 — 5층 evidence stack:
1. **A1 본문 inventory** — DYN 비율 100% (harness-run) / DYN 31% (harness-ship)
2. **A2 인용 1** — pattern format spec
3. **A2 인용 15** — `Bash(*)` spec 명시
4. **A3 매트릭스** — 17 PM × 13+ PM × first token 분기 폭발
5. **PERMISSION_PATTERN.md §6 R3' Conservative** — fragile pattern 회피

각 층 단독으로는 broad 정당화 미흡. 종합 evidence가 R3' Conservative 채택 정당화.

### 4. subagent vs skill 필드명 분기 (인용 11 권위)

A1/A2 매트릭스:
- `.claude/commands/*.md` → `allowed-tools:`
- `.claude/skills/*/SKILL.md` → `allowed-tools:`
- `.claude/agents/*.md` → **`tools:`** (별도 schema)

흔한 오류 (`tools:` 또는 `allowed-tools:` 혼용)를 본 v1.10f A2 인용 11 + Stage 6 smoke로 명시적 검증 가능. agent docs spec 확보 = 향후 agent 추가 시 frontmatter 결함 0 회귀 자동 차단.

### 5. 4 형식 separator 매트릭스 (인용 7/14/16 통합)

A6 §6 매트릭스 — 4 형식 spec 권위 등급:
- ★★★★★ YAML list (skills + plugin-dev)
- ★★★★ JSON array (MCP + agents)
- ★★★ 공백 inline (skills only)
- ★★ 콤마 inline (plugin-dev only — colon pattern 충돌 risk)

본 v1.10f YAML list 채택 = 양쪽 docs verbatim 충족 + 콜론 패턴 안전 + 미래 확장 안정. JSON array는 subagent docs (인용 11)에서 명시지만 skill과 일관성을 위해 YAML list로 통일 (인용 11 alternative 허용).

### 6. 회귀 위험 LOW 등급 → 신뢰성 있는 자동 마이그레이션

A5 §6 종합:
- 신규 프로젝트 bootstrap = LOW (디스패처 prompt 시그널 1)
- 기존 deployed = NONE (영향 0, T4 후행 별도 책임)
- v1.10d β scope = NONE (smoke 6/6 회귀 PASS)
- Cross-platform = NONE (POSIX 12 명령 자동허용 5환경 × OS)

→ install-project-claude 재실행 (`-f`) 만으로 자동 마이그레이션 안전 (각 프로젝트 책임).

## 산출물 요약

```
sessions/meta/v1.10f-broad-bash-fine-grain/
├── PLAN.md                        # 231 라인 (audit 6 + Q1-Q4 결정 통합)
├── REPORT.md                      # 본 파일
├── audit/
│   ├── A1-bash-usage.md           # 172 라인
│   ├── A2-anthropic-docs.md       # 198 라인 (인용 11-15)
│   ├── A3-dynamic-vars.md         # 245 라인
│   ├── A4-policy-decisions.md     # 297 라인 (R1-R6 + Grey 3 + scope 매트릭스)
│   ├── A5-regression-risk.md      # 244 라인
│   └── A6-frontmatter-cross-validation.md  # 316 라인 (인용 16-18, Q4 발견)
└── evidence/
    ├── smoke-broad-bash-fine-grain.txt      # 6 stage 결과
    └── regression-smoke-bash-permission-pattern.txt  # v1.10d 6/6 회귀

bootstrap/templates/_base/.claude/skills/
├── harness/SKILL.md (R2)
├── harness-run/SKILL.md (R3)
└── harness-ship/SKILL.md (R3+R5)

bootstrap/templates/_base/.claude/agents/
├── harness-verifier.md (R4)
├── harness-dispatcher.md (R6)
├── harness-explore.md (R6)
└── harness-grey-area.md (R6)

tests/
└── smoke-broad-bash-fine-grain.sh   # 6 stage smoke

bootstrap/docs/PERMISSION_PATTERN.md  # §8 yaml 5블록 추가 + §11 audit ref
CLAUDE.md                              # 최신 meta 링크
README.md                              # 최신 + 직전 meta 링크
```

## 후속 세션 연결 — Lessons Forward

### 직접 연계 (각자 책임 — 본 v1.10f scope 외)

- **deployed projects** (예: upbit) — `<proj>/.claude/`의 동일 정정 (S6, T4 후행). install-project-claude `-f` 재실행으로 자동 마이그레이션 가능 OR 자기 세션에서 직접 정정. 회귀 위험 LOW.
- **`sessions/meta/v1.10g-skill-thinking-effort/`** — A6 §1 발견: `harness-ship`/`harness-design`/`harness-plan` SKILL의 `thinking: high` 필드 검증 (deprecated `effort:` alias 가능성). context7 docs 미명시 — 별도 evidence 확보 후 정정 결정.
- **`sessions/meta/v1.21-cross-platform-install/`** — verify.ps1 통합 (V1+V5+V7+V8+V9 + 본 v1.10f Stage 1-6). 본 audit/A5 §3 시나리오 자동화.

### Lessons Forward — 향후 세션 패턴

1. **"별건" 결정 재평가 패턴** — 후속 evidence 확보 시 통합 처리. v1.10d "별건" → v1.10f Q4 통합 사례
2. **다층 evidence 정당화** — broad 유지 같은 spec 우회 결정은 5층 evidence stack 필요 (단일 근거 미흡)
3. **subagent vs skill 필드명 분기** — 신규 frontmatter 작성 시 인용 11 매트릭스 참조
4. **scope 동상 동시 처리** — 형식 일관성 위반 (콤마 separator 등)은 동상 발견 즉시 동시 처리. scope creep 미발생 (단순 형식 정정은 audit 0 추가)
5. **smoke evidence 보존** — REPORT 작성 시 `evidence/` 디렉토리에 stdout 그대로 저장. 향후 회귀 비교 base
6. **install-project-claude `cp -r` 재확인** — A5/A6 정합 확보. baseline 변경 시 deployed projects 영향 0 (자동 동기화 안 됨, 명시적 `-f` 재실행 필요)
