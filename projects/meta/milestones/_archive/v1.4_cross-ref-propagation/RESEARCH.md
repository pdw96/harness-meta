# RESEARCH — v1.4_cross-ref-propagation

```json
{
  "id": "v1.4_cross-ref-propagation",
  "external": [
    {
      "source": "v1.3_harness-engineering-definition DESIGN.decisions[4] / DESIGN.risk_mitigation[4] / phases[2].rationale",
      "topic": "보수 cross-ref 결정 + 후속 milestone 분리 명시",
      "findings": "DESIGN.decisions[4] 'cross-ref 갱신 범위 = 보수 (root CLAUDE.md 1줄만, host 본 milestone 자체)' rationale = 'AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md 는 영문·stale 이슈 동반 → 별개 cleanup milestone (v1.4_cross-ref-propagation 후속 발의). 사용자 결정.' DESIGN.risk_mitigation[4] = 'AGENTS.md / README.md cross-ref 는 후속 milestone 에서 일괄 처리'. DESIGN.phases[2].rationale = 'AGENTS.md / README.md / projects/meta/CLAUDE.md / docs/ARCHITECTURE.md / GUARDRAILS.md cross-ref 는 후속 v1.4_cross-ref-propagation milestone 분리.'",
      "drift": "본 milestone (v1.4_cross-ref-propagation) 이 v1.3 의 후속으로 정확히 매핑됨. drift 0."
    },
    {
      "source": "사용자 의문 round 결정 (PLAN 작성 전 4건 + 모순 재확인 1건)",
      "topic": "scope / docs/ARCHITECTURE 처리 / GUARDRAILS scope / Status 섹션",
      "findings": "(1) cross-ref 일괄 + AGENTS·projects/meta/CLAUDE·README stale 동반, docs/ARCH·GUARDRAILS 별도 처리 — 단 의문 round 2 에서 GUARDRAILS 재확인 시 본 milestone scope 안 명시. (2) docs/ARCHITECTURE.md 폐기 (책임 중복). (3) GUARDRAILS.md 전면 재작성 본 milestone scope 안. (4) AGENTS Status 섹션 일반화 ('Milestone history: see projects/meta/ROADMAP.md').",
      "drift": "v1.3 ROADMAP entry summary ('5곳 cross-ref + 동반 stale 정리') 와 사용자 결정의 미세 차이 — 본 milestone PLAN/RESEARCH 가 사용자 결정에 정합 (cross-ref 4곳 + GUARDRAILS 재작성 + docs/ARCH 폐기). ROADMAP entry summary 는 본 milestone Stage B 에서 갱신됨."
    },
    {
      "source": "정의 host (projects/meta/ARCHITECTURE.md § 3.5)",
      "topic": "단일 source 정합 의무",
      "findings": "§ 3.5 명시: '본 § 3 (하네스 엔지니어링 정의) 는 본 파일이 단일 source. 다른 문서 (root CLAUDE.md, AGENTS.md, README.md, docs/ARCHITECTURE.md, GUARDRAILS.md) 는 cross-ref 만, 정의 본문·매트릭스 중복 금지.' root CLAUDE.md L8 표본 형식 ('★ 하네스 엔지니어링 정의 (정전 single source): ... § 3 — working definition + 5요소 매트릭스 (Context / Workflow / Constraint / Verification / Trace). 신규 milestone 발의는 본 정의 5요소 중 하나에 매핑.') 1줄.",
      "drift": "본 milestone 은 § 3.5 의 cross-ref 대상 5곳 중 docs/ARCHITECTURE.md 폐기로 4곳 (AGENTS·README·projects/meta/CLAUDE·GUARDRAILS) 만 처리. § 3.5 본문도 docs/ARCHITECTURE.md 거명 제거 cascade 대상."
    }
  ],
  "codebase": {
    "current_state_summary": "정의 host (projects/meta/ARCHITECTURE.md § 3) 박혔고 root CLAUDE.md L8 cross-ref 1줄 추가됨 (v1.3 phase-2). host 4곳 (AGENTS·README·projects/meta/CLAUDE·GUARDRAILS) cross-ref 부재. docs/ARCHITECTURE.md 53줄 모든 섹션이 4-tier 시대 잔존 (sessions/<target>/, bootstrap/templates/_base/, bootstrap/docs/, bootstrap/render-manifest.sh, bootstrap/detect-project.sh — 모두 부재 디렉토리/파일). GUARDRAILS.md 92줄 중 sessions/ 7회 + bootstrap C2~C6 매트릭스 (templates/_base, install-project-claude, manifest-schema, docs — 모두 부재) 잔존. AGENTS.md L82-84 Status 섹션이 v1.0~v1.1_readme-cleanup completed + v1.1_agents-md-cleanup in progress 명시 (실제 v1.1_agents-md-cleanup 도 completed + v1.2/v1.3 누락).",
    "affected_files_in_scope": [
      {
        "path": "AGENTS.md",
        "current_state": "84줄, Key docs 섹션 (L73-80) 에 projects/meta/ARCHITECTURE.md 거명 (단순 'Meta architecture'), 정의 § 3 거명 0. Status 섹션 (L82-84) v1.1_agents-md-cleanup in progress stale.",
        "target_state": "Key docs 섹션 갱신 (정의 cross-ref 1줄 추가) + Status 섹션 일반화 ('Milestone history: see projects/meta/ROADMAP.md'). 영문 형식. docs/ARCHITECTURE.md 거명 0 (확인됨, cascade 대상 아님)."
      },
      {
        "path": "README.md",
        "current_state": "203줄, Key docs 섹션 (L184-194) 에 projects/meta/ARCHITECTURE.md 거명 (단순 'Meta repo structural snapshot'), 정의 § 3 거명 0.",
        "target_state": "Key docs 섹션 갱신 (정의 cross-ref 1줄 추가). 영문 형식. docs/ARCHITECTURE.md 거명 0 (확인됨, cascade 대상 아님)."
      },
      {
        "path": "projects/meta/CLAUDE.md",
        "current_state": "23줄 lazy load subdirectory guide. 모듈 가이드 섹션에 ARCHITECTURE.md / ROADMAP.md / milestones/ 거명 있으나 정의 § 3 명시 거명 0. lazy load 시 ARCHITECTURE.md 자동 로드 안 됨 (같은 디렉토리이지만 별도 trigger 없음).",
        "target_state": "정의 cross-ref 1줄 추가 (모듈 가이드 섹션 또는 의도 섹션). 한국어 형식."
      },
      {
        "path": "GUARDRAILS.md",
        "current_state": "92줄. L7 (스코프 안내) sessions/meta/, L28 H1 sessions/meta/<old-version>, L33 H6 sessions/<project>/vX.Y-{name}/, L36 H9 sessions/**/index.json + step{N}.md, L53 C8 sessions/meta/vX.0, L59 sessions/meta/v1.10j-scope-contract-discipline, L91 sessions/meta/vX.Y-guardrails-{topic}/. C2~C6 (L47-51) bootstrap 부재 디렉토리/파일 거명 5건. C7 (5+ 파일 동시 변경) + C8 (vX.0 major bump) 는 7-stage 시대에도 유효. H7 (execute.py / phases/) + H8 (.harness.toml schema) 는 7-stage 시대에도 유효. T4 (L33) / S3 (L91) / S#·T# (L62) 4-tier scope 코드 거명 다수.",
        "target_state": "전면 재작성. sessions/ 거명 0 (milestones/v{X.Y}_{slug}/ 로 갱신). bootstrap C2~C6 매트릭스 제거 (부재 디렉토리). H/C 매트릭스 7-stage 시대 항목으로 재구성. 정의 cross-ref 1줄 추가 (서두 또는 References 섹션). DESIGN.approval 게이트 명시. INTENT.md 3 섹션 의무 (4-tier 시대 'Scope contract') 는 7-stage 의 PLAN.success_criteria + out_of_scope + dependencies 로 재구성."
      },
      {
        "path": "docs/ARCHITECTURE.md",
        "current_state": "53줄 — Layer Model (L9-33) 4-tier sessions/<target>/vX.Y-{name}/ + bootstrap/templates/_base/ + bootstrap/docs/ + bootstrap/interview.md + bootstrap/render-manifest.sh + bootstrap/detect-project.sh + projects/<name>/{ARCHITECTURE,DECISIONS,INTERVIEW,STACK}.md (DECISIONS·INTERVIEW·STACK 도 부재). Install Flow (L46-48) bootstrap/install-project-claude.ps1 거명 (부재). Test Suite (L50-52) tests/smoke-v1.1.sh 거명 (확인 필요).",
        "target_state": "git rm — 파일 자체 폐기. 책임 (글로벌 시스템 도식) 은 projects/meta/ARCHITECTURE.md 가 흡수 (이미 § 1 디렉토리 트리 + § 2 모듈 책임 표 보유). cascade 정리: ROADMAP.md L43 (root '관련 문서') + projects/meta/ARCHITECTURE.md L5 / L46 / L76 / L102 / L112 (5곳)."
      },
      {
        "path": "ROADMAP.md (root)",
        "current_state": "L43 '관련 문서' 섹션에 docs/ARCHITECTURE.md cross-ref 1줄.",
        "target_state": "L43 cross-ref 줄 제거 (docs/ARCHITECTURE.md 폐기 cascade)."
      },
      {
        "path": "projects/meta/ARCHITECTURE.md",
        "current_state": "L5 (본문 단락 위 인용) / L46 (§ 2 모듈 책임 표 row) / L76 (§ 3.5 단일 source 정합 거명 list) / L102 (§ 6 변경 시 주의) / L112 (§ 7 관련 문서) — 5곳 docs/ARCHITECTURE.md 거명.",
        "target_state": "5곳 docs/ARCHITECTURE.md 거명 모두 제거. § 2 모듈 책임 표 row 1행 제거 (table). § 3.5 cross-ref list 에서 docs/ARCHITECTURE.md 거명 제거 (4곳 → 3곳). § 6 변경 시 주의에서 docs/ARCHITECTURE.md 항목 제거. § 7 관련 문서 docs/ARCHITECTURE.md 항목 제거. § 1 본문 단락 위 인용 (L5) docs/ARCHITECTURE.md 거명 제거 (글로벌 시스템 도식 흡수 명시)."
      },
      {
        "path": "projects/meta/ROADMAP.md",
        "current_state": "L18 v1.4_cross-ref-propagation entry status:in_progress (Stage B 에서 갱신됨), L20 summary 갱신됨.",
        "target_state": "Stage G (REPORT 후) 에서 status:completed + summary narrative 으로 최종 갱신."
      }
    ],
    "untouched_files_explicit": [
      {
        "path": "claude/hooks/post-report-write.sh",
        "rationale": "L2 stale 주석 (sessions/**/REPORT.md) + L126 변경 이력 메모 — 실제 패턴은 v1.1_post-report-write-hook-update 에서 정상 갱신됨. 주석 정리는 본 milestone scope 외 (별개 cleanup, 후속 milestone 후보)."
      },
      {
        "path": "claude/CLAUDE.md",
        "rationale": "L39 stale narrative ('현재 silent NOOP, 후속 milestone v1.1_post-report-write-hook-update 처리 예정') — 이미 처리됨. 별개 cleanup."
      },
      {
        "path": "CHANGELOG.md",
        "rationale": "L3 stale path ('sessions/meta/vX.Y-<slug>/REPORT.md') — Status 섹션 일반화 결정과 정합 갱신 후보이나 PLAN.out_of_scope #3 명시 (CHANGELOG.md 신규 작성 또는 갱신). 별개 milestone 후보."
      },
      {
        "path": "projects/upbit/{ARCHITECTURE,ROADMAP}.md",
        "rationale": "sessions/ 거명 (upbit scope 4-tier 시대 historical narrative). 본 milestone scope 외 (meta scope only)."
      },
      {
        "path": "docs/adr/{ADR-002,ADR-005,ADR-006}.md",
        "rationale": "ADR 들의 sessions/ 거명은 변경 이력 narrative — ADR 본질 (영구 기록) 상 정정 금지. 본 milestone scope 외."
      },
      {
        "path": ".gitignore / .markdownlintignore / .env.example",
        "rationale": "bootstrap 부재 디렉토리/파일 거명. 본 milestone 의 docs/ARCHITECTURE.md 폐기 cascade 와 별개 (정의 cross-ref vs 인프라 정전화). v1.5_infra-minimization 후속 milestone 정합."
      },
      {
        "path": "tests/smoke-* (22종 중 다수)",
        "rationale": "bootstrap 부재 디렉토리 거명 (smoke-broad-bash-fine-grain, smoke-bash-permission-pattern, smoke-thinking-effort, smoke-language-overlay, smoke-legacy-cleanup-overlay, smoke-bootstrap-license-*, smoke-bootstrap-render, smoke-skills-install, smoke-sync-agents, smoke-backup-cleanup, smoke-license-line-policy, smoke-roadmap-sync 등 12+ 종). 정의 § 3.3 매트릭스 'Verification 혼재' 의 임시방편 부분 — v1.5_infra-minimization 핵심 trigger. 본 milestone 은 정의 cross-ref + GUARDRAILS 재작성 + docs/ARCH 폐기 만, smoke 정전화는 후속."
      },
      {
        "path": "bootstrap/skills/audit/{harness-roadmap-update,harness-plan-verify}/SKILL.md",
        "rationale": "DEPRECATED 표시된 SKILL 파일 (v1.1 / v1.2). 제거 vs 보존은 별개 milestone (정의 § 3.3 'Context' 의 SKILL 자동 invoke 임시방편 분류 정전화 후속)."
      },
      {
        "path": "ai-ready-report.json",
        "rationale": "generated artifact (AI-Ready scoring 결과). docs/ARCHITECTURE.md 거명은 SKILL 의 generic 패턴 매치 — repo 폐기 후 자동 재생성 시 갱신됨. 본 milestone 직접 처리 X."
      }
    ],
    "untouched_files_summary": "sessions/ 잔존 stale 5곳 + bootstrap 부재 거명 3+ files + smoke 22종 중 12+ + ADR + DEPRECATED SKILL — 모두 본 milestone scope 외. 별개 milestone 후보 (v1.5_infra-minimization / v1.5_legacy-narrative-cleanup / v1.5_skill-deprecation)."
  },
  "options": [
    {
      "topic": "phase 분할",
      "options": [
        {
          "name": "3 phase (cross-ref 일괄 / GUARDRAILS 재작성 / docs/ARCH 폐기 cascade)",
          "pros": ["v1.3 의 2-phase 패턴 확장. 책임 분리 명확 (cross-ref 추가 = Context 정전 보강 / GUARDRAILS 재작성 = 별개 host 정전화 / docs/ARCH 폐기 = cascade cleanup)", "각 phase 독립 commit + smoke 회귀 격리", "EXECUTE 단계 진입 시 phase 별 affected_files 화이트리스트 명확"],
          "cons": ["phase 수 증가로 commit 개수 3개 (Stage G 별도 +1 = 총 4 commit)", "GUARDRAILS 재작성 + docs/ARCH 폐기 가 각각 큰 phase — 한 phase 안의 변경량 격차"]
        },
        {
          "name": "2 phase (cross-ref + GUARDRAILS 재작성 / docs/ARCH 폐기 cascade)",
          "pros": ["GUARDRAILS 안에 정의 cross-ref 1줄 추가가 자연 — 같은 phase 묶음. commit 개수 절감 (Stage G 별도 +1 = 총 3 commit)"],
          "cons": ["phase-1 affected_files 가 5개 (AGENTS·README·projects/meta/CLAUDE·GUARDRAILS·milestone tracker) — 변경량 큼. cross-ref 추가 (1~2줄) + GUARDRAILS 전면 재작성 (92줄→...) 책임 혼재"]
        },
        {
          "name": "4 phase (host 별 + docs/ARCH 폐기)",
          "pros": ["각 host 별 독립 commit — audit trail 가장 세밀"],
          "cons": ["phase 수 과다 (4 + Stage G = 5 commit) — v1.3 lessons '단순 메시지 교체도 phase 분리 이득' 의 over-application", "AGENTS·README·projects/meta/CLAUDE 의 cross-ref 1줄 추가는 같은 책임 — 굳이 분리 안 해도 됨"]
        }
      ]
    },
    {
      "topic": "cross-ref 1줄 위치 (host 별)",
      "options": [
        {
          "name": "Key docs 섹션 항목 description 갱신 (현재 'Meta architecture' / 'Meta repo structural snapshot' → '+ harness engineering definition (canonical single source)')",
          "pros": ["본문 침범 0, Key docs 섹션이 자연 cross-ref location", "host 본문 흐름 보존"],
          "cons": ["description 줄 길어짐 — Key docs 표 폭 영향", "정의 host 가시성 약화 (sub-bullet 처럼 보임)"]
        },
        {
          "name": "독립 헤더 1줄 추가 (host 서두, root CLAUDE.md L8 형식 답습)",
          "pros": ["가시성 강함 — 독립 행 + 'definition' 키워드 grep 즉시 매치", "root CLAUDE.md 와 형식 일치 (cross-host consistency)"],
          "cons": ["host 본문 1줄 추가 — README.md 200+ 줄에 큰 영향 X 이지만 상단 정밀 위치 결정 필요"]
        },
        {
          "name": "host 별 자연 위치 (host 책임 정합)",
          "pros": ["host 별 본문 흐름 최우선 — projects/meta/CLAUDE.md 는 모듈 가이드 섹션, GUARDRAILS 는 References, AGENTS·README 는 Key docs"],
          "cons": ["cross-host 일관성 약화 — Claude 가 host 별 다른 위치 학습 필요"]
        }
      ]
    },
    {
      "topic": "GUARDRAILS.md 재작성 scope 세부",
      "options": [
        {
          "name": "전면 재작성 (sessions/→milestones/, bootstrap C2~C6 제거, H/C 매트릭스 7-stage 시대로 재구성, 정의 cross-ref 추가, DESIGN.approval 게이트 명시)",
          "pros": ["정전 host 자격 — 7-stage 시대 정합. C2~C6 부재 디렉토리 거명 제거로 false positive 0", "DESIGN.approval 의무화 = 본 milestone 의 정의 § 3.5 단일 source 정합 강화 (INTENT.md 작성 단계 자동 참조)"],
          "cons": ["변경량 큼 (92줄 → 추정 70~90줄) — phase 1 의 변경량 격차"]
        },
        {
          "name": "부분 재작성 (sessions/→milestones/ 만, bootstrap C2~C6 보존)",
          "pros": ["변경량 절감"],
          "cons": ["bootstrap 부재 디렉토리 거명 잔존 — false positive 유지. 본 milestone 의 정의 cross-ref 추가에도 host 자체가 stale 잔존 — 정전성 약화"]
        }
      ]
    },
    {
      "topic": "AGENTS.md Status 섹션 일반화 정확한 문구",
      "options": [
        {
          "name": "'Milestone history: see [projects/meta/ROADMAP.md](projects/meta/ROADMAP.md)' (1줄)",
          "pros": ["사용자 결정 직접 답습", "최소 변경"],
          "cons": ["섹션 자체 1줄로 줄어듦 — 외부 가시성 (방문자가 ROADMAP 까지 안 들어가면 인지 0)"]
        },
        {
          "name": "'Public repository, MIT licensed. Milestone history: see [projects/meta/ROADMAP.md].' (status + history 통합 2줄)",
          "pros": ["repo 상태 (Public/MIT) 외부 가시성 보존 + history ROADMAP 위임"],
          "cons": ["복합 — 'Status' 섹션 책임 (현재 milestone 진행 상황) 명확성 약함"]
        },
        {
          "name": "Status 섹션 자체 제거 + Key docs 섹션에 ROADMAP 항목으로 흡수",
          "pros": ["AGENTS.md 단순화"],
          "cons": ["Status (Public/MIT licensed) 메타 정보 사라짐. README.md 또는 LICENSE 로 별도 위임 필요"]
        }
      ]
    }
  ],
  "risks_identified": [
    {
      "id": "R1",
      "risk": "정의 본문 / 5요소 매트릭스 가 cross-ref 추가 host 4곳에 누설 → drift",
      "severity": "high",
      "mitigation_candidate": "v1.3 DESIGN.risk[4] mitigation 답습 — root CLAUDE.md L8 표본 형식 (5요소 이름 + 운영 게이트 1줄, 정의 본문 복제 X). success_criteria #2 (drift 0 강제) + smoke-spec-verification 회귀 검증."
    },
    {
      "id": "R2",
      "risk": "GUARDRAILS 재작성 시 4-tier 시대 'Scope contract' 의무 (3 섹션) 가 7-stage 시대 'PLAN.success_criteria + out_of_scope + dependencies' 와 의미 중복인지 정합인지 모호 — 재작성 결과 GUARDRAILS 의 정전 가치 약화 가능",
      "severity": "medium",
      "mitigation_candidate": "DESIGN 단계에서 4-tier 'Scope contract' 의무 → 7-stage 'PLAN 의무 3 필드 (success_criteria / out_of_scope / dependencies)' 매핑 + 'DESIGN.approval 게이트' (4-tier 시대 명시 부재) 추가. GUARDRAILS 가 PLAN/DESIGN 단계 의무 reminder 역할로 재구성."
    },
    {
      "id": "R3",
      "risk": "docs/ARCHITECTURE.md 폐기 시 cascade 정리 누락 → broken link",
      "severity": "high",
      "mitigation_candidate": "RESEARCH 단계 grep 으로 cascade 대상 7곳 확정 (ROADMAP.md L43 + projects/meta/ARCHITECTURE.md L5/L46/L76/L102/L112 + docs/ARCHITECTURE.md 자체). EXECUTE 후 smoke-cross-ref 회귀 검증 + grep 'docs/ARCHITECTURE' 결과 0 (live 파일) 의무."
    },
    {
      "id": "R4",
      "risk": "AGENTS.md Status 섹션 일반화로 외부 가시성 (방문자 진입 시 milestone 인지) 약화",
      "severity": "low",
      "mitigation_candidate": "DESIGN 단계 옵션 결정 (1줄 / 2줄 통합 / 섹션 제거). README.md Key docs 섹션에 ROADMAP 항목 거명 보존 (이미 존재) → 외부 진입자도 ROADMAP 인지 가능."
    },
    {
      "id": "R5",
      "risk": "phase-3 (docs/ARCH 폐기 cascade) 가 phase-2 (GUARDRAILS 재작성) 와 의존 — phase 순서 잘못 시 cascade 누락",
      "severity": "medium",
      "mitigation_candidate": "phase 순서 = phase-1 cross-ref 일괄 → phase-2 GUARDRAILS 재작성 (정의 cross-ref + docs/ARCH 거명 제거 동시) → phase-3 docs/ARCH 폐기 + cascade. 또는 phase-1 cross-ref → phase-2 docs/ARCH 폐기 → phase-3 GUARDRAILS 재작성. DESIGN 단계 결정."
    },
    {
      "id": "R6",
      "risk": "잔존 sessions/ stale (claude/hooks/post-report-write.sh / claude/CLAUDE.md / projects/upbit/* / CHANGELOG.md) + bootstrap 부재 거명 (smoke 12+ / .gitignore / .markdownlintignore / .env.example) 본 milestone scope 외 — 정전 host 갱신 후에도 임시방편 잔존",
      "severity": "low",
      "mitigation_candidate": "본 milestone 은 cross-ref 4곳 + GUARDRAILS 재작성 + docs/ARCH 폐기 만 — 잔존 stale 은 v1.5_infra-minimization (smoke / bootstrap 부재 거명 정전화) + v1.5_legacy-narrative-cleanup (claude/hooks 주석 / claude/CLAUDE.md L39 / CHANGELOG.md L3 / projects/upbit historical) 후속 milestone 분리. REPORT.next_candidates 에 등록 의무."
    },
    {
      "id": "R7",
      "risk": "scope creep — phase 진행 중 GUARDRAILS 재작성 시 H1~H9 / C1~C8 매트릭스 항목 별 keep/remove/rewrite 결정이 본 milestone 의 cross-ref 전파 정신을 벗어나 'GUARDRAILS 정전화' 별개 milestone 분량",
      "severity": "high",
      "mitigation_candidate": "DESIGN 단계에서 GUARDRAILS 재작성 scope 명시 — 'sessions/→milestones/ 갱신 + bootstrap C2~C6 제거 + 정의 cross-ref 추가 + DESIGN.approval 명시' 4가지 작업으로 한정. H1~H9 / C1~C8 항목 별 의미 변경 (예: 새 H 추가) 은 out_of_scope."
    },
    {
      "id": "R8",
      "risk": "정의 § 3.5 단일 source 정합 list (root CLAUDE.md, AGENTS.md, README.md, docs/ARCHITECTURE.md, GUARDRAILS.md) 에서 docs/ARCHITECTURE.md 제거 → 단일 source 거명 list 갱신 필요. projects/meta/CLAUDE.md (lazy load) 거명 부재 — 본 milestone 의 cross-ref 추가 host 4곳 중 1곳 단일 source list 누락",
      "severity": "medium",
      "mitigation_candidate": "EXECUTE phase-3 (또는 phase-2) docs/ARCH cascade 정리 시 § 3.5 단일 source list 갱신 — docs/ARCHITECTURE.md 제거 + projects/meta/CLAUDE.md 추가. 또는 별도 phase 로 분리 (DESIGN 결정)."
    }
  ]
}
```

## 종합 narrative

본 RESEARCH 의 핵심 발견은 **본 milestone 의 명시 scope (cross-ref 4곳 + GUARDRAILS 재작성 + docs/ARCH 폐기) 외에 잔존 sessions/ stale + bootstrap 부재 거명이 repo 전반에 광범위 잔존** 한다는 점. 이는 정의 § 3.3 매트릭스의 'Verification 혼재' (smoke 임시방편) + 'Context' 의 SKILL 자동 invoke 임시방편 분류와 직접 매핑되며, **본 milestone 은 그 정전화의 첫 단계 (Context 정전 보강) 이고, 후속 v1.5+ milestone 들이 임시방편 정전화 책임**.

cascade 정리 대상은 docs/ARCHITECTURE.md 폐기 시 **7곳** (ROADMAP.md L43 + projects/meta/ARCHITECTURE.md 5곳 + docs/ARCHITECTURE.md 자체). AGENTS·README·GUARDRAILS 는 docs/ARCHITECTURE 거명 부재 (확인됨) — cascade 영향 0.

phase 분할은 DESIGN 단계 5 관점 검토 (architecture / spec-drift / 회귀 risk / scope contract — scope 6+ 파일 분류) 거쳐 확정. 잠정 3 phase (cross-ref 일괄 / GUARDRAILS 재작성 / docs/ARCH 폐기 cascade) 가 v1.3 의 2-phase 패턴 확장 + 책임 분리 명확.

GUARDRAILS 재작성 scope 는 R7 (scope creep) 방어 의무 — 4가지 작업 (sessions/→milestones/ 갱신, bootstrap C2~C6 제거, 정의 cross-ref 추가, DESIGN.approval 명시) 에 한정.
