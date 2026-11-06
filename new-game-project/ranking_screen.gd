extends Control

const RAKING_ITEM = preload("uid://b86hmdgdevqet")

var game_data: GameData

@onready var raking_list: VBoxContainer = $RakingList
@onready var main_menu_button: Button = $MainMenu


func _ready() -> void:
	main_menu_button.disabled = true
	game_data = GameManger.get_game_data()
	populate_ranks()
	EventBus.score_submitted.connect(_on_rank_submitted)
	
	
func populate_ranks() -> void:
	game_data.ranking.sort()
	
	var current_score: int = game_data.score
	var is_new_record: bool = false
	
	for s in game_data.ranking.keys():
		if current_score > s:
			game_data.ranking[current_score] = ""
			is_new_record = true
			break
	if is_new_record == true:
		game_data.ranking.erase(game_data.ranking.keys()[0])
	game_data.ranking.sort()
	for rank in game_data.ranking.keys():
		var item: RankingItem = RAKING_ITEM.instantiate() as RankingItem
		raking_list.add_child(item)
		raking_list.move_child(item, 0)
		item.set_item(game_data.ranking[rank], rank)
		if rank == current_score:
			item.set_focus()
	
	
func _on_rank_submitted(item: RankingItem) -> void:
	main_menu_button.disabled = false
	game_data.ranking[item.score] = str(item.player_name)
	GameManger.save_data()
	
	

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
