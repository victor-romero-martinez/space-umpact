extends Node2D


@export var next_level: PackedScene
@export var enemy_manager: EnemyManager
@export var menu_pause: MenuPause

@onready var global = Global

var _paused: bool = false

func _ready():
	# level settings
	global.game_data.level = self.name.split('-')[-1].to_int()

	if not global.game_data.level:
		push_error('Make sure the node is named as follows Node-1')
		
	#region Os matcher
	match OS.get_name():
		"Android":
			$Game/Hud. position.x = 75.0
			$Game/HudPosition. position.x = 75.0
		"iOS":
			$Game/Hud. position.x = 75.0
			$Game/HudPosition. position.x = 75.0
		_:
			$Game/Hud. position.x = 0
			$Game/HudPosition. position.x = 0
	#endregion
			
	#region Color schema
	if global.game_data.theme:
		$ColorRect.color = global.game_data.theme[1]
		$ColorRect.visible = true
		$Game.modulate = global.game_data.theme[2]
	#endregion
		
	connect('tree_exited', _on_tree_exited)


func _process(_delta):
	if global.game_data.heart == 0: _lose_scene()
	if Input.is_action_just_pressed('ui_pause'): _on_pause()
	# call after hiding player
	if global.hidden_player: _next_level()


# resets default values ​​for next level
func _restore_global_var():
	global.defeated_boss = false
	global.queue_boss = false
	global.hidden_player = false


func _next_level():
	if next_level:
		global.game_data.level = global.game_data.level + 1
		_restore_global_var()
		global.update_data()
		get_tree().change_scene_to_packed(next_level)
	else:
		#get_tree().call_deferred('change_scene_to_file', 'res://control/credit.tscn')
		get_tree().change_scene_to_file('res://control/credit.tscn')

func _lose_scene():
	global.game_data.heart = global.DEFAULT_SETTINGS.heart
	_restore_global_var()
	get_tree().change_scene_to_file("res://control/dead_menu.tscn")


func _on_pause():
	if _paused:
		enemy_manager.pause_music(false)
		menu_pause.stop_music()
		menu_pause.hide()
		Engine.time_scale = 1
	else:
		enemy_manager.pause_music(true)
		menu_pause.show()
		menu_pause.play_music()
		Engine.time_scale = 0
		
	_paused = not _paused


func _on_tree_exited():
	Engine.time_scale = 1
