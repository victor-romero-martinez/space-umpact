@icon("res://assets/icons/round-test-tube.svg")
extends Node2D


@onready var menu_pause = $MenuPause


var global = Global
var paused: bool = false


func _ready():
	# set color shema
	if global.game_data.theme:
		$ColorRect.color = global.game_data.theme[1]
		$Game.modulate = global.game_data.theme[2]


func _process(_delta):
	if Input.is_action_just_pressed('ui_pause'):
		_pause_menu()
		
	if global.hidden_player:
		close_room()

 
func close_room():
	print_rich("[color=green][b]Finished test![/b][/color]")
	get_tree().quit()

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
