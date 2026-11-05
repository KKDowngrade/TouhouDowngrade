extends Node

const SAVE_PATH: String = "user://save_data.tres"

var life: int = 3
var bombs: int = 3
@export var game_data: GameData = GameData.new()


func _ready() -> void:
	load_data()
	EventBus.game_finished.connect(_on_game_finished)



func save_data() -> void:
	ResourceSaver.save(game_data, SAVE_PATH)
	
func save_default_data() -> void:
	var _game_data: GameData = GameData.new()
	_game_data.ranking[999] = "KIM"
	_game_data.ranking[13] = "MAU"
	_game_data.ranking[1] = "HUM"
	_game_data.ranking[77] = "BLUT"
	_game_data.ranking[79] = "ANA"
	_game_data.ranking[76] = "LUU"
	_game_data.ranking[72] = "NAD"
	_game_data.ranking[99] = "BIA"
	_game_data.ranking[71] = "GOS"
	_game_data.ranking[78] = "LPP"

	game_data = _game_data
	save_data()

func load_data() -> void:
	if ResourceLoader.exists(SAVE_PATH):
		game_data = ResourceLoader.load(SAVE_PATH)
	else:
		save_default_data()	
	
	
	var _save: Resource = ResourceLoader.load(SAVE_PATH)
	
	if _save == null:
		save_default_data()
		
	else:
		game_data = _save
		
		
func get_game_data() -> GameData:
	return game_data



func _on_game_finished() -> void:
	pass
	
	
func _on_score_recorded(player_name: String) -> void:
	game_data.ranking[game_data.score] = player_name
	
	

	
	
