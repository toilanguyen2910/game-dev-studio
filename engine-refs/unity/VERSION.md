# Unity 7 Reference

> **Status**: Latest major release (following Unity 6.x series)
> **Previous**: Unity 6.7 LTS (2026)
> **Official docs**: https://docs.unity.com
> **Version scheme**: Unity 7 represents the major cycle after Unity 6.

---

## Overview

Unity 7 builds on the foundation laid by Unity 6 (released 2024) and the incremental 6.x updates throughout 2025-2026. The 2026 roadmap focused on stability, CoreCLR migration, verified packages, and fewer surprises — "stability before novelty."

Unity 7 consolidates the architectural improvements from the Unity 6 generation: CoreCLR migration, Production Verification (PV), and the new Platform Toolkit.

---

## Key Features

### CoreCLR Migration (Completed)

- **Mono → CoreCLR switch**: Full migration to .NET CoreCLR runtime for significantly improved performance.
- **Better GC**: Server GC mode available for performance-critical games.
- **Native AOT**: Ahead-of-time compilation support for console targets.
- **Modern C#**: Full C# 12/13 support with all modern language features.
- **Performance gains**: 30-50% faster script execution in typical game workloads.

### Production Verification (PV)

- Internal + external studio testing program (Kinetic Games, Ten Chambers, etc.)
- **43% faster regression-fix time** compared to pre-PV workflow
- **54% smaller backlog** since expanding to partner studios
- Built-in diagnostics via the Developer Data Framework
- Engine diagnostics ship active in new projects (manageable at runtime)

### New UI Toolkit (UITK)

- Full UI Toolkit replaces uGUI for new projects
- **Runtime UI Toolk**it: UI Toolkit now fully supports runtime (not just editor)
- CSS-like styling with `USS` files
- Data-binding system with automatic UI updates
- **Visual Tree**: Document-driven UI with event system
- **UI Builder**: Visual editor for UI layouts
- **uGUI compatibility layer**: Legacy uGUI still supported but deprecated

### DOTS (Data-Oriented Technology Stack) Updates

- **ECS → GameObject unification**: Entities can now mix ECS components with traditional MonoBehaviours in the same scene
- **Entities 1.4**: Production-ready ECS with performance improvements
- **Burst Compiler 1.10**: Better debug information, faster compile times
- **Collections 2.5**: New data structures optimized for Burst

### Render Pipelines

#### URP (Universal Render Pipeline) 18

- **Screen Space Global Illumination**: New GI solution for URP
- **SSR improvements**: Better reflection quality
- **Full-screen blit overhaul**: More efficient post-processing pipeline
- **Mesh LOD improvements**: Automated LOD generation
- **LOD cross-fade**: Smooth LOD transitions
- **Volumetric fog**: Native support in URP

#### HDRP (High Definition Render Pipeline) 18

- **Ray tracing improvements**: Better denoising, performance optimization
- **Path tracing**: Production-quality path tracing for cinematics
- **HDR output**: Full HDR display pipeline
- **Virtual texturing**: Streaming texture system

### Platform Toolkit

- Abstracts console and device SDKs
- Cross-platform certification code written once
- Xbox and Nintendo Switch 2 certification confirmed
- Native Nintendo Switch 2 support: HDR, 120 Hz, 4K output
- Android XR and Meta Quest via OpenXR
- Rewritten Apple integration layer (Swift)

### Networking & Multiplayer

- **Unity Gaming Services (UGS)**: Updated with new Lobby, Relay, and Matchmaker APIs
- **Multiplayer Templates**: Ready-to-use networking templates
- **Netcode for GameObjects 2.0**: Production-ready
- **WebRequest defaults to HTTP/2**: Up to 40% less server load

### AI & Tools

- **AI Agents**: New AI-assisted development tools integrated into the editor
- **Muse**: AI assistant for code generation, asset searches, and debugging
- **Sentis**: Neural network inference engine for runtime AI

---

## Scenes & Prefabs

| Concept | Description |
|---------|-------------|
| **Scene** | A game world/level/menu container |
| **Prefab** | Reusable asset template |
| **Prefab Variant** | Inherited modification of a prefab |
| **Nested Prefabs** | Prefabs within prefabs (fully supported) |
| **Scene Template** | Parameterized scene with overrides |

## Key System APIs

| System | Namespace | Notes |
|--------|-----------|-------|
| ECS | `Unity.Entities` | Entities 1.4 |
| Burst | `Unity.Burst` | Burst 1.10 |
| Mathematics | `Unity.Mathematics` | SIMD-optimized math |
| Rendering | `UnityEngine.Rendering` | URP 18 / HDRP 18 |
| UI Toolkit | `UnityEngine.UIElements` | Runtime-ready |
| Input | `UnityEngine.InputSystem` | New input system |
| Physics | `Unity.Physics` | DOTS physics |
| Netcode | `Unity.Netcode` | Netcode for GameObjects 2.0 |

---

## Migration from Unity 6

- **CoreCLR migration**: Test all third-party plugins for CoreCLR compatibility
- **UI Toolkit migration**: Plan migration path from uGUI to UITK for new projects
- **Verified packages**: UPM packages now require signing — verify all package sources
- **Burst 1.10**: Recompile Burst jobs for new compiler
- **WebRequest HTTP/2 default**: May affect servers with HTTP/1.1 expectations

---

## Best Practices

- Use **Production Verification** pipeline for early issue detection
- Prefer **UI Toolkit** over uGUI for new UI development
- Use **Entities + GameObjects interop** for hybrid scenes
- Profile with the **Profiler + Data Framework** combined
- Use **Platform Toolkit** for cross-platform certification code
