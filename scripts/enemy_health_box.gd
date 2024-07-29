@icon("res://assets/icons/heavy-black-heart.svg")
extends Area2D
class_name EnemyHealthBox

''' Instrunctions
	- Drag and drop on enemy node
	- Inside the enemy script create the following methods:
		- start_move_on_zigszag()
		- handler_zigzag_direction()
	- Configure collisions as follows:
		- Layer assigned to enemy
		- Mask unassigned
'''

#DANGER: Be sure to set the collisions as follows: Layer assigned to enemy and Mask  unassigned

var max_health: int


func _ready():
	max_health = get_parent().health


func take_damage():
	max_health -= 1
	
	if max_health == 0:
		get_parent().make_boom()
		

func apply_move_zigzag():
	get_parent().start_move_on_zigszag()

func change_zigzag_direction():
	get_parent().handler_zigzag_direction()
