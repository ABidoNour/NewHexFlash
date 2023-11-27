extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	$TutorialTimer.start()


func _on_tutorial_timer_timeout():
	queue_free()
