@icon("res://assets/icons/heavy-black-heart.svg")
extends Area2D
class_name PlayerHealthBox

#NOTE: Drag and drop as a child of Player node
#DANGER: Be sure to set the collisions as follows: Layer assigned to player and Mask unassigned

@onready var global = Global


func take_damage():
	get_parent().make_boom()
	
