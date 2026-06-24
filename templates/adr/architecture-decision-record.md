# ADR-[NNNN]: [Title]

## Status

[Proposed | Accepted | Deprecated | Superseded by ADR-XXXX]

## Date

[YYYY-MM-DD — when this ADR was written]

## Last Verified

[YYYY-MM-DD — when this ADR was last confirmed accurate against the current engine version and design.]

## Decision Makers

[Who was involved in this decision]

## Summary

[2 sentences: what problem this ADR solves, and what was decided. Written for tiered context loading — be specific: name the system, the problem, and the chosen approach.]

## Engine Compatibility

| Field | Value |
|-------|-------|
| **Engine** | [e.g. Godot 4.6 / Unity 7 / Unreal Engine 5.6] |
| **Domain** | [Physics / Rendering / UI / Audio / Navigation / Animation / Networking / Core / Input / Scripting] |
| **Knowledge Risk** | [LOW — in training data / MEDIUM — near cutoff, verify / HIGH — post-cutoff, must verify] |
| **References Consulted** | [e.g. `engine-refs/godot/modules/physics.md`] |
| **Post-Cutoff APIs Used** | [Specific APIs from post-cutoff engine versions, or "None"] |
| **Verification Required** | [Concrete behaviours to test before shipping, or "None"] |

> **Note**: If Knowledge Risk is MEDIUM or HIGH, this ADR must be re-validated if the project upgrades engine versions.

## ADR Dependencies

| Field | Value |
|-------|-------|
| **Depends On** | [ADR-NNNN, or "None"] |
| **Enables** | [ADR-NNNN, or "None"] |
| **Blocks** | [Epic/Story name, or "None"] |
| **Ordering Note** | [Any sequencing constraint not captured above] |

## Context

### Problem Statement
[What problem are we solving? Why must this decision be made now? What is the cost of not deciding?]

### Current State
[How does the system work today? What is wrong with the current approach?]

### Constraints
- [Technical constraints — engine limitations, platform requirements]
- [Timeline constraints — deadline pressures, dependencies]
- [Resource constraints — team size, expertise available]

### Requirements
- [Functional requirement 1]
- [Functional requirement 2]
- [Performance requirement — specific, measurable]

## Decision

[The specific technical decision, described in enough detail for someone to implement it without further clarification.]

### Architecture
```
[ASCII diagram showing the system architecture this decision creates.
Show components, data flow direction, and key interfaces.]
```

### Key Interfaces
```
[Pseudocode or language-specific interface definitions that this decision
creates. These become the contracts that implementers must respect.]
```

### Implementation Guidelines
[Specific guidance for the programmer implementing this decision.]

## Alternatives Considered

### Alternative 1: [Name]
- **Description**: [How this approach would work]
- **Pros**: [What is good about this approach]
- **Cons**: [What is bad about this approach]
- **Estimated Effort**: [Relative effort compared to chosen approach]
- **Rejection Reason**: [Why this was not chosen]

### Alternative 2: [Name]
[Same structure]

## Consequences

### Positive
- [Good outcomes of this decision]

### Negative
- [Trade-offs and costs we are accepting]

### Neutral
- [Changes that are neither good nor bad, just different]

## Risks

| Risk | Probability | Impact | Mitigation |
|------|------------|--------|-----------|

## Performance Implications

| Metric | Before | Expected After | Budget |
|--------|--------|---------------|--------|
| CPU (frame time) | [X]ms | [Y]ms | [Z]ms |
| Memory | [X]MB | [Y]MB | [Z]MB |
| Load Time | [X]s | [Y]s | [Z]s |

## Migration Plan (if applicable)

1. [Step 1 — what changes, what breaks, how to verify]
2. [Step 2]
3. [Step 3]

**Rollback plan**: [How to revert if this decision proves wrong]

## Validation Criteria

- [ ] [Measurable criterion 1]
- [ ] [Measurable criterion 2]
- [ ] [Performance criterion]

## GDD Requirements Addressed

> This section is MANDATORY. Every ADR must trace back to at least one GDD requirement, or explicitly state it is a foundational decision.

| GDD Document | System | Requirement | How This ADR Satisfies It |
|-------------|--------|-------------|--------------------------|
| [e.g. `design/gdd/combat.md`] | [Combat] | [e.g. "Hitbox detection must resolve within 1 frame"] | [e.g. "Jolt physics collision queries run synchronously in _physics_process"] |

> If no GDD dependency: "Foundational — no GDD requirement. Enables: [list what GDD systems this decision unlocks]"

## Related

- [Link to related ADRs — note if supersedes, contradicts, or depends on]
- [Link to relevant code files once implemented]
