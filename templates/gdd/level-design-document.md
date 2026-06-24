# Level: [Level Name]

## Quick Reference

- **Area/Region**: [Where in the game world]
- **Type**: [Combat / Exploration / Puzzle / Hub / Boss / Mixed]
- **Estimated Play Time**: [X-Y minutes]
- **Difficulty**: [1-10 relative scale]
- **Prerequisite**: [What the player must have done to reach this level]
- **Status**: [Concept | Layout | Graybox | Art Pass | Polish | Final]

---

## Goals

### Player Goals
[What does the player need to accomplish in this level? List explicit objectives.]

1. [Objective 1]
2. [Objective 2]
3. [Objective 3]

### Design Goals
[What does this level teach, test, or communicate?]

1. [Skill or mechanic introduced]
2. [Story beat delivered]
3. [Design constraint tested]

### Narrative Context

- **Story Moment**: [Where in the narrative arc does this level occur]
- **Narrative Purpose**: [What story beat this level delivers]
- **Emotional Target**: [What the player should feel during this level]
- **Lore Discoveries**: [What world-building the player can find here]

---

## Layout

### Overview Map

```
[S] = Start point       [E] = Exit/end point
[C] = Combat encounter  [P] = Puzzle
[R] = Reward/loot        [!] = Story beat
[?] = Secret/optional    [>] = One-way passage
[=] = Two-way passage    [@] = NPC
[B] = Boss encounter
```

[ASCII diagram of the level layout using the symbols above]

### Critical Path
[The mandatory route through the level, step by step.]

1. Player enters at [S]
2. [Description of what happens along the path]
3. Player exits at [E]

### Optional Paths
| Path | Access Requirement | Reward | Discovery Hint |
|------|-------------------|--------|---------------|

### Points of Interest
| Location | Type | Description | Purpose |
|----------|------|-------------|---------|

---

## Flow & Pacing

### Pacing Chart
```
Intensity
10 |                              *
 8 |                         *   * *
 6 |            *  *        * * *   *
 4 |     *  *  * ** *   *  *
 2 | * ** ** *        * * *          *
 0 |S-----------------------------------------E
     [Start]    [Mid]              [Climax] [Exit]
```

[Describe the intended rhythm: where are the peaks, valleys, rest points, and how the intensity curve supports the emotional target.]

### Flow Control Mechanisms
[What systems regulate player progress through this level?]
- **Gating**: [Key-locked doors, one-way drops, enemy blockades, story triggers]
- **Alternative routes**: [How players can skip or bypass sections based on skill/exploration]
- **Tutorial integration**: [When and how new mechanics are introduced]
- **Pacing valves**: [Spawn gates that pause combat, forced-walk sections, dialogue sequences]

---

## Encounters

### Combat Encounters
| ID | Position | Enemy Composition | Difficulty | Arena Notes |
|----|----------|------------------|-----------|-------------|
| E-01 | [Map ref] | [2x Grunt, 1x Ranged] | 3/10 | Open area, cover on flanks |
| E-02 | [Map ref] | [1x Elite, 3x Grunt] | 5/10 | Narrow corridor, no retreat |

*For each encounter, specify: spawn triggers, enemy AI behaviour, arena hazards, environmental interactions, and fallback if player retreats.*

### Non-Combat Encounters
| ID | Position | Type | Description | Solution Hint |
|----|----------|------|-------------|---------------|
| [N-01] | [Map ref] | [Puzzle / Dialogue / Exploration] | [Description] | [Hint for the player] |

### Boss Encounter (if applicable)
- **Boss Name**: [Name]
- **Phase Structure**: [Number of phases, transition triggers]
- **Arena**: [Description of boss arena, hazards, and interactables]
- **Attack Patterns**: [List of boss attacks, telegraphs, and player responses]
- **Reward on Defeat**: [What the player gets]

---

## Difficulty Curve

### Local Difficulty Gradient
[How difficulty changes across this specific level's duration]

- **Entry difficulty**: [Easy — orientation, refresher mechanics]
- **Ramp section 1**: [Moderate — introduce new threat combination]
- **Difficulty spike**: [Hard — peak challenge before climactic moment]
- **Climax**: [Hardest encounter — boss or final puzzle]
- **Resolution**: [Easy — post-climax recovery, narrative payoff]

### Global Difficulty Placement
- **Position in game**: [Early / Mid / Late]
- **Player presumed level**: [Level X]
- **Presumed player skill**: [What they should have mastered by now]
- **Skill checks**: [Specific mechanics this level validates]

### Difficulty Modifiers (for replay or accessibility)
| Modifier | Effect | Type |
|----------|--------|------|
| [More enemies] | [+X enemies per encounter] | [Hard mode] |
| [Reduced time] | [Timer on puzzles] | [Challenge mode] |
| [Auto-aim] | [Lock-on assistance] | [Accessibility] |

---

## Audio Direction

| Zone/Moment | Music Track | Ambience | Key SFX |
|-------------|------------|----------|---------|
| [Entry] | [Track] | [Ambient sounds] | [Door opening] |
| [Combat] | [Combat music] | [Muted ambience] | [Combat SFX] |

---

## Visual Direction

- **Lighting**: [Key, fill, ambient description and mood]
- **Color Palette**: [Dominant colors and their emotional purpose]
- **Mood Board References**: [Description of visual references]
- **Landmarks**: [Visible navigation aids and their locations]
- **Sight Lines**: [What the player should see from key positions]
- **Performance Budget**: [Poly count target, draw calls, texture memory]

---

## Collectibles & Secrets

| Item | Location | Visibility | Hint | Required For |
|------|----------|-----------|------|-------------|

---

## Technical Notes

- **Estimated Object Count**: [N]
- **Streaming Zones**: [Where to break the level for streaming]
- **Performance Concerns**: [Any known heavy areas]
- **Required Systems**: [What game systems are active in this level]
- **Collision & Navigation**: [NavMesh requirements, blocking volumes, one-way routes]

---

## Testing & Validation

### Playtest Criteria
- [ ] Can a first-time player complete the level without getting stuck?
- [ ] Are all critical path elements clearly signposted?
- [ ] Does the difficulty curve feel smooth (no unfair spikes)?
- [ ] Can a speedrunner bypass optional content and still complete?
- [ ] Does the level maintain target framerate in worst-case camera view?

### Known Issues
| Issue | Severity | Status |
|-------|----------|--------|
| [e.g., Corner near E-03 has no cover] | [Low] | [To fix in graybox] |
