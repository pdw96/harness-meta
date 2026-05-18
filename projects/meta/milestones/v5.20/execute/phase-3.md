# execute/phase-3.md — v5.20

```json
{
  "phase": 3,
  "title": "§ 4 끝 7 paragraph 매트릭스화 (표 변환 + cross-ref) + agent namespace prefix cascade 7 위치 (claude/commands/harness-meta.md 5 + agents-md-sync.md 1 + environment-auditor.md 1)",
  "status": "complete",
  "started_at": "2026-05-19",
  "completed_at": "2026-05-19",
  "scope_ref": "DESIGN.phases[3] (n=3) — scenario B 채택 (의문 round 2 사용자 결정)",
  "actions": [
    "1. ARCHITECTURE.md § 4 첫 paragraph (v3.10) 위에 '### § 4 끝 narrative 정전화 누적 매트릭스 (v5.20, 무넘버)' sub-section 추가 — 5열 7행 표 (# / 정전화 milestone / 본질 / 1차 source / 검증 method)",
    "2. paragraph 본문 7건 (v3.10/v3.20/v5.9/v5.10/v5.11+v5.18/v5.16/v5.20) 그대로 보존 (narrative archive 효과 + cross-ref 1차 source 보존)",
    "3. § 4.1 Bundling sub-section 번호 보존 (외부 cross-ref 다수 — docs/adr/ADR-006 + milestones — § 4.1 재번호 시 cascade drift risk)",
    "4. matrix sub-section은 무넘버 H3 — sub-section 번호 충돌 회피",
    "5. claude/commands/harness-meta.md L75~L78 + L83 안 5건 `subagent_type=\"<name>\"` → `subagent_type=\"harness-meta:<name>\"` 교체",
    "6. agents/agents-md-sync.md L122 prefix 추가 + agents/environment-auditor.md L155 prefix 추가",
    "7. 본 phase-3.md 작성 + commit"
  ],
  "outputs": [
    "projects/meta/ARCHITECTURE.md (§ 4 끝 매트릭스 표 신규 추가 + sub-section 무넘버 H3)",
    "claude/commands/harness-meta.md (5건 prefix 추가)",
    "agents/agents-md-sync.md (L122 prefix)",
    "agents/environment-auditor.md (L155 prefix)"
  ],
  "verification_steps": {
    "grep_namespace_prefix": "Stage G VERIFY 안 `grep -c 'subagent_type=\"harness-meta:' claude/commands/harness-meta.md agents/agents-md-sync.md agents/environment-auditor.md` = 7 (5+1+1)",
    "grep_matrix_header": "Stage G VERIFY 안 `grep -c '§ 4 끝 narrative 정전화 누적 매트릭스' projects/meta/ARCHITECTURE.md` = 1",
    "matrix_row_count": "Stage G VERIFY 안 표 row 7건 검증 (paragraph 본문 1:1 매핑)",
    "lint_precheck": "v5.16 절차 — ARCHITECTURE.md matrix 표 안 MD022/MD031/MD032 안전 (표 위 H3 sub-section + 빈 줄 + 표 + 빈 줄 + paragraph 본문 archive)"
  },
  "commit": "9e6f0d0",
  "execution_notes": "v3.21 narrative 정전화 3 단계 패턴 22번째 cycle 도그푸드 — (a) DESIGN D13+D14 1차 source + (b) 본 phase-3 Edit + (c) VERIFY grep. scenario B 채택 효과 = (1) ROADMAP 단일 entry (v5.20) 안 v5.19 PROPOSE#4+#8 + spec-drift D1 통합 흡수 + (2) lightweight 이탈 정당화 (D15) = 3 milestone 분리 회피. § 4.1 Bundling 번호 보존 결정 = 외부 cross-ref 다수 (ADR-006 + milestones v3.0/v5.9/v5.10/v5.11/_archive/v3.20/_archive/v3.21) 회귀 회피."
}
```

## narrative

### 매트릭스화 결정 (D13 정합)

scenario B 채택. 6 paragraph (v3.10/v3.20/v5.9/v5.10/v5.11+v5.18/v5.16) + 1 신규 paragraph (v5.20 stability) = 7 paragraph 표 변환. 표 형식 = 5열 7행 (# / 정전화 milestone / 본질 / 1차 source / 검증 method).

paragraph 본문 7건은 narrative archive로 표 아래에 보존 — full text 1차 source 보존 + cross-ref 매핑. 신규 정전화 시 본문 + row 동시 추가 의무.

### namespace prefix cascade (D14 정합)

claude/commands/harness-meta.md L75~L78 + L83 5건 + agents/agents-md-sync.md L122 + agents/environment-auditor.md L155 = 7 위치. spec-drift D1 (Plugin namespace prefix mismatch) 해소. 본 사용자 환경 agent list 안 `harness-meta:<name>` 표기 = Plugin spec v5.0+ 정상 표기 확인 evidence.

### § 4.1 Bundling 번호 보존 결정 (사용자 결정 narrative)

외부 cross-ref 다수 = docs/adr/ADR-006 + milestones v3.0/v5.9/v5.10/v5.11/_archive/v3.20/_archive/v3.21 안 § 4.1 직접 참조. § 4.1 → § 4.2 재번호 시 cascade drift 위험 → matrix sub-section은 무넘버 H3로 처리. 깔끔하지 않은 sub-section 번호 layout (matrix 무넘버 + § 4.1 Bundling)은 trade-off — 외부 cross-ref 안전성이 sub-section 번호 깔끔보다 우선.
