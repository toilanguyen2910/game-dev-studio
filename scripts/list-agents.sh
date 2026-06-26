#!/usr/bin/env bash
# =============================================================================
# Game Dev Studio - List All Agents
# =============================================================================
# Usage: bash scripts/list-agents.sh
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTS_DIR="$(cd "$SCRIPT_DIR/../agents" && pwd)"

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║  Game Dev Studio - Agent Roster                      ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

total=0

for phase_dir in "$AGENTS_DIR"/*/; do
    [[ -d "$phase_dir" ]] || continue
    phase="$(basename "$phase_dir")"
    echo -e "${YELLOW}📁 Phase: ${phase^}${NC}"

    for agent_file in "$phase_dir"*.md; do
        [[ -f "$agent_file" ]] || continue
        name="$(basename "$agent_file" .md)"
        # Extract the subtitle line ("> **...**")
        subtitle=$(grep -m1 '> \*\*' "$agent_file" | sed 's/> \*\*//;s/\*\*//')
        echo -e "   ${GREEN}•${NC} $(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1') — $subtitle"
        total=$((total + 1))
    done
    echo ""
done

echo -e "${CYAN}Total agents: ${GREEN}$total${NC}"
echo ""
