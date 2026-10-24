extends Control

var fullscreen: bool = false

@onready var screen_button: Button = $VBoxContainer/ScreenButton

func _ready() -> void:
	screen_button.text=("FullScreen")
	
func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_screen_button_pressed() -> void:
	if fullscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		fullscreen = true
		screen_button.text=("Windowed")
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		fullscreen = false
		screen_button.text=("Fullscreen")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_controls_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn")
