# INTENT — v5.5 v4x-deprecation-narrative-cleanup

```json
{
  "id": "v5.5_v4x-deprecation-narrative-cleanup",
  "title": "v4.x SymbolicLink 잔존 narrative 정리 + environment-auditor Stage B v5.0+ Plugin 검증 전면 개선",
  "goal": "environment-auditor.md Stage B (Symlink/Junction 무결성) 를 install-type-aware 로 재설계하여 v5.0+ Plugin install 환경에서도 실질적 헬스 체크를 수행하도록 한다. 동시에 비 archive 파일 내 v4.x 개념 거명에 명시적 컨텍스트 표지를 추가하여 사용자 혼란을 제거한다.",
  "motivation": "v5.0_plugin-pivot PROPOSE.next_candidates#4 carry-over. environment-auditor.md Stage B (B1~B6) 는 v4.x install 전제 — v5.0+ Plugin install 환경에서 실행 시 B1~B6 모두 false-negative (6건 전부 FAIL/WARN). 표지만 추가하면 false-negative는 여전히 발생. Stage B 를 install type 감지 기반으로 재구성해야 v5.0+ 사용자도 실질적 audit 수혜를 받는다.",
  "success_criteria": [
    "environment-auditor.md Stage B 에 B0 (install type detect: Plugin vs v4.x) 추가 — ~/.claude/plugins/cache/harness-meta/ 존재 여부로 분기",
    "v5.0+ Plugin 경로: BP1 (plugin cache 존재) + BP2 (agents/ 7건 열거) + BP3 (skills/ 5건 열거) 3 check 수행",
    "v4.x 경로: 기존 B1~B6 그대로 실행 + '(Deprecated since v5.0, v4.x 환경 전용)' 표지 명시",
    "environment-auditor.md frontmatter description 갱신 (v5.0+/v4.x 양방향 지원 명시)",
    "A1 설명 + Output 형식 예시에 v4.x 전용 컨텍스트 표지 추가",
    "Bash 화이트리스트에 Plugin cache 경로 관련 명령 확인 (기존 Test-Path/Get-ChildItem 으로 충분)",
    "skills/harness-roadmap-update/SKILL.md L126 install-skills 거명에 '(폐기, v4.x historical)' 표지 추가",
    "pre-commit 14 hook PASS, smoke 회귀 0"
  ],
  "out_of_scope": [
    "projects/meta/milestones/_archive/ 안 historical milestone 산출물 — 보존 대상",
    "CHANGELOG.md 안 historical v4.x 기록 항목 — changelog 특성상 backward 보존",
    "component-installer.md Step C3/C4 — 이미 'v4.x migration 진단' 레이블 명시",
    "bootstrap/skills/CLAUDE.md L96 backup 위치 — 이미 'v4.x 환경' 명시",
    "README.md / AGENTS.md / CLAUDE.md 등 이미 deprecated 표지 있는 파일 — 추가 수정 불필요",
    "실 사용자 환경 ~/.claude/agents/ SymbolicLink 물리 삭제 — repo 안 narrative scope 만",
    "claude plugin list CLI 호출 — Bash 화이트리스트 확장 없이 Test-Path/Get-ChildItem 으로 대체"
  ],
  "dependencies": {
    "predecessor": ["v5.0_plugin-pivot (PROPOSE.next_candidates#4 origin)", "v5.4_marketplace-json-github-source (직전 milestone)"],
    "successor": []
  }
}
```
