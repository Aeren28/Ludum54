extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer2/Score.text = "0"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setScore(score):
	$MarginContainer2/Score.set_text(str(score))

func setHealthbar(percentage):
	pass
