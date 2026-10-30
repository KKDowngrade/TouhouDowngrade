class_name Enemy
extends Area2D

@export var spaw_points: Array[int]
@export var path: Path2D
@export var deviation: float = 1
@export var frequency: float = 0.01
var scratch: int = 10
@onready var entity: Entity = $Entity
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	animation_player.play("new_animation")

func _on_area_entered(area: Area2D) -> void:
	print("area entred")
	EventBus.scratched.emit(scratch)


func _physics_process(delta: float) -> void:
	position.y += entity.speed * delta
	position.x += sin(position.y * frequency) * deviation


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
