# harness-meta verify library — install.ps1 / verify.ps1 공유 함수
# dot-source: . (Join-Path $PSScriptRoot 'verify-lib.ps1')

function Test-SymlinkIntegrity {
    <#
    .SYNOPSIS
        Symlink 무결성 체크 — LinkType=SymbolicLink + Target 실존 + (옵션) MetaRoot 하위 or ExpectedTarget 일치.

    .OUTPUTS
        pscustomobject: Ok (bool), Reason (string), LinkType, Target
    #>
    param(
        [Parameter(Mandatory)][string]$Path,
        [string]$MetaRoot,
        [string]$ExpectedTarget
    )

    if (-not (Test-Path $Path)) {
        return [pscustomobject]@{ Ok = $false; Reason = "파일 없음"; LinkType = $null; Target = $null }
    }

    $item = Get-Item $Path -Force

    if ($item.LinkType -ne 'SymbolicLink') {
        return [pscustomobject]@{
            Ok = $false
            Reason = "LinkType='$($item.LinkType)' (SymbolicLink 아님 — Junction/ReparsePoint 단독 불허)"
            LinkType = $item.LinkType
            Target = $item.Target
        }
    }

    if (-not $item.Target -or -not (Test-Path $item.Target)) {
        return [pscustomobject]@{
            Ok = $false
            Reason = "target 실존 X: '$($item.Target)'"
            LinkType = $item.LinkType
            Target = $item.Target
        }
    }

    if ($ExpectedTarget -and ($item.Target -ne $ExpectedTarget)) {
        return [pscustomobject]@{
            Ok = $false
            Reason = "target 불일치: '$($item.Target)' (기대: '$ExpectedTarget')"
            LinkType = $item.LinkType
            Target = $item.Target
        }
    }

    if ($MetaRoot) {
        $sep = [IO.Path]::DirectorySeparatorChar
        $prefix = $MetaRoot.TrimEnd($sep) + $sep
        if (-not $item.Target.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
            return [pscustomobject]@{
                Ok = $false
                Reason = "target이 MetaRoot 밖: '$($item.Target)' (MetaRoot='$MetaRoot')"
                LinkType = $item.LinkType
                Target = $item.Target
            }
        }
    }

    return [pscustomobject]@{ Ok = $true; Reason = "OK"; LinkType = $item.LinkType; Target = $item.Target }
}
