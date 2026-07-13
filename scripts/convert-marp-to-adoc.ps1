param(
    [string]$Root = (Join-Path $PSScriptRoot '..\doc')
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Convert-InlineText {
    param([string]$Text)

    $Text = [regex]::Replace($Text, '!\[([^\]]*)\]\(([^)]+)\)', {
        param($m)
        "image::$($m.Groups[2].Value)[$($m.Groups[1].Value)]"
    })

    $Text = [regex]::Replace($Text, '\[([^\]]+)\]\((https?://[^)]+|[^)]+)\)', {
        param($m)
        "link:$($m.Groups[2].Value)[$($m.Groups[1].Value)]"
    })

    $Text = [regex]::Replace($Text, '`([^`]+)`', {
        param($m)
        "+$($m.Groups[1].Value)+"
    })

    $Text = [regex]::Replace($Text, '\*\*([^*]+)\*\*', {
        param($m)
        "*$($m.Groups[1].Value)*"
    })

    $Text = [regex]::Replace($Text, '<i>(.*?)</i>', {
        param($m)
        "_$($m.Groups[1].Value)_"
    }, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

    $Text = [regex]::Replace($Text, '<b>(.*?)</b>', {
        param($m)
        "*$($m.Groups[1].Value)*"
    }, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)

    return $Text
}

function Get-DocumentTitle {
    param(
        [string[]]$Lines,
        [string]$Fallback
    )

    $title = $null
    $bodyStart = 0

    if ($Lines.Count -gt 0 -and $Lines[0].Trim() -eq '---') {
        for ($i = 1; $i -lt $Lines.Count; $i++) {
            if ($Lines[$i].Trim() -eq '---') {
                for ($j = 1; $j -lt $i; $j++) {
                    if ($Lines[$j] -match '^\s*title\s*:\s*(.+)\s*$') {
                        $title = $matches[1].Trim()
                        break
                    }
                }
                $bodyStart = $i + 1
                break
            }
        }
    }

    if (-not $title) {
        for ($k = $bodyStart; $k -lt $Lines.Count; $k++) {
            if ($Lines[$k] -match '^\s*#{1,6}\s+(.*\S)\s*$') {
                $title = $matches[1].Trim()
                break
            }
        }
    }

    if (-not $title) {
        $title = $Fallback -replace '\.marp$', '' -replace '_', ' '
    }

    return (Convert-InlineText $title)
}

function Convert-MarpFile {
    param([System.IO.FileInfo]$File)

    $raw = Get-Content -LiteralPath $File.FullName -Raw -Encoding UTF8
    $lines = $raw -split "`r?`n"
    $title = Get-DocumentTitle -Lines $lines -Fallback $File.BaseName

    $output = New-Object System.Collections.Generic.List[string]
    $output.Add("= $title")
    $output.Add(':revealjsdir: https://cdn.jsdelivr.net/npm/reveal.js@5')
    $output.Add(':revealjs_theme: white')
    $output.Add(':revealjs_controls: true')
    $output.Add(':revealjs_slideNumber: true')
    $output.Add(':imagesdir: .')
    $output.Add(':icons: font')
    $output.Add(':sectnums: false')
    $output.Add(':source-highlighter: highlightjs')
    $output.Add('')

    $inFrontMatter = $false
    $frontMatterDone = $false
    $inCode = $false

    foreach ($line in $lines) {
        if (-not $frontMatterDone -and $line.Trim() -eq '---') {
            if (-not $inFrontMatter) {
                $inFrontMatter = $true
            } else {
                $frontMatterDone = $true
                $inFrontMatter = $false
            }
            continue
        }

        if ($inFrontMatter -and -not $frontMatterDone) {
            continue
        }

        if ($line -match '^\s*```(\w+)?\s*$') {
            if (-not $inCode) {
                $inCode = $true
                $lang = $matches[1]
                if ($lang) {
                    $output.Add("[source,$lang]")
                } else {
                    $output.Add('[source]')
                }
                $output.Add('----')
            } else {
                $inCode = $false
                $output.Add('----')
                $output.Add('')
            }
            continue
        }

        if ($inCode) {
            $output.Add($line)
            continue
        }

        if ($line.Trim() -eq '---') {
            if ($output.Count -gt 0 -and $output[$output.Count - 1] -ne '') {
                $output.Add('')
            }
            $output.Add('---')
            $output.Add('')
            continue
        }

        if ($line -match '^(#{1,6})\s+(.*\S)\s*$') {
            $asciidocLevel = '=='
            $text = Convert-InlineText $matches[2].Trim()
            $output.Add("$asciidocLevel $text")
            continue
        }

        $output.Add((Convert-InlineText $line))
    }

    $target = $File.FullName -replace '\.marp\.md$', '.adoc'
    Set-Content -LiteralPath $target -Value ($output -join "`r`n") -Encoding UTF8
    return $target
}

$rootPath = (Resolve-Path $Root).Path
$marpFiles = Get-ChildItem -LiteralPath $rootPath -Recurse -File -Filter '*.marp.md'
$converted = New-Object System.Collections.Generic.List[string]

foreach ($file in $marpFiles) {
    $converted.Add((Convert-MarpFile -File $file))
}

Get-ChildItem -LiteralPath $rootPath -Recurse -File -Filter '*.md' |
    Where-Object { $_.Name -notlike '*.marp.md' } |
    ForEach-Object {
        $text = Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8
        $updated = $text -replace '\.marp\.md\b', '.adoc'
        if ($updated -ne $text) {
            Set-Content -LiteralPath $_.FullName -Value $updated -Encoding UTF8
        }
    }

foreach ($file in $marpFiles) {
    Remove-Item -LiteralPath $file.FullName
}

Write-Host "Converted $($converted.Count) Marp files to AsciiDoc."
