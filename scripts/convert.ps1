#!/usr/bin/env pwsh
# =============================================================================
# Game Dev Studio - Multi-Platform Conversion Script (PowerShell)
# =============================================================================
# Converts game-dev-studio skills to work with multiple coding AI agents.
#
# Usage:
#   .\scripts\convert.ps1                          # Convert to all platforms
#   .\scripts\convert.ps1 -Tool claude             # Convert to one platform
#   .\scripts\convert.ps1 -DryRun                  # Show what would be done
#   .\scripts\convert.ps1 -Help                    # Show help
#
# Supported platforms: openclaw, claude, codex, gemini, cursor, windsurf, opencode
#
# Cross-platform note: On Linux/Mac, use:
#   pwsh scripts/convert.ps1
# =============================================================================

param(
    [string]$Tool = "all",
    [switch]$DryRun,
    [switch]$Help
)

if ($Help) {
    Get-Content $PSCommandPath | Select-Object -First 30 | ForEach-Object {
        if ($_ -match '^# (.+)$') { Write-Host $Matches[1] }
    }
    exit 0
}

$ProjectDir = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
$SkillsDir = Join-Path $ProjectDir "skills"
$Converted = @{}
$ConvertedCount = 0
$TotalSkills = 0

function Run-Cmd {
    param([string]$Command)
    if ($DryRun) {
        Write-Host "  [DRY-RUN] $Command" -ForegroundColor Yellow
    } else {
        Invoke-Expression $Command
    }
}

function Convert-OpenClaw {
    param([string]$Src, [string]$Name)
    $Dest = Join-Path $ProjectDir ".openclaw\skills\$Name"
    Run-Cmd "New-Item -ItemType Directory -Force -Path '$Dest' | Out-Null"
    Run-Cmd "Copy-Item -Recurse -Path '$Src\*' -Destination '$Dest'"

    $SkillFile = Join-Path $Dest "SKILL.md"
    if (-not (Test-Path $SkillFile)) {
        $Readme = Join-Path $Src "README.md"
        if (Test-Path $Readme) {
            Run-Cmd "Copy-Item -Path '$Readme' -Destination '$SkillFile'"
        } else {
            $Content = "# $Name`n`n> Auto-converted from game-dev-studio skills.`n"
            Set-Content -Path $SkillFile -Value $Content
        }
    }
    $Converted["openclaw:$Name"] = $Dest
}

function Convert-Claude {
    param([string]$Src, [string]$Name)
    $Dest = Join-Path $ProjectDir ".claude\skills\$Name"
    Run-Cmd "New-Item -ItemType Directory -Force -Path '$Dest' | Out-Null"
    Run-Cmd "Copy-Item -Recurse -Path '$Src\*' -Destination '$Dest'"

    $SkillFile = Join-Path $Dest "SKILL.md"
    if (Test-Path $SkillFile) {
        $Content = Get-Content $SkillFile -Raw
        $Header = @"
---
name: $Name
version: 1.0.0
source: game-dev-studio
---
"@
        Set-Content -Path $SkillFile -Value "$Header`n$Content"
    }
    $Converted["claude:$Name"] = $Dest
}

function Convert-Codex {
    param([string]$Src, [string]$Name)
    $Dest = Join-Path $ProjectDir ".codex\skills\$Name"
    Run-Cmd "New-Item -ItemType Directory -Force -Path '$Dest' | Out-Null"

    $Readme = Join-Path $Src "README.md"
    $SkillFile = Join-Path $Src "SKILL.md"
    $DestSkill = Join-Path $Dest "SKILL.md"

    if (Test-Path $SkillFile) {
        Run-Cmd "Copy-Item -Path '$SkillFile' -Destination '$DestSkill'"
    } elseif (Test-Path $Readme) {
        Run-Cmd "Copy-Item -Path '$Readme' -Destination '$DestSkill'"
    } else {
        Set-Content -Path $DestSkill -Value "# $Name`nConverted from game-dev-studio."
    }

    # Copy supporting files
    Get-ChildItem -Path $Src -Include "*.md","*.json","*.yaml","*.yml" -File | ForEach-Object {
        Run-Cmd "Copy-Item -Path '$($_.FullName)' -Destination '$Dest\'"
    }
    $Converted["codex:$Name"] = $Dest
}

function Convert-Gemini {
    param([string]$Src, [string]$Name)
    $Dest = Join-Path $ProjectDir ".gemini\skills\$Name"
    Run-Cmd "New-Item -ItemType Directory -Force -Path '$Dest' | Out-Null"
    Run-Cmd "Copy-Item -Recurse -Path '$Src\*' -Destination '$Dest'"

    $Manifest = Join-Path $Dest "skill.yaml"
    if (-not (Test-Path $Manifest)) {
        $Yaml = @"
name: $Name
version: 1.0.0
description: "Game dev studio skill: $Name"
source: game-dev-studio
"@
        Set-Content -Path $Manifest -Value $Yaml
    }
    $Converted["gemini:$Name"] = $Dest
}

function Convert-Cursor {
    param([string]$Src, [string]$Name)
    $Dest = Join-Path $ProjectDir ".cursor\rules\$Name.mdc"
    Run-Cmd "New-Item -ItemType Directory -Force -Path '$(Split-Path $Dest)' | Out-Null"

    $Readme = Join-Path $Src "README.md"
    $SkillFile = Join-Path $Src "SKILL.md"

    $Body = if (Test-Path $SkillFile) {
        (Get-Content $SkillFile -Raw) -replace '(?s)^---.*?---', ''
    } elseif (Test-Path $Readme) {
        Get-Content $Readme -Raw
    } else {
        "Auto-converted from game-dev-studio skills/$Name"
    }

    $Content = @"
---
description: Game dev studio rule: $Name
globs: *.cs,*.gd,*.cpp,*.h,*.py,*.js,*.ts
---

# $Name

$Body
"@
    Set-Content -Path $Dest -Value $Content
    $Converted["cursor:$Name"] = $Dest
}

function Convert-Windsurf {
    param([string]$Src, [string]$Name)
    $Dest = Join-Path $ProjectDir ".windsurf\skills\$Name"
    Run-Cmd "New-Item -ItemType Directory -Force -Path '$Dest' | Out-Null"
    Run-Cmd "Copy-Item -Recurse -Path '$Src\*' -Destination '$Dest'"
    $Converted["windsurf:$Name"] = $Dest
}

function Convert-OpenCode {
    param([string]$Src, [string]$Name)
    $Dest = Join-Path $ProjectDir ".opencode\skills\$Name"
    Run-Cmd "New-Item -ItemType Directory -Force -Path '$Dest' | Out-Null"
    Run-Cmd "Copy-Item -Recurse -Path '$Src\*' -Destination '$Dest'"
    $Converted["opencode:$Name"] = $Dest
}

function Convert-Platform {
    param([string]$Platform)
    $Converter = "Convert-$Platform"
    $Count = 0

    Write-Host "`n━━━ Converting to $Platform ━━━" -ForegroundColor Cyan

    Get-ChildItem $SkillsDir -Directory | ForEach-Object {
        $Name = $_.Name
        $global:TotalSkills++
        Write-Host "  • $Name"
        & $Converter $_.FullName $Name
        $Count++
    }

    $global:ConvertedCount += $Count
    Write-Host "  → $Count skills converted for $Platform" -ForegroundColor Green
}

function Print-Summary {
    Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║           Conversion Complete                        ║" -ForegroundColor Cyan
    Write-Host "╠══════════════════════════════════════════════════════╣" -ForegroundColor Cyan
    Write-Host "║  Skills processed:  $TotalSkills".PadRight(42) + "║" -ForegroundColor Cyan
    Write-Host "║  Platform runs:     $ConvertedCount".PadRight(42) + "║" -ForegroundColor Cyan
    Write-Host "║  Dry run:           $DryRun".PadRight(42) + "║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan

    Write-Host "`n📁 Converted locations:" -ForegroundColor Yellow
    foreach ($key in $Converted.Keys) {
        Write-Host "  [$key] → $($Converted[$key])"
    }
}

# ── Main ─────────────────────────────────────────────────────────────────────
Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Game Dev Studio - Skill Converter                   ║" -ForegroundColor Cyan
Write-Host "║  Platform: $((Get-CimInstance Win32_OperatingSystem).Caption 2>$null ?? 'Unknown')   " -ForegroundColor Cyan
Write-Host "║  Target:   $Tool                                       " -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan

switch ($Tool.ToLower()) {
    "all" {
        Convert-Platform "OpenClaw"
        Convert-Platform "Claude"
        Convert-Platform "Codex"
        Convert-Platform "Gemini"
        Convert-Platform "Cursor"
        Convert-Platform "Windsurf"
        Convert-Platform "OpenCode"
    }
    default {
        Convert-Platform $Tool
    }
}

Print-Summary
Write-Host "`n✅ Done." -ForegroundColor Green
