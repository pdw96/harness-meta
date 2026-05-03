"""categories_type_safety.py — 타입 안전성 카테고리

score_type_safety: Python/TypeScript 타입 힌트 / mypy / 스키마 / Protocol.
v1.56-quality-file-split에서 categories_quality.py 분할.
"""

from __future__ import annotations

from pathlib import Path

from utils import (
    Check,
    file_content,
    file_exists_any,
    is_small_typed_lang_repo,
    python_type_hint_ratio,
)


def score_type_safety(repo: Path, tracked: list[Path], lang: str) -> list[Check]:
    checks: list[Check] = []
    small_repo = is_small_typed_lang_repo(repo, tracked, lang)

    if lang == "Python":
        py_files = [f for f in tracked if f.suffix == ".py" and f.is_file()]
        ratio = python_type_hint_ratio(py_files)
        score = 5 if ratio >= 0.7 else (3 if ratio >= 0.4 else (1 if ratio > 0.1 else 0))
        if not (ratio >= 0.4) and small_repo:
            checks.append(Check(
                "타입 힌트 커버리지",
                True, 5, 5,
                "N/A — Python 소스 5개 미만 (타입 힌트 부적합, 자동 만점)",
                None, "즉시", 2.5, na=True
            ))
        else:
            checks.append(Check(
                "타입 힌트 커버리지",
                ratio >= 0.4, score, 5,
                f"함수 {ratio:.0%} 타입 힌트 보유",
                None if ratio >= 0.4 else "모든 public 함수에 인자·반환 타입 힌트 추가 (mypy strict 권장)",
                "중기", 2.5
            ))

        # mypy / pyright 설정
        mypy_conf, fname = file_exists_any(repo, [
            "mypy.ini", ".mypy.ini", "pyproject.toml"
        ])
        mypy_active = False
        if mypy_conf:
            content = file_content(repo / fname)
            mypy_active = "[mypy]" in content or "mypy" in content.lower()
        if not mypy_active and small_repo:
            checks.append(Check(
                "mypy / pyright 설정",
                True, 3, 3,
                "N/A — Python 소스 5개 미만 (정적 타입 체크 부적합, 자동 만점)",
                None, "즉시", 2.0, na=True
            ))
        else:
            checks.append(Check(
                "mypy / pyright 설정",
                mypy_active, 3 if mypy_active else 0, 3,
                "설정 있음" if mypy_active else "정적 타입 체크 미설정",
                None if mypy_active else "pyproject.toml에 [tool.mypy] strict 설정 추가",
                "즉시", 2.0
            ))

        # pydantic / dataclass / TypedDict
        schema_patterns = ["pydantic", "dataclass", "TypedDict", "attrs", "msgspec"]
        schema_found = any(
            any(p in file_content(f) for p in schema_patterns)
            for f in py_files[:50]
        )
        if not schema_found and small_repo:
            checks.append(Check(
                "스키마 정의 (Pydantic/dataclass)",
                True, 4, 4,
                "N/A — Python 소스 5개 미만 (스키마 정의 부적합, 자동 만점)",
                None, "단기", 2.0, na=True
            ))
        else:
            checks.append(Check(
                "스키마 정의 (Pydantic/dataclass)",
                schema_found, 4 if schema_found else 0, 4,
                "스키마 라이브러리 사용 중" if schema_found else "구조화된 데이터 모델 미사용",
                None if schema_found else "API 입출력·설정·이벤트에 Pydantic 모델 또는 dataclass 적용",
                "단기", 2.0
            ))

        # Protocol / ABC
        protocol_found = any("Protocol" in file_content(f) or "ABC" in file_content(f) for f in py_files[:50])
        if not protocol_found and small_repo:
            checks.append(Check(
                "인터페이스 정의 (Protocol/ABC)",
                True, 3, 3,
                "N/A — Python 소스 5개 미만 (인터페이스 정의 부적합, 자동 만점)",
                None, "중기", 1.5, na=True
            ))
        else:
            checks.append(Check(
                "인터페이스 정의 (Protocol/ABC)",
                protocol_found, 3 if protocol_found else 0, 3,
                "Protocol/ABC 사용 중" if protocol_found else "인터페이스 계약 미정의",
                None if protocol_found else "모듈 경계에 Protocol 또는 ABC로 인터페이스 계약 정의",
                "중기", 1.5
            ))

    elif lang in ("TypeScript",):
        # tsconfig
        tsconfig, fname = file_exists_any(repo, ["tsconfig.json", "tsconfig.base.json"])
        if not tsconfig and small_repo:
            checks.append(Check("tsconfig.json (strict)", True, 5, 5,
                                "N/A — TypeScript 소스 5개 미만 (tsconfig 부적합, 자동 만점)",
                                None, "즉시", 2.5, na=True))
        else:
            checks.append(Check("tsconfig.json (strict)", tsconfig, 5 if tsconfig else 0, 5,
                                f"발견: {fname}" if tsconfig else "없음",
                                None if tsconfig else "tsconfig.json strict 모드 활성화",
                                "즉시", 2.5))
        # zod / io-ts
        ts_files = [f for f in tracked if f.suffix in {".ts", ".tsx"} and f.is_file()]
        schema = any("zod" in file_content(f) or "io-ts" in file_content(f) for f in ts_files[:50])
        if not schema and small_repo:
            checks.append(Check("런타임 스키마 (zod/io-ts)", True, 7, 7,
                                "N/A — TypeScript 소스 5개 미만 (런타임 스키마 부적합, 자동 만점)",
                                None, "단기", 2.0, na=True))
        else:
            checks.append(Check("런타임 스키마 (zod/io-ts)", schema, 7 if schema else 0, 7,
                                "런타임 검증 라이브러리 사용 중" if schema else "런타임 타입 검증 없음",
                                None if schema else "경계 레이어(API/외부입력)에 zod 스키마 적용",
                                "단기", 2.0))
        checks.append(Check("타입 시스템 상세 분석", True, 3, 3,
                            "TypeScript — 기본 점수 부여", None))

    else:
        checks.append(Check(
            f"{lang} 타입 시스템",
            True, 10, 15,
            f"{lang} — 정적 분석 skip (부분 점수 부여)", None
        ))
        checks.append(Check("스키마 정의", True, 5, 5,
                            f"{lang} — 부분 점수 부여", None))

    return checks
