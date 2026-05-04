# A2 — Recovery rate 검증 (실 LICENSE 17건)

본 audit 시점(2026-04-27) 기준 시스템 LICENSE 파일 17건 추출. v1.10e A2 (sample 10건, T1 0%) 후속 — 17건으로 확장 + T2 boilerplate 매칭 가능성 검증.

## 1. 17 sample 분포 (확장)

조사 명령:

```bash
find ~ -maxdepth 5 \( -iname "LICENSE" -o -iname "LICENSE.md" -o -iname "LICENSE.txt" -o -iname "LICENSE-*" -o -iname "COPYING" -o -iname "NOTICE" \) -type f
head -30 <each>
grep -n -i -m1 "MIT License\|Apache License\|GNU.*PUBLIC LICENSE\|Mozilla\|Permission..." <each>
```

| # | 파일 | 첫 매칭 라인 (header) | body signal | 기대 분류 |
|---|------|---------------------|-------------|----------|
| 1 | `~/.cache/pre-commit/.../LICENSE-APACHE` (Astral) | `Apache License` @ L2 (leading WS) | `Version 2.0` @ L3 | Apache-2.0 |
| 2 | `~/.cache/pre-commit/.../LICENSE-MIT` (Astral) | `MIT License` @ L1 | `Permission... free of charge` @ L5 | MIT |
| 3 | `~/.vscode/extensions/databricks.../LICENSE.txt` | (none) | (none) | Proprietary EULA |
| 4 | `~/.vscode/extensions/github.copilot-chat-0.42.3/LICENSE.txt` | (none) | (none) | Proprietary EULA |
| 5 | `~/.vscode/extensions/github.copilot-chat-0.43.0/LICENSE.txt` | (none) | (none) | (dup of #4) |
| 6 | `~/.vscode/extensions/github.copilot-chat-0.44.1/LICENSE.txt` | (none) | (none) | (dup of #4) |
| 7 | `~/.vscode/extensions/github.remotehub.../LICENSE.txt` | (none) | (none) | Proprietary EULA |
| 8 | `~/.vscode/extensions/ms-azuretools.vscode-containers/LICENSE.md` | `MIT License` @ L7 (after preamble) | `Permission... free of charge` @ L9 | MIT |
| 9 | `~/.vscode/extensions/ms-kubernetes.../LICENSE.txt` | `Apache License` @ L2 | `Version 2.0` @ L3 | Apache-2.0 |
| 10 | `~/.vscode/extensions/ms-python.debugpy/LICENSE.txt` | `MIT License` @ L1 (indented) | `Permission... free of charge` @ L5 | MIT |
| 11 | `~/.vscode/extensions/ms-python.python/LICENSE.txt` | `MIT License` @ L13 (after long preamble) | `Permission... free of charge` @ L15 | MIT |
| 12 | `~/.vscode/extensions/ms-python.vscode-pylance/LICENSE.txt` | `MICROSOFT SOFTWARE LICENSE TERMS` @ L3 | (none) | Microsoft EULA |
| 13 | `~/.vscode/extensions/ms-vscode.powershell/LICENSE.txt` | `MIT License` @ L3 | `Permission... free of charge` @ L5 | MIT |
| 14 | `~/.vscode/extensions/ms-vscode.powershell/modules/LICENSE` | `The MIT License (MIT)` @ L1 | `Permission... free of charge` @ L5 | MIT |
| 15 | `~/.vscode/extensions/oracle.oracle-java/LICENSE.txt` | `Apache License` @ L1 | `Version 2.0` @ L2 | Apache-2.0 |
| 16 | `~/.vscode/extensions/redhat.vscode-yaml/LICENSE.txt` | `MIT License` @ L1 | `Permission... free of charge` @ L5 | MIT |
| 17 | `~/.vscode/extensions/vscjava.vscode-spring-initializr/LICENSE.txt` | `MIT License` @ L5 | `Permission... free of charge` @ L7 | MIT |
| 18 | `~/AppData/Local/Programs/Notion/LICENSE` | (header 부재) | `Permission... free of charge` @ L4 + `Copyright (c)` @ L1 | MIT (no header) |
| 19 | `~/Downloads/PortableGit/LICENSE.txt` | `GNU GENERAL PUBLIC LICENSE` @ L22 | `Version 2` @ L23 | GPL-2.0-or-later¹ |
| 20 | `~/harness-meta/LICENSE` | `MIT License` @ L1 | `Permission... free of charge` @ L5 | MIT |

¹ PortableGit boilerplate or-later 보유 → `GPL-2.0-or-later` stamp. 단 사용자 의도 (Linus 메모 line 1-15) `GPL-2.0-only` — boilerplate vs intent 의미적 conflict (audit/A1 §2-4 알려진 한계).

**Total**: 20 file (10 unique 외 + 3 copilot duplicates + 7 v1.10e A2 baseline).

## 2. 분류 분포

| 분류 | 개수 | 비율 | T2 매칭 |
|------|:----:|:----:|:-------:|
| MIT (header 정상) | 9 | 45% | ✅ T2 |
| MIT (header 부재, body+copyright) | 1 (Notion) | 5% | ✅ T2 fallback |
| Apache-2.0 | 3 | 15% | ✅ T2 |
| GPL-2.0 | 1 (PortableGit) | 5% | ✅ T2 |
| Proprietary/EULA | 6 (copilot×3 + databricks + remotehub + pylance) | 30% | ❌ T3 (정확) |

**OSS 식별 가능**: **14/20 (70%)**. v1.10e A2 (10건, OSS 50%)와 비교 — sample 확장으로 더 높은 비율 확인.

**False positive 추정**: **0** (모든 proprietary EULA는 boilerplate header signal 부재 → T3 fallback 정확).

**False negative 추정**: PortableGit `or-later` 의미 conflict 1건 (위 §1 footnote). 사용자 SPDX 헤더 추가로 회복 가능 (T1 우선순위).

## 3. T1 vs T2 비교 — 추출률 향상

| 측면 | v1.10e (T1 only) | **v1.10e2 (T1 + T2)** |
|------|:---------------:|:---------------------:|
| sample 추출률 | 0/20 (0%) | 14/20 (70%) |
| OSS 정확 분류 | 0/14 OSS | 13/14 OSS |
| Proprietary 정확 분류 | 6/6 (T3 정확) | 6/6 (T3 정확) |
| False positive | 0 | 0 |
| False negative | 14 (모든 OSS) | 1 (PortableGit or-later 의미 conflict) |
| 의미적 정확도 (or-later) | N/A | 13/14 정확, 1건 boilerplate stamp |

**v1.10e2 가치**: 추출률 0% → 70%. SPDX 헤더 도입률 낮은 (audit/A1 sample 0%) 현실에서 실용 추출률 큰 향상.

## 4. Edge case 5건 분석

### Edge 1 — Notion (헤더 부재 MIT)

```
Copyright (c) Electron contributors
Copyright (c) 2013-2020 GitHub Inc.

Permission is hereby granted, free of charge, to any person obtaining
...
```

**처리**: Header signal 부재 — body signal (`Permission... free of charge`) + copyright pattern fallback → MIT.

**audit/A1 §1 분기 적용**: `(header_signal OR (body_signal AND copyright_pattern))`.

### Edge 2 — ms-python.python (긴 preamble + MIT)

```
PLEASE NOTE: This is the license for the Python extension...

 - The Python Debugger extension is released under an MIT License: ...
 - The Pylance extension is only available in binary form...

------------------------------------------------------------------------------

Copyright (c) Microsoft Corporation. All rights reserved.

MIT License
...
```

**처리**: head -30 안에 `MIT License` @ L13 + `Permission... free of charge` @ L15 → MIT 정확 매칭.

**False positive risk**: preamble line 3 `released under an MIT License` — header signal regex `^[[:space:]]*(The )?MIT License`로 시작 anchor 적용 → match 안 됨 (preamble은 다른 어구로 시작). 안전.

### Edge 3 — ms-azuretools containers (`All rights reserved` + MIT 본문)

```
Container Tools for Visual Studio Code

Copyright (c) Microsoft Corporation

All rights reserved.

MIT License

Permission is hereby granted, free of charge,...
```

**처리**: `All rights reserved` 텍스트는 boilerplate 외 — MIT header `MIT License` @ L7 + body `Permission... free of charge` @ L9 → MIT 정확.

**중요**: `All rights reserved` 키워드만으로 proprietary 분류 시도 시 **false negative** (실제는 MIT). 본 v1.10e2는 negative signal 미사용 — header + body positive signal에만 의존.

### Edge 4 — ms-python.debugpy (들여쓰기 MIT)

```
    MIT License

    Copyright (c) Microsoft Corporation.

    Permission is hereby granted, free of charge,...
```

**처리**: header regex `^[[:space:]]*(The )?MIT License` — 시작 leading whitespace 허용 → 매칭. body 동일.

### Edge 5 — PortableGit GPL or-later 의미 conflict

```
 Note that the only valid version of the GPL as far as this project
 is concerned is _this_ particular version of the license (ie v2, not
 v2.2 or v3.x or whatever)...
... (line 22)
      GNU GENERAL PUBLIC LICENSE
         Version 2, June 1991
... (line 320)
    (at your option) any later version.
```

**처리**:

- T2 boilerplate stamp: `GPL-2.0-or-later` (body `any later version` 매칭)
- 사용자 의도: `GPL-2.0-only` (Linus 메모)

**한계**: bash grep으로 의미 추출 불가. boilerplate stamp이 항상 정확하지 않음.

**완화책**: INTERVIEW_FLOW.md `{{license}}` round-trip 한계 안내 + 사용자 SPDX 헤더 추가 권장 (T1 우선 매칭).

## 5. 본 repo (harness-meta) self-detect 검증

| 파일 | 기대 | T1 (SPDX) | T2 (boilerplate) |
|------|------|:---------:|:----------------:|
| `~/harness-meta/LICENSE` | MIT | ❌ (헤더 부재) | ✅ T2 매칭 → `MIT` |

→ **본 repo가 v1.10e2 자가 검증 fixture로 활용 가능** (smoke 추가 stage). 단 harness-meta는 bootstrap 대상 아님 — smoke fixture만.

## 6. v1.10e3 후속 동기

본 v1.10e2 한계:

- modified license (e.g. "MIT License (with attribution clause)") → false negative
- 신규/희귀 license (Boost, zlib, NCSA 등) → 미커버
- License 파일 없이 메타데이터만 명시 (npm `"license": "ISC"`) → 미커버

→ **v1.10e3** (메타데이터 license 필드) 후속 채택 시 추가 추출. 본 v1.10e2 evidence가 v1.10e3 동기.

## 7. 통합 결론

| 측면 | sample 결과 | 시사 |
|------|------------|------|
| T2 추출률 (OSS만) | 13/14 (93%) | 거의 모든 OSS 매칭 |
| T2 추출률 (전체) | 14/20 (70%) | proprietary 6건 정확 fallback |
| False positive | 0/20 | 안전 (header+body 2-신호 + start-anchor) |
| False negative (OSS) | 1/14 (or-later 의미) | bash grep 한계 — SPDX 헤더 권장 |
| Edge case 처리 | 5/5 | Notion / preamble / 들여쓰기 / All rights reserved / or-later 의미 |
| Recovery vs T1 | 0% → 70% | 매우 큰 향상 |

**v1.10e2 채택 정당성** (audit/A4 R1 입력):

- T1 only (v1.10e) sample 0% 한계 정량 증명
- T2 추가 시 70% 추출 + 0 false positive
- v1.10c observation 본질 유지 (사용자 LICENSE 콘텐츠 read, default stamp 강제 없음)
- 한계 1건 (or-later 의미) 명시 + 사용자 SPDX 헤더 권장으로 회복 경로 보장

→ **v1.10e2 채택 정당**. v1.10c 거부 결정 (injection)와 정합.
