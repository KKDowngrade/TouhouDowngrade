extends Area2D
@export var speed: float = 900.0
var direction := Vector2.UP

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
