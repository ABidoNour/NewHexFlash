extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$Buttons/MainMenu.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu/mainMenuBido.tscn")


func _on_quit_pressed():
	get_tree().quit()
