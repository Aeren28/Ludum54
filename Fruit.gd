extends RigidBody3D

@onready var target = null
# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_tree().get_root().get_node("Escenario").get_node("Character")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null:
		if position.distance_to(target.position) < 1.5:
			target.cure(randf_range(0, 1))
			queue_free()
