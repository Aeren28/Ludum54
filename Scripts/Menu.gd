extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$"MarginContainer/VBoxContainer2/MarginContainer/VBoxContainer/Start Button Container/Start Button".grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Escenario.tscn")
	$AudioStart.play()

func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
