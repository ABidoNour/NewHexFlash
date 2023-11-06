extends Control

@onready var main = $Main


func _on_resume_button_pressed():
	main.pauseMenu()


func _on_quit_pressed():
	get_tree().quit()
