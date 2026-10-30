extends Node2D
@onready var points_label: RichTextLabel = $HUD/VBoxContainer/PointsLabel
@onready var life_label: RichTextLabel = $HUD/VBoxContainer/LifeLabel
@onready var spells_label: RichTextLabel = $HUD/VBoxContainer/SpellsLabel
@onready var power_barr: ProgressBar = $HUD/VBoxContainer/HBoxContainer/PowerBarr
@onready var scratch_label: RichTextLabel = $HUD/VBoxContainer/ScratchLabel

var life: int = 3
var score: int = 0
var bombs: int = 3
var max_life: int = 7
var max_bombs: int = 7
var power: int = 0
var continues: int = 5
var scratch: int = 0


func _ready() -> void:
	life = GameManger.life
	bombs = GameManger.bombs
	points_label.text=str("[color=orange_red]Points:[/color] ", score)
	life_label.text=str("[color=red]Lifes:[/color] ", life)
	spells_label.text=str("[color=green]Bombs:[/color] ", bombs)
	scratch_label.text=str("[color=purple]Scratch:[/color] ", scratch)
	EventBus.power_uped.connect(_power_upated)
	EventBus.scored.connect(_score_updated)
	EventBus.scratched.connect(_scratch_updated)
	

func _power_upated(amount: int) -> void:
	power_barr.value = amount
	
	
func _score_updated(points: int) -> void:
	score = points
	points_label.text=str("[color=orange_red]Points:[/color] ", score)
	
func _scratch_updated(scratchs: int) -> void:
	scratch += scratchs
	scratch_label.text=str("[color=purple]Scratch:[/color] ", scratch)
