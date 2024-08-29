@icon("res://assets/icons/gear.svg")
extends Node2D
## [color=GREEN]Control of enemy chunk[/color]
class_name EnemyManager



@export_group('enemies_collections List')
## Velocity of chunk
@export var speed: float = 30.0
## List of enemy pack
@export var enemies_chunk: Array[PackedScene] = []
## Boss scene fight
@export var boss_chunk:PackedScene


@onready var music: AudioStreamPlaybackInteractive = $AudioStreamPlayer2D.get_stream_playback()


var _screen_width: float
var _chunk_counter: int = 0
var _current_chunk: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_screen_width = Global.screen_size.x
	
	#region enemies chunk check
	if enemies_chunk.is_empty():
		push_error('Enemy chunk scene is missing')
	else:
		_chunk_counter = enemies_chunk.size()
		_make_enemy_chunk(_current_chunk)
	#endregion
	
	
func _decrement_chunk():
	_chunk_counter -= 1
	
	if _chunk_counter == 0:
		_make_boss_chunk()
	

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


func _make_boss_chunk():
	if not boss_chunk:
		push_error('Boss chunk scene is missing')
	else:
		var boss_c = boss_chunk.instantiate()
		boss_c.position = position
		boss_c.boss.defeated.connect(_stop_boss_music)
		add_child.call_deferred(boss_c)
		_change_music()
	
	
## Pause or resume current music
func pause_music(val: bool):
	$AudioStreamPlayer2D.stream_paused = val
	
	
func _change_music():
	music.switch_to_clip_by_name(&'boss')
	
	
func _stop_boss_music():
	var t = create_tween()
	t.tween_property($AudioStreamPlayer2D, "volume_db", -60.0, 4.0)\
		.set_trans(Tween.TRANS_LINEAR)\
		.set_ease(Tween.EASE_IN)
	t.tween_callback(func (): $AudioStreamPlayer2D.playing = false)
	
