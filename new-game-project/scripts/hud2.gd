extends CanvasLayer

@export var next_level: String
@export var pause_panel: Control
@export var continue_panel: Control
@export var remainign_cont_label: Control
@export var game_over_panel: Control
@onready var points_label: RichTextLabel = $VBoxContainer/PointsLabel
@onready var life_label: RichTextLabel = $VBoxContainer/LifeLabel
@onready var spells_label: RichTextLabel = $VBoxContainer/SpellsLabel
@onready var scratch_label: RichTextLabel = $VBoxContainer/ScratchLabel
@onready var boss_health_panel: HBoxContainer = $ReferenceRect/BossHealthPanel
@onready var boss_health_bar: ProgressBar = $ReferenceRect/BossHealthPanel/BossHealthBar
@onready var power_barr: ProgressBar = $VBoxContainer/HBoxContainer/PowerBarr

var life: int = 3
var score: int = 0
var bombs: int = 3
var max_life: int = 7
var max_bombs: int = 7
var power: int = GameManger.power
var continues: int = 5
var scratch: int = 0



# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause(not pause_panel.visible)


func _ready() -> void:
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
	DialogueManager.show_dialogue_balloon(load("res://resource/level02-0010.dialogue"), "start")
	EventBus.power_uped.connect(_on_power_uped)
	EventBus.scored.connect(_on_scored)
	EventBus.bomb_used.connect(_bomb_used)
	EventBus.life_lost.connect(_life_lost)
	EventBus.scratched.connect(_scratch_updated)
	power_barr.value = power
	print(GameManger.power)
	
func toggle_pause(status: bool) -> void:
	pause_panel.visible = status
	get_tree().paused = status
	
	
func _on_player_died() -> void:
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
