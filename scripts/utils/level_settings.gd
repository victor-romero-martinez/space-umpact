extends Node2D

@onready var menu_pause = %MenuPause

var global = Global
var _paused: bool = false

func _ready():
	# level settings
	global.current_level = self.name.split('-')[-1].to_int()

	if not global.current_level:
		push_error('Make sure the node is named as follows Node-1')


func _process(_delta):
#TODO: remplazar por game over sscreen
	if global.is_game_over():
		print('estoy en level script')
		get_tree().quit()

	if Input.is_action_just_pressed('ui_pause'):
		_pause_menu()
			
	# call after hiding player
	if global.hidden_player: _next_level()


# resets default values ​​for next level
func _restore_global_var():
	global.defeated_boss = false
	global.queue_boss = false
	global.hidden_player = false


func _next_level():
	_restore_global_var()
	var next_level = 'res://scenes/level_%d.tscn' %(global.current_level + 1)
	
	if FileAccess.file_exists(next_level):
		get_tree().change_scene_to_file(next_level)
	else:
		print_debug('TODO: poner creditos aqui')
		get_tree().change_scene_to_file("res://control/main_menu.tscn")


func _pause_menu():
	if _paused:
		menu_pause.hide()
		Engine.time_scale = 1
	else:
		menu_pause.show()
		Engine.time_scale = 0
		
	_paused = not _paused


func _on_menu_pause_resume():
	_pause_menu()
