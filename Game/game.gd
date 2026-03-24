extends Node

var number_of_players: int = Game_Autoload.player_amount

@onready var players := {
#	"1": {
#		viewport = $HBoxContainer/SubViewportContainer/SubViewport,
#		camera = $HBoxContainer/SubViewportContainer/SubViewport/Camera2D,
#		player = $HBoxContainer/SubViewportContainer/SubViewport/level/Player1
#		},
#	"2": {
#		viewport = $HBoxContainer/SubViewportContainer2/SubViewport,
#		camera = $HBoxContainer/SubViewportContainer2/SubViewport/Camera2D,
#		player = $HBoxContainer/SubViewportContainer/SubViewport/level/Player2 or null
#		}
}

func _setup() -> void:
	_init_players_dictionaty()
	_init_viewports()
	

#####################################

func _init_players_dictionaty():
	_create_players_dictionary()
	_fill_players_dictionary()

func _create_players_dictionary():
	for player_instance in range(number_of_players+1):
		var player_id: int = player_instance
		var empty_dic: Dictionary = {}
		
		players.get_or_add(player_id,empty_dic)
	print(players)

func _fill_players_dictionary():
	var level = get_node("level")
	for player_instance in range(number_of_players+1):
		var row = player_instance/2
		var path = "CanvasLayer/VBoxContainer/HBoxContainer%d/SubViewportContainer%d/SubViewport" % [row, player_instance]
		
		var node = get_node(path)
		
		var viewport = node
		var camera = node.get_node("Camera2D")
		var player = level.get_node("Player%d"%[player_instance])
		
		players[player_instance]["viewport"] = viewport
		players[player_instance]["camera"] = camera
		players[player_instance]["player"] = player

#####################################

func _init_viewports():
	for player_instance in range(number_of_players+1):
		_init_viewport_dimensions(player_instance)
		_init_viewport_world2d(player_instance,get_node("level"))
		_init_viewport_camera2D(player_instance)
		

func _init_viewport_dimensions(player_instance):
	var player_dictionary: Dictionary = players[player_instance]
	match number_of_players+1:
		1:
			_set_viewport_dimensions(player_dictionary["viewport"],1920,1080)
		2:
			_set_viewport_dimensions(player_dictionary["viewport"],960,1080)
		_:
			_set_viewport_dimensions(player_dictionary["viewport"],960,540)
	player_dictionary["viewport"].get_parent().visible = true

func _set_viewport_dimensions(viewport: SubViewport,width: int = 1920, heigth: int = width*0.5625):
	viewport.size = Vector2i(width,heigth)

func _init_viewport_world2d(player_instance, world: Node2D):
	var viewport: SubViewport = players[player_instance]["viewport"]
	viewport.world_2d = world.get_world_2d()

func _init_viewport_camera2D(player_instance):
	var player_dictionary: Dictionary = players[player_instance]
	var remote_transform := RemoteTransform2D.new()
	
	remote_transform.remote_path = player_dictionary["camera"].get_path()
	player_dictionary["player"].add_child(remote_transform)

#####################################

func _ready() -> void:
	_setup()
#	players["2"].viewport.world_2d = players["1"].viewport.world_2d
#	for node in players.values():
#		var remote_transform := RemoteTransform2D.new()
#		remote_transform.remote_path = node.camera.get_path()
#		node.player.add_child(remote_transform)
