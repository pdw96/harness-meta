# milestones — v3.1 (sub-milestone listing per version)

본 파일은 v3.0+ 9-stage-bundled era 의 sub-milestone listing per version 정전 source. v3.1 통합 milestone 의 sub-책임 3건을 phase 단위로 매핑.

상위 정책 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1.

spec picture-frame (D17): [`../v3.0/milestones.md`](../v3.0/milestones.md) § Spec — 본 파일은 spec 본문 복제 부재, cross-ref 만 (picture-frame 정신 일관).

## Instance (v3.1_workflow-policy-fine-tuning)

```json
{
  "version": "v3.1",
  "milestone_id": "workflow-policy-fine-tuning",
  "title": "v3.0 bundling 정책 첫 후속 적용 — markdownlint trap / milestones.md historical / bundling trigger smoke",
  "phase_count": 3,
  "status": "in_progress",
  "self_reference_compliance": true,
  "sub_milestones": [
    {
      "id": "markdownlint-trap-narrative",
      "phase": 1,
      "status": "completed",
      "commit_sha": "0a86598",
      "title": "tests/CLAUDE.md § '흔한 함정' 7번째 항목 — markdownlint MD032/MD049 trap narrative",
      "summary": "v3.0 lessons L10 직접 후속. tests/CLAUDE.md § '흔한 함정' 표 7번째 row 추가 (markdownlint 자동 차단 함정) — 증상 (underscore emphasis 오인 + list 빈 줄 부재) + 회피 (백틱 escape + 강조 직후 빈 줄 의무, MD049 spec 직접 인용 D18). milestones/v3.1/milestones.md 신규 (R1 mitigation — detect_era 9-stage-bundled 인식 보장). 자동 강제 부재, 사용자 안내만.",
      "dependencies": [],
      "absorbed_from": "v3.1_markdownlint-trap-narrative (PROPOSE next_candidates)"
    },
    {
      "id": "milestones-md-historical-decision",
      "phase": 2,
      "status": "in_progress",
      "title": "ARCHITECTURE.md § 6.1 — milestones.md historical era 적용 결정 (forward-only 강제)",
      "summary": "milestones.md spec 의 historical era (v2.0~v2.1, v1.0~v1.4) 적용 정책 결정. 옵션 (a) forward-only 강제 채택 (D1) — v2.x 9-stage flat 구조 (sub-milestone 부재) → milestones.md 의 sub_milestones[] phase 매핑 본질 부적합. ARCHITECTURE.md § 6.1 'forward-only era 영구화 trade-off' 단락 안 결정 narrative 추가 1단락 + spec picture-frame cross-ref 'v3.0 milestones.md' 1줄. v3.0 milestones.md unchanged (D12, architecture P1 권고 + 사용자 결정 흡수).",
      "dependencies": [1],
      "absorbed_from": "v3.1_milestones-md-spec-formalization (PROPOSE next_candidates)"
    },
    {
      "id": "bundle-trigger-smoke",
      "phase": 3,
      "status": "pending",
      "title": "tests/smoke-bundle-trigger.sh 신규 + pre-commit 등록 (12 → 13 hook)",
      "summary": "ARCHITECTURE.md § 6.1 bundling 정책 자동 검증 smoke. 검증 책임 (D8): (1) 같은 version 값 v3.0+ entry 1건 강제, (2) v3.0+ entry milestones_path 필드 형식 검증, (3) historical entry 무시 (forward-only). detect_era 미호출 (D16) — ROADMAP entry schema 직접 검사. 표준 절차 적용 (D10) — batched python3 heredoc + cp949 reconfigure errors='replace' + AST audit boilerplate. .pre-commit-config.yaml 안 신규 hook 등록 (entry: direct, D9). tests/CLAUDE.md § smoke 매트릭스 27 → 28 + § Pre-commit 통합 5 → 6 active hook (D15 — phase-3 책임).",
      "dependencies": [2],
      "absorbed_from": "v3.1_smoke-bundle-trigger-validation (PROPOSE next_candidates)"
    }
  ]
}
```

## 흡수 추적성 (D14, v3.0 phase-7 패턴)

| 원 v3.0 PROPOSE next_candidates | 흡수 phase | sub-milestone id |
|---|:-:|---|
| v3.1_markdownlint-trap-narrative | 1 | markdownlint-trap-narrative |
| v3.1_milestones-md-spec-formalization | 2 | milestones-md-historical-decision |
| v3.1_smoke-bundle-trigger-validation | 3 | bundle-trigger-smoke |

각 흡수 commit 메시지에 원 PROPOSE id reference 의무 (D14, v3.0 패턴 일관).

## 의존 그래프

```text
phase-1 (markdownlint-trap-narrative + milestones.md 신규)
    └── phase-2 (historical 결정 narrative)
            └── phase-3 (bundle-trigger smoke + tests/CLAUDE.md 동기화)
```

phase-1 → phase-2 → phase-3 (선형, D6 + D14 dependencies 매핑).

## bundling 정책 첫 후속 적용 사례

본 milestone 은 v3.0_milestones-restructure 도입 정책 (ARCHITECTURE.md § 6.1) 의 **첫 후속 통합 milestone 사례**. v3.0 자체는 자기참조 부합 (도그푸드) 으로 신 구조에 작성되었으나, v3.0 종결 후 bundling 정책의 일상 운용 패턴은 본 v3.1 에서 처음 적용. v3.0 통합 (8 phase, 정책 4 + 흡수 4) 대비 v3.1 통합 (3 phase, sub-milestone 1:1) 의 **소규모 사례** — bundling 정책의 작은 정책 fine-tuning 그룹 운용 패턴 박음.

3 sub-milestone 이 같은 모듈 (tests/) + 같은 주제 (정책 fine-tuning) 의미 단위 grouping (ARCHITECTURE.md § 6.1 bundling trigger 조건 (a) + (b)) — 분리 시 토큰 비효율 (3× INTENT~PROPOSE = 24 산출물 vs 통합 8 산출물 = 67% 감소) + 의존 관계 표현 어려움. v3.0 lessons L3 (bundling 정책 ROADMAP/디렉토리 구조 효과) 직접 적용.

## 관련

- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
- 정전 single source: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 6.1
- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- APPROVE: [`APPROVE.md`](APPROVE.md)
- spec picture-frame source: [`../v3.0/milestones.md`](../v3.0/milestones.md)
- ROADMAP entry: [`../../ROADMAP.md`](../../ROADMAP.md) (v3.1 entry, milestones_path 필드)
