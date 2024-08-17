@icon("res://assets/icons/gear.svg")
extends Node2D

const DEFAULT_SETTINGS := {
		'level': 1,
		'heart': 3,
		'theme': null
	}

var screen_size: Vector2

var game_data: Dictionary
var player_arsenal: Array[String] = ['bullet']

var defeated_boss: bool = false
## call after hiding boss
var queue_boss: bool = false
## call after hiding player
var hidden_player: bool = false


## Theme colors
var theme_schema := {
	#index: path_custome_theme, color_rect, sprites_and_tiles, index_namber
	0: ['res://control/theme/pink_theme.tres', '#201d24', '#f63090', 0],
	1: ['res://control/theme/classic_theme.tres', '#74a583', '#201d24', 1],
	2: ['res://control/theme/modern_theme.tres', '#252525', '#e4e4e4', 2]
	}
## User directory
var path: String

#TODO: implementar animacion de spawn
func _ready():
	screen_size = get_viewport_rect().size
	path = 'user://data.json'

	if FileAccess.file_exists(path):
		_load_data()
	else:
		_create_data(DEFAULT_SETTINGS)


func _create_data(data):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, '\t'))
	file.close()


func update_save_data(level: int = 1, heart: int = 3):
	game_data.level = level
	game_data.heart = heart
	
	_create_data(game_data)


func update_theme(new_theme: Array):
	game_data.theme = new_theme
	
	_create_data(game_data)
	

func _load_data():
	var file = FileAccess.open(path, FileAccess.READ)
	var res = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(res)
	if error == OK:
		var data = json.data
		game_data = data
	else :
		push_error('Unexpected data')

