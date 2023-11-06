extends Node2D

#class_name Main

#signal toggle_game_paused(is_paused : bool)

#var game_paused : bool = false:
	#get:
		#return game_paused
	#set(value):
		#game_paused = value
		#emit_signal("toggle_game_paused", game_paused)
# Called when the node enters the scene tree for the first time.

func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
#func _input(event: InputEvent):
	#if(event.is_action_pressed("ui_cancel")):
		#var current_value : bool = get_tree().paused
		#game_paused = !game_paused
		



func _on_boss_active_trigger_body_entered(body):
	$Boss.is_agr = true
	$Boss.start()
	$BossActiveTrigger.queue_free()
