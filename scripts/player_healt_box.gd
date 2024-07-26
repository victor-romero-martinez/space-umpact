extends Area2D
class_name PlayerHealthBox

@onready var global = Global


func take_damage():
	get_parent().make_boom()
	
