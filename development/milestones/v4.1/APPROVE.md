---
id: install-strategy-reaudit
title: APPROVE v4.1
version: v4.1
stage: APPROVE
status: completed
---

# APPROVE — v4.1

## Spec

```json
{
  "approval": {
    "approved_by": "user",
    "date": "2026-05-13",
    "approval_summary": "Install 전략 자체 재검토 (Option D 채택: Junction Windows default + Symlink Linux/macOS) milestone EXECUTE 진입 승인. 사용자 의문 raise (이전 v4.1_dev-tools-bootstrap APPROVE 게이트 안 'dev-tools 를 써야하는 이유' + 본질 의문 'Developer Mode 켜야 하는 이유') → v4.1 scope rewrite 결정 (이전 산출물 commit 부재 상태에서 삭제) → 본 milestone scope 재정의. 10 decisions (D1 Option D + D2 D7 5 step rewrite + D3 component-installer 화이트리스트 + D4 cascade 단일 source = bootstrap/agents/CLAUDE.md + D5 v3.21 3 단계 패턴 적용 + D6 phases 2 분할 + D7 NTFS same-volume 강제 + D8 stale 정정 inventory + D9 ARCHITECTURE 미추가 + D10 OS detect mechanism $IsWindows) + 4 관점 병렬 검토 모두 pass-with-comments + 의견 충돌 0건 + 7 risk mitigation (R1~R7) 흡수. 권고 모두 D1~D10 자동 흡수. 추가 발견 (GUARDRAILS.md L34 legacy reference + verify.ps1/sh L97/L96 A1 check) cascade host 7 → 10 확장 흡수. Stage D 완료 직전 의무 step (v3.5 phase-2) 실행 — milestones/v4.1/milestones.md sub_milestones 2 entry phase-1 (mechanical) + phase-2 (cascade narrative) 1:1 동기 갱신. EXECUTE 진입 게이트 통과."
  }
}
```

## 검토 종합 narrative

### 4 관점 검토 결과

scope 큼 (10 host cascade + D7 sequence + component-installer 갱신, 12+ 파일 변경) → 4 관점 병렬 검토 진행 (보안 관점은 install 메커니즘 변경 본질적 권한 / path traversal risk 낮음 — 생략 결정).

| # | 관점 | agent | verdict | 흡수 권고 |
|:-:|---|---|---|---|
| 1 | architecture | Plan | pass-with-comments | D2 (D7 5 step) + D3 (화이트리스트) + D4 (단일 source) + D5 (3 단계 패턴) + D6 (phases 2 분할) |
| 2 | spec-drift | general-purpose (context7 invoke) | pass-with-comments (3 PASS + 1 PASS_WITH_NOTE + 1 권고) | D7 (same-volume) + D10 (OS detect $IsWindows) + R2 mitigation (junction 인식 ad-hoc 검증) |
| 3 | 회귀 risk | Explore (grep inventory) | pass-with-comments | D8 (stale 정정: claude/CLAUDE.md install.ps1 + GUARDRAILS.md L34 + verify.ps1/sh A1) — cascade host 7 → 10 확장 |
| 4 | scope contract | Explore (read-only) | pass-with-comments | (criteria ↔ phases 매핑 자유도 OK / out_of_scope forward propose 0 / affected_files Stage D 정정 / milestones.md 갱신 의무) — REPORT 안 'v4.1 rewrite narrative 선례 부재 명확화' 권고 (non-blocking) |

### DESIGN 종합

**핵심 결정** = Option D 채택 후 D7 mechanical sequence 4 step → 5 step rewrite (Backup → **OS detect (신규)** → Primary attempt by OS [Windows = junction / Linux/macOS = symlink] → Copy fallback → Cleanup retention). Windows junction default 가 Developer Mode 강제 해소 + drift 회피 둘 다 보존. Spec-drift 검토 안 PowerShell 7.6 docs 직접 인용 — `Junction` ItemType 안 elevation note 부재 (standard user 권한 OK).

**Cascade 단일 source 정합** = bootstrap/agents/CLAUDE.md § 'Install / Update / Cleanup 책임' (현 D7 정전 host) 보존. ARCHITECTURE § 3.1 끝 install 전략 paragraph 추가 X (정체성 narrative ↔ mechanical narrative 책임 분리, D4/D9 정합). 나머지 9 host (README + AGENTS + bootstrap/skills/CLAUDE.md + claude/CLAUDE.md + root CLAUDE.md + ARCHITECTURE.md cross-ref 검증 + GUARDRAILS.md + verify.ps1/sh) = cross-ref 또는 mechanical 검증만.

**v3.21 narrative 정전화 3 단계 패턴 적용** — (a) DESIGN 안 정확 markdown code block 1차 source (D7 5 step + same-volume narrative + ad-hoc 검증 권고 포함) / (b) phase-1 EXECUTE Edit tool 정확 문구 그대로 삽입 / (c) phase-2 VERIFY 안 grep 검증 ('Junction' + 'OS detect' + '5 step' + 'same.*volume' + 'Primary attempt by OS' cohesive 키워드 cohesive). 3 cycle 선례 (v3.18/v3.20/v3.21) 누적 craft 재사용.

### v3.10 부산물 정책 정합

INTENT.out_of_scope 6 entry + RESEARCH.untouched_files_explicit 6 entry + RESEARCH.risks_identified 7 entry + DESIGN.decisions[i].rationale + DESIGN.phases[n].scope 모두 사실 진술. forward propose 명령형 ('별 milestone 으로') 0건 grep 검증. 후속 발의 (예: 환경별 onboarding 가이드 매트릭스 / pre-commit hook 환경 detect 자동화 / 도그푸드 install precondition narrative) 는 Stage I PROPOSE 통합 흡수.

### EXECUTE 진입 게이트 통과

Stage D 완료 직전 의무 step (v3.5 phase-2) 실행 — milestones/v4.1/milestones.md sub_milestones placeholder → 2 entry 1:1 동기 갱신 완료. phase-1 (mechanical, 3 affected) + phase-2 (cascade narrative, 10 affected). 사용자 명시 승인 결정 (2026-05-13, AskUserQuestion 'v4.1 DESIGN 승인 — EXECUTE 진입 결정?' 안 '승인 — EXECUTE 진입 (Recommended)' 명시 선택) → EXECUTE 진입.

### INTENT~APPROVE commit 시점 (v3.1 L6)

기본값 (b) — Stage G (VERIFY) commit 안 포함. VERIFY 전 산출물 영구 보존 보장. phase-1 commit 안 INTENT/RESEARCH/DESIGN/APPROVE.md 4건 미포함 (atomic mechanical 변경 commit 단일 책임).

## 관련

- INTENT: [`INTENT.md`](INTENT.md)
- RESEARCH: [`RESEARCH.md`](RESEARCH.md)
- DESIGN: [`DESIGN.md`](DESIGN.md)
- milestones.md (sub_milestones 갱신 완료): [`milestones.md`](milestones.md)
- 9-stage workflow Stage E (APPROVE): [`../../../../claude/commands/harness-meta.md`](../../../../claude/commands/harness-meta.md)
