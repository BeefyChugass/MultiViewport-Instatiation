extends Node
class_name SceneManager

var players: Array
var scene_dir_path = "res://scenes/"

func change_from_title_to_game():
	var full_path = "res://Game/game.tscn"
	self.get_tree().call_deferred("change_scene_to_file", full_path)

func change_scene(from,to_scene_name: String) -> void:
	pass
