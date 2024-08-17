extends Node2D

@onready var menu_pause = %MenuPause
@onready var global = Global

var _paused: bool = false

func _ready():
	# level settings
	global.game_data.level = self.name.split('-')[-1].to_int()

	if not global.game_data.level:
		push_error('Make sure the node is named as follows Node-1')
		
	connect('tree_exited', _on_tree_exited)


func _process(_delta):
	if global.game_data.heart == 0: _lose_scene()
	if Input.is_action_just_pressed('ui_pause'): _pause_menu()
	# call after hiding player
	if global.hidden_player: _next_level()


# resets default values ​​for next level
func _restore_global_var():
	global.defeated_boss = false
	global.queue_boss = false
	global.hidden_player = false


func _next_level():
	_restore_global_var()
	var next_value = global.game_data.level + 1
	var next_level = 'res://scenes/level_%d.tscn' %next_value
	
	if FileAccess.file_exists(next_level):
		global.update_save_data(next_value)
		get_tree().change_scene_to_file(next_level)
	else:
		get_tree().change_scene_to_file('res://control/credit.tscn')


func _lose_scene():
	global.game_data.heart = global.DEFAULT_SETTINGS.heart
	_restore_global_var()
	get_tree().change_scene_to_file("res://control/dead_menu.tscn")


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


func _on_tree_exited():
	Engine.time_scale = 1

