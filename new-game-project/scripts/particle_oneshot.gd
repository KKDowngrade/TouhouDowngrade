class_name ParticleOneShot
extends Node


@export var scene_root: Node
@export var particles: GPUParticles2D

func _ready() -> void:
	particles.finished.connect(_on_particles_finished)
	particles.one_shot = true
	
	
func _on_particles_finished() -> void:
	scene_root.queue_free()
