extends CharacterBody3D

var SPEED = 200

@onready var weapon = get_tree().get_root().get_node("Escenario").get_node("Character").get_node("Weapon").get_node("Marker3D")

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	position = weapon.global_transform.origin
	velocity = weapon.get_global_transform().basis.x * SPEED

func _process(delta):
	move_and_slide()

