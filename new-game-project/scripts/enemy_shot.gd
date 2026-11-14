extends Area2D


@export var deviation: float = 1
@export var frequency: float = 0.01
@export var speed: float = 200

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	position.x += sin(position.y * frequency) * deviation

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
