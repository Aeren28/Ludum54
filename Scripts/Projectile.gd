extends CharacterBody3D

var SPEED = 200
var TIME_TO_LIFE = 0.5

@onready var weapon = null

var direction
var life_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	weapon = get_tree().get_root().get_node("Escenario").get_node("Character").get_node("Weapon").get_node("Marker3D")
	position = weapon.global_transform.origin
	velocity = weapon.get_global_transform().basis.z * SPEED
	get_tree().get_root().get_node("Escenario").get_node("AudioStreamPlayer3").play()

func _process(delta):
	life_timer += delta
	move_and_slide()
	
	if (velocity == Vector3.ZERO or life_timer >= TIME_TO_LIFE):
		queue_free()

func _physics_process(delta):
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("Enemy"):
			collision.get_collider().call("damage")
			queue_free()
			break
