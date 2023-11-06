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
		get_tree().change_scene_to_file("res://MainMenu/mainMenuBido.tscn")
