# A1 — Boilerplate 12 패턴 grep regex 확정

본 audit의 **유일한 spec source**. 실 LICENSE 17건 (audit/A2) 콘텐츠 evidence 기반 grep regex 확정.

## 1. 12 패턴 식별 매트릭스

각 패턴은 **2가지 신호** 사용 (false positive ↓):
1. **Header signal** (1차 — license 이름 키워드)
2. **Body signal** (2차 — boilerplate 본문 distinctive 구문)

T2는 **둘 다 매칭** 시 confidence 충분. 단일 신호만 매칭은 weak — false positive risk 높음 (audit/A2).

| # | SPDX ID | Header signal (1차) | Body signal (2차) | 본문 라인 위치 |
|---|---------|--------------------|-------------------|---------------|
| 1 | `MIT` | `^[[:space:]]*(The )?MIT License(\s|\(MIT\)\|$)` | `Permission is hereby granted, free of charge,` | 1-15 |
| 2 | `Apache-2.0` | `^[[:space:]]*Apache License` | `Version 2\.0` (다음 라인) | 1-5 |
| 3 | `GPL-2.0` | `GNU GENERAL PUBLIC LICENSE` | `Version 2(,\| )` | 1-30 |
| 4 | `GPL-3.0` | `GNU GENERAL PUBLIC LICENSE` | `Version 3` | 1-30 |
| 5 | `AGPL-3.0` | `GNU AFFERO GENERAL PUBLIC LICENSE` | `Version 3` | 1-30 |
| 6 | `LGPL-2.1` | `GNU LESSER GENERAL PUBLIC LICENSE` | `Version 2\.1` | 1-30 |
| 7 | `LGPL-3.0` | `GNU LESSER GENERAL PUBLIC LICENSE` | `Version 3` | 1-30 |
| 8 | `BSD-2-Clause` | `Redistribution and use` (in source and binary forms) | NO `3\. Neither (the name\|the names)` 매칭 | 1-30 |
| 9 | `BSD-3-Clause` | `Redistribution and use` (in source and binary forms) | `3\. Neither (the name\|the names)` 매칭 | 1-30 |
| 10 | `ISC` | `Permission to use, copy, modify, and/or distribute` | `WITHOUT WARRANTY` 또는 `WITH OR WITHOUT FEE` | 1-15 |
| 11 | `MPL-2.0` | `Mozilla Public License` | `Version 2\.0` | 1-5 |
| 12 | `Unlicense` | `This is free and unencumbered software released into the public domain` | `unlicense\.org` 또는 `For more information` | 1-10 |

### Notion edge case (헤더 부재 MIT)

Notion `~/AppData/Local/Programs/Notion/LICENSE`:
- Line 1-2: copyright만 (`Copyright (c) Electron contributors` ...)
- Line 4: `Permission is hereby granted, free of charge, to any person obtaining`
- **Header signal 부재** (`MIT License` 키워드 없음)

→ MIT 신호 표 위 `OR` 분기 적용:
```
(header_signal OR (body_signal AND copyright_pattern))
```
즉 header 부재여도 body signal + `Copyright (c)` 헤더 존재 시 MIT 분류. 단 body signal이 ISC와 다르므로 (`free of charge` vs `for any purpose with or without fee`) 충돌 없음.

## 2. False positive 방지 — disambiguation rule

### 2-1. MIT vs ISC

둘 다 Permission 구문 사용하나 distinctive 차이:
- MIT: `Permission is hereby granted, free of charge,`
- ISC: `Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee`

→ 분리 grep 가능. 충돌 없음.

### 2-2. GPL family 우선순위 (longest-match first)

GPL 파생은 **상위 longest match 먼저**:
1. `AGPL` (AFFERO GENERAL) — 가장 specific
2. `LGPL` (LESSER GENERAL) — specific
3. `GPL` (GENERAL PUBLIC) — base

스캔 순서 역순: AGPL → LGPL → GPL. 아니면 base GPL이 LGPL/AGPL 텍스트도 매칭 (LGPL/AGPL은 `GENERAL PUBLIC LICENSE` substring 포함).

### 2-3. BSD-3 vs BSD-2

둘 다 `Redistribution and use` 시작. 차이는 3번째 조항 (`3. Neither the name`):
- BSD-3-Clause: 3 conditions (3번째에 endorsement 금지)
- BSD-2-Clause: 2 conditions only

→ scan order: BSD-3 먼저 (longer match), 매칭 안되면 BSD-2.

### 2-4. GPL or-later detection

GPL 매칭 후 본문 추가 grep:
```
"either version <N> of the License, or (at your option) any later version"
또는 "version <N> of the License, or any later version"
```

매칭 시 SPDX ID에 `-or-later` suffix, 미매칭 시 `-only` suffix.

**예**:
- `GPL-3.0-only` (or-later 구문 없음)
- `GPL-3.0-or-later` (or-later 구문 있음)
- `LGPL-2.1-or-later`
- `AGPL-3.0-only`

⚠️ **알려진 한계** (audit/A2 PortableGit 사례):
PortableGit LICENSE는 `or-later` 구문 보유 (line 266, 320 — GPL 표준 텍스트) 이지만 파일 상단 (line 1-15) Linus 메모: "the only valid version of the GPL ... v2, not v2.2 or v3.x". 이 의미적 conflict는 grep으로 detect 불가 → 본 v1.10e2는 boilerplate or-later 구문 있으면 `-or-later` stamp. **사용자 의도가 다르면 SPDX 헤더 추가 권장** (T1 우선순위 적용).

## 3. 실 LICENSE 콘텐츠 검증 (audit/A2 17 sample 대조)

| 파일 | 기대 SPDX | 1차 header signal 라인 | 2차 body signal 라인 | head -30 capture? |
|------|----------|---------------------|--------------------|------------------|
| harness-meta/LICENSE | MIT | `MIT License` @ L1 | `Permission... free of charge` @ L5 | ✅ |
| Astral LICENSE-APACHE | Apache-2.0 | `Apache License` @ L2 (leading WS) | `Version 2.0, January 2004` @ L3 | ✅ |
| Astral LICENSE-MIT | MIT | `MIT License` @ L1 | `Permission... free of charge` @ L5 | ✅ |
| Notion/LICENSE | MIT (no header) | (header 부재) | `Permission... free of charge` @ L4 | ✅ (body+copyright fallback) |
| ms-kubernetes / oracle-java | Apache-2.0 | `Apache License` @ L2 | `Version 2.0` @ L3 | ✅ |
| ms-python python | MIT | `MIT License` @ L13 (preamble 후) | `Permission... free of charge` @ L15 | ✅ |
| ms-python debugpy | MIT | `    MIT License` @ L1 (indented) | `Permission... free of charge` @ L5 | ✅ |
| PowerShell | MIT | `MIT License` @ L3 (after copyright) | `Permission... free of charge` @ L5 | ✅ |
| PS modules | MIT | `The MIT License (MIT)` @ L1 | `Permission... free of charge` @ L5 | ✅ |
| redhat yaml | MIT | `MIT License` @ L1 | `Permission... free of charge` @ L5 | ✅ |
| spring-initializr | MIT | `MIT License` @ L5 | `Permission... free of charge` @ L7 | ✅ |
| ms-azuretools containers | MIT | `MIT License` @ L7 | `Permission... free of charge` @ L9 | ✅ |
| PortableGit | GPL-2.0-only* | `GNU GENERAL PUBLIC LICENSE` @ L22 | `Version 2` @ L23 | ✅ (head -30 필수) |
| databricks / copilot×3 / remotehub / pylance / Microsoft EULA | (T3 fallback) | (header 부재) | (body 부재) | T3 |

\*PortableGit `or-later` 구문 보유 — boilerplate stamp는 `GPL-2.0-or-later`. 본 v1.10e2 한계 (위 §2-4 알려진 한계 참조).

**Recovery rate**:
- OSS 식별: 13/17 (= **76.5%** — MIT 9 + Apache-2.0 3 + GPL-2.0 1)
- T3 fallback: 4/17 (proprietary EULA 정확 처리)
- False positive: 0/17 (모든 EULA가 boilerplate signal 부재)

## 4. head 라인 수 결정

**head -30** 채택. 근거:
- PortableGit GPL @ L22 → head -10/-15 부족
- ms-python python MIT @ L13 → head -10 경계
- BSD-3-Clause `3. Neither` 마커 — 본문 중반 → head -30 필요
- head -50은 보수적이지만 추가 false positive risk (license 본문 외 텍스트가 longer)

→ **head -30**으로 실 sample 100% capture.

## 5. 최종 grep regex 표 (bash 구현 직전)

각 패턴 함수는 head -30 buffer를 stdin으로 받음. exit 0 = 매칭, exit 1 = 미매칭.

```bash
# header_signal_<spdx_id>(): head -30 stdin → exit 0 (매칭) / 1 (미매칭)
header_mit()      { grep -q -E '^[[:space:]]*(The )?MIT License(\s|\(MIT\)|$)'; }
header_apache()   { grep -q -E '^[[:space:]]*Apache License'; }
header_gpl()      { grep -q -E 'GNU GENERAL PUBLIC LICENSE'; }
header_agpl()     { grep -q -E 'GNU AFFERO GENERAL PUBLIC LICENSE'; }
header_lgpl()     { grep -q -E 'GNU LESSER GENERAL PUBLIC LICENSE'; }
header_bsd_redist(){ grep -q -E 'Redistribution and use'; }   # BSD-2/3 공통
header_isc()      { grep -q -E 'Permission to use, copy, modify, and/or distribute'; }
header_mpl()      { grep -q -E 'Mozilla Public License'; }
header_unlicense(){ grep -q -E 'This is free and unencumbered software released into the public domain'; }

# body signal — head -30 또는 entire body
body_mit_perm()   { grep -q -E 'Permission is hereby granted, free of charge'; }
body_version_2()  { grep -q -E 'Version 2(,| )'; }
body_version_21() { grep -q -E 'Version 2\.1'; }
body_version_3()  { grep -q -E 'Version 3'; }
body_version_20() { grep -q -E 'Version 2\.0'; }
body_bsd_clause3(){ grep -q -E '3\. Neither (the name|the names)'; }
body_or_later()   { grep -q -E '(at your option)?\s*any later version'; }
```

## 6. 매칭 알고리즘 의사코드 (audit/A3에서 bash 확정)

```
match_priority_order = [
    AGPL_3,    # longest GPL family - first
    LGPL_3,
    LGPL_21,
    GPL_3,
    GPL_2,
    APACHE_2,
    MPL_2,
    UNLICENSE,
    BSD_3,     # before BSD_2 (longer match)
    BSD_2,
    ISC,       # before MIT (different perm phrase)
    MIT,
]

for pattern in match_priority_order:
    if pattern.header_signal(head_buffer) AND pattern.body_signal(head_buffer):
        spdx = pattern.id
        if pattern.is_gpl_family AND body_or_later(full_body):
            spdx += "-or-later"
        else if pattern.is_gpl_family:
            spdx += "-only"
        return spdx

# Notion edge case fallback
if body_mit_perm(head_buffer) AND copyright_pattern(head_buffer):
    return MIT  # 헤더 부재 MIT

return None  # T3 fallback
```

## 7. 후속 분기 (v1.10e3 메타데이터)

본 v1.10e2 boilerplate 매칭이 false negative인 케이스 (modified license, 신규 license 등) → **v1.10e3**:
- `package.json` `"license"` 필드
- `pyproject.toml` `[project].license` (PEP 621) 또는 `[tool.poetry].license`
- `Cargo.toml` `[package].license`

→ 본 v1.10e2의 한계가 v1.10e3 동기 — evidence-driven 후속 분기 (v1.10e와 동일 패턴).

## 관련 문서

- 본 audit: `A2-recovery-rate.md` (sample 검증) · `A3-detect-strategy.md` (bash 구현) · `A4-policy-decisions.md` (정책)
- v1.10e A1: `../v1.10e-detect-license/audit/A1-spdx-spec.md` (SPDX-License-Identifier 헤더 spec)
- 외부: [SPDX License List](https://spdx.org/licenses/)
