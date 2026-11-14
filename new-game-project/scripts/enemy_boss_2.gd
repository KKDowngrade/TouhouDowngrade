extends Node2D

@export var entity: Entity
@export var bullet_scene: PackedScene
@export var path_follow: PathFollow2D
@onready var cannon_1: Marker2D = $Path2D/PathFollow2D/Area2D/Cannon1
@onready var cannon_2: Marker2D = $Path2D/PathFollow2D/Area2D/Cannon2

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
