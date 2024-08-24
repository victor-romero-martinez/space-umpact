@icon("res://assets/icons/tools.svg")
extends Area2D
## Eliminates the parent when he leaves the screen
class_name Destroyer


## Remove parent
func do_something():
	get_parent().queue_free()
