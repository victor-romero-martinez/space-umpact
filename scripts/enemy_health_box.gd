@icon("res://assets/icons/heavy-black-heart.svg")
extends Area2D
class_name EnemyHealthBox

''' Instrunctions
	- Drag and drop on enemy node
	- Inside the enemy script create the following methods:
		- apply_damge()
		- start_move_on_zigszag()
		- handler_zigzag_direction()
	- Configure collisions as follows:
		- Layer assigned to enemy
		- Mask unassigned
'''

#DANGER: Be sure to set the collisions as follows: Layer assigned to enemy and Mask  unassigned


func take_damage():
	get_parent().apply_damge()
		

func apply_move_zigzag():
	get_parent().start_move_on_zigszag()


func change_zigzag_direction():
	get_parent().handler_zigzag_direction()
