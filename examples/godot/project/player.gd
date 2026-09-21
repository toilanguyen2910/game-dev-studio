extends Node2D

const SPEED := 180.0
const SIZE := Vector2(32.0, 32.0)

func _process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += direction * SPEED * delta
	queue_redraw()

func _draw() -> void:
	draw_rect(Rect2(-SIZE / 2.0, SIZE), Color.CORNFLOWER_BLUE)
