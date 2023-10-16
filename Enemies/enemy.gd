extends CharacterBody2D

var direction = Vector2.ZERO  # Declare and initialize 'direction'
@export var speed = 400  # Speed of the enemy
var player = null  # Declare a variable to hold the player node
var chase_player = false
@export var health : int = 3


func _on_area2D_body_entered(body):
	if body.is_in_group("projectiles"):
#		body.connect("hit", self, "_on_Wand_hit")
		health -= 1
		print(health)
		if health <= 0:
			queue_free()

			
func _ready():
	$AnimatedSprite2D.play("default")
	add_to_group('mob')
#	get_tree().connect("wand_hit", self, "_on_Wand_hit")

#func _on_Wand_hit(body):
#	if body == self:
#		body.disconnect("hit", self, "_on_Wand_hit")


func _physics_process(delta):
	if chase_player:
		direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()

#func _on_area2D_body_entered(body):
#	if body.is_in_group("projectiles"):
#		health -= 1
#		print(health)
#		# Connect the 'hit' signal and then emit it
##		body.connect("hit", self, "_on_Wand_hit")
##		body.emit_signal("hit")
##		queue_free()

func _on_detection_area_body_entered(body):
	player = body
	chase_player = true


func _on_detection_area_body_exited(body):
	chase_player = false
	
func _on_hit(body):
	if body == self:
		health -= 1
		print(health)
		if health <= 0:
			queue_free()
