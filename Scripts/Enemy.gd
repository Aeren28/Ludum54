extends CharacterBody3D

class_name Enemy

var SPEED = randf_range(1, 4)

@onready var target = get_tree().get_root().get_node("Escenario").get_node("Character")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
<<<<<<< HEAD:Scripts/Enemy.gd
=======
	if target == null: get_tree().get_nodes_in_group("Character")
>>>>>>> a8ff41605a90bfcdccd8547e8563ec72b402d9d1:Scenes/Enemy.gd
	if target != null:
		velocity = position.direction_to(target.position) * SPEED
		move_and_slide()
