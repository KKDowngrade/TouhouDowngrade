class_name Entity
extends Node

signal died

@export var entity_owner: Node2D
@export var health: int = 1
@export var speed: float = 200
@export var bullet_damage: int = 1
@export var drop: PackedScene
@export var drop_types: Array[Drop.DropType]

var tween: Tween = create_tween()





func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		feedback_damage()
		died.emit()
		

func feedback_damage() -> void:
	if not tween.is_valid():
		tween = create_tween()
	tween.tween_property(entity_owner, "modulate", Color.WHITE * 4, 0.1)
	await  tween.finished
	var drop_offset: float = 10
	var drop_index: int = 0
	for _type in drop_types:
		var _drop: Drop = drop.instantiate()
		_drop.drop_type = _type
		_drop.global_position = entity_owner.global_position
		entity_owner.add_sibling(_drop)
		_drop.position.x += drop_offset + drop_index
		drop_index += 1
	
	
	entity_owner.queue_free() # TODO: EXPLODE
