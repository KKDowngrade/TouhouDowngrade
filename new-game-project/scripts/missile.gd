class_name Missile
extends Area2D

@export var player: PackedScene
@export var damage: int = 1
@export var speed: float = 500.0
@export var direction := Vector2.DOWN
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var player1: Node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.play("missile_animation")
	EventBus.player_search.emit(self)
	speed = 100
	await  get_tree().create_timer(1).timeout
	speed = 500
	direction = global_position.direction_to(player1.global_position)
	rotation = direction.angle() - PI / 2



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
