@icon("res://assets/icons/tools.svg")
extends Node2D
## Shows the arsenal collected by the player
class_name HudGun


@onready var global = Global


var _outline_shader = load("res://scenes/utilities/outline.gdshader")
var _img = load('res://assets/gun_select.png')
# position between items
var _next_position_x: float = 0


func _ready():
	for i in global.game_data.weapons.size():
		var sprite = _make_sprite(Vector2(1, global.game_data.weapons[i][1]), _next_position_x)
		var new_material = ShaderMaterial.new()
		
		new_material.shader = _outline_shader
		new_material.set_shader_parameter(
			'outline_color', Color(global.game_data.theme[1])
		)
		new_material.set_shader_parameter(
			'sprite_tint', Color(global.game_data.theme[2])
		)
		
		sprite.material = new_material

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
	

func _on_player_add_weapon(val: int):
	var child = _make_sprite(Vector2(0, val), _next_position_x)
	var new_material = ShaderMaterial.new()
	
	new_material.shader = _outline_shader
	new_material.set_shader_parameter(
		'outline_color', Color(global.game_data.theme[1])
	)
	new_material.set_shader_parameter(
		'sprite_tint', Color(global.game_data.theme[2])
	)
	
	child.material = new_material
	child.modulate = Color(global.game_data.theme[2])
	add_child(child)
	_next_position_x += 12


func _on_player_current_weapon(idx: int):
	if not get_children().is_empty():
		var child_prev = get_child(idx - 1) as Sprite2D
		child_prev.frame_coords.x = 0
		
		var child_curr = get_child(idx) as Sprite2D
		child_curr.frame_coords.x = 1


func _on_player_remove_weapon(val: int):
	var child = get_child(val)
	child.queue_free()
	
	_next_position_x -= 12.0
	# still includes the deleted node
	var children = get_children()
	
	# val -> base 0, children.size -> base 1
	if (val + 1) == children.size(): return
	
	# i -> base 0, children.size -> base 1
	for i in children.size(): # [0, 1, 2, 3]
		if i <= val: continue
		
		children[i].position.x -= 12
	
