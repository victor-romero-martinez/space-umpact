@icon("res://assets/icons/crossed-swords.svg")
extends Area2D
class_name PlayerHitBox

#NOTE: Drag and drop as a child of Player node
#DANGER: Be sure to set the collisions as follows: Layer unassigned and Mask assigned to enemy


func _ready():
	area_entered.connect(_hit)
	
	
func _hit(area):
	if area is EnemyHealthBox:
		area.take_damage()
