extends Node2D
@onready var points_label: RichTextLabel = $HUD/VBoxContainer/PointsLabel
@onready var life_label: RichTextLabel = $HUD/VBoxContainer/LifeLabel
@onready var spells_label: RichTextLabel = $HUD/VBoxContainer/SpellsLabel
@onready var power_barr: ProgressBar = $HUD/VBoxContainer/HBoxContainer/PowerBarr

var life: int = 3
var score: int = 0
var bombs: int = 3
var max_life: int = 7
var max_bombs: int = 7
var power: int = 0
var continues: int = 5


func _ready() -> void:
	life = GameManger.life
	bombs = GameManger.bombs
	points_label.text=str("[color=blue]Points:[/color] ", score)
	life_label.text=str("[color=magenta]Lifes:[/color] ", life)
	spells_label.text=str("[color=green]Bombs:[/color] ", bombs)
