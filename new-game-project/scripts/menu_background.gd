extends Node3D
@onready var marker_3d: Marker3D = %Marker3D


func _physics_process(delta: float) -> void:
	marker_3d.rotate(Vector3.RIGHT, -delta * 0.1)
