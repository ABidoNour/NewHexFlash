extends CharacterBody2D

@onready var ray_cast = $RayCast2D
@onready var player = owner.get_node('Player')
@export var stream : AudioStream
var random = RandomNumberGenerator.new()



var direction = Vector2.RIGHT
@export var ray_cast_range : float = 400
var is_agr = false
var health
@export var maxhealth = 25
var healthbar
@onready var key_scene : PackedScene = preload("res://pickups/level_1_key.tscn")

func _ready():
	health = maxhealth
	healthbar = $UIHealthbar
	healthbar.max_value = maxhealth
	random.randomize()

func _process(_delta):
	if not player.is_alive:
		is_agr
	if not is_agr:
		return
	direction = (player.position - position).normalized()
	ray_cast.target_position = direction * ray_cast_range
	healthbar.value = health
	
func take_damage(damage_value):
	health -= damage_value
	if health <= 0:
		AudioManager.play_sound(stream)
		var key = key_scene.instantiate()
		key.position = global_position
		owner.call_deferred("add_child", key)
		queue_free()
		
func start():
	$FiniteStateMachine/Idle.transition()
	
	
	

