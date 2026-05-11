# RESEARCH — v3.6 overengineering-audit

```json
{
  "external": [
    {
      "source": "Martin Fowler — Harness engineering for coding agent users",
      "url": "https://martinfowler.com/articles/harness-engineering.html",
      "topic": "lightweight harness 권고",
      "findings": "피드포워드 (Guides — agent 행동 사전 유도) + 피드백 (Sensors — 사후 자체수정) 균형. 경량 (계산 기반 — 린터/타입체크/구조테스트, 밀리초~초) 우선 + 중량 (추론 기반 — AI 리뷰/의미분석) 은 통합 후 파이프라인만. 'A good harness should not necessarily aim to fully eliminate human input, but to direct it to where our input is most important.'",
      "drift": "본 repo 는 narrative + smoke (경량) + 9-stage subagent 5 관점 (중량) 을 매 milestone 의무 적용 — 중량을 통합 후가 아니라 매 결정마다 강제"
    },
    {
      "source": "OpenAI — Harness engineering: leveraging Codex",
      "url": "https://openai.com/index/harness-engineering/",
      "topic": "Bitter Lesson — control flow vs atomic tools",
      "findings": "'Do not build massive control flows. Provide robust atomic tools. Let the model make the plan.' harness lightweight 의무 — 모델 업데이트마다 control flow deprecate 위험. 'pick a harness framework, configure it along the four pillars (system prompt, tools, context, subagents), and put the rest of your effort into domain-specific prompt and tool design.'",
      "drift": "본 repo 의 9-stage workflow + 5 관점 검토 + 4 era 분기 = massive control flow. Bitter Lesson 직접 충돌"
    },
    {
      "source": "Anthropic — Claude Code Agent Skills",
      "url": "https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview",
      "topic": "progressive disclosure",
      "findings": "Skills 는 frontmatter 100 토큰 scan → 관련 시 < 5k 토큰 본문 load. CLAUDE.md 는 session 시작마다 자동 로드. fresh session ≈ 20k 토큰, quality 저하 임계 20~40% 컨텍스트, 60% cap 권고",
      "drift": "본 repo 는 'SKILL 자동 invoke 거부' 명시 (ARCHITECTURE.md § 3.1) — Anthropic spec 정면 거부. 결과로 narrative 강제 (5,041 LOC smoke + 14,829 LOC milestone narrative) 로 통제, 토큰 효율 spec 위배"
    },
    {
      "source": "Pi — canonical slim coding harness",
      "url": "https://prowe214.medium.com/agentic-coding-harnesses-a-comparison-4db34b87fd5c",
      "topic": "minimalist counterpoint",
      "findings": "Pi 는 minimalist open-source coding harness — 'slim but powerful' canonical 사례. owning harness behavior + full visibility into every token/tool call. 비용: up-front harness engineering + ongoing maintenance.",
      "drift": "본 repo 는 Claude Code 위에 추가 추상화 누적 (9-stage + smoke + skill + hook + statusline + 4 era), Pi 정신과 정반대 (Claude Code 슬림화가 아니라 무거운 메타 레이어)"
    }
  ],
  "codebase": {
    "quantitative_signals": {
      "duration_days": 18,
      "commits_total": 235,
      "commits_per_day_avg": 13,
      "authors": 1,
      "markdown_files": 224,
      "smoke_scripts_total": 29,
      "smoke_scripts_active": 7,
      "smoke_scripts_inactive": 22,
      "smoke_loc_total": 5041,
      "milestone_dirs": 24,
      "milestone_narrative_loc_total": 14829,
      "workflow_major_bumps": 3,
      "era_count_coexisting": 4,
      "external_project_application": 0,
      "workflow_self_improvement_milestones": 9,
      "pending_workflow_strengthening": 4,
      "pending_total": 6
    },
    "narrative_to_code_ratio": {
      "v3.5_total_narrative_loc": 897,
      "v3.5_actual_code_change": "smoke 1건 신규 + slash command 미세 narrative 수정",
      "estimated_overhead_multiplier": "5~9x"
    },
    "self_reference_cycle_evidence": [
      "v1.0 → v2.0 → v3.0 — 18일간 workflow 3회 major bump",
      "v2.0_workflow-word-fidelity (단어 의미 부합 정정 자체가 milestone)",
      "v3.4_open-stage-milestones-md-protocol (Stage A step 7 신규)",
      "v3.5_open-stage-discipline-strengthening (Stage D 신규 step)",
      "v3.7 pending workflow-narrative-strengthening-v2 (narrative 강화의 v2)",
      "smoke 자체를 검증하는 smoke (smoke-python-entry-boilerplate, smoke-bash-permission-pattern)"
    ]
  },
  "options": [
    {
      "option": "A. lightweight remediation only (즉시 적용 가능 권고 #1/#4/#6/#7)",
      "pros": "본 milestone scope 적정, lightweight 모드 정합, breaking change 부재, 회귀 risk 최소",
      "cons": "9-stage trim / 5 관점 trim / 4 era migration 미적용 — 자기참조 사이클 근본 해결 X (구조적 trim 필요)"
    },
    {
      "option": "B. 전면 trim (권고 7건 모두 1 milestone 안)",
      "pros": "오버엔지니어링 근본 해소",
      "cons": "9-stage trim + 4 era forward migration = breaking change → major bump (v4.0) + 자기참조 사이클 재진입 (workflow 변경 milestone), lightweight 모드 정신 자체 위배, 산출물 대량 narrative 생산"
    },
    {
      "option": "C. milestone 부재 — 즉시 ad-hoc 정리만",
      "pros": "narrative 0, 가장 lightweight",
      "cons": "audit trail 부재, 권고 적용 기록 손실, v3.6 entry 없으면 외부 reviewer 사후 추적 불가"
    }
  ],
  "risks_identified": [
    {
      "risk": "R1. lightweight 모드 자체가 자기참조 회피 표지 — '도그푸드 부재' narrative 가 또 다른 narrative 부담",
      "severity": "low",
      "mitigation": "v2.0 선례 직접 참조, ARCHITECTURE.md § 6.1 정합 (예외 표지 narrative 1줄)"
    },
    {
      "risk": "R2. 권고 #4 (smoke inactive 처분) 가 'archive 이동' 일 때 git history 손실",
      "severity": "medium",
      "mitigation": "git mv 사용 (history 보존), 또는 delete + commit log 거명 (PROPOSE 단계 사용자 결정)"
    },
    {
      "risk": "R3. 권고 #6 (narrative cap) 의 'cap 정책 명문화' 자체가 workflow 변경 → workflow self-improvement milestone 사이클 재진입 trigger",
      "severity": "high",
      "mitigation": "cap 정책 narrative 는 ARCHITECTURE.md § 3.1 (정의) 안 1 paragraph 또는 lightweight 모드 표지 정책 1 paragraph 만 추가, claude/commands/harness-meta.md (workflow 자체) 변경 회피"
    },
    {
      "risk": "R4. 권고 #7 (upbit 외부 적용) 발의 시 .harness.toml 부재 / upbit repo 별 작업 필요 — 본 milestone scope 초과",
      "severity": "medium",
      "mitigation": "PROPOSE 단계에서 'upbit 실 적용 milestone v0.1_setup' next_candidate 등재만, 실 실행은 별 milestone (upbit repo 작업)"
    },
    {
      "risk": "R5. 본 milestone REPORT/PROPOSE 가 또 lessons_learned 5~10개 생산 → workflow self-improvement candidates 등재 사이클 재현",
      "severity": "high",
      "mitigation": "lessons_learned cap (< 5건) + next_candidates 가 workflow 자체 변경 (claude/commands/harness-meta.md / tests/CLAUDE.md / ARCHITECTURE.md § 4) 시 명시적 동결 declaration"
    }
  ]
}
```

## 비고

본 RESEARCH.md 145줄 (cap < 150줄 정합).
