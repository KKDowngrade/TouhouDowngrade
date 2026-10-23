extends CharacterBody2D

@export var speed: float = 400.0
@export var focus_speed: float = 180.0
var current_speed: float = 0
@export var bullet_scene: PackedScene
@export var fire_rate: float = 0.08
var shot_cooldown: float = 0.0
@onready var cannon: Marker2D = $Cannon

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_pressed("Focus"):
		current_speed = focus_speed
	else:
		current_speed = speed
	velocity = direction * current_speed
	move_and_slide()
	handle_shooting(delta)
	
	
func handle_shooting(delta: float) -> void:
	shot_cooldown -= delta
	if Input.is_action_pressed("Shot") and shot_cooldown <= 0:
		shot()
		shot_cooldown = fire_rate
	
	
func shot() ->  void:
	var bullet := bullet_scene.instantiate()
	bullet.global_position = cannon.global_position
	get_tree().current_scene.add_child(bullet)
