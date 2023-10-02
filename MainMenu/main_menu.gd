extends MarginContainer

const start_game = preload("res://main.tscn")

@onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector

@onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector

@onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

@onready var _current_selection = 0

func _ready():
	set_current_selection(0)
	_current_selection += 1
	set_current_selection(_current_selection)
	_current_selection -= 1
	set_current_selection(_current_selection)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and _current_selection < 2:
		_current_selection += 1
		set_current_selection(_current_selection)
	elif Input.is_action_just_pressed("ui_up") and _current_selection > 0:
		_current_selection -= 1
		set_current_selection(_current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(_current_selection)
	
func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(start_game.instantiate())
		queue_free()
	elif _current_selection == 2:
		get_tree().quit()
	
func set_current_selection(_curent_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
