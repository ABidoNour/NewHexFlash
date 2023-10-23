extends CharacterBody2D


@export var speed : float = 700
@export var maxHealth = 3
@export var knockback_strength = 10000
@onready var health = maxHealth
@onready var effect_animation = $HurtEffect
@onready var death_animation = $DeathEffect
var fireball_scene: PackedScene = preload("res://Projectiles/fireball.tscn")
@export var weapon_damage = 1

signal fireball(pos, direction)
signal health_changed

var can_fireball: bool = true
var invincible : bool = false
var is_alive : bool = true

const SPRITE_MAP = {
	Vector2.RIGHT : preload("res://Art/PlayerSprites/PrototypeSide.png"),
	Vector2.LEFT : preload("res://Art/PlayerSprites/PrototypeSide.png"),
	Vector2.UP : preload("res://Art/PlayerSprites/PrototypeSide.png"),
}

func _ready():
	effect_animation.play("RESET")

func _process(delta):
	if not is_alive:
		return
	
	if health <= 0 and is_alive:
		player_death()
	
	# print(health)
	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "side"
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x > 0
	elif velocity.y > 0:
		$AnimatedSprite2D.animation = "down"
		$AnimatedSprite2D.flip_h = false
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_h = false
	
	# fireball shooting input
	if Input.is_action_pressed("primary action") and can_fireball:
		#randomly select a marker 2D for the fireball blast to spawn
		var fireball_markers = $Weapon.get_children()
		var selected_fireball = fireball_markers[randi() % fireball_markers.size()]
		var player_direction = (get_global_mouse_position() - position).normalized()
		can_fireball = false
		$Timer.start()
		#emit the position we selected
		_shoot(selected_fireball.global_position, player_direction)
		
func _shoot(pos, direction):
	var fireball = fireball_scene.instantiate()
	fireball.position = pos
	fireball.rotation_degrees = rad_to_deg(direction.angle())
	fireball.direction = direction
	fireball.damage = weapon_damage
	owner.add_child(fireball)
	$FireCastSound.play()

func _physics_process(_delta):
	if not is_alive:
		return
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * speed
	
	move_and_slide()

#adds a wait time before player can shoot again of 0.5s
func _on_timer_timeout():
	can_fireball = true

func _on_hurt_box_area_entered(area):
	if !invincible:
		health -=1
		$DamageSound.play()
		health_changed.emit(health)
		invincible = true
		$PlayerInvincibilityPeriod.start()
		knockback(area.owner.velocity)
		effect_animation.play("hurtBlink")
	
func player_death():
	is_alive = false
	
	death_animation.play("Death")
	$DeathTimer.start()
	$DeathSound.play()
	await $DeathTimer.timeout
	queue_free()
	get_tree().change_scene_to_file("res://MainMenu/mainMenuBido.tscn")

func _on_player_invincibility_period_timeout():
	invincible = false
	effect_animation.play("RESET")
	
func knockback(enemy_velocity : Vector2):
	var knockback_direction = (enemy_velocity - velocity).normalized() * knockback_strength
	velocity = knockback_direction
	move_and_slide()
	
func add_health():
	if health < maxHealth:
		health += 1
		health_changed.emit(health)
