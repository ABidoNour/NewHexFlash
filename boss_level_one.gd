extends CharacterBody2D

@onready var ray_cast = $RayCast2D
@onready var player = get_parent().get_node('Player')

var direction = Vector2.RIGHT
@export var ray_cast_range : float = 400
var is_agr = false
var health = 15
@export var maxhealth = 15
var healthbar 

func _ready():
	health = maxhealth
	healthbar = $UIHealthbar
	healthbar.max_value = maxhealth

func _process(_delta):
	if player.is_alive == false:
		is_agr = false
	if not is_agr:
		return
	direction = (player.position - position).normalized()
	ray_cast.target_position = direction * ray_cast_range
	healthbar.value = health
	
func take_damage(damage_value):
	health -= damage_value
	if health <= 0:
		queue_free()
		
	
	
	

