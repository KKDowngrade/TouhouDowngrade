extends CanvasLayer

@export var next_level: String
@export var pause_panel: Control
@export var continue_panel: Control
@export var remainign_cont_label: Control
@export var game_over_panel: Control
@export var fade_time: int = 2
@export var firsti_dialogue: String
@export var last_dialogue: String
@onready var points_label: RichTextLabel = $VBoxContainer/PointsLabel
@onready var life_label: RichTextLabel = $VBoxContainer/LifeLabel
@onready var spells_label: RichTextLabel = $VBoxContainer/SpellsLabel
@onready var scratch_label: RichTextLabel = $VBoxContainer/ScratchLabel
@onready var boss_health_panel: HBoxContainer = $ReferenceRect/BossHealthPanel
@onready var boss_health_bar: ProgressBar = $ReferenceRect/BossHealthPanel/BossHealthBar
@onready var power_barr: ProgressBar = $VBoxContainer/HBoxContainer/PowerBarr
@onready var black_fade: ColorRect = $BlackFade

var life: int = 3
var score: int = 0
var bombs: int = 3
var max_life: int = 7
var max_bombs: int = 7
var power: int = GameManger.power
var continues: int = 5
var scratch: int = 0
var boss_killed: bool = false



# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause(not pause_panel.visible)


func _ready() -> void:
	fade_in()
	life = GameManger.life
	score = GameManger.score
	scratch = GameManger.scratch
	bombs = GameManger.bombs
	power = GameManger.power
	game_over_panel.hide()
	pause_panel.hide()
	continue_panel.hide()
	boss_health_panel.hide()
	EventBus.boss_health_changed.connect(_on_boss_health_changed)
	points_label.text= tr("POINTS_LABEL") % power
	life_label.text=tr("LIFE_LABEL") % life
	spells_label.text=tr("BOMB_LABEL") % bombs
	scratch_label.text=tr("SCRATCH_LABEL") % scratch
	EventBus.boss_killed.connect(_on_boss_killed)
	DialogueManager.show_dialogue_balloon(load(firsti_dialogue), "start")
	EventBus.power_uped.connect(_on_power_uped)
	EventBus.scored.connect(_on_scored)
	EventBus.bomb_used.connect(_bomb_used)
	EventBus.life_lost.connect(_life_lost)
	EventBus.scratched.connect(_scratch_updated)
	EventBus.player_died.connect(_on_player_died)
	power_barr.value = power
	print(GameManger.power)
	
func toggle_pause(status: bool) -> void:
	pause_panel.visible = status
	get_tree().paused = status
	
	
func _on_player_died() -> void:
	GameManger.game_data.score = score
	if continues > 0:
		get_tree().paused = true
		remainign_cont_label.text=tr("CONTINUES_REMAINING") % continues
		continue_panel.show()
	else: 
		game_over_panel.show()
		
		
func _on_boss_health_changed(health: int, max_health:int) -> void:
	boss_health_panel.show()
	boss_health_bar.max_value = max_health
	boss_health_bar.value = health
	
	
func _on_boss_killed() -> void:
	if boss_killed == false:
		boss_killed = true
		get_tree().call_group("enemy", "take_damage", 10)
		DialogueManager.show_dialogue_balloon(load(last_dialogue), "start")
		await DialogueManager.dialogue_ended
		fade_out()
		await  get_tree().create_timer(fade_time).timeout
		get_tree().change_scene_to_file(next_level)
	
	
func _on_power_uped(amount: int) -> void:
	power_barr.value = amount
	power = amount
	
	

func _on_scored(points: int) -> void:
	score = points
	points_label.text=str("[color=orange_red]Points:[/color] ", score)
	GameManger.game_data.score = score
	
	
func _bomb_used(bombs_used: int) -> void:
	bombs = bombs_used
	spells_label.text=str("[color=green]Bombs:[/color] ", bombs)
	
func _life_lost(losted_lifes: int) -> void:
	life = losted_lifes
	life_label.text=str("[color=red]Lifes:[/color] ", life)
	
	
	
func _scratch_updated(scratchs: int) -> void:
	scratch += scratchs
	scratch_label.text=str("[color=purple]Scratch:[/color] ", scratch)
	
	
func fade_in() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(black_fade, "modulate:a", 0.0, fade_time)
	

func fade_out() -> void:
	
	var tween: Tween = create_tween()
	tween.tween_property(black_fade, "modulate:a", 1.0, fade_time)
	
	



func _on_continue_yes_pressed() -> void:
	continues -= 1
	continue_panel.hide()
	get_tree().paused = false
	EventBus.run_continued.emit()


func _on_continue_no_pressed() -> void:
	EventBus.game_finished.emit()
	await  get_tree().physics_frame
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ranking_screen.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_game_over_button_pressed() -> void:
	EventBus.game_finished.emit()
	await  get_tree().physics_frame
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ranking_screen.tscn")


func _on_pause_button_pressed() -> void:
	toggle_pause(false)
