extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.set_frame(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.has_key == true:
		$AnimatedSprite2D.set_frame(1)
		$Timer.start()
		await $Timer.timeout
		var level = ''
		if get_tree().current_scene.name == 'Main':
			level = "res://Levels/level_2.tscn"
		elif get_tree().current_scene.name == 'Level2':
			level = 'res://Levels/level_3.tscn'
		else:
			level = "res://MainMenu/mainMenuBido.tscn"
		get_tree().change_scene_to_file(level)
