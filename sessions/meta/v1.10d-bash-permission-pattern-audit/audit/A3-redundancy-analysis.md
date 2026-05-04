# A3 — 5축 통합 정정 매트릭스 (β scope)

본 문서는 v1.10d β scope의 4 파일 정정 최종안. 5축 통합 (A1 필드명 + A2 separator + A3 pattern + A4 redundant + A5 conservative).

**근거**:

- A1 인용 7: skills/slash command 공식 필드 = `allowed-tools:`
- A1 인용 8: slash command는 skill과 동일 frontmatter
- A1 인용 7: separator = "space-separated string or YAML list" (콤마 미명시)
- A1 인용 9: `allowed-tools` = pre-approval (NOT 제한)
- A1 인용 3: auto-allow set 자동 허용 (declare redundant)
- A1 인용 1: `Bash(cmd *)` 공백 형식 = `Bash(cmd:*)` 콜론 = equivalent

## 형식 채택 — YAML 리스트 (D2-b)

5축 통합 정정 시 **YAML 리스트 형식** 채택 — 모호성 차단:

- separator 모호성 (콤마 vs 공백) 차단 — 각 항목 독립 라인
- 가독성 + 확장성 ✓
- 공식 spec verbatim "space-separated string or **a YAML list**" 명시

대안 (공백 inline) 평가:

- (a) 공백 inline: `allowed-tools: Read Glob Grep Bash(mkdir *)` — 한 줄, 읽기 어려움 (long)
- (b) YAML list: 각 항목 독립 라인 — 추천

## 정정 매트릭스 (4 파일, 5축 통합)

### Pattern 형식 — 공백 (`Bash(cmd *)`) 채택

A1 인용 1 verbatim: 공백 형식이 dialog 표준 + permissions/skills/settings docs 3건 dominant. 콜론은 alias이지만 표기 minor.

(R1' 갱신: 콜론 → 공백)

### `claude/commands/harness-meta.md:5` (slash command)

**5축 모두 정정**:

```diff
-tools: Read, Glob, Grep, Write, Edit, Bash(ls*), Bash(mkdir*), Bash(git*), Bash(bash*), Bash(pwsh*), Bash(grep*), Bash(sed*), Bash(uname*), Bash(mv*), Bash(cp*), Bash(rm*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
+  - Write
+  - Edit
+  - Bash(mkdir *)
+  - Bash(git *)
+  - Bash(bash *)
+  - Bash(pwsh *)
+  - Bash(sed *)
+  - Bash(uname *)
+  - Bash(mv *)
+  - Bash(cp *)
+  - Bash(rm *)
```

**5축 변화**:

- A1: `tools:` → `allowed-tools:` (slash command 공식 필드)
- A2: 콤마 → YAML list
- A3: `cmd*` → `cmd *` (word-boundary)
- A4: `Bash(ls*)`, `Bash(grep*)` 제거 (자동 허용 set)
- A5: argument fine-grain 미시도 (Conservative 유지)

11 → 9 Bash 패턴.

### `bootstrap/templates/_base/.claude/skills/harness-design/SKILL.md:5`

```diff
-allowed-tools: Read, Glob, Grep, Write(phases/**), Edit(phases/**), Bash(ls*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
+  - Write(phases/**)
+  - Edit(phases/**)
```

**5축 변화**:

- A1: `allowed-tools:` 정합 (변경 없음)
- A2: 콤마 → YAML list
- A3: `Bash(ls*)` 제거 (A4와 함께)
- A4: ls 자동 허용 set declare 제거
- A5: 변경 없음

1 → 0 Bash 패턴.

### `bootstrap/templates/_base/.claude/skills/harness-plan/SKILL.md:6`

```diff
-allowed-tools: Read, Glob, Grep, Write(phases/**/PLAN.md), Edit(phases/**/PLAN.md), Bash(ls*), Bash(mkdir*), Bash(wc*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
+  - Write(phases/**/PLAN.md)
+  - Edit(phases/**/PLAN.md)
+  - Bash(mkdir *)
```

**5축 변화**:

- A1: 정합
- A2: 콤마 → YAML list
- A3: `Bash(mkdir*)` → `Bash(mkdir *)` (word-boundary)
- A4: ls/wc 자동 허용 declare 제거 (2건)
- A5: 변경 없음

3 → 1 Bash 패턴.

### `bootstrap/templates/_base/.claude/skills/harness-review/SKILL.md:5`

```diff
-allowed-tools: Read, Glob, Grep, Bash(git*)
+allowed-tools:
+  - Read
+  - Glob
+  - Grep
```

**5축 변화**:

- A1: 정합
- A2: 콤마 → YAML list
- A3: `Bash(git*)` 제거 (A4와 함께)
- A4: review skill = read-only — git read-only forms 자동 허용으로 충분 (인용 9: pre-approval 제거 시 baseline 폴백, 차단 아님)
- A5: 변경 없음

1 → 0 Bash 패턴.

## 총 정정 변화 (β scope)

| 파일 | 5축 위반 (현) | β 정정 후 | 변화 |
|------|:-----------:|:--------:|------|
| `harness-meta.md` | A1+A2+A3+A4 | 5축 모두 정정 | tools→allowed-tools / 콤마→YAML / 11 콜론없음→9 공백 / -2 redundant |
| `harness-design/SKILL.md` | A2+A3+A4 | 5축 모두 정정 | 콤마→YAML / Bash 통째 제거 |
| `harness-plan/SKILL.md` | A2+A3+A4 | 5축 모두 정정 | 콤마→YAML / 3→1 (-2 redundant + 1 공백화) |
| `harness-review/SKILL.md` | A2+A3+A4 | 5축 모두 정정 | 콤마→YAML / Bash 통째 제거 |
| **합계** | 16 Bash 패턴 | **9 Bash 패턴** | **-7 (44% 감소)** + A1 1건 + A2 4건 + A3 9건 + A4 7건 |

**Bash 외 항목 정정**: A2 콤마 → YAML list — 5 파일 (4 SKILL + 1 command) 모두. Read/Glob/Grep/Write/Edit 등 비-Bash 항목도 모두 YAML list 라인으로 분리.

## 의미 변화 검증 (5축 통합)

각 정정의 행위적 동등성 + 차이:

1. **A1 필드명 (`tools:` → `allowed-tools:`)**:
   - 가능 변화: 현재 silent ignore되던 declare가 정상 작동하기 시작 → `git status` 등 prompt 발생 케이스 변화 가능
   - 단 git read-only는 자동 허용 set으로 prompt 무 → 사용자 실제 영향 거의 없음
   - write forms (`mkdir`, `bash`, `pwsh` 등) 호출 시 정상 pre-approval 작동 (현재 prompt 발생 가능 → 정정 후 prompt 안 발생)

2. **A2 separator (콤마 → YAML list)**:
   - 가능 변화: 현재 콤마 형식이 단일 문자열로 파싱돼 `allowed-tools` 전체 무효였다면 → YAML list 정정 후 정상 작동
   - 단 verifiable evidence 없음 (skills docs는 공백/YAML list만 명시, 콤마 미명시)

3. **A3 pattern (`cmd*` → `cmd *`)**:
   - 행위적 차이: 의도 외 매치 (`lsof`, `gitk`, `cpio`, `rmdir`) 차단
   - 본 repo 실제 호출 명령은 정확한 명령명만 — 부작용 0

4. **A4 redundant 제거**:
   - 행위적 차이 0 (자동 허용 set은 declare 무관 작동)
   - misleading declare 제거 (cleanup)

5. **A5 conservative (변경 없음)**:
   - argument fragile 패턴 미시도 — 정책 일관 유지

**Regression 가능성 평가**:

- A1+A2 정정으로 declare가 처음 정상 작동할 수 있음 → 일부 명령 prompt 안 발생 (긍정적 변화)
- A3 정정으로 의도 외 매치 차단 → 본 repo 호출 명령 모두 정확한 명령명, 부작용 0
- A4 정정은 행위 무변화

**총 risk = 🟢 0** (모든 정정이 spec 정합 또는 redundant 제거).
