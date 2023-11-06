extends State
class_name IdleState

@onready var idle_timer : Timer = $"../../IdleTimer"
var is_mid_idle = false
var states = ['Shoot', 'Dash', 'BulletHell']

func transition():
	if owner.is_agr == false:
		print("Is not agr")
		return
	if is_mid_idle:
		print("Mid IDLE")
		return
	print("Reached IDLE")
	var random_choice = states[randi_range(0,states.size()-1)]
	print(random_choice)
	is_mid_idle = true
	idle_timer.start()
	await idle_timer.timeout
	get_parent().change_state(random_choice)
	is_mid_idle = false
