extends Area2D

@export var stream : AudioStream

func _on_body_entered(body):
	body.has_key = true
	AudioManager.play_sound(stream)
	queue_free()
