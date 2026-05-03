# meta v1.49-scorer-html-na-ui — PLAN

세션 시작: 2026-05-03
선행 세션: [`sessions/meta/v1.48-scorer-linter-na/`](../v1.48-scorer-linter-na/PLAN.md) — Automation 린터 설정 N/A 분기 신설

목적: AI-Ready scorer HTML 대시보드에서 N/A 항목을 정밀하게 시각화. 현재 N/A 체크 항목은 `ℹ️` 아이콘 외에 ✅와 구분이 어렵고, 카테고리 헤더·레전드에 N/A 기여분 표시 없음.

## 세션 소속 근거 (self-apply)

**세션 소속**: `sessions/meta/`

**근거**:
- 변경 파일: S1c(1) `bootstrap/skills/audit/ai-ready-scorer/scripts/html_renderer.py` = 1/1 meta
- **T1 경로 다수결** — S1c 100% (글로벌 user-skill)

## Scope inheritance (verbatim from 선행 세션)

**Source — ROADMAP.md §3-E (verbatim)**:

> `v1.18e-scorer-html-na-ui` — HTML 대시보드 N/A 카드 정밀 시각화

**Parsed sub-items (1)**:

1. **N/A 카드 정밀 시각화** — HTML 대시보드에서 N/A 항목을 별도 시각 스타일로 구분

## Out of scope (explicit rejection)

| ❌ Item | 분리 대상 |
|--------|---------|
| 점수 계산 로직 변경 | 별 후속 (evidence-driven) |
| ROI 테이블 N/A 필터링 | 별 후속 (evidence-driven) |
| Radar chart N/A 구분 | 별 후속 (evidence-driven) |
| categories_*.py 스코어링 변경 | 별 후속 |
| JSON 구조 변경 | 별 후속 |

## Spec verification (context7)

| sub-field | 값 |
|-----------|---|
| **library** | N/A |
| **topic** | N/A |
| **findings** | N/A |
| **drift** | N/A — 본 세션은 외부 spec 의존 무 (HTML/CSS UI 변경만, Anthropic Claude Code docs 무관) |
| **re-verify** | N/A |

## 배경 (문제 분석)

### 현재 상태

`html_renderer.py`의 체크 렌더링 (L35-44):
```python
icon = "ℹ️" if ch.get("na") else ("✅" if ch["passed"] else "❌")
action_html = ...
checks_html += f'''
<li>
  <span class="check-icon">{icon}</span>
  <span class="check-name">{ch["name"]}</span>
  <span class="check-score">{ch["score"]:.0f}/{ch["max_score"]:.0f}</span>
  {action_html}
</li>'''
```

**문제점 3가지**:

| # | 문제 | 증상 |
|---|------|------|
| P1 | N/A 항목 시각 미구분 | `ℹ️ 3/3` — ✅ 만점과 구분 불가 |
| P2 | 카테고리 헤더 N/A 정보 없음 | 점수 13/15 중 얼마가 N/A 자동 부여인지 불명 |
| P3 | 레전드 N/A 정보 없음 | 카테고리 범례에 N/A 기여분 표시 없음 |

### harness-meta 현재 N/A 항목 (JSON 기준)

- `문서화 (13/15)`: Docstring/JSDoc 커버리지 — 3/3 (N/A)
- `자동화 (13/15)`: 린터 설정(2/2), Docker/컨테이너화(2/2), 의존성 Lock 파일(1/1) — 5/5 (N/A)

## 목표

- [x] 세션 디렉토리 생성
- [x] PLAN.md 작성
- [ ] **사용자 PLAN 확정**
- [ ] Stage A — CSS 3 클래스 추가 (`.check-na`, `.na-tag`, `.na-count`)
- [ ] Stage B — 체크 루프 N/A 스타일 분기 (na-class + na-tag)
- [ ] Stage C — 카테고리 헤더 N/A 카운트 배지
- [ ] Stage D — 레전드 N/A 어노테이션
- [ ] Stage E — 동적 시뮬레이션 (python 실행 + HTML 육안 확인)
- [ ] Stage F — REPORT.md + ROADMAP 갱신

## 변경 대상

| 파일 | scope | 변경 |
|------|------|------|
| `bootstrap/skills/audit/ai-ready-scorer/scripts/html_renderer.py` | S1c | CSS 3 클래스 + 렌더링 3개소 변경 |

## 구현 상세 (R1 ~ R4)

### R1 — CSS 3 클래스 신설

```css
/* N/A 체크 항목 행 — 흐리게 */
.check-na {{ opacity: 0.6; }}
.check-na .check-name {{ color: #475569; }}

/* N/A 태그 (점수 대체) */
.na-tag {{
  font-size: 0.65rem; font-weight: 700;
  color: #475569; background: #0f172a;
  border: 1px solid #1e293b;
  padding: 0.1rem 0.35rem; border-radius: 0.25rem;
  white-space: nowrap;
}}

/* 카테고리 헤더 N/A 카운트 배지 */
.na-count {{
  font-size: 0.7rem; color: #475569;
  background: #0f172a; border: 1px solid #1e293b;
  padding: 0.1rem 0.4rem; border-radius: 1rem;
  white-space: nowrap;
}}
```

### R2 — 체크 루프 N/A 분기

```python
for ch in c["checks"]:
    is_na = ch.get("na", False)
    icon = "ℹ️" if is_na else ("✅" if ch["passed"] else "❌")
    action_html = f'<div class="action">→ {ch["action"]}</div>' if not ch["passed"] and ch.get("action") else ""
    na_li_class = " check-na" if is_na else ""
    score_cell = '<span class="na-tag">N/A</span>' if is_na else f'<span class="check-score">{ch["score"]:.0f}/{ch["max_score"]:.0f}</span>'
    checks_html += f'''
    <li class="check-item{na_li_class}">
      <span class="check-icon">{icon}</span>
      <span class="check-name">{ch["name"]}</span>
      {score_cell}
      {action_html}
    </li>'''
```

### R3 — 카테고리 헤더 N/A 배지

```python
na_count = sum(1 for ch in c["checks"] if ch.get("na"))
na_badge_html = f'<span class="na-count">{na_count} N/A</span>' if na_count else ""
# cat-header 순서: cat-name | na-badge | cat-grade | cat-score
```

### R4 — 레전드 N/A 어노테이션

```python
# legend-item 내 legend-name에 N/A 수 suffix
na_cnt = sum(1 for ch in c.get("checks", []) if ch.get("na"))
na_suffix = f' <span style="font-size:0.7rem;color:#475569">·&nbsp;{na_cnt}&nbsp;N/A</span>' if na_cnt else ''
# <span class="legend-name">{c["name_ko"]}{na_suffix}</span>
```

## 성공 기준

- [ ] N/A 체크 항목이 opacity 0.6 + `.check-na` 클래스로 시각 구분
- [ ] N/A 항목 점수 셀이 `N/A` 태그로 표시 (점수 숫자 대신)
- [ ] N/A 항목이 있는 카테고리 헤더에 `X N/A` 배지 노출
- [ ] 레전드 항목에 `· X N/A` 어노테이션 노출
- [ ] 기존 ✅/❌ 항목 렌더링 회귀 0
- [ ] harness-meta 점수 93/100 변동 0 (렌더링 전용)

## 커밋 전략

```
feat(meta): v1.49-scorer-html-na-ui — HTML 대시보드 N/A 카드 정밀 시각화

- html_renderer.py:
  - CSS: .check-na (opacity 0.6) / .na-tag (N/A 배지) / .na-count (헤더 배지)
  - 체크 루프: N/A 항목 check-na class + na-tag 점수 대체
  - 카테고리 헤더: N/A 카운트 배지 (na_count > 0 시)
  - 레전드: · X N/A 어노테이션 (na_cnt > 0 시)

ROADMAP §3-E v1.18e evidence 해소.
```
