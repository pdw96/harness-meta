---
id: price-compare-external-harness-application
title: price-compare 외부 harness 적용으로 audit-team 백지전제 결함 검출
version: v8.3
status: completed
---

# v8.3 — price-compare 외부 harness 적용으로 audit-team 백지전제 결함 검출

> 본 milestone = **가벼운 흐름** (4 섹션 트랙, ARCHITECTURE § 7.4) 산출물. 외부 적용을 실제 1건 수행한 **사례 trace + 결함 관찰 + 후속 후보 등록** 이지 컨설팅 자산 (audit-team) 자체의 변경이 아니므로 9-stage 아닌 4 섹션 한 장으로 처리 (§ 7.4 승격 기준 정합 — audit-team 실 개선은 큰 건 후보로 분리 등록).

## 문제

harness-meta 정체성 = harness engineering 컨설턴트 (§ 3.1). 그러나 v5.8 진단상 운영분 **self-loop 92.3%** (외부 적용 = upbit 1건뿐, 13건 중 12건 자기개발). "컨설팅 설계가 외부에서 실제로 통하는가" 는 외부 사례 축적으로만 입증 가능 — 책상 검증 (설계 정합) 과 현장 검증 (역량) 의 분리.

사용자 발의로 첫 **이종 스택** 외부 적용을 시도했다. 대상 = `price-compare` (Next.js App Router + TypeScript + Prisma 7 + Auth.js v5, k8s 배포) — upbit (Python async 트레이딩) 및 meta self-loop 양쪽과 완전히 다른 스택이라 audit-team chain 이 낯선 구조에서도 통하는지 검증력이 가장 높다. scope = audit → 권고 → e3 → 부품 배치 전 과정 실증 (audit-team 작동 + 컨설팅 부품의 외부 가치 확인).

## 결정

1. **적용 깊이 = "부품만 배치"** — 9-stage 워크플로우 이식 ❌, `.harness.toml` 활성화 ❌. harness-meta 정체성은 "워크플로우 복제" 가 아닌 "대상에 맞는 부품 (hook/skill/agent) 적재적소 배치" 이므로 정합.
2. **배치 부품 2종** (audit P0 #2 / P1 #3·#4 권고) — secret-guard hook (평문 토큰·JWT·키 감지) + git-push-guard hook (자동배포 경고 + tsc/eslint 리마인더). **차단 (deny) 아닌 경고** 설계 — false positive 회피, 판단은 작성자에게 (narrative 우선 철학). 로직은 inline 아닌 **파일 분리** (hook = 단순 호출자, deferred hook-narrative-separation 테마 정합).
3. **gsd 선행 제거** — 사용자 결정으로 기존 이종 하네스 (`get-shit-done-cc` 플러그인 + `.planning/` 86 파일 + stale worktree 3) 를 먼저 완전 삭제 후 harness-meta 부품 배치 (audit 권고 C1 "워크플로우 강제 금지" 의 충돌 대상이 제거됨).
4. **audit-team 실 개선은 본 가벼운 흐름 scope 외** — 아래 결함 (백지 전제) 의 실제 mechanism 수정은 컨설팅 자산 변경 = 큰 건이므로 next_candidate 로만 등록.

## 적용

외부 repo (`price-compare`, harness-meta 외부 — push 없이 로컬 커밋만):

- `905e80f` chore: gsd 워크플로우 제거 (`.planning/` 86 파일 + worktree prune + settings.json gsd 권한 + CLAUDE.md 안내 제거)
- `14bb1a3` feat: harness-meta audit 권고 hook 부품 배치 (`.claude/hooks/secret-guard.py` + `git-push-guard.py`, settings.local.json hooks 연결은 gitignore 로컬 전용)

harness-meta repo (본 trace):

- `development/milestones/v8.3/LIGHTWEIGHT.md` (본 파일)
- `development/ROADMAP.md` — `milestones[]` v8.3 entry + `next_candidates[]` audit-team 백지전제 검증 후보 추가 + `updated` 갱신

## 기록

**검증** — 두 hook 에 모의 입력 주입: secret-guard 는 `dckr_pat_…` 감지 시 경고 / 정상 코드 무반응, git-push-guard 는 `git push origin main` 감지 시 배포 경고 / 일반 명령 무반응 = 4 케이스 모두 기대대로. Windows cp949 한글 깨짐을 `sys.stdout.reconfigure(encoding="utf-8")` 로 해결 (출력 UTF-8 정상 확인). settings.local.json JSON valid. 본 LIGHTWEIGHT.md 는 `tests/smoke-spec-verification.sh` 4-section-lightweight era 검증 대상.

**교훈 (핵심)** — audit-team 의 암묵 전제 **"신규 대상 = 하네스 백지"** 가 외부에서 깨졌다. price-compare 는 입력 가정 (".harness.toml 부재 = 미적용") 과 달리 이미 gsd + 자작 하네스 (agents 6 / rules 3 / skills 1 / PreToolUse hook / MCP 5) 를 보유. audit-team 은 전제 정정을 거쳐 책임을 "구축" 에서 **"기존 자산 존중 + 충돌 회피 + 격차 보강"** 으로 재정의해 의미 있는 권고를 냈으나, 이 전제 결함은 **self-loop 92.3% 로는 절대 관찰 불가** — 외부·이종 검증의 가치를 직접 입증했다.

**교훈 2** — 외부 적용이 1건 (upbit) → 2건 (price-compare, 첫 이종 스택) 으로. v5.8 운용 부합도 (composer audit-team 작동 빈도 1/13) 의 reverse evidence 1건 추가.

**후속** — (1) `audit-team-blank-slate-assumption-check` (큰 건, next_candidate 등록) = audit-team 에 "기존 harness 자동 inventory + 백지 아닌 전제 검증 step" 보강. (2) 본 사례는 `verification-philosophy-redefine` (v8.0 oos_3, 검증철학 dogfooding 은퇴) 의 **첫 실증 데이터** 제공 — 외부 적용을 1차 검증 vector 로 재정의하는 근거.
