extends Node2D

var global_settings= Global


func _process(_delta):
#TODO: remplazar por game over sscreen
	if global_settings.is_game_over():
		get_tree().quit()


