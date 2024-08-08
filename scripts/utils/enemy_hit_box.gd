@icon("res://assets/icons/crossed-swords.svg")
extends Area2D
class_name EnemyHitBox


## DANGER: Be sure to set the collisions as follows: [b]Layer[/b] [b][color=#d58b8b]unassigned[/color][/b] and [b]Mask[/b] assigned to [b][color=#d58b8b]player[/color][/b]


func _ready():
	area_entered.connect(_hit)
	
	
## Player must have a components [color=#d58b8b]PlayerHealthBox[/color]
func _hit(area: Area2D):
	if area is PlayerHealthBox:
		area.take_damage()
