# INTENT — v5.6 environment-auditor-runtime-check-automation

```json
{
  "id": "v5.6_environment-auditor-runtime-check-automation",
  "title": "environment-auditor G 섹션 (Runtime-only manual checklist) 자동화 확대 + Plugin activation 상태 포함",
  "goal": "environment-auditor 의 Stage G (Runtime-only 수동 체크리스트) 안 5 항목 중 자동화 가능한 항목 (= Bash 환경 안 `claude` CLI 호출 또는 plugin cache 파일 검증으로 결정 가능한 항목) 을 자동 검증 stage (B 확장 또는 신규 stage, Stage D 결정) 로 이전하고, Plugin activation 상태 (`claude plugin list` / `claude plugin details harness-meta` 안 enabled 상태) 검증을 신규로 자동 stage 에 추가한다. 자동화 불가능 항목 (= Claude Code 세션 컨텍스트 의존, 예: CLAUDE.md 자동 로드) 만 G 섹션에 잔존.",
  "motivation": "v5.5_v4x-deprecation-narrative-cleanup REPORT L1 lesson (environment-auditor 동시 갱신 패턴 정합) origin. v5.5 PROPOSE next_candidates#2 사용자 명시 선택 (A_user trigger). 현 Stage G 5 항목 (`/harness-meta` slash command 인식 / 글로벌 user-skill 호출 인식 / root CLAUDE.md @ROADMAP.md 자동 로드 / `projects/meta/CLAUDE.md` lazy 로드 / subdirectory CLAUDE.md on-demand 로드) 중 일부는 Claude Code CLI (`claude plugin list` / `claude plugin details`) 로 자동 검증 가능 — 'manual only' 분류는 잠재 false-confidence risk (정량 사례 부재, RESEARCH 검증 대상). Plugin activation 상태 (현재 enable/disable) 도 audit 본질 (install 검증 → activation 검증) 누락 항목.",
  "success_criteria": [
    "sc_1: G 5 항목 자동/수동 매트릭스 작성 — 각 항목 'AUTO 부분 + MANUAL 부분' 책임 표기 추가 (RESEARCH round 4 정정 결과 흡수). 자동화 가능 N=5 (G1~G5 모두 AUTO 부분 보유, 자동 stage 통합 single sub-step). 분류 기준 = audit 책임 (binary 상태 검증) 단일 책임 매핑.",
    "sc_2: Plugin activation 자동 check 신규 추가 — `claude plugin list` 또는 `claude plugin details harness-meta` 출력 spec RESEARCH 후 enabled 상태 grep 패턴 확정 + Bash 화이트리스트 명시",
    "sc_3: G 섹션 잔존 항목 = 자동화 불가능 기준 (Bash 환경 안 검증 불가) 만 충족 — 매트릭스 narrative 안 기준 명시",
    "sc_4: environment-auditor.md frontmatter description + 본문 stage 매트릭스 narrative 동시 갱신 — '10 stage' → 'N stage' (Stage D 결정 후 정확 카운트, B 확장 시 10 유지 / 신규 stage 신설 시 11)",
    "sc_5: 회귀 0 — smoke 14 hook PASS + 본 milestone phase commit 후 사용자 자연어 호출 ('verify 해줘') 수동 trace 1회 결과 narrative 보고",
    "sc_6: Bash 화이트리스트 (D7 security) 정합 — `claude` CLI 호출 (read-only side-effect-free RESEARCH 검증 후) 허용 항목 명시 추가 + 위반 명령 부재 검증",
    "sc_7: pre-commit 14 hook 모두 PASS, smoke 회귀 0"
  ],
  "out_of_scope": [
    "Claude Code 세션 컨텍스트 의존 항목 (root CLAUDE.md @ROADMAP.md 자동 로드 / subdirectory CLAUDE.md on-demand 로드) 의 강제 자동화 — 본질 Bash 환경 안 검증 불가능, G 섹션 잔존 정당 (B/C/D 부산물 정책 v3.10 정합)",
    "본 milestone 직접 scope 외 stage (Z/A/C/D/E/F/I/J) 의 본질 변경 — 단, Stage B 확장 시 B 변경은 scope 안 (DESIGN 결정 의존)",
    "environment-auditor 외 agent 본질 변경 (agents-md-sync / component-installer / 5 멤버 audit team) — 단, 본 milestone 결과 자연 발생 cascade narrative 갱신 (bootstrap/agents/CLAUDE.md 매트릭스 narrative / projects/meta/ARCHITECTURE.md cross-ref 등) 은 scope 안 (strict exclusion 아님)",
    "verify.sh / verify.ps1 4 script 부활 (v4.2 폐기 정합 유지)"
  ],
  "dependencies": [
    "v5.5_v4x-deprecation-narrative-cleanup (Stage B Plugin 전용 교체 완료 — B0/BP1/BP2 도입, 본 milestone 의 Stage B 확장 base)",
    "v4.2_verify-infra-agent-absorption (environment-auditor standalone subagent 흡수, 본 milestone 의 갱신 대상 host)"
  ]
}
```

## 의도 narrative

v5.5 가 Stage B (install 검증) 를 SymbolicLink → Plugin cache 전환했지만, Stage G (Runtime-only) 는 v4.2 도입 이후 그대로 — 5 항목 모두 'manual only' 분류. 그러나 일부는 `claude plugin details harness-meta` 출력 안 명시 (예: commands/skills 목록), 일부는 Claude Code 세션 컨텍스트 의존 (CLAUDE.md 자동 로드). 분류 정밀화 + 자동화 확대가 audit 정확도 향상.

Plugin activation 상태는 audit 매트릭스 본질 누락 — install 확인 (Stage B = cache 존재) ≠ activation 확인 (`claude plugin list` enabled). 본 milestone 도입.

## 책임 분리 narrative (v5.6 안 INTENT 책임)

본 INTENT 의 작성 책임:

- **사용자 (확정)**: goal/motivation 의 high-level 의도 — v5.5 PROPOSE next_candidates#2 사용자 명시 선택 (A_user trigger) 가 1차 source. 본 INTENT 의 `goal` + `motivation` 필드는 그 선택의 narrative 정전화. 정정 1 round (4 권고 반영) 거쳐 사용자 확정.
- **Claude (초안)**: success_criteria + out_of_scope + dependencies 의 detail — 환경 분석 (environment-auditor.md 현재 G 5 항목 + Bash 화이트리스트 + sc_6 보안 정합) 기반 추정. 사용자 디테일 분석 round 1 회 (4 권고 흡수) 후 갱신. 향후 Stage E APPROVE 게이트에서 최종 사용자 확정.

향후 RESEARCH (Stage C) 안 `claude` CLI spec 검증 → success_criteria N (sc_1) + frontmatter '10/11 stage' (sc_4) 정량화. DESIGN (Stage D) 안 B 확장 vs 신규 stage 결정 후 sc_4 확정.
