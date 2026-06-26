# Godot Engine 4.6 Reference

> **Released**: January 26, 2026
> **Status**: Stable
> **Previous**: Godot 4.5 (September 15, 2025)
> **Official docs**: https://docs.godotengine.org/en/4.6/
> **Release notes**: https://godotengine.org/releases/4.6/

---

## Overview

Godot 4.6 is a mature, performance-focused release centered on polish and production-ready defaults. It shifts focus toward workflow improvements, stability, and deeper rendering tool enhancements rather than large architectural changes.

---

## Key New Features in 4.6

### Rendering

- **Full SSR rewrite** — Screen Space Reflections overhauled to reduce temporal instability and artifacts at grazing angles. Explicit half-resolution and full-resolution modes. Full-resolution mode provides cleaner reflections for high-end realtime visuals and virtual production.
- **Reflection probes** — Octahedral encoding support lowers memory usage while preserving angular resolution. Relevant for large environments with many probes where cubemap memory pressure was previously a limiting factor.
- **Glow compositing** — Now composited before tonemapping rather than after, resulting in more physically consistent highlights in HDR pipelines.
- **Tonemapping** — More configurable, with parameters exposed for artists and TDs who need predictable output across displays.
- **Material debanding** — Improved to reduce banding in low-gradient areas (sky domes, volumetric lighting setups).
- **Direct3D 12 default** — On Windows, D3D12 becomes the default rendering backend. Vulkan remains fully supported.

### Physics

- **Jolt Physics is now the default 3D physics engine** for new projects. Jolt is a third-party rigid-body solver known for determinism and stability. Existing projects do not migrate automatically.
- **Breaking change warning**: Results will differ from Godot Physics. Test existing projects thoroughly before upgrading.

### Editor & Workflow

- **Modern editor theme** — Improved readability, focus, and visual clarity.
- **Floatable docks** — Editor docks and panels are now movable, floatable, and fully rearrangeable.
- **Modular IK framework** — New framework for advanced procedural animation.
- **LibGodot** — Supported way to embed Godot as a library inside another application.

### Audio & Input

- **New joypad foundation** — LED control, motion sensors, and haptic feedback support.
- **Accessibility** — Experimental screen reader support for both the editor and game runtime.

### Packaging & Deployment

- **Delta encoding for Patch PCKs** — Significantly reduces update sizes for patching.
- **Shader baker** — Pre-compiles shaders to reduce first-load delays (~20× faster load in some cases).

---

## Key APIs & Systems Reference

### Rendering APIs

| API | Description | Notes |
|-----|-------------|-------|
| `RenderingServer` | Low-level rendering API | Preferred for custom rendering |
| `World3D` | Environment + camera + scene | Handles SSR, glow, tonemapping |
| `ReflectionProbe` | Capture environment reflections | Octahedral encoding in 4.6 |
| `ScreenSpaceReflection` | SSR quality settings | New half/full resolution modes |
| `VoxelGI` | Voxel-based global illumination | |
| `LightmapGI` | Baked lightmaps | |

### Physics APIs

| API | Description | Notes |
|-----|-------------|-------|
| `Jolt Physics3D` | Default 3D physics engine (4.6+) | Deterministic, stable |
| `Godot Physics3D` | Original Godot physics | Available, not default |
| `PhysicsDirectSpaceState3D` | Raycasts, shape queries | Works with both engines |
| `CharacterBody3D` | Kinematic character controller | |
| `RigidBody3D` | Full physics simulation body | |
| `Area3D` | Detection zone | Overlap, body enter/exit |

### Key Node Types

| Node | Purpose |
|------|---------|
| `Node3D` | Base 3D node |
| `MeshInstance3D` | Mesh renderer |
| `MultiMeshInstance3D` | Instanced rendering (foliage, crowds) |
| `GPUParticles3D` | GPU-accelerated particles |
| `CPUParticles3D` | CPU particles (mobile-friendly) |
| `AnimationTree` | Blend-tree animation state machine |
| `AnimationPlayer` | Timeline-based animation |
| `Skeleton3D` | Skeletal animation rig |
| ` NavigationAgent3D` | Pathfinding agent |
| `TileMapLayer` | 2D tilemap (reworked collision in 4.5+) |

### Multi-threading Notes

- **Thread-safe**: `ResourceLoader`, `ResourceSaver`, `RenderingServer` calls from threads
- **Not thread-safe**: Scene tree modifications, node creation/destruction
- **Use `call_deferred`** to invoke main-thread-only methods from threads
- **`WorkerThreadPool`** for general parallel work
- **GDScript 2.0** fully supports threads via `Thread` class

---

## Performance Guidelines

- **Draw calls**: Keep under 2000 for mobile, 5000+ for desktop
- **Materials**: Share materials across meshes — each unique material = a new draw call
- **LOD**: Use `VisibleOnScreenNotifier3D` + manual LOD switching or `MultiMesh` for instances
- **Physics**: Use `Area3D` for detection over `RigidBody3D` when possible
- **Vulkan vs D3D12**: D3D12 default on Windows; Vulkan preferred on Linux and for VR

---

## Migration from 4.5

Most projects are compatible. Key breaking changes:
- Jolt Physics default (test physics behaviour differences)
- D3D12 default on Windows (test rendering backend)
- SSR rewrite (may change reflection appearance)

See [official migration guide](https://docs.godotengine.org/en/4.6/tutorials/migrating/upgrading_to_godot_4.6.html).
