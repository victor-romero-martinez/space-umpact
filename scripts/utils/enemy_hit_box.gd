@icon("res://assets/icons/crossed-swords.svg")
extends Area2D
class_name EnemyHitBox

''' Instrunctions
	- Drag and drop on enemy node
	- Configure collisions as follows:
		- Layer unassigned
		- Mask assigned to player
'''

#DANGER: Be sure to set the collisions as follows: Layer unassigned and Mask assigned to player


func _ready():
	area_entered.connect(_hit)
	
	
func _hit(area):
	if area is PlayerHealthBox:
		area.take_damage()
