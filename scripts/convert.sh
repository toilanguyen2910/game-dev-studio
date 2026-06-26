#!/usr/bin/env bash
# =============================================================================
# Game Dev Studio - Multi-Platform Conversion Script
# =============================================================================
# Converts game-dev-studio skills to work with multiple coding AI agents.
#
# Usage:
#   ./scripts/convert.sh                    # Convert to all platforms
#   ./scripts/convert.sh --tool openclaw    # Convert to one platform only
#   ./scripts/convert.sh --dry-run          # Show what would be done
#   ./scripts/convert.sh --help             # Show this help
#
# Supported platforms: openclaw, claude, codex, gemini, cursor, windsurf, opencode
# =============================================================================
#
# Windows (PowerShell) equivalent:
#   powershell -ExecutionPolicy Bypass -File scripts\convert.ps1
#   powershell -ExecutionPolicy Bypass -File scripts\convert.ps1 -Tool claude
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$PROJECT_DIR/skills"
DRY_RUN=false

# ── Help ─────────────────────────────────────────────────────────────────────
show_help() {
    sed -n 's/^# \?//p' "${BASH_SOURCE[0]}" | head -30
    exit 0
}

# ── Parse arguments ──────────────────────────────────────────────────────────
TARGET="all"
while [[ $# -gt 0 ]]; do
    case "$1" in
        --tool)   TARGET="$2"; shift ;;
        --dry-run) DRY_RUN=true ;;
        --help)   show_help ;;
        *)        echo "Unknown option: $1"; exit 1 ;;
    esac
    shift
done

# ── Initialize tracking ──────────────────────────────────────────────────────
declare -A CONVERTED
CONVERTED_COUNT=0
TOTAL_SKILLS=0

# ── Detect OS ────────────────────────────────────────────────────────────────
OS="linux"
[[ "$(uname)" == "Darwin" ]] && OS="macos"
[[ "$(uname -s)" =~ ^MINGW|^MSYS|^CYGWIN ]] && OS="windows"

# ── Helpers ──────────────────────────────────────────────────────────────────
run_cmd() {
    if [[ "$DRY_RUN" == true ]]; then
        echo "  [DRY-RUN] $*"
    else
        eval "$@"
    fi
}

convert_openclaw() {
    local src="$1" name="$2"
    local dest="$PROJECT_DIR/.openclaw/skills/$name"
    run_cmd mkdir -p "$(dirname "$dest")"
    run_cmd cp -r "$src" "$dest"
    # Ensure SKILL.md exists
    if [[ ! -f "$dest/SKILL.md" ]]; then
        local skill_name="${name//-/ }"
        skill_name="${skill_name^}"
        local readme="$src/README.md"
        if [[ -f "$readme" ]]; then
            run_cmd cp "$readme" "$dest/SKILL.md"
        else
            cat > "$dest/SKILL.md" <<-EOF
# $skill_name

> Auto-converted from game-dev-studio skills.

$(cat "$src/README.md" 2>/dev/null || echo "See source files in this directory.")
EOF
        fi
    fi
    CONVERTED["openclaw:$name"]="$dest"
}

convert_claude() {
    local src="$1" name="$2"
    local dest="$PROJECT_DIR/.claude/skills/$name"
    run_cmd mkdir -p "$(dirname "$dest")"
    run_cmd cp -r "$src" "$dest"
    # Claude Code uses SKILL.md with metadata header
    local header="$dest/SKILL.md"
    if [[ -f "$header" ]]; then
        local tmp="$dest/.tmp_skill.md"
        echo "---" > "$tmp"
        echo "name: $name" >> "$tmp"
        echo "version: 1.0.0" >> "$tmp"
        echo "source: game-dev-studio" >> "$tmp"
        echo "---" >> "$tmp"
        cat "$header" >> "$tmp"
        run_cmd mv "$tmp" "$header"
    fi
    CONVERTED["claude:$name"]="$dest"
}

convert_codex() {
    local src="$1" name="$2"
    local dest="$PROJECT_DIR/.codex/skills/$name"
    run_cmd mkdir -p "$(dirname "$dest")"
    # Codex CLI prefers flat SKILL.md
    run_cmd mkdir -p "$dest"
    local readme="$src/README.md"
    local skill_file="$src/SKILL.md"
    if [[ -f "$skill_file" ]]; then
        run_cmd cp "$skill_file" "$dest/SKILL.md"
    elif [[ -f "$readme" ]]; then
        run_cmd cp "$readme" "$dest/SKILL.md"
    else
        echo "# $name" > "$dest/SKILL.md"
        echo "Converted from game-dev-studio." >> "$dest/SKILL.md"
    fi
    # Copy support files
    for f in "$src"/*.md "$src"/*.json "$src"/*.yaml "$src"/*.yml 2>/dev/null; do
        [[ -f "$f" ]] && run_cmd cp "$f" "$dest/"
    done
    CONVERTED["codex:$name"]="$dest"
}

convert_gemini() {
    local src="$1" name="$2"
    local dest="$PROJECT_DIR/.gemini/skills/$name"
    run_cmd mkdir -p "$(dirname "$dest")"
    run_cmd cp -r "$src" "$dest"
    # Gemini expects a skill.yaml manifest
    local manifest="$dest/skill.yaml"
    if [[ ! -f "$manifest" ]]; then
        cat > "$manifest" <<-EOF
name: $name
version: 1.0.0
description: "Game dev studio skill: $name"
source: game-dev-studio
EOF
    fi
    CONVERTED["gemini:$name"]="$dest"
}

convert_cursor() {
    local src="$1" name="$2"
    local dest="$PROJECT_DIR/.cursor/rules/${name}.mdc"
    run_cmd mkdir -p "$(dirname "$dest")"
    # Cursor uses .mdc format with YAML frontmatter
    {
        echo "---"
        echo "description: Game dev studio rule: $name"
        echo "globs: *.cs,*.gd,*.cpp,*.h,*.py,*.js,*.ts"
        echo "---"
        echo ""
        echo "# $name"
        echo ""
        local readme="$src/README.md"
        local skill_file="$src/SKILL.md"
        if [[ -f "$skill_file" ]]; then
            cat "$skill_file" | sed '1s/^---.*---//s'
        elif [[ -f "$readme" ]]; then
            cat "$readme"
        else
            echo "Auto-converted from game-dev-studio skills/$name"
        fi
    } | run_cmd tee "$dest" > /dev/null
    CONVERTED["cursor:$name"]="$dest"
}

convert_windsurf() {
    local src="$1" name="$2"
    local dest="$PROJECT_DIR/.windsurf/skills/$name"
    run_cmd mkdir -p "$(dirname "$dest")"
    run_cmd cp -r "$src" "$dest"
    CONVERTED["windsurf:$name"]="$dest"
}

convert_opencode() {
    local src="$1" name="$2"
    local dest="$PROJECT_DIR/.opencode/skills/$name"
    run_cmd mkdir -p "$(dirname "$dest")"
    run_cmd cp -r "$src" "$dest"
    CONVERTED["opencode:$name"]="$dest"
}

# ── Convert all skills for a given platform ──────────────────────────────────
convert_platform() {
    local platform="$1"
    local count=0

    # Map platform to converter function
    local converter="convert_${platform}"
    if ! type "$converter" &>/dev/null; then
        echo "  [SKIP] Unknown platform: $platform"
        return
    fi

    echo ""
    echo "━━━ Converting to $platform ━━━"

    for skill_dir in "$SKILLS_DIR"/*/; do
        [[ -d "$skill_dir" ]] || continue
        local name
        name="$(basename "$skill_dir")"
        TOTAL_SKILLS=$((TOTAL_SKILLS + 1))
        echo "  • $name"
        "$converter" "$skill_dir" "$name"
        count=$((count + 1))
    done

    CONVERTED_COUNT=$((CONVERTED_COUNT + count))
    echo "  → $count skills converted for $platform"
}

# ── Print summary ────────────────────────────────────────────────────────────
print_summary() {
    echo ""
    echo "╔══════════════════════════════════════════════════════╗"
    echo "║           Conversion Complete                        ║"
    echo "╠══════════════════════════════════════════════════════╣"
    printf "║  Skills processed:   %-27d ║\n" "$TOTAL_SKILLS"
    printf "║  Platform runs:      %-27d ║\n" "$CONVERTED_COUNT"
    printf "║  Dry run:           %-27s ║\n" "$DRY_RUN"
    echo "╚══════════════════════════════════════════════════════╝"

    echo ""
    echo "📁 Converted locations:"
    for key in "${!CONVERTED[@]}"; do
        printf "  %-12s → %s\n" "[$key]" "${CONVERTED[$key]}"
    done
}

# ── Main ─────────────────────────────────────────────────────────────────────
echo "╔══════════════════════════════════════════════════════╗"
echo "║  Game Dev Studio - Skill Converter                   ║"
echo "║  Target: $TARGET                                   "
echo "╚══════════════════════════════════════════════════════╝"

case "$TARGET" in
    all)
        convert_platform "openclaw"
        convert_platform "claude"
        convert_platform "codex"
        convert_platform "gemini"
        convert_platform "cursor"
        convert_platform "windsurf"
        convert_platform "opencode"
        ;;
    *)
        convert_platform "$TARGET"
        ;;
esac

print_summary

# ── Windows (PowerShell) dual-function ──────────────────────────────────────
# If this script is detected as being run on Windows, this warning appears.
if [[ "$OS" == "windows" ]]; then
    echo ""
    echo "⚠  Windows detected. For best results, use the PowerShell equivalent:"
    echo "   powershell -ExecutionPolicy Bypass -File scripts/convert.ps1"
fi

echo ""
echo "✅ Done."
