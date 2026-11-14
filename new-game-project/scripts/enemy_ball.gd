extends Enemy

@export var bullet_scene: PackedScene
@onready var markers: Array[Node] = [
	$Marker2D, $Marker2D2, $Marker2D3, $Marker2D4,
	$Marker2D5, $Marker2D6, $Marker2D7, $Marker2D8
]
@onready var timer: Timer = $Timer

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	await get_tree().create_timer(2).timeout
	entity.speed = 0


func _on_area_entered(area: Area2D) -> void:

	EventBus.scratched.emit(scratch)
	
	
func _physics_process(delta: float) -> void:
	position.y += entity.speed * delta

func _on_timer_timeout() -> void:
	for marker in markers:
		var bullet := bullet_scene.instantiate() as Enemy_Bullet
		bullet.direction = global_position.direction_to(marker.global_position)
		bullet.global_position = marker.global_position
		add_sibling(bullet)
