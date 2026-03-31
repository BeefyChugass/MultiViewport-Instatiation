extends Node
class_name AttackComponent

@export var Body: CharacterBody3D
@export var hitbox_component: HitboxComponent

var damage_amount:= 10

func activate_hitbox():
	var timer = Timer.new()
	self.add_child(timer)
	timer.connect("timeout",timer_timeout)
	timer.start(0.1)
	hitbox_component.monitoring = true
#	Hitbox.set_deferred("monitoring",false)

func attack(target: PhysicsBody3D):
	if target.has_method("damage"):
		target.damage(damage_amount)
		hitbox_component.target = null

func timer_timeout():
	hitbox_component.monitoring = false
	get_child(0).queue_free()
