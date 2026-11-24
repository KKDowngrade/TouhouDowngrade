extends Node2D
@onready var points_label: RichTextLabel = $HUD/VBoxContainer/PointsLabel
@onready var life_label: RichTextLabel = $HUD/VBoxContainer/LifeLabel
@onready var spells_label: RichTextLabel = $HUD/VBoxContainer/SpellsLabel
@onready var power_barr: ProgressBar = $HUD/VBoxContainer/HBoxContainer/PowerBarr
@onready var scratch_label: RichTextLabel = $HUD/VBoxContainer/ScratchLabel
@export var boss_health_bar: ProgressBar  
@export var boss_name_label: RichTextLabel 
@export var boss_health_panel: HBoxContainer 
@onready var black_fade: ColorRect = $HUD/BlackFade


var life: int = 3
var score: int = 0
var bombs: int = 3
var max_life: int = 7
var max_bombs: int = 7
var power: int = 0
var continues: int = 5
var scratch: int = 0




func _ready() -> void:

	boss_health_panel.hide()
	life = GameManger.life
	bombs = GameManger.bombs
	points_label.text= tr("POINTS_LABEL") % power
	life_label.text=tr("LIFE_LABEL") % life
	spells_label.text=tr("BOMB_LABEL") % bombs
	scratch_label.text=tr("SCRATCH_LABEL") % scratch
	EventBus.power_uped.connect(_power_upated)
	EventBus.scored.connect(_score_updated)
	EventBus.scratched.connect(_scratch_updated)
	EventBus.life_lost.connect(_life_lost)
	EventBus.bomb_used.connect(_bomb_used)
	EventBus.boss_health_changed.connect(_on_boss_health_changed)
	EventBus.player_died.connect(_on_player_died)

	

func _power_upated(amount: int) -> void:
	power_barr.value = amount
	power = amount

	
	
func _score_updated(points: int) -> void:
	print("scored")
	score = points
	points_label.text= tr("POINTS_LABEL") % power
	GameManger.game_data.score = score
	
func _scratch_updated(scratchs: int) -> void:
	scratch += scratchs
	scratch_label.text=tr("SCRATCH_LABEL") % scratch
	
	
func _life_lost(losted_lifes: int) -> void:
	life = losted_lifes
	life_label.text=tr("LIFE_LABEL") % life
	
	
func _bomb_used(bombs_used: int) -> void:
	bombs = bombs_used
	spells_label.text=tr("BOMB_LABEL") % bombs


func _on_boss_health_changed(health: int, max_health:int) -> void:
	boss_health_panel.show()
	boss_health_bar.max_value = max_health
	boss_health_bar.value = health
	
func _on_player_died() -> void:
	GameManger.game_data.score = score
	
	
