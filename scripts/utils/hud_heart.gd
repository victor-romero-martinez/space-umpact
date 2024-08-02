@icon("res://assets/icons/tools.svg")
extends Node2D
class_name HudHealth

@export var heart_compnent: PackedScene
@export var position_in_game: Marker2D

var global = Global
var _initial_position: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	if heart_compnent and position_in_game:
		_initial_position = position
		for h in global.player_heart:
			var heart = heart_compnent.instantiate()
			heart.position.x = position.x + 8.0 * h
			add_child(heart)
		_show_health()
	else:
		push_error('PackedScene or InitialHealthPosition is missing')
	
	
func _process(_delta):
	if global.defeated_boss:
		_hide_health()
	
	
func _show_health():
	var t = create_tween()
	t.tween_property(self, 'position', position_in_game.position, .45)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
	
	
func _hide_health():
	var t = create_tween()
	t.tween_property(self, 'position', _initial_position, .45)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_IN)


func remove_heart():
	if get_child_count() > 0:
		get_child(-1).queue_free()
