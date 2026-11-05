class_name RankingItem
extends HBoxContainer



@export var player_name: String = "bug"
@export var score: int = -1
@export var editable: bool = false

@onready var player_name_line_edit: LineEdit = $PlayerName
@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	player_name_line_edit.editable = editable


func set_item(_player_name: String, _score: int) -> void:
	player_name = _player_name
	score = _score
	update_interface()
	
	
func update_interface() -> void:
	player_name_line_edit.text = player_name
	score_label.text = str(score)
	
	
func set_focus() -> void:
	editable = true
	player_name_line_edit.editable = editable
	player_name_line_edit.grab_focus()

func _on_player_name_text_submitted(new_text: String) -> void:
	if player_name_line_edit.text.length() <= 2:
		set_focus()
	else:
		player_name_line_edit.text = player_name_line_edit.text.to_upper()
		EventBus.score_submitted.emit(self)
		player_name_line_edit.editable = false
	
	
	
	
