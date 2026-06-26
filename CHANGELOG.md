# Changelog

All notable changes to Game Dev Studio will be documented here.

---

## [1.1.0] - 2026-06-25

### Added

- `studio-config/` folder with per-platform README for OpenClaw, Claude Code, Codex CLI, Gemini CLI, and Cursor
- `scripts/list-agents.sh` — lists all agents grouped by phase with color output
- `scripts/validate.sh` — validates full repo structure (35 checks); exits non-zero on error, suitable for CI

### Fixed

- **Agents restructured into phase subfolders** to match README documentation:
  - `agents/concept/` — Creative Director, Art Director
  - `agents/design/` — Game Designer, Narrative Director
  - `agents/architecture/` — Technical Director
  - `agents/pre-production/` — Producer
  - `agents/production/` — Lead Programmer, UI Programmer, Sound Designer
  - `agents/qa/` — QA Lead
- **`docs/workflow.md`** — All skill references updated to match the 10 skills actually present in `skills/`:
  - Phase 1 (Concept): now references `brainstorm`, `art-bible`, `game-design-doc`, `start`
  - Phase 2 (Design): now references `game-design-doc`, `brainstorm`, `architecture`
  - Phase 3 (Architecture): now references `architecture`, `setup-engine`, `sprint-dev`
  - Phase 4 (Pre-Production): now references `prototype`, `art-bible`, `game-design-doc`
  - Phase 5 (Production): now references `sprint-dev`, `art-bible`, `architecture`
  - Phase 6 (QA): now references `qa-test`, `prototype`, `sprint-dev`
  - Phase 7 (Release): now references `release`, `qa-test`, `sprint-dev`
- **`README.md`** — Fixed agent folder tree to reflect actual phase structure (removed non-existent `release/` subfolder)
- **`README.md`** — Fixed Quick Start install commands to copy from `skills/` directly instead of non-existent `studio-config/` subfolders

---

## [1.0.0] - 2026-06-24

### Added

- Initial release
- 10 agents covering all 7 development phases
- 10 reusable skills: `start`, `brainstorm`, `game-design-doc`, `architecture`, `art-bible`, `prototype`, `setup-engine`, `sprint-dev`, `qa-test`, `release`
- Templates: GDD, ADR, UX specs
- Engine references: Godot 4, Unity 7, Unreal Engine 5
- Install scripts for Windows (`install.ps1`) and Linux/macOS (`install.sh`)
- Multi-platform support: OpenClaw, Claude Code, Codex CLI, Gemini CLI, Cursor
- 7-phase development pipeline documentation
- Agent collaboration protocol
