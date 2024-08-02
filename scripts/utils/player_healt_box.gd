@icon("res://assets/icons/heavy-black-heart.svg")
extends Area2D
class_name PlayerHealthBox

''' Instrunctions
	- Drag and drop on player node
	- Inside the player script create the following methods:
		- make_boom()
	- Configure collisions as follows:
		- Layer assigned to player
		- Mask unassigned
'''

#DANGER: Be sure to set the collisions as follows: Layer assigned to player and Mask unassigned

@onready var global = Global


# callback
func take_damage():
	get_parent().make_boom()
	
