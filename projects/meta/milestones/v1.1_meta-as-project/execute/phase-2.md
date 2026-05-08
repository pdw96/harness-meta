# EXECUTE phase-2 — Atomic flip

```json
{
  "n": 2,
  "title": "Atomic flip — git mv milestones/ + root ROADMAP thin index + harness-meta.md Stage A path resolution",
  "status": "in_progress",
  "started_at": "2026-05-08",
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
  "execution_notes": [],
  "commit_message": "feat(meta): v1.1 phase-2 — atomic flip (git mv milestones + thin index + harness-meta.md path resolution)"
}
```
