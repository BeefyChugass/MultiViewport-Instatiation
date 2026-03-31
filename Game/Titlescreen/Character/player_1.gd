extends Sprite2D

@export var player_id: int = 0
var controls: Dictionary
var speed = 300



func _process(delta: float) -> void:
	var move: Vector2 = Vector2(0,0)

#	if Input.is_key_pressed(controls.press_up):
#		move.y += -speed*delta
#	if Input.is_key_pressed(controls.press_down):
#		move.y += speed*delta
#	if Input.is_key_pressed(controls.press_left):
#		move.x += -speed*delta
#	if Input.is_key_pressed(controls.press_right):
#		move.x += speed*delta

	
	self.global_position += move
