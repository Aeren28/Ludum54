extends CharacterBody3D

class_name Enemy

const SPEED = 5.0

@onready var target = $"../Character"

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if target == null: get_tree().get_nodes_in_group("Character")
	if target != null:
		velocity = position.direction_to(target.position) * SPEED
		move_and_slide()
