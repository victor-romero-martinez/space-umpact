@icon("res://assets/icons/tools.svg")
extends Node2D
class_name HudHealth

@export var heart_compnent: PackedScene
@export var position_in_game: Marker2D

var player_heart = Global.player_heart


# Called when the node enters the scene tree for the first time.
func _ready():
	if heart_compnent and position_in_game:
		for h in player_heart:
			var heart = heart_compnent.instantiate()
			heart.position.x = position.x + 8.0 * h
			add_child(heart)
		_show_health()
	else:
		push_error('PackedScene or InitialHealthPosition is missing')
	
	
func _show_health():
	var t = create_tween()
	t.tween_property(self, 'position', position_in_game.position, .45)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_OUT)


func remove_heart():
	if get_child_count() > 0:
		get_child(-1).queue_free()
