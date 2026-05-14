# INTENT — v5.4 marketplace-json-github-source

```json
{
  "id": "v5.4_marketplace-json-github-source",
  "title": "marketplace.json source 필드 → GitHub source 객체 명시 전환 (optional 품질 개선)",
  "goal": "v5.3에서 './' 가 Git repository marketplace에서 정상 작동함을 확인했다. 본 milestone은 Claude Code Plugin spec 상 Git repository marketplace의 올바른 source 표현이 무엇인지 context7로 재검증하고, 명시적 GitHub source 객체 형태 전환 여부를 결정한다.",
  "motivation": "v5.3 PROPOSE에서 optional candidate로 등재. marketplace.json plugins[0].source = './' 는 기능상 정상이나, spec 관점에서 외부 방문자에게 GitHub source 객체가 더 명시적일 수 있다는 개선 가능성 제기. 실제 전환 필요 여부는 RESEARCH spec 검증 후 결정.",
  "success_criteria": [
    "context7 Claude Code Plugin spec에서 Git repository marketplace의 source 필드 허용 형태 확인",
    "marketplace.json source 필드 최종 결정 (전환 또는 현행 유지 + 근거 명문화) 완료",
    "결정이 DESIGN.decisions[]에 명시되고 narrative 정전화됨",
    "pre-commit 14 hook 모두 PASS, 회귀 0"
  ],
  "out_of_scope": [
    "plugin.json 변경",
    "README/AGENTS/CLAUDE.md 등 cascade narrative 변경 (source 필드 변경 시 cascade 최소 범위로 제한)",
    "새 기능 추가 또는 다른 milestone과 무관한 cleanup"
  ],
  "dependencies": {
    "predecessor": "v5.3_external-marketplace-registration (completed, context7 첫 검증 결과 보유)",
    "successor": null
  }
}
```
