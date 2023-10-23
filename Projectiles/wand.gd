#extends Area2D
#
#@export var speed: int = 1000
#var direction: Vector2 = Vector2.UP
#
#func _process(delta):
#	position += direction * speed * delta

	
extends Area2D

@export var speed: int = 1500
var direction: Vector2 = Vector2.UP
var damage = 1

# Declare a new signal
signal hit

func _process(delta):
	position += direction * speed * delta

# Wand.gd
func _ready():
	# Add this instance to the 'projectiles' group
	add_to_group("projectiles")


func _on_body_entered(body):
	if body.is_in_group("mob"):
		body.take_damage(damage)
	queue_free()
