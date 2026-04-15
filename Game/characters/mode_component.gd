extends Node
class_name ModeComponent

enum Mode {MOVE,AIM}

var current_mode: Mode = Mode.MOVE

func is_move_mode() ->bool:
	return current_mode == Mode.MOVE

func is_aim_mode() ->bool:
	return current_mode == Mode.AIM

func enter_move_mode() -> void:
	current_mode = Mode.MOVE

func enter_aim_mode() -> void:
	current_mode = Mode.AIM
