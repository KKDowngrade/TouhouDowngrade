class_name WorldBackground
extends Node3D

@onready var camera_pivot: Marker3D = %CameraPivot

func _physics_process(delta: float) -> void:
	camera_pivot.rotate(Vector3.RIGHT, -delta * 0.1)
