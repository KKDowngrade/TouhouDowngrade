class_name Drop
extends Area2D

enum DropType{SCORE, POWER, SPELL, HEALTH}

@export var drop_type: DropType
@export var score_texture: Texture2D
@export var power_texture: Texture2D
@export var spell_texture: Texture2D
@export var healt_texture: Texture2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var speed: float = 100.0
@export var direction := Vector2.DOWN

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	_update_sprite()


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _update_sprite() -> void:
	match drop_type:
		DropType.SCORE:
			sprite_2d.texture = score_texture
		DropType.POWER:
			sprite_2d.texture = power_texture
		DropType.SPELL:
			sprite_2d.texture = spell_texture
		DropType.HEALTH:
			sprite_2d.texture = healt_texture

	
func _on_area_entered(area: Area2D) -> void:
	EventBus.drop_collected.emit(drop_type)
	queue_free() #TODO: add feedback
