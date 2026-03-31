extends Control

var player_amount: int 

func load_viewports(amount:int):
	var scene_tree = get_tree()
	Gamehandler.player_amount = player_amount
	Scene_Manager.change_from_title_to_game()



func _1_player_pressed() -> void:
	player_amount = 0
	load_viewports(player_amount)


func _2_player_pressed() -> void:
	player_amount = 1
	load_viewports(player_amount)


func _3_player_pressed() -> void:
	player_amount = 2
	load_viewports(player_amount)


func _4_player_pressed() -> void:
	player_amount = 3
	load_viewports(player_amount)
