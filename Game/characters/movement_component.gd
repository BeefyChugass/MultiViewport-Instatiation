extends Node
class_name MovementComponent

@export var body: CharacterBody3D
@export var model: Node3D

@export var speed:= 5
@export var jump_velocity:= 12.0
@export var gravity_multiplier:= 3.0

var direction: Vector2 = Vector2.ZERO
var wants_jump := false

func tick(delta: float) -> void:
	if body == null:
		return
	#TopDown Movement starts here
	body.velocity.x = direction.x * speed
	body.velocity.z = direction.y * speed
	
	#gravity
	if not body.is_on_floor():
		body.velocity += body.get_gravity() * delta * gravity_multiplier
	
	#jump
	if wants_jump and body.is_on_floor():
		body.velocity.y = jump_velocity
	wants_jump = false
	
	body.move_and_slide()
