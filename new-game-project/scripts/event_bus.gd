extends Node

signal drop_collected(drop_type: Drop.DropType)
signal power_uped(power: int)
signal scored(score: int)
signal scratched(scratch: int)
signal life_lost(lifes: int)
signal bomb_used(bombs: int)
signal boss_health_changed(health: int, max_health: int)
signal player_died
signal run_continued
signal game_finished
signal score_submitted(item: RankingItem)
signal player_search(node: Node)
