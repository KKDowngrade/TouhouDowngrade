class_name EnemyBoss
extends Node2D


@export var entity: Entity
@export var path_follow: PathFollow2D
@onready var animation_player: AnimationPlayer = $Path2D/PathFollow2D/EnemyArea/AnimationPlayer
@onready var marker_2d: Marker2D = $Path2D/PathFollow2D/EnemyArea/Marker2D
@export var missile_scene: PackedScene
@export var bullet_scene: PackedScene
@onready var bullet_one: Marker2D = $Path2D/PathFollow2D/EnemyArea/BulletOne
@onready var bullet_two: Marker2D = $Path2D/PathFollow2D/EnemyArea/BulletTwo

func _ready() -> void:
	entity.entity_damaged.connect(_on_entity_damaged)
	animation_player.play("Boss1Animation")
	EventBus.boss_health_changed.emit(entity.health, entity.max_health)


func _physics_process(delta: float) -> void:
	path_follow.progress_ratio += 0.1 * delta


func _on_entity_damaged() -> void:
	EventBus.boss_health_changed.emit(entity.health, entity.max_health)


func _on_timer_timeout() -> void:
	var missile := missile_scene.instantiate() as Missile
	add_sibling(missile)
	missile.global_position = marker_2d.global_position


func _on_timer_2_timeout() -> void:
	var bullet1 := bullet_scene.instantiate() as Enemy_Bullet
	add_sibling(bullet1)
	bullet1.global_position = bullet_one.global_position
	
	var bullet2 := bullet_scene.instantiate() as Enemy_Bullet
	add_sibling(bullet2)
	bullet2.global_position = bullet_two.global_position
