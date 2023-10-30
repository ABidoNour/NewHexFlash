extends State
class_name DashState


@onready var active_timer = $"../../DashTimer"
@onready var timer = $"../../DashCooldown"
var is_active : bool = false
 
func transition():
	if is_active:
		return
	is_active = true
	active_timer.start()
	await active_timer.timeout
	get_parent().change_state("Idle")
	is_active = false
 
func dash():
	if not owner.is_agr:
		return
	var tween = get_tree().create_tween()
	tween.tween_property(owner, "position", player.position, 1.0)
 
func _on_timer_timeout():
	print("WILL DASH")
	dash()
 
func enter():
	super.enter()
	timer.start()
 
func exit():
	super.exit()
	timer.stop()
