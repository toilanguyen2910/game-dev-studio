# GDScript 2.0 Reference (Godot 4.6)

> **Documentation**: https://docs.godotengine.org/en/4.6/tutorials/scripting/gdscript/
> **Version**: GDScript 2.0 (Godot 4.x series)

---

## Overview

GDScript 2.0 is Godot's primary scripting language, redesigned for Godot 4.x with a proper type system, lambdas, traits, and significant performance improvements over GDScript 1.x (Godot 3.x).

---

## Type System

### Static Typing

GDScript 2.0 supports **optional static typing**. Types are enforced at runtime but provide editor autocompletion, error detection, and performance optimization hints.

```gdscript
var health: int = 100
var speed: float = 5.0
var name: String = "Hero"
var is_alive: bool = true

# Arrays with type hints
var inventory: Array[Item] = []
var damage_numbers: Array[float] = []

# Dictionary with typed keys/values
var stats: Dictionary[String, Variant] = {}

# Typed function signatures
func take_damage(amount: float, source: Node) -> bool:
    health -= amount
    return health <= 0
```

### Variant and Built-in Types

| Type | Description |
|------|-------------|
| `Variant` | Any type (default for untyped) |
| `int` | 64-bit signed integer |
| `float` | 64-bit floating point (float in C++) |
| `bool` | Boolean |
| `String` | UTF-8 string |
| `Vector2`, `Vector3` | 2D/3D vector |
| `Vector2i`, `Vector3i` | Integer vector |
| `Color` | RGBA color |
| `Rect2`, `Rect2i` | 2D rectangle |
| `Transform2D`, `Transform3D` | Transformation |
| `Plane` | 3D plane |
| `Quaternion` | Quaternion rotation |
| `AABB` | Axis-aligned bounding box |
| `Basis` | 3x3 rotation/scale matrix |
| `Projection` | 4x4 projection matrix |
| `NodePath` | Path to a node |
| `RID` | Rendering server resource ID |
| `Signal` | Reference to a signal |
| `Callable` | Reference to a callable method |
| `Array[Type]` | Typed array |
| `Dictionary[KeyType, ValueType]` | Typed dictionary |
| `PackedByteArray`, `PackedInt32Array`, etc. | Optimized data arrays |

### Enums

```gdscript
enum State { IDLE, WALKING, RUNNING, ATTACKING }
enum Direction { LEFT = -1, RIGHT = 1, UP, DOWN }

var current_state: State = State.IDLE
```

### Resource Types (Classes)

```gdscript
extends Resource
class_name WeaponStats

@export var damage: float = 10.0
@export var fire_rate: float = 1.0
@export var ammo_type: String = "standard"
```

---

## Lambda Functions (Closures)

GDScript 2.0 supports lambda expressions using the `func` keyword inline:

```gdscript
var double = func(x: int) -> int: return x * 2
print(double.call(5))  # 10

# With type inference
var sorted = items.filter(func(item): return item.price > 100)

# Capturing variables
var multiplier = 3
var triple = func(x: int) -> int: return x * multiplier

# Lambda with multiple statements using pass
var process = func(value: float) -> float:
    var result = value * 2.0
    result += 1.0
    return result
```

**Performance note**: Lambdas allocate each time they are created. For hot paths, pre-create lambdas as member variables.

---

## Traits & Composition

Traits enable code reuse without inheritance:

```gdscript
# trait.gd
trait Damageable:
    var health: int = 100
    
    func take_damage(amount: int) -> void:
        health -= amount
        if health <= 0:
            _on_death()
    
    func _on_death() -> void:
        pass  # Override in implementing class

# Using a trait
extends CharacterBody3D
uses Damageable

func _on_death() -> void:
    queue_free()
```

**Note**: Traits are resolved at compile time. A trait can declare virtual methods (like `_on_death`) that the implementing class must define.

---

## Signals

```gdscript
signal health_changed(old_value: int, new_value: int)
signal died()

func apply_damage(amount: int) -> void:
    var old = health
    health -= amount
    health_changed.emit(old, health)
    if health <= 0:
        died.emit()

# One-shot connection
health_changed.connect(func(old, new): print("HP:", old, "->", new), CONNECT_ONE_SHOT)

# Custom signal with binding
hurt_sound.connect(_play_sound.bind("hit"))
```

**Best practice**: Always type signal parameters for editor autocompletion.

---

## Async/Await

GDScript 2.0 has native async/await support:

```gdscript
func load_level(path: String) -> void:
    var scene = await ResourceLoader.load_threaded_request(path)
    get_tree().change_scene_to_file(path)

func delayed_action(delay: float) -> void:
    await get_tree().create_timer(delay).timeout
    print("Timer finished")

# Parallel awaits
var result1 = await some_async_func()
var result2 = await another_async_func()

# Await on signals
await button.pressed
```

---

## Performance Tips

### Hot Path Optimization

1. **Use typed variables**: `var x: float = 1.0` is ~2x faster than `var x = 1.0`
2. **Prefer `for` over `while`**: `for` loops are optimized
3. **Minimize allocations in `_process`**: Cache nodes and resources
4. **Use `@tool` sparingly**: Tool scripts run in the editor
5. **Use `Packed*Array` over `Array`**: 10-100x faster for bulk data
6. **Prefer `match` over nested `if/elif`**: Match compiles to a jump table
7. **Use `@onready var` for node references**: Avoids null references at init

### Memory Management

```gdscript
# Good: Pre-load once
@onready var sword_scene = preload("res://items/sword.tscn")

# Bad: Load every time
func spawn_sword():
    var sword = load("res://items/sword.tscn")  # Don't do this
```

### Export Performance

```gdscript
# Use @export for inspector-exposed values (fast)
@export var damage: float = 10.0

# Avoid @export for large data structures
# Use Resource files instead
```

---

## Debugging

```gdscript
# Print with type info
print("health = ", health, " type = ", typeof(health))

# Breakpoints
breakpoint  # Halt execution in debugger

# Assertions
assert(health > 0, "Health must be positive")

# Profiling markers
Engine.get_main_loop().add_profiler_span("combat_physics", func():
    # Code to profile
    pass
)
```

---

## Common Patterns

### Singleton (Autoload)

```gdscript
# In Project Settings > Autoload
extends Node
# Automatically available as global singleton
```

### State Machine

```gdscript
extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State

func _ready() -> void:
    current_state = initial_state
    current_state.enter()

func change_state(new_state: State) -> void:
    current_state.exit()
    current_state = new_state
    current_state.enter()
```

### Object Pooling

```gdscript
class ObjectPool:
    var _pool: Array[Node] = []
    var _scene: PackedScene
    
    func acquire() -> Node:
        if _pool.is_empty():
            return _scene.instantiate()
        return _pool.pop_back()
    
    func release(obj: Node) -> void:
        obj.hide()
        _pool.append(obj)
```
