extends CharacterBody3D

class_name Enemy

var SPEED = randf_range(1, 4)
const MAX_HEALTH = 2
var health = MAX_HEALTH

@onready var target = null

func _ready():
	target = get_tree().get_root().get_node("Escenario").get_node("Character")

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if target == null: get_tree().get_root().get_node("Escenario").get_node("Character")
	if target != null:
		velocity = position.direction_to(target.position) * SPEED
		move_and_slide()

func damage():
	health -= 1
	print("[!] Health: ", health)
	if health <= 0:
		queue_free()