extends Node2D

var screen_size: Vector2
var player_heart:int = 3


#TODO: implementar animacion de spawn
func _ready():
	screen_size = get_viewport_rect().size


func take_damage():
	if player_heart > 0:
		player_heart -= 1


func is_game_over() -> bool:
	return player_heart == 0
