#!/usr/bin/env bash
# =============================================================================
# Game Dev Studio - Validate Repository Structure
# =============================================================================
# Checks that all required files, folders, and formats are correct.
#
# Usage: bash scripts/validate.sh
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

ERRORS=0
WARNINGS=0
PASSED=0

pass() { echo -e "  ${GREEN}✓${NC} $1"; PASSED=$((PASSED + 1)); }
warn() { echo -e "  ${YELLOW}⚠${NC} $1"; WARNINGS=$((WARNINGS + 1)); }
fail() { echo -e "  ${RED}✗${NC} $1"; ERRORS=$((ERRORS + 1)); }

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║  Game Dev Studio - Repository Validator               ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# ── 1. Top-level structure ────────────────────────────────────────────────────
echo -e "${YELLOW}[1/5] Top-level structure${NC}"

for dir in agents skills templates docs engine-refs scripts studio-config; do
    if [[ -d "$PROJECT_DIR/$dir" ]]; then
        pass "Directory exists: $dir/"
    else
        fail "Missing directory: $dir/"
    fi
done

for file in README.md LICENSE CONTRIBUTING.md; do
    if [[ -f "$PROJECT_DIR/$file" ]]; then
        pass "File exists: $file"
    else
        warn "Missing file: $file"
    fi
done

echo ""

# ── 2. Agents ─────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[2/5] Agents${NC}"

EXPECTED_PHASES=("concept" "design" "architecture" "pre-production" "production" "qa")
for phase in "${EXPECTED_PHASES[@]}"; do
    if [[ -d "$PROJECT_DIR/agents/$phase" ]]; then
        count=$(find "$PROJECT_DIR/agents/$phase" -name "*.md" | wc -l)
        if [[ $count -gt 0 ]]; then
            pass "agents/$phase/ ($count agents)"
        else
            warn "agents/$phase/ exists but has no .md files"
        fi
    else
        fail "Missing agent phase folder: agents/$phase/"
    fi
done

echo ""

# ── 3. Skills ─────────────────────────────────────────────────────────────────
echo -e "${YELLOW}[3/5] Skills${NC}"

skill_count=0
for skill_dir in "$PROJECT_DIR/skills"/*/; do
    [[ -d "$skill_dir" ]] || continue
    name="$(basename "$skill_dir")"
    if [[ -f "$skill_dir/SKILL.md" ]]; then
        # Check SKILL.md has required frontmatter
        if grep -q "^name:" "$skill_dir/SKILL.md" && grep -q "^description:" "$skill_dir/SKILL.md"; then
            pass "skills/$name/SKILL.md (valid frontmatter)"
        else
            warn "skills/$name/SKILL.md missing 'name:' or 'description:' in frontmatter"
        fi
        skill_count=$((skill_count + 1))
    else
        fail "skills/$name/ is missing SKILL.md"
    fi
done

if [[ $skill_count -eq 0 ]]; then
    fail "No skills found in skills/"
else
    pass "Total skills: $skill_count"
fi

echo ""

# ── 4. Templates ──────────────────────────────────────────────────────────────
echo -e "${YELLOW}[4/5] Templates${NC}"

for subdir in gdd adr ux; do
    if [[ -d "$PROJECT_DIR/templates/$subdir" ]]; then
        count=$(find "$PROJECT_DIR/templates/$subdir" -name "*.md" | wc -l)
        pass "templates/$subdir/ ($count templates)"
    else
        warn "Missing templates/$subdir/"
    fi
done

echo ""

# ── 5. Studio config ──────────────────────────────────────────────────────────
echo -e "${YELLOW}[5/5] Studio config${NC}"

EXPECTED_PLATFORMS=("openclaw" "claude-code" "codex" "gemini" "cursor")
for platform in "${EXPECTED_PLATFORMS[@]}"; do
    if [[ -d "$PROJECT_DIR/studio-config/$platform" ]]; then
        pass "studio-config/$platform/"
    else
        fail "Missing studio-config/$platform/"
    fi
done

echo ""

# ── Summary ───────────────────────────────────────────────────────────────────
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║  Validation Summary                                   ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  ${GREEN}Passed:${NC}   $PASSED"
echo -e "  ${YELLOW}Warnings:${NC} $WARNINGS"
echo -e "  ${RED}Errors:${NC}   $ERRORS"
echo ""

if [[ $ERRORS -eq 0 ]]; then
    echo -e "${GREEN}✅ Repository is valid and ready to publish!${NC}"
    exit 0
else
    echo -e "${RED}❌ Fix the errors above before publishing.${NC}"
    exit 1
fi
