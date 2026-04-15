extends Node
class_name AimCursorMovementComponent

@export var cursor: Node3D
@export var player: CharacterBody3D
@export var input_component: InputComponent
@export var mode_component: ModeComponent

@export var speed: float = 5
@export var max_distance: float = 10

var direction: Vector2 = Vector2.ZERO

func tick(delta: float):
	if player and cursor:
#		cursor.global_position += input_component
		pass
