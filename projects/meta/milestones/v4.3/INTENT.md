---
id: v4.3_subagent-discovery-path-research
title: Claude Code subagent discovery 메커니즘 RESEARCH — install (~/.claude/agents/ 매핑) 외 경로 (Plugin spec / settings path / 기타) 발견 + 후속 milestone 발의 narrative
version: v4.3
stage: INTENT
status: completed
---

# INTENT — v4.3 subagent-discovery-path-research (scope rewritten)

## Spec

```json
{
  "goal": "Claude Code 의 subagent discovery 메커니즘을 context7 + code.claude.com primary source 으로 RESEARCH 하여 install (~/.claude/agents/ symlink/copy 매핑) 외 경로 (Claude Code Plugin spec + plugin marketplace + settings.json 안 추가 path 등) 가능 여부 검증한다. 발견 결과 narrative + 후속 milestone 발의 (v4.4 또는 v5.0_plugin-pivot) 안 실 적용 설계. 본 v4.3 자체는 **진단 + 경로 발견** milestone — 실 적용 (구조 변환) 은 후속 milestone carry-over.",
  "success_criteria": [
    "RESEARCH 결과 — Claude Code subagent discovery 경로 후보 1건 이상 발견 + 검증 narrative (context7 + code.claude.com primary source 인용)",
    "발견 경로 별 trade-off 분석 — pros/cons + 사용자 마찰 (onboarding) + drift risk + 정합도 (v4.0 정체성 ecosystem integrator)",
    "DESIGN 안 후속 milestone 설계 narrative — v4.4 또는 v5.0 안 어떤 phase 분할 + 어떤 변경 + breaking change 여부",
    "ROADMAP 안 후속 candidate 1건 이상 등재 (narrative 거명만 또는 pending entry — DESIGN 결정 game 안)",
    "v4.1 narrative drift (.md 파일 영역 Junction 불가능 + SymbolicLink default + copy fallback 실 동작) 정전화 narrative (Lightweight, ARCHITECTURE.md 또는 bootstrap/agents/CLAUDE.md cascade)",
    "본 milestone 자체 산출물 안 forward propose 명령형 부재 (v3.10 부산물 정책 정합)",
    "회귀 0 (pre-commit 14 hook PASS, 기존 smoke 활성 PASS, 산출물 변경 narrative 중심)"
  ],
  "out_of_scope": [
    "Plugin spec 실 적용 — harness-meta 구조 자체를 plugin 으로 변환 / .claude-plugin/plugin.json 추가 / paths 명시 / local marketplace 등록. 본 milestone 의 범위가 아니다 (RESEARCH + 설계만, 실 적용은 후속 milestone carry-over)",
    "두 신규 standalone subagent (environment-auditor + agents-md-sync) 실 호출 검증 — 본 v4.3 의 원래 scope 였으나 install 본질 의문 raise 후 보류 (scope_rewritten_from 안 명시). install 경로 결정 후 별 milestone 안 진행 가능 (사실 진술)",
    "v4.1 narrative drift 정전화 자체의 큰 cascade 변경 — 본 milestone 의 범위가 아니다 (Lightweight 1줄 narrative 만, 큰 cascade 는 후속)",
    "5 멤버 audit-team 재배포 — 본 milestone 의 범위가 아니다 (현 SymbolicLink 작동, 본 milestone 의 RESEARCH 대상이 아니다)",
    "install script 3개 (install.ps1 + install-skills.{ps1,sh}) 폐기 결정 자체 재검토 — 본 milestone 의 범위가 아니다 (v4.0 phase-3 B3 결정 보존)"
  ]
}
```

## Motivation

사용자 의문 raise (`install 로 하는 이유가 뭐야`) → install 본질 narrative 검토 + Claude Code subagent discovery 메커니즘 RESEARCH 발의. v4.1 narrative drift (Junction Windows default 표현 안 .md 파일 영역 부적합) + 실 구현 (SymbolicLink + Developer Mode 의존) drift 의 root cause = '~/.claude/agents/ 단일 discovery 가정'. context7 1차 검증 결과 = **Claude Code Plugin spec 안 plugin marketplace local source 지원** + plugin 안 agents/ 자동 인식 = install 회피 경로 존재 발견. 본 v4.3 = 그 경로 깊이 검증 + 후속 milestone 설계 narrative. install (\~/.claude/agents/ 매핑) 정책 자체 재검토 (v4.1 install-strategy-reaudit 직접 후속, 두 번째 install 정책 재검토 cycle).

## Dependencies

- **predecessor**: v4.2_verify-infra-agent-absorption — 2 standalone subagent 신규 정의 + ad-hoc 검증 narrative origin, v4.1_install-strategy-reaudit — Option D narrative drift (.md 파일 영역 Junction 부적합) + scope rewrite 패턴 첫 사례, v4.0_harness-composer-pivot — 정체성 (Claude Code ecosystem integrator) 정합 narrative + § 6.2 폐지 (workflow self-improvement 자유 발의)
- **successor_potential**: v4.4_install-path-canonicalization 또는 v5.0_plugin-pivot — install 정책 전면 재설계 (RESEARCH 결과 따라 결정, DESIGN 안 narrative), v4.4+ subagent-runtime-validation — 두 신규 standalone subagent 실 호출 검증 (본 v4.3 원래 scope, install 경로 결정 후 진행), v4.4+ v4.1-narrative-drift-correction — v4.1 narrative 의 .md 파일 영역 + Junction 분기 정전화 (Lightweight cascade)

## scope rewrite narrative

**scope_rewritten_from**: 본 v4.3 의 원래 scope = `subagent-runtime-validation` (v4.2 PROPOSE.next_candidates #2 + #4 bundle — environment-auditor + agents-md-sync 첫 호출 실 검증 + Junction 인식 ad-hoc 검증). 사용자 의문 round 3회 (Developer Mode 의존 / install 자체 의문 / install 외 경로 탐색) 안 raise 후 scope rewrite. v4.1 안 'dev-tools-bootstrap → install-strategy-reaudit' scope rewrite 패턴 두 번째 사례.

원래 scope (subagent runtime validation) 은 본 v4.3 PROPOSE 안 후속 candidate (v4.4+) 거명 — install 경로 결정 후 자연 흡수.

## 의도 narrative

본 milestone 의 핵심 본질 = **install (~/.claude/agents/ 매핑) 의 정당성 근본 재검토 + Claude Code subagent discovery 메커니즘 RESEARCH + 발견 결과 narrative 정전화**.

핵심 의도:

1. **install 본질 narrative 부족 진단**: v4.0/4.1/4.2 narrative 안 install (~/.claude/agents/ 매핑) 의 정당성 명확 진술 부재 → 사용자 의문 본질 (왜 install 인가, 어떤 trade-off, 대안 부재 근거).
2. **Claude Code Plugin spec 검증**: context7 1차 검증 결과 = plugin marketplace local source 지원 + plugin 안 agents/ 자동 인식 → install 회피 경로 발견. **본 v4.3 안 깊은 검증**.
3. **후속 milestone 설계 narrative**: RESEARCH 결과 따라 v4.4 (점진) 또는 v5.0 (breaking) 안 install 정책 전면 재설계 설계.

## 자기참조 narrative

본 milestone 자체가 v4.0 정체성 ('Claude Code ecosystem integrator + agent fleet maintainer') 의 깊은 자기 검토 사례 — 현 install 정책 (symlink/copy 매핑) 이 정체성에 정합한가, 더 적합한 경로 (plugin spec) 가 있는가 RESEARCH. § 6.2 폐지 (v4.0) 후 workflow self-improvement 자유 발의 narrative 안 자연 흡수 — 다만 본 milestone 은 workflow self-improvement 가 아니라 **install 정책 재검토** (v4.1 직접 후속).

## 단어-책임 부합 (v2.0 word-fidelity)

본 INTENT.md 는 v2.0 word-fidelity 원칙 정합:

- ✅ goal: 1-2 문장 (RESEARCH + 발견 + 후속 발의 narrative)
- ✅ motivation: 본 milestone 이 왜 필요한가 (사용자 의문 + v4.1 drift + context7 1차 발견)
- ✅ success_criteria: 관측 가능한 결과 (RESEARCH 결과 narrative + DESIGN 후속 설계 + ROADMAP 등재 + 회귀 0)
- ✅ out_of_scope: 사실 진술만 (v3.10 정합 — '본 milestone 의 범위가 아니다' 형식)
- ✅ dependencies: 선행 (v4.0/4.1/4.2) + 후행 (v4.4+/v5.0+ 잠재)
- ❌ phase list / file list / commit 메시지: 부재 (DESIGN 으로 미룸)

## 관련

- 직접 origin: 사용자 의문 round 3회 (Developer Mode 의존 / install 자체 의문 / install 외 경로 탐색) — 본 session log
- v4.2 PROPOSE 원래 origin (carry-over): [`../v4.2/PROPOSE.md`](../v4.2/PROPOSE.md) `next_candidates` #2 + #4
- v4.1 narrative drift: [`../v4.1/REPORT.md`](../v4.1/REPORT.md) (Option D narrative + D7 sequence)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝
- context7 검증 primary source: `/websites/code_claude` library — plugin-marketplaces / plugins-reference / sub-agents / settings
- 운영 가이드: [`../../../../CLAUDE.md`](../../../../CLAUDE.md)
