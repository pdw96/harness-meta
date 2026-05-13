# EXECUTE phase-2 — Atomic flip

```json
{
  "phase": 2,
  "title": "Atomic flip — git mv milestones/ + root ROADMAP thin index + harness-meta.md Stage A path resolution",
  "status": "complete",
  "started_at": "2026-05-08",
  "completed_at": "2026-05-08",
  "commit_sha": "0fa3d32",
  "scope": "최소 원자 set: (1) git mv milestones/* → projects/meta/milestones/* (7 dir 일괄, history 보존) + (2) 기존 root ROADMAP.md 를 thin index 로 rewrite (milestones[] 제거, projects[] 만 — { projects: [{ name, roadmap_path }] }) + (3) claude/commands/harness-meta.md Stage A/B/C/D/E/G 모든 path resolution 갱신. 단일 commit. /harness-meta meta Stage A read 가 thin index 만난 직후 즉시 새 path 인식 → broken window 0.",
  "changes": [
    {
      "files": "milestones/v1.0_workflow-redesign/ + v1.1_meta-as-project/ + v1.84_workflow-revamp/ + v1.85_roadmap-housekeeping/ + v1.86_cross-ref-false-positive-fix/ + v1.87_python-entry-boilerplate-smoke/ + v1.88_precommit-performance/",
      "action": "git mv → projects/meta/milestones/",
      "description": "7 milestone 디렉토리 일괄 이동. 단일 git mv milestones projects/meta/milestones 로 atomic. history 보존 (--follow). 내부 cross-ref ../../ROADMAP.md 는 depth +2 self-heal — 이전 root → 신규 projects/meta/ROADMAP.md."
    },
    {
      "file": "ROADMAP.md (root)",
      "action": "rewrite",
      "description": "thin index — { project: 'harness-meta-projects-index', updated, projects: [{ name: 'meta', roadmap_path: 'projects/meta/ROADMAP.md' }, { name: 'upbit', roadmap_path: 'projects/upbit/ROADMAP.md' }] }. milestones[] 키 부재 (smoke 가 차단). 관련 문서 § thin index 안내 + meta milestone 위치 명시."
    },
    {
      "file": "claude/commands/harness-meta.md",
      "action": "modify",
      "description": "Stage A/B/C/D/E/G 모든 path resolution 갱신. 라인 35 (모듈 매트릭스 ROADMAP 행 — projects/meta/ROADMAP.md), 36 (MILESTONE 행 — projects/meta/milestones/), 48 (대상 구분 표 메타 milestone path), 67 (Stage A meta read), 79 (vX.Y 결정 기준), 82 (Stage B mkdir path), 90/105/120 (Stage C/D/E PLAN/RESEARCH/DESIGN path), 169/175 (Stage G VERIFY/REPORT path), 228-229 (금지 list path), 236 (관련 cross-ref). frontmatter / 7-stage 도식 / Stage F 흐름 등 비-path 부분은 무수정."
    }
  ],
  "execution_notes": [
    "44 files changed, +87 / -56 (commit 0fa3d32). 42 renames (대부분 100% similarity, phase-1.md 70% — git rename + content modification 동시 detect).",
    "git mv 단일 명령 (milestones → projects/meta/milestones) 으로 7 milestone 디렉토리 일괄 이동 — history 보존 확인.",
    "ROADMAP.md (root) thin index 변환 — milestones[] 6건 제거, projects[] 2 entries (meta + upbit). 관련 문서 § meta milestone 위치 명시 + 워크플로우 진입 가이드 보강.",
    "claude/commands/harness-meta.md path resolution 갱신: Stage A/B 모듈 매트릭스 (라인 35/36), 대상 구분 표 (라인 48), Stage A read (라인 67), Stage B vX.Y/mkdir (라인 79/82), 금지 list (라인 228/229 + neue 'root ROADMAP에 milestone 직접 기재 금지' 항목), 관련 cross-ref (라인 236). Stage C/D/E/G generic milestones/ 경로는 유지 (양 mode 호환).",
    "phase-1.md status: in_progress → complete + execution_notes (commit 7bfa1a5 retro) 갱신 — 본 commit 에 포함.",
    "수동 smoke 검증: bash tests/smoke-projects-scope-discipline.sh 실행 → PASS exit 0. (root thin index + projects/<name>/ROADMAP milestones[] 모두 정상)",
    "broken window 0 검증: phase 2 commit 후 새 세션 시뮬 — Stage A read 가 ~/harness-meta/projects/meta/ROADMAP.md 정상 resolve (harness-meta.md 라인 67 갱신).",
    "git diff content 보존 확인 — 42 rename 중 phase-1.md 만 70% (status update + execution_notes 추가, 의도된 변경). 나머지 100% similarity = path만 변경."
  ],
  "commit_message": "feat(meta): v1.1 phase-2 — atomic flip (git mv milestones + thin index + harness-meta.md path resolution)"
}
```
