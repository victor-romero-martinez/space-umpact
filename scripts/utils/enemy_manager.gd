@icon("res://assets/icons/gear.svg")
extends Node2D


@export_group('enemies_collections List')
@export var enemies_chunk: Array[PackedScene] = []
@export var boss_chunk:PackedScene


var _screen_width: float
var _add_boss: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_screen_width = Global.screen_size.x
	_make_enemy_chunk()


func _process(_delta):
	if not _add_boss: _append_boss()
	

func _make_enemy_chunk():
	if enemies_chunk.size() == 0:
		push_error('Enemy chunk scene is missing')
	else:
		for i in enemies_chunk.size():
			var chunk = enemies_chunk[i].instantiate()
			chunk.position.x = _screen_width * (i + 1)
			add_child(chunk)


func _make_boos_chunk():
	if not boss_chunk:
		push_error('Boss chunk scene is missing')
	else:
		var boss = boss_chunk.instantiate()
		boss.position = position
		add_child(boss)
			 

func _append_boss():
	if get_child_count() == 0:
		_make_boos_chunk()
		_add_boss = true
	
