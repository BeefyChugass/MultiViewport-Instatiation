extends CharacterBody3D
class_name Player

@onready var input_component: InputComponent = %InputComponent
@onready var movement_component: MovementComponent = %MovementComponent
@onready var health_component: HealthComponent = %HealthComponent
@onready var hitbox_component: HitboxComponent = %HitboxComponent
@onready var attack_component: AttackComponent = %AttackComponent


@export var player_id: int = 0
var controls: Array
var speed = 3

func _ready() -> void:
	health_component.died.connect(_on_died)
	
	controls = Controls.get_controls(player_id)
	var sprite = get_node("Sprite3D")
	match player_id:
		0:
			sprite.modulate = Color(0,1,1,1)
		1:
			sprite.modulate = Color(1.0,0.32,0.25,1)
		2:
			sprite.modulate = Color(0,1,0,1)
		3:
			sprite.modulate = Color(1,1,0,1)
		_:
			sprite.modulate = Color(1,1,1,1)

func _physics_process(delta: float) -> void:
	#read controls
	input_component.update(player_id)
	
	#read movement component
	movement_component.direction = input_component.move_dir
	movement_component.wants_jump = input_component.jump_pressed
	
	if input_component.heal_pressed == true:
		health_component.heal(10)
	if input_component.hurt_pressed == true:
		attack_component.activate_hitbox()
	
	if hitbox_component.target:
		attack_component.attack(hitbox_component.target)
	
	
	#do tick
	movement_component.tick(delta)

func _on_died() -> void:
	print("Player %d died"%player_id)
	queue_free()

func damage(amount):
	health_component.damage(amount)
