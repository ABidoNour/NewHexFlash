#extends Area2D
#
#@export var speed: int = 1000
#var direction: Vector2 = Vector2.UP
#
#func _process(delta):
#	position += direction * speed * delta

	
extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

# Declare a new signal
signal hit

func _process(delta):
	position += direction * speed * delta

func _on_Area2D_body_entered(body):
	if body.is_in_group("mob"):
		body.queue_free()
		print("REACHED")
		# Emit the 'hit' signal
	queue_free()  # This will remove the wand from the scene

# Wand.gd
func _ready():
	# Add this instance to the 'projectiles' group
	add_to_group("projectiles")


func _on_hit():
	pass # Replace with function body.


func _on_Wand_hit(body):
	if body.is_in_group("Enemies"):
		emit_signal('hit')
		# Emit the 'hit' signal
	queue_free() # Replace with function body.
