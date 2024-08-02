extends Node2D

var global_settings = Global


func _ready():
	global_settings.defeated_boss = false


func _process(_delta):
#TODO: remplazar por game over sscreen
	if global_settings.is_game_over():
		print('estoy en level script')
		get_tree().quit()


