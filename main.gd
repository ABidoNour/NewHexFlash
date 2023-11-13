extends Node2D

@onready var pause_menu = $GUIPause/PauseMenu
var paused = false
@onready var animation_player = $Player/AnimatedSprite2D



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		

func pauseMenu():
	if paused:
		pause_menu.hide() 
		Engine.time_scale = 1
		animation_player.play()
	else:
		pause_menu.show()
		Engine.time_scale = 0
		animation_player.stop()
 
	paused = !paused


func _on_boss_active_trigger_body_entered(body):
	$Boss.is_agr = true
	$Boss.start()
	$BossActiveTrigger.queue_free()
