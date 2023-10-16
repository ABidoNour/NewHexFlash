extends CharacterBody2D


@export var speed : float = 700
@export var maxHealth = 3
@onready var health = maxHealth
var default_wand_scene: PackedScene = preload("res://Projectiles/wand.tscn")

signal wand(pos, direction)
signal health_changed

var can_wand: bool = true

const SPRITE_MAP = {
	Vector2.RIGHT : preload("res://Art/PlayerSprites/PrototypeSide.png"),
	Vector2.LEFT : preload("res://Art/PlayerSprites/PrototypeSide.png"),
	Vector2.UP : preload("res://Art/PlayerSprites/PrototypeSide.png"),
}

func _process(delta):
	if health <= 0:
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
	
	# wand shooting input
	if Input.is_action_pressed("primary action") and can_wand:
		#randomly select a marker 2D for the wand blast to spawn
		var wand_markers = $Weapon.get_children()
		var selected_wand = wand_markers[randi() % wand_markers.size()]
		var player_direction = (get_global_mouse_position() - position).normalized()
		can_wand = false
		$Timer.start()
		#emit the position we selected
		_shoot(selected_wand.global_position, player_direction)
		
func _shoot(pos, direction):
	var wand = default_wand_scene.instantiate()
	wand.position = pos
	wand.rotation_degrees = rad_to_deg(direction.angle())
	wand.direction = direction
	owner.add_child(wand)
	$FireCastSound.play()

func _physics_process(_delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * speed
	
	move_and_slide()

#adds a wait time before player can shoot again of 0.5s
func _on_timer_timeout():
	can_wand = true


func _on_hurt_box_area_entered(area):
	health -=1
	health_changed.emit(health)
	
func player_death():
	queue_free()
	get_tree().change_scene_to_file("res://MainMenu/mainMenuBido.tscn")
