# 🤝 Agent Collaboration Protocol

> *How agents work together — structured, scalable, and accountable*

---

## Table of Contents

1. [The Core Protocol](#the-core-protocol-question--options--decision--draft--approval)
2. [Review Modes](#review-modes)
3. [Agent Roles & Responsibilities](#agent-roles--responsibilities)
4. [Escalation Paths](#escalation-paths)
5. [Conflict Resolution](#conflict-resolution)
6. [Communication Standards](#communication-standards)
7. [Session Structure](#session-structure)
8. [Workflows & Examples](#workflows--examples)

---

## The Core Protocol: Question → Options → Decision → Draft → Approval

Every interaction between agents follows a **5-step structured protocol**. This ensures traceability, accountability, and efficient decision-making.

```
┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐    ┌──────────┐
│ Question │───▶│ Options  │───▶│ Decision │───▶│  Draft   │───▶│ Approval │
└──────────┘    └──────────┘    └──────────┘    └──────────┘    └──────────┘
```

### Step 1: ❓ Question

An agent identifies a need, problem, or opportunity and raises it to the relevant party.

**Format:**

```markdown
**QUESTION** (Agent: <name>)

**Context:** <brief background>
**Need:** <what is required>
**Constraints:** <time, budget, scope, dependencies>
**Suggested Respondent:** <which agent/role should answer>
```

**Example:**

```markdown
**QUESTION** (Agent: Game Designer)

**Context:** The combat system requires a dodge mechanic with i-frames.
**Need:** How many i-frames should the dodge provide for the game to feel responsive at 60 FPS?
**Constraints:** Target is 60 FPS on console. Must not exceed 200ms total invulnerability.
**Suggested Respondent:** Systems Designer
```

### Step 2: 📋 Options

The responding agent proposes 2–3 viable options with trade-offs clearly stated.

**Format:**

```markdown
**OPTIONS** (Agent: <name>)

**Option A:** <description>
  - Pros: <list>
  - Cons: <list>
  - Effort: <estimate>

**Option B:** <description>
  - Pros: <list>
  - Cons: <list>
  - Effort: <estimate>

**Recommendation:** <A or B, with rationale>
```

**Example:**

```markdown
**OPTIONS** (Agent: Systems Designer)

**Option A:** 12 i-frames (200ms at 60 FPS)
  - Pros: Industry standard (Dark Souls, Monster Hunter)
  - Cons: Tight timing for casual players
  - Effort: Implement in 1 hour

**Option B:** 8 i-frames (133ms at 60 FPS)
  - Pros: Rewards skill, shorter PvP windows
  - Cons: Frustrating for less experienced players
  - Effort: Implement in 1 hour

**Recommendation:** Option A — aligns with our target audience of mid-core players.
```

### Step 3: ✅ Decision

The decision-making agent (or human) selects one option and documents the rationale.

**Format:**

```markdown
**DECISION** (Agent: <name>)

**Selected:** Option <A/B/C> or <custom>
**Rationale:** <why this choice>
**Impact:** <what changes as a result>
**Assignee:** <who will execute>
```

**Example:**

```markdown
**DECISION** (Agent: Creative Director)

**Selected:** Option A (12 i-frames, 200ms)
**Rationale:** Matches player expectations for the genre. We can tune in QA if needed.
**Impact:** Dodge timing documented in GDD. Affects animation lengths.
**Assignee:** Game Designer
```

### Step 4: 📝 Draft

The executor produces the deliverable — code, document, asset, or configuration.

**Format:**

```markdown
**DRAFT** (Agent: <name>)

**Deliverable:** <what was produced>
**Details:** <key implementation notes>
**Dependencies:** <anything else needed>
**Reviewers:** <who should review>
```

**Example:**

```markdown
**DRAFT** (Agent: Game Designer)

**Deliverable:** Dodge mechanic section added to GDD (Section 4.3.2)
**Details:**
  - 12 i-frames (200ms) on dodge start
  - 100ms recovery after i-frame window
  - No i-frames on back-dodge
**Dependencies:** Animation team needs 12-frame dodge animation
**Reviewers:** Systems Designer, Lead Programmer, Creative Director
```

### Step 5: 👍 Approval

The designated reviewers sign off, request changes, or reject with reasoning.

**Format:**

```markdown
**APPROVAL** (Agent: <name>)

**Status:** ✅ Approved / 🔄 Changes Requested / ❌ Rejected
**Feedback:** <specific notes or requested changes>
**Next Steps:** <what happens next>
```

**Example (Approved):**

```markdown
**APPROVAL** (Agent: Creative Director)

**Status:** ✅ Approved
**Feedback:** Looks solid. Let's proceed.
**Next Steps:** Pass to Animation team for dodge animation spec.
```

**Example (Changes Requested):**

```markdown
**APPROVAL** (Agent: Systems Designer)

**Status:** 🔄 Changes Requested
**Feedback:** Back-dodge should also have i-frames (8 frames min) to prevent corner-trapping exploits.
**Next Steps:** Update GDD and re-submit for approval.
```

---

## Review Modes

Game Dev Studio supports **three review modes**, each suited to different team sizes, decision types, and timeline pressures.

### Full Review

**When to use:**
- Major design or architecture decisions
- Cross-team changes (affecting 3+ disciplines)
- Changes with significant scope/cost impact
- Final QA sign-off and release approval

**Process:**

```
All relevant agents → Provide Options → Group Discussion → 
Decision Maker Picks → Draft → All Agents Review → 
Vote / Consensus → Final Approval
```

**Characteristics:**
- All agents in the relevant phase participate
- Minimum 2 rounds of feedback
- Documented in detail for future reference
- Takes longer but catches edge cases

**Timeline:** 1–3 days (can be shortened for urgent items)

### Lean Review

**When to use:**
- Routine design or implementation decisions
- Single-discipline changes
- Low-to-medium risk changes
- Iterative development (e.g., sprint-level decisions)

**Process:**

```
Lead Agent → Options → Decision Maker → 
Draft → Core Team Review → Approval
```

**Characteristics:**
- Only core team participants (Lead Programmer, Lead Designer, Producer)
- Single round of feedback
- Documented as ADR or GDD notes
- Fast, efficient

**Timeline:** 2–4 hours

### Solo Mode

**When to use:**
- Well-understood, low-risk tasks
- Bug fixes that don't affect design
- Documentation updates
- Asset production following established style guides
- Any task where the agent has full context and authority

**Process:**

```
Agent → Self-Options → Self-Decision → 
Produce Deliverable → Self-Approval → (optional) Notify Team
```

**Characteristics:**
- Single agent makes and executes the decision
- No formal review loop
- Documented as a note in the project log
- Fastest possible turn-around

**Timeline:** 15–30 minutes

### Mode Selection Matrix

| Decision Type | Impact | Risk | Recommended Mode |
|---|---|---|---|
| Core mechanic design | High | High | **Full** |
| Level layout | Medium | Medium | **Lean** |
| UI button placement | Low | Low | **Solo** |
| Architecture change | High | High | **Full** |
| Bug fix (critical) | Medium | Low | **Solo** |
| Sound effect selection | Low | Low | **Solo** |
| Sprint scope change | Medium | Medium | **Lean** |
| Engine upgrade | High | Critical | **Full** |
| Asset color palette | Low | Low | **Solo** |
| Release readiness | High | Critical | **Full** |

---

## Agent Roles & Responsibilities

Every agent in Game Dev Studio has a defined role, scope, and authority level.

### Role Hierarchy

```
                    ┌──────────────────┐
                    │   Producer / PM  │
                    │  (process owner) │
                    └────────┬─────────┘
                             │
              ┌──────────────┼──────────────┐
              │              │              │
     ┌────────┴───────┐ ┌───┴───────┐ ┌────┴────────┐
     │ Creative Lead  │ │ Tech Lead │ │ QA Lead     │
     │ (vision owner) │ │ (perf     │ │ (quality    │
     │                │ │  owner)   │ │  owner)     │
     └────────┬───────┘ └───┬───────┘ └────┬────────┘
              │             │              │
     ┌────────┴───────┐ ┌───┴───────┐ ┌────┴────────┐
     │ Specialists    │ │ Engineers │ │ Testers     │
     │ (designers,    │ │ (program- │ │ (QA engi-   │
     │  artists, etc) │ │  mers)    │ │  neers)     │
     └────────────────┘ └───────────┘ └─────────────┘
```

### Authority Levels

| Level | Title | Can Decide | Escalates To |
|---|---|---|---|
| **L1** | Specialist | Within their discipline guidelines | Lead |
| **L2** | Lead | Within their discipline, cross-discipline decisions | Producer / Creative Director |
| **L3** | Director | Cross-discipline, strategic direction | Producer / Studio Head |
| **L4** | Producer | Process, timeline, scope | Studio Head / Human |

### Agent Communication Matrix

| Agent Type | Reports To | Consults | Informs |
|---|---|---|---|
| **Game Designer** | Creative Director | Systems Designer, Narrative Designer | All team |
| **Programmer** | Tech Lead | Architect, Lead Designer | QA Lead |
| **Artist** | Creative Director | Technical Artist, Animator | Producer |
| **QA Engineer** | QA Lead | All discipline leads | Producer |
| **Sound Designer** | Creative Director | Game Designer, Programmer | Producer |
| **Producer** | Human | All leads | Human |

---

## Escalation Paths

When an agent cannot resolve a question or conflict within their authority, they escalate using a defined path.

### Standard Escalation

```
Step 1: Agent → Their Discipline Lead
Step 2: Discipline Lead → Producer
Step 3: Producer → Human Stakeholder
Step 4: Human → Final Decision
```

### Escalation Levels

| Level | Involves | Timeline | Method |
|---|---|---|---|
| **Level 1** | Agent + Lead | Same day | Direct message |
| **Level 2** | Cross-lead discussion | 1 day | Brief meeting / async thread |
| **Level 3** | Producer + Leads | 1–2 days | Scheduled meeting |
| **Level 4** | Human decision | As needed | Formal request |

### When to Escalate

Escalate when:

- **Conflict** — Two agents disagree and cannot reconcile
- **Ambiguity** — The GDD or spec is unclear
- **Scope** — A decision exceeds the agent's authority level
- **Risk** — A decision carries high risk and needs human oversight
- **Blocked** — A dependency is not available and needs unblocking

### Escalation Format

```markdown
**ESCALATION** (Agent: <name> → <target>)

**Issue:** <clear description>
**Attempted Resolution:** <what was already tried>
**Options Considered:** <what was discussed>
**Recommended Path:** <suggestion for resolution>
**Urgency:** Low / Medium / High / Critical
```

---

## Conflict Resolution

### Principles

1. **Data over opinion** — Decisions are backed by metrics, player feedback, or design goals
2. **Design intent** — When data is unavailable, the GDD's design intent takes precedence
3. **Scope awareness** — The producer has final say on scope; creative decisions stay with creative leads
4. **Rapid prototyping** — When in doubt, build a cheap prototype to test the disagreement
5. **Bias toward action** — A reasonable decision today beats a perfect decision next week

### Resolution Workflow

```
                ┌────────────┐
                │  Conflict  │
                │  Identified│
                └─────┬──────┘
                      │
                      ▼
              ┌─────────────────┐
              │ Can agents agree │
              │ at Level 1?      │
              └────┬────────┬────┘
                   │ YES    │ NO
                   ▼        ▼
            ┌─────────┐  ┌────────────┐
            │Resolved │  │ Escalate to│
            │  ✓      │  │ Level 2    │
            └─────────┘  └──────┬─────┘
                                │
                      ┌─────────┴─────────┐
                      │ Can leads agree?  │
                      └────┬────────┬─────┘
                           │ YES    │ NO
                           ▼        ▼
                     ┌─────────┐  ┌─────────────┐
                     │Resolved │  │ Escalate to  │
                     │  ✓      │  │ Producer     │
                     └─────────┘  └──────┬──────┘
                                          │
                                ┌─────────┴─────────┐
                                │ Producer's decision│
                                │ is final. Sign-off │
                                │ documented in log. │
                                └───────────────────┘
```

---

## Communication Standards

### Message Format

All agent-to-agent communication follows a consistent format:

```
**TYPE** (Agent: <name> → <recipient(s)>)

**Topic:** <brief title>
**Context:** <background, 1–3 sentences>
**Body:** <main content>
**Action Required:** <what the recipient should do>
**Deadline:** <when, if applicable>
```

### Message Types

| Type | Purpose | Example |
|---|---|---|
| **QUESTION** | Request information or decision | "How many i-frames?" |
| **OPTIONS** | Propose alternatives | "12 vs 8 i-frames" |
| **DECISION** | Announce a choice | "We're using 12 i-frames" |
| **DRAFT** | Share a deliverable for review | "GDD Section 4.3 is ready" |
| **APPROVAL** | Sign off or request changes | "Approved with minor feedback" |
| **ESCALATION** | Elevate unresolved issue | "Disagreement on dodge timing" |
| **UPDATE** | Share progress or status | "Animation rigging is 80% done" |
| **BLOCKER** | Report an impediment | "Waiting on animation rig" |

### Tags

Messages may include tags for filtering:

```
[urgent]     — Requires response within 2 hours
[blocking]   — Blocking other work
[info-only]  — No action required, just FYI
[decision]   — Contains a decision that needs logging
```

### Channels

| Channel | Use For | Recorded |
|---|---|---|
| **Project Log** | All decisions, approvals, escalations | ✅ Yes |
| **Phase Chat** | Phase-specific discussion | ✅ Yes |
| **Direct Message** | Quick coordination between leads | ❌ No (summarize to log) |
| **Standup** | Daily updates and blocking issues | ✅ Yes |

---

## Session Structure

A standard agent collaboration session follows this flow:

### Session Initiation

1. **Context Load** — All agents load project context (GDD, ADRs, current build)
2. **Status Sync** — Agents share current state and recent changes
3. **Goal Setting** — Define session objectives and priority
4. **Mode Selection** — Choose Full, Lean, or Solo mode

### Session Execution

```
Concurrent work with checkpoints every 30-60 minutes:

[Checkpoint]
  1. Progress update from each active agent
  2. New blockers or questions
  3. Quick decisions when possible
  4. Continue or pivot

[Between Checkpoints]
  - Agents work autonomously within their scope
  - Questions use the protocol format
  - Decisions are logged immediately
```

### Session Closure

1. **Deliverable Summary** — What was produced
2. **Decision Log** — All decisions made during the session
3. **Blocker List** — Unresolved items requiring follow-up
4. **Next Session Prep** — What needs to be ready for next session
5. **Handoff Notes** — For agents not in the next session

---

## Workflows & Examples

### Example 1: Feature Design (Lean Mode)

```
[Question] Game Designer → Systems Designer
  "Can we implement a stamina system for sprinting?"

[Options] Systems Designer → Game Designer
  A) Fixed stamina bar (300 units, 30/sec recovery after 2s delay)
  B) Segmented stamina bar (5 segments, 1 segment/sec recovery)
  Rec: A — simpler to balance, better UX clarity

[Decision] Game Designer → Systems Designer
  Option A. Add sprint cost of 20/sec. 300 total, 2s delay.

[Draft] Systems Designer → Game Designer
  GDD Section 5.2 updated. Stamina values documented.
  Programming spec ready.

[Approval] Game Designer → Systems Designer
  ✅ Approved.  Good work.
```

### Example 2: Bug Fix (Solo Mode)

```
[Context] QA Engineer noticed character clips through
wall at x: 42, y: 18 in Level 3.

[Action] Programmer (Solo)
  - Identifies cause: capsule collider too small
  - Fix: Increase capsule height by 0.2 units
  - Test: Confirms no clipping
  - Log: "Fixed capsule collider clipping in Level 3 (x:42, y:18)"
  - Self-Approved
```

### Example 3: Architecture Decision (Full Mode)

```
[Question] Tech Lead → All Leads
  "Should we use ECS for our enemy AI system?"

[Options] Architect → All Leads
  A) Full ECS (Unity DOTS) — Best performance, steep learning curve
  B) Hybrid — ECS for pathfinding, OOP for behavior trees
  C) All OOP — Simpler, but may hit perf limits with 200+ enemies
  Rec: B — balances performance with team skill level

[Discussion]
  - Lead Programmer: Supports B, suggests adding job system
  - Game Designer: Needs behavior trees to remain editable by designers
  - Tech Lead: Confirms hybrid approach supports designer tools

[Decision] Tech Lead
  Option B with Unity Job System for pathfinding.
  Behavior trees in standard C#.

[Draft] Architect
  ADR-004: Enemy AI Architecture written.
  Covers ECS boundary, job system scope, behavior tree structure.

[Approval] All Leads
  ✅ Approved. ADR-004 is now active.
```

---

## Protocol Quick Reference

### Decision Flow

```
QUESTION → Who has the answer?
OPTIONS  → What are the trade-offs?
DECISION → What are we doing?
DRAFT    → Here's the result.
APPROVAL → Is this good enough to ship?
```

### Mode Quick Select

| Situation | Mode |
|---|---|
| High risk, cross-team | Full |
| Routine, low risk | Lean |
| Well-understood, solo | Solo |

### Escalation Trigger

> *"I've tried to resolve this but I don't have the authority / data / time. I need help."*

---

*Next: Explore the 7-phase pipeline → [docs/workflow.md](workflow.md)*
