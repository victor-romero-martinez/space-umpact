@icon("res://assets/icons/crossed-swords.svg")
extends Area2D
## Control enemy receive a hit
class_name EnemyHitBox

## DANGER: Be sure to set the collisions as follows: [b]Layer[/b] [b][color=#d58b8b]unassigned[/color][/b] and [b]Mask[/b] assigned to [b][color=#d58b8b]player[/color][/b]

func _ready():
	area_entered.connect(_hit)
	
	
## Player must have a components [u][color=#d58b8b]PlayerHealthBox[/color][/u]
func _hit(area: Area2D):
	if area is PlayerHealthBox:
		area.take_damage()
