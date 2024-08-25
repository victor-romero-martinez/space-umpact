@icon("res://assets/icons/heavy-black-heart.svg")
extends Area2D
## Control enemy life
class_name EnemyHealthBox


## DANGER: Be sure to set the collisions as follows: [b]Layer[/b] assigned to [b][color=#d58b8b]enemy[/color][/b] and [b]Mask[/b]  [b][color=#d58b8b]unassigned[/color][/b]

## Play sound when receive a hit
@export var hit_sound: AudioStreamPlayer

var health: int = 0

func _ready():
	health = get_parent().health

## Inside the enemy script create the following methods:
##	[code]
##		func set_blinking():
##			...logic code
##	[/code]
func take_damage(damage: int = 1):
	health -= damage
	get_parent().set_blinking(damage)
	hit_sound.play()
	
	if health < 1:
		get_parent().defeated.emit()
		
