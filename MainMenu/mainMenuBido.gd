extends Control

@onready var pause_menu = $PauseMenu2
var paused = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$Buttons/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused = !paused


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_exit_button_button_down():
	get_tree().quit()


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://tutorial.tscn")
	# Replace with function body.
