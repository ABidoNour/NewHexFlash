extends Area2D
@onready var pickup_sound = $PickupSound
@onready var pickup_timer = $PickupTimer


func _on_body_entered(body):
	visible = false
	body.add_health()
	pickup_timer.start()
	pickup_sound.play()
	

func _on_pickup_timer_timeout():
	queue_free() # Replace with function body.
