@icon("res://assets/icons/gear.svg")
extends Node2D

var default_settings := {
		'level': 1,
		'heart': 3
	}

var screen_size: Vector2
var current_level: int = 1
var player_heart: int = 3

var defeated_boss: bool = false
## call after hiding boss
var queue_boss: bool = false
## call after hiding player
var hidden_player: bool = false


#TODO: implementar animacion de spawn
func _ready():
	screen_size = get_viewport_rect().size
	var path = 'user://data.json'

	if FileAccess.file_exists(path):
		_load_data(path)
	else:
		_create_data(path, default_settings)

func take_damage():
	if player_heart > 0:
		player_heart -= 1
	

func is_game_over() -> bool:
	return player_heart == 0


func _create_data(path: String, data):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data, '\t'))
	file.close()


func update_save_data(level: int, heart: int = 3):
	current_level = level
	player_heart = heart
	var temp = {
		'level': level,
		'heart': heart
		}
	
	_create_data('user://data.json', temp)


func _load_data(path: String):
	var file = FileAccess.open(path, FileAccess.READ)
	var res = file.get_as_text()
	var json = JSON.new()
	var error = json.parse(res)
	if error == OK:
		var data = json.data
		current_level = data.level
		player_heart = data.heart
	else :
		push_error('Unexpected data')

