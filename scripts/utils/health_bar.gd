@icon("res://assets/icons/tools.svg")
extends Node2D

@export var pos_in_game: Marker2D
@onready var health_bar = %Health

var _boss: BossEenemy
var _status_health_bar: int = 0
var _initial_position: Vector2


func _ready():
	_initial_position = position # set position to hide
	#DANGER: _boss must be the last child
	var target = get_parent().get_child(-1)
	
	if target is BossEenemy:
		_boss = target
		_boss.set_health.connect(_on_set_health_bar)
		_boss.activate_fight.connect(_on_activate_fight)
		_boss.hit.connect(_on_hit)
		_boss.defeated.connect(_hide_health_bar)
	else:
		push_warning('The last component should be _bossenemy')


func _show_health_bar():
	var t = create_tween()
	t.tween_property(self, 'position', pos_in_game.position, 2.0)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)


func _hide_health_bar():
	var t = create_tween()
	t.tween_property(self, 'position', _initial_position, .45)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_IN)


func _on_set_health_bar(val: int):
	_status_health_bar = val
	
	health_bar.max_value = _status_health_bar
	health_bar.value = _status_health_bar


func _on_hit(val: int):
	_status_health_bar -= val
	
	health_bar.value = _status_health_bar
	

func _on_activate_fight():
	_show_health_bar()
