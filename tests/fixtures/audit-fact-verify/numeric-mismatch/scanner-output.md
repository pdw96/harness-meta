# scanner-output (fixture — numeric-mismatch, v6.14 cycle 7 v5.17 evidence)

audit chain `project-scanner` 산출 모방 fixture — numeric mismatch case (v6.14 NUMERIC_LOOKUP 2 entry 도입 후 stated value mismatch detect 검증).

```json
{
  "project": "harness-meta",
  "claude_md_lines": 999999,
  "claude_md_bytes": 999999
}
```

본 fixture 호출 시 `audit_fact_verify.py` 의 NUMERIC_LOOKUP (`claude_md_lines` + `claude_md_bytes`, v6.14 추가) 안 lookup actual = harness-meta repo (REPO_ROOT 기준) CLAUDE.md 실 측정값 → stated 999999 ≠ actual → mismatch detect 2건 → exit 1 FAIL (expected).

stated value 999999 = unlikely large value cross-platform stable (D3) — 현재 harness-meta CLAUDE.md ~73 lines 의 ~13000배 안전 margin. 미래 evidence 도달 시 별 milestone 안 fixture value 갱신 자연 (lightweight scope 외).

mechanism context scope = harness-meta repo (REPO_ROOT 기준) context 한정 cover. target project (예: upbit) = harness-meta 외부 별 git repo + v6.6 D10 path traversal 차단 narrative 정합 = external context 검증 oos (본 fixture 도 동일 본질).
