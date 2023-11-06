extends Area2D

func _on_body_entered(body):
	body.has_key = true
	queue_free()
