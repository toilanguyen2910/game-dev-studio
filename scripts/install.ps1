#!/usr/bin/env pwsh
# =============================================================================
# Game Dev Studio - One-Command Installer (PowerShell)
# =============================================================================
# Detects platform and coding agents, installs skills to appropriate locations.
#
# Usage:
#   .\scripts\install.ps1               # Interactive install
#   .\scripts\install.ps1 -All          # Install to all detected platforms
#   .\scripts\install.ps1 -Help         # Show help
# =============================================================================

param(
    [switch]$All,
    [switch]$Help
)

if ($Help) {
    Get-Content $PSCommandPath | Select-Object -First 20 | ForEach-Object {
        if ($_ -match '^# (.+)$') { Write-Host $Matches[1] }
    }
    exit 0
}

$ProjectDir = Split-Path -Parent (Split-Path -Parent $PSCommandPath)
$SkillsDir = Join-Path $ProjectDir "skills"
$Installed = @()
$Skipped = @()

# ── Banner ───────────────────────────────────────────────────────────────────
Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  Game Dev Studio - Skill Installer                   ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# ── Detect OS ────────────────────────────────────────────────────────────────
$OS = "windows"
if ($IsLinux) { $OS = "linux" }
if ($IsMacOS)  { $OS = "macos" }

Write-Host "Detected OS: $OS" -ForegroundColor Yellow

# ── Detect agents ────────────────────────────────────────────────────────────
function Detect-Agents {
    $agents = @()

    # OpenClaw
    if (Get-Command "openclaw" -ErrorAction SilentlyContinue) {
        $agents += "openclaw"
        Write-Host "  $(✓) OpenClaw CLI detected"
    } else {
        Write-Host "  $(○) OpenClaw not found" -ForegroundColor Yellow
    }

    # Claude Code
    if (Get-Command "claude" -ErrorAction SilentlyContinue -or (Test-Path "$env:USERPROFILE\.claude")) {
        $agents += "claude"
        Write-Host "  $(✓) Claude Code detected"
    } else {
        Write-Host "  $(○) Claude Code not found" -ForegroundColor Yellow
    }

    # Codex CLI
    if ((Get-Command "codex" -ErrorAction SilentlyContinue) -or (Test-Path "$env:USERPROFILE\.codex")) {
        $agents += "codex"
        Write-Host "  $(✓) Codex CLI detected"
    } else {
        Write-Host "  $(○) Codex CLI not found" -ForegroundColor Yellow
    }

    # Gemini CLI
    if ((Get-Command "gemini" -ErrorAction SilentlyContinue) -or (Test-Path "$env:USERPROFILE\.gemini")) {
        $agents += "gemini"
        Write-Host "  $(✓) Gemini CLI detected"
    } else {
        Write-Host "  $(○) Gemini CLI not found" -ForegroundColor Yellow
    }

    # Cursor
    if ((Get-Command "cursor" -ErrorAction SilentlyContinue) -or (Test-Path "$env:USERPROFILE\.cursor")) {
        $agents += "cursor"
        Write-Host "  $(✓) Cursor detected"
    } else {
        Write-Host "  $(○) Cursor not found" -ForegroundColor Yellow
    }

    # Windsurf
    if ((Get-Command "windsurf" -ErrorAction SilentlyContinue) -or (Test-Path "$env:USERPROFILE\.windsurf")) {
        $agents += "windsurf"
        Write-Host "  $(✓) Windsurf detected"
    } else {
        Write-Host "  $(○) Windsurf not found" -ForegroundColor Yellow
    }

    # OpenCode
    if ((Get-Command "opencode" -ErrorAction SilentlyContinue) -or (Test-Path "$env:USERPROFILE\.opencode")) {
        $agents += "opencode"
        Write-Host "  $(✓) OpenCode detected"
    } else {
        Write-Host "  $(○) OpenCode not found" -ForegroundColor Yellow
    }

    return $agents
}

function Install-OpenClaw {
    $dest = "$env:USERPROFILE\.openclaw\workspace\skills"
    Write-Host "`nInstalling to OpenClaw..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force -Path $dest | Out-Null

    $count = 0
    Get-ChildItem $SkillsDir -Directory | ForEach-Object {
        $name = $_.Name
        Write-Host "  • $name ... " -NoNewline

        $skillDest = Join-Path $dest $name
        New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
        Copy-Item -Recurse -Path "$($_.FullName)\*" -Destination $skillDest -ErrorAction SilentlyContinue

        $skillFile = Join-Path $skillDest "SKILL.md"
        if (-not (Test-Path $skillFile)) {
            $readme = Join-Path $skillDest "README.md"
            if (Test-Path $readme) {
                Copy-Item -Path $readme -Destination $skillFile
                Write-Host "[SKILL.md from README] " -NoNewline
            } else {
                Set-Content -Path $skillFile -Value "# $name`n`n> Installed by game-dev-studio installer.`n"
                Write-Host "[SKILL.md created] " -NoNewline
            }
        }

        Write-Host "✓" -ForegroundColor Green
        $count++
    }

    $global:Installed += "OpenClaw ($count skills → $dest)"
    Write-Host "  → $count skills installed" -ForegroundColor Green
    Write-Host "  💡 Run: openclaw skills install" -ForegroundColor Yellow
}

function Install-ToDir {
    param([string]$AgentName, [string]$Dest)

    Write-Host "`nInstalling to $AgentName..." -ForegroundColor Cyan
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null

    $count = 0
    Get-ChildItem $SkillsDir -Directory | ForEach-Object {
        $name = $_.Name
        Write-Host "  • $name ... " -NoNewline

        $skillDest = Join-Path $Dest $name
        New-Item -ItemType Directory -Force -Path $skillDest | Out-Null
        Copy-Item -Recurse -Path "$($_.FullName)\*" -Destination $skillDest -ErrorAction SilentlyContinue

        Write-Host "✓" -ForegroundColor Green
        $count++
    }

    $global:Installed += "$AgentName ($count skills → $Dest)"
    Write-Host "  → $count skills installed" -ForegroundColor Green
}

function Select-Agents {
    $agentNames = @("openclaw", "claude", "codex", "gemini", "cursor", "windsurf", "opencode")
    $agentLabels = @("OpenClaw", "Claude Code", "Codex CLI", "Gemini CLI", "Cursor", "Windsurf", "OpenCode")

    Write-Host "`nSelect which coding agents to install skills for:" -ForegroundColor Yellow

    for ($i = 0; $i -lt $agentLabels.Length; $i++) {
        Write-Host "  [$($i+1)] $($agentLabels[$i])"
    }
    Write-Host "  [a] All"
    Write-Host "  [q] Quit"

    $input = Read-Host "`nEnter choices (comma-separated, e.g. 1,3,5)"
    $input = $input.ToLower()

    if ($input -eq "q") {
        Write-Host "Installation cancelled."
        exit 0
    }

    $choices = @()
    if ($input -eq "a") {
        $choices = $agentNames
    } else {
        $input -split ',' | ForEach-Object {
            $idx = $_.Trim() - 1
            if ($idx -ge 0 -and $idx -lt $agentNames.Length) {
                $choices += $agentNames[$idx]
            } else {
                Write-Host "Invalid choice: $_" -ForegroundColor Red
            }
        }
    }

    return $choices
}

# ── Main ─────────────────────────────────────────────────────────────────────
Write-Host "`nDetecting installed coding agents..." -ForegroundColor Cyan
$Agents = Detect-Agents
Write-Host ""

if ($All) {
    # Install to all
    foreach ($agent in $Agents) {
        switch ($agent) {
            "openclaw" { Install-OpenClaw }
            "claude"   { Install-ToDir "Claude Code"  "$env:USERPROFILE\.claude\skills" }
            "codex"    { Install-ToDir "Codex CLI"    "$env:USERPROFILE\.codex\skills" }
            "gemini"   { Install-ToDir "Gemini CLI"   "$env:USERPROFILE\.gemini\skills" }
            "cursor"   { Install-ToDir "Cursor"       "$env:USERPROFILE\.cursor\rules" }
            "windsurf" { Install-ToDir "Windsurf"     "$env:USERPROFILE\.windsurf\skills" }
            "opencode" { Install-ToDir "OpenCode"     "$env:USERPROFILE\.opencode\skills" }
        }
    }
} else {
    if ($Agents.Count -eq 0) {
        Write-Host "No coding agents detected on this system." -ForegroundColor Yellow
        Write-Host "You can still install manually:"
        Write-Host "  .\scripts\convert.ps1 -Tool <platform>"
        $answer = Read-Host "`nInstall to project-local directories anyway? [y/N]"
        if ($answer.ToLower() -ne "y") {
            Write-Host "Installation cancelled."
            exit 0
        }
        $Agents = @("openclaw", "claude", "codex", "gemini", "cursor", "windsurf", "opencode")
    }

    Write-Host "Detected agents:" -ForegroundColor Yellow
    foreach ($agent in $Agents) {
        Write-Host "  • $(Get-Culture).TextInfo.ToTitleCase($agent)"
    }

    $answer = Read-Host "`nInstall to all detected agents? [Y/n]"
    if ($answer.ToLower() -eq "n") {
        $Selected = Select-Agents
    } else {
        $Selected = $Agents
    }

    foreach ($agent in $Selected) {
        switch ($agent) {
            "openclaw" { Install-OpenClaw }
            "claude"   { Install-ToDir "Claude Code"  "$env:USERPROFILE\.claude\skills" }
            "codex"    { Install-ToDir "Codex CLI"    "$env:USERPROFILE\.codex\skills" }
            "gemini"   { Install-ToDir "Gemini CLI"   "$env:USERPROFILE\.gemini\skills" }
            "cursor"   { Install-ToDir "Cursor"       "$env:USERPROFILE\.cursor\rules" }
            "windsurf" { Install-ToDir "Windsurf"     "$env:USERPROFILE\.windsurf\skills" }
            "opencode" { Install-ToDir "OpenCode"     "$env:USERPROFILE\.opencode\skills" }
        }
    }
}

# ── Summary ──────────────────────────────────────────────────────────────────
Write-Host "`n╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║              Installation Complete                    ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

if ($Installed.Count -gt 0) {
    Write-Host "✅ Installed:" -ForegroundColor Green
    foreach ($entry in $Installed) {
        Write-Host "  • $entry"
    }
}

if ($Skipped.Count -gt 0) {
    Write-Host "⚠ Skipped:" -ForegroundColor Yellow
    foreach ($entry in $Skipped) {
        Write-Host "  • $entry"
    }
}

Write-Host "`n💡 Next steps:" -ForegroundColor Yellow
Write-Host "  • Verify installations in your coding agent"
Write-Host "  • Run '.\scripts\convert.ps1' for project-local copies"
Write-Host "  • See scripts\openclaw-install.md for OpenClaw-specific setup"

Write-Host "`nDone." -ForegroundColor Green
