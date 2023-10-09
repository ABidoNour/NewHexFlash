extends Node2D

var default_wand_scene: PackedScene = preload("res://Projectiles/wand.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


# func _on_player_wand(pos, direction):
#	var wand = default_wand_scene.instantiate() as Area2D
#	wand.position = pos
#	wand.rotation_degrees = rad_to_deg(direction.angle())
#	wand.direction = direction
#	$Projectiles.add_child(wand)
