# VERIFY — v3.5 open-stage-discipline-strengthening

```json
{
  "version": "v3.5",
  "id": "open-stage-discipline-strengthening",
  "smoke_tests": [
    {
      "name": "smoke-open-stage-discipline (단독, 신규 도입 검증)",
      "command": "bash tests/smoke-open-stage-discipline.sh",
      "result": "PASS",
      "output": "smoke-open-stage-discipline PASS (9-stage-bundled checked=6, historical skipped=18)"
    },
    {
      "name": "smoke-open-stage-discipline (violation 주입 검증)",
      "command": "mkdir projects/meta/milestones/v99.99 && bash tests/smoke-open-stage-discipline.sh; rmdir projects/meta/milestones/v99.99",
      "result": "PASS (FAIL → 복원 → PASS cascade 정상)",
      "output": "violation 주입 시: exit code 1 + FAIL 메시지 ('디렉토리 ↔ milestones.md 페어링 위배 — 9-stage-bundled era 의무 충족 부재'). cp949 mojibake 출력은 D7 + v3.1 L5 narrative 정합 (Windows cp949 콘솔 errors='replace' 치환, exit=1 정상). 복원 시: PASS 복귀."
    },
    {
      "name": "pre-commit run --all-files (post-phase-1)",
      "command": "pre-commit run --all-files",
      "result": "PASS (14 hook)",
      "output": "5 base + shellcheck + markdownlint + 7 active local (smoke-projects-scope-discipline / smoke-spec-verification / smoke-scope-contract / smoke-cross-ref / smoke-claude-md-drift / smoke-bundle-trigger / smoke-open-stage-discipline) 모두 PASS."
    },
    {
      "name": "pre-commit run --all-files (post-phase-2)",
      "command": "pre-commit run --all-files",
      "result": "PASS (14 hook)",
      "output": "phase-2 변경 (claude/commands/harness-meta.md Stage D 신규 step + Stage A step 7 보강) 후 재실행. 14 hook 모두 PASS, markdownlint 자동 차단 회피 (강조 직후 paragraph + underscore identifier backtick escape) 검증."
    }
  ],
  "manual_checks": [
    {
      "check": "Stage D 신규 sub-section 위치 (5 관점 표 + 의견 충돌 처리 직후, Stage E 헤더 직전)",
      "result": "정합",
      "notes": "D8 결정 timing ('phases[] 확정 = 5 관점 검토 후') 정합. 사용자가 Stage D 진입 시 마지막 sub-section 으로 즉시 발견 가능."
    },
    {
      "check": "Stage A step 7 미세 보강 ('placeholder title 교체' 표현)",
      "result": "양방향 표현 통일",
      "notes": "Stage A forward cross-ref + Stage D backward cross-ref 모두 '(placeholder title 교체)' 표현 1:1 통일 — 사용자 진입 stage 무관 narrative 일관성 (spec-drift C4 흡수)."
    },
    {
      "check": "자기참조 도그푸드 — v3.5 milestones.md sub_milestones 가 phases[] 와 1:1 정합",
      "result": "정합",
      "notes": "Stage D DESIGN 단계 (5 관점 검토 + 흡수) 직후 milestones.md placeholder → 실 phase title 교체 완료 — phase-2 narrative 산출 결과를 본 milestone Stage D 실 실행 흐름에 retroactive 적용한 첫 자기참조 사례 (도그푸드)."
    },
    {
      "check": "신규 smoke 의 9-stage-bundled era 표지 (디렉토리명 + milestones.md) 1:1 정합 (D3)",
      "result": "정합",
      "notes": "tests/_era_detect.py:27 의 표지 정의 (re.match(r'^v\\d+\\.\\d+$', mdir.name) and (mdir / 'milestones.md').is_file()) 와 tests/smoke-open-stage-discipline.sh:42-46 의 검증 알고리즘 (BUNDLED_NAME_REGEX = re.compile(r'^v\\d+\\.\\d+$') + ms_file.is_file()) 동치 확인."
    },
    {
      "check": "신규 smoke 의 historical era forward-only skip (D6)",
      "result": "정합",
      "notes": "violation 주입 시 skipped=18 — historical 디렉토리 (v1.84_* 5건 + v1.0_* / v1.1_* / v1.2_* / v1.3_* / v1.4_* 등 + v2.0_*/v2.1_*) 자연 skip. 표지 정규식 매칭 부재로 자동 skip 동작 확인."
    },
    {
      "check": "신규 smoke pre-commit hook entry 패턴 (D4 정정 후)",
      "result": "정합",
      "notes": ".pre-commit-config.yaml hook entry files 패턴 'projects/[^/]+/milestones/v[0-9]+\\.[0-9]+/.*\\.md$|\\.pre-commit-config\\.yaml$' — 회귀 risk HIGH 흡수 후 D6 정규식과 1:1 정합. 자기참조 검증 (pre-commit-config 자체 변경 시 트리거) 포함."
    },
    {
      "check": "bundle-trigger 와 책임 직교 (D3 보강)",
      "result": "정합",
      "notes": "smoke-bundle-trigger.sh (ROADMAP entry → 실 파일 방향, entry schema 의무) + smoke-open-stage-discipline.sh (디렉토리 → milestones.md 방향, 페어링 의무) — 두 책임은 검사 방향 직교. tests/CLAUDE.md L208 책임 분리 규약 (v3.1 L3 D16) 정합."
    }
  ],
  "criteria_check": [
    {
      "criterion": "OPEN 단계 종료 시점 '디렉토리 ↔ milestones.md 페어링 부재' 를 smoke 가 자동 검출 (디렉토리 명 ^v\\d+\\.\\d+$ 매칭 후 milestones.md 부재 시 FAIL) — tests/_era_detect.py:27 9-stage-bundled 표지와 1:1 정합",
      "pass": true,
      "evidence": "smoke-open-stage-discipline violation 주입 검증 — v99.99/ 디렉토리 (milestones.md 부재) → exit code 1 + FAIL 메시지. 표지 정의 manual check 동치 확인."
    },
    {
      "criterion": "Stage D 절차 narrative 에 'phases[] 확정 후 milestones.md sub_milestones 1:1 동기 갱신' step 신규 명시 + Stage A step 7 와 cross-ref",
      "pass": true,
      "evidence": "phase-2 commit a4aa8c7 — claude/commands/harness-meta.md Stage D 끝 신규 sub-section ('Stage D 완료 직전 의무 step') 삽입 + Stage A step 7 placeholder narrative 끝 '(placeholder title 교체)' 미세 추가. 양방향 cross-ref 명시."
    },
    {
      "criterion": "pre-commit 13 hook (또는 신규 smoke 도입 시 14 hook) 모두 PASS",
      "pass": true,
      "evidence": "post-phase-1 + post-phase-2 + Stage G violation 주입 후 복원 (3회) 모두 14 hook (5 base + shellcheck + markdownlint + 7 active local) PASS."
    },
    {
      "criterion": "본 milestone 의 OPEN 단계 자체가 자기참조 부합 (이미 충족 — Stage A 종료 시점 3 조건 모두 보유)",
      "pass": true,
      "evidence": "Stage A 종료 시점 ROADMAP entry status: in_progress + milestones_path: 'milestones/v3.5/milestones.md' + 실 파일 보유 (3 조건 충족). smoke-open-stage-discipline 첫 실행에 v3.5/ 디렉토리 PASS (checked=6 안 포함). 도그푸드 부합."
    },
    {
      "criterion": "DESIGN 5 관점 (범위가 ≤5 파일이면 3 관점, 6~15 파일이면 4 관점) 병렬 검토 모두 pass 또는 pass-with-comments + 의견 충돌 시 사용자 결정 게이트",
      "pass": true,
      "evidence": "D11 결정 — 4 관점 (architecture / spec-drift / 회귀 risk / scope contract) 병렬 검토. 4 모두 pass-with-comments + 의견 충돌 0. 필수 흡수 4건 + 선택 흡수 2건 + phase-2 작업 시점 권고 3건 모두 처리 (APPROVE.md 안 명시)."
    },
    {
      "criterion": "VERIFY.criteria_check 가 본 success_criteria 와 1:1 매핑 PASS + 회귀 0",
      "pass": true,
      "evidence": "본 VERIFY.md 의 criteria_check 6 항목 모두 INTENT.success_criteria 6 항목과 1:1 매핑 + 모두 pass=true. regressions: 0."
    }
  ],
  "verdict": "pass",
  "regressions": []
}
```

## 검증 narrative

### violation 주입 검증 (controlled comparison 일종)

신규 smoke (tests/CLAUDE.md § '회귀 검증 절차' 신규 smoke 추가 3번 의무) 의 dynamic 검증 — `projects/meta/milestones/v99.99/` 임시 디렉토리 (milestones.md 부재) 생성 후 smoke 실행 → exit code 1 + FAIL 메시지 정상 출력 (cp949 mojibake 는 D7 + tests/CLAUDE.md § '흔한 함정' 6번 + v3.1 L5 narrative '의도된 동작' 정합). 복원 후 PASS 복귀 → cascade 검출 동작 검증.

### 자기참조 도그푸드

본 milestone 의 워크플로우 진행 자체가 본 milestone 의 신규 narrative + 신규 smoke 의 첫 자기 적용 사례:

1. **OPEN 단계 자기참조** (v3.4 step 7) — Stage A 종료 시점에 milestones.md skeleton 즉시 작성 (3 조건 충족) → phase-1 신규 smoke 첫 실행 시 v3.5/ PASS
2. **Stage D 자기참조** (v3.5 phase-2 신규 step) — Stage D 5 관점 검토 + 흡수 직후 milestones.md sub_milestones placeholder → 실 phase title 교체 완료 (phase-2 narrative 의 사전 적용 = retroactive 도그푸드)
3. **smoke 자기참조** (v3.5 phase-1) — pre-commit run --all-files 안 smoke-open-stage-discipline 가 본 milestone 자체 디렉토리 (v3.5/) 검증 PASS

## 관련

- 1차 source: [`milestones.md`](milestones.md), [`INTENT.md`](INTENT.md), [`RESEARCH.md`](RESEARCH.md), [`DESIGN.md`](DESIGN.md), [`APPROVE.md`](APPROVE.md)
- phase 산출물: [`execute/phase-1.md`](execute/phase-1.md) (35c621c), [`execute/phase-2.md`](execute/phase-2.md) (a4aa8c7)
- 신규 smoke: [`../../../../tests/smoke-open-stage-discipline.sh`](../../../../tests/smoke-open-stage-discipline.sh)
- workflow 갱신: [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md) Stage D + Stage A step 7
- 회귀 차단 narrative: [`../../../../tests/CLAUDE.md`](../../../../tests/CLAUDE.md) § '핵심 정책 검증' + § '현행 hook 현황'
