extends Node2D

enum State {SPAWNING, WAITING}

signal all_hordes_finished

@export var hordes: Array[HordeData]
@export var hordes_finished: Array[HordeData]

var timer_elapsed: float = 0
var next_horde: HordeData
var next_horde_time: float = 0
var current_state: State = State.WAITING

func _ready() -> void:
	get_next_horde()
	DialogueManager.dialogue_started.connect(_on_dialogue_started)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	

func  _physics_process(delta: float) -> void:
	if current_state == State.WAITING:
		return
	
	if timer_elapsed > 0 and timer_elapsed >= next_horde_time:
		spawn_horde()
		get_next_horde()
	timer_elapsed += delta
	
	
func get_next_horde() -> void:
	if hordes.size() <= 0:
		get_tree().create_timer(10).timeout.connect(all_hordes_finished.emit)
		set_physics_process(false)
		return
	next_horde = hordes[0]
	next_horde_time += next_horde.time
	
	
func spawn_horde() -> void:
	var horde: HordeData = hordes.pop_front()
	for i in horde.amount:
		for j in horde.spawn_per_wave:
			var enemy : Enemy = horde.enemies.pick_random().enemy_scene.instantiate()
			var point : int = horde.spanw_points[j % horde.spanw_points.size()]
			var spawn_position : Vector2 = get_child(point).global_position
			enemy.global_position = spawn_position
			add_sibling(enemy)
		await  get_tree().create_timer(horde.wave_delay).timeout
	
	
func _on_dialogue_started(_dialougue) -> void:
	current_state = State.WAITING
	

func _on_dialogue_ended(_dialougue) -> void:
	current_state = State.SPAWNING
