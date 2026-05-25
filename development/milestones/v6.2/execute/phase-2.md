# phase-2 — v6.2 자체 retrofit (개별 파일 5건 → MILESTONE.md 단일 통합) + VERIFY/REPORT/PROPOSE H2 신규

## Spec

```json
{
  "phase": 2,
  "status": "complete",
  "changes": [
    {"file": "projects/meta/milestones/v6.2/MILESTONE.md", "change": "신규 통합 본책 작성 — YAML frontmatter 4 필드 (id/title/version/status, stage 제거 D3) + H1 본문 제목 + H2 9 섹션 (## INTENT/RESEARCH/DESIGN/APPROVE/EXECUTE/VERIFY/REPORT/PROPOSE/SUB_MILESTONES) + ## 관련 통합. ## VERIFY/REPORT/PROPOSE = placeholder (Stage G/H/I 진입 시 작성)."},
    {"file": "projects/meta/milestones/v6.2/INTENT.md", "change": "git rm — 내용 → MILESTONE.md ## INTENT 섹션 흡수 (D12 a/b 정합)"},
    {"file": "projects/meta/milestones/v6.2/RESEARCH.md", "change": "git rm — 내용 → MILESTONE.md ## RESEARCH 섹션 흡수"},
    {"file": "projects/meta/milestones/v6.2/DESIGN.md", "change": "git rm — 내용 → MILESTONE.md ## DESIGN 섹션 흡수"},
    {"file": "projects/meta/milestones/v6.2/APPROVE.md", "change": "git rm — 내용 → MILESTONE.md ## APPROVE 섹션 흡수"},
    {"file": "projects/meta/milestones/v6.2/milestones.md", "change": "git rm — 내용 → MILESTONE.md ## SUB_MILESTONES 섹션 흡수 (D5)"},
    {"file": "projects/meta/ROADMAP.md", "change": "v6.2 entry milestones_path 갱신 = `milestones/v6.2/MILESTONE.md#sub-milestones` (이전 `milestones/v6.2/milestones.md`). D10 (g) 정합 — flattened era ROADMAP entry anchor 포함 정전화."}
  ],
  "verification": {
    "smoke_spec_verification": "PASS — v6.2 = 9-stage-flattened era 자동 식별 (MILESTONE.md 존재) + 8 stage H2 섹션 모두 검증 (INTENT/RESEARCH/DESIGN/APPROVE 4건 + VERIFY/REPORT/PROPOSE 3건 placeholder = skip = SKIP).",
    "smoke_4종_전체": "PASS — spec-verification + scope-contract + bundle-trigger + open-stage-discipline 모두 회귀 0. v6.2 = flattened era 첫 자동 식별 entry.",
    "pre_commit_14_hook": "PASS — 14 hook 모두 통과.",
    "atomic_commit_단일성": "git rm 5건 + git add MILESTONE.md + git add ROADMAP.md = 1 commit (D17 정합, architecture P1 #3 흡수). commit 메시지 안 source 5 파일 phase-1 commit 059206c hash 인용 narrative (regression P1 #2 흡수, git history 추적 보존)."
  }
}
```

## 변경 narrative

### 1. MILESTONE.md 단일 통합 (D2/D12)

기존 5 파일 (INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md) 내용 1:1 H2 섹션 매핑:

| 기존 파일 | → MILESTONE.md H2 섹션 | 강등 |
|---|---|---|
| INTENT.md | ## INTENT | 본 ## Spec → ### Spec, ## Motivation → ### Motivation, ## Dependencies → ### Dependencies, ## Harness engineering mapping → ### Harness engineering mapping, ## 명료화 → ### 명료화 (안 ### 본 milestone 의 위치 → #### 본 milestone 의 위치 등 H4 sub-strands) |
| RESEARCH.md | ## RESEARCH | ## Spec → ### Spec, ## 코드베이스 grep 결과 정리 → ### 코드베이스 grep 결과 정리, ## Options 비교 → ### Options 비교, ## Risks 요약 → ### Risks 요약 |
| DESIGN.md | ## DESIGN | ## Spec → ### Spec, ## Risk mitigation → ### Risk mitigation, ## 5 관점 검토 결과 → ### 5 관점 검토 결과, ## 신규 schema 명세 → ### 신규 schema 명세, ## era 분기 구현 → ### era 분기 구현, ## cascade host 정전화 → ### cascade host 정전화 |
| APPROVE.md | ## APPROVE | ## Spec → ### Spec, ## 승인 narrative → ### 승인 narrative |
| milestones.md | ## SUB_MILESTONES | ## Spec → ### Spec, ## Notes → ### Notes |

YAML frontmatter 4 필드 (stage 제거, D3 정합). H1 본문 제목 = `# v6.2 — milestone 산출물 디렉토리 평탄화 (단일 파일 통합)`. ## 관련 1 통합 섹션 (D12 c).

### 2. ## VERIFY/REPORT/PROPOSE H2 placeholder (Stage G/H/I 대기)

phase-2 시점 = Stage F EXECUTE. VERIFY/REPORT/PROPOSE 는 Stage G/H/I 진입 시 신규 작성 의무. MILESTONE.md 안 placeholder 섹션 (`(Stage G VERIFY 진입 시 작성)` narrative) 유지. smoke-spec-verification.sh flattened era loop 안 check_h2_section_fields 가 `no-h2-section` 또는 `no-json-block` → skip 처리 = 회귀 0.

### 3. ROADMAP entry milestones_path 갱신 (D10 g)

이전: `"milestones_path": "milestones/v6.2/milestones.md"`
신규: `"milestones_path": "milestones/v6.2/MILESTONE.md#sub-milestones"`

smoke-bundle-trigger.sh:47 regex (`^milestones/(_archive/)?v[0-9]+\.[0-9]+/(MILESTONE\.md(#sub-milestones)?|milestones\.md)$`) 정합 — anchor `#sub-milestones` 허용.

### 4. atomic commit (D17, architecture P1 #3 + regression P1 #2)

```bash
git rm projects/meta/milestones/v6.2/INTENT.md \
       projects/meta/milestones/v6.2/RESEARCH.md \
       projects/meta/milestones/v6.2/DESIGN.md \
       projects/meta/milestones/v6.2/APPROVE.md \
       projects/meta/milestones/v6.2/milestones.md
git add projects/meta/milestones/v6.2/MILESTONE.md \
        projects/meta/milestones/v6.2/execute/phase-2.md \
        projects/meta/ROADMAP.md
git commit -m "...source 5 파일 (phase-1 commit 059206c 안 added) → MILESTONE.md 단일 통합 retrofit..."
```

git rm 5건 N:1 매핑 = git mv 직접 불가. commit 메시지 안 source 5 파일 hash 인용 narrative 정전화 — git history 추적 보존:

- source 5 파일 (INTENT/RESEARCH/DESIGN/APPROVE.md + milestones.md) = phase-1 commit `059206c` 안 added
- phase-2 commit (본 commit, pending) 안 git rm + MILESTONE.md add = N:1 retrofit
- git log --follow + git log --diff-filter=D 으로 source 파일 history 추적 가능

### 5. 검증 결과

phase-2 commit 후:

- bash tests/smoke-spec-verification.sh PASS — v6.2 첫 flattened era 자동 식별 (detect_era="9-stage-flattened") + H2 8 stage loop (INTENT/RESEARCH/DESIGN/APPROVE PASS + VERIFY/REPORT/PROPOSE skip "no-h2-section")
- bash tests/smoke-scope-contract.sh PASS — v6.2 flattened era 분기 = MILESTONE.md ## INTENT.out_of_scope 검증 + ## APPROVE.approval.approved_by='user' 검증
- bash tests/smoke-bundle-trigger.sh PASS — v6.2 entry milestones_path = `milestones/v6.2/MILESTONE.md#sub-milestones` regex 통과
- bash tests/smoke-open-stage-discipline.sh PASS — 디렉토리 v6.2/ + MILESTONE.md 페어링 PASS (bundled/flattened checked++)
- pre-commit 14 hook 모두 PASS

회귀 0. r_1/r_7 mitigation 정합.

## 관련

- DESIGN: [`../MILESTONE.md`](../MILESTONE.md) (DESIGN H2 섹션)
- phase-1: [`phase-1.md`](phase-1.md)
- source 5 파일 phase-1 commit: `059206c`
