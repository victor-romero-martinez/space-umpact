@icon("res://assets/icons/heavy-black-heart.svg")
extends Area2D
## DANGER: Be sure to set the collisions as follows: Layer assigned to [b][color=#d58b8b]player[/color][/b] and Mask [b][color=#d58b8b]unassigned[/color][/b]
class_name PlayerHealthBox


## Set player health and apply function dead 
func take_damage(_damage: int = 1):
	get_parent().make_boom()

	
