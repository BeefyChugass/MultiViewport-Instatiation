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

var players := {
	0: {
		press_up = KEY_W,
		press_down = KEY_S,
		press_left = KEY_A,
		press_right = KEY_D
		},
	1: {
		press_up = KEY_I,
		press_down = KEY_K,
		press_left = KEY_J,
		press_right = KEY_L
		},
	2: {
		press_up = KEY_T,
		press_down = KEY_G,
		press_left = KEY_F,
		press_right = KEY_H
		},
	3: {
		press_up = KEY_UP,
		press_down = KEY_DOWN,
		press_left = KEY_LEFT,
		press_right = KEY_RIGHT
		}
}

func get_controls(id: int) -> Dictionary:
	return players[id]
