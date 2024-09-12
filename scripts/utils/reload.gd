@icon("res://assets/icons/tools.svg")
extends StaticBody2D
class_name ReloadItem


enum TBullet { rocket, laser_h, laser_v }

@export var bullet_type: TBullet
@export var random_type: bool = false

@onready var global = Global

var _weapon_array: Array

func _ready():
	if random_type:
		var random_idx = randi_range(1, (TBullet.size()))
		_weapon_array = [TBullet.find_key(random_idx - 1), random_idx]
	else:
		_weapon_array = [TBullet.keys()[bullet_type], TBullet.values()[bullet_type] + 1]
		
	%AnimatedSprite.play(_weapon_array[0])


func _on_area_2d_area_entered(area):
	if area is PlayerCollectorItem:
		for w in global.game_data.weapons:
			if w[1] == _weapon_array[1]: return
		
		area.received_item(_weapon_array)
		$PickItemSfx.play()
		$Area2D.set_deferred('monitorable', false)
		visible = false
			

func _on_pick_item_sfx_finished() -> void:
	queue_free()
	
