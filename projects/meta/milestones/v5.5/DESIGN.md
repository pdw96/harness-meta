# DESIGN — v5.5 v4x-deprecation-narrative-cleanup

```json
{
  "decisions": [
    {
      "id": "D1",
      "decision": "Stage B 를 Plugin install 검증으로 전면 교체 — B1-B6 (SymbolicLink) 완전 삭제, Plugin 경로 전용 (B0 detect → BP1-BP3)",
      "rationale": "v5.0+ Plugin install 환경이 현행 — SymbolicLink 검증 로직은 현재 환경에서 무용. backward compat 유지보다 현행 상태를 정확히 반영하는 것이 auditor 역할에 부합.",
      "alternatives_rejected": ["B1-B6 보존 + Plugin 병행: 사용하지 않는 검증이 audit 결과를 오염시킴"]
    },
    {
      "id": "D2",
      "decision": "A1 (Windows Developer Mode 정보 표시) 항목 삭제",
      "rationale": "Plugin install 기반으로 전환한 목적 자체가 Developer Mode 의존 제거 — 삭제가 의도에 부합.",
      "alternatives_rejected": ["A1 유지 + '불필요' 문구 추가: 불필요한 check 를 보고하는 것 자체가 노이즈"]
    },
    {
      "id": "D3",
      "decision": "frontmatter description 교체 — 'B Symlink 또는 Junction 무결성' → 'B Plugin install 검증'",
      "rationale": "description 이 system-reminder 로 노출되므로 현행 검증 내용 반영 필수.",
      "alternatives_rejected": []
    },
    {
      "id": "D4",
      "decision": "Output 형식 예시 갱신 — A1 줄 제거 + B section 을 Plugin 검증 결과 예시로 교체",
      "rationale": "Output 형식은 문서 역할도 하므로 실제 실행 결과와 일치해야 함.",
      "alternatives_rejected": []
    },
    {
      "id": "D5",
      "decision": "skills/harness-roadmap-update/SKILL.md L126 install-skills 거명 행 완전 삭제",
      "rationale": "install-skills 는 v4.0 phase-3 에서 폐기된 스크립트 — 보안 위협 표에서 완전 제거. 버전 태그 없이 깔끔하게 처리.",
      "alternatives_rejected": ["'(폐기, historical)' 표지 유지: 폐기된 패턴을 보안 표에 남길 이유 없음"]
    },
    {
      "id": "D6",
      "decision": "버전 태그(v4.x, v5.0+, Deprecated since v5.0) 사용자 노출 문서에 추가 없음",
      "rationale": "버전 태그는 내부 milestone 추적 언어 — 사용자 노출 문서는 현행 상태만 반영.",
      "alternatives_rejected": ["'Deprecated since v5.0' 표지 추가: 불필요한 버전 정보 노출"]
    },
    {
      "id": "D7",
      "decision": "1-phase 적용",
      "rationale": "영향 파일 2건 + CHANGELOG — 분할 불필요.",
      "alternatives_rejected": []
    }
  ],
  "approach": "agents/environment-auditor.md (frontmatter description / A1 삭제 / Stage B 전면 교체 / Output 형식) + skills/harness-roadmap-update/SKILL.md (L126 행 삭제) + CHANGELOG [v5.5]. 1-phase 1 commit.",
  "phases": [
    {
      "n": 1,
      "title": "environment-auditor Stage B Plugin 전용 교체 + A1 삭제 + SKILL.md L126 삭제 + CHANGELOG",
      "scope": "agents/environment-auditor.md (frontmatter description / A1 삭제 / Stage B 전면 재작성 / Output 형식) + skills/harness-roadmap-update/SKILL.md (L126 행 삭제) + CHANGELOG.md [v5.5]",
      "affected_files": [
        "agents/environment-auditor.md",
        "skills/harness-roadmap-update/SKILL.md",
        "CHANGELOG.md",
        "projects/meta/milestones/v5.5/execute/phase-1.md"
      ],
      "rationale": "단일 phase — 삭제 + 교체 중심, 분할 효과 없음.",
      "risks": ["Stage B 전면 교체 시 B0 detect 로직 (Plugin cache 경로) 정확성 — v5.0 VERIFY 단계에서 확인된 실제 경로 사용"]
    }
  ],
  "risk_mitigation": [
    {
      "risk": "Stage B 전면 교체 시 Plugin cache 경로 오류",
      "mitigation": "~/.claude/plugins/cache/harness-meta/ 는 v5.0 VERIFY 단계 실 confirm 경로 — 변경 없음"
    },
    {
      "risk": "A1 삭제 시 10 stage 매트릭스 check 수 변경 → frontmatter description 불일치",
      "mitigation": "frontmatter description 도 동시 갱신 — '10 stage 매트릭스' 문구 검토 필요"
    }
  ],
  "self_review": {
    "architecture": "Stage B 교체는 environment-auditor 안 로직 — repo 구조 변경 없음. PASS.",
    "spec_drift": "Plugin cache 경로 (~/.claude/plugins/cache/harness-meta/) 는 v5.0 VERIFY 실 확인 경로. PASS.",
    "scope_contract": "INTENT.success_criteria 8건 vs DESIGN: B0+BP1-BP3 ✓ / B1-B6 삭제 ✓ / frontmatter ✓ / A1 삭제+Output ✓ / 화이트리스트 확장 없음 ✓ / SKILL.md L126 삭제 ✓ / 버전 태그 없음 ✓ / pre-commit PASS 예상 ✓. PASS."
  }
}
```
