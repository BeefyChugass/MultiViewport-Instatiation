extends Node
class_name MovementComponent

@export var body: CharacterBody3D
@export var model: Node3D

@export var grid_size:int = 1

@export var speed:float= 5
@export var jump_velocity:= 12.0
@export var gravity_multiplier:= 3.0

var direction: Vector2 = Vector2.ZERO
var wants_jump := false

var is_moving:bool=false

func tick(delta: float) -> void:
	if body == null:
		return
#	if direction != Vector2.ZERO:
#		try_move()
	#TopDown Movement starts here
	body.velocity.x = direction.x * speed
	body.velocity.z = direction.y * speed
	
	#Grid Movement starts here
#	var tween = create_tween()
#	var tweeny = create_tween()
	#tween.tween_property(body,"global_position",body.global_position+Vector3(direction.x,0.0,direction.y),0.1)
	
	#gravity
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	#jump
	if wants_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	wants_jump = false
	
	body.move_and_slide()

#func try_move():
#	if is_moving:
#		return
#	is_moving = true
#	var tweenx = create_tween()
#	var target_pos = body.global_position
#	target_pos.x += direction.x*grid_size
#	target_pos.z += direction.y*grid_size
#	tweenx.tween_property(body, "global_position", target_pos, speed)
#	tweenx.connect("finished",move_done)

#func move_done():
#	is_moving = false
