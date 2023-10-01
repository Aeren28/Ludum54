extends CharacterBody3D

class_name Character

const SPEED = 5.0
const ANGULAR_SPEED = 0.02
const MAX_HEALTH = 100

var projectile_preload = preload("res://Scenes/Projectile.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var input_dir
var look_dir
var direction
var _mouse_motion = Vector2()
var rotation_speed = 10.0  # Adjust the rotation speed as needed
var current_rotation = 0.0  # Stores the current rotation in degrees
var use_mouse_and_keyboard = true
var health = MAX_HEALTH
var score = 0;

@onready var gameplayUI_script = get_node("GameplayUI")

func _input(event):
	if(event is InputEventKey):
		use_mouse_and_keyboard = true;
	elif(event is InputEventJoypadButton):
		use_mouse_and_keyboard = false;
		# Do stuff
	elif(event is InputEventMouseButton):
		use_mouse_and_keyboard = true;
		# Do stuff
	elif(event is InputEventScreenTouch):
		use_mouse_and_keyboard = false;
		# Do stuff
	else:
		pass

func _process(delta):
	input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
#	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
	
	# Mouse movement.
#	_mouse_motion = Input.get_last_mouse_velocity()
#	rotate_y(-_mouse_motion.x * ANGULAR_SPEED * delta)
	
	# Mouse Rotation
	if use_mouse_and_keyboard:
		var rotation = screen_point_to_ray()
		look_at(Vector3(-rotation.x, self.position.y, -rotation.z), Vector3.UP)
		var mouse_pos = get_normalized_mouse_pos()
		var projections = get_projected_2d_basis()
		var proj_x = projections[0]
		var proj_y = projections[1]
		var move_dir = proj_x * mouse_pos.x - proj_y * mouse_pos.y
		move_dir = -move_dir.normalized()

		look_at(get_global_transform().origin + move_dir, Vector3.UP)
	
	# Controller Rotation
	if !use_mouse_and_keyboard:
		look_dir = Input.get_vector("look_left", "look_right", "look_up", "look_down")
		if look_dir.length() > 0:
			var angle = atan2(look_dir.x, look_dir.y)
			var target_angle = rad_to_deg(angle)
	
			current_rotation = lerp_angle_custom(current_rotation, target_angle, delta * rotation_speed)

		rotation_degrees = Vector3(0, current_rotation, 0)

	if Input.is_action_just_pressed("attack"):
		var projectile = projectile_preload.instantiate()
		get_tree().get_root().get_node("Escenario").add_child(projectile)

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

func lerp_angle_custom(a, b, t):
	# Ensure both 'a' and 'b' are in the range of -180 to 180 degrees
	a = wrapf(a, -180, 180)
	b = wrapf(b, -180, 180)
	
	# Calculate the difference between 'b' and 'a'
	var diff = b - a
	
	# Wrap the difference to be within -180 to 180 degrees
	if diff > 180:
		diff -= 360
	elif diff < -180:
		diff += 360
	
	# Interpolate and wrap the result
	var result = a + diff * t
	return wrapf(result, -180, 180)

func screen_point_to_ray():
	var spaceState = get_world_3d().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var camera = get_tree().root.get_camera_3d()
	var rayOrigin = camera.project_ray_origin(mousePos)
	var rayEnd = rayOrigin + camera.project_ray_normal(mousePos) * 20000
	var rayQuery = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
	rayQuery.collide_with_areas = true;
	rayQuery.collide_with_bodies = true;
	var rayArray = spaceState.intersect_ray(rayQuery)
	if rayArray.has("position"):
		return rayArray["position"]
	return Vector3()

func get_normalized_mouse_pos():
	var mouse_pos = get_viewport().get_mouse_position()
	var size = get_viewport().get_visible_rect().size
	var center_offset = size / 2.0  # Calculate the center of the viewport

	# Calculate the offset from the center of the viewport
	var offset = mouse_pos - center_offset

	# Normalize the offset so that it's in the range of -1 to 1
	var normalized_offset = offset / center_offset

	return normalized_offset

func get_projected_2d_basis():
	var cam_basis = get_tree().root.get_camera_3d().get_global_transform().basis
	var proj_x = cam_basis.x
	proj_x.y = 0
	var proj_y = cam_basis.y
	proj_y.y = 0
	return [proj_x.normalized(), proj_y.normalized()]

func damage(damage):
	health -= damage
	gameplayUI_script.setHealthbar(health / MAX_HEALTH)
	if (health <= 0):
		queue_free()

func get_points(append_score):
	score += append_score
	gameplayUI_script.setScore(score)

func cure(cure):
	if (health < MAX_HEALTH):
		health += 1
		gameplayUI_script.setHealthbar(health / MAX_HEALTH)
