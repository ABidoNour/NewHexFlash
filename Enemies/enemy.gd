extends CharacterBody2D

var direction = Vector2.ZERO  # Declare and initialize 'direction'
@export var speed = 400  # Speed of the enemy
@onready var player = owner.get_node('Player')
var chase_player = false
var maxhealth = 3
var health = 3
var healthbar 
@onready var health_pickup_scene = preload("res://health_pickup.tscn")
var random
@export var health_pickup_chance = 65 # 65% chance of dropping


func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	$AnimatedSprite2D.play("default")
	healthbar = $UIHealthbar
	healthbar.max_value = maxhealth
	healthbar.visible = false
	

func _physics_process(delta):
	if not player.is_alive:
		return
	if chase_player:
		direction = (player.position - position).normalized()
		velocity = direction * speed
	move_and_slide()
	update_health()

func _on_detection_area_body_entered(body):
	chase_player = true

func _on_detection_area_body_exited(body):
	chase_player = false
	
func update_health():
	healthbar.value = health
	healthbar.visible = false if health == maxhealth else true
	
func take_damage(damage_value : int):
	health -= damage_value
	if health <= 0:
		var drop_pickup = (randi_range(1, 100) <= health_pickup_chance)
		if drop_pickup:
			var health_pickup = health_pickup_scene.instantiate()
			health_pickup.position = global_position
			owner.call_deferred("add_child", health_pickup)
		queue_free()
	
	
