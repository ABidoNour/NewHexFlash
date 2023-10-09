extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Buttons/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_exit_button_button_down():
	get_tree().quit()


func _on_options_button_pressed():
	#TODO
	pass # Replace with function body.
