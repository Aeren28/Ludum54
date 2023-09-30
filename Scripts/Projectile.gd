extends CharacterBody3D

var SPEED = 200
var TIME_TO_LIFE = 0.5

@onready var weapon = get_tree().get_root().get_node("Escenario").get_node("Character").get_node("Weapon").get_node("Marker3D")

var direction
var life_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	position = weapon.global_transform.origin
	velocity = weapon.get_global_transform().basis.x * SPEED

func _process(delta):
	life_timer += delta
	move_and_slide()
	
	if (velocity == Vector3.ZERO or life_timer >= TIME_TO_LIFE):
		queue_free()

func _physics_process(delta):
	var collision = get_last_slide_collision()
	if collision:
		if (collision.get_collider(0).name == "Enemy"):
			queue_free()
