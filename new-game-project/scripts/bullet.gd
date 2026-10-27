extends Area2D

@export var damage: int = 1


@export var speed: float = 900.0
var direction := Vector2.UP

func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.has_node("Entity"):
		var entity: Entity = area.get_node("Entity")
		entity.take_damage(damage)
		queue_free()
