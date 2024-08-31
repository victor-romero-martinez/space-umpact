@icon("res://assets/icons/tools.svg")
extends Node2D
class_name HudHealth


@onready var global = Global

var img = load('res://assets/heart.png')


func _ready():
	for h in global.game_data.heart:
		var heart = Sprite2D.new()
		heart.texture = img
		heart.position.x = position.x + 10.0 * h
		heart.scale = Vector2(1.5, 1.5)
		add_child(heart)
	

func _remove_heart():
	if get_child_count() > 0:
		get_child(-1).queue_free()


func _on_player_hit():
	global.game_data.heart -= 1
	_remove_heart()
