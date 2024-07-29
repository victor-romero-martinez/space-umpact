@icon("res://assets/Kyrise's 16x16 RPG Icon Pack - V1.3/icons/16x16/armor_01e.png")
extends Area2D
class_name EnemyHealthBox

#NOTE: Drag and drop as a child of Enemy node
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
