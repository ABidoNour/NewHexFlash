#extends CharacterBody2D
##
#
#func _process(_delta):
#	#direction
#	var direction = Vector2.RIGHT
#
#	#velocity
#	velocity = direction * 100
#
#	#move and slide
#	move_and_slide()

extends CharacterBody2D

var direction = Vector2.ZERO  # Declare and initialize 'direction'
@export var speed = 400  # Speed of the enemy
var player = null  # Declare a variable to hold the player node
var chase_player = false

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	if chase_player:
		direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()

func _on_area2D_body_entered(body):
	if body.is_in_group("projectiles"):
		body.queue_free()
		# Connect the 'hit' signal and then emit it
		body.connect("hit", self, "_on_Wand_hit")
		body.emit_signal("hit")
		queue_free()

func _on_detection_area_body_entered(body):
	player = body
	chase_player = true


func _on_detection_area_body_exited(body):
	chase_player = false
