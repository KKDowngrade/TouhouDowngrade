class_name Player
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
var power_amount_max: int = 1000
var power_level_max: int = 10
var attack_points: Array[Vector2]
var score: int = 0
var scratch: int = 0
var lifes: int = 0
var invencible: bool = false
@export var invencibility_time: float = 2.0
@export var flash_interval: float = 0.1
var flash_tween: Tween

func _ready() -> void:
	lifes = GameManger.life
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
			score += 10
			EventBus.scored.emit(score)
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
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
	
	if power_level == 2:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
	
	if power_level == 3:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
	
	if power_level == 4:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
		attack_points.append(Vector2(-40, 0).rotated(-0.5))
		attack_points.append(Vector2(40, 0).rotated(0.5))
	
	if power_level == 5:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
		attack_points.append(Vector2(-40, 0).rotated(-0.5))
		attack_points.append(Vector2(40, 0).rotated(0.5))
		attack_points.append(Vector2(-50, 0).rotated(-0.5))
		attack_points.append(Vector2(50, 0).rotated(0.5))
		
	if power_level == 6:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
		attack_points.append(Vector2(-40, 0).rotated(-0.5))
		attack_points.append(Vector2(40, 0).rotated(0.5))
		attack_points.append(Vector2(-50, 0).rotated(-0.5))
		attack_points.append(Vector2(50, 0).rotated(0.5))
		attack_points.append(Vector2(-60, 0).rotated(-0.5))
		attack_points.append(Vector2(60, 0).rotated(0.5))
		
	if power_level == 7:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
		attack_points.append(Vector2(-40, 0).rotated(-0.5))
		attack_points.append(Vector2(40, 0).rotated(0.5))
		attack_points.append(Vector2(-50, 0).rotated(-0.5))
		attack_points.append(Vector2(50, 0).rotated(0.5))
		attack_points.append(Vector2(-60, 0).rotated(-0.5))
		attack_points.append(Vector2(60, 0).rotated(0.5))
		attack_points.append(Vector2(-70, 0).rotated(-0.5))
		attack_points.append(Vector2(70, 0).rotated(0.5))
		
	if power_level == 8:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
		attack_points.append(Vector2(-40, 0).rotated(-0.5))
		attack_points.append(Vector2(40, 0).rotated(0.5))
		attack_points.append(Vector2(-50, 0).rotated(-0.5))
		attack_points.append(Vector2(50, 0).rotated(0.5))
		attack_points.append(Vector2(-60, 0).rotated(-0.5))
		attack_points.append(Vector2(60, 0).rotated(0.5))
		attack_points.append(Vector2(-70, 0).rotated(-0.5))
		attack_points.append(Vector2(70, 0).rotated(0.5))
		attack_points.append(Vector2(-80, 0).rotated(-0.5))
		attack_points.append(Vector2(80, 0).rotated(0.5))
	
	if power_level == 9:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
		attack_points.append(Vector2(-40, 0).rotated(-0.5))
		attack_points.append(Vector2(40, 0).rotated(0.5))
		attack_points.append(Vector2(-50, 0).rotated(-0.5))
		attack_points.append(Vector2(50, 0).rotated(0.5))
		attack_points.append(Vector2(-60, 0).rotated(-0.5))
		attack_points.append(Vector2(60, 0).rotated(0.5))
		attack_points.append(Vector2(-70, 0).rotated(-0.5))
		attack_points.append(Vector2(70, 0).rotated(0.5))
		attack_points.append(Vector2(-80, 0).rotated(-0.5))
		attack_points.append(Vector2(80, 0).rotated(0.5))
		attack_points.append(Vector2(-90, 0).rotated(-0.5))
		attack_points.append(Vector2(90, 0).rotated(0.5))
		
	if power_level >= 10:
		attack_points.append(Vector2.ZERO)
		attack_points.append(Vector2(-10, 0).rotated(-0.5))
		attack_points.append(Vector2(10, 0).rotated(0.5))
		attack_points.append(Vector2(-20, 0).rotated(-0.5))
		attack_points.append(Vector2(20, 0).rotated(0.5))
		attack_points.append(Vector2(-30, 0).rotated(-0.5))
		attack_points.append(Vector2(30, 0).rotated(0.5))
		attack_points.append(Vector2(-40, 0).rotated(-0.5))
		attack_points.append(Vector2(40, 0).rotated(0.5))
		attack_points.append(Vector2(-50, 0).rotated(-0.5))
		attack_points.append(Vector2(50, 0).rotated(0.5))
		attack_points.append(Vector2(-60, 0).rotated(-0.5))
		attack_points.append(Vector2(60, 0).rotated(0.5))
		attack_points.append(Vector2(-70, 0).rotated(-0.5))
		attack_points.append(Vector2(70, 0).rotated(0.5))
		attack_points.append(Vector2(-80, 0).rotated(-0.5))
		attack_points.append(Vector2(80, 0).rotated(0.5))
		attack_points.append(Vector2(-90, 0).rotated(-0.5))
		attack_points.append(Vector2(90, 0).rotated(0.5))
		attack_points.append(Vector2(-100, 0).rotated(-0.5))
		attack_points.append(Vector2(100, 0).rotated(0.5))
	
	
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


func _on_scratch_area_body_entered(body: Node2D) -> void:
	print(body)
	scratch += 10
	score += 50
	EventBus.scored.emit(score)
	EventBus.scratched.emit(scratch)
	
	
func _taken_damage() -> void:
	if invencible:
		return
	invencible = true
	lifes -= 1
	global_position = Vector2(332, 630)
	
	_play_flash()
	
	await  get_tree().create_timer(invencibility_time).timeout
	invencible = false
	
	
func _play_flash() -> void:
	if flash_tween and flash_tween.is_valid():
		flash_tween.kill()
	var flashes: int = max(1, int(invencibility_time / (flash_interval * 2.0)))
	
	flash_tween = create_tween()
	flash_tween.set_loops(flashes)
	flash_tween.tween_property(sprite_2d, "modulate", Color(4, 4, 4, 1), flash_interval)
	flash_tween.tween_property(sprite_2d, "modulate", Color.WHITE, flash_interval)
	flash_tween.finished.connect(func() -> void: sprite_2d.modulate = Color.WHITE)
	
	
