@icon("res://assets/icons/tools.svg")
extends Node2D
## Shows the arsenal collected by the player
class_name HudGun

enum TBullet { bullet, rocket, laser_h, laser_v }

@onready var global = Global

var _img = load('res://assets/gun_select.png')
# position between items
var _next_position_x: float = 0

func _ready():
	for w in global.player_arsenal:
		var sprite = _make_sprite(Vector2(1, 0), _next_position_x)
		add_child(sprite)
		_next_position_x += 12


func _make_sprite(frames: Vector2, pos_x: float) -> Sprite2D:
	var sprite = Sprite2D.new()
	sprite.texture = _img
	sprite.hframes = 2
	sprite.vframes = 4
	#sprite.frame = 2
	sprite.frame_coords = frames # x, y
	sprite.position.x = pos_x
	sprite.scale = Vector2(1.5, 1.5)
	
	return sprite
	

func _on_player_add_weapon(val):
	var temp = TBullet.get(val)
	
	var child = _make_sprite(Vector2(0, temp), _next_position_x)
	add_child(child)
	_next_position_x += 12


func _on_player_current_weapon(idx: int):
	var child_prev = get_child(idx - 1) as Sprite2D
	child_prev.frame_coords.x = 0
	
	var child_curr = get_child(idx) as Sprite2D
	child_curr.frame_coords.x = 1


func _on_player_remove_weapon(val: int):
	global.player_arsenal.erase(TBullet.find_key(val))
	_next_position_x -= 12
	var child = get_child(val)
	child.queue_free()
