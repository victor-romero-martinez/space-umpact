@icon("res://assets/icons/tools.svg")
extends Node2D
class_name HudHealth


@onready var global = Global

var _img = load('res://assets/heart.png')
var _outline_shader = load("res://scenes/utilities/outline.gdshader")


func _ready():
	for h in global.game_data.heart:
		var heart = Sprite2D.new()
		heart.texture = _img
		heart.position.x = position.x + 10.0 * h
		heart.scale = Vector2(1.5, 1.5)
		
		var new_material = ShaderMaterial.new()
		new_material.shader = _outline_shader
		new_material.set_shader_parameter(
			'outline_color', Color(global.game_data.theme[1])
		)
		new_material.set_shader_parameter(
			'sprite_tint', Color(global.game_data.theme[2])
		)
		
		heart.material = new_material
		
		add_child(heart)
	

func _remove_heart():
	if get_child_count() > 0:
		get_child(-1).queue_free()


func _on_player_hit():
	global.game_data.heart -= 1
	_remove_heart()
