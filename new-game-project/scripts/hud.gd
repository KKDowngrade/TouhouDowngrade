extends CanvasLayer

@export var next_level: String
@export var pause_panel: Control
@export var continue_panel: Control
@export var remainign_cont_label: Control
@export var game_over_panel: Control
@export var fade_time: int = 2
@onready var points_label: RichTextLabel = $VBoxContainer/PointsLabel
@onready var life_label: RichTextLabel = $VBoxContainer/LifeLabel
@onready var spells_label: RichTextLabel = $VBoxContainer/SpellsLabel
@onready var scratch_label: RichTextLabel = $VBoxContainer/ScratchLabel
var boss_killed: bool = false
@onready var black_fade: ColorRect = $BlackFade
@onready var continue_yes: Button = $ReferenceRect/ContinuePanel/HBoxContainer/ContinueYes
@onready var game_over_button: Button = $ReferenceRect/GameOverPanel/GameOverButton
@onready var pause_button: Button = $ReferenceRect/PausePanel/PauseButton


var life: int = 3
var score: int = 0
var bombs: int = 3
var max_life: int = 7
var max_bombs: int = 7
var power: int = 0
var continues: int = 5
var scratch: int = 0



# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		pause_button.grab_focus()
		toggle_pause(not pause_panel.visible)
	


func _ready() -> void:
	game_over_panel.hide()
	pause_panel.hide()
	continue_panel.hide()
	EventBus.player_died.connect(_on_player_died)
	EventBus.boss_killed.connect(_on_boss_killed)
	fade_in()
	DialogueManager.show_dialogue_balloon(load("res://resource/level01-0010.dialogue"), "start")


func _on_pause_button_pressed() -> void:
	toggle_pause(false)


func _on_player_died() -> void:
	if continues > 0:
		get_tree().paused = true
		remainign_cont_label.text=tr("CONTINUES_REMAINING") % continues
		continue_panel.show()
		continue_yes.grab_focus()
	else: 
		game_over_panel.show()
		game_over_button.grab_focus()


func toggle_pause(status: bool) -> void:
	pause_panel.visible = status
	get_tree().paused = status

func _on_continue_yes_pressed() -> void:
	continues -= 1
	continue_panel.hide()
	get_tree().paused = false
	EventBus.run_continued.emit()


func _on_continue_no_pressed() -> void:
	EventBus.game_finished.emit()
	print(GameManger.game_data.score)
	print(GameManger.score)
	await  get_tree().physics_frame
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ranking_screen.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_game_over_button_pressed() -> void:
	EventBus.game_finished.emit()
	print(GameManger.game_data.score)
	print(score)
	
	await  get_tree().physics_frame
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ranking_screen.tscn")
	
	
func _on_boss_killed() -> void:
	if boss_killed == false:
		boss_killed = true
		get_tree().call_group("enemy", "take_damage", 10)
		DialogueManager.show_dialogue_balloon(load("res://resource/level01-0020.dialogue"), "start")
		await DialogueManager.dialogue_ended
		fade_out()
		await  get_tree().create_timer(fade_time).timeout
		get_tree().change_scene_to_file(next_level)
		
		
func fade_in() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(black_fade, "modulate:a", 0.0, fade_time)
	

func fade_out() -> void:
	
	var tween: Tween = create_tween()
	tween.tween_property(black_fade, "modulate:a", 1.0, fade_time)
