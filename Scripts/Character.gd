extends CharacterBody3D

class_name Character

const SPEED = 5.0
const ANGULAR_SPEED = 0.02

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var input_dir
var direction
var _mouse_motion = Vector2()

func _process(delta):
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Mouse movement.
	_mouse_motion = Input.get_last_mouse_velocity()
	rotate_y(-_mouse_motion.x * ANGULAR_SPEED * delta)
	
	if Input.is_action_just_pressed("attack"):
		print("Ataca perra")
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		

	move_and_slide()
