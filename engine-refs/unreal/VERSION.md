# Unreal Engine 5.6 Reference

> **Status**: Latest stable release (following UE 5.5)
> **Previous**: Unreal Engine 5.5 (2024)
> **Next**: Unreal Engine 5.7 (September 2025)
> **Official docs**: https://docs.unrealengine.com/5.6/

---

## Overview

Unreal Engine 5.6 bridges UE 5.5 and UE 5.7, refining the experimental features introduced in 5.5 (MegaLights) while preparing major features for 5.7 (Nanite Foliage, AI Assistant). It focuses on stability, performance optimization, and workflow improvements.

---

## Key Features in 5.6

### MegaLights Improvements

MegaLights (experimental in UE 5.5) receives significant refinement in 5.6:

- **Performance optimizations**: Reduced GPU cost per light, improved BVH construction
- **Improved denoising**: Better temporal accumulation for ray-traced shadows
- **More light types**: Extended support beyond area lights
- **Volumetric fog lighting**: MegaLights now supports volumetric fog
- **Translucency support**: Semi-transparent materials cast/receive MegaLights shadows
- **Scalability**: Better LOD and quality tier management via scalability profiles

MegaLights remains **experimental** in 5.6, graduating to **beta** in UE 5.7.

### Animation Tools

- **Skeletal Editor improvements**: More robust bone placement and weight painting
- **Motion Warping**: Improved IK blending for contextual animation matching
- **Animation Blueprint performance**: 15-20% faster evaluation
- **Control Rig**: Better constraint support, new procedural nodes

### Gameplay Ability System (GAS)

- **Multi-threaded ability activation**: Abilities can now be activated on worker threads
- **Improved GameplayCue system**: Lower overhead for frequent cue events
- **Better networking**: Reduced replication bandwidth for active abilities
- **Blueprint integration**: More GAS nodes exposed to Blueprint
- **Ability Task improvements**: Better cancellation and error handling

### Rendering

- **Lumen optimizations**: Reduced GPU cost, especially on consoles
- **Nanite improvements**: Better LOD fallback mesh generation, reduced memory usage
- **Substrate material system**: Refined for production use
- **Virtual Shadow Maps (VSM)**: Improved filtering and reduced leaking
- **Temporal Super Resolution (TSR)**: Better upscaling quality

### Editor Workflow

- **Content Browser** improvements: Better filtering and search
- **Level Editor**: Faster iteration in large levels
- **Blueprint debugging**: Improved breakpoint management
- **Python scripting**: Expanded API surface for automation
- **Unreal Insights**: More comprehensive profiling data

### Physics & Simulation

- **Chaos Physics**: Better cloth simulation stability
- **Chaos Vehicles**: Improved wheel model
- **Enhanced Destruction**: More robust fracture and debris

---

## Blueprint vs C++

### Blueprint

| Strength | Limitation |
|----------|------------|
| Fast iteration | Slower execution |
| Visual dataflow | Hard to diff/merge |
| Designer-friendly | Less control over memory |
| Great for prototyping | Not suitable for hot paths |

**Best for**: UI flow, level scripting, event handling, designer-owned logic.

### C++

| Strength | Limitation |
|----------|------------|
| Maximum performance | Longer compile times |
| Full engine access | Requires C++ expertise |
| Multi-threading support | Memory management |
| Gameplay Ability System | Harder to iterate |

**Best for**: Core gameplay systems, performance-critical code, networking, AI logic.

### Recommended Split

```
┌─────────────────────────┬──────────────────────────┐
│        C++ Layer        │      Blueprint Layer      │
├─────────────────────────┼──────────────────────────┤
│ Core gameplay systems   │ Level scripting          │
│ Networking & replication│ UI flow                  │
│ Performance physics     │ Animation Blueprints     │
│ GAS implementation      │ AI behavior trees        │
│ Data structures         │ Cinematic sequences      │
│ Algorithm-heavy code    │ Tutorial/onboarding flow │
└─────────────────────────┴──────────────────────────┘
```

---

## Key APIs & Systems

### Core

| System | Module | Notes |
|--------|--------|-------|
| `UObject` | Core | Base class for all managed objects |
| `AActor` | Engine | Base class for all placed actors |
| `UActorComponent` | Engine | Modular component architecture |
| `UWorld` | Engine | World/level container |
| `UGameInstance` | Engine | Persistent game-wide singleton |

### Gameplay Ability System (GAS)

| Class | Purpose |
|-------|---------|
| `UGameplayAbility` | An action a character can perform |
| `UGameplayEffect` | Temporary or permanent stat modification |
| `UGameplayAttribute` | Character attribute (health, mana, etc.) |
| `UGameplayAbilitySet` | Collection of starting abilities |
| `UGameplayCue` | Visual/audio feedback for effects |
| `UAbilityTask` | Asynchronous ability sub-operation |
| `UGameplayAbilityTargetActor` | Targeting for abilities |

### Animation

| Class | Purpose |
|-------|---------|
| `UAnimInstance` | Animation blueprint instance |
| `UAnimBlueprint` | Visual animation graph |
| `UAnimMontage` | Sectioned animation playback |
| `UAnimNode` | Animation graph node |
| `UAnimNotify` | Event at animation frame |
| `UControlRig` | Procedural animation controller |
| `UIKRetargeter` | IK chain retargeting |

### Rendering & Materials

| System | Purpose |
|--------|---------|
| `UMaterialInstance` | Material parameter overrides |
| `UMaterialInterface` | Base material class |
| `UNiagaraSystem` | VFX system |
| `UDecalComponent` | Decal rendering |
| `ULightComponent` | All light types |
| `UMegaLightComponent` | MegaLights (5.5+ experimental) |

---

## GAS Quick Reference

### Creating an Ability

**C++:**
```cpp
UCLASS()
class UMyGameplayAbility : public UGameplayAbility
{
    GENERATED_BODY()
    
public:
    virtual void ActivateAbility(
        const FGameplayAbilitySpecHandle Handle,
        const FGameplayAbilityActorInfo* ActorInfo,
        const FGameplayAbilityActivationInfo ActivationInfo,
        const FGameplayEventData* TriggerEventData
    ) override;
    
    UFUNCTION(BlueprintCallable)
    void ApplyDamageToTarget(AActor* Target, float Damage);
};
```

**Blueprint**: Create a Blueprint class derived from `GameplayAbility`.

### Attribute Set

```cpp
UCLASS()
class UMyAttributeSet : public UAttributeSet
{
    GENERATED_BODY()
    
public:
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Attributes")
    FGameplayAttributeData Health;
    
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Attributes")
    FGameplayAttributeData MaxHealth;
    
    UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Attributes")
    FGameplayAttributeData Stamina;
};
```

---

## Performance Guidelines

- **Nanite**: Use for high-poly static geometry; disable for small objects
- **Lumen**: Prefer hardware ray tracing on console; software fallback on lower-end
- **MegaLights**: Experimental — test per-platform performance
- **Blueprint nativization**: Can compile Blueprint to C++ for hot path performance
- **Level streaming**: Break large worlds into streaming levels
- **World Partition**: Required for large open worlds

---

## Migration from 5.5

- **MegaLights** config updated: New performance parameters in `BaseScalability.ini`
- **Skeletal Editor** changes: Weight painting API updated
- **GAS**: Multi-threaded activation may require thread-safety review
- **Substrate**: Material conversion path available in content browser context menu

See [official 5.6 migration notes](https://docs.unrealengine.com/5.6/Migration).
