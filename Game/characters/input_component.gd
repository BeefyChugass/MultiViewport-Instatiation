extends Node
class_name InputComponent

var move_dir: Vector2 = Vector2.ZERO
var jump_pressed:= false
var heal_pressed:= false
var hurt_pressed:= false

func update(player_id: int) -> void:
	move_dir = Input.get_vector("p%d_left"%player_id,"p%d_right"%player_id,"p%d_up"%player_id,"p%d_down"%player_id)
	jump_pressed = Input.is_action_just_pressed("p%d_jump"%player_id)
	
	heal_pressed = Input.is_action_just_pressed("p0_heal")
	hurt_pressed = Input.is_action_just_pressed("p%d_hurt"%player_id)
