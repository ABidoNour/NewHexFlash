extends HBoxContainer
@onready var HeartGuiScene = preload("res://heart_gui.tscn")

func set_max_hearts(max_hearts : int):
	for i in range(max_hearts):
		var heart = HeartGuiScene.instantiate()
		add_child(heart)

func update_hearts(currentHealth : int):
	var hearts = get_children()
	
	for i in range(currentHealth):
		hearts[i].update(true)
		
	for i in range(currentHealth, hearts.size()):
		hearts[i].update(false)
