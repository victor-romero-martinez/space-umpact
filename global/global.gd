extends Node2D

var screen_size: Vector2
var player_health: int = 3

#TODO: implementar animacion de spawn
func _ready():
	screen_size = get_viewport_rect().size



func  player_damage(damege: int = 1):
#INFO: mientras no sea `true` se ejecuta
	if not is_game_over():
		player_health -= damege


func is_game_over() -> bool:
	return player_health == 0
