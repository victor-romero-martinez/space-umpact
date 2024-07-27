extends Area2D
class_name EnemyHealthBox

#NOTE: Drag and drop as a child of Enemy node
#DANGER: Be sure to set the collisions as follows: Layer assigned to enemy and Mask  unassigned

@export var max_health: int = 1



func take_damage():
	max_health -= 1
	
	if max_health == 0:
		get_parent().make_boom()
		
