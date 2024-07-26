extends Area2D
class_name EnemyHealthBox

@export var max_health: int = 1



func take_damage():
	max_health -= 1
	
	if max_health == 0:
		get_parent().make_boom()
		
