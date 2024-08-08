@icon("res://assets/icons/tools.svg")
extends Node
## Use to eliminate enemies when they leave the screen.
class_name DestroyerEntities


func _process(_delta):
	if get_parent().global_position.x < 0:
		get_parent().queue_free()
