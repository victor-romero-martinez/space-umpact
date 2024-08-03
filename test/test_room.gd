@icon("res://assets/icons/round-test-tube.svg")
extends Node2D


@onready var menu_pause = $MenuPause


var paused: bool = false


func _process(_delta):
	if Input.is_action_just_pressed('ui_pause'):
		_pause_menu()


func _pause_menu():
	if paused:
		menu_pause.hide()
		Engine.time_scale = 1
	else:
		menu_pause.show()
		Engine.time_scale = 0
		
	paused = not paused


func _on_menu_pause_resume():
	_pause_menu()
