class_name Enemy
extends Area2D

@export var spaw_points: Array[int]
@export var path: Path2D
@export var deviation: float = 1
@export var frequency: float = 0.01

@onready var entity: Entity = $Entity


func _physics_process(delta: float) -> void:
	position.y += entity.speed * delta
	position.x += sin(position.y * frequency) * deviation
