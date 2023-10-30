extends State
class_name ShootState

var is_active = false
@onready var shoot_timer : Timer = $"../../ShootTimer"
@onready var bullet_scene : PackedScene = preload("res://Projectiles/enemy_projectile.tscn")
@onready var cooldown_timer : Timer = $"../../ShootCooldownTimer"

func transition():
	if is_active:
		return
	is_active = true
	shoot_timer.start()
	await shoot_timer.timeout
	get_parent().change_state("Idle")
	is_active = false


func enter():
	super.enter()
	cooldown_timer.start()
	
func exit():
	super.enter()
	cooldown_timer.stop()

func _on_shoot_cooldown_timer_timeout():
	if not owner.is_agr:
		return
	var bullet = bullet_scene.instantiate()
	bullet.position = global_position
	bullet.direction = (player.global_position - global_position).normalized()
	
	get_tree().current_scene.call_deferred("add_child", bullet)
