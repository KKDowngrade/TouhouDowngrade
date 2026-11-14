extends Enemy

@onready var animation_playera: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_playera.play("enemy_a_animation")
	
	
func _physics_process(delta: float) -> void:
	position.y += entity.speed * delta
