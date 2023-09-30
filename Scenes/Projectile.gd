extends RigidBody3D

var weapon = get_root().get_node("Escenario").get_node("Character").get_node("Weapon").get_node("Marker3D")

# Called when the node enters the scene tree for the first time.
func _ready():
	position = weapon.position
	set_axis_velocity(weapon.transform.forward)
