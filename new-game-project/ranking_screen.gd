extends Control

const RAKING_ITEM = preload("uid://b86hmdgdevqet")

var game_data: GameData
@export var leaderboard_internal_name: String
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
	
	var online_data: GameData = await get_online_game_data()
	print(online_data.ranking)
	if online_data.ranking.keys().size() < 10:
		online_data.ranking[current_score] = ""
		is_new_record = true
	else:
		for s in online_data.ranking.keys():
			if current_score > s:
				online_data.ranking[current_score] = ""
				is_new_record = true
				break
		if is_new_record == true:
			online_data.ranking.erase(online_data.ranking.keys()[0])
	online_data.ranking.sort()
	
	#for s in online_data.ranking.keys():
		#for i in game_data.ranking.keys():
			#if s > i:
				#game_data.ranking[s] = online_data.ranking[s]
				#game_data.ranking.erase(game_data.ranking.keys()[0])
				#break
	#game_data.ranking.sort()
	for rank in online_data.ranking.keys():
		var item: RankingItem = RAKING_ITEM.instantiate() as RankingItem
		raking_list.add_child(item)
		raking_list.move_child(item, 0)
		item.set_item(online_data.ranking[rank], rank)
		if rank == current_score:
			item.set_focus()
			
	if is_new_record == false:
		main_menu_button.disabled = false
	
	
func _on_rank_submitted(item: RankingItem) -> void:
	if GameManger.online_save == true:
		print(item.player_name)
		
		await Talo.players.identify("username", item.player_name)

		var res := await Talo.leaderboards.add_entry("RANK", item.score)
		main_menu_button.disabled = false
		game_data.ranking[item.score] = str(item.player_name)
		GameManger.save_data()
	else:
		main_menu_button.disabled = false
		game_data.ranking[item.score] = str(item.player_name)
		GameManger.save_data()
	

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	
func get_online_game_data() -> GameData:
	var data: GameData = GameData.new()
	await Talo.players.identify("username", "dev")
	var talo_records := await Talo.leaderboards.get_top_entries("RANK", 10)
	for i in talo_records.top_entries:
		data.ranking[int(i.score)] = i.player_alias.display_name
	return data
