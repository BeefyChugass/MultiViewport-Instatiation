extends Node
class_name PlayerControls
@export var player_id: int = 0
#@export var press_up: String = "p1_move_up"
#@export var press_down: String = "p1_move_down"
#@export var press_left: String = "p1_move_left"
#@export var press_right: String = "p1_move_right"
#
#@export var press_a: String = "p1_press_a"
#@export var press_b: String = "p1_press_b"
#@export var press_x: String = "p1_press_x"
#@export var press_y: String = "p1_press_y"
enum PlayerAction {UP,DOWN,LEFT,RIGHT,JUMP}

var players: Array[Array] =[
	[
		KEY_W,
		KEY_S,
		KEY_A,
		KEY_D,
		KEY_Q
	],
	[
		KEY_I,
		KEY_K,
		KEY_J,
		KEY_L,
		KEY_U
	],
	[
		KEY_T,
		KEY_G,
		KEY_F,
		KEY_H,
		KEY_R
	],
	[
		KEY_UP,
		KEY_DOWN,
		KEY_LEFT,
		KEY_RIGHT,
		KEY_SHIFT
	],
]

func _add_player_actions(player_id: int, binds: Array) -> void:
	_bind_action("p%d_up"%player_id,binds[PlayerAction.UP])
	_bind_action("p%d_down"%player_id,binds[PlayerAction.DOWN])
	_bind_action("p%d_left"%player_id,binds[PlayerAction.LEFT])
	_bind_action("p%d_right"%player_id,binds[PlayerAction.RIGHT])
	_bind_action("p%d_jump"%player_id,binds[PlayerAction.JUMP])

func _bind_action(action_name: String, keycode: Key):
	if not InputMap.has_action(action_name):
		InputMap.add_action(action_name)
	else:
		InputMap.action_erase_events(action_name)
	
	var event := InputEventKey.new()
	event.keycode = keycode
	InputMap.action_add_event(action_name,event)

func _ready() -> void:
	for player_id in range(players.size()):
		_add_player_actions(player_id,players[player_id])

func get_controls(id: int) -> Array:
	return players[id]
