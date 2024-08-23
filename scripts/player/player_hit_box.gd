@icon("res://assets/icons/crossed-swords.svg")
extends Area2D
## DANGER: Be sure to set the collisions as follows: Layer  [b][color=#d58b8b]unassigned[/color][/b] and Mask assigned to [b][color=#d58b8b]enemy[/color][/b]
class_name PlayerHitBox


func _ready():
	area_entered.connect(_hit)
	

## Enemy must have a components [u][color=#d58b8b]EnemyHealthBox[/color][/u]
func _hit(area: Area2D):
	if area is EnemyHealthBox: # TODO: agregar colosion player
		area.take_damage()
