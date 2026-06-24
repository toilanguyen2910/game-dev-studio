# 🎮 Game Dev Studio

> **Multi-Platform AI-Powered Game Development Ecosystem**
> *49+ Agents · 73+ Skills · 41 Templates · 13+ Coding Platforms*

---

**English** | [Tiếng Việt](#tiếng-việt)

---

## Overview

**Game Dev Studio** is a comprehensive, multi-platform game development environment powered by AI coding agents. It provides a structured pipeline for building games across any engine (Godot, Unity, Unreal) using best-in-class AI tools — all managed through a unified skill, agent, and template library.

Whether you are a solo indie developer or a full studio team, Game Dev Studio gives you:

- **49+ Specialized Agents** — From concept artists to QA engineers, each agent has a defined role, expertise, and tools.
- **73+ Reusable Skills** — Pre-built capabilities covering game design, programming, art, audio, marketing, and operations.
- **41 Production Templates** — Game Design Documents (GDD), Architecture Decision Records (ADR), UX specs, and more.
- **7-Phase Pipeline** — A battle-tested development workflow from concept to release.
- **Multi-Platform Support** — Works with OpenClaw, Claude Code, Codex CLI, Gemini CLI, Cursor, and more.

---

## Supported Platforms

| Platform | Install Method | Config Path |
|---|---|---|
| **OpenClaw** | `openclaw skills install` | `studio-config/openclaw/` |
| **Claude Code** | `.claude/skills/` | `studio-config/claude-code/` |
| **Codex CLI** | `.codex/` | `studio-config/codex/` |
| **Gemini CLI** | `.gemini/skills/` | `studio-config/gemini/` |
| **Cursor** | `.cursor/rules/` | `studio-config/cursor/` |

Detailed setup instructions → [docs/multi-platform.md](docs/multi-platform.md)

---

## Quick Start

### Prerequisites

- Git
- One (or more) supported AI coding agent platforms
- A game engine of your choice (Godot 4.6+, Unity 7+, or UE 5.6+)

### Installation

```bash
# Clone the repository
git clone https://github.com/toilanguyen2910/game-dev-studio.git
cd game-dev-studio

# Install platform-specific configs (choose your platform)
# OpenClaw
openclaw skills install ./studio-config/openclaw/

# Claude Code
mkdir -p .claude/skills/ && cp -r studio-config/claude-code/* .claude/skills/

# Codex CLI
mkdir -p .codex/ && cp -r studio-config/codex/* .codex/

# Gemini CLI
mkdir -p .gemini/skills/ && cp -r studio-config/gemini/* .gemini/skills/

# Cursor
mkdir -p .cursor/rules/ && cp -r studio-config/cursor/* .cursor/rules/
```

### First Run

```bash
# Verify installation
openclaw skills list

# List all available agents
./scripts/list-agents.sh

# Run the collaboration protocol
openclaw agent start --pipeline init
```

---

## Repository Structure

```
game-dev-studio/
├── README.md                    # This file
├── docs/
│   ├── workflow.md              # 7-phase development pipeline
│   ├── multi-platform.md        # Platform-specific guides
│   └── collaboration.md         # Agent collaboration protocol
├── agents/                      # Agent definitions & role specs
│   ├── concept/                 # Concept-phase agents
│   ├── design/                  # Design-phase agents
│   ├── architecture/            # Architecture-phase agents
│   ├── pre-production/          # Pre-production agents
│   ├── production/              # Production agents
│   ├── qa/                      # QA / testing agents
│   └── release/                 # Release & deploy agents
├── skills/                      # Reusable skill definitions
│   ├── game-design/             # Design skills
│   ├── programming/             # Code & scripting skills
│   ├── art/                     # Art & asset creation skills
│   ├── audio/                   # Sound & music skills
│   ├── marketing/               # Marketing & publishing skills
│   └── operations/              # DevOps & live-ops skills
├── templates/                   # Production-ready templates
│   ├── gdd/                     # Game Design Documents
│   ├── adr/                     # Architecture Decision Records
│   └── ux/                      # UX / UI specifications
├── engine-refs/                 # Engine-specific references
│   ├── godot/                   # Godot 4.6 references
│   ├── unity/                   # Unity 7 references
│   └── unreal/                  # Unreal Engine 5.6 references
├── scripts/                     # Automation & utility scripts
└── studio-config/               # Per-platform configuration
    ├── openclaw/
    ├── claude-code/
    ├── codex/
    ├── gemini/
    └── cursor/
```

---

## Engine References

| Engine | Version | Focus Areas |
|---|---|---|
| **Godot** | 4.6 | GDScript, C#, Vulkan/Metal, 2D/3D, XR |
| **Unity** | 7 | DOTS, ECS, MegaCity, Sentis AI, WebGPU |
| **Unreal Engine** | 5.6 | Nanite, Lumen, MetaHuman, PCG, Verse |

Each engine folder contains best-practice reference implementations, code snippets, and performance optimization guides. See `engine-refs/<engine>/README.md` for details.

---

## Development Pipeline

Game Dev Studio follows a proven **7-phase pipeline**:

| Phase | Goal | Key Agents |
|---|---|---|
| **1. Concept** | Define vision & feasibility | Concept Artist, Market Analyst, Creative Director |
| **2. Design** | Detail game mechanics | Game Designer, Systems Designer, Narrative Designer |
| **3. Architecture** | Technical blueprint | Technical Director, Engine Architect, Data Engineer |
| **4. Pre-Production** | Validate with prototype | Prototype Lead, UI/UX Designer, Sound Designer |
| **5. Production** | Build the game | Programmers, Artists, Animators, Audio Engineers |
| **6. QA / Testing** | Ensure quality | QA Lead, Performance Analyst, Localization Tester |
| **7. Release** | Ship & support | Release Manager, Community Manager, Live-Ops Engineer |

See [docs/workflow.md](docs/workflow.md) for the full breakdown.

---

## Agent Collaboration

Agents work together through a structured **Question → Options → Decision → Draft → Approval** protocol:

1. **Question** — An agent raises a need or problem
2. **Options** — The relevant expert proposes 2–3 viable solutions
3. **Decision** — The decision-maker selects the best option
4. **Draft** — The executor creates a deliverable (doc, code, asset)
5. **Approval** — Stakeholders review and sign off

Three review modes support different team sizes:
- **Full** — All agents weigh in (high-confidence decisions)
- **Lean** — Core team reviews (fast iteration)
- **Solo** — Single agent decides (quick tasks)

See [docs/collaboration.md](docs/collaboration.md) for the complete protocol.

---

## Usage Examples

### Start a New Game Project

```bash
# Initialize a new project
openclaw agent run --init-project "My Game" --engine godot --pipeline concept

# This triggers the Concept phase: market analysis → genre selection → vision doc → pitch deck
```

### Run the Full Pipeline

```bash
# Walk through all 7 phases
openclaw agent run --pipeline full --project ./my-game
```

### Run a Single Phase

```bash
# Just the QA phase
openclaw agent run --pipeline qa --project ./my-game --focus regression
```

### Use a Template

```bash
# Scaffold a Game Design Document
cp -r templates/gdd ./my-game/docs/
openclaw agent run --fill-template ./my-game/docs/gdd.md
```

### Generate a Report

```bash
# Status report for production build
openclaw agent run --report-status --phase production
```

---

## How to Contribute

We welcome contributions from game developers, AI engineers, designers, and writers.

### Contribution Categories

| Category | Description |
|---|---|
| **New Agents** | Define a new specialized agent with role, expertise, and tools |
| **New Skills** | Add reusable capabilities (code, art prompts, sound patterns) |
| **Templates** | Improve or create new GDD, ADR, UX templates |
| **Engine References** | Add best-practice code for Godot, Unity, or Unreal |
| **Docs** | Improve documentation, translations, examples |
| **Bug Fixes** | Fix issues in scripts, configs, or pipeline logic |

### Steps

1. **Fork** the repository
2. **Create a branch**: `git checkout -b feature/your-feature`
3. **Make your changes** — follow existing conventions
4. **Test**: `./scripts/validate.sh`
5. **Submit a Pull Request** with clear description

### Guidelines

- Agents go in `agents/<phase>/`
- Skills go in `skills/<category>/`
- Templates go in `templates/<type>/`
- Engine refs go in `engine-refs/<engine>/`
- Every agent must have a `role.yaml` and `README.md`
- Every skill must have a `SKILL.md` with usage examples

---

## License

MIT — see `LICENSE` for details.

---

## Community

- **Discord**: [discord.gg/gamedevstudio](https://discord.gg/gamedevstudio)
- **Twitter/X**: [@GameDevStudio](https://twitter.com/gamedevstudio)
- **Issues**: [GitHub Issues](https://github.com/toilanguyen2910/game-dev-studio/issues)

---

# 🇻🇳 Tiếng Việt

**Game Dev Studio** là hệ sinh thái phát triển game đa nền tảng, được hỗ trợ bởi các tác nhân AI. Nó cung cấp một quy trình có cấu trúc để xây dựng game trên mọi engine (Godot, Unity, Unreal) sử dụng các công cụ AI tốt nhất — tất cả được quản lý thông qua thư viện kỹ năng, tác nhân và mẫu thống nhất.

### Tính năng chính

- **49+ Tác nhân chuyên biệt** — Từ nghệ sĩ ý tưởng đến kỹ sư kiểm thử
- **73+ Kỹ năng tái sử dụng** — Thiết kế game, lập trình, nghệ thuật, âm thanh, tiếp thị
- **41 Mẫu sản xuất** — Tài liệu thiết kế game (GDD), quyết định kiến trúc (ADR), thông số UX
- **Quy trình 7 giai đoạn** — Từ ý tưởng đến phát hành
- **Đa nền tảng** — Hoạt động với OpenClaw, Claude Code, Codex CLI, Gemini CLI, Cursor

### Bắt đầu nhanh

```bash
# Clone dự án
git clone https://github.com/toilanguyen2910/game-dev-studio.git
cd game-dev-studio

# Cài đặt platform tương ứng (ví dụ: OpenClaw)
openclaw skills install ./studio-config/openclaw/
```

### Liên kết hữu ích

| Tài liệu | Mô tả |
|---|---|
| [docs/workflow.md](docs/workflow.md) | Quy trình phát triển 7 giai đoạn |
| [docs/multi-platform.md](docs/multi-platform.md) | Hướng dẫn cài đặt từng nền tảng |
| [docs/collaboration.md](docs/collaboration.md) | Giao thức cộng tác tác nhân |

---

*Built by [Jack Nguyen](https://github.com/toilanguyen2910)*
