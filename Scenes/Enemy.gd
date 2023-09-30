extends CharacterBody3D


const SPEED = 5.0
var player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	player = get_node("/root/Escenario/CharacterBody3D")
	
	pass

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	print(player.transform)
	var input_dirX = player.transform.basis.x - transform.basis.x
	var input_dirZ = player.transform.basis.z - transform.basis.z
	var direction = (Vector3(input_dirX.x, 0, input_dirZ.z)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	move_and_slide()
