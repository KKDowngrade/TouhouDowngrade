extends Enemy
@onready var animation_player1: AnimationPlayer = $AnimationPlayer
@onready var marker_2d: Marker2D = $Marker2D
@export var entityy: Entity
@export var bullet_scene: PackedScene

func _ready() -> void:
	animation_player1.play("enemy_su_animation")
	
	
func _physics_process(delta: float) -> void:
	position.y += entity.speed * delta

func _on_timer_timeout() -> void:
	var bullet1 := bullet_scene.instantiate()
	bullet1.global_position = marker_2d.global_position
	add_sibling(bullet1)
