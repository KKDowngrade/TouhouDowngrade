extends Control

var Fullscreen: bool = false
@onready var screen_button: Button = $VBoxContainer/ScreenContainer/ScreenButton

func _ready() -> void:
	screen_button.text=tr("FULLSCREEN")


func _on_screen_button_pressed() -> void:
	if Fullscreen == false:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Fullscreen = true
		screen_button.text=tr("WINDOWED")
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Fullscreen = false
		screen_button.text=tr("FULLSCREEN")


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func _on_life_box_value_changed(value: float) -> void:
	GameManger.life = int(value)


func _on_bombs_box_value_changed(value: float) -> void:
	GameManger.bombs = int(value)


func _on_english_pressed() -> void:
	TranslationServer.set_locale("en")


func _on_portuguese_pressed() -> void:
	TranslationServer.set_locale("pt")
