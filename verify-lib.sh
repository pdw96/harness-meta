#!/usr/bin/env bash
# harness-meta verify library — install.sh / verify.sh 공유 함수 (bash 4+)
# source: . "$(dirname "${BASH_SOURCE[0]}")/verify-lib.sh"

# test_symlink_integrity — Symlink 무결성 체크
# Args:
#   $1: path           (검사할 파일 경로)
#   $2: meta_root      (선택. 비어있으면 MetaRoot 하위 검증 skip)
#   $3: expected_target (선택. 비어있으면 target 일치 검증 skip)
# Returns:
#   0: OK
#   1: 실패 (stdout에 사유: NotASymlink / target_not_exist:<t> / target_mismatch:<t> (expected:<e>) / target_outside_meta:<t> (meta:<m>))
test_symlink_integrity() {
    local path="$1"
    local meta_root="${2:-}"
    local expected_target="${3:-}"

    if [ ! -L "$path" ]; then
        echo "LinkType=NotASymlink"
        return 1
    fi

    local target
    target=$(python3 -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$path" 2>/dev/null)
    if [ -z "$target" ] || [ ! -e "$target" ]; then
        echo "target_not_exist:$target"
        return 1
    fi

    if [ -n "$expected_target" ]; then
        local exp_norm
        exp_norm=$(python3 -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$expected_target" 2>/dev/null)
        if [ "$target" != "$exp_norm" ]; then
            echo "target_mismatch:$target (expected:$exp_norm)"
            return 1
        fi
    fi

    if [ -n "$meta_root" ]; then
        local meta_norm
        meta_norm=$(python3 -c "import os, sys; print(os.path.realpath(sys.argv[1]))" "$meta_root" 2>/dev/null)
        case "$target" in
            "$meta_norm"/*) ;;
            *)
                echo "target_outside_meta:$target (meta:$meta_norm)"
                return 1
                ;;
        esac
    fi

    return 0
}
