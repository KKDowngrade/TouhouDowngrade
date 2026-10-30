extends Enemy



@onready var animation_player_shooter: AnimationPlayer = $AnimationPlayer
@export var bullet_scene: PackedScene
@onready var cannon_1: Marker2D = $Cannon1
@onready var cannon_2: Marker2D = $Cannon2


func _ready() -> void:
	animation_player_shooter.play("shooter_animation")
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area2D) -> void:

	EventBus.scratched.emit(scratch)
	
func _physics_process(delta: float) -> void:
	position.y += entity.speed * delta
	position.x += sin(position.y * frequency) * deviation

	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	var bullet1 := bullet_scene.instantiate() as Enemy_Bullet
	bullet1.global_position = cannon_1.global_position
	add_sibling(bullet1)
	var bullet2 := bullet_scene.instantiate() as Enemy_Bullet
	bullet2.global_position = cannon_2.global_position
	add_sibling(bullet2)
