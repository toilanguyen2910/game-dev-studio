extends Node2D

const SPEED := 240.0
const SIZE := Vector2(36.0, 36.0)
const VIEW_SIZE := Vector2(960.0, 540.0)

func _ready() -> void:
	position = VIEW_SIZE / 2.0

func _process(delta: float) -> void:
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += direction * SPEED * delta
	position = position.clamp(SIZE / 2.0, VIEW_SIZE - SIZE / 2.0)
	queue_redraw()

func _draw() -> void:
	var font := ThemeDB.fallback_font
	var origin := -position
	for x in range(0, 961, 48):
		draw_line(Vector2(x, 0) + origin, Vector2(x, 540) + origin, Color(0.12, 0.17, 0.24), 1.0)
	for y in range(0, 541, 48):
		draw_line(Vector2(0, y) + origin, Vector2(960, y) + origin, Color(0.12, 0.17, 0.24), 1.0)
	draw_string(font, Vector2(48, 65) + origin, "GAME DEV STUDIO", HORIZONTAL_ALIGNMENT_LEFT, -1, 32, Color(0.9, 0.96, 1.0))
	draw_string(font, Vector2(48, 96) + origin, "A tiny playable Godot prototype", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.6, 0.72, 0.82))
	draw_string(font, Vector2(48, 500) + origin, "Move with arrow keys", HORIZONTAL_ALIGNMENT_LEFT, -1, 18, Color(0.6, 0.72, 0.82))
	draw_circle(Vector2(750, 290) + origin, 42.0, Color(0.12, 0.33, 0.31))
	draw_circle(Vector2(750, 290) + origin, 22.0, Color(0.3, 0.95, 0.72))
	draw_rect(Rect2(-SIZE / 2.0, SIZE), Color(0.33, 0.68, 1.0))
