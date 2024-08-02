@icon("res://assets/icons/tools.svg")
extends Node2D

@export var pos_in_game: Marker2D
@onready var health_bar = %Health

var boss: BossEenemy
var status_health_bar: int = 0


func _ready():
	var target = get_parent().get_child(-1)
	
	if target is BossEenemy:
		boss = target
		boss.set_health.connect(_on_set_health_bar)
		boss.activate_fight.connect(_on_activate_fight)
		boss.hit.connect(_on_hit)
	else:
		push_warning('The last component should be bossenemy')

func _show_health_bar():
	var t = create_tween()
	t.tween_property(self, 'position', pos_in_game.position, 2.0)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)


func _on_set_health_bar(val: int):
	status_health_bar = val
	
	health_bar.max_value = status_health_bar
	health_bar.value = status_health_bar


func _on_hit(val: int):
	status_health_bar -= val
	
	health_bar.value = status_health_bar
	

func _on_activate_fight():
	_show_health_bar()
