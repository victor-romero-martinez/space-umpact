@icon("res://assets/icons/gear.svg")
extends Node2D

const DEFAULT_SETTINGS = {
		'level': 1,
		'heart': 3,
		'theme': null,
		'music': 0,
		'vfx': 0
	}


#region Game Settings
var game_data: Dictionary
## Theme colors
var theme_schema := {
	#index: path_custome_theme, color_rect, sprites_and_tiles, index_namber
	0: ['res://control/theme/pink_theme.tres', '#201d24', '#f63090', 0],
	1: ['res://control/theme/classic_theme.tres', '#74a583', '#201d24', 1],
	2: ['res://control/theme/modern_theme.tres', '#252525', '#e4e4e4', 2]
	}
## User directory
const PATH = 'user://data.json'
## Min value for audio bus control
const MIN_VOL = -10
var screen_size = Vector2(
	ProjectSettings.get_setting('display/window/size/viewport_width'),\
	ProjectSettings.get_setting('display/window/size/viewport_height')
	)
#endregion

#region Status game
var player_arsenal: Array[String] = ['bullet']
var defeated_boss: bool = false
## call after hiding boss
var queue_boss: bool = false
## call after hiding player
var hidden_player: bool = false
#endregion


#TODO: implementar animacion de spawn
func _ready():
	if FileAccess.file_exists(PATH):
		_load_data()
	else:
		_create_data(DEFAULT_SETTINGS)


func _create_data(data):
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, '\t'))
	file.close()


#func update_save_data(level: int = 1, heart: int = 3):
	#game_data.level = level
	#game_data.heart = heart
	#
	#_create_data(game_data)

	
func update_data():
	_create_data(game_data)
	
	
func _load_data():
	var file = FileAccess.open(PATH, FileAccess.READ)
	var res = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(res)
	if error == OK:
		var data = json.data
		game_data = data
	else :
		push_error('Unexpected data')


func game_volumen(name_db: String, value: float):
	var bus_idx = AudioServer.get_bus_index(name_db)
	
	if value > MIN_VOL:
		AudioServer.set_bus_volume_db(bus_idx, value)
	else:
		AudioServer.set_bus_volume_db(bus_idx, -80)


