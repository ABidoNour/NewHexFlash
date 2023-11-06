extends CharacterBody2D

var direction = Vector2.ZERO  # Declare and initialize 'direction'
@export var speed = 300  # Speed of the enemy
@onready var player = owner.get_node('Player')
var chase_player = false
var shoot_player = false
var maxhealth = 3
var health = 3
var healthbar 
@onready var health_pickup_scene = preload("res://health_pickup.tscn")
@onready var bullet_scene : PackedScene = preload("res://Projectiles/enemy_projectile.tscn")
var random
var can_shoot : bool = true
@export var health_pickup_chance = 85 # 1 in 2


func _ready():
	random = RandomNumberGenerator.new()
	random.randomize()
	healthbar = $UIHealthbar
	healthbar.max_value = maxhealth
	healthbar.visible = false
	$AnimatedSprite2D.play()
	
func _process(_delta):
	if chase_player:
		if shoot_player:
			$AnimatedSprite2D.animation = "default"
		else:
			$AnimatedSprite2D.animation = "Run"
			
	if not $WandPosition/AnimatedSprite2D.is_playing():
		$WandPosition/AnimatedSprite2D.play("default")

func _physics_process(_delta):
	if not player.is_alive:
		return
		
	direction = (player.position - position).normalized()
	if chase_player:
		if shoot_player:
			velocity = Vector2.ZERO
			_shoot()
		else:
			velocity = direction * speed
	move_and_slide()
	update_health()
	
func update_health():
	healthbar.value = health
	healthbar.visible = false if health == maxhealth else true
		
func take_damage(damage_value : int):
	health -= damage_value
	if health <= 0:
		var drop_pickup = (randi_range(1, 100) <= health_pickup_chance) # 1 in 2 chance
		if drop_pickup:
			var health_pickup = health_pickup_scene.instantiate()
			health_pickup.position = global_position
			owner.call_deferred("add_child", health_pickup)
		queue_free()

func _on_detection_area_body_entered(_body):
	chase_player = true

func _on_shoot_range_body_entered(_body):
	shoot_player = true

func _on_shoot_range_body_exited(_body):
	shoot_player = false
	
func _shoot():
	if can_shoot:
		can_shoot = false
		$ShootCooldown.start()
		$WandPosition/AnimatedSprite2D.play("shoot")
		var bullet = bullet_scene.instantiate()
		bullet.position = $WandPosition.global_position
		bullet.direction = (player.global_position - bullet.position).normalized()
		bullet.speed = 800
		get_tree().current_scene.call_deferred("add_child", bullet)

func _on_shoot_cooldown_timeout():
	can_shoot = true
