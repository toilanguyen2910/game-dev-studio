# 🎯 Game Development Pipeline: 7-Phase Workflow

> *A battle-tested, agent-driven pipeline from concept to release*

---

## Overview

The Game Dev Studio pipeline breaks game development into **7 distinct phases**, each with clearly defined goals, deliverables, agent roles, and exit criteria. Every phase produces artifacts that feed directly into the next, ensuring traceability and reducing rework.

```
Concept → Design → Architecture → Pre-Production → Production → QA/Testing → Release
```

---

## Phase 1: 🧠 Concept

**Goal:** Define the game's core vision, validate market viability, and establish creative direction.

### Activities

- **Brainstorming & Ideation** — Generate game concepts based on genre trends, team strengths, and market gaps
- **Market Research** — Analyze competitors, target audience, platform trends, and revenue models
- **Vision Document** — Create a 1–2 page vision statement covering core loop, tone, art style, and target platform
- **Feasibility Assessment** — Evaluate technical scope, team capacity, budget, and timeline
- **Pitch Deck** — Build materials for stakeholder or publisher buy-in

### Relevant Skills

| Skill | Purpose |
|---|---|
| `market-analysis` | Competitor & audience research |
| `concept-art` | Mood boards, concept sketches |
| `game-vision` | Vision document templates & guidance |
| `pitch-deck` | Investor/publisher deck creation |
| `churn-prevention` | Early player retention modeling |

### Key Agents

- **Creative Director** — Owns the vision
- **Market Analyst** — Validates market demand
- **Concept Artist** — Visualizes the idea
- **Producer** — Assesses feasibility

### Deliverables

- ✅ Vision Document (1–2 pages)
- ✅ Market Research Report
- ✅ Concept Art / Mood Board
- ✅ Feasibility Assessment
- ✅ Pitch Deck (optional)

### Exit Criteria

> *The concept is approved by stakeholders, market data supports viability, and the team agrees to proceed.*

---

## Phase 2: ✏️ Design

**Goal:** Detail every aspect of the game's mechanics, systems, narrative, and player experience.

### Activities

- **Game Design Document (GDD)** — Comprehensive specification of gameplay mechanics, systems, progression, and content
- **Systems Design** — Economy systems, combat math, leveling curves, loot tables
- **Narrative Design** — Story, characters, dialogue trees, world-building
- **Level Design** — High-level level layouts, flow maps, encounter planning
- **UX Design** — Player journey maps, input schemes, HUD wireframes
- **Technical Design** — Engine-specific considerations, asset budgets, rendering targets

### Relevant Skills

| Skill | Purpose |
|---|---|
| `gdd-authoring` | Game Design Document creation |
| `systems-design` | Economy & progression math |
| `narrative-design` | Story & dialogue systems |
| `ux-design` | Player experience & HUD |
| `level-design` | Layout & flow planning |

### Key Agents

- **Game Designer** — Owns the GDD
- **Systems Designer** — Balance & progression
- **Narrative Designer** — Story & characters
- **UX Designer** — Player experience
- **Technical Designer** — Bridge between design & engineering

### Deliverables

- ✅ Game Design Document (GDD)
- ✅ Systems Design Spec (economy, progression, combat)
- ✅ Narrative Bible
- ✅ Level Flow Diagrams
- ✅ UX Wireframes & Input Specs

### Exit Criteria

> *The GDD is frozen, systems are mathematically balanced, and all major design decisions are documented and signed off.*

---

## Phase 3: 🏗️ Architecture

**Goal:** Create the technical blueprint — engine setup, code architecture, data pipelines, and development infrastructure.

### Activities

- **Engine Setup** — Configure Godot/Unity/Unreal project with correct settings, plugins, and build targets
- **Code Architecture** — Define project structure, design patterns (ECS, MVC, etc.), core abstractions
- **Data Architecture** — Design data models, save systems, configuration formats (JSON, YAML, binary)
- **Asset Pipeline** — Set up import/export workflows for art, audio, and animation assets
- **CI/CD Pipeline** — Build automation for testing, building, and deploying to target platforms
- **Architecture Decision Records (ADRs)** — Document every significant architectural choice
- **Performance Budget** — Define frame time, memory, draw-call, and build-size targets

### Relevant Skills

| Skill | Purpose |
|---|---|
| `engine-config` | Godot/Unity/Unreal project setup |
| `code-architecture` | Project structure & patterns |
| `data-pipeline` | Data models & save systems |
| `asset-pipeline` | Art & audio import workflows |
| `ci-cd-pipeline-builder` | Build & deploy automation |
| `adr-templates` | Architecture Decision Records |

### Key Agents

- **Technical Director** — Owns architecture
- **Engine Architect** — Engine-specific decisions
- **Data Engineer** — Data systems & pipelines
- **DevOps Engineer** — CI/CD & infrastructure

### Deliverables

- ✅ Engine Project (initialized & configured)
- ✅ Architecture Overview Document
- ✅ Architecture Decision Records (ADRs)
- ✅ CI/CD Configuration
- ✅ Performance Budget
- ✅ Code Style Guide

### Exit Criteria

> *Architecture is documented in ADRs, engine is configured, CI/CD is operational, and the team has been briefed on architecture decisions.*

---

## Phase 4: 🧪 Pre-Production

**Goal:** Validate the design and architecture through a playable prototype, proving core mechanics and technical viability.

### Activities

- **Vertical Slice** — Build a small but complete chunk of the game (one level, one mechanic, full pipeline)
- **Prototype** — Rapidly test high-risk mechanics, controls, or systems
- **UI/UX Implementation** — Build HUD, menus, and input handling
- **Audio Prototype** — Test sound effects, music direction, and voice-over style
- **Art Style Guide** — Finalize art direction with sample assets
- **Technical Spike** — Validate risky features (multiplayer, procedural generation, streaming)
- **Production Plan** — Final scoping, task breakdown, sprint planning

### Relevant Skills

| Skill | Purpose |
|---|---|
| `prototyping` | Rapid mechanic validation |
| `vertical-slice` | End-to-end demo creation |
| `ui-implementation` | HUD & menu systems |
| `audio-design` | Sound & music prototyping |
| `art-guide` | Style guides & reference sheets |

### Key Agents

- **Prototype Lead** — Owns the vertical slice
- **UI/UX Designer** — Interface implementation
- **Sound Designer** — Audio prototypes
- **Lead Artist** — Art style validation
- **Producer** — Production planning

### Deliverables

- ✅ Playable Vertical Slice
- ✅ Art Style Guide
- ✅ Audio Direction Samples
- ✅ UI Prototype (menus, HUD)
- ✅ Production Plan (sprints, milestones)
- ✅ Updated ADRs (learnings from prototype)

### Exit Criteria

> *The vertical slice is playable, core mechanics feel fun, art and audio direction are validated, and the team has a detailed production plan with sprint breakdowns.*

---

## Phase 5: 🏭 Production

**Goal:** Build the full game — create all assets, implement all features, and iterate until feature-complete.

### Activities

- **Feature Implementation** — Build game mechanics, systems, UI, audio, and VFX per the GDD
- **Asset Creation** — Produce all art assets (characters, environments, props, animations)
- **Audio Production** — Record/compose all sound effects, music, and voice-over
- **Level Building** — Construct all levels, missions, or world areas
- **Localization** — Translate text, adapt cultural references, record VO in target languages
- **Polish** — Juice (screen shake, particles, tweening), accessibility, performance optimization
- **Integration** — Merge all systems, test end-to-end flows

### Relevant Skills

| Skill | Purpose |
|---|---|
| `programming` | Core game logic & features |
| `3d-modeling` | Character & environment assets |
| `animation` | Character & object animation |
| `vfx` | Particles, shaders, post-processing |
| `audio-production` | Music & sound effect creation |
| `localization` | Translation & cultural adaptation |
| `optimization` | Performance profiling & tuning |
| `juice` | Polish, feel, and game feel |

### Key Agents

- **Lead Programmer** — Feature implementation
- **Lead Artist** — Art production & quality
- **Animator** — Animation production
- **Audio Engineer** — Sound & music production
- **Level Designer** — Level construction
- **Localization Specialist** — Translation
- **Producer** — Sprint management, burndown

### Deliverables

- ✅ Feature-Complete Game Build
- ✅ All Art Assets (characters, environments, UI)
- ✅ All Audio Assets (SFX, music, VO)
- ✅ All Levels / Worlds
- ✅ Localized Content
- ✅ Builds for all Target Platforms

### Exit Criteria

> *The game is feature-complete — all planned content is implemented, all assets are final, and the game is playable from start to finish on target platforms.*

---

## Phase 6: 🐛 QA / Testing

**Goal:** Ensure the game meets quality, performance, and compatibility standards across all target platforms.

### Activities

- **Functional Testing** — Verify all features work as specified (regression, smoke, sanity)
- **Playtesting** — Internal and external playtest sessions for fun, difficulty, and pacing
- **Performance Testing** — Frame rate, memory, load times, thermal profiling
- **Compatibility Testing** — Test across all target hardware, OS versions, and peripherals
- **Localization Testing** — Verify translations, text fit, and cultural appropriateness
- **Accessibility Testing** — Test color-blind modes, subtitles, control remapping, difficulty options
- **Regression Testing** — Re-test after every bug fix to catch new issues
- **Bug Tracking** — Log, triage, and verify fixes through a structured system

### Relevant Skills

| Skill | Purpose |
|---|---|
| `functional-testing` | Feature verification |
| `playtesting` | Player experience testing |
| `performance-analysis` | Frame rate & memory profiling |
| `compatibility-testing` | Cross-platform validation |
| `localization-qa` | Translation quality checks |
| `accessibility-audit` | Accessibility compliance |
| `bug-tracking` | Issue logging & triage |
| `regression-testing` | Re-test after fixes |

### Key Agents

- **QA Lead** — Owns test strategy & execution
- **Performance Analyst** — Profiling & optimization
- **Playtest Coordinator** — Session organization
- **Localization Tester** — Translation quality
- **Accessibility Specialist** — Inclusive design validation

### Deliverables

- ✅ Test Plan & Test Cases
- ✅ Bug Reports (logged & triaged)
- ✅ Playtest Feedback Report
- ✅ Performance Report
- ✅ Compatibility Matrix
- ✅ Verification Reports (all fixes tested)
- ✅ QA Sign-Off

### Exit Criteria

> *All critical and major bugs are fixed, the game runs at target performance on all platforms, playtest feedback is positive, and QA has formally signed off.*

---

## Phase 7: 🚀 Release

**Goal:** Ship the game to players and manage post-launch operations.

### Activities

- **Storefront Preparation** — Set up Steam, Epic, App Store, Google Play, console stores
- **Build Certification** — Platform certification (Steam Deck, Nintendo, PlayStation, Xbox, Apple)
- **Marketing Launch** — Coordinate trailer, press releases, influencer outreach, social media
- **Community Management** — Set up Discord, forums, bug reporting channels
- **Live Operations** — Server deployment, monitoring, analytics, hotfix pipeline
- **Post-Launch Roadmap** — Plan DLC, patches, events, and updates
- **Retrospective** — Team retrospective, lessons learned, knowledge capture

### Relevant Skills

| Skill | Purpose |
|---|---|
| `storefront-setup` | Platform store configuration |
| `certification` | Platform certification checklist |
| `marketing-launch` | Launch campaign coordination |
| `community-management` | Player engagement & support |
| `live-ops` | Server ops & analytics |
| `patch-pipeline` | Hotfix & update deployment |
| `retrospective` | Project post-mortem |

### Key Agents

- **Release Manager** — Owns the launch
- **Community Manager** — Player communication
- **DevOps Engineer** — Server & build pipeline
- **Marketing Lead** — Launch campaign
- **Live-Ops Engineer** — Post-launch operations
- **Producer** — Retrospective & lessons learned

### Deliverables

- ✅ Release Builds (all platforms)
- ✅ Store Listings (assets, descriptions, pricing)
- ✅ Certification Submissions & Passes
- ✅ Marketing Assets (trailer, screenshots, key art)
- ✅ Community Channels (Discord, forums)
- ✅ Live-Ops Dashboard & Monitoring
- ✅ Post-Launch Roadmap
- ✅ Retrospective Document

### Exit Criteria

> *The game is publicly available on target platforms, players can purchase and play, live-ops is operational, and the team has completed the retrospective.*

---

## Pipeline Flow Diagram

```
┌─────────────┐     ┌─────────────┐     ┌───────────────┐
│   Concept    │────▶│   Design    │────▶│ Architecture  │
│  (Phase 1)   │     │  (Phase 2)  │     │   (Phase 3)   │
└─────────────┘     └─────────────┘     └───────┬───────┘
                                                │
                                                ▼
┌─────────────┐     ┌─────────────┐     ┌───────────────┐
│   Release    │◀────│  QA/Test    │◀────│ Pre-Production│
│  (Phase 7)   │     │  (Phase 6)  │     │   (Phase 4)   │
└─────────────┘     └─────────────┘     └───────┬───────┘
                                                │
                                                ▼
                                         ┌───────────────┐
                                         │  Production    │
                                         │   (Phase 5)    │
                                         └───────────────┘
```

**Feedback Loops:**
- During **Production** → loops back to **Design** if features need re-specification
- During **QA** → loops back to **Production** for bug fixes
- **Retrospective** (Phase 7) → feeds forward into future project **Concept** phases

---

## Running the Pipeline

### Full Run

```bash
openclaw agent run --pipeline full --project ./my-game
```

### Single Phase

```bash
openclaw agent run --pipeline design --project ./my-game
```

### Phase with Specific Focus

```bash
openclaw agent run --pipeline production --project ./my-game --focus audio
```

### Custom Skip

```bash
# Skip pre-production if already validated
openclaw agent run --pipeline full --project ./my-game --skip pre-production
```

---

## Phase Transition Checklist

When transitioning between phases, always verify:

1. **All deliverables** for the current phase are complete
2. **Exit criteria** are met
3. **Phase gate** is approved (by producer or creative director)
4. **Dependencies** for the next phase are available
5. **Handoff documentation** is clear and accessible

---

## Customizing the Pipeline

The pipeline is fully modular. You can:

- **Add phases** — Insert custom phases (e.g., "Early Access", "Beta")
- **Remove phases** — Skip phases that don't apply (e.g., skip Architecture for a jam game)
- **Reorder** — Run phases in a different sequence
- **Parallelize** — Run multiple phases concurrently (e.g., Audio Production alongside general Production)

Edit the pipeline configuration in `studio-config/openclaw/pipeline.yaml` to customize.

---

*Next: Learn how to set this up on your platform → [docs/multi-platform.md](multi-platform.md)*
