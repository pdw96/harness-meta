# phase-1 — Identity 5 host 재작성 + § 6.2 폐지 + 3 host 안 install narrative cleanup 통합 (옵션 B)

```json
{
  "phase": 1,
  "version": "v4.0",
  "id": "harness-composer-pivot",
  "title": "Identity 5 host 재작성 + § 6.2 폐지 + 3 host 안 install narrative cleanup 통합",
  "status": "in_progress",
  "commit": null,
  "changes": [
    "(1) projects/meta/ARCHITECTURE.md § 3.1 끝 — 'harness-meta repo 정체성' paragraph 추가 (v4.0 새 정체성 단일 source, project harness composer + Claude Code ecosystem integrator + agent fleet maintainer)",
    "(2) projects/meta/ARCHITECTURE.md § 6.2 (line 182~205) — header + 4 paragraph (Lightweight 모드 정책 / Workflow self-improvement 동결 / Narrative 정전화 3단계 패턴 / 선례 2건) 완전 제거 + § 6.1 끝 폐지 narrative paragraph 1줄 추가",
    "(3) root CLAUDE.md line 3~4 — 정체성 paragraph 갱신 (cross-ref to ARCHITECTURE § 3.1 끝)",
    "(4) root CLAUDE.md line 49~51 — 기술 스택 안 'install 자동화' narrative cleanup + Symlink 배포 narrative agent 흡수 명시 + `agents/` 디렉토리 추가",
    "(5) root CLAUDE.md line 56~57 — 새 slash command/hook + user-skill/subagent 추가 narrative 안 `install.ps1` / `install-skills.{ps1,sh}` reference → agent (`component-installer`) 로 갱신",
    "(6) root CLAUDE.md line 75~96 — 설치 / 재설치 섹션 (install.ps1 + install-skills.ps1 + verify.ps1/.sh 명령 블록) → D9 onboarding entry (clone + 자연어 호출) 대체",
    "(7) AGENTS.md line 3~15 — 영문 tagline + Commands 섹션 → 새 정체성 + D9 onboarding entry 영문 대체",
    "(8) README.md line 3~7 — 영문 tagline 갱신 (project harness composer + ecosystem integrator + fleet maintainer)",
    "(9) README.md line 28~76 — Installation 섹션 (Stage 1 Global + Stage 2 user-skills + Verify) → D9 onboarding entry 영문 대체 (clone + 자연어 호출, component-installer 흡수)",
    "(10) README.md line 113~117 — Directory layout 안 install.ps1 + install-skills.ps1 + install-skills.sh 행 3건 제거 (phase-3 안 실제 파일 삭제)",
    "(11) projects/meta/CLAUDE.md — 정체성 cross-ref 확장 (§ 3.1 끝 paragraph 명시 + v4.0 도입 표지)"
  ],
  "affected_files": [
    "projects/meta/ARCHITECTURE.md",
    "CLAUDE.md",
    "AGENTS.md",
    "README.md",
    "projects/meta/CLAUDE.md"
  ],
  "criteria_met": {
    "INTENT_sc_1": "5 host identity paragraph 정전화 — ARCHITECTURE § 3.1 끝 단일 source + 4 host cross-ref + 짧은 sketch (v1.4_cross-ref-propagation 패턴 정합)",
    "INTENT_sc_2": "ARCHITECTURE § 6.2 폐지 + 폐지 narrative 1 paragraph 표지 (v4.0 pivot 사유 cross-ref)",
    "옵션_B_통합": "3 host (root CLAUDE.md + AGENTS + README) 안 install narrative cleanup 함께 — 같은 host 두 번 Edit 회피 (phase-3 안 phase-1 host 재Edit 0)"
  },
  "narrative_canonicalization_3step_dogfood": {
    "note": "본 § 6.2 폐지 milestone — 패턴 자체 폐기 대상이지만 본 phase-1 안 자연 적용 (도그푸드)",
    "(a) DESIGN 정확 문구 1차 source": "DESIGN.md § 'Phase 1 정확 narrative 정문구' subsection 안 markdown code block 6건 (ARCHITECTURE § 3.1 + § 6.1 + root CLAUDE.md + AGENTS + README + projects/meta/CLAUDE.md + onboarding entry)",
    "(b) phase-1 EXECUTE Edit 그대로 삽입": "위 5 host Edit 으로 (a) 정확 문구 그대로 삽입 — Edit exact-match 의무가 narrative 일관성 보장",
    "(c) VERIFY grep 키워드": "VERIFY.md criteria_check 안 grep 키워드 = `project harness composer` + `Claude Code ecosystem integrator` + `agent fleet maintainer` + `component-installer` + `§ 6.2 폐지` (4~5 host 동시 매칭 검증)"
  }
}
```

## narrative

본 phase-1 = v4.0 EXECUTE 첫 phase. 옵션 B 책임 통합 (identity + 3 host install narrative cleanup 같은 commit 안 처리, 같은 host 두 번 Edit 회피).

### 핵심 변경

1. **새 정체성 1차 source** = `projects/meta/ARCHITECTURE.md` § 3.1 끝 paragraph
2. **4 host cross-ref** (root CLAUDE.md / AGENTS.md / README.md / projects/meta/CLAUDE.md) — v1.4_cross-ref-propagation 패턴 정합
3. **§ 6.2 완전 폐지** — header + 4 paragraph (Lightweight / Workflow 동결 / Narrative 정전화 3단계 / 선례) 모두 제거 + § 6.1 끝 폐지 narrative 1 paragraph
4. **3 host install 섹션** (root CLAUDE.md + AGENTS + README) → D9 onboarding entry (clone + 자연어 호출, agent `component-installer` 흡수)

### LOC 추정

- ARCHITECTURE.md: +13 (§ 3.1 paragraph) / -24 (§ 6.2 paragraph 4건) / +5 (폐지 narrative) = **net -6 line**
- root CLAUDE.md: ~+8 line (정체성 paragraph 확장 + install 섹션 짧게 대체)
- AGENTS.md: ~+5 line (Commands 섹션 압축 — install 6 bullet → D9 onboarding paragraph)
- README.md: ~-40 line (Installation 섹션 36 line → D9 paragraph 5 line + Directory layout 3 행 제거)
- projects/meta/CLAUDE.md: +0 line (cross-ref 확장)

총 net 변경 ~-30 line.

## commit (pending 사용자 확인)

```
feat(meta)!: v4.0 phase-1 — identity 5 host 재작성 + § 6.2 폐지 + 3 host install narrative cleanup (옵션 B)

새 정체성 1차 source: projects/meta/ARCHITECTURE.md § 3.1 끝 — project harness
composer + Claude Code ecosystem integrator + agent fleet maintainer.
4 host cross-ref (root CLAUDE.md / AGENTS / README / projects/meta/CLAUDE.md).

§ 6.2 (Lightweight 모드 + Workflow self-improvement 동결 + Narrative 정전화 3단계
+ 선례 2건) 폐지 narrative 1 paragraph.

3 host install 섹션 (root CLAUDE.md / AGENTS / README) → D9 onboarding entry
(clone + 자연어 호출, agent component-installer 흡수, v4.0 B3).

옵션 B 통합 — phase-1 + phase-3 같은 host 두 번 Edit 회피.

BREAKING CHANGE: § 6.2 동결 정책 폐지 + 정체성 재정의 (v3 → v4 major bump).
```

## 관련

- INTENT: [`../INTENT.md`](../INTENT.md) — success_criteria (1), (2)
- DESIGN: [`../DESIGN.md`](../DESIGN.md) § "Phase 1 정확 narrative 정문구" — 정확 문구 1차 source
- ARCHITECTURE § 3.1 끝: [`../../../ARCHITECTURE.md`](../../../ARCHITECTURE.md)
- ARCHITECTURE § 6.1 끝 폐지 narrative: [`../../../ARCHITECTURE.md`](../../../ARCHITECTURE.md) (line ~182)
