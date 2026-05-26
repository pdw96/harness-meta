# v8.9 execute — phase-2: 3 agent wiring + cross-ref

## changes

1. **`agents/harness-gap-analyzer.md`** (d_2) — Task 1 에 'harness-meta canonical 자산 gap' 단락 추가: § 4 inventory 의 '권고 case' 컬럼 Read 참조 + secret-scan detect 기준(claude_dir=true ∧ hooks `name` 에 `secret`/`scan` 토큰 부재 → gap, 자작 hook 존재 시 gap=false) + heterogeneous 시 직교 격차 보강(replace 아님). Output Format `harness_gaps` 엔트리에 `source: "harness-meta-asset"` 예시 추가(optional 필드).
2. **`agents/claude-docs-mapper.md`** (d_3 + d_6 (b)) — Primary source 에 '영역 4 자산 인벤토리' bullet 추가 + Catalog manual descriptor '3 영역'→'4 영역'. Task 1 에 '영역 4 분기' 단락(gap.source=='harness-meta-asset' → `{gap, asset_source, apply:"copy", claude_doc_ref:null}`, generic 무손상). Output schema 에 harness-meta-asset gap_mapping 예시 추가.
3. **`agents/component-proposer.md`** (d_4) — Task 1 에 'harness-meta-asset 분기' 단락(즉석 frontmatter/system-prompt draft 생략 + canonical 자산 참조 + apply=copy proposal template). Task 2 Summary table 에 'harness-meta-asset' Source case row 추가.

## verification

| smoke | 결과 |
| --- | --- |
| smoke-agent-frontmatter-schema | PASS FAIL=0 (3 agent frontmatter 무손상 — body Task 텍스트만 edit) |
| smoke-cross-ref | PASS=1 FAIL=0 |
| smoke-claude-md-drift | 13/13 PASS |
| spec-verification / scope-contract | PASS FAIL=0 |
| bundle-trigger / open-stage / entry-title / cascade-drift / candidate-draft | 전부 PASS |

전체 active smoke FAIL=0 (sc_5). generic 흐름(영역 1~3) 무손상 — 영역 4 분기는 `source=='harness-meta-asset'` 한정 optional(risk_2).

## 검증 한계 (정직 기록, d_5)

영역 4 wiring 의 **실효(agent 가 실제 detect/매핑/draft 분기 실행)는 정적 smoke 범위 밖** — agent Task 텍스트 = LLM prompt-time 추론 지시문이라 정적 검증 불가. '분기 실작동'은 실 audit 실행(oos_2 외부 적용 trace)에서만 검증 가능. 본 phase 는 'wiring 텍스트 존재 + frontmatter/cross-ref 무손상'까지 입증.

## commit

(milestone 단위 — VERIFY/REPORT/PROPOSE 후 사용자 확인)
