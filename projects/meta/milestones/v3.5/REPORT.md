# REPORT — v3.5 open-stage-discipline-strengthening

```json
{
  "version": "v3.5",
  "id": "open-stage-discipline-strengthening",
  "summary": "v3.4 lessons L1 (cascade smoke 부재) + L3 (Stage D narrative 미명시) bundle 후속. v3.0+ 9-stage-bundled era 두 번째 bundle 사례 (첫: v3.1_workflow-policy-fine-tuning). 2 phase 2 commit + Stage G 종합 commit. phase-1 (35c621c) — `tests/smoke-open-stage-discipline.sh` 신규 + pre-commit hook 등록 (13→14 active) + tests/CLAUDE.md 매트릭스 5 영역 갱신 (헤더 28→29 / narrative active 5→7 / 핵심 정책 검증 표 row + 현행 hook 표 row + inactive 22 active 카운트). phase-2 (a4aa8c7) — claude/commands/harness-meta.md Stage D 끝 신규 sub-section ('Stage D 완료 직전 의무 step') 삽입 + Stage A step 7 placeholder narrative 끝 '(placeholder title 교체)' 미세 추가. 4 관점 병렬 검토 (architecture / spec-drift / 회귀 risk / scope contract) 모두 pass-with-comments + 의견 충돌 0 + 필수 흡수 4건 (D4 정규식 정정 / INTENT goal·motivation·SC#1 phrasing / DESIGN D3 trace 보강 / DESIGN phases[0] affected_files 보강). Stage G commit 첫 시도 시 markdownlint MD032 9 위치 + smoke-bundle-trigger 같은 version 2건 검출 → 정정 (markdownlint list 앞 빈 줄 추가 + v3.6/v3.7 분리) 후 재 commit (L8 lessons 신규 발견). pre-commit 최종 14 hook 모두 PASS, 회귀 0, 자기참조 도그푸드 3 사례 (OPEN/Stage D/smoke).",
  "delta": {
    "files_added": [
      "tests/smoke-open-stage-discipline.sh (신규 smoke, executable)",
      "projects/meta/milestones/v3.5/execute/phase-1.md",
      "projects/meta/milestones/v3.5/execute/phase-2.md",
      "projects/meta/milestones/v3.5/milestones.md (Stage A 산출, Stage G commit 예정)",
      "projects/meta/milestones/v3.5/INTENT.md (Stage B 산출, Stage G commit 예정)",
      "projects/meta/milestones/v3.5/RESEARCH.md (Stage C 산출, Stage G commit 예정)",
      "projects/meta/milestones/v3.5/DESIGN.md (Stage D 산출, Stage G commit 예정)",
      "projects/meta/milestones/v3.5/APPROVE.md (Stage E 산출, Stage G commit 예정)",
      "projects/meta/milestones/v3.5/VERIFY.md (본 단계 직전 작성, Stage G commit 예정)",
      "projects/meta/milestones/v3.5/REPORT.md (본 파일, Stage G commit 예정)"
    ],
    "files_modified": [
      ".pre-commit-config.yaml (active hook 1건 추가, smoke-bundle-trigger 직후)",
      "claude/commands/harness-meta.md (Stage D 끝 신규 sub-section + Stage A step 7 미세 보강)",
      "tests/CLAUDE.md (5 영역 — 헤더 28→29 / narrative 7 active / 핵심 정책 검증 row + 현행 hook 표 row + inactive 22 active 카운트)",
      "projects/meta/ROADMAP.md (v3.5 entry status: pending → in_progress + milestones_path 추가, Stage A — Stage G commit 안 포함)"
    ],
    "files_deleted": [],
    "modules_affected": [
      "tests/ (신규 smoke + CLAUDE.md 매트릭스 narrative)",
      "claude/commands/ (harness-meta.md Stage A + D 절차 narrative)",
      ".pre-commit-config.yaml (active hook 7건 운용)",
      "projects/meta/milestones/ (v3.5/ 신규 컨테이너)",
      "projects/meta/ROADMAP.md (v3.5 entry in_progress + milestones_path)"
    ]
  },
  "lessons_learned": [
    {
      "n": "L1",
      "topic": "cascade 검증 smoke 의 책임 경계 명확화",
      "narrative": "v3.5 phase-1 신규 smoke 의 검증 책임 (디렉토리 → milestones.md 방향, 페어링 의무) 은 기존 smoke-bundle-trigger (ROADMAP entry → 실 파일 방향, entry schema 의무) 와 검사 방향 직교. _era_detect.py 와 1:1 정합 (표지 동치). 세 책임 (era 분류 / entry schema / 디렉토리 페어링) 모두 분리 운용 → tests/CLAUDE.md L208 책임 분리 규약 (v3.1 L3 D16) 직접 적용 사례."
    },
    {
      "n": "L2",
      "topic": "D4 정규식 모순 발견 — 4 관점 검토의 가치",
      "narrative": "DESIGN.D4 의 files 패턴 초안 `v[^/]+` 는 historical 디렉토리 (예: v1.4_infra-minimization) 도 매칭 → D6 검증 정규식 `^v\\d+\\.\\d+$` 와 모순 + 불필요 hook 트리거 누적 위험. 회귀 risk 관점 검토 (Explore subagent) 가 HIGH severity 로 발견 → 흡수. architecture / spec-drift / scope contract 관점만으로는 발견 어려움. **4 관점 검토 (회귀 risk 포함) 의 가치 직접 증명**."
    },
    {
      "n": "L3",
      "topic": "INTENT.motivation phrasing 의 RESEARCH 후 미세 조정 의무",
      "narrative": "INTENT 작성 시점 (Stage B) 의 motivation phrasing 이 RESEARCH (Stage C) 단계의 코드 deep dive 결과와 다소 불일치 — 초안에서 'smoke-bundle-trigger 가 status: in_progress 인데 milestones_path 부재 자체를 FAIL 시그널로 처리하는지 미확인' 으로 갭 모호 표현. RESEARCH 후 smoke-bundle-trigger:96-100 명시 검출 확인 → 진짜 갭 = '디렉토리 생성됐으나 milestones.md 부재 (디렉토리 → 페어링 방향, smoke-bundle-trigger 미커버)'. spec-drift C3 + scope contract 검토 권고로 phrasing 갱신 (절대 갭 정확화). **lessons: INTENT motivation 은 RESEARCH 후 미세 조정 빈발, Stage B → C 간 phrasing 정합 1-pass 부족할 수 있다.**"
    },
    {
      "n": "L4",
      "topic": "Stage D 신규 step (phase-2) 의 retroactive 자기참조 적용",
      "narrative": "v3.5 phase-2 의 결과물 ('Stage D 완료 직전 의무 step — phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신') 이 본 milestone Stage D 단계에 retroactive 적용 — 본 milestone DESIGN 단계의 5 관점 검토 흡수 직후 milestones.md placeholder → 실 phase title 교체 작업 자체가 phase-2 의 narrative 결과를 사전 적용한 첫 자기참조 사례. **lessons: bundle milestone 의 phase 결과가 본 milestone 의 후속 stage 에 즉시 적용되는 retroactive 도그푸드 패턴 (v3.0 도그푸드 부합 정신 직접 강화)**."
    },
    {
      "n": "L5",
      "topic": "violation 주입 cp949 mojibake 정상 동작 (v3.1 L5 반복 발견)",
      "narrative": "Stage G violation 주입 (v99.99/ 디렉토리 임시 생성) 시 신규 smoke 의 FAIL 메시지 안 한글 + em dash 가 Windows cp949 콘솔에서 mojibake (`???` 또는 유사 문자) 로 출력. 이는 `sys.stdout.reconfigure(errors='replace')` (D7) 의 의도된 동작 — UnicodeEncodeError 없이 exit=1 정상 반환. tests/CLAUDE.md '흔한 함정' 6번 + § '회귀 검증 절차' controlled 비교 narrative + v3.1 L5 narrative 정합. **반복 발견 — 향후 신규 smoke 도입 시 cp949 mojibake 정상 동작 narrative 검증 standard step 으로 정착 권고**."
    },
    {
      "n": "L6",
      "topic": "bundle 운용 두 번째 사례 (v3.0 bundling 정책 적용 누적)",
      "narrative": "v3.0_milestones-restructure 의 bundling 정책 적용 — v3.1 (markdownlint trap + milestones-md historical + smoke-bundle-trigger 3 sub-milestone) 가 첫 사례, v3.5 (cascade smoke + Stage D narrative 동기 2 sub-milestone) 가 두 번째 사례. **bundle 의미 grouping trigger (같은 부모 lessons + 같은 모듈 + 같은 주제) 가 자연스럽게 작동 — version 단위 1 milestone 운용 시 토큰 절약 + INTENT/RESEARCH/DESIGN/APPROVE 통합 1건 + execute/phase-{n}.md sub-milestone 1:1 매핑 패턴 누적 검증**."
    },
    {
      "n": "L7",
      "topic": "OPEN 단계 자기참조 도그푸드 첫 적용 (v3.4 step 7 의 첫 자기 사용)",
      "narrative": "v3.5 는 v3.4_open-stage-milestones-md-protocol 의 Stage A step 7 narrative 의 첫 자기 적용 사례 — Stage A 종료 시점에 ROADMAP entry status: in_progress + milestones_path 보유 + milestones.md 실 파일 보유 3 조건 모두 충족. 그 결과 본 milestone phase-1 의 신규 smoke 가 v3.5/ 자체 디렉토리 PASS (checked=6 안 포함). **lessons: 자기참조 도그푸드 가 narrative 강제 (v3.4) + 자동 강제 (v3.5) 의 양면을 한 milestone 안에서 직접 검증 완료**."
    },
    {
      "n": "L8",
      "topic": "smoke 자동 강제력 PROPOSE 단계 직접 작동 (bundling 정책 분기점)",
      "narrative": "v3.5 PROPOSE 초안에서 next_candidates 2건 모두 v3.6 minor bump 시도 (milestones-md-validation-extension + workflow-narrative-strengthening-v2). Stage G commit 시점 smoke-bundle-trigger 가 같은 version 값 2건 검출 → 자동 분리 강제 (v3.6 + v3.7 별 version, smoke FAIL 메시지가 의사 결정 trigger). 두 후보의 주제 grouping (자동 강제 vs narrative 강화) 다르므로 분리 자연. **lessons: v3.0 bundling 정책의 자동 강제력이 PROPOSE 단계 의사 결정 분기점에서 직접 작동 — narrative 강제 (사용자 의사) + 자동 강제 (smoke) 의 cascade 협력 패턴 검증 첫 사례**. 본 발견은 markdownlint MD032 9 위치 동시 발견과 함께 Stage G commit FAIL → 정정 → 재시도 cycle 안에서 발생 — pre-commit hook 이 narrative 결정 의사를 사후 강제하는 자동화 가치 직접 증명."
    }
  ]
}
```

## 종합 narrative

v3.5 는 v3.4 lessons L1 + L3 의 bundle 후속으로 v3.0+ 9-stage-bundled era 두 번째 bundle milestone. 2 phase 2 commit + 4 관점 병렬 검토 + 사용자 명시 승인 게이트 + Stage G violation 주입 검증 모두 정상. pre-commit 14 hook (5 base + shellcheck + markdownlint + 7 active local) PASS 회귀 0.

**자기참조 도그푸드 3 사례 누적**:

1. OPEN 단계 (v3.4 step 7 첫 자기 적용)
2. Stage D 단계 (v3.5 phase-2 신규 step retroactive 적용)
3. smoke 자체 (v3.5 phase-1 신규 smoke 가 본 milestone 디렉토리 PASS)

다음 forward 후속 candidates (PROPOSE.md 분리).

## 관련

- 1차 source: [`milestones.md`](milestones.md), [`INTENT.md`](INTENT.md), [`RESEARCH.md`](RESEARCH.md), [`DESIGN.md`](DESIGN.md), [`APPROVE.md`](APPROVE.md), [`VERIFY.md`](VERIFY.md)
- phase 산출물: [`execute/phase-1.md`](execute/phase-1.md), [`execute/phase-2.md`](execute/phase-2.md)
- 직속 부모: [`../v3.4/REPORT.md`](../v3.4/REPORT.md) (L1 + L3)
- 첫 bundle 사례: [`../v3.1/REPORT.md`](../v3.1/REPORT.md)
- forward 후속: [`PROPOSE.md`](PROPOSE.md)
