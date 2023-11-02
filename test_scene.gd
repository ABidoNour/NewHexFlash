extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$CharacterBody2D.is_agr = true
