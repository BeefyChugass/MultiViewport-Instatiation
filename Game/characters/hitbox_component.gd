extends Area3D
class_name HitboxComponent

@export var health_component: HealthComponent
@export var Body: CharacterBody3D

var target: PhysicsBody3D = null

func damage(amount: int):
	if health_component:
		health_component.damage(amount)


func _on_body_entered(body: Node3D) -> void:
	if body == Body:
		return
	if body is PhysicsBody3D:
		target = body
