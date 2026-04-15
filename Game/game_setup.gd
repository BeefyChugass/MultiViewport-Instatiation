extends Node

var number_of_players: int = Gamehandler.player_amount

func _setup() -> void:
	_init_players_dictionaty()
	_init_viewports()
	

#####################################

func _init_players_dictionaty():
	_create_player_data()
	_fill_player_data()

func _create_player_data():
	for player_instance in range(number_of_players+1):
		var player_id: int = player_instance
		var new_data: PlayerData = PlayerData.new()
		new_data.player_id = player_instance
		Gamehandler.playerdata.append(new_data)
		_create_player_viewport(player_instance)

func _create_player_viewport(player_id):
	var row = player_id/2
	var path = get_node("CanvasLayer/VBoxContainer/HBoxContainer%d"%row)
	var name: String = "SubViewportContainer%d"%player_id
	if path.has_node(name):
		return

	var new_viewport = load("res://gamesetup/sub_viewport_container_scene.tscn").instantiate()
	new_viewport.name = "SubViewportContainer%d"%player_id
	path.add_child(new_viewport)

func _fill_player_data():
	var level = get_node("level3D")
	for player_instance in range(number_of_players+1):
		var player_data = Gamehandler.playerdata[player_instance]
		var row = player_instance/2
		var path = "CanvasLayer/VBoxContainer/HBoxContainer%d/SubViewportContainer%d/SubViewport" % [row, player_instance]
		
		var node = get_node(path)
		
		var viewport = node
		var camera_pivot = node.get_node("CameraPivot")
		var camera_direct = camera_pivot.get_node("CameraPosition/Camera3D")
		var player = _create_player_node(player_instance)
		level.get_node("Entitys").add_child(player)
		player.global_position = level.get_node("SpawnPoints/SpawnPlayer%d"%player_instance).global_position#+Vector3(0,5,0)
		#player = level.get_node("Entitys/Player%d"%[player_instance])
		
		player_data.viewport = viewport
		player_data.camera_pivot = camera_pivot
		player_data.camera_direct = camera_direct
		player_data.player = player

func _create_player_node(player_id: int)->CharacterBody3D:
	var player:Player = load("res://Game/characters/player3d.tscn").instantiate()
	player.player_id = player_id
	player.set_name("Player%d"%player_id) 
	return player

#####################################

func _init_viewports():
	for player_instance in range(number_of_players+1):
		_init_viewport_dimensions(player_instance)
		_init_viewport_world3d(player_instance,get_node("level3D"))
		_init_viewport_camera3D(player_instance)
		

func _init_viewport_dimensions(player_instance):
	var player_data: PlayerData = Gamehandler.playerdata[player_instance]
	match number_of_players+1:
		1:
			_set_viewport_dimensions(player_data.viewport,1920,1080)
		2:
			_set_viewport_dimensions(player_data.viewport,960,1080)
		_:
			_set_viewport_dimensions(player_data.viewport,960,540)
	player_data.viewport.get_parent().visible = true

func _set_viewport_dimensions(viewport: SubViewport,width: int = 1920, heigth: int = width*0.5625):
	viewport.size = Vector2i(width,heigth)

func _init_viewport_world2d(player_instance, world: Node2D):
	var viewport: SubViewport = Gamehandler.playerdata[player_instance].viewport
	viewport.world_2d = world.get_world_2d()

func _init_viewport_world3d(player_instance, world: Node3D):
	var viewport: SubViewport = Gamehandler.playerdata[player_instance].viewport
	viewport.world_3d = world.get_world_3d()

func _init_viewport_camera2D(player_instance):
	var player_data: PlayerData = Gamehandler.playerdata[player_instance]
	var remote_transform := RemoteTransform2D.new()

func _init_viewport_camera3D(player_instance):
	var player_data: PlayerData = Gamehandler.playerdata[player_instance]
	var remote_transform: CameraPlayerAnchor = CameraPlayerAnchor.new()
	#RemoteTransform3D.new()
	
	remote_transform.player = player_data.player
	remote_transform.current_parent = remote_transform.player
	
	remote_transform.remote_path = player_data.camera_pivot.get_path()
	player_data.player.add_child(remote_transform)
	remote_transform.init()
	
	remote_transform.rotate_y((deg_to_rad(30)))
	player_data.camera_pivot.get_node("CameraPosition").rotate_x(deg_to_rad(-45))
	player_data.camera_pivot.get_node("CameraPosition").position.y += 10
	player_data.camera_pivot.get_node("CameraPosition").position.z += 10

#####################################

func _ready() -> void:
	_setup()
#	players["2"].viewport.world_2d = players["1"].viewport.world_2d
#	for node in players.values():
#		var remote_transform := RemoteTransform2D.new()
#		remote_transform.remote_path = node.camera.get_path()
#		node.player.add_child(remote_transform)
