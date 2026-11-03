class_name BombEffect
extends Node2D
@onready var bomb_particles: GPUParticles2D = $BombParticles

func _ready() -> void:
	EventBus.bomb_used.connect(_on_bomb_used)
	
	
func _on_bomb_used(amount: int) -> void:
	bomb_particles.restart()
