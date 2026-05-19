# scanner-output (fixture — empty-targets)

audit chain `project-scanner` 산출 모방 fixture — fact 인용 (boolean / 표 / 수치) 0 건.

본 fixture 는 detect target 부재 cases (plain narrative content 만) — `audit_fact_verify.py` 가 어떤 fact 인용도 detect 안 함 → exit 0 PASS.

본 fixture 목적 = empty 산출물 (no boolean / no table / no numeric) edge case 검증. script 가 crash 없이 정상 작동 확인.

audit chain agent 가 산출 시 fact 인용 0 case 가능 (e.g., narrative 만 작성 시) — 본 fixture 가 그 case 모방.
