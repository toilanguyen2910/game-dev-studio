#!/usr/bin/env bash
# =============================================================================
# Game Dev Studio - One-Command Installer
# =============================================================================
# Detects platform and coding agents, installs skills to appropriate locations.
#
# Usage:
#   bash scripts/install.sh            # Interactive install
#   bash scripts/install.sh --all      # Install to all detected platforms
#   bash scripts/install.sh --help     # Show help
#
# Windows:
#   powershell -ExecutionPolicy Bypass -File scripts\install.ps1
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_DIR="$PROJECT_DIR/skills"
INSTALL_ALL=false
INSTALLED=()
SKIPPED=()

# ── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ── Help ─────────────────────────────────────────────────────────────────────
if [[ "${1:-}" == "--help" ]]; then
    head -30 "${BASH_SOURCE[0]}" | sed 's/^# \?//'
    exit 0
fi

if [[ "${1:-}" == "--all" ]]; then
    INSTALL_ALL=true
fi

# ── Banner ───────────────────────────────────────────────────────────────────
echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║  Game Dev Studio - Skill Installer                   ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# ── Detect OS ────────────────────────────────────────────────────────────────
detect_os() {
    case "$(uname -s)" in
        Linux*)   echo "linux" ;;
        Darwin*)  echo "macos" ;;
        MINGW*|MSYS*|CYGWIN*) echo "windows" ;;
        *)        echo "unknown" ;;
    esac
}

OS="$(detect_os)"
echo -e "${YELLOW}Detected OS:${NC} $OS"

# ── Detect coding agents (check common install paths) ────────────────────────
detect_agents() {
    local agents=()

    # OpenClaw
    if command -v openclaw &>/dev/null; then
        agents+=("openclaw")
        echo -e "  ${GREEN}✓${NC} OpenClaw CLI detected"
    else
        echo -e "  ${YELLOW}○${NC} OpenClaw not found"
    fi

    # Claude Code
    if command -v claude &>/dev/null; then
        agents+=("claude")
        echo -e "  ${GREEN}✓${NC} Claude Code detected"
    elif [[ -d "$HOME/.claude" ]]; then
        agents+=("claude")
        echo -e "  ${GREEN}✓${NC} Claude config directory found"
    else
        echo -e "  ${YELLOW}○${NC} Claude Code not found"
    fi

    # Codex CLI
    if command -v codex &>/dev/null || [[ -d "$HOME/.codex" ]]; then
        agents+=("codex")
        echo -e "  ${GREEN}✓${NC} Codex CLI detected"
    else
        echo -e "  ${YELLOW}○${NC} Codex CLI not found"
    fi

    # Gemini CLI
    if command -v gemini &>/dev/null || [[ -d "$HOME/.gemini" ]]; then
        agents+=("gemini")
        echo -e "  ${GREEN}✓${NC} Gemini CLI detected"
    else
        echo -e "  ${YELLOW}○${NC} Gemini CLI not found"
    fi

    # Cursor
    if command -v cursor &>/dev/null || [[ -d "$HOME/.cursor" ]]; then
        agents+=("cursor")
        echo -e "  ${GREEN}✓${NC} Cursor detected"
    else
        echo -e "  ${YELLOW}○${NC} Cursor not found"
    fi

    # Windsurf
    if command -v windsurf &>/dev/null || [[ -d "$HOME/.windsurf" ]]; then
        agents+=("windsurf")
        echo -e "  ${GREEN}✓${NC} Windsurf detected"
    else
        echo -e "  ${YELLOW}○${NC} Windsurf not found"
    fi

    # OpenCode
    if command -v opencode &>/dev/null || [[ -d "$HOME/.opencode" ]]; then
        agents+=("opencode")
        echo -e "  ${GREEN}✓${NC} OpenCode detected"
    else
        echo -e "  ${YELLOW}○${NC} OpenCode not found"
    fi

    echo ""
    echo "${agents[@]}"
}

# ── Install functions ────────────────────────────────────────────────────────
install_openclaw() {
    local dest="$HOME/.openclaw/workspace/skills"
    echo -e "\n${CYAN}Installing to OpenClaw...${NC}"
    mkdir -p "$dest"

    local count=0
    for skill_dir in "$SKILLS_DIR"/*/; do
        [[ -d "$skill_dir" ]] || continue
        local name
        name="$(basename "$skill_dir")"
        echo -n "  • $name ... "

        local skill_dest="$dest/$name"
        mkdir -p "$skill_dest"
        cp -r "$skill_dir"/* "$skill_dest"/ 2>/dev/null

        # Ensure SKILL.md exists
        if [[ ! -f "$skill_dest/SKILL.md" ]]; then
            if [[ -f "$skill_dest/README.md" ]]; then
                cp "$skill_dest/README.md" "$skill_dest/SKILL.md"
                echo -n "[SKILL.md from README] "
            else
                cat > "$skill_dest/SKILL.md" <<-EOF
# $name

> Installed by game-dev-studio installer.
EOF
                echo -n "[SKILL.md created] "
            fi
        fi

        echo -e "${GREEN}✓${NC}"
        count=$((count + 1))
    done

    INSTALLED+=("OpenClaw ($count skills → $dest)")
    echo -e "${GREEN}  → $count skills installed${NC}"

    # Suggest openclaw skills install
    echo -e "${YELLOW}  💡 Run: openclaw skills install${NC}"
}

install_to_dir() {
    local agent_name="$1"
    local dest="${2:-$HOME/.$agent_name/skills}"

    echo -e "\n${CYAN}Installing to ${agent_name^}...${NC}"
    mkdir -p "$dest"

    local count=0
    for skill_dir in "$SKILLS_DIR"/*/; do
        [[ -d "$skill_dir" ]] || continue
        local name
        name="$(basename "$skill_dir")"
        echo -n "  • $name ... "
        mkdir -p "$dest/$name"
        cp -r "$skill_dir"/* "$dest/$name"/ 2>/dev/null
        echo -e "${GREEN}✓${NC}"
        count=$((count + 1))
    done

    INSTALLED+=("${agent_name^} ($count skills → $dest)")
    echo -e "${GREEN}  → $count skills installed${NC}"
}

# ── Interactive selection ────────────────────────────────────────────────────
select_agents() {
    echo ""
    echo -e "${YELLOW}Select which coding agents to install skills for:${NC}"

    local choices=()
    local i=1
    local agent_names=("openclaw" "claude" "codex" "gemini" "cursor" "windsurf" "opencode")
    local agent_labels=("OpenClaw" "Claude Code" "Codex CLI" "Gemini CLI" "Cursor" "Windsurf" "OpenCode")

    for label in "${agent_labels[@]}"; do
        echo "  [$i] ${label}"
        i=$((i + 1))
    done
    echo "  [a] All"
    echo "  [q] Quit"
    echo ""

    read -rp "Enter choices (comma-separated, e.g. 1,3,5): " raw_input
    raw_input="${raw_input,,}"  # lowercase

    if [[ "$raw_input" == "q" ]]; then
        echo "Installation cancelled."
        exit 0
    fi

    if [[ "$raw_input" == "a" ]]; then
        choices=("openclaw" "claude" "codex" "gemini" "cursor" "windsurf" "opencode")
    else
        IFS=',' read -ra indices <<< "$raw_input"
        for idx in "${indices[@]}"; do
            idx="$(echo "$idx" | xargs)"  # trim
            local pos=$((idx - 1))
            if [[ $pos -ge 0 && $pos -lt ${#agent_names[@]} ]]; then
                choices+=("${agent_names[$pos]}")
            else
                echo -e "${RED}Invalid choice: $idx${NC}"
            fi
        done
    fi

    echo "${choices[@]}"
}

# ── Main ─────────────────────────────────────────────────────────────────────
echo ""
echo -e "${CYAN}🔍 Detecting installed coding agents...${NC}"

AGENTS=($(detect_agents))
echo ""

if [[ "$INSTALL_ALL" == true ]]; then
    # Install to all detected agents
    for agent in "${AGENTS[@]}"; do
        case "$agent" in
            openclaw) install_openclaw ;;
            claude)   install_to_dir "claude"   "$HOME/.claude/skills" ;;
            codex)    install_to_dir "codex"    "$HOME/.codex/skills" ;;
            gemini)   install_to_dir "gemini"   "$HOME/.gemini/skills" ;;
            cursor)   install_to_dir "cursor"   "$HOME/.cursor/rules" ;;
            windsurf) install_to_dir "windsurf" "$HOME/.windsurf/skills" ;;
            opencode) install_to_dir "opencode" "$HOME/.opencode/skills" ;;
        esac
    done
else
    # Interactive selection
    if [[ ${#AGENTS[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No coding agents detected on this system.${NC}"
        echo "You can still install manually:"
        echo "  bash scripts/convert.sh --tool <platform>"
        echo ""
        read -rp "Install all to project-local directories anyway? [y/N] " answer
        if [[ "${answer,,}" != "y" ]]; then
            echo "Installation cancelled."
            exit 0
        fi
        AGENTS=("openclaw" "claude" "codex" "gemini" "cursor" "windsurf" "opencode")
    fi

    echo -e "${YELLOW}Detected agents:${NC}"
    for agent in "${AGENTS[@]}"; do
        echo "  • ${agent^}"
    done
    echo ""

    read -rp "Install to all detected agents? [Y/n] " answer
    if [[ "${answer,,}" == "n" ]]; then
        SELECTED=($(select_agents))
    else
        SELECTED=("${AGENTS[@]}")
    fi

    for agent in "${SELECTED[@]}"; do
        case "$agent" in
            openclaw) install_openclaw ;;
            claude)   install_to_dir "claude"   "$HOME/.claude/skills" ;;
            codex)    install_to_dir "codex"    "$HOME/.codex/skills" ;;
            gemini)   install_to_dir "gemini"   "$HOME/.gemini/skills" ;;
            cursor)   install_to_dir "cursor"   "$HOME/.cursor/rules" ;;
            windsurf) install_to_dir "windsurf" "$HOME/.windsurf/skills" ;;
            opencode) install_to_dir "opencode" "$HOME/.opencode/skills" ;;
        esac
    done
fi

# ── Summary ──────────────────────────────────────────────────────────────────
echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║              Installation Complete                    ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

if [[ ${#INSTALLED[@]} -gt 0 ]]; then
    echo -e "${GREEN}✅ Installed:${NC}"
    for entry in "${INSTALLED[@]}"; do
        echo "  • $entry"
    done
fi

if [[ ${#SKIPPED[@]} -gt 0 ]]; then
    echo -e "${YELLOW}⚠ Skipped:${NC}"
    for entry in "${SKIPPED[@]}"; do
        echo "  • $entry"
    done
fi

echo ""
echo -e "${YELLOW}💡 Next steps:${NC}"
echo "  • Verify installations in your coding agent"
echo "  • Run 'bash scripts/convert.sh' for project-local copies"
echo "  • See scripts/openclaw-install.md for OpenClaw-specific setup"

echo ""
echo -e "${GREEN}Done.${NC}"
