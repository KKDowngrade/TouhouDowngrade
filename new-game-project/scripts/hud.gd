extends CanvasLayer

@export var pause_panel: Control
@export var continue_panel: Control

# Called when the node enters the scene tree for the first time.
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause(not pause_panel.visible)


func _ready() -> void:
	pause_panel.hide()
	continue_panel.hide()
	EventBus.player_died.connect(_on_player_died)


func _on_pause_button_pressed() -> void:
	toggle_pause(false)


func _on_player_died() -> void:
	get_tree().paused = true
	continue_panel.show()


func toggle_pause(status: bool) -> void:
	pause_panel.visible = status
	get_tree().paused = status

func _on_continue_yes_pressed() -> void:
	continue_panel.hide()
	get_tree().paused = false
	EventBus.run_continued.emit()


func _on_continue_no_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
