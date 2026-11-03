extends Marker2D

@export var boss_scene: PackedScene


func _on_all_hordes_finished() -> void:
	var boss: EnemyBoss = boss_scene.instantiate() as EnemyBoss
	add_child(boss)
	pass # Replace with function body.
