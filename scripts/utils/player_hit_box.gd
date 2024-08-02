@icon("res://assets/icons/crossed-swords.svg")
extends Area2D
class_name PlayerHitBox

''' Instrunctions
	- Drag and drop on enemy node
	- Configure collisions as follows:
		- Layer unassigned
		- Mask assigned to enemy
'''

#DANGER: Be sure to set the collisions as follows: Layer unassigned and Mask assigned to enemy


func _ready():
	area_entered.connect(_hit)
	
	
func _hit(area):
	if area is EnemyHealthBox:
		area.take_damage()
