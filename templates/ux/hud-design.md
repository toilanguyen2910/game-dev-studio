# HUD Design: [Game Name]

> **Status**: Draft | In Review | Approved | Implemented
> **Author**: [Name or agent]
> **Last Updated**: [Date]
> **Game**: [Game name — one document per game, not per element]
> **Platform Targets**: [All platforms — e.g., PC, PS5, Xbox Series X, Steam Deck]
> **Related GDDs**: [Every system that exposes information through the HUD]
> **Accessibility Tier**: Basic | Standard | Comprehensive | Exemplary

> **Scope boundary**: This document specifies all elements that overlay the game world during active gameplay — health bars, ammo counters, minimaps, quest trackers, subtitles, damage numbers, notification toasts. For menu screens and dialogs, use `ux-spec.md` instead.

---

## 1. HUD Philosophy

**What is this game's relationship with on-screen information?**
[One paragraph. A design statement, not a feature list. E.g., "The world is the interface. If the player has to look away from the environment to survive, the HUD has failed."]

**Visibility principle**: [Default to HIDE | Default to SHOW | Default to CONTEXTUAL]

**The Rule of Necessity**: "A HUD element earns its place when [complete this sentence]."

---

## 2. Information Architecture

| Information Type | Always Show | Contextual | On Demand | Hidden (Diegetic) | Reasoning |
|-----------------|-------------|------------|-----------|-------------------|-----------|
| Health / Vitality | | | | | |
| Primary resource (mana/stamina/ammo) | | | | | |
| Minimap / Compass | | | | | |
| Quest objective | | | | | |
| Enemy health bar | | | | | |
| Status effects | | | | | |
| Dialogue subtitles | | | | | |
| Damage numbers | | | | | |

---

## 3. Layout Zones

### 3.1 Zone Diagram
```
 0%                                             100%
 ┌──────────────────────────────────────────────────┐  0%
 │  [SAFE MARGIN — X% from edge]                    │
 │  ┌────────────────────────────────────────────┐  │
 │  │ [TOP-LEFT]              [TOP-CENTER]  [TOP-RIGHT] │
 │  │  Health, resource       Quest name     Ammo      │
 │  │                                              │  │
 │  │               [CENTER-SCREEN]               │  │
 │  │                Crosshair / reticle           │  │
 │  │                                              │  │
 │  │ [BOTTOM-LEFT]    [BOTTOM-CENTER]   [BOTTOM-RIGHT] │
 │  │  Minimap          Subtitles         Notifications │
 │  └────────────────────────────────────────────┘  │
 └──────────────────────────────────────────────────┘  100%
```

### 3.2 Zone Specification
| Zone Name | Screen Position | Safe Zone Compliant | Primary Elements | Max Simultaneous |
|-----------|----------------|---------------------|-----------------|------------------|

**Safe zone margins by platform**:
| Platform | Top | Bottom | Left | Right | Notes |
|----------|-----|--------|------|-------|-------|

---

## 4. HUD Element Specifications

### 4.1 Element Overview
| Element Name | Zone | Always Visible | Visibility Trigger | Data Source | Update Frequency | Max Size (% screen) | Overlap Priority | Accessibility Alt |
|-------------|------|---------------|-------------------|-------------|-----------------|-------------------|-----------------|------------------|

### 4.2 Element Detail Blocks

**[Element Name]**
- **Visual description**: [Fill bar, icon, text label, etc.]
- **Data displayed**: [What values and in what format]
- **Update behavior**: [How the element animates between states]
- **Urgency states**: [Normal / Caution / Critical / Zero]
- **Interaction**: [Display only, clickable, hover tooltip]
- **Player customization**: [Opacity, position, size settings]

*[Repeat for every element in 4.1]*

---

## 5. HUD States by Gameplay Context

| Context | Elements Shown | Elements Hidden | Elements Modified | Transition |
|---------|---------------|-----------------|------------------|------------|
| Exploration — no threats | | | | |
| Combat — active threat | | | | |
| Dialogue / Cutscene | | | | |
| Cinematic | | | | |
| Inventory / Menu open | | | | |
| Death / Respawn | | | | |
| Boss Encounter | | | | |

---

## 6. Information Hierarchy

| Element | Priority Tier | Reasoning | What Replaces It If Hidden |
|---------|--------------|-----------|---------------------------|
| Subtitles | MUST KEEP | Accessibility requirement | Nothing |
| Health Bar | MUST KEEP | Survival decisions | Auditory cues |
| Crosshair | MUST KEEP (while aiming) | Precision targeting | Dot-only mode |
| Ammo Counter | SHOULD KEEP | Low ammo decisions | Click on empty |
| Minimap | SHOULD KEEP | Navigation | Compass strip |
| Damage Numbers | CAN HIDE | Feedback only | Hit sounds |
| Notifications | CAN HIDE | Mid-combat noise | Queue released later |

---

## 7. Visual Budget

| Budget Constraint | Limit | Measurement Method | Status |
|------------------|-------|--------------------|--------|
| Max simultaneous HUD elements | [8] | Count visible elements | |
| Max % screen area (exploration) | [12%] | Pixel area / total | |
| Max % screen area (combat) | [22%] | Pixel area / total | |
| Min contrast ratio (HUD text) | [4.5:1 WCAG AA] | Against game world | |
| Max background panel opacity | [65%] | Alpha value | |

---

## 8. Notification System

| Notification Type | Trigger System | Position | Duration | Max Simultaneous | Priority | Queue Behavior |
|------------------|---------------|----------|----------|-----------------|----------|---------------|
| Item Pickup | InventorySystem | Bottom Right | 2000ms | 3 stacked | Low | FIFO |
| XP Gain | ProgressionSystem | Bottom Right | 1500ms | 1 (merges) | Very Low | Combat-aware |
| Level Up | ProgressionSystem | Center | Persistent | 1 | High | Pauses others |
| Quest Update | QuestSystem | Top Center | 4000ms | 1 | Medium | |
| Critical Warning | CombatSystem | Screen edge | Persistent | 1 | Critical | Bypasses queue |

**Notification queue rules**:
1. Combat-aware queue: Low priority notifications queue when player is in combat, flush post-combat
2. Merge rule: identical types within 500ms merge into a single notification
3. Critical notifications bypass all queues

---

## 9. Platform Adaptation

| Platform | Safe Zone | Resolution Range | Input Method | Notes |
|----------|-----------|-----------------|-------------|-------|

**HUD repositionability**: Players must be able to reposition Health bar, Minimap, and Ability bar. Saved per profile.

---

## 10. Accessibility — HUD Specific

### 10.1 Colorblind Modes
| Element | Color-Only Risk | Fix |
|---------|----------------|-----|

### 10.2 Text Scaling
| Element | 100% | 125% | 150% | Overflow |
|---------|------|------|------|----------|

### 10.3 Motion Sensitivity
| Animation | Severity | Disabled by Reduced Motion? | Replacement |
|-----------|----------|----------------------------|-------------|

### 10.4 Subtitles Specification
- **Default**: [ON/OFF]
- **Position**: Bottom Center, above safe zone
- **Max characters per line**: [42]
- **Max simultaneous lines**: [2]
- **Speaker identification**: [Name in color + colon prefix]
- **Background**: [Semi-transparent panel, 70% opacity]
- **Font size minimum**: [24px at 1080p]

### 10.5 HUD Opacity & Visibility Controls
| Setting | Range | Default | Effect |
|---------|-------|---------|--------|

---

## 11. Tuning Knobs

| Parameter | Current Value | Range | Player Adjustable? | Notes |
|-----------|-------------|-------|-------------------|-------|

---

## 12. Acceptance Criteria

**Layout & Visibility**
- [ ] All elements within platform safe zone margins
- [ ] No element overlaps in any documented context
- [ ] HUD < [12]% screen in exploration, < [22]% in combat
- [ ] All elements legible at minimum supported resolution

**Per-Context Correctness**
- [ ] HUD shows correct elements per context in Section 5
- [ ] Context transitions respect timing spec

**Accessibility**
- [ ] All text meets 4.5:1 contrast against game world
- [ ] No color-only differentiation
- [ ] Reduced Motion disables animated transitions
- [ ] Text Scale 150% does not cause overflow
- [ ] Subtitles appear for all voiced lines

**Notifications**
- [ ] Identical types within 500ms merge
- [ ] Low priority queued during combat, released post-combat
- [ ] Critical warnings bypass all queues

---

## 13. Open Questions

| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
