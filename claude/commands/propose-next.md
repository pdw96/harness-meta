---
description: Claude 자율 candidate 제안 mechanism — ROADMAP + 최근 5 milestone 분석 → 다음 milestone 후보 제안
allowed-tools: Bash, Read, Edit
argument-hint: "[apply]"
---

# /propose-next — Claude 자율 milestone 발의 mechanism (v6.5)

`projects/meta/ARCHITECTURE.md` § 4 끝 매트릭스 #9 row + paragraph 본문 안 정의된 mechanism. AI Native § 7.1 '자율성' 면 첫 실 적용. 자율 범위 = candidate 제안까지만 (사용자 결정 게이트 보존, 스무고개 방식 milestone 결정 선호 부합).

## 책임

- **본 slash command** = UX orchestrator. script 호출 + 우선순위 보고 + 사용자 명시 응답 (y/n) + candidate_draft[] append (Edit 도구 활용).
- **`scripts/propose_next.py`** = mechanical work 단일 source. enumerate (1차 디렉토리 + 2차 ROADMAP/CHANGELOG cross-validate) + JSON 출력. **append 책임 미포함** (D10 분리, append = 본 slash command 안 LLM Bash Edit).

## 실행 절차

`$ARGUMENTS` 안 사용자가 `apply` 키워드를 명시했는지 확인.

### Step 1 — Scan (dry-run, default)

다음 명령을 Bash tool 으로 호출 (fixed argument list — 다른 argument 금지):

```bash
python scripts/propose_next.py --scan
```

출력 = JSON. enumerated_milestones (최근 5).candidate_items (v6.8 dedupe 적용 — status 'delta' | 'passing') + roadmap_next_candidates + cross_validate.dedupe_stats (delta_count + passing_count).

### Step 2 — Report (delta 우선 surface + passing 통계 only, v6.8 dedupe)

JSON 분석 후 사용자에게 **`status: delta` (신규 surface 대상) 안 최우선 1 candidate 우선 보고** (D12 paper 일괄 제시 회피 + v6.8 D5 — 'status: passing' (이미 등재) 은 통계만 narrative):

```
가장 우선 후보 1 건 (신규 — delta):
  - title: <title>
  - rationale: <왜 우선인가>
  - source: <어느 milestone PROPOSE 출처>
  - category: 내부 진척 후 떠오른 아이디어 / 외부 트렌드 발견 중 어느 쪽

이미 인지한 후보 N건 (passing — next_candidates 또는 candidate_draft 안 등재) 통계만 보고.
추가 delta M-1건 후보가 더 발견되었습니다. 표시할까요? (y/n)
```

**delta 0건 case** (모든 후보 이미 인지): 신규 후보 부재 narrative + passing 통계 보고 (예: "신규 surface 후보 부재. 이미 인지한 후보 N건 (passing) — 후보 추가 발의 시 사용자 명시 발의 자연."). round 종료 (Step 3 진입 부재).

**비유 표현 가이드** (D12 dialog P1-2 + v6.8 D5, user_non_developer_role 정합):

- `candidate_draft[]` → "아직 결정 안 한 후보 명단"
- `internal_synthesis` → "내부 진척 후 떠오른 아이디어"
- `benchmark_external` → "외부 트렌드 발견"
- `lessons_learned P2 라벨` → "이전 작업 후속 후보 거명"
- `next_candidates_named_only` → "PROPOSE 안 거명만 처리된 후보"
- `status: delta` → "신규 surface 후보 (어디에도 등재 부재)"
- `status: passing` → "이미 인지한 후보 (등재 완료 또는 buffer)"
- `dedupe_stats` → "이미 인지한 후보 vs 신규 후보 자동 분리 통계"

### Step 3 — User approval (apply 분기)

후보 1+ 건 제안 후:

- `$ARGUMENTS` 안 `apply` 부재 = 사용자에게 "이 후보를 후보 명단 (candidate_draft[]) 에 추가할까요? (y/n)" 명시 응답 받기. 추가 후보 표시 요청 시 Step 2 반복.
- `$ARGUMENTS` 안 `apply` 존재 = 사용자가 apply 명시 의도이나 LLM 는 여전히 후보 1건 출력 후 "추가 진행 확정합니다." 보고 후 Step 4 진입 (안전 default).

`y` 또는 명시 승인 시 Step 4 진입. 그 외 = 종료.

### Step 4 — Append (Edit 도구 활용)

ROADMAP `candidate_draft[]` 안 신규 entry append. **schema 의무** (D3, 7 필드):

```json
{
  "id": "<a-z0-9-{1,64}>",
  "title": "<≤ 60자 + ' + ' 부재>",
  "source": "<origin_milestone + section 안 정확 인용>",
  "detected_at": "<ISO 8601 date, YYYY-MM-DD>",
  "rationale": "<왜 후보 — ≤ 500자>",
  "category": "internal_synthesis | benchmark_external",
  "decision_pending": "<사용자 결정 무엇 필요한가>"
}
```

**append 절차**:

1. `Read` 도구로 `projects/meta/ROADMAP.md` read.
2. `Edit` 도구로 `"candidate_draft": [` 직후 신규 entry insert (또는 `[]` 이면 `[\n  {<entry>}\n]` 으로 교체).
3. JSON validity self-check — Bash 으로 `python -c "import json; json.load(open('projects/meta/ROADMAP.md'))"` 부재 (ROADMAP 안 json 코드 블록 만 검증).

### Step 5 — Final report

- appended entry id + title + category 사용자에게 보고.
- "이후 검토 후 채택 시 `next_candidates[]` 이동, 거절 시 entry 삭제." narrative 추가.
- "다음 milestone 진입 결정은 사용자 자유 스무고개." (round 1 자율 범위 결정 정합).

## Mechanism 안전 가드레일

- **read-only default** (D9 + D10) — script `--scan` / `--list-candidates` 모두 read-only. append 책임 분리.
- **fixed argument list** (D13 정합) — slash command 가 script 호출 시 `--scan` 또는 `--list-candidates` 두 형태 만 허용 (shell metacharacter `;`, `&&`, `$(...)` injection 차단).
- **path traversal 차단** (D10) — script 안 `safe_relative(path)` 검증 의무. repo 외부 path 차단.
- **input validation 3축** (D10 sec P1 흡수) — append 시 LLM 안 schema enforcement (id regex / title ≤ 60자 / category enum 2 값 / detected_at ISO).
- **JSON round-trip self-check** (D10 sec P1_sec_3 흡수) — script 출력 + Edit 후 ROADMAP json 코드 블록 모두 round-trip.

## v4.0 narrative 관계 (D3 + D8)

`candidate_draft[]` 신 필드 = v4.0 phase-7 안 도입 narrative (벤치마크 cycle routine schedule skill 주 1회 cron). **작동 0건** (v5.8 evidence). v6.5 가 첫 실 작동 mechanism. **category 분리**:

- `internal_synthesis` (v6.5 자율 발의) — 내부 진척 (ROADMAP + 최근 5 milestone PROPOSE + lessons P2) 종합.
- `benchmark_external` (v4.0 벤치마크 cycle routine) — 외부 (GitHub 인기 repo + Claude Code release notes/changelog).

같은 host (`candidate_draft[]`) 공존, category 필드 분리 = 충돌 회피.

## Cascade source vs host 정의 (cf ARCHITECTURE § 4 끝 #9)

- **Cascade source** = 정전 narrative 의 1차 위치 (ARCHITECTURE.md § 4 끝 매트릭스 #9 row + paragraph 본문, explicit anchor `<a id="section-4-end-row-9">`).
- **Cascade host** = 본 slash command + root CLAUDE.md § 명령어 안 narrative 1 줄 인용 + bootstrap/agents/CLAUDE.md:163 안 category 분리 narrative.

## 관련

- 정전 source: [`projects/meta/ARCHITECTURE.md`](../../projects/meta/ARCHITECTURE.md) § 4 끝 매트릭스 #9 row + paragraph 본문
- 본 milestone: [`projects/meta/milestones/v6.5/MILESTONE.md`](../../projects/meta/milestones/v6.5/MILESTONE.md)
- smoke 자동 검증: [`tests/smoke-candidate-draft-schema.sh`](../../tests/smoke-candidate-draft-schema.sh)
- 관련 mechanism (cycle 동치): [`cascade-sync.md`](cascade-sync.md) (v6.4 — narrative cascade)
