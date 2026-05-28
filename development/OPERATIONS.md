# meta — Operations

harness-meta repo 의 **운영 매뉴얼 단일 source** — 비대칭 의도 (외부 project milestone 위치) + era 정책 (4 era 명문화 + bundling) + AI Native 운영 정의 (3면 매트릭스) + Entry title 가이드 (4 원칙).

> 운영 가이드 + CRITICAL 규칙: root [`../CLAUDE.md`](../CLAUDE.md). 본질 정합 = [`ARCHITECTURE.md`](ARCHITECTURE.md) (구조 + 정체성 + 책임 레이어). 워크플로우 정의 (9-stage / bundling / Stage 본질 / 가벼운 흐름 / 분야 발현) = [`WORKFLOW.md`](WORKFLOW.md).
>
> **본질 분리 (v9.1+)**: 본 파일은 development/ARCHITECTURE.md 의 운영 본질 (구 § 5 / § 6 / § 7.1 / § 7.2) 단일 source. v9.1_architecture-md-split-by-canonical-definition 정전화.

## 1. 비대칭 의도 (CRITICAL)

`development/milestones/` 는 본 repo 안에 존재하지만 `projects/upbit/milestones/` 는 **부재** — upbit milestone 산출물은 upbit repo 자체에 위치한다 (root CLAUDE.md "프로젝트별 하네스 개선" 컨벤션). meta는 본 repo가 곧 자체 작업 공간이므로 본 repo의 `development/milestones/` 보유.

이 비대칭은 의도적: `projects/<name>/` 는 "harness-meta 가 인지하는 외부 프로젝트 trace 의 view" 이며, milestone 산출물 본체는 해당 프로젝트 repo 자체에 위치한다. harness-meta 자체 개발 이력만 본 repo 의 `development/milestones/` 를 보유한다. 미래 N 개 프로젝트 추가 시 동일 패턴 — 본 repo 안 `projects/<name>/` 는 ROADMAP + ARCHITECTURE view 만 갖고, 산출물은 target repo 로 위임한다.

## 2. 변경 시 주의 + era 정책

- root `CLAUDE.md` / `AGENTS.md` 갱신 시 본 ARCHITECTURE.md 동기 검토 (drift risk)
- 신규 meta milestone 진입 시 `development/milestones/v{X.Y}/` 생성 (root `milestones/` 부활 금지)
- root ROADMAP.md 는 thin index 유지 — milestones[] 키 추가 금지 (smoke `tests/smoke-projects-scope-discipline.sh` 가 차단)
- ★ § 3 (하네스 엔지니어링 정의) 본문·매트릭스는 **본 파일이 단일 source** — 다른 문서로 복제 금지, cross-ref 만 허용

### 2.1 era 정책 (4 era 명문화 + bundling)

milestone 디렉토리 명 + 산출 파일명 자체로 era 자동 추론:

| era | version 범위 | era 표지 (smoke 자동 식별) | 신규 작업 |
|---|---|---|---|
| **9-stage-flattened** | v6.2+ | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `MILESTONE.md` (단일 본책, H2 9 섹션 = ## INTENT / ## RESEARCH / ## DESIGN / ## APPROVE / ## EXECUTE / ## VERIFY / ## REPORT / ## PROPOSE / ## SUB_MILESTONES + 조건부 ## SCOPE_OUT_NOTES) + execute/phase-{n}.md (별책) | ✅ 큰 건 (컨설팅 자산 영향) 의무 (v6.2+ 신규) |
| **4-section-lightweight** | v8.1+ | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `LIGHTWEIGHT.md` (단일 본책, H2 4 섹션 = ## 문제 / ## 결정 / ## 적용 / ## 기록) + `MILESTONE.md` 부재 (detect 순서 = flattened 검사보다 뒤, flattened 우선 보존) | ✅ 작은 건 (내부·작은 조정) 가벼운 흐름 (v8.1+ 신규, § 7.4 정의) |
| **9-stage-bundled** | v3.0~v6.1 | 디렉토리 명 `^v\d+\.\d+$` (밑줄 부재) + `milestones.md` (sub-milestone listing per version) + INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE + execute/phase-{n}.md | ❌ 참조용 보존 (v6.1 까지), 신규 금지 — v6.2+ 9-stage-flattened 의무 |
| **9-stage** | v2.0~v2.1 | 디렉토리 명 `v{X.Y}_{slug}` + INTENT/APPROVE/PROPOSE 3종 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 신규 금지 (forward-only 정책) |
| **7-stage** | v1.0~v1.4 | 디렉토리 명 `v{X.Y}_{slug}` + PLAN.md 존재 + INTENT/APPROVE/PROPOSE 동시 부재 + RESEARCH/DESIGN/VERIFY/REPORT + execute/phase-{n}.md | ❌ 참조용 보존, 신규 금지 |
| **4-tier** | v1.84~v1.88 | 어셈블 plan-N/{PLAN,REPORT}.md (sub-plan 구조) | ❌ 참조용 보존, 신규 금지 |

**9-stage-flattened era 정전화 (v6.2_milestone-artifact-directory-flattening, 2026-05-19)**: AI Native § 3 컨텍스트 효율 면 두 번째 실 적용 milestone (v6.0 정의 → v6.1 JSON 필드 → v6.2 디렉토리 평탄화). 본질 = 1 milestone 디렉토리 안 6~8 파일 분산 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE/milestones.md) → 1 본책 (MILESTONE.md) + 1 별책 디렉토리 (execute/) 통합 = AI 1 Read 으로 milestone 전체 흡수. 형태 = (b) 하이브리드 (책 + 별책 비유) — 본책 안 H2 9 섹션 (8 stage 단어 fidelity 보존 + 1 SUB_MILESTONES listing, v2.0_workflow-word-fidelity 정전화 정합) + 별책 phase-{n}.md (실 구현 일지 분리, 동시 편집 가능). **조건부 ## SCOPE_OUT_NOTES** (v7.0 T1.3, 2026-05-25) = Stage D design-review N+ 가변 안 scope 외 거명 발생 시만 생성하는 선택 H2 (SUB_MILESTONES 선례 정합 — 고정 10 H2 아님, § 11.4 + smoke-spec-verification 은 필수 8 stage 섹션 존재만 검사하므로 추가 섹션 무해). YAML frontmatter = 4 필드 (id/title/version/status — stage 필드 제거, milestone-level 통합 표지 = H2 섹션 자체). 적용 범위 = v6.2+ 신규만 (v3.0~v6.1 28 active 디렉토리 era 보존, era 분기 자연 확장 — forward-only 정책 일관). bundling 정책 (version 단위 1 milestone + sub-milestone phase 매핑) 본질 = ## SUB_MILESTONES 섹션 안 흡수 = bundling 본질 보존 (era 명명 분리 ≠ bundling 정책 폐기). 자기참조 부합 = phase-2 도그푸드 (자체 MILESTONE.md retrofit). detect_era 검사 순서 우선 = 9-stage-flattened (MILESTONE.md 존재 첫 검사, milestones.md 보다 우선 — phase-2 retrofit 일시 동시 존재 케이스 deterministic 보장).

**bundling 정책 (9-stage-bundled era, v3.0+)**: version (= 1 milestone) 단위로 의미 단위 후속 candidates 를 묶음.

- **묶이는 단위 (의미 grouping)**: (a) 같은 모듈 영향 (예: tests/CLAUDE.md 동시 수정), (b) 같은 주제 (예: smoke 인프라 / 정책 명문화), (c) 같은 lessons_learned 에서 발의된 후속 candidates
- **분리 단위 (별 milestone)**: 다른 모듈 / 다른 주제 / 시간 단위만 같은 (release train 모델 부적합)
- **운용**: 한 milestone (= version) 안 sub-milestone 들은 phase 단위 1 commit 으로 운용. INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE 산출물은 통합 1건. ROADMAP `milestones[]` entry 는 version 단위 1건 (sub-milestone 상세는 milestones.md 위임)

**1-phase milestone 정합 (v3.17_phase-distribution-audit 진단 + v3.18_option-a-natural-adaptation-narrative 정전화)**: 같은 의미 단위 후속 candidates 가 1건 (= `sub_milestones[]` 1 entry) 일 때도 본 era 정합 — `milestones.md` 가 narrative 1차 source 책임 충족하면 phase 다중 통합 (≥2 건 자연 활용) 와 1-phase 정전화 (1 건) 두 경로 모두 정상. 정량: v3.7~v3.16 = 100% 1-phase, v3.x 전체 17 milestone = 12/17 = 70.6% 1-phase (`development/milestones/v3.17/RESEARCH.md` 분포표 1차 source). bundling 의미 grouping 본질 = 후속 candidates 가 ≥2 건일 때 자연 활용 도구, 단일 후속 시 1-phase 강제 분할 부재.

**자기참조 부합 (도그푸드, v3.0+ 권장)**: 새 era 도입 milestone 자체가 신 구조 첫 적용. 회피 표지 (v2.0 선례 — 본 milestone `v2.0_workflow-word-fidelity` 자체가 7-stage 포맷 사용, chicken-and-egg 회피) 는 신뢰 부족 시만 예외. v3.0_milestones-restructure 는 부합 채택 — phase-1 smoke era branching 선결 commit 으로 chicken-and-egg mitigate.

**breaking change → major bump (semver)**: era 도입 (= ROADMAP schema + 디렉토리 명 + 모든 cross-ref 영향) 은 breaking change → major bump (예: v2 → v3). semver.org 정합. 단조 증가 정책 (root CLAUDE.md) 직접 적용.

**era 영구화 trade-off (forward-only)**: era N 추가 = smoke 분기 N+1 코드 복잡도 누적. forward-only 정책 (historical 디렉토리 unchanged) 의 직접 비용. detect_era 함수 (`tests/_era_detect.py`, v2.2_era-detect-shared-module 흡수 v3.0 phase-2) 단일 source 로 mitigate. era N+1 추가 시 본 § 2.1 표 + tests/_era_detect.py 갱신 의무.

**milestones.md spec historical era 적용 결정 (v3.1 phase-2 흡수)**: milestones.md spec picture-frame (`development/milestones/v3.0/milestones.md` § Spec, v3.0 phase-5 도입) 의 적용 era 정책 = **옵션 (a) forward-only 강제**. v3.0+ 9-stage-bundled era 만 milestones.md 의무 (§ 2.1 표 행 1), historical era (v2.0~v2.1 9-stage / v1.0~v1.4 7-stage / v1.84~v1.88 4-tier) 부재 영구. rationale: (1) v2.x 9-stage flat 구조 = 디렉토리 명 `v{X.Y}_{slug}` 단위 1 milestone (sub-milestone 부재) → milestones.md 의 sub_milestones[] phase 매핑 본질 부적합, (2) v1.x 7-stage / 4-tier 동일, (3) forward-only 정책 (§ 2.1 'era 영구화 trade-off') 직접 일관 — historical 디렉토리 unchanged. 옵션 (b) v2.x retroactive / (c) 신규만 거부 — (b) 본질 부적합 + git mv history 위험, (c) (a) 와 사실상 동치. spec picture-frame: `development/milestones/v3.0/milestones.md`. 본 결정은 v3.1_workflow-policy-fine-tuning phase-2 흡수, historical 디렉토리 변경 부재.

**smoke 자동 식별 보조**: `tests/smoke-spec-verification.sh` + `tests/smoke-scope-contract.sh` 가 위 era 표지로 era 분류 후 schema 차별화 검증 (narrative 1차 source + smoke 보조, § 3.1 정책 일관). detect_era 함수는 `tests/_era_detect.py` 단일 source.

**§ 2.2 폐지 narrative** (v4.0_harness-composer-pivot, 2026-05-13): 구 § 2.2 "Lightweight 모드 정책 (v3.6_overengineering-audit 도입)" + "Workflow self-improvement milestone 동결 정책" + "Narrative 정전화 3단계 패턴" + 선례 2건 모두 v4.0 정체성 재정의로 폐지. 새 정체성 (§ 3.1 끝 paragraph) 이 자연 가드레일 — 자기참조 workflow self-improvement milestone 자체가 새 정체성에 부합 안 함. 본 § 2.2 cross-ref (v3.6 / v3.10 / v3.11 / v3.13 ~ v3.21 entry) 들은 v4.0 phase-2 안 `development/milestones/_archive/` 이전으로 자동 무력화. 자세히: [`milestones/v4.0/INTENT.md`](milestones/v4.0/INTENT.md) + [`milestones/v4.0/DESIGN.md`](milestones/v4.0/DESIGN.md).

**spec-drift spike 패턴** (v5.7_spec-drift-spike-pattern-canonicalization, 2026-05-16 + **v6.13_spec-drift-spike-pattern-c-design-immediate-narrative + v6.14_audit-fact-verify-numeric-lookup-cycle-7-extension + v6.15_v6-4-v6-9-entry-title-active-form-redefinition 보강**, 2026-05-21): 외부 spec 안 정확 명시 부재 (context7 source narrative 표현 추정) 항목의 정정 cycle 4 단계 — (a) RESEARCH 단계 context7 source 추정 진행 (정확 spec 명시 부재 인식 + 추정 명시 의무) → (b) Stage D DESIGN 5 관점 spec-drift agent 검토 안 추정 risk 식별 → (c) 정정 시점 분기 = (c-1) Stage F EXECUTE 안 실 spike (실 호출 / 실 spec 검증) 또는 (c-2) DESIGN 안 즉시 정정 → (d) DESIGN.decisions 또는 phase-{n}.md execution_notes 안 hardcode (정확 spec 값 string literal 명시, 동적 구성 회피). 자연 발현 origin 2건 — v4.2 = (a)→(b)→(c-2) DESIGN 즉시 정정→(d) (Stage F 전 cycle, context7 standard pattern 정정), v5.6 = (a)→(b)→(c-1) Stage F spike→(d) (Stage F 안 cycle, settings.json enabled key 검증). 정정 시점 차이 (c-1 vs c-2) 는 spec 명시 부재 정도에 따라 자연 분기. **v6.13 + v6.14 + v6.15 누적 evidence 보강**: 자연 발현 누적 cycle 12 (v4.2 / v5.6 / v6.2 / v6.3 / v6.4 / v6.5 / v6.6 / v6.8 / v6.9 / v6.13 / v6.14 / v6.15), 분기 분포 11:1 (c-2 vs c-1) — v4.2 + v6.2~v6.9 + v6.13 + v6.14 + v6.15 11건 자체 정전화 cycle 누적 (외부 spec 자체 부재 → c-2 DESIGN 즉시 정정 분기, v6.15 = Conventional Commits / Keep a Changelog 안 entry title style guide 부재 → § 4 본 repo 자체 컨벤션 자기 적용) + v5.6 1건 외부 spec 검증 단일 (settings.json enabled key binary 검증 → c-1 Stage F spike 분기). **분기 본질** = 외부 spec 명시 부재 정도 (자체 정전화 = spec 자체 부재 → c-2 / 외부 spec 검증 = binary 검증 필요 → c-1). 누적 분포 11:1 = 자체 정전화 cycle 우세 evidence — 본 repo 자체 컨벤션 mechanism 도입 시 외부 spec 검증 → 부재 시 자체 정전화 분기가 더 흔한 자연 발현 패턴 사실 진술. § 4 끝 row paragraph 안 individual cycle 명시 (row #8 = cycle 5 v6.4 / row #10 = cycle 7 v6.6 + cycle 9 v6.9 + cycle 11 v6.14) 보존. ecosystem integrator 정체성 (§ 3.1 끝 paragraph) 직접 부합 — context7 spec 정합 가드레일. 자세히: [`milestones/v4.2/DESIGN.md`](milestones/v4.2/DESIGN.md) (D2 origin) + [`milestones/v5.6/DESIGN.md`](milestones/v5.6/DESIGN.md) (D10 origin) + [`milestones/v5.7/DESIGN.md`](milestones/v5.7/DESIGN.md) (정전화) + [`milestones/v6.13/MILESTONE.md`](milestones/v6.13/MILESTONE.md) + [`milestones/v6.14/MILESTONE.md`](milestones/v6.14/MILESTONE.md) + [`milestones/v6.15/MILESTONE.md`](milestones/v6.15/MILESTONE.md) (보강).

## 3. 정의

본 repo (harness-meta) 운영의 본질은 **AI Native 운영** — 본 repo 의 산출물 (ROADMAP / CHANGELOG / milestone 산출물 / cascade narrative) 이 AI (Claude / 다른 LLM agent) 에 의해 가장 자주 흡수되고 활용되며, AI 의 컨텍스트 효율 + 자율성 + 다중 AI 협업 친화도가 운영 품질의 1차 measure 다. § 3.1 끝 정체성 (LLM-agnostic harness engineering consultant + project harness composer + reference adapter maintainer (Claude Code) + portable adapter coordinator (Codex / Gemini / Cursor)) 이 '본 repo 가 무엇을 만드는가' (책임 / 결과물) 라면, AI Native 운영은 '본 repo 가 어떻게 운영되는가' (원칙 / 운영 방식) — 두 차원 직교 보완.

**3 면 매트릭스**:

| 면 | 정의 | 현 baseline |
|---|---|---|
| **컨텍스트 효율** | AI 가 한 자료 (예: ROADMAP entry list) 를 흡수할 때 토큰 비용 + 본질 파악 신속 | entry title ≤ 60자 (§ 4 P2 정합), 한 entry = 한 본질 (§ 4 P1) — v6.0 정전화 |
| **자율성** | AI 가 사용자 명령 모호해도 의도 추출 + milestone 발의 + 진행 + 회고 가능. 사용자 명시 결정 게이트 보존 + AI 가 주도 결정 책임 흡수 | v6.x+ 후속 milestone candidate — 현 baseline = 사용자 명시 발의 의무. Auto-Mode 최소권한 mechanism = § 10 (v7.0 T1.5 정전화, `defaultMode` 활성 v7.1 보류) |
| **다중 AI 협업** | audit-team / external agent / context7 등 여러 AI 사이 컨텍스트 공유 + 책임 분리 명료 + fact 검증 자동 | audit chain 6 cycle 실 호출 (v5.10~v5.19) + Input Verification narrative 정전화 (v5.18) + lint precheck (v5.16) — 진행 중 |

본 매트릭스는 후속 milestone 발의 평가 기준 — 신규 milestone 이 3 면 중 어느 면을 향상시키는가 명시 (§ 3.7 5요소 매트릭스 평가 절차 와 cross-ref 보완).

**제품 역량 검증(외부 vector) 연결** (v8.6): 위 3 면이 '본 repo 운영 품질'의 measure 라면, '제품(컨설팅 자산)이 외부에서 실제 통하는가'의 1차 검증 vector = **외부 적용**이며 자기개발(self-loop) 횟수는 그 증거가 아니다. 정의 1차 source = § 3.1 검증철학 paragraph (본 § 3 은 단방향 pointer, cascade marker 부재 자연 = § 7.3 단방향 pointer 선례 동형).

**컨텍스트 효율 면 mechanism** (v7.1): (a) statusline 컨텍스트 게이지 `[ctx N%]` = statusline.sh 가 stdin `context_window.used_percentage` 표시 (70/90 임계 마커, 부재 시 생략) + (b) stage carry-over 블록 + `/clear` 권고 = stage 완료 결정적 trigger 에 디스크 미기록 in-flight 상태 carry. 두 반쪽은 '게이지 보고(WHEN) → 안전 리셋(HOW)' 한 loop. 1차 source = [`../../CLAUDE.md`](../CLAUDE.md) § 개발 프로세스 (carry-over narrative, always-loaded) — 본 § 3 은 pointer only (정의 중복 회피, cascade marker 부재 자연 = § 7.3 단방향 pointer 선례 동형).

> **§ 7 sub-split cross-ref (d_7 정합, v9.1)**: 본 § (AI Native 정의) 의 3면 매트릭스 (컨텍스트 효율 + 자율성 + 다중 AI 협업) 의 실 적용 사례 = [`WORKFLOW.md`](WORKFLOW.md) § 2 (Stage 본질) + § 3 (가벼운 흐름).

## 4. Entry title 가이드 (4 원칙)

ROADMAP `milestones[]` entry / CHANGELOG bullet header / 기타 entry-form artifact 안 title 작성 시 다음 4 원칙 의무:

1. **한 entry = 한 본질** — bundling 시 (v3.0+ bundling era) 모자 본질만 title 안. 'A + B + C + D' 합치기 형식 금지. 나머지 본질은 summary 필드 안.
2. **≤ 60자 (한국어, 영문 약 120자)** — 한 화면 안 시각 흡수 + LLM context efficiency baseline. 60자 위 = 분류 정확도 감소 + grep keyword false-positive 증가.
3. **Active form + 짧은 동사구 시작** — '재정의 / 도입 / 정전화 / 분리 / 통합 / 흡수 / 갱신' 같은 본질 동사. 명사구 시작 회피.
4. **Detail 은 summary 필드로 분리** — title 은 '무엇' / summary 는 '왜 + 어떻게 + 결과 + cross-ref'.

**smoke 자동 강제 정전화** (v6.3_entry-title-guideline-smoke-verification, 2026-05-20): 위 4 원칙 중 **(1) + (2) 자동 검증** = `tests/smoke-entry-title-guideline.sh` (pre-commit hook 8건째 등재). (1) ' + ' literal space + lookbehind/lookahead non-whitespace P1 mechanical proxy 검출 (코드 식별자 R1+R2 / C++ false-positive 회피). (2) Python `len(title)` codepoint > 60 검출 (한국어 시각 폭 ≈ 영문 120자 baseline). **(3) Active form + (4) Detail summary 분리 = AI 판단 위임** (자동 검증 제외 — 휴리스틱 false-positive 위험 + 의미 차원). enumerate scope = `projects/*/ROADMAP.md` 안 `milestones[]/next_candidates[]/candidate_draft[]` title 필드 + `CHANGELOG.md` bullet bold header (line-by-line + `[^*\n]{1,500}` length-bounded ReDoS 차단). SIZE_LIMIT 100KB 초과 = stderr 경고 + exit 1 FAIL (silent SKIP 폐기, 정책 우회 차단).
