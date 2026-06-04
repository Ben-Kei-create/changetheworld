# TERRA App Icon Specification

## Concept

**"The Breathing Earth"** — A single, luminous globe viewed slightly from above,
rendered with extreme minimalism. No borders, no pins, no text. Just the planet.

## Visual Description

- **Background:** Deep near-black (#050A1A), slight blue warmth
- **Globe:** Soft sphere, 78% of canvas diameter
  - Ocean: Rich gradient from `#1A4A8A` (deep) → `#2878C8` (lit face)
  - Land: Single green tone `#2A7A38`, slight texture suggestion (no realistic detail)
  - Atmospheric glow: 2px blur of `#5AB4FF` at the lit edge (upper-left)
  - Shadow: Subtle dark crescent, lower-right
- **No outlines.** No white borders. The sphere breathes on its own.

## Sizes Required (Mac App Store)

| Size | File |
|------|------|
| 1024×1024 | AppIcon-1024.png (App Store submission) |
| 512×512 | AppIcon-512.png |
| 256×256 | AppIcon-256.png |
| 128×128 | AppIcon-128.png |
| 64×64 | AppIcon-64.png |
| 32×32 | AppIcon-32.png |
| 16×16 | AppIcon-16.png |

## Design Rationale

**Why minimal?**

In the Mac dock, this icon will appear at 64×64 or smaller.
Complexity disappears. Only the essential gesture survives.
A luminous globe says everything: the whole world. This app.

**Color rationale:**

Deep space background signals depth and gravity — not a casual game.
The green-blue globe is immediately readable as Earth, but the color
temperature (slightly cooler blue than realistic) gives it a painterly,
contemplative quality distinct from photo-realistic apps.

**Comparison reference:** Overcast (podcast app) achieves icon clarity
through radical simplicity. We do the same, but for Earth.

## Icon Do Nots

- No gradients on the background (flat deep space only)
- No "glow" effects on the background
- No text
- No additional elements (stars, orbits, characters)
- No rounded rect mask visible — Apple applies this automatically

## Approved by

Yuna Park (Design Lead) — Sprint 2, 2026-06-04
