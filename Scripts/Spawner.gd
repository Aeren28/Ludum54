extends Node3D

class_name Spawner

var numberEnemys = 1
var enemy_count
var time = 10
var timer
var sec

@onready var enemy = preload("res://Scenes/Enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = 0
	enemy_count = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (timer <= 0 || enemy_count <= 0):
		for i in numberEnemys:
			var pos = get_child(0).get_children().pick_random()
			var instance = enemy.instantiate()
			add_child(instance)
			instance.position = pos.position
			enemy_count += 1
			
		numberEnemys *= 1.2
		time = numberEnemys * 1.5
		timer = time
	else:
		timer -= delta
