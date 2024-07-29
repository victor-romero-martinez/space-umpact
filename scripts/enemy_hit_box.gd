@icon("res://assets/icons/crossed-swords.svg")
extends Area2D
class_name EnemyHitBox

#NOTE: Drag and drop as a child of Enemy node
#DANGER: Be sure to set the collisions as follows: Layer unassigned and Mask assigned to player


func _ready():
	area_entered.connect(_hit)
	
	
func _hit(area):
	if area is PlayerHealthBox:
		area.take_damage()
