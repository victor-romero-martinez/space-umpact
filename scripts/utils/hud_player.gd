extends Node2D


@export var final_position: Marker2D

@onready var global = Global

var _initial_pos: Vector2

func _ready():
	_initial_pos = position
	_show()


func _process(_delta):
	if global.defeated_boss:
		_hide()
		
		
func _show():
	var t = create_tween()
	t.tween_property(self, 'position', final_position.position, .45)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)
		
		
func _hide():
	var t = create_tween()
	t.tween_property(self, 'position', _initial_pos, .45)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_IN)

	
