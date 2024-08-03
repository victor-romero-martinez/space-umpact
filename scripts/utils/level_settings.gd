extends Node2D

@onready var menu_pause = %MenuPause

var global_settings = Global
var paused: bool = false


func _ready():
	global_settings.defeated_boss = false


func _process(_delta):
#TODO: remplazar por game over sscreen
	if global_settings.is_game_over():
		print('estoy en level script')
		get_tree().quit()

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
