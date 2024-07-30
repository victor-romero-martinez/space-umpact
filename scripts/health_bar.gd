@icon("res://assets/icons/tools.svg")
extends Node2D

@export var pos_in_game: Marker2D
@onready var health = $Health

var status_health: int = 0


func _show_healthbar():
	var t = create_tween()
	t.tween_property(self, 'position', pos_in_game.position, 1.0)\
		.set_trans(Tween.TRANS_EXPO)\
		.set_ease(Tween.EASE_OUT)


func _on_boss_1_set_health(val: int):
	status_health = val
	
	health.max_value = status_health
	health.value = status_health


func _on_boss_1_hit(val: int):
	status_health -= val
	
	health.value = status_health
	


func _on_boss_1_activate_fight():
	_show_healthbar()
