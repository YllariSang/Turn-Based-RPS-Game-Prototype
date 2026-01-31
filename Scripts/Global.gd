extends Node

var player_hp: int = 3
var max_hp: int = 3
var current_level_id: int = 1
var game_state: String = "MAP" # MAP, DIALOGUE, BATTLE

func reset_player():
	player_hp = max_hp
