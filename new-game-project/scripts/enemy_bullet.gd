class_name Enemy_Bullet
extends Area2D

@export var damage: int = 1


@export var speed: float = 500.0
@export var direction := Vector2.DOWN

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()



func _on_body_entered(body: Node2D) -> void:
	body._taken_damage()
