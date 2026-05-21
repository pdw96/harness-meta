#!/usr/bin/env bash
# tests/smoke-agent-frontmatter-schema.sh
#
# v6.20_agent-type-syntax-adoption 안 신설 (2026-05-21).
# agents/*.md frontmatter schema 검증 — Agent(agent_type) syntax 정합 + 참조 agent 존재 검증.
#
# 3 검증 항목:
#   (a) agents/*.md frontmatter parse (---/--- opening + closing + YAML)
#   (b) tools 필드 안 Agent(...) literal regex 정합 (parens 매칭 + comma separated)
#   (c) Agent(...) 안 참조 agent name 이 agents/*.md 안 실제 존재 (agents/{name}.md 존재 검증)
#
# cycle 1 evidence = agents/audit-orchestrator.md (Agent(5 멤버 allowlist) 본 repo 첫 사용 사례).
# v6.20 신설 trigger = audit-team 5 멤버 sandbox 효과 강제 + 미래 Agent(...) syntax 흡수 cycle 2+ (oos_2 정합) 회귀 차단.
#
# v2.1 batched python smoke 패턴 정합 (memory project_v2.1_smoke-spawn-batching).

set -euo pipefail

cd "$(dirname "$0")/.."

exec python3 - <<'PYEOF'
import re
import sys
from pathlib import Path

# Windows Git Bash cp949 함정 회피 — stdout utf-8 강제 (memory project_v2.1_smoke-spawn-batching cp949 함정 패턴 정합)
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8', errors='replace')

REPO_ROOT = Path('.').resolve()
AGENTS_DIR = REPO_ROOT / 'agents'

if not AGENTS_DIR.is_dir():
    print('FAIL: agents/ 디렉토리 부재')
    sys.exit(1)

# standalone agents/*.md 만 검증 (sub-directory 안 CLAUDE.md 제외 — agents/project-harness-audit-team/CLAUDE.md 등)
agent_files = sorted([p for p in AGENTS_DIR.glob('*.md') if p.is_file()])

if not agent_files:
    print('FAIL: agents/*.md 0건')
    sys.exit(1)

# 기존 agent name set (Agent(...) 참조 검증용)
agent_names = {p.stem for p in agent_files}

fails = 0
checks = 0
agent_ref_checks = 0
fmre = re.compile(r'\A---\n(.*?)\n---\n', re.DOTALL)
toolre = re.compile(r'^tools:\s*(.+)$', re.MULTILINE)
agentre = re.compile(r'Agent\(([^)]*)\)')
nameitemre = re.compile(r'^[a-z][a-z0-9_-]*$')

print(f'=== agents/*.md frontmatter schema 검증 ({len(agent_files)} 파일) ===\n')

for fp in agent_files:
    text = fp.read_text(encoding='utf-8', errors='replace')
    label = fp.relative_to(REPO_ROOT).as_posix()
    checks += 1

    # (a) frontmatter parse
    m = fmre.match(text)
    if not m:
        print(f'  ✗ {label} — frontmatter 부재 또는 잘못된 형식 (---/--- 매칭 실패)')
        fails += 1
        continue
    fm_body = m.group(1)

    # (b) tools 필드 추출 + Agent(...) literal 검증
    tm = toolre.search(fm_body)
    if not tm:
        print(f'  - {label} — tools 필드 부재 (SKIP — default tools 자연)')
        continue
    tools = tm.group(1).strip()

    # Agent(...) literal 검출 (1 또는 다중)
    matches = list(agentre.finditer(tools))
    if not matches:
        # tools 필드 있으나 Agent(...) literal 부재 — 일반 tool list 자연 (회귀 차단 대상 아님)
        print(f'  ✓ {label} — frontmatter parse OK, Agent(...) literal 부재 (일반 tool list)')
        continue

    # Agent(...) literal 있음 — 안 name 검증
    file_fails = 0
    for am in matches:
        names_raw = am.group(1)
        if not names_raw.strip():
            print(f'  ✗ {label} — Agent() 안 name 부재 (빈 parens)')
            file_fails += 1
            continue
        names = [n.strip() for n in names_raw.split(',') if n.strip()]
        for name in names:
            agent_ref_checks += 1
            if not nameitemre.match(name):
                print(f'  ✗ {label} — Agent(...) literal 안 잘못된 name 형식: {name!r} (regex: ^[a-z][a-z0-9_-]*$)')
                file_fails += 1
                continue
            if name not in agent_names:
                print(f'  ✗ {label} — Agent({name}) 참조 agent 미존재 — agents/{name}.md 부재')
                file_fails += 1
                continue

    if file_fails == 0:
        total_names = sum(len([n.strip() for n in m.group(1).split(',') if n.strip()]) for m in matches)
        print(f'  ✓ {label} — frontmatter OK + Agent(...) literal {len(matches)}건 ({total_names} 참조) 정합')
    else:
        fails += file_fails

print(f'\n--- 검증 결과 ---')
print(f'  파일 검증: {checks} 건')
print(f'  Agent(...) 참조 검증: {agent_ref_checks} 건')
print(f'  FAIL: {fails} 건')

if fails > 0:
    print(f'\nFAIL — agents/*.md frontmatter Agent(agent_type) syntax 위반 {fails} 건')
    sys.exit(1)

print(f'\nPASS — agents/*.md frontmatter Agent(agent_type) syntax 검증 통과')
PYEOF
