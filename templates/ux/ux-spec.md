# UX Specification: [Screen / Flow Name]

> **Status**: Draft | In Review | Approved | Implemented
> **Author**: [Name or agent]
> **Last Updated**: [Date]
> **Screen / Flow Name**: [Short identifier — e.g., `InventoryScreen`, `NewGameFlow`]
> **Platform Target**: [PC | Console | Mobile | All]
> **Related GDDs**: [Links to GDD sections that generated this UI requirement]
> **Related ADRs**: [Architectural decisions that constrain this screen]
> **Related UX Specs**: [Sibling and parent screens]
> **Accessibility Tier**: Basic | Standard | Comprehensive | Exemplary

> **Scope boundary**: This template covers discrete screens and flows (menus, dialogs, inventory, settings, cutscene UI). For persistent in-game overlays during active gameplay, use `hud-design.md` instead.

---

## 1. Purpose & Player Need

**What player need does this screen serve?**
[One paragraph. Name the real human need, not the system function. What would frustrate a player if it didn't work?]

**The player goal** (what the player wants to accomplish):
[One sentence. Specific enough to write an acceptance criterion.]

**The game goal** (what the game needs to communicate):
[One sentence. What the system needs from this interaction.]

---

## 2. Player Context on Arrival

| Question | Answer |
|----------|--------|
| What was the player just doing? | [e.g., Completed a combat encounter] |
| What is their emotional state? | [e.g., High tension — just survived] |
| What cognitive load are they carrying? | [e.g., High — tracking enemies] |
| What information do they already have? | [e.g., Knows they picked up an item] |
| What are they most likely trying to do? | [e.g., Check if new item is better] |

**Emotional design target**: [One sentence — e.g., "Confident and in control"]

---

## 3. Navigation Position

**Screen hierarchy**:
```
[Root — e.g., Main Menu]
  └── [Parent Screen — e.g., Settings]
        └── [This Screen]
              └── [Child Screen]
```

**Modal behavior**: [Modal | Non-modal | Overlay (game paused) | Overlay-live (game continues)]

**Reachability**:
| Entry Point | Triggered By | Notes |
|-------------|-------------|-------|

---

## 4. Entry & Exit Points

**Entry table**:
| Trigger | Source State | Transition Type | Data Passed In | Notes |
|---------|-------------|-----------------|----------------|-------|

**Exit table**:
| Exit Action | Destination | Transition Type | Data Returned | Notes |
|-------------|------------|-----------------|---------------|-------|

---

## 5. Layout Specification

### 5.1 Wireframe
```
[ASCII art layout using:
 ┌ ┐ └ ┘ │ ─    for borders
 [ ]              for interactive elements
 { }              for content areas
 ...              for scrollable content
 ●                for focused element on open
]
```

### 5.2 Zone Definitions
| Zone Name | Description | Approximate Size | Scrollable? | Overflow Behavior |
|-----------|-------------|-----------------|-------------|-------------------|

### 5.3 Component Inventory
| Component Name | Type | Zone | Purpose | Required? | Reuses Existing? |
|----------------|------|------|---------|-----------|-------------------|

**Primary focus element on open**: [Description]

---

## 6. States & Variants

| State Name | Trigger | Visual Change | Behavioral Change | Notes |
|------------|---------|--------------|------------------|-------|
| [Loading] | Data not yet available | Skeleton placeholders | No interactions except Close | |
| [Empty] | No items/data | Empty state component | Action buttons hidden | |
| [Populated] | Data present | Content shown | All actions available | |
| [Error] | Data load failed | Error state | Only Retry and Close | |

---

## 7. Interaction Map

### 7.1 Navigation Inputs
| Input | Platform | Action | Visual Response | Audio Cue | Notes |
|-------|----------|--------|-----------------|-----------|-------|

### 7.2 Action Inputs
| Input | Platform | Context | Action | Response | Animation | Audio Cue | Notes |
|-------|----------|---------|--------|----------|-----------|-----------|-------|

### 7.3 State-Specific Behaviors
| State | Input Restriction | Reason |
|-------|------------------|--------|

---

## 8. Data Requirements

| Data Element | Source System | Update Frequency | Who Owns It | Format | Null / Missing Handling |
|--------------|--------------|-----------------|-------------|--------|------------------------|

> **Rule**: This screen must never write directly to any system listed above. All player actions fire events (see Section 9).

---

## 9. Events Fired

| Player Action | Event Fired | Payload | Receiver System | Notes |
|---------------|-------------|---------|-----------------|-------|

---

## 10. Transition & Animation

| Transition | Trigger | Direction / Type | Duration (ms) | Easing | Interruptible? | Skipped by Reduced Motion? |
|------------|---------|-----------------|--------------|--------|----------------|---------------------------|

---

## 11. Input Method Completeness Checklist

**Keyboard**
- [ ] All interactive elements reachable using Tab and arrow keys
- [ ] Tab order follows visual reading order
- [ ] Every mouse action also achievable by keyboard
- [ ] Focus is visible at all times
- [ ] Esc key closes or cancels

**Gamepad**
- [ ] All elements reachable with D-Pad and left stick
- [ ] Face button mapping documented and consistent
- [ ] Controller disconnection handled gracefully

**Mouse**
- [ ] Hover states defined for all interactive elements
- [ ] Clickable hit targets minimum 32x32px (44x44px preferred)

**Touch (if applicable)**
- [ ] All touch targets minimum 44x44px
- [ ] Swipe gestures don't conflict with system navigation

---

## 12. Screen-Level Accessibility Requirements

**Text contrast**:
| Text Element | Background | Required Ratio | Pass? |
|--------------|-----------|---------------|-------|

**Colorblind-unsafe elements**:
| Element | Risk | Mitigation |
|---------|------|------------|

**Focus order**:
[Numbered Tab key sequence]

**Screen reader announcements**:
| State Change | Announcement Text | Timing |
|--------------|------------------|--------|

---

## 13. Localization Considerations

- All text elements must tolerate minimum 40% expansion from English baseline
- RTL layout (Arabic, Hebrew): mirrored layout required
- CJK languages: text may be 20-30% shorter — verify layouts

| Text Element | English Baseline | Max Characters | RTL Behavior | Overflow Behavior |
|--------------|----------------|---------------|--------------|-------------------|

---

## 14. Acceptance Criteria

**Performance**
- [ ] Screen opens within 200ms on minimum-spec hardware
- [ ] Fully interactive within 500ms

**Layout & Rendering**
- [ ] Correct at min and max supported resolution
- [ ] All states render correctly
- [ ] No text overflow in English or longest-translation language

**Input**
- [ ] Keyboard, gamepad, and mouse all fully navigable
- [ ] Focus visible and trapped correctly

**Accessibility**
- [ ] All text passes minimum contrast ratios
- [ ] No color-only information
- [ ] Reduced motion disables animated transitions

---

## 15. Open Questions

| Question | Owner | Deadline | Resolution |
|----------|-------|----------|-----------|
