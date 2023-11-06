extends CharacterBody2D

var direction = Vector2.ZERO  # Declare and initialize 'direction'
@export var speed = 400  # Speed of the enemy
var player = null  # Declare a variable to hold the player node
var chase_player = false
var maxhealth = 3
var health = 3
var healthbar 
var health_pickup_scene = preload("res://health_pickup.tscn")
var random
@onready var death_sound = $DeathSound
@onready var death_timer = $DeathTimer
var is_alive = true 


func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	$AnimatedSprite2D.play("default")
	healthbar = $UIHealthbar
	healthbar.max_value = maxhealth
	healthbar.visible = false


	

func _physics_process(delta):
	if chase_player and player.is_alive and is_alive:
		direction = (player.position - position).normalized()
		velocity = direction * speed
		move_and_slide()
		update_health()
	else:
		velocity = Vector2.ZERO

func _on_detection_area_body_entered(body):
	player = body
	chase_player = true


func _on_detection_area_body_exited(body):
	chase_player = false
	
func update_health():
	healthbar.value = health
	
	if health == maxhealth:
		healthbar.visible = false
	else:
		healthbar.visible = true
	
func take_damage(damage_value : int):
	health -= damage_value
	if health <= 0 and is_alive:
		is_alive = false
		var drop_pickup = (randi_range(1,4) == 1) # 1 in 4 chance
		if drop_pickup:
			var health_pickup = health_pickup_scene.instantiate()
			health_pickup.position = global_position
			owner.call_deferred("add_child", health_pickup)
		visible = false
		death_sound.play()	
		death_timer.start()
#

	


func _on_death_timer_timeout():
	queue_free() # Replace with function body.
