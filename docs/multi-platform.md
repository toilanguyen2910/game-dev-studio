# 💻 Multi-Platform Guide

> *Install and use Game Dev Studio across all supported AI coding platforms*

---

## Overview

Game Dev Studio is built to work seamlessly across **13+ AI coding agent platforms**. Each platform has its own configuration directory under `studio-config/`, and the same skill, agent, and template libraries are shared across all of them.

This guide covers installation and usage for the **5 primary platforms**. Community contributions extend support to additional platforms.

---

## Platform Comparison

| Platform | Best For | Strengths |
|---|---|---|
| **OpenClaw** | Full pipeline management | Native skill/agent system, pipeline orchestration |
| **Claude Code** | In-editor AI pairing | Deep code understanding, GitHub integration |
| **Codex CLI** | Terminal-first development | Fast, lightweight, OpenAI models |
| **Gemini CLI** | Google ecosystem projects | Vertex AI integration, large context window |
| **Cursor** | Visual Studio Code integration | GUI + AI, inline edits, full IDE experience |

---

## 1. 🐾 OpenClaw

### Overview

OpenClaw is the **primary platform** for Game Dev Studio. It provides native support for skills, agents, pipelines, and templates.

### Installation

```bash
# Navigate to project root
cd game-dev-studio

# Install all Game Dev Studio skills
openclaw skills install ./studio-config/openclaw/

# Verify installation
openclaw skills list

# Expected output should include 73+ skills
```

### Configuration

OpenClaw auto-loads configuration from the installed skills directory. No additional setup is required.

### Usage

```bash
# List all agents
openclaw agent list

# Run a specific agent
openclaw agent run --agent game-designer --task "Design core combat loop"

# Execute the full pipeline
openclaw agent run --pipeline full --project ./my-game

# Run a specific phase
openclaw agent run --pipeline production --project ./my-game

# Use collaboration protocol
openclaw collaboration start --mode lean --project ./my-game
```

### Commands Reference

| Command | Description |
|---|---|
| `openclaw skills install <path>` | Install skills from path |
| `openclaw skills list` | List installed skills |
| `openclaw agent list` | List available agents |
| `openclaw agent run <args>` | Run an agent with arguments |
| `openclaw collaboration start` | Start collaboration session |
| `openclaw pipeline run` | Execute pipeline phase |
| `openclaw template scaffold` | Generate from template |

---

## 2. 🤖 Claude Code

### Overview

Claude Code runs inside your terminal and pairs with you on code. Game Dev Studio provides skills as `.claude/skills/` files.

### Installation

```bash
# Navigate to project root
cd game-dev-studio

# Create skills directory and copy configs
mkdir -p .claude/skills/

# Copy all skills
cp -r studio-config/claude-code/* .claude/skills/

# Or install a single skill
cp studio-config/claude-code/game-design.md .claude/skills/
```

### Configuration

Skills are loaded automatically from `.claude/skills/`. Each skill file contains system prompts and tool definitions.

### Usage

```bash
# Start a session with Game Dev Studio skills loaded
claude --project-path . --skills-path .claude/skills/

# Or during a session, reference a skill
# In chat: "Load the gdd-authoring skill and help me write a GDD"
```

### Skills Structure

Claude Code skills are markdown files with front matter:

```markdown
---
name: gdd-authoring
version: 1.0.0
description: Game Design Document authoring assistant
---

# GDD Authoring

## Role
You are a Game Design Document specialist...

## Instructions
...
```

### Commands Reference

| Command | Description |
|---|---|
| `claude --skills-path <path>` | Load skills from directory |
| `claude --project-path <path>` | Set project context |
| `/load-skill <name>` | Load a specific skill by name |
| `/list-skills` | List loaded skills |

---

## 3. 📟 Codex CLI

### Overview

Codex CLI brings OpenAI's Codex models to your terminal. Game Dev Studio configs go in `.codex/`.

### Installation

```bash
# Navigate to project root
cd game-dev-studio

# Create config directory
mkdir -p .codex/

# Copy all configs
cp -r studio-config/codex/* .codex/
```

### Configuration

Codex CLI reads from `.codex/` for project-level configuration, including custom instructions, tool definitions, and skill references.

### Usage

```bash
# Start Codex with Game Dev Studio context
cd my-game-project
codex

# Inside Codex, reference skills by name
# "Act as a game systems designer. Load the systems-design skill."
```

### Config Structure

```
.codex/
├── instructions.md        # Project-level instructions
├── tools/                 # Custom tool definitions
│   ├── gdd-tool.yaml
│   └── adr-tool.yaml
└── skills/                # Skill references
    └── game-dev.yaml
```

### Commands Reference

| Command | Description |
|---|---|
| `codex` | Start Codex CLI in current directory |
| `codex --instructions <file>` | Load custom instructions |
| `codex --tools <dir>` | Load custom tools directory |

---

## 4. 🌿 Gemini CLI

### Overview

Gemini CLI uses Google's Gemini models. Game Dev Studio skills are placed in `.gemini/skills/`.

### Installation

```bash
# Navigate to project root
cd game-dev-studio

# Create skills directory
mkdir -p .gemini/skills/

# Copy all skills
cp -r studio-config/gemini/* .gemini/skills/
```

### Configuration

Gemini CLI auto-discovers skills in `.gemini/skills/`. Each skill file is a YAML or markdown document defining the agent's persona, capabilities, and instructions.

### Usage

```bash
# Start Gemini with project context
cd my-game-project
gemini chat

# In the chat, reference a skill
# "Use the performance-analysis skill to profile our game's frame rate"
```

### Skills Structure

Gemini skills use YAML:

```yaml
# .gemini/skills/performance-analysis.yaml
name: performance-analysis
version: 1.0.0
description: "Game performance profiling and optimization"
persona: "Performance Analyst"
capabilities:
  - profiler: "Frame time analysis"
  - optimizer: "LOD, draw call reduction, memory management"
instructions: |
  You are a game performance analyst...
```

### Commands Reference

| Command | Description |
|---|---|
| `gemini chat` | Start interactive chat |
| `gemini run <task>` | Execute a single task |
| `gemini --global-instructions <file>` | Load additional instructions |

---

## 5. 🖥️ Cursor

### Overview

Cursor is an AI-first code editor built on VS Code. Game Dev Studio rules go in `.cursor/rules/`.

### Installation

```bash
# Navigate to project root
cd game-dev-studio

# Create rules directory
mkdir -p .cursor/rules/

# Copy all rules
cp -r studio-config/cursor/* .cursor/rules/
```

### Configuration

Cursor loads rules from `.cursor/rules/` as markdown files. Each rule defines an AI behavior pattern for the editor.

### Usage

1. Open Cursor in your game project: `cursor .`
2. Cursor automatically loads rules from `.cursor/rules/`
3. Use `Ctrl+K` / `Cmd+K` to invoke AI with rule context
4. Reference rules in chat: `@Rules` → select Game Dev Studio rule

### Rules Structure

```markdown
---
description: GDD Authoring Rule for Cursor
globs: **/*.gdd.md, docs/gdd/**
---
# GDD Authoring

When editing Game Design Documents, follow these conventions:
...
```

### Commands Reference

| Command | Description |
|---|---|
| `cursor .` | Open project in Cursor |
| `Ctrl+K` / `Cmd+K` | Open AI command palette |
| `@Rules` in chat | Browse and select active rules |
| `Ctrl+Shift+P` → `Rules: Reload` | Reload all rules |

---

## Configuration Directory Structure

The `studio-config/` folder contains ready-to-use configurations for every supported platform:

```
studio-config/
├── openclaw/                    # OpenClaw native config
│   ├── skills/                  # Skill definitions
│   ├── agents/                  # Agent definitions
│   └── pipeline.yaml            # Pipeline orchestration
├── claude-code/                 # Claude Code skills (.md)
│   ├── game-design.md
│   ├── programming.md
│   ├── art-production.md
│   ├── audio-engineering.md
│   ├── marketing.md
│   └── operations.md
├── codex/                       # Codex CLI config
│   ├── instructions.md
│   └── tools/
├── gemini/                      # Gemini CLI skills (.yaml)
│   ├── game-design.yaml
│   ├── programming.yaml
│   ├── art-production.yaml
│   ├── audio-engineering.yaml
│   ├── marketing.yaml
│   └── operations.yaml
└── cursor/                      # Cursor rules (.md)
    ├── game-design.md
    ├── programming.md
    ├── art-production.md
    ├── audio-engineering.md
    ├── marketing.md
    └── operations.md
```

---

## Switching Between Platforms

You can use **multiple platforms** on the same project. Each platform reads from its own config directory:

```bash
# Use OpenClaw for pipeline orchestration
openclaw agent run --pipeline design --project ./my-game

# Use Claude Code for a specific code task
cd ./my-game
claude --skills-path ../.claude/skills/

# Use Cursor for visual editing
cursor ./my-game
```

All platforms share the same:
- `agents/` — Role definitions
- `skills/` — Skill implementations  
- `templates/` — Document templates
- `engine-refs/` — Engine references

---

## Platform-Specific Notes

### OpenClaw
- Requires `openclaw` CLI installed globally
- Supports the full 7-phase pipeline natively
- Best for end-to-end project management

### Claude Code
- Requires Anthropic API key or Claude Pro subscription
- Skills are conversational prompts, not executables
- Best for code generation, debugging, and code review

### Codex CLI
- Requires OpenAI API key
- Lightweight, no project file scanning
- Best for quick tasks and prototyping

### Gemini CLI
- Requires Google Cloud project with Vertex AI enabled
- Supports large context windows (1M+ tokens)
- Best for large codebase analysis and documentation

### Cursor
- Requires Cursor IDE installation
- Rules are passive (applied when relevant)
- Best for day-to-day development with AI inline support

---

## Troubleshooting

### Skills Not Loading

```bash
# Verify config directory exists and has files
ls -la studio-config/<platform>/

# For OpenClaw
openclaw skills list

# For Claude Code
ls -la .claude/skills/

# For Cursor
ls -la .cursor/rules/
```

### Platform Not Supported

If your platform isn't listed, you can still use Game Dev Studio:

1. Read the raw skill files in `skills/`
2. Adapt them to your platform's format
3. Contribute back via a pull request!

### Permission Issues

```bash
# Ensure config files are readable
chmod -R u+r studio-config/

# On Windows (PowerShell)
Get-ChildItem -Recurse studio-config/ | Set-ItemProperty -Name IsReadOnly -Value $false
```

---

## Beyond 5: Other Platforms

Game Dev Studio's architecture is platform-agnostic. The raw skills in `skills/` can be adapted to any AI coding agent platform:

| Platform | Integration Method |
|---|---|
| **GitHub Copilot** | `.github/copilot-instructions.md` |
| **Tabby** | `.tabby/agentrc.yaml` |
| **Continue.dev** | `.continue/config.json` |
| **Windsurf** | `.windsurf/rules/` |
| **Aider** | `.aider.conf.yml` |
| **MCP Servers** | `.mcp.json` with skill tool definitions |

---

*Next: Learn how agents collaborate → [docs/collaboration.md](collaboration.md)*
