extends CharacterBody2D

@export var speed: float = 400.0
@export var focus_speed: float = 180.0
@export var normal_texture: Texture2D
@export var focus_texture: Texture2D
var current_speed: float = 0
@export var bullet_scene: PackedScene
@export var fire_rate: float = 0.08
var shot_cooldown: float = 0.0
@onready var cannon: Marker2D = $Cannon
@onready var sprite_2d: Sprite2D = $Sprite2D
var power_amount: int = 0
var power_level: int = 0
var power_amount_max: int = 100
var power_level_max: int = 5
var attack_points: Array[Vector2]

signal power_uped

func _ready() -> void:
	EventBus.drop_collected.connect(_on_drop_collected)
	power_level_up()


func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("Left", "Right", "Up", "Down")
	
	if Input.is_action_pressed("Focus"):
		current_speed = focus_speed
	else:
		current_speed = speed
	velocity = direction * current_speed
	move_and_slide()
	handle_shooting(delta)
	update_sprite()
	
	
func _on_drop_collected(drop_type: Drop.DropType) -> void:
	match drop_type:
		Drop.DropType.SCORE:
			pass
		Drop.DropType.POWER:
			power_amount += 1
			power_amount = mini(power_amount, power_amount_max)
			EventBus.power_uped.emit(power_amount)
			check_power_level()
		Drop.DropType.HEALTH:
			pass
		Drop.DropType.SPELL:
			pass
		
		
func check_power_level() -> void:
	var current_power_level: int = power_amount / (power_amount_max / power_level_max)
	if current_power_level != power_level:
		power_level = current_power_level
		power_level_up()
	
	
func power_level_up() -> void:
	attack_points.clear()
	
	if power_level == 0:
		attack_points.append(Vector2.ZERO)
	
	if power_level == 1:
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
	
	if power_level >= 2:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
	
	
func update_sprite() -> void:
	if Input.is_action_pressed("Focus"):
		sprite_2d.texture = focus_texture
	else:
		sprite_2d.texture = normal_texture
	
func handle_shooting(delta: float) -> void:
	shot_cooldown -= delta
	if Input.is_action_pressed("Shot") and shot_cooldown <= 0:
		shot()
		shot_cooldown = fire_rate
	
	
func shot() ->  void:

	for origin in attack_points:
		var bullet := bullet_scene.instantiate() as Bullet
		bullet.direction = Vector2(0, lerpf(80, 800, Input.get_action_strength("Focus"))).direction_to(origin)
		bullet.global_position = cannon.global_position + origin
		add_sibling(bullet)
