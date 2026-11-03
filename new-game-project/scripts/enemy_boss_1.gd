class_name EnemyBoss
extends Node2D


@export var entity: Entity
@export var path_follow: PathFollow2D

func _ready() -> void:
	entity.entity_damaged.connect(_on_entity_damaged)


func _physics_process(delta: float) -> void:
	path_follow.progress_ratio += 0.1 * delta


func _on_entity_damaged() -> void:
	EventBus.boss_health_changed.emit(entity.health, entity.max_health)
