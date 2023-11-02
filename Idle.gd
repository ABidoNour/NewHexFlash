extends State
class_name IdleState

@onready var idle_timer : Timer = $"../../IdleTimer"
var is_mid_idle = false
var states = ['Shoot', 'Dash', 'BulletHell']

# Called when the node enters the scene tree for the first time.
func transition():
	if not owner.is_agr or is_mid_idle:
		return
	var random_choice = states[randi_range(0,states.size()-1)]
	print(random_choice)
	is_mid_idle = true
	idle_timer.start()
	await idle_timer.timeout
	get_parent().change_state(random_choice)
	is_mid_idle = false
