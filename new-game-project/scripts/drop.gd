class_name Drop
extends Area2D

enum DropType{SCORE, POWER, SPELL, HEALTH}

@export var drop_type: DropType


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	EventBus.drop_collected.emit(drop_type)
	queue_free() #TODO: add feedback
