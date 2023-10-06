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
var speed = 100  # Speed of the enemy
var player = null  # Declare a variable to hold the player node

var wand

func _init(wand_node):
	wand = wand_node
	
func _ready():
	# Try to get the player node
	player = get_node_or_null("/root/Player")  # Replace with the actual path to your player node

func _process(_delta):
	# Check if the player node exists
	if player != null:
		# Update 'direction' to follow the player
		direction = (player.position - position).normalized()
		
		# velocity
		velocity = direction * speed
		
		# move and slide
		move_and_slide()

# Function to handle when the enemy is hit by a projectile
func _on_Wand_hit(body):
	if body.is_in_group("projectiles"):
		body.queue_free() # This will remove the enemy from the scene
	
func _on_area2D_body_entered(body):
	if body.is_in_group("projectiles"):
		body.queue_free()
		# Connect the 'hit' signal and then emit it
		body.connect("hit", self, "_on_Wand_hit")
		body.emit_signal("hit")
		queue_free()
		


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_area_2d_body_entered(body):
	if body.name.contains('wand'):
		body.queue_free() # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited():
	pass # Replace with function body.
