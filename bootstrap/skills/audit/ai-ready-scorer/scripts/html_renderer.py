"""html_renderer.py — AI-Ready 점수 HTML 대시보드 생성

generate_html: dict 기반 (dataclass 미참조). Chart.js radar + 카테고리 카드 + ROI 표.
v1.18g-score-codebase-py-split에서 추출.

의존: utils.pct (백분율 계산) + stdlib (json, pathlib).
"""

from __future__ import annotations

import json
from pathlib import Path

from utils import pct


def generate_html(report: dict, output_path: Path) -> None:
    cats = report["categories"]
    total = report["total_score"]
    grade = report["grade"]
    color = report["color"]
    roi = report["roi_actions"]

    radar_labels = json.dumps([c["name_ko"] for c in cats], ensure_ascii=False)
    radar_scores = json.dumps([c["score"] for c in cats])
    radar_max    = json.dumps([c["max_score"] for c in cats])

    grade_emoji = {"S": "🏆", "A": "⭐", "B": "✅", "C": "⚠️", "D": "🔴"}.get(grade, "")

    # 레전드/헤더용 N/A 카운트 사전 계산
    for c in cats:
        c["_na_count"] = sum(1 for ch in c.get("checks", []) if ch.get("na"))

    cat_cards = ""
    for c in cats:
        g, col = c["grade"], c["color"]
        bar_pct = pct(c["score"], c["max_score"])
        na_count = c["_na_count"]
        na_badge_html = f'<span class="na-count">{na_count} N/A</span>' if na_count else ""
        checks_html = ""
        for ch in c["checks"]:
            is_na = ch.get("na", False)
            is_partial = not is_na and ch["score"] < ch["max_score"]
            icon = "ℹ️" if is_na else ("⚠️" if is_partial else "✅")
            action_html = f'<div class="action">→ {ch["action"]}</div>' if is_partial and ch.get("action") else ""
            na_li_class = " check-na" if is_na else ""
            score_cell = '<span class="na-tag">N/A</span>' if is_na else f'<span class="check-score">{ch["score"]:.0f}/{ch["max_score"]:.0f}</span>'
            checks_html += f'''
            <li class="check-item{na_li_class}">
              <span class="check-icon">{icon}</span>
              <span class="check-name">{ch["name"]}</span>
              {score_cell}
              {action_html}
            </li>'''
        cat_cards += f'''
        <div class="cat-card">
          <div class="cat-header">
            <span class="cat-name">{c["name_ko"]}</span>
            {na_badge_html}
            <span class="cat-grade" style="background:{col}">{g}</span>
            <span class="cat-score">{c["score"]:.0f} / {c["max_score"]}</span>
          </div>
          <div class="progress-bar">
            <div class="progress-fill" style="width:{bar_pct}%;background:{col}"></div>
          </div>
          <ul class="check-list">{checks_html}</ul>
        </div>'''

    roi_rows = ""
    for i, a in enumerate(roi[:10], 1):
        effort_color = {"즉시": "#10b981", "단기": "#f59e0b", "중기": "#ef4444"}.get(a["effort"], "#6b7280")
        roi_rows += f'''
        <tr>
          <td class="rank">#{i}</td>
          <td><span class="tag" style="background:{effort_color}">{a["effort"]}</span></td>
          <td class="score-cell">+{a["recoverable_score"]:.0f}점</td>
          <td class="cat-cell">{a["category"]}</td>
          <td class="action-text">{a["action"]}</td>
        </tr>'''

    html = f"""<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>AI-Ready 감사 — {report["repo_name"]}</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
<style>
  *, *::before, *::after {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    background: #0f172a; color: #e2e8f0; min-height: 100vh;
  }}
  .header {{
    background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
    border-bottom: 1px solid #334155;
    padding: 2rem;
    text-align: center;
  }}
  .header h1 {{ font-size: 1.5rem; color: #94a3b8; margin-bottom: 0.5rem; }}
  .repo-name {{ font-size: 2rem; font-weight: 700; color: #f1f5f9; }}
  .meta {{ color: #64748b; font-size: 0.875rem; margin-top: 0.5rem; }}
  .score-hero {{
    display: flex; align-items: center; justify-content: center; gap: 2rem;
    padding: 3rem 2rem;
    background: #1e293b;
    border-bottom: 1px solid #334155;
  }}
  .score-circle {{
    width: 140px; height: 140px; border-radius: 50%;
    border: 6px solid {color};
    display: flex; flex-direction: column; align-items: center; justify-content: center;
    box-shadow: 0 0 30px {color}44;
  }}
  .score-number {{ font-size: 3rem; font-weight: 800; color: {color}; line-height: 1; }}
  .score-denom {{ font-size: 1rem; color: #64748b; }}
  .score-info {{ text-align: left; }}
  .grade-badge {{
    display: inline-block; padding: 0.5rem 1.5rem; border-radius: 2rem;
    background: {color}22; border: 2px solid {color};
    font-size: 2rem; font-weight: 800; color: {color};
    margin-bottom: 0.75rem;
  }}
  .score-pct {{ font-size: 1.25rem; color: #94a3b8; }}
  .score-lang {{ font-size: 0.875rem; color: #64748b; margin-top: 0.25rem; }}
  .main {{ max-width: 1200px; margin: 0 auto; padding: 2rem; }}
  .section-title {{ font-size: 1.25rem; font-weight: 700; color: #f1f5f9; margin-bottom: 1.5rem;
    border-left: 4px solid #3b82f6; padding-left: 0.75rem; }}
  .chart-section {{
    display: grid; grid-template-columns: 1fr 2fr; gap: 2rem;
    margin-bottom: 3rem; align-items: start;
  }}
  .chart-box {{
    background: #1e293b; border: 1px solid #334155; border-radius: 1rem; padding: 1.5rem;
  }}
  .chart-legend {{ display: flex; flex-direction: column; gap: 0.75rem; }}
  .legend-item {{
    display: flex; align-items: center; gap: 0.75rem;
    background: #0f172a; border-radius: 0.5rem; padding: 0.75rem;
  }}
  .legend-dot {{ width: 10px; height: 10px; border-radius: 50%; flex-shrink: 0; }}
  .legend-name {{ flex: 1; font-size: 0.875rem; }}
  .legend-score {{ font-weight: 700; font-size: 0.875rem; }}
  .legend-bar {{ flex: 1; height: 4px; background: #334155; border-radius: 2px; overflow: hidden; }}
  .legend-fill {{ height: 100%; border-radius: 2px; }}
  .cats-grid {{
    display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 1.5rem; margin-bottom: 3rem;
  }}
  .cat-card {{
    background: #1e293b; border: 1px solid #334155; border-radius: 1rem; padding: 1.25rem;
  }}
  .cat-header {{
    display: flex; align-items: center; gap: 0.75rem; margin-bottom: 0.75rem;
  }}
  .cat-name {{ flex: 1; font-weight: 600; font-size: 1rem; }}
  .cat-grade {{
    padding: 0.25rem 0.75rem; border-radius: 1rem; font-weight: 800; font-size: 0.875rem;
    color: white;
  }}
  .cat-score {{ font-size: 0.875rem; color: #94a3b8; white-space: nowrap; }}
  .progress-bar {{
    height: 6px; background: #334155; border-radius: 3px; overflow: hidden; margin-bottom: 1rem;
  }}
  .progress-fill {{ height: 100%; border-radius: 3px; transition: width 0.5s ease; }}
  .check-list {{ list-style: none; display: flex; flex-direction: column; gap: 0.5rem; }}
  .check-list li {{
    display: flex; align-items: flex-start; gap: 0.5rem; font-size: 0.8rem;
    flex-wrap: wrap;
  }}
  .check-icon {{ flex-shrink: 0; }}
  .check-name {{ flex: 1; color: #94a3b8; }}
  .check-score {{ color: #64748b; font-size: 0.75rem; white-space: nowrap; }}
  .check-na {{ opacity: 0.6; }}
  .check-na .check-name {{ color: #475569; }}
  .na-tag {{
    font-size: 0.65rem; font-weight: 700; color: #475569;
    background: #0f172a; border: 1px solid #1e293b;
    padding: 0.1rem 0.35rem; border-radius: 0.25rem; white-space: nowrap;
  }}
  .na-count {{
    font-size: 0.7rem; color: #475569;
    background: #0f172a; border: 1px solid #1e293b;
    padding: 0.1rem 0.4rem; border-radius: 1rem; white-space: nowrap;
  }}
  .action {{
    width: 100%; color: #f59e0b; font-size: 0.75rem;
    padding: 0.25rem 0.5rem; background: #f59e0b11; border-radius: 0.25rem;
    margin-top: 0.25rem;
  }}
  .roi-section {{ margin-bottom: 3rem; }}
  .roi-table {{ width: 100%; border-collapse: collapse; font-size: 0.875rem; }}
  .roi-table th {{
    background: #334155; color: #94a3b8; padding: 0.75rem 1rem;
    text-align: left; font-weight: 600;
  }}
  .roi-table td {{ padding: 0.75rem 1rem; border-bottom: 1px solid #1e293b; vertical-align: top; }}
  .roi-table tr:hover td {{ background: #1e293b; }}
  .rank {{ color: #64748b; font-weight: 700; width: 3rem; }}
  .tag {{
    display: inline-block; padding: 0.2rem 0.6rem; border-radius: 1rem;
    font-size: 0.75rem; font-weight: 600; color: white; white-space: nowrap;
  }}
  .score-cell {{ font-weight: 700; color: #10b981; white-space: nowrap; }}
  .cat-cell {{ color: #94a3b8; white-space: nowrap; }}
  .action-text {{ color: #e2e8f0; }}
  .footer {{
    text-align: center; color: #475569; font-size: 0.8rem;
    padding: 2rem; border-top: 1px solid #334155; margin-top: 2rem;
  }}
  @media (max-width: 768px) {{
    .chart-section {{ grid-template-columns: 1fr; }}
    .score-hero {{ flex-direction: column; gap: 1.5rem; }}
  }}
</style>
</head>
<body>
<div class="header">
  <h1>🤖 AI-Ready Codebase 감사 리포트</h1>
  <div class="repo-name">{report["repo_name"]}</div>
  <div class="meta">생성: {report["generated_at"][:10]} | 언어: {report["language"]} | 파일: {report["file_count"]}개 | 브랜치: {report["git_branch"] or "N/A"}</div>
</div>

<div class="score-hero">
  <div class="score-circle">
    <div class="score-number">{total:.0f}</div>
    <div class="score-denom">/ 100</div>
  </div>
  <div class="score-info">
    <div class="grade-badge">{grade_emoji} {grade}</div>
    <div class="score-pct">{report["percentage"]:.1f}% AI-Ready</div>
    <div class="score-lang">{report["language"]} 프로젝트</div>
  </div>
</div>

<div class="main">
  <div class="chart-section">
    <div class="chart-box" style="max-width:320px">
      <canvas id="radarChart" width="300" height="300"></canvas>
    </div>
    <div class="chart-box">
      <div class="section-title">카테고리별 점수</div>
      <div class="chart-legend">
        {"".join(f'''<div class="legend-item">
          <div class="legend-dot" style="background:{c['color']}"></div>
          <span class="legend-name">{c["name_ko"]}{f' <span style="font-size:0.7rem;color:#475569">&#183;&nbsp;{c["_na_count"]}&nbsp;N/A</span>' if c["_na_count"] else ""}</span>
          <div class="legend-bar"><div class="legend-fill" style="width:{pct(c['score'],c['max_score'])}%;background:{c['color']}"></div></div>
          <span class="legend-score" style="color:{c['color']}">{c['score']:.0f}/{c['max_score']}</span>
          <span class="cat-grade" style="background:{c['color']}">{c['grade']}</span>
        </div>''' for c in cats)}
      </div>
    </div>
  </div>

  <div class="section-title">카테고리 상세</div>
  <div class="cats-grid">{cat_cards}</div>

  <div class="roi-section">
    <div class="section-title">🚀 ROI 우선순위 액션 TOP 10</div>
    <table class="roi-table">
      <thead>
        <tr>
          <th>순위</th><th>난이도</th><th>회복 점수</th><th>카테고리</th><th>권장 액션</th>
        </tr>
      </thead>
      <tbody>{roi_rows}</tbody>
    </table>
  </div>
</div>

<div class="footer">
  AI-Ready Codebase Scorer · 생성: {report["generated_at"]} ·
  <a href="https://github.com/pdw96/upbit" style="color:#3b82f6">upbit</a>
</div>

<script>
const labels = {radar_labels};
const scores = {radar_scores};
const maxes  = {radar_max};
const pcts = scores.map((s,i) => parseFloat((s/maxes[i]*100).toFixed(1)));

new Chart(document.getElementById('radarChart'), {{
  type: 'radar',
  data: {{
    labels: labels,
    datasets: [{{
      label: 'AI-Ready 점수',
      data: pcts,
      backgroundColor: 'rgba(59,130,246,0.15)',
      borderColor: '#3b82f6',
      borderWidth: 2,
      pointBackgroundColor: '#3b82f6',
      pointRadius: 4,
    }}]
  }},
  options: {{
    responsive: true,
    scales: {{
      r: {{
        min: 0, max: 100,
        ticks: {{ color: '#64748b', stepSize: 25, font: {{ size: 10 }} }},
        grid: {{ color: '#334155' }},
        pointLabels: {{ color: '#94a3b8', font: {{ size: 10 }} }},
        angleLines: {{ color: '#334155' }},
      }}
    }},
    plugins: {{ legend: {{ display: false }} }}
  }}
}});
</script>
</body>
</html>"""

    output_path.write_text(html, encoding="utf-8", newline="\n")
