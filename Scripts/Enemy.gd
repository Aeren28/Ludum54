extends CharacterBody3D

class_name Enemy

const MAX_HEALTH = 2
const SCORE = 15

var SPEED = randf_range(2, 3)
var DAMAGE = randi_range(1, 2)
var health = MAX_HEALTH

@onready var target = null
@onready var fruits = [preload("res://Scenes/Fruits/Apple.tscn"), preload("res://Scenes/Fruits/Banana.tscn"), preload("res://Scenes/Fruits/Cherry.tscn"), preload("res://Scenes/Fruits/Watermelon.tscn")]
@onready var attack_cooldown = $"Attack Cooldown"

func _ready():
	target = get_tree().get_root().get_node("Escenario").get_node("Character")

func _process(delta):
	if target != null:
		if position.distance_to(target.position) < 1.5:
			if attack_cooldown.is_stopped():
				target.damage(DAMAGE)
				attack_cooldown.start()

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if target == null: get_tree().get_root().get_node("Escenario").get_node("Character")
	if target != null:
		velocity = position.direction_to(target.position) * SPEED
		move_and_slide()

func damage():
	health -= 1
	if health <= 0:
		target.get_points(SCORE)
		$AudioStreamPlayer.play()
		if (randf_range(1,100) <= 25):
			var instance = fruits[randi_range(0, fruits.size() - 1)].instantiate()
			instance.position = position
			get_tree().get_root().get_node("Escenario").add_child(instance)
			
		queue_free()
