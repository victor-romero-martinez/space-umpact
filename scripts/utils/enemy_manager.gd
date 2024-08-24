@icon("res://assets/icons/gear.svg")
extends Node2D
## Control of enemy chunk
class_name EnemyManager


## List of music to play
@export var game_music: Array[AudioStreamPlayer]
@export_group('enemies_collections List')
## Velocity of chunk
@export var speed: float = 30.0
## List of enemy pack
@export var enemies_chunk: Array[PackedScene] = []
## Boss scene fight
@export var boss_chunk:PackedScene


var _screen_width: float
var _chunk_counter: int = 0
var _current_chunk: int = 0
var _current_music:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_screen_width = Global.screen_size.x
	game_music[_current_music].play()
	
	#region enemies chunk check
	if enemies_chunk.is_empty():
		push_error('Enemy chunk scene is missing')
	else:
		_chunk_counter = enemies_chunk.size()
	#endregion
	
	_make_enemy_chunk(_current_chunk)

	
func _decrement_chunk():
	_chunk_counter -= 1
	
	if _chunk_counter == 0:
		_trans_music()
		_make_boos_chunk()
	

func _next_chunk():
	if _current_chunk < enemies_chunk.size():
		call_deferred("_make_enemy_chunk", _current_chunk)


func _make_enemy_chunk(idx: int):
	var chunk = enemies_chunk[idx].instantiate() as ChunkEnemy
	chunk.position.x = _screen_width
	chunk.tree_exiting.connect(_decrement_chunk)
	chunk.next_chunk.connect(_next_chunk)
		
	add_child(chunk)
	_current_chunk += 1


func _make_boos_chunk():
	if not boss_chunk:
		push_error('Boss chunk scene is missing')
	else:
		var boss_c = boss_chunk.instantiate()
		boss_c.position = position
		boss_c.boss.defeated.connect(_stop_boss_music) #NOTICE
		add_child.call_deferred(boss_c)
	
## Pause or resume current music
func pause_music(val: bool):
	game_music[_current_music].stream_paused = val
	
	
func _change_music():
	game_music[_current_music].stop()
	_current_music += 1
	game_music[_current_music].play()
	
			 
func _trans_music():
	var t = create_tween()
	t.set_trans(Tween.TRANS_QUAD)
	t.tween_property(game_music[_current_music], "volume_db", -60, 2.0)
	t.tween_callback(_change_music)
	

func _stop_boss_music():
	var t_b = create_tween()
	t_b.set_trans(Tween.TRANS_QUAD)
	t_b.tween_property(game_music[-1], "volume_db", -60, 4.0)
