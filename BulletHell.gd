extends State
class_name BulletHell

@onready var bullet_scene = preload("res://Projectiles/enemy_projectile.tscn")
@onready var rotator = $"../../Rotator"
@onready var shoottimer = $"../../BulletHellShootTimer"
@onready var active_timer = $"../../BulletHellTimer"

const rotate_speed = 200
const shoot_timer_wait_time = 0.25
const spawn_point_coint = 3
const radius = 100
@export var bullet_speed = 500

var is_active = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var step = 2 * PI / spawn_point_coint
	
	for i in range(spawn_point_coint):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotator.add_child(spawn_point)
		
	shoottimer.wait_time = shoot_timer_wait_time

func transition():
	if is_active:
		return
	is_active = true
	active_timer.start()
	await active_timer.timeout
	get_parent().change_state("Idle")
	is_active = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_active:
		return
	var new_rotation = rotator.rotation_degrees + rotate_speed * delta
	rotator.rotation_degrees = fmod(new_rotation, 360)


func _on_bullet_hell_shoot_timer_timeout():
	if not owner.is_agr or not is_active:
		return
	for s in rotator.get_children():
		var bullet = bullet_scene.instantiate()
		
		bullet.position = s.global_position
		bullet.direction = (s.global_position - owner.global_position).normalized()
		bullet.rotation = s.global_rotation
		bullet.speed = bullet_speed
	
		get_tree().current_scene.call_deferred("add_child", bullet)
		
func enter():
	super.enter()
	shoottimer.start()
 
func exit():
	super.exit()
	shoottimer.stop()
