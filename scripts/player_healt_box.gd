@icon("res://assets/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/16x16/armor_01e.png")
extends Area2D
class_name PlayerHealthBox

#NOTE: Drag and drop as a child of Player node
#DANGER: Be sure to set the collisions as follows: Layer assigned to player and Mask unassigned

@onready var global = Global


func take_damage():
	get_parent().make_boom()
	
