extends Node2D

@export var entity: Entity
@export var bullet_scene: PackedScene
@export var path_follow: PathFollow2D
@export var bullet_count: int = 8
@export var bullet_scene2: PackedScene
@onready var cannon_1: Marker2D = $Path2D/PathFollow2D/Area2D/Cannon1
@onready var cannon_2: Marker2D = $Path2D/PathFollow2D/Area2D/Cannon2
@onready var marker_2d: Marker2D = $Path2D/PathFollow2D/Area2D/Marker2D


func _ready() -> void:
	entity.entity_damaged.connect(_on_entity_damaged)
	EventBus.boss_health_changed.emit(entity.health, entity.max_health)


func _physics_process(delta: float) -> void:
	path_follow.progress_ratio += 0.1 * delta


func _on_timer_timeout() -> void:
	var bullet1 := bullet_scene.instantiate()
	add_sibling(bullet1)
	bullet1.global_position = cannon_1.global_position
	
	var bullet2 := bullet_scene.instantiate()
	add_sibling(bullet2)
	bullet2.global_position = cannon_2.global_position
	
	


func _on_entity_damaged() -> void:
	EventBus.boss_health_changed.emit(entity.health, entity.max_health)
	if entity.health <= 0:
		EventBus.boss_killed.emit()


func _on_timer_2_timeout() -> void:
	for i in bullet_count:
		print("shooting")
		var angle := TAU * 1 / bullet_count
		var bullets := bullet_scene2.instantiate()
		bullets.direction = Vector2.RIGHT.rotated(angle)
		bullets.global_position = marker_2d.global_position
		add_sibling(bullets)
