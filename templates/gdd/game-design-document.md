# Game Design Document: [Game Title]

> **Status**: Draft | In Review | Approved | Implemented
> **Author**: [Name or agent]
> **Last Updated**: [Date]
> **Implements Pillar**: [Which game pillar this supports]

---

## Section 1: Overview

### 1.1 Game Summary
[2-3 sentences: what this system is, what it does for the player, and why it exists in this game. Written for tiered context loading.]

> **Quick reference** — Layer: `[Foundation | Core | Feature | Presentation]` · Priority: `[MVP | Vertical Slice | Alpha | Full Vision]` · Key deps: `[System names or "None"]`

### 1.2 Player Fantasy
[What should the player feel when engaging with this system? The emotional or power fantasy being served.]

### 1.3 Relation to Game Pillars
[How does this system support or derive from each game pillar?]

---

## Section 2: Mechanics

### 2.1 Core Rules
[Precise, unambiguous rules. A programmer should be able to implement this section without asking questions.]

### 2.2 States and Transitions
[If this system has states, document every state and every valid transition.]

| State | Entry Condition | Exit Condition | Behavior |
|-------|----------------|----------------|----------|
| [State 1] | [Condition] | [Condition] | [Description] |

### 2.3 Formulas

#### [Formula Name]
```
result = base_value * (1 + modifier_sum) * scaling_factor
```

| Variable | Type | Range | Source | Description |
|----------|------|-------|--------|-------------|
| base_value | float | 1-100 | data file | The base amount before modifiers |

**Expected output range**: [min] to [max]
**Edge case**: [Handling for extreme values]

### 2.4 Edge Cases
| Scenario | Expected Behavior | Rationale |
|----------|------------------|-----------|
| [What if X is zero?] | [This happens] | [Because of this reason] |

---

## Section 3: Systems

### 3.1 Interactions with Other Systems
[How does this system interact with combat? Inventory? Progression? UI? For each interaction, specify the interface.]

### 3.2 Dependencies
| System | Direction | Nature of Dependency |
|--------|-----------|---------------------|
| [Combat] | This depends on Combat | Needs damage calculation results |

### 3.3 Cross-References
| This Document References | Target GDD | Specific Element | Nature |
|--------------------------|-----------|------------------|--------|
| [combo multiplier feeds score] | `design/gdd/score.md` | combo_multiplier | Data dependency |

> **Nature**: `Data dependency` (we consume their output), `State trigger` (their state change triggers our behaviour), `Rule dependency` (our rule assumes their rule is also true), `Ownership handoff` (we hand off ownership of a value to them).

### 3.4 Tuning Knobs
| Parameter | Current Value | Safe Range | Effect of Increase | Effect of Decrease |
|-----------|-------------|------------|-------------------|-------------------|

---

## Section 4: UI/UX

### 4.1 UI Requirements
[What information needs to be displayed to the player and when?]

| Information | Display Location | Update Frequency | Condition |
|-------------|-----------------|-----------------|-----------|

### 4.2 Game Feel

#### Feel Reference
[Name a specific game/mechanic that captures the target feel. Include anti-reference.]

#### Input Responsiveness
| Action | Max Input-to-Response Latency (ms) | Frame Budget (60fps) | Notes |
|--------|-----------------------------------|----------------------|-------|

#### Animation Feel Targets
| Animation | Startup Frames | Active Frames | Recovery Frames | Feel Goal |
|-----------|---------------|--------------|----------------|-----------|

#### Impact Moments
| Impact Type | Duration (ms) | Effect Description | Configurable? |
|-------------|--------------|-------------------|---------------|
| Hit-stop | [80ms] | [Freeze both objects on contact] | Yes |

#### Feel Acceptance Criteria
- [ ] [e.g., "Combat feels impactful — playtesters comment on weight unprompted"]
- [ ] [e.g., "No reviewer uses the words 'floaty', 'slippery', or 'unresponsive'"]

---

## Section 5: Narrative

### 5.1 Story Context
[Where in the narrative does this system appear? What story beats does it serve?]

### 5.2 Worldbuilding Integration
[How does this system reinforce the game world and lore?]

### 5.3 Character Implications
[How does this affect characters, their development, or relationships?]

---

## Section 6: Art & Audio

### 6.1 Visual Requirements
| Event | Visual Feedback | Priority |
|-------|----------------|----------|

### 6.2 Audio Requirements
| Event | Audio Feedback | Priority |
|-------|---------------|----------|

### 6.3 VFX Notes
[Particle effects, shaders, lighting requirements specific to this system.]

---

## Section 7: Technical

### 7.1 Performance Budget
| Metric | Budget | Notes |
|--------|--------|-------|
| CPU (frame time) | [X ms] | |
| Memory | [X MB] | |
| Load Time | [X s] | |

### 7.2 Data Architecture
[Key data structures, serialization concerns, network considerations.]

### 7.3 Integration Points
[Engine-specific integration notes, system interfaces, event bus hooks.]

### 7.4 Acceptance Criteria
- [ ] [Criterion 1: specific, measurable, testable]
- [ ] Performance: System update completes within [X]ms
- [ ] No hardcoded values in implementation

---

## Section 8: Production

### 8.1 Milestone Mapping
| Milestone | Deliverable | Estimated Effort |
|-----------|-------------|------------------|
| [Alpha] | [Core system functional] | [X weeks] |

### 8.2 Dependencies & Blockers
[What must be done before this system can be built? What does this system block?]

### 8.3 Open Questions
| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|

---

## Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 0.1 | [Date] | [Name] | Initial draft |
