extends Marker2D

@export var boss_scene: PackedScene


func _on_enemy_spawner_all_hordes_finished() -> void:
	var boss = boss_scene.instantiate()
	add_child(boss)
