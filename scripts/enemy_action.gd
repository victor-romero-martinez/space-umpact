@icon("res://assets/icons/tools.svg")
extends Area2D
class_name EnemyAction

#NOTE: use EnemyHealthBox area because is the only visible by other Area2D collision


func _ready():
	area_entered.connect(_active)
	area_exited.connect(_handler_movement)
	
	
#INFO: callback start zigzag movement
func _active(area):
	if area is EnemyHealthBox:
		area.apply_move_zigzag()


func _handler_movement(area):
	if area is EnemyHealthBox:
		area.change_zigzag_direction()
