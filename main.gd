extends Node2D

@onready var HeartHUD = $CanvasLayer/HeartContainer
@onready var player = $Player


# Called when the node enters the scene tree for the first time.
func _ready():
	HeartHUD.set_max_hearts(player.maxHealth)
	HeartHUD.update_hearts(player.health)
	player.health_changed.connect(HeartHUD.update_hearts)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# TAKE THIS OUT OF MAIN


