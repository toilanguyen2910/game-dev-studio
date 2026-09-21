# 🎮 Game Dev Studio

> **Multi-Platform AI-Powered Game Development Ecosystem**
> *10 Agents · 10 Skills · 7 Templates · 5 Documented Platforms*

---

**English** | [Tiếng Việt](#tiếng-việt)

---

## Overview

**Game Dev Studio** is a comprehensive, multi-platform game development environment powered by AI coding agents. It provides a structured pipeline for building games across any engine (Godot, Unity, Unreal) using best-in-class AI tools — all managed through a unified skill, agent, and template library.

Whether you are a solo indie developer or a full studio team, Game Dev Studio gives you:

- **10 Specialized Agents** — From creative direction and design to production and QA.
- **10 Reusable Skills** — Covering game design, programming, art, prototyping, QA, and release.
- **7 Production Templates** — Game Design Documents (GDD), Architecture Decision Records (ADR), and UX specs.
- **7-Phase Pipeline** — A battle-tested development workflow from concept to release.
- **Multi-Platform Support** — Documented for OpenClaw, Claude Code, Codex CLI, Gemini CLI, and Cursor.

---

## Supported Platforms

| Platform | Install Method | Config Path |
|---|---|---|
| **OpenClaw** | `bash scripts/install.sh` | `studio-config/openclaw/` |
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
- A game engine for the examples you intend to run (Godot 4.7.2, Unity 6.3 LTS, or Unreal Engine 5.8)

### Installation

```bash
# Clone the repository
git clone https://github.com/toilanguyen2910/game-dev-studio.git
cd game-dev-studio

# Inspect installer choices before installing to any agent configuration
bash scripts/install.sh --help

# Or use PowerShell on Windows
pwsh -File scripts/install.ps1 -Help
```

### First Run

```bash
# Check repository structure
bash scripts/validate.sh

# List included agent definitions
bash scripts/list-agents.sh

# Load the included Godot example (requires Godot 4.7)
godot --headless --path examples/godot/project --quit-after 2
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
│   ├── concept/                 # Creative Director, Art Director
│   ├── design/                  # Game Designer, Narrative Director
│   ├── architecture/            # Technical Director
│   ├── pre-production/          # Producer
│   ├── production/              # Lead Programmer, UI Programmer, Sound Designer
│   └── qa/                      # QA Lead
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
│   ├── godot/                   # Godot 4.7 references
│   ├── unity/                   # Unity 6.3 LTS reference
│   └── unreal/                  # Unreal Engine 5.8 reference
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
| **Godot** | 4.7.2 | GDScript and the bundled 2D prototype |
| **Unity** | 6.3 LTS | C#, UI Toolkit, DOTS, cross-platform builds |
| **Unreal Engine** | 5.8 | Version reference and links to Epic documentation |

The version notes under `engine-refs/` link to official documentation. The
Godot example under `examples/godot/` is a small playable project. The Unity
example is currently a workflow guide, not a bundled Unity project.

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

Open the [Godot prototype](examples/godot/README.md) or start a game project in
your chosen engine. Ask your coding agent to read `skills/start/SKILL.md` and
help define the concept and the next deliverable.

### Run the Full Pipeline

Use [docs/workflow.md](docs/workflow.md) as a checklist. Each phase produces a
document or game artifact that you review before moving on.

### Run a Single Phase

Ask your coding agent to read `skills/qa-test/SKILL.md`, inspect your game
project, run the available tests, and write down reproducible findings.

### Use a Template

Copy `templates/gdd/game-design-document.md` into your game project and fill
it with your agent. The template is a Markdown file, not a CLI command.

### Generate a Report

Ask your agent to summarize completed work, open risks, validation results,
and the next milestone using the project's real source and build logs.

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

## Contact Me

- **Gmail**: [jack.vhknguyen@gmail.com](mailto:jack.vhknguyen@gmail.com)
- **Facebook**: [Vu Hoang Khoi Nguyen](https://www.facebook.com/sourrrkngyn7/)
- **Instagram**: [sourrrr_kngyn](https://www.instagram.com/sourrrr_kngyn/)

---

# 🇻🇳 Tiếng Việt

**Game Dev Studio** là hệ sinh thái phát triển game đa nền tảng, được hỗ trợ bởi các tác nhân AI. Nó cung cấp một quy trình có cấu trúc để xây dựng game trên mọi engine (Godot, Unity, Unreal) sử dụng các công cụ AI tốt nhất — tất cả được quản lý thông qua thư viện kỹ năng, tác nhân và mẫu thống nhất.

### Tính năng chính

- **10 Tác nhân chuyên biệt** — Từ định hướng sáng tạo đến lập trình và kiểm thử
- **10 Kỹ năng tái sử dụng** — Thiết kế game, lập trình, nghệ thuật, prototype, QA và phát hành
- **7 Mẫu sản xuất** — Tài liệu thiết kế game (GDD), quyết định kiến trúc (ADR), thông số UX
- **Quy trình 7 giai đoạn** — Từ ý tưởng đến phát hành
- **Đa nền tảng** — Hoạt động với OpenClaw, Claude Code, Codex CLI, Gemini CLI, Cursor

### Bắt đầu nhanh

```bash
# Clone dự án
git clone https://github.com/toilanguyen2910/game-dev-studio.git
cd game-dev-studio

# Xem tùy chọn rồi cài skill cho nền tảng bạn chọn
bash scripts/install.sh --help
bash scripts/install.sh
```

### Liên kết hữu ích

| Tài liệu | Mô tả |
|---|---|
| [docs/workflow.md](docs/workflow.md) | Quy trình phát triển 7 giai đoạn |
| [docs/multi-platform.md](docs/multi-platform.md) | Hướng dẫn cài đặt từng nền tảng |
| [docs/collaboration.md](docs/collaboration.md) | Giao thức cộng tác tác nhân |

---

*Built by [Jack Nguyen](https://github.com/toilanguyen2910)*
