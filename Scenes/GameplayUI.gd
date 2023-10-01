extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/VBoxContainer/Score.text = "0"
	$MarginContainer/VBoxContainer/HealthBar.value = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setScore(score):
	$MarginContainer/VBoxContainer/Score.set_text(str(score))

func setHealthbar(percentage):
	$MarginContainer/VBoxContainer/HealthBar.value = percentage - 9
