# REPORT — v4.3 subagent-discovery-path-research

```json
{
  "summary": "v4.3 milestone 의 본질 = '진단 + 경로 발견' (scope rewritten from 'subagent-runtime-validation'). 사용자 의문 round 3 raise (Developer Mode 의존 / install 자체 의문 / install 외 경로 탐색) 안 scope rewrite 결정 후 context7 4 source 검증 (sub-agents docs / plugins-reference / plugin-marketplaces / settings) 으로 Claude Code Plugin spec 안 plugin marketplace local source 지원 + plugin 안 agents/ 자동 인식 발견 = install (~/.claude/agents/ SymbolicLink/Copy 매핑) 회피 경로 단일 발견. DESIGN 7 결정 (D1~D7) + 3 관점 자기 검토 (lightweight 모드) pass + APPROVE 게이트 (Round 5) 후 EXECUTE 1-phase Lightweight 진행. narrative 2 host 정전화 — (1) ARCHITECTURE.md § 3.1 끝 'Install 정책 본질 + Claude Code Plugin spec 대안' paragraph 신규 + (2) bootstrap/agents/CLAUDE.md § D7 sequence 끝 '.md 파일 영역 SymbolicLink default 정정' sub-paragraph 신규 + (3) ROADMAP v5.0_plugin-pivot pending entry 등재 (전면 P1 채택, breaking major bump). v3.21 narrative 정전화 3 단계 패턴 7 번째 cycle 누적 완성 (v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3). VERIFY verdict = pass + 회귀 risk 0 + criteria_check 6건 PASS + 1건 PENDING_AT_COMMIT.\n\nv4.1 scope rewrite 패턴 두 번째 사례 — 첫 사례는 v4.1_dev-tools-bootstrap (APPROVE 게이트 직전 사용자 의문 raise → 폐기 후 새 scope), 두 번째 사례는 본 v4.3 (Stage D 진입 직후 사용자 의문 raise → INTENT/RESEARCH 재작성). 두 사례 모두 scope_rewritten_from 필드 정합 + audit trail = REPORT.lessons_learned + ROADMAP entry summary 보존.\n\nv5.0_plugin-pivot pending entry 등재 narrative = 7 phase scope (plugin.json + marketplace.json + onboarding + component-installer 책임 분리 + install narrative cascade + 두 신규 standalone subagent Plugin 거주 + 5 멤버 migration + breaking CHANGELOG entry). 본 v4.3 = v4.0_harness-composer-pivot (정체성 pivot) 직접 후속의 진단 milestone + v5.0_plugin-pivot 으로 실 적용 자연 흐름.",
  "delta": {
    "files_changed": 2,
    "files_added": 8,
    "files_deleted": 0,
    "modules_affected": [
      "projects/meta/ARCHITECTURE.md — § 3.1 끝 paragraph 신규 1건 (+1 paragraph, ~5 line)",
      "bootstrap/agents/CLAUDE.md — § D7 sequence 끝 sub-paragraph 신규 1건 (+1 paragraph, ~3 line)",
      "projects/meta/ROADMAP.md — v5.0_plugin-pivot pending entry 추가 (+1 entry) + v4.3 entry status in_progress → completed 갱신 + updated 2026-05-14",
      "projects/meta/milestones/v4.3/ — 8 신규 파일 (milestones.md + INTENT.md + RESEARCH.md + DESIGN.md + APPROVE.md + execute/phase-1.md + VERIFY.md + REPORT.md + PROPOSE.md)"
    ],
    "loc_estimate": "narrative 2 host 정전화 +8 line + ROADMAP entry +15 line + milestones/v4.3/ 8 신규 ~ 600~800 line = total ~+625 line. lightweight 모드 정합 (cap 1500 권고 ~42% 활용)."
  },
  "lessons_learned": [
    {
      "id": "L1",
      "lesson": "scope rewrite 패턴 두 번째 사례 — Stage D 진입 직후 의문 raise 안 INTENT/RESEARCH 재작성 + ROADMAP entry 안 scope_rewritten_from 필드 정합",
      "evidence": "v4.1 첫 사례 (APPROVE 게이트 직전 폐기 후 새 scope) + 본 v4.3 두 번째 사례 (Stage D 진입 직후 재작성). 두 패턴 모두 audit trail = scope_rewritten_from 필드 + REPORT.lessons_learned + ROADMAP entry summary 보존. 본 v4.3 시점 (3 round 사용자 의문 + Stage D 미완료) = 더 이른 시점 raise → 산출물 폐기 부재 (재작성만), 더 효율적.",
      "future_implication": "후속 milestone — scope rewrite 패턴 정전화 (workflow 정전 narrative 안 명시) candidate. v2.0 word-fidelity → scope rewrite 패턴 narrative 잠재 후속. PROPOSE 안 narrative 거명 (ROADMAP 미등재, § 6.2 폐지 후 사용자 명시 결정 후 등재)."
    },
    {
      "id": "L2",
      "lesson": "사용자 의문 round 3 trigger — 'symlink' → 'install' → 'install 외 경로 탐색' 깊이 진화. 각 round 별 답변 narrative 가 다음 의문 trigger",
      "evidence": "Round 2 'symlink 는 개발자 도구 컴퓨터 적용 의문' → Developer Mode 진단 답변. Round 3 'install 로 하는 이유' → install 본질 narrative 답변. Round 4 'install 외 경로 탐색 원함' → context7 RESEARCH 진입. 각 round 답변이 다음 의문 trigger 하는 depth-first 패턴.",
      "future_implication": "후속 milestone — 사용자 의문 round 패턴 narrative 정전화 잠재 (workflow 안 'AskUserQuestion 운영 원칙' 확장). PROPOSE 안 narrative 거명 가능."
    },
    {
      "id": "L3",
      "lesson": "context7 1차 검증 4 source 안 Plugin spec 발견 — install 회피 단일 경로 (대안 부재 진단)",
      "evidence": "RESEARCH external #1~#5 안 4 source primary 검증 — sub-agents docs (~/.claude/agents/ + .claude/agents/ 단일 강제) + plugins-reference (plugin agents/ 자동 인식 + paths 명시) + plugin-marketplaces (local source 지원) + settings docs (subagent additional path 부재). 4 source 검증 결과 = Plugin spec 단일 install 회피 경로.",
      "future_implication": "후속 milestone v5.0_plugin-pivot 안 깊은 검증 필요 — paths glob 지원 / plugin install 시 ~/.claude/plugins/ 디렉토리 구조 / 5 멤버 migration plan. 본 v4.3 RESEARCH 단계 1차 검증 + v5.0 안 2차 (실 적용) 검증."
    },
    {
      "id": "L4",
      "lesson": "v4.1 narrative drift 진단 — Junction Windows default 표현이 .md 파일 영역 부적합 (Junction = directory only Microsoft NTFS spec)",
      "evidence": "v4.1 D7 sequence step 3 narrative 'Windows: NTFS junction 시도' = .md 파일 영역 적용 시 spec 위반. 실 v4.0 phase-5 안 5 멤버 audit-team 배포 결과 = lrwxrwxrwx SymbolicLink (Get-Item LinkType=SymbolicLink, Developer Mode=1 활성 환경). 즉 narrative '실 구현' drift 검증. 본 v4.3 안 bootstrap/agents/CLAUDE.md L63 sub-paragraph 정전화 흡수.",
      "future_implication": "후속 milestone v5.0_plugin-pivot 안 D7 sequence narrative 자체 폐기 (Plugin 채택 시 D7 = component-installer custom lifecycle 만 잔존, Plugin install lifecycle 별). v4.1 narrative 자체는 historical 보존 + v5.0 안 deprecation 명시."
    },
    {
      "id": "L5",
      "lesson": "lightweight 모드 누적 10/22 = 45.5% — v4.0 § 6.2 폐지 후 자유 default 패턴 진화",
      "evidence": "v3.6 + v3.10 + v3.13 + v3.14 + v3.17 + v3.18 + v3.19 + v3.20 + v3.21 + 본 v4.3 = 10 cycle 누적. v4.0/4.1/4.2 = 정상 모드 (3~4 관점 검토 + multi-phase). lightweight 모드 trigger 조건 = scope 작음 ≤5 파일 + RESEARCH 자기 검토 충분 + 의견 충돌 0 예상 + narrative 중심.",
      "future_implication": "후속 milestone — lightweight 모드 trigger 조건 정전화 잠재 (현 narrative 안 ad-hoc, 정전화 시 자기 검토 narrative cap 명시). PROPOSE 안 candidate 거명 가능."
    },
    {
      "id": "L6",
      "lesson": "narrative 정전화 3 단계 패턴 7 번째 cycle 누적 (v3.21 → v4.3)",
      "evidence": "(a) DESIGN 안 정확 문구 1차 source (D7 grep 키워드 3건 명시) + (b) phase-1 EXECUTE 안 Edit tool 그대로 삽입 (ARCHITECTURE.md L71 + bootstrap/agents/CLAUDE.md L63) + (c) VERIFY grep 검증 (smoke_tests 1~3 PASS). v3.18 + v3.20 + v3.21 + v4.1 + v4.2 + v4.3 = 6 cycle (v3.21 자체 포함 7 cycle).",
      "future_implication": "narrative 정전화 자연 default. v5.0_plugin-pivot 안 install narrative cascade 정전화 시 동일 패턴 적용 예상."
    },
    {
      "id": "L7",
      "lesson": "Plugin spec 채택 결정 (사용자 round 4 (a)) = v4.0 정체성 pivot 의 두 번째 major bump (v5.0) 잠재 trigger — '진단 + 경로 발견' milestone 의 자연 후속",
      "evidence": "v4.0 정체성 pivot (project harness composer + Claude Code ecosystem integrator + agent fleet maintainer) 안 'Claude Code ecosystem integrator' 본질 = Plugin spec 활용 정합. 본 v4.3 RESEARCH = 그 정합 검증 + 실 적용 carry-over (v5.0). v4.0 (정체성) → v4.3 (진단) → v5.0 (적용) 3 단계 cycle.",
      "future_implication": "v5.0_plugin-pivot 안 v4.0 정체성 narrative 정전화 (Plugin spec 채택 narrative 추가) + install script 폐기 narrative 완성 (v4.0 phase-3 B3 자연 후속)."
    }
  ]
}
```

## narrative

본 milestone 의 본질 = **'진단 + 경로 발견'**. 사용자 의문 round 3 raise → scope rewrite (v4.1 패턴 두 번째 사례) → context7 4 source 검증 → Claude Code Plugin spec 발견 → narrative 2 host 정전화 + v5.0_plugin-pivot pending entry 등재. v3.21 narrative 정전화 3 단계 패턴 7 번째 cycle 누적 + lightweight 모드 10/22 = 45.5% 누적.

v4.0 (정체성 pivot) → v4.3 (진단 + 경로 발견) → v5.0 (Plugin 적용, breaking major bump) 자연 3 단계 cycle. v4.1/v4.2 (install + verify/sync agent 흡수) 는 'mechanical 본질 agent 흡수' cycle — v5.0 안 Plugin install 안 자연 통합 가능.

## delta 정량

- ARCHITECTURE.md: +1 paragraph (~5 line) — Install 정책 본질 + Plugin spec 대안
- bootstrap/agents/CLAUDE.md: +1 paragraph (~3 line) — .md 파일 영역 SymbolicLink default 정정
- ROADMAP.md: +1 entry (v5.0_plugin-pivot pending) + v4.3 status completed + updated 2026-05-14
- milestones/v4.3/: 9 신규 파일 (INTENT/RESEARCH/DESIGN/APPROVE/VERIFY/REPORT/PROPOSE/milestones.md + execute/phase-1.md)
- net LOC ~+625 line (lightweight 모드 정합)

## 관련

- INTENT (scope rewrite 후): [`INTENT.md`](INTENT.md)
- RESEARCH (context7 4 source 검증): [`RESEARCH.md`](RESEARCH.md)
- DESIGN (7 결정 + 1-phase Lightweight + 3 관점 자기 검토): [`DESIGN.md`](DESIGN.md)
- APPROVE (Round 5 명시 승인): [`APPROVE.md`](APPROVE.md)
- VERIFY (verdict pass + 회귀 0): [`VERIFY.md`](VERIFY.md)
- 후속 forward: [`PROPOSE.md`](PROPOSE.md) (next_candidates 거명만)
- v4.0 정체성: [`../../ARCHITECTURE.md`](../../ARCHITECTURE.md) § 3.1 끝
- v5.0_plugin-pivot pending entry: ROADMAP milestones[] 안
